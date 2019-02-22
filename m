Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07BB720248
	for <e@80x24.org>; Fri, 22 Feb 2019 23:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbfBVXTi (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 18:19:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42563 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVXTi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 18:19:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id r5so4025571wrg.9
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 15:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=m7XkKAyvyuQBdizIiuGDUvgV6hFy/IELy+bEXGhH/jg=;
        b=dLJsX7NLmnsXTmZnuyn20mqduPW06BTTWS/wzAzZJeAHZxJn7N2sTyaxQXbyZqvw6S
         00Dltmj5LMJg5nSuotXWR1Uqj35kawhHOJyZKTcVv/KQ0SmNAOz8pTDLbyuOt6KmCgMK
         IftfHrg6baI5GHT8Kwti+wSoJ8Q4MWzkokqk/rtP/ClnF/a5CFC/l/lzvJGjiHCm1Jef
         O78wlaFzTKYT8tZ+IQd8nc32+V3354MyzSnTb8TqQ+yUwdPFagNAuCHX/1PZfTCBnFQJ
         CG1yyxUzfaAm0wow4c7KYq5gkQBh331vqamTcFzrLwV3DIMNf7gzIK1tfQgMsE7vCb7b
         P/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=m7XkKAyvyuQBdizIiuGDUvgV6hFy/IELy+bEXGhH/jg=;
        b=dS3GcbrlyXNH7UrAiILANq0aFlpwvCs9JUfUZe7GtQ54Kpma4wUpDAAe2YkXgOjA0+
         br2MIr9cvQmoHZJ7+hGTZDLsuaEmzj/awd7dFd/55g/Yugw73/1f64S5fCeDzx1kFWdl
         kHAJSQKQYQpncKDxROdWDlXUArfkb+gxeb3A1DHvXb6thIVgzdBDsI+jlWA1O7zHKX1/
         xO/wsU/ME9Ae+XSQMTDnFt0LeiBmKnSPxrlFBlD7pev7Z33FAqvO13PeL54jd5+PNRy7
         waRZGqlDBA+cqaf+tXA173MRjvjfZd6UayrNY6VgGPQtzXAM9EdAYehcFIbspcKEJQz6
         OPXg==
X-Gm-Message-State: AHQUAubMjDDjXf9ynfpKD+uMUUl1/AkNuDrcHbZ3j1u2iqiVz2fWlHqP
        KCV7Rc0dugOOWofwVARB+uI=
X-Google-Smtp-Source: AHgI3IbQIHP2G1b/iG3rizIOh6KrWcFN3Gag277o+GoLLfdE1GSQ8vLJWFVnJZh+xr0Pyw6QSBTBJw==
X-Received: by 2002:a5d:604d:: with SMTP id j13mr4693633wrt.194.1550877576291;
        Fri, 22 Feb 2019 15:19:36 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d15sm6187469wrw.36.2019.02.22.15.19.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 15:19:35 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Lars Schneider <larsxschneider@gmail.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH v2 5/6] Makefile: move the setting of *FLAGS closer to "include"
References: <20190222105658.26831-1-avarab@gmail.com>
        <20190222144127.32248-6-avarab@gmail.com>
Date:   Fri, 22 Feb 2019 15:19:34 -0800
In-Reply-To: <20190222144127.32248-6-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 22 Feb 2019 15:41:26 +0100")
Message-ID: <xmqqva1bo1h5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Move the setting of variables like CFLAGS down past settings like
> "prefix" and default programs like "TAR" to just before we do the
> include from "config.mak.*".
>
> There's no functional changes here yet, but move note that
> "ALL_CFLAGS" and "ALL_LDFLAGS" are moved below the include. A
> follow-up change will tweak those depending on a variable set in
> config.mak.dev.

Sorry, but cannot parse the sentence around "move note".

>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Makefile | 40 ++++++++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 59674ce9d7..82cfd6c2e4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -506,13 +506,6 @@ GIT-VERSION-FILE: FORCE
>  	@$(SHELL_PATH) ./GIT-VERSION-GEN
>  -include GIT-VERSION-FILE
>  
> -# CFLAGS and LDFLAGS are for the users to override from the command line.
> -CFLAGS = -g -O2 -Wall
> -LDFLAGS =
> -ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
> -ALL_LDFLAGS = $(LDFLAGS)
> -ARFLAGS = rcs
> -
>  # Set our default configuration.
>  #
>  # Among the variables below, these:
> @@ -572,7 +565,6 @@ TCLTK_PATH = wish
>  XGETTEXT = xgettext
>  MSGFMT = msgfmt
>  CURL_CONFIG = curl-config
> -PTHREAD_CFLAGS =
>  GCOV = gcov
>  STRIP = strip
>  SPATCH = spatch
> @@ -582,16 +574,6 @@ export TCL_PATH TCLTK_PATH
>  # Set our default LIBS variables
>  PTHREAD_LIBS = -lpthread
>  
> -# user customisation variable for 'sparse' target
> -SPARSE_FLAGS ?=
> -# internal/platform customisation variable for 'sparse'
> -SP_EXTRA_FLAGS =
> -
> -SPATCH_FLAGS = --all-includes --patch .
> -
> -BASIC_CFLAGS = -I.
> -BASIC_LDFLAGS =
> -
>  # Guard against environment variables
>  BUILTIN_OBJS =
>  BUILT_INS =
> @@ -1160,6 +1142,25 @@ ifeq ($(wildcard sha1collisiondetection/lib/sha1.h),sha1collisiondetection/lib/s
>  DC_SHA1_SUBMODULE = auto
>  endif
>  
> +# Set CFLAGS, LDFLAGS and other *FLAGS variables. These might be
> +# tweaked by config.* below as well as the command-line, both of
> +# which'll override these defaults.
> +CFLAGS = -g -O2 -Wall
> +LDFLAGS =
> +BASIC_CFLAGS = -I.
> +BASIC_LDFLAGS =
> +
> +# library flags
> +ARFLAGS = rcs
> +PTHREAD_CFLAGS =
> +
> +# For the 'sparse' target
> +SPARSE_FLAGS ?=

Makes us wonder why only this one is different and uses ?= ;-)

> +SP_EXTRA_FLAGS =
> +
> +# For the 'coccicheck' target
> +SPATCH_FLAGS = --all-includes --patch .
> +
>  include config.mak.uname
>  -include config.mak.autogen
>  -include config.mak
> @@ -1168,6 +1169,9 @@ ifdef DEVELOPER
>  include config.mak.dev
>  endif
>  
> +ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
> +ALL_LDFLAGS = $(LDFLAGS)
> +
>  comma := ,
>  empty :=
>  space := $(empty) $(empty)
