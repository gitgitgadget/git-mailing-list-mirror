Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BFA41F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 18:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfJGSvt (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 14:51:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37558 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfJGSvt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 14:51:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id p14so15613857wro.4
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 11:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g/pY2NgN39pPFwD/6Nf9wN46NseW7HTI5aNoTZ5dbT4=;
        b=FMKxAOCyPV6shJROxrjVpfnnRLwP79L/9Eluqu6474hFp+0lKdOEvKT5/RBEvxqiK/
         ZYaT+fpL9sDoMr+grl+FAM/jR1AePO8WySjvpq5+D/j0rg3IwTzqNXzTQJCAI7irr/7+
         KkDo4fKjVi2Nb+L5AXReMj1QptbShftEeAZY7IL2WAl4BwiJh/oRVAuI5hVPj18y/pEZ
         b9ohgx7Y/jOS93aGyvQdoyOYKxtO3NyunsQ+r8/4+b+2kR417e1aNpApIJy9aa1OKDBC
         glb5PCJ35rjOGtyLNGrdL4zKlzx/+3TDvOy7ncmQy7UjPovoj4S2cBc3D4Mx+DI7baWn
         GRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g/pY2NgN39pPFwD/6Nf9wN46NseW7HTI5aNoTZ5dbT4=;
        b=fpwAIADRKVbXcftYrOl6Cya3Y1XqYmPtZnu3HKb1EOF6+MK++dN7mGFmH6SvJ6PM4Y
         8RCX99uIhXad/6gysx2C2QQj3qTj1MSRe9bWfAsnhYDMYw3QpBSJyoMMsbnxSL6hae6B
         LD+mdV5l4qodTRWhNvXsgynTNy8VDHSDuNg6IMjQJiapzna87wAVYU/+8cTGV+Og+oFT
         a1cRZFsG/S5H4pUVjyrjWXdvb2i0BgvAFExIFl4fKVRmqyJBWlrk81mn79APgk06kgoy
         KiimsG97Q+EHqII4/oAko+aPPW9gof06saL9ZKk5pgK2vQfE4ID0pjkUdSDJz0Kn3JF4
         vRMQ==
X-Gm-Message-State: APjAAAU1kVHAvWTdHAi8ZGpvJeDRxtVzseQXyy5vnDAfaxhplONIq4vU
        5Y8kX93QbgMPy9hd6JkpfpdZM8h2
X-Google-Smtp-Source: APXvYqwi5TNnpYxX6MYW3kXhyGOhZMir0mgdzoE7Dyl323pdN3ap76JLlBuRQH7JSpwEVxLZKkeraA==
X-Received: by 2002:adf:9c93:: with SMTP id d19mr21706866wre.383.1570474306979;
        Mon, 07 Oct 2019 11:51:46 -0700 (PDT)
Received: from szeder.dev (x4dbd6b2d.dyn.telefonica.de. [77.189.107.45])
        by smtp.gmail.com with ESMTPSA id b22sm559373wmj.36.2019.10.07.11.51.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 11:51:46 -0700 (PDT)
Date:   Mon, 7 Oct 2019 20:51:44 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] ci: run `hdr-check` as part of the `Static Analysis`
 job
Message-ID: <20191007185144.GE11529@szeder.dev>
References: <pull.368.git.gitgitgadget@gmail.com>
 <4b3b58ca6ddff476acff6735129049588c0a1f13.1569928584.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b3b58ca6ddff476acff6735129049588c0a1f13.1569928584.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 01, 2019 at 04:16:26AM -0700, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>

Good idea, now that 'make hdr-check' runs clean this will help to keep
it that way.

I think adding it to the static analysis job makes sense, as opposed
to the additional VM startup, git clone, and dependency installation
overhead of a dedicated job.  However, this way we won't run 'make
hdr-check' if Coccinelle were to find something undesired, but I think
that's acceptable.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  azure-pipelines.yml        | 2 +-
>  ci/install-dependencies.sh | 3 ++-
>  ci/run-static-analysis.sh  | 3 +++
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/azure-pipelines.yml b/azure-pipelines.yml
> index c329b7218b..15831f6006 100644
> --- a/azure-pipelines.yml
> +++ b/azure-pipelines.yml
> @@ -354,7 +354,7 @@ jobs:
>         test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
>  
>         sudo apt-get update &&
> -       sudo apt-get install -y coccinelle &&
> +       sudo apt-get install -y coccinelle  coccinelle libcurl4-openssl-dev libssl-dev libexpat-dev gettext &&

These are the same additional packages that the hunk below adds to
'ci/install-dependencies.sh'.

So... why not just run 'ci/install-dependencies.sh' in the first place?

(On a related note, I noticed that the regular Linux and OSX jobs on
Azure Pipelines do run 'ci/install-dependencies.sh', but even in those
jobs 'azure-pipelines.yml' runs its own 'apt-get update && install'
anyway.)

>         export jobname=StaticAnalysis &&
>  
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 8cc72503cb..8ce9ce276e 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -49,7 +49,8 @@ osx-clang|osx-gcc)
>  	;;
>  StaticAnalysis)
>  	sudo apt-get -q update
> -	sudo apt-get -q -y install coccinelle
> +	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-dev \
> +		libexpat-dev gettext
>  	;;
>  Documentation)
>  	sudo apt-get -q update
> diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
> index a19aa7ebbc..65bcebda41 100755
> --- a/ci/run-static-analysis.sh
> +++ b/ci/run-static-analysis.sh
> @@ -26,4 +26,7 @@ then
>  	exit 1
>  fi
>  
> +make hdr-check ||
> +exit 1

This '|| exit 1' is unnecessary: our CI scripts are run with 'set -e',
so the non-zero exit code from a failing 'make hdr-check' alone would
fail the build.

(Yeah, there is an other 'exit 1' in the patch context above, but
that's a whole different ballpark and we do need that one.  Unlike
'make hdr-check', 'make coccicheck' (or even COccinelle itself for
that matter) doesn't exit with error when it found something to
transform, and it doesn't print those transformations either.
Consequently, we had to take a few extra steps to fail the build if it
found something, and that 'exit 1' is part of that.  More details in
0860a7641b (travis-ci: fail if Coccinelle static analysis found
something to transform, 2018-07-23).)


> +
>  save_good_tree
> -- 
> gitgitgadget
