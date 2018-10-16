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
	by dcvr.yhbt.net (Postfix) with ESMTP id A14A91F453
	for <e@80x24.org>; Tue, 16 Oct 2018 09:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeJPRdZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 13:33:25 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34247 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeJPRdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 13:33:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id w19-v6so20652189eds.1
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 02:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8unzj+mdwRbYvNn/tPi4jnkFuIcvd+hBJamYU1GqGbs=;
        b=WJP+cNYgyVCLEmGZ+0mxRgXHOXsos4fSxlsykH6KGeGm7RpUCn6Nn7nOYEmhPAssa/
         BFZEP9/FJXwOJoiA9gQewHM2zvJ2DkmG1cYBC5FAzO39w2WUDQDlJZDl8RVlGw6B8Jil
         ltCOY5LEpxXmjSNOsX1LgSqAMUbGtsk9anEH1/DEqkWM3ywrJyauxPBz+mWYWwPYAmIE
         h5bNys0bdosqP1OlbbLAA1bod2Xq2lZp6TDpL592TH+9UeGA3mgd/D/9394caFkYDMmP
         QMCcxy/OAh4LWKKqASLyAs1oV+LK1BSb79dC1pG/NgIGbkMlRpn7tBoHyNsWuSPhqGQO
         0EOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8unzj+mdwRbYvNn/tPi4jnkFuIcvd+hBJamYU1GqGbs=;
        b=mEdSV+4yBxZBwbQvdrI8ek/OQbmf66MlZiC6ihjMCAp1NxMiDVCXuSF/+spiqHKMVG
         e/49ohtK7xqLJTPVdyG6bUyI90HLKNehhVHy555E258vONqDRZ/9sxcyLK7oC2Y+lkZU
         tga71F5B2FHFKvGr1xESswpvfsstc53VCOZmWk0JEOhpq1ZmC8+iTIY5sOq2x+7TnBkO
         Jpvj7M9/ejZiGf7xqO9cFdNBFHlnYANDdS7R3cgAQEnUKLz+t4rmSijNc3JNOvg5RVot
         OfftpwhFTjBGMHIYUshNMgoO0K5zxO6HOjQzTw++gQtyyUWx6iG0UEGjv7P7TTb7jjtv
         FXkA==
X-Gm-Message-State: ABuFfohVPyxpPO/V+dO5MHi2+aFNzx4NgJVHHr4AyIITG7Howgvoz7A5
        xmcZ2yX3cdNGb8qrmoK1lOYOVEZc
X-Google-Smtp-Source: ACcGV60yPG3dT6AUFTrzSQvCar28vdhxKVOHts4YQEUn8ZnCAZDkVdi2wGyLdw4YnKPLRLFhmPj8RA==
X-Received: by 2002:a17:906:b30d:: with SMTP id n13-v6mr22898936ejz.34.1539683028500;
        Tue, 16 Oct 2018 02:43:48 -0700 (PDT)
Received: from szeder.dev (x4d0caaf1.dyn.telefonica.de. [77.12.170.241])
        by smtp.gmail.com with ESMTPSA id n6-v6sm2758593ejh.2.2018.10.16.02.43.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 02:43:47 -0700 (PDT)
Date:   Tue, 16 Oct 2018 11:43:44 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 05/13] ci/lib.sh: add support for Azure Pipelines
Message-ID: <20181016094344.GJ19800@szeder.dev>
References: <pull.31.git.gitgitgadget@gmail.com>
 <pull.31.v2.git.gitgitgadget@gmail.com>
 <486d1d25183fc7b0de599a0791ed41a87cc176cb.1539598316.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <486d1d25183fc7b0de599a0791ed41a87cc176cb.1539598316.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 03:12:05AM -0700, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> This patch introduces a conditional arm that defines some environment
> variables and a function that displays the URL given the job id (to
> identify previous runs for known-good trees).
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  ci/lib.sh | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 8532555b4e..584abcd529 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -19,6 +19,29 @@ then
>  	BREW_INSTALL_PACKAGES="git-lfs gettext"

So we install these two additional packages in the macOS build jobs on
Travis CI ...

>  	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
>  	export GIT_TEST_OPTS="--verbose-log -x --immediate"
> +elif test -n "$SYSTEM_TASKDEFINITIONSURI"
> +then
> +	# We are running in Azure Pipelines
> +	CI_BRANCH="$BUILD_SOURCEBRANCH"
> +	CI_COMMIT="$BUILD_SOURCEVERSION"
> +	CI_JOB_ID="$BUILD_BUILDID"
> +	CI_JOB_NUMBER="$BUILD_BUILDNUMBER"
> +	CI_OS_NAME="$(echo "$AGENT_OS" | tr A-Z a-z)"
> +	test darwin != "$CI_OS_NAME" || CI_OS_NAME=osx
> +	CI_REPO_SLUG="$(expr "$BUILD_REPOSITORY_URI" : '.*/\([^/]*/[^/]*\)$')"
> +	CC="${CC:-gcc}"
> +
> +	# use a subdirectory of the cache dir (because the file share is shared
> +	# among *all* phases)
> +	cache_dir="$HOME/test-cache/$SYSTEM_PHASENAME"
> +
> +	url_for_job_id () {
> +		echo "$SYSTEM_TASKDEFINITIONSURI$SYSTEM_TEAMPROJECT/_build/results?buildId=$1"
> +	}
> +
> +	BREW_INSTALL_PACKAGES=

... but not on Azure Pipelines.  Is this mere oversight or
intentional?  If it's intentional, then I think the commit message
should mention why.

> +	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
> +	export GIT_TEST_OPTS="--quiet --write-junit-xml"
>  fi
>  
>  skip_branch_tip_with_tag () {
> -- 
> gitgitgadget
> 
