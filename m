Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECB181F457
	for <e@80x24.org>; Thu, 18 Oct 2018 22:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbeJSGEN (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 02:04:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38938 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725738AbeJSGEN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 02:04:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id d15-v6so29663772edq.6
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 15:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=soZk3ACjaFXelRpIQ9BndeZK3gIyb5BaRyUT+cW+qnY=;
        b=HfTMbDu62LnR/vbqgULgaX0edtFlCK4xROr7QZ0W3Zxh7fLzkp16QJeVww+qPepMZy
         tfW5nCHMMRs5tkIWEw3RJzytPOBQx5LGtlfNe27uWTAqUlzfb2TIWUGJsG7k5GX+dCV+
         5w9XgDw+GqnnjxAwretmNUshRGSGHtmntvZAmmRhhacTxp5ej7uMQCkNRChjhuDMReB8
         piLzY7fDMRXgeCggcW8j824Az8Z7ybJKsKT4elTuinC97j1qVEwky4rr+tz0TEDW98jF
         gDhhv1Xqc0Ns2R4HEeKYpT+GiuPrZMzKaUFhEP0g+qjEH9Soe0JVYWWlmWOTzDCaigb/
         YhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=soZk3ACjaFXelRpIQ9BndeZK3gIyb5BaRyUT+cW+qnY=;
        b=iCrPAyQcH8G8A3jmTQq008aTZ2EYWiTQxGZdiKry47x59XuYVtsQ1KjpXd7eP13n1+
         BtUOaHXelfD2sp52pOq0XiXDqsFTTgClQiIWejtjpXFQrvRpsMATrC8DwsM+/QQbH6So
         25JPYWtjYkRwAe/Lu+fXCktzqjw0JaZsnez0kx1M7xIRC0EDWiQRTSgbLGmKlCmAeg3e
         fSNKfWeiCUC2yVh7AoU+NgS94JRpeYNI77WpgpCW/v0Dn55hLDjStRiuNf8J0WnuBpsz
         r4l4rids96OfYwEDjwmlza8K5AgmcgdMJbuIrOktsArf7YjGMcVQvUZXi/Z9sk6Ykn/h
         DL/A==
X-Gm-Message-State: ABuFfogk8y9vFykZwKBWIAuPMqX7RhPXQewy18ECwYFVho4wqmOyk5d1
        xq1qL7juRJZ74zU3vLPjEJM=
X-Google-Smtp-Source: ACcGV60t9H1OFC0gR//MMn53My1gEMbizkw1FDSTQDMcyRs2TR04NNr0WgnwRgXtmA4IjbSvpDngdQ==
X-Received: by 2002:aa7:c704:: with SMTP id i4-v6mr4454640edq.253.1539900070208;
        Thu, 18 Oct 2018 15:01:10 -0700 (PDT)
Received: from szeder.dev (x4d0c676f.dyn.telefonica.de. [77.12.103.111])
        by smtp.gmail.com with ESMTPSA id h17-v6sm10225037edh.77.2018.10.18.15.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 15:01:09 -0700 (PDT)
Date:   Fri, 19 Oct 2018 00:01:06 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 02/13] ci/lib.sh: encapsulate Travis-specific things
Message-ID: <20181018220106.GU19800@szeder.dev>
References: <pull.31.git.gitgitgadget@gmail.com>
 <pull.31.v2.git.gitgitgadget@gmail.com>
 <815152e0f57d545ae2fae7429c16e5be497746be.1539598316.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <815152e0f57d545ae2fae7429c16e5be497746be.1539598316.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 03:12:00AM -0700, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 06970f7213..8532555b4e 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -1,5 +1,26 @@
>  # Library of functions shared by all CI scripts
>  
> +if test true = "$TRAVIS"
> +then
> +	# We are running within Travis CI
> +	CI_BRANCH="$TRAVIS_BRANCH"
> +	CI_COMMIT="$TRAVIS_COMMIT"
> +	CI_JOB_ID="$TRAVIS_JOB_ID"
> +	CI_JOB_NUMBER="$TRAVIS_JOB_NUMBER"
> +	CI_OS_NAME="$TRAVIS_OS_NAME"
> +	CI_REPO_SLUG="$TRAVIS_REPO_SLUG"
> +
> +	cache_dir="$HOME/travis-cache"
> +
> +	url_for_job_id () {
> +		echo "https://travis-ci.org/$CI_REPO_SLUG/jobs/$1"
> +	}
> +
> +	BREW_INSTALL_PACKAGES="git-lfs gettext"
> +	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
> +	export GIT_TEST_OPTS="--verbose-log -x --immediate"
> +fi

