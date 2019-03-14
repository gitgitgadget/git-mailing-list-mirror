Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D51DD20248
	for <e@80x24.org>; Thu, 14 Mar 2019 01:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfCNByf (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 21:54:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37058 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfCNByf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 21:54:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id x10so1121361wmg.2
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 18:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ayvpr9BUHaycUEhYJimplovmS8Npk4jwKqzOSXx5mzg=;
        b=iDffhB+4yp3mcgrWVq7oVVks1o/bMFIOW9joCFhffkBAPsJx2roPvHM4qe+tLQkOMR
         CCTG/ydnl9mak+zbgznDVeFk49NWgJ/N7+s2gX97EH+TYhFWkiMv1Huw+W7+pUz407Jk
         ZWG+Soe/hR2tkydTvNLSKCiVVcdwIlby5paylmF2WgivZcvbthyNT1+bEbPzLBZvtc1/
         ReNsSC7bOBss3Rie6aAnI+/9v4d/+5JQtBakHMXVj/Akn9cvLupRk5FnagE6b8Xgnwae
         3jKG0vudx/0rnfDqHYtBxV2cLphQdd/n2nRTTD/n75SpTZ3Nq4al7tnfUVEsUP296FTF
         h73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ayvpr9BUHaycUEhYJimplovmS8Npk4jwKqzOSXx5mzg=;
        b=XG6WE/hBQy9CcNRq8zDsr4++FeGsk0IRY7f3/VKrT4k876tUmBLz2gz7aLMoRiCe5a
         OD/mCRW0uKTXWVbcRKOmJKkG1tcg7NwS6Em5PXfrHwe5Y+wxn7a9+qi3oGtW0O3Qebzh
         YxNpPgENNOLa1IhmUNNBmy1Sj8zVS5yGK3WeOtkdqV/1Q6FZBRSUmyqTKU0OtXZl1B3H
         8w+SXqwPJcyARAHyf5F9rhIO1fQ/K2QQCkpNQovvaKp8XIGgj7WP4ft0/R+7PfTZKJya
         kzsuB0vg+WHW1anMK6P/dgsli2XPOOzeon5S3qjvM1RzBBi75wCPrTBc23fqcxvb7XnJ
         fvYw==
X-Gm-Message-State: APjAAAVQM0YAzL4DtjICfh0CK1YDKirk++V5rA690DdVX/LFHoK+WO/+
        1Q3nvTAbO4Cn49qL5zEXh3M=
X-Google-Smtp-Source: APXvYqx7Q9TTQgvbkOzMc7uReENqXLVL6FvH45vBzmGr0WzxndUql4Qy2Lqao6AO/8/qwJfDwrJGAA==
X-Received: by 2002:a1c:6046:: with SMTP id u67mr638445wmb.142.1552528473491;
        Wed, 13 Mar 2019 18:54:33 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id r63sm802934wmr.32.2019.03.13.18.54.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 18:54:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] check-docs: fix for setups where executables have an extension
References: <pull.162.git.gitgitgadget@gmail.com>
        <f06126c3a11119bf6e2a830bbac312f65582387f.1552478212.git.gitgitgadget@gmail.com>
Date:   Thu, 14 Mar 2019 10:54:32 +0900
In-Reply-To: <f06126c3a11119bf6e2a830bbac312f65582387f.1552478212.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 13 Mar 2019
        04:56:53 -0700 (PDT)")
Message-ID: <xmqq5zsmcjaf.fsf@gitster-ct.c.googlers.com>
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
> On Windows, for example, executables (must) have the extension `.exe`.
> Our `check-docs` target was not prepared for that.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

My writing this loop certainly predates increased upstream
activities for Windows port we see recently, and we saw little
updates ever since the loop was written; I am kind of surprised it
took this long for us to find the missing .exe support here.

Thanks.

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
>  		*" $$cmd "*)	;; \
>  		*) echo "removed but $$how: $$cmd" ;; \
>  		esac; \
