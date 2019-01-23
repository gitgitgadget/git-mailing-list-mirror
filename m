Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECFD01F453
	for <e@80x24.org>; Wed, 23 Jan 2019 23:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfAWXjO (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 18:39:14 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37066 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfAWXjN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 18:39:13 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so4510651wrt.4
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 15:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=HqUkOFSOjKELKIa5tnGYTo+D/UtzBSTwNxH103kdrvw=;
        b=JTAX4R4BQURzWrocHZ1ta557p77jrG8fJO4tEntcjXEo7DkRja0F1Q6+xaS0V5O8QS
         jmjhdZUEkL9W112gO3oZ9shyC01PmF+5F0hcoRsk6hSRmI1rBoeXKaNyKG3ZZLsZqfEl
         7WweSbpuZJjMKO16ctO7/wpgmQ62fpPWe9iWcxmCDzwhgtHiwY2ZQnoaFdESvMjZJbiX
         hPNOWPrnc3lvw7Y3cOBziYy8YPxX+5/MNLe6yYzhHsij00xL0Mt5HBcxOXd8uOLjLTWj
         w/bCiFQR+4mBmuVKXhkXRuTJiwI6+vz9JhvMFmETYb66Dd118MxaKcazzekzotugyR/4
         u0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=HqUkOFSOjKELKIa5tnGYTo+D/UtzBSTwNxH103kdrvw=;
        b=B+Mf26g+ZQxEsURNBOZBmENQAMOAtLgetUqJoY/RCd+foQpADPlzpo19uMIAgzgstb
         liQc/icMjVxM1Vrmi0zkZ6Y17jBti27cfcuyTK9iSqsdUOd7JXYQaY1BOv7d8GhxPDiu
         Fjp5ahCrsF6x+TS+8VYu/XLHhxi47O9oOfW67I9UjNBFamhzxJJGdUC9MpXanJTDKHy5
         80br2WZIbF2a/nkAz8fDp4nhGjn8Mh2Z6urGtzATrWd+osPzeWH++pL+yq4T38sXC6J4
         XAXMtqERPIRyk2x/rP4vvXDD/hZS5S2f/rRvF7P/qML5LVU+Ts7TUztKV78Qmutc9IaF
         bb/A==
X-Gm-Message-State: AJcUukdeXG2PmVkWByxFX3FWJ203MZkzN1tkkNxOHeRRPNVlPxjw6XoW
        dCCZd/D319mgsUOC7hGWSCg=
X-Google-Smtp-Source: ALg8bN7JpKUQ99BF4B0yF0FNNUkYgDv8255mKjP2RyaXzl3utdV/qKnZaIwBu7/ZX5anQbKTWJYi5g==
X-Received: by 2002:adf:bb44:: with SMTP id x4mr4918117wrg.24.1548286751343;
        Wed, 23 Jan 2019 15:39:11 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u204sm93502121wmu.30.2019.01.23.15.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 15:39:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 08/21] ci/lib.sh: add support for Azure Pipelines
Date:   Wed, 23 Jan 2019 14:40:08 -0800
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
        <178dc9b789caef8e2402ab518bb5ca36da2c32ad.1548254412.git.gitgitgadget@gmail.com>
Message-ID: <xmqqimyf54gx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This patch introduces a conditional arm that defines some environment
> variables and a function that displays the URL given the job id (to
> identify previous runs for known-good trees).
>
> For example, we do not have to install the git-lfs and gettext packages
> on Azure Pipelines' macOS agents: they are already installed, and trying
> to install them again would result in an error.

The rationale in the second paragraph is shared with the earlier one
that introduced BREW_INSTALL_PACKAGES variable in the first place.
It would have made more sense if it was explained there (i.e. say
"in environments other than Travis, some packages may be pre
installed and asking to install them again may cause failure, so
make it configurable what to install")---that way, the explanation
in this step's log message can just say "Because Azure pipeline's
macOS agents already have git-lfs and gettext installed, unlike
Travis, we can leave BREW_INSTALL_PACKAGES empty".

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  ci/lib.sh | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 4456dbbcb0..a9eb4f4eae 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -20,6 +20,29 @@ then
>  	BREW_INSTALL_PACKAGES="git-lfs gettext"
>  	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
>  	export GIT_TEST_OPTS="--verbose-log -x --immediate"
> +elif test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
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
> +	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
> +	export GIT_TEST_OPTS="--quiet --write-junit-xml"
>  fi
>  
>  skip_branch_tip_with_tag () {
