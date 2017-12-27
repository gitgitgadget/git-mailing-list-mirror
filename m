Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 668C21F424
	for <e@80x24.org>; Wed, 27 Dec 2017 22:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbdL0WYL (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 17:24:11 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35980 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbdL0WYK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 17:24:10 -0500
Received: by mail-wm0-f67.google.com with SMTP id b76so41443067wmg.1
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 14:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=N8Mv3W0lQQUoEXzuJZm/PZar1zV0E7VGEicHx+23UP8=;
        b=IkxCURSy3RxXxGBdTVeZ4WNOavRbGwVrhg23u5noGmuGGQCNnDPGRMGEZE/WBtTPQp
         3xDkyTjRYt8iV1mnUbVu5EOe22T5t3VsXxZPrF+SNN6nlGE+N+MUKbeKjq2J1HAyOqps
         plaU/+7Q9eaLuXXwjGiGbv9Fa5WyvsXxPi2Mfsp44VzADeTBOd0UZA+AxMTRIU8RKnTw
         oBCuTkVCQnAzT4QmfMUz/aC01j+SO1QsnMbuc+jgfPEFCJZE52Exlnf0TsV8/w25ui/6
         IynBS0cF8RQFoTi16/Kev5gWcWelrWn8TZMGWtS/NPwgg+EAIzIKwvLo3o3k8hGqFJ86
         IGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=N8Mv3W0lQQUoEXzuJZm/PZar1zV0E7VGEicHx+23UP8=;
        b=BRmA4UozeIbjdnGJSrp+sUg7Cz+sjn9DxANk3yEgEPxKPebM3Ykpa1pFesmq/Fuco6
         NcxlVeSR+JJs+FgJhT07vapWqdWe3LX6bPnGzJmQAvW1io5WgPTY/QHJtgdyEmscoxYO
         Ebgt0D++n268JUQhLlTxv1ZgEjZM6lGk4ya51fFtCHIzu2lleJFPr3vYCc7kwgf6AqAF
         1R/t9x82uEUvpxTuUnS9DZLxK4UBRaD+TsI1gXw1fX0DlCA9O0b9doXUjQQuQV+LyaNx
         got4bB3Q9LgzlBdnIaO7RG+qGaibLAMu/TCQZ+6mLikKkRloZ3+ndNTlOZ/QeB9z0+hZ
         e9NQ==
X-Gm-Message-State: AKGB3mK1qmgiovAOiKeiVdVtV3RzgSrJsl2LN6EZWjUTefnu1yiBvKom
        VH47271/Ac9iRUbaenNbnS1BgKoC
X-Google-Smtp-Source: ACJfBotnJeNk7lGaS4CIyBuj/8LZl7zHnBwf1oHzO5D5+huYXi987GsxAvkDKHgzXASSH/hef3b1EQ==
X-Received: by 10.80.186.193 with SMTP id x59mr37425357ede.256.1514413448812;
        Wed, 27 Dec 2017 14:24:08 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id y28sm27656390edi.95.2017.12.27.14.24.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 14:24:07 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Dan Jacques <dnj@google.com>,
        Alex Riesen <alexander.riesen@cetitec.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Casey <drafnel@gmail.com>, Petr Baudis <pasky@ucw.cz>,
        Gerrit Pape <pape@smarden.org>,
        "martin f . krafft" <madduck@madduck.net>, Eric Wong <e@80x24.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        Michael J Gruber <git@grubix.eu>,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v6] Makefile: replace perl/Makefile.PL with simple make rules
References: <20171220174147.GG3693@zaya.teonanacatl.net> <20171220182419.16865-1-avarab@gmail.com> <xmqqefnmshsm.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqefnmshsm.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 27 Dec 2017 23:24:06 +0100
Message-ID: <87lghnrerd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 22 2017, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>
> Thanks, but I thought the patch was already in 'next' for a week or
> more and it's time to refine incrementally.
>
> Here is the difference as I see between what we already have and
> this update, and a proposed summary.
>
> -- >8 --
> From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Subject: perl: avoid *.pmc and fix Error.pm further
>
> The previous round tried to use *.pmc files but it confused RPM
> dependency analysis on some distros.  Install them as plain
> vanilla *.pm files instead.
>
> Also "local @_" construct did not properly work when goto &sub
> is used until recent versions of Perl.  Avoid it (and we do not
> need to localize it here anyway).

When I read this back on the 22nd I missed that you were waiting on my
feedback on this. Just saw What's Cooking now. Yes, LGTM:

Acked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
(if needed)
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

> ---
> diff --git a/Makefile b/Makefile
> index ba6607b7e7..5c73cd208a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2274,14 +2274,14 @@ endif
>  po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
>  	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
>
> -PMFILES := $(wildcard perl/*.pm perl/*/*.pm perl/*/*/*.pm perl/*/*/*/*.pm)
> -PMCFILES := $(patsubst perl/%.pm,perl/build/lib/%.pmc,$(PMFILES))
> +LIB_PERL := $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl/Git/*/*/*.pm)
> +LIB_PERL_GEN := $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_PERL))
>
>  ifndef NO_PERL
> -all:: $(PMCFILES)
> +all:: $(LIB_PERL_GEN)
>  endif
>
> -perl/build/lib/%.pmc: perl/%.pm
> +perl/build/lib/%.pm: perl/%.pm
>  	$(QUIET_GEN)mkdir -p $(dir $@) && \
>  	sed -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' < $< > $@
>
> diff --git a/perl/Git/Error.pm b/perl/Git/Error.pm
> index 5874672150..09bbc97390 100644
> --- a/perl/Git/Error.pm
> +++ b/perl/Git/Error.pm
> @@ -39,7 +39,7 @@ sub import {
>  	require Error;
>      };
>
> -    local @_ = ($caller, @_);
> +    unshift @_, $caller;
>      goto &Error::import;
>  }
>
