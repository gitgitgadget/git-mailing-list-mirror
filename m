Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E6A41F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 16:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbfJAQnC (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 12:43:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40971 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732350AbfJAQnC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 12:43:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id s1so10026286pgv.8
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 09:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0QCr8wGaP9QKif9qZF3xDIzDT/QeXeYPT2ir1Z6NQK0=;
        b=LwpolLf+IqU5nfb8U5xOYvCBmIz2GkgnOR/ngpAVndD6fdWBUQxBB2IHcSausjJRxe
         ZFZQkkMzromDAxOe4u/KG02Vf8gutSI08u14rMkq/RSdv568Rnft6A0zFxVi30eE09er
         6oNxFNouyH70Foa48SI0y31ypG+9WN6hY1O6zfS95W9jhOWNiTrOmeDBqWySzUS70Go0
         YmXvWKEnBuoqQNdopYJxEjcL3bpMhvQQFeZAC0nqn3+iNvADaqrkvHQFdR5UwZHgPjEG
         oxMZojkwpKVcVGcSztK7SXXWM+BXIMzis+TCqRajO/u/GhOmmZ+saDYEtjAB+E5l+nOe
         Bp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0QCr8wGaP9QKif9qZF3xDIzDT/QeXeYPT2ir1Z6NQK0=;
        b=gg1UU+k8EbrnKnHnYoWIo528UFHInNPHa2bbyc4t+nXlo8hQcj4vd+Yw6C7NP18mCI
         oUGFCG24yksJNn05hdzHqxEvo3TT56x88ZGKfx0lFBxMJ28gq89AY2pioKOVxx3DW0lF
         lLAIOkD2UIMGXuySC+Qk20UrVd3wLsbWfFn3FNGoPrt50l7HTr10Ior2FT9XagVljnNk
         fvftjNVj92bDfE/1Q096SyZ7vhck1M1h24/uLxSjhljM4yCT/GIRIhe9dlrxMVYeAle2
         3dohUZxmDmp/x/LD/k9QvWmsLAVsS/edNhWb4idYOwzNL9HztxEf9NB7FJSDgF9N7AiP
         RW6w==
X-Gm-Message-State: APjAAAWKrp6QTbK6stnw9YFHr4bEhoPKmJBdWftmTa/Z+NwAJQy2kzpS
        je+KT6S3U2wXhgAPzSbu7dDYrzg/
X-Google-Smtp-Source: APXvYqwgCSyLYkCun0xyJcJbvym1Ff8+E9LKUGN5nCOYo+p6tCpiq3U9jfTBdq/RjXouyNv1KMkgQA==
X-Received: by 2002:a65:404b:: with SMTP id h11mr31092570pgp.237.1569948181402;
        Tue, 01 Oct 2019 09:43:01 -0700 (PDT)
Received: from generichostname ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id r186sm15368366pfr.40.2019.10.01.09.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 09:43:00 -0700 (PDT)
Date:   Tue, 1 Oct 2019 09:42:58 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] ci: run `hdr-check` as part of the `Static Analysis`
 job
Message-ID: <20191001164258.GA1356@generichostname>
References: <pull.368.git.gitgitgadget@gmail.com>
 <4b3b58ca6ddff476acff6735129049588c0a1f13.1569928584.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b3b58ca6ddff476acff6735129049588c0a1f13.1569928584.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Sorry for not replying or rolling this in earlier, I was waiting for my
series to hit master before doing this change but I guess it doesn't
really hurt to do it any earlier.

On Tue, Oct 01, 2019 at 04:16:26AM -0700, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
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

Seems like you accidentally included coccinelle twice.

Anyway, thanks for picking up where I left off.

-Denton

>  
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
> +
>  save_good_tree
> -- 
> gitgitgadget
