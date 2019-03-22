Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3108920248
	for <e@80x24.org>; Fri, 22 Mar 2019 18:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfCVSnu (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 14:43:50 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36924 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfCVSnu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 14:43:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id z16so3690903qtn.4
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 11:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yHm4OZ1CMFLwO5dY9yOJ/NcIYExs55B+M7sztCUSvZc=;
        b=SQ6nwS1p52DfaXE0sKwWDWwLspNd35+NZyCEj8lRQH2cOe7f4s7I6PRQ5xJWQQISwu
         HjxxMVreIrMrxCw1vZ0qk+7FKu4160m00x8nYyPIGLgTzcYdr7olBRldWwoxPhLD1ywR
         rYiJt4uLc/7HYpcFl3VpuUvJ2myP82ytxJHWTqmNyOFplPZIZJXeep3bi3LS/rMwt+ei
         oRdv1tUaBySaPGyOt7SRdl0D92wghpOmBlfyx/KTTwYpHLIw3BSIWKCg5Mg3c++JOnNl
         883PFpd7u48HPWvuTUJaZViejY5YfP9iFmowCz8GRMMnnLCvvWezIs8WuDZJjlPqconF
         dHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yHm4OZ1CMFLwO5dY9yOJ/NcIYExs55B+M7sztCUSvZc=;
        b=KPaRatU+pkvPiWIM9UWdncVS68+AxX/pww6jEmzYS2ShtPRYDFoWQt1edIDxxzZh7h
         6epZL6W/Y9xzPYDVkdUUNieQfnJbso9Y03yFiMyCoY63QyNg3MLH9OPidSHnrQbL5eCL
         Eh9GxG72tWii3QDJT86tutSCoSA3HLcCmkG0iTDzT3zEWHl4+8bKvO6uRFoqkbwrIJKo
         a7k4tNQ8k8YcHXODM9NfBRfuHffno9JdEQMNQgOB859gQUnQ4vQYWhRw/t7KUuIJKyLA
         fJy7NXQ/80qRKLQCf7VS6j4q6uzGIlFyz6ml4zUuVOWAHtB7lTcQxOlJVE2KIzuYFQJt
         MZqg==
X-Gm-Message-State: APjAAAUa79At6G7WIc1mHg9tde08gLDuG/cpkAoCTNuet9uwBKImrvrQ
        jWqqSmCG/5elBCoW+acJrF4l0g==
X-Google-Smtp-Source: APXvYqzZ39vFtdL6SiIjWZUdEMY9snpZPrUnjVqeKFsqxgH+okrt6wiEomnYLV0KghQjNnCwApQzRg==
X-Received: by 2002:a0c:9973:: with SMTP id i48mr9546109qvd.9.1553280228877;
        Fri, 22 Mar 2019 11:43:48 -0700 (PDT)
Received: from localhost ([173.225.52.220])
        by smtp.gmail.com with ESMTPSA id y6sm2182191qka.69.2019.03.22.11.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 11:43:47 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Fri, 22 Mar 2019 14:43:47 -0400
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] check-docs: fix for setups where executables have an
 extension
Message-ID: <20190322184347.GC12155@Taylors-MacBook-Pro.local>
References: <pull.162.git.gitgitgadget@gmail.com>
 <f06126c3a11119bf6e2a830bbac312f65582387f.1552478212.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f06126c3a11119bf6e2a830bbac312f65582387f.1552478212.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Wed, Mar 13, 2019 at 04:56:53AM -0700, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> On Windows, for example, executables (must) have the extension `.exe`.
> Our `check-docs` target was not prepared for that.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 537493822b..df56bf0cd1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3074,7 +3074,7 @@ ALL_COMMANDS += git-gui git-citool
>  .PHONY: check-docs
>  check-docs::
>  	$(MAKE) -C Documentation lint-docs
> -	@(for v in $(ALL_COMMANDS); \
> +	@(for v in $(patsubst %$X,%,$(ALL_COMMANDS)); \
>  	do \
>  		case "$$v" in \
>  		git-merge-octopus | git-merge-ours | git-merge-recursive | \
> @@ -3103,7 +3103,7 @@ check-docs::
>  		    -e 's/\.txt//'; \
>  	) | while read how cmd; \
>  	do \
> -		case " $(ALL_COMMANDS) " in \
> +		case "  $(patsubst %$X,%,$(ALL_COMMANDS)) " in \

I'm a little late to reading this thread, but I was curious why there
are now two spaces around the patsubst as opposed to the one around
ALL_COMMANDS?

>  		*" $$cmd "*)	;; \
>  		*) echo "removed but $$how: $$cmd" ;; \
>  		esac; \
> --
> gitgitgadget

Thanks,
Taylor