Please set all these variables ...

> +
>  skip_branch_tip_with_tag () {
>  	# Sometimes, a branch is pushed at the same time the tag that points
>  	# at the same commit as the tip of the branch is pushed, and building
> @@ -13,10 +34,10 @@ skip_branch_tip_with_tag () {
>  	# we can skip the build because we won't be skipping a build
>  	# of a tag.
>  
> -	if TAG=$(git describe --exact-match "$TRAVIS_BRANCH" 2>/dev/null) &&
> -		test "$TAG" != "$TRAVIS_BRANCH"
> +	if TAG=$(git describe --exact-match "$CI_BRANCH" 2>/dev/null) &&
> +		test "$TAG" != "$CI_BRANCH"
>  	then
> -		echo "$(tput setaf 2)Tip of $TRAVIS_BRANCH is exactly at $TAG$(tput sgr0)"
> +		echo "$(tput setaf 2)Tip of $CI_BRANCH is exactly at $TAG$(tput sgr0)"
>  		exit 0
>  	fi
>  }
> @@ -25,7 +46,7 @@ skip_branch_tip_with_tag () {
>  # job if we encounter the same tree again and can provide a useful info
>  # message.
>  save_good_tree () {
> -	echo "$(git rev-parse $TRAVIS_COMMIT^{tree}) $TRAVIS_COMMIT $TRAVIS_JOB_NUMBER $TRAVIS_JOB_ID" >>"$good_trees_file"
> +	echo "$(git rev-parse $CI_COMMIT^{tree}) $CI_COMMIT $CI_JOB_NUMBER $CI_JOB_ID" >>"$good_trees_file"
>  	# limit the file size
>  	tail -1000 "$good_trees_file" >"$good_trees_file".tmp
>  	mv "$good_trees_file".tmp "$good_trees_file"
> @@ -35,7 +56,7 @@ save_good_tree () {
>  # successfully before (e.g. because the branch got rebased, changing only
>  # the commit messages).
>  skip_good_tree () {
> -	if ! good_tree_info="$(grep "^$(git rev-parse $TRAVIS_COMMIT^{tree}) " "$good_trees_file")"
> +	if ! good_tree_info="$(grep "^$(git rev-parse $CI_COMMIT^{tree}) " "$good_trees_file")"
>  	then
>  		# Haven't seen this tree yet, or no cached good trees file yet.
>  		# Continue the build job.
> @@ -45,18 +66,18 @@ skip_good_tree () {
>  	echo "$good_tree_info" | {
>  		read tree prev_good_commit prev_good_job_number prev_good_job_id
>  
> -		if test "$TRAVIS_JOB_ID" = "$prev_good_job_id"
> +		if test "$CI_JOB_ID" = "$prev_good_job_id"
>  		then
>  			cat <<-EOF
> -			$(tput setaf 2)Skipping build job for commit $TRAVIS_COMMIT.$(tput sgr0)
> +			$(tput setaf 2)Skipping build job for commit $CI_COMMIT.$(tput sgr0)
>  			This commit has already been built and tested successfully by this build job.
>  			To force a re-build delete the branch's cache and then hit 'Restart job'.
>  			EOF
>  		else
>  			cat <<-EOF
> -			$(tput setaf 2)Skipping build job for commit $TRAVIS_COMMIT.$(tput sgr0)
> +			$(tput setaf 2)Skipping build job for commit $CI_COMMIT.$(tput sgr0)
>  			This commit's tree has already been built and tested successfully in build job $prev_good_job_number for commit $prev_good_commit.
> -			The log of that build job is available at https://travis-ci.org/$TRAVIS_REPO_SLUG/jobs/$prev_good_job_id
> +			The log of that build job is available at $(url_for_job_id $prev_good_job_id)
>  			To force a re-build delete the branch's cache and then hit 'Restart job'.
>  			EOF
>  		fi
> @@ -81,7 +102,6 @@ check_unignored_build_artifacts ()
>  # and installing dependencies.
>  set -ex

... after we turn on 'set -x', so the variables' values will be
visible in the logs.

(Or move this 'set -ex' to the beginning of the script?  Then we
could perhaps avoid similar issues in the future.)

> -cache_dir="$HOME/travis-cache"
>  good_trees_file="$cache_dir/good-trees"
>  
>  mkdir -p "$cache_dir"
