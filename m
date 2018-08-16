Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49C311F404
	for <e@80x24.org>; Thu, 16 Aug 2018 16:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392297AbeHPTT5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 15:19:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42832 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbeHPTT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 15:19:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id e7-v6so4658374wrs.9
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 09:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=B2FeuE9w0hjsE7uFc5ji7eTTmmLrvgVVGaMDdFcqYU0=;
        b=ZekF+5jOdAYY2va32MbW/Y2AVC+pAa/igwsNwen0vx+5WwLhlYG4PWaD9h+o+biAON
         ySZcqkTklF3BjtWTRtQ+gAaeaeb/HNNgmTuNu72IjiJnpySFjwCWL9yCj14T/XFvDQFl
         I/xDKcet6J7g8RdQWEDt/tAL0ZXyNVsaaYRIUY4fAHLn4LGGOR1qybG/qnlOgFeXhzYO
         bnl8rdxkXAzbdRFi6mNe5tO4LIbfGwRw7reUGrqv4dfOwm5ZgI04h4bJ82G7+1GQNs9X
         Sx45VTmZPaepgmpI2y/UTMUDy6i4YoefGaH3pyzV9MvFhBmmqeDPJyCZHNume9nawFPT
         CgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=B2FeuE9w0hjsE7uFc5ji7eTTmmLrvgVVGaMDdFcqYU0=;
        b=HTi0t0iVPTbeH0hIxrbZ3T9KYasHgl3460Gg1XrZ0Kib7NvprKuNcU8Vdl3AgHFcr8
         YWrO8/oJcuXYWsQ1sZSP7pm1mNaYRk95KFGaZYd35324urix1Tek4oQG4Xqt8tkXK0tr
         Ch/JJVZNE6PopoFzUsMEukgfeJ1EgTkENAQPMX38oexKbSjViVyIiL7NiOVVg6Bu4dmy
         RfuxqQIeWDAWV+I567fX+qggOgcMUjVr2jHoNzVrc3xhLEDRqp7AcGz7GFEjP2puC9e+
         dUeFzRjAkUrePDKzpeIcwSy9WTxxKrsxRDMpNdHs6g6vTJ3iTGNfAjjgs8VNrHL8weBU
         SaUA==
X-Gm-Message-State: AOUpUlGSUYDP6rcYN8TAY6e1E87ld/78ehiOUfwCuycXzOuDLXnsmh+l
        8K11BVKf8YReFmA7R8/5Few=
X-Google-Smtp-Source: AA+uWPzYMPPxNEpCTfLXQOLYpmhVFlP8tp6a9e1OxeZOHsrPPbaZOHGfVYMt14qp/b7LZsyblaufFg==
X-Received: by 2002:a5d:6581:: with SMTP id q1-v6mr20373024wru.141.1534436428512;
        Thu, 16 Aug 2018 09:20:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n8-v6sm18634863wrt.56.2018.08.16.09.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 09:20:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, peff@peff.net, jrnieder@gmail.com
Subject: Re: [PATCHv4 0/6] Add missing includes and forward declares
References: <https://public-inbox.org/git/20180813171749.10481-1-newren@gmail.com/>
        <20180815175410.5726-1-newren@gmail.com>
        <b8553a50-6b97-2b45-2f7b-cfe2576548cb@ramsayjones.plus.com>
Date:   Thu, 16 Aug 2018 09:20:27 -0700
In-Reply-To: <b8553a50-6b97-2b45-2f7b-cfe2576548cb@ramsayjones.plus.com>
        (Ramsay Jones's message of "Thu, 16 Aug 2018 01:19:17 +0100")
Message-ID: <xmqqtvnufflg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> BTW, I happen to be on the 'pu' branch.
>
> I think some of the errors are due to missing compiler flags
> (-I, -D, etc); which flags did you pass to the compiler?
>
> Well, it killed 15min. before bed! ;-)
>
> ATB,
> Ramsay Jones

It certainly does look fun.  I anticipate (read: mostly "hinting
that I won't be the one who would be doing so") somebody would make
it a real patch, as the current trend seems to be to automate as
much checking as we reasonably can.

> -- >8 --
> Subject: [PATCH] Makefile: add a hdr-check target
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  Makefile | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 9923db888c..798396c52e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2684,6 +2684,16 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
>  .PHONY: sparse $(SP_OBJ)
>  sparse: $(SP_OBJ)
>  
> +EXCEPT_HDRS := ./compat% ./xdiff% ./ewah%
> +CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(LIB_H))
> +HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
> +
> +$(HCO): %.hco: %.h FORCE
> +	$(CC) -Wall -include git-compat-util.h -I. -o /dev/null -c -xc $<
> +
> +.PHONY: hdr-check $(HCO)
> +hdr-check: $(HCO)
> +
>  .PHONY: style
>  style:
>  	git clang-format --style file --diff --extensions c,h
