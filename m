Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C06EC1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 19:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbeGWUjt (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 16:39:49 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51538 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbeGWUjs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 16:39:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id h3-v6so262293wmb.1
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 12:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=KREdf5NqKziQZ78mEf/1My+91oI4Ui6qg3mEMof9lJI=;
        b=Pzm18du+39JavcQkJJFXVP8F9/zeRb6ZchHCVD6rwwe5OljbXUJxxbqZOcOwKkOqy5
         zJsjQv4iWVFJMcRga0zv4OfpPGguVPBkmsAsN2WwuGlop4ILsGMpClSLpWPegBpDKah8
         7MX/dANv5kKMd2wN4VXxTZbJkI57u9ZHUmo9eLij4FQ6/MNvaJuvsHn4CO8oI78rLr2R
         geTDihNUi9bpqbsEWfYIrbm2rfbFqQfxwyK4aCx4uWhsaIBg4HSjciJAQkz2cFW2tx4J
         P2TlsR0solio8n0D6+adpAwTa1atB3BLfCSee9PMogX6YPcPOUo0b8H87UAEAlwK9jLG
         CXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=KREdf5NqKziQZ78mEf/1My+91oI4Ui6qg3mEMof9lJI=;
        b=o9mF3w73nVivjJCPaP2JKIE8NI1L7fEk2XBuupmPAs1SaCPyiQL4QaAwSi5+eO89sY
         A7EZvg9gZOVoBXOaQaIM6fNXcWRGJ2QhJKMeg1is1+aIuoWVfSoIcLVILGA7jo3bzZNe
         BJe8ZiObEpDl0NEHNw75LQrHdhLOY/uxCimvFIJ9bZynx05FcxljAHhOX4ripJH4GMdG
         lgBEBYwwevBQRhSw8rgdgNa6TojPKs7iv5frhoW5mKYpXlloUbOLP31ZiaSlL3sBNjvo
         9yi1VoeKSyVlXk+kXGtfbcMIBNmUI5M4l86jh/zzERu+XpHPIhnjqYLQ9Iay/5HRPM+u
         f14Q==
X-Gm-Message-State: AOUpUlH/G2rND138IpGVxzSQOkPUuQE1TaE+HduaARkiE8zhDlFcGvtE
        t4H0zA986dB+ucJ2/6cJ3Ys=
X-Google-Smtp-Source: AAOMgpe3hMlAZkM1hxLRCj2STqPIBdMkNkd/lxT0WN8wgiGhOr3C74176l1cAwPupr6F8ZnOnmG4VQ==
X-Received: by 2002:a1c:7c0c:: with SMTP id x12-v6mr196167wmc.58.1532374625343;
        Mon, 23 Jul 2018 12:37:05 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p184-v6sm7994747wmp.31.2018.07.23.12.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 12:37:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH 1/5] coccinelle: mark the 'coccicheck' make target as .PHONY
References: <20180723135100.24288-1-szeder.dev@gmail.com>
        <20180723135100.24288-2-szeder.dev@gmail.com>
Date:   Mon, 23 Jul 2018 12:37:04 -0700
In-Reply-To: <20180723135100.24288-2-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Mon, 23 Jul 2018 15:50:56 +0200")
Message-ID: <xmqqefft68wv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> The 'coccicheck' target doesn't create a file with the same name, so
> mark it as .PHONY.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---

Good.  It is customary to do so immediately before the target, not
after a blank line, though.

>  Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index e4b503d259..27bfc196dd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2685,6 +2685,8 @@ C_SOURCES = $(patsubst %.o,%.c,$(C_OBJ))
>  	fi
>  coccicheck: $(patsubst %.cocci,%.cocci.patch,$(wildcard contrib/coccinelle/*.cocci))
>  
> +.PHONY: coccicheck
> +
>  ### Installation rules
>  
>  ifneq ($(filter /%,$(firstword $(template_dir))),)
