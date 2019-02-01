Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9E311F453
	for <e@80x24.org>; Fri,  1 Feb 2019 21:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfBAVqR (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 16:46:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44735 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfBAVqR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 16:46:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so8591098wrt.11
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 13:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WOg/wY6pFm+Ov8VJd27LYO8uZ3AtOprVbs7jDSZ6w3o=;
        b=Ffp5KKSiSUeBlLdN9sUzvrLVIJuDEIwP+j7+UM3VHedO9Jf1c4ky75yNPkx3r/ibpC
         5bbTm+mY6irhJdpNNek3ZPfy09cOaoyhJ0ZvV3GUvNXGUnSJdvSlbmLiwiB97c94ZjPg
         b8Y1CLWDEkmm6qSFgDygPJ8b8TOYzsEtrK1aFepZxqHYxSFKjtE2LUn7iERCOKgymsEu
         SiDfwwFgazrUmES0SiBDgtAKIf72Ht8lxafSZgTj/T3rH8J68BxLkf6FgLSDGORR2j1B
         nQBGvCjotu3iKmzzeVIM+BA/MkLzcNV7Bh/Zgpt7GXYuCg95YTi+Hkm/fNCgMwdaqDL2
         osWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WOg/wY6pFm+Ov8VJd27LYO8uZ3AtOprVbs7jDSZ6w3o=;
        b=VKqfeFe7fn1rt5KdhCSA0RaEr2lku+FC8pwmtQ1g1PxShPsMbssnlYrjjECbRTdfHa
         dBEsD+mUH1Md9vayPstfIe79u9OEELY1mPvKRDxHS/Vdw0P8lZb9gtR/SGwdUvABsztZ
         H/hqNctQexsxQVPDfIp9OGAyBCzmV/BIdzLhKKMalQRyiZggbbEbdX3WPvwfRXIlxq9x
         k1ENTstY7vwvHdYb5CfzykZiuCWxnhowtp9sUYbOUit52wAqO/88Mn/IQxSMztZg8EOJ
         aY0ExOGEh3qrmLATQYF34CAxx/EtWSyoRivOCSi1Xa6SjALKY9+SC6Kuf5Toy23KJ1Vu
         AF4w==
X-Gm-Message-State: AJcUukdSVfmSNp7Yj0kiMgk7nZ1A2y3E8YDwT1QBFcySlwDIAwVvy+CE
        szyTOe/G40oazWWUz6PP30U=
X-Google-Smtp-Source: ALg8bN5BuNMXNxeNhmnVqb1dotQOSx2fWEx3dHiv7EwvTnqmr5BvjctEDPkp1eH2GFZbLK+Fficn5g==
X-Received: by 2002:adf:ae41:: with SMTP id u1mr38625942wrd.20.1549057574639;
        Fri, 01 Feb 2019 13:46:14 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z206sm4556197wmc.18.2019.02.01.13.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 13:46:14 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/1] Makefile: improve SPARSE_FLAGS customisation
References: <3ccf0255-8a15-effc-ce6b-eabb61625f90@ramsayjones.plus.com>
Date:   Fri, 01 Feb 2019 13:46:13 -0800
In-Reply-To: <3ccf0255-8a15-effc-ce6b-eabb61625f90@ramsayjones.plus.com>
        (Ramsay Jones's message of "Fri, 1 Feb 2019 21:03:11 +0000")
Message-ID: <xmqqmunfxjve.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> In order to enable greater user customisation of the SPARSE_FLAGS
> variable, we introduce a new SP_EXTRA_FLAGS variable to use for
> target specific settings. Without using the new variable, setting
> the SPARSE_FLAGS on the 'make' command-line would also override the
> value set by the target-specific rules in the Makefile (effectively
> making them useless). In addition, we initialise the SPARSE_FLAGS
> to the default (empty) value using a conditional assignment (?=).
> This allows the SPARSE_FLAGS to be set from the environment as
> well as from the command-line.

Thanks for a detailed and clear explanation here and in the cover
letter.  I agree with the motivation and most of the things I see in
this patch, but one thing that stands out at me is if we still want
to += append to SP_EXTRA_FLAGS in target specific way.  Before this
patch, because SPARSE_FLAGS was a dual use variable, it needed +=
appending to it in these two places, but that rationale is gone with
this patch.

Also, don't we want to clear SP_EXTRA_FLAGS at the beginning?

The reason I raise these is because I do not quite see a clear
answer to "I want to set SP_EXTRA_FLAGS and not SPARSE_FLAGS,
because ...".

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  Makefile | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 6e8d017e8e..dc02825c88 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -574,7 +574,7 @@ SPATCH = spatch
>  
>  export TCL_PATH TCLTK_PATH
>  
> -SPARSE_FLAGS =
> +SPARSE_FLAGS ?=
>  SPATCH_FLAGS = --all-includes --patch .
>  
>  
> @@ -2369,10 +2369,10 @@ gettext.sp gettext.s gettext.o: GIT-PREFIX
>  gettext.sp gettext.s gettext.o: EXTRA_CPPFLAGS = \
>  	-DGIT_LOCALE_PATH='"$(localedir_relative_SQ)"'
>  
> -http-push.sp http.sp http-walker.sp remote-curl.sp imap-send.sp: SPARSE_FLAGS += \
> +http-push.sp http.sp http-walker.sp remote-curl.sp imap-send.sp: SP_EXTRA_FLAGS += \
>  	-DCURL_DISABLE_TYPECHECK
>  
> -pack-revindex.sp: SPARSE_FLAGS += -Wno-memcpy-max-count
> +pack-revindex.sp: SP_EXTRA_FLAGS += -Wno-memcpy-max-count
>  
>  ifdef NO_EXPAT
>  http-walker.sp http-walker.s http-walker.o: EXTRA_CPPFLAGS = -DNO_EXPAT
> @@ -2386,7 +2386,7 @@ endif
>  ifdef USE_NED_ALLOCATOR
>  compat/nedmalloc/nedmalloc.sp compat/nedmalloc/nedmalloc.o: EXTRA_CPPFLAGS = \
>  	-DNDEBUG -DREPLACE_SYSTEM_ALLOCATOR
> -compat/nedmalloc/nedmalloc.sp: SPARSE_FLAGS += -Wno-non-pointer-null
> +compat/nedmalloc/nedmalloc.sp: SP_EXTRA_FLAGS += -Wno-non-pointer-null
>  endif
>  
>  git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
> @@ -2710,7 +2710,7 @@ SP_OBJ = $(patsubst %.o,%.sp,$(C_OBJ))
>  
>  $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
>  	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
> -		$(SPARSE_FLAGS) $<
> +		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $<
>  
>  .PHONY: sparse $(SP_OBJ)
>  sparse: $(SP_OBJ)
