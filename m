Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5D2A1F404
	for <e@80x24.org>; Fri, 16 Feb 2018 14:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757956AbeBPOjJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 09:39:09 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:37250 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754785AbeBPOjI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 09:39:08 -0500
Received: by mail-wr0-f171.google.com with SMTP id k32so3134123wrk.4
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 06:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=FpPCyB5AE9ZoEk4unypEEh6OtH8qaN5W8X4eWc53E0g=;
        b=tW1YnqRLGAD7jxDMKzLvPR1dVc0jq4dCK7M5kb5VMcQleffUDh3g1Uuq9ZFyXkKSc+
         mB6+7zJUOSuMLtYeqEK2PL1xIiFRTfxeO386Fz4GkKrbJNBxZf+uZM1j2GelemfHYStG
         VTN4w+TgSrt1qKc7WRqhbWmj+Q28dckXE0vm6ZLDmva6oCW+vMfObSJqvHJzzVLJIBOT
         bUmS9LQTeSU4nIsuSRgKcE5oxI4U5ubydwAGVYmi8W13vZ3J9FlMyDSe/mNj49kx/Vuu
         saEd34q0dowv+YCBf5ivYvGgB1jKQLUhMhMU31aDeYPZrALq6+22wJo7lduEDnpZZY2J
         sCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=FpPCyB5AE9ZoEk4unypEEh6OtH8qaN5W8X4eWc53E0g=;
        b=Iop24xzL6/IjKpB4cVFLdADpkukp+nxAirqWW7e0pzLOihIDUe9s5pC4CjHzZqqs9b
         cuf//rPHpn73wItY59D2P09+FFRY+Kd7NTMmpRyRMfC2KG95sDtz+9dlhH3NC9Uw8z/z
         OxpjEcD6SsYyFHrBMJSr8CVH+17x2EVHD2la6uMJ2ogl0HNeu3oV7rqHoNRyc8oJpPh/
         jIysN4VXVCus8hyXW9uZTXqHayG1BPRFM0Zf+CqzS5nBM/HB6QB3SGGDC9UsbxKcn+zV
         mmjHz/jIRb/kozHP5yNPeU8EReuzqmUQYOeiip3HOkRJdt/hMZEpU3UuUyWw3B1KyrP9
         CIug==
X-Gm-Message-State: APf1xPCANcl8O6M89ScOepntT2KDt2+nuui+a1YUEmwP0C6ay0a5bxOQ
        x1rGApHc0+iKYGU8a5ACYWeXubx1
X-Google-Smtp-Source: AH8x227VsLmwkULAUmtfBYmoyjgXi1T5QG3EwbFe5XihUuPQ/8PDFw0/I9OIjyVETk4HwM1o1G4JGA==
X-Received: by 10.223.202.9 with SMTP id o9mr6078208wrh.40.1518791946421;
        Fri, 16 Feb 2018 06:39:06 -0800 (PST)
Received: from evledraar (static-2-73-24-46.ipcom.comunitel.net. [46.24.73.2])
        by smtp.gmail.com with ESMTPSA id u48sm1898529wrb.85.2018.02.16.06.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 06:39:05 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 3/8] perl: generalize the Git::LoadCPAN facility
References: <20180214222146.10655-1-avarab@gmail.com> <20180214222146.10655-4-avarab@gmail.com> <20180215045301.GC27038@zaya.teonanacatl.net> <87sha2f0j1.fsf@evledraar.gmail.com> <20180215212338.GL27038@zaya.teonanacatl.net>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180215212338.GL27038@zaya.teonanacatl.net>
Date:   Fri, 16 Feb 2018 15:39:03 +0100
Message-ID: <87k1vdf188.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 15 2018, Todd Zullinger jotted:

> [I dropped bbourbie@slb.com from the Cc: list, as it bounced
> on my previous reply.]
>
> Ævar Arnfjörð Bjarmason wrote:
>> That makes sense, I'll incorporate that in a re-roll. I like
>> NO_PERL_CPAN_FALLBACKS or just NO_CPAN_FALLBACKS better.
>
> Either is an improvement.  Starting with NO_PERL_ seems
> like a slightly better bikeshed color. :)
>
>> I'd really like to find some solution that works differently though,
>> because with this approach we'll run the full test suite against a
>> system where our fallbacks will be in place (although if the OS
>> distributor has done as promised we won't use them), and then just
>> remove this at 'make install' time, also meaning we'll re-gen it before
>> running 'make install' again, only to rm it again.
>>
>> The former issue we could deal with by munging the Git::LoadCPAN file so
>> it knows about NO_PERL_CPAN_FALLBACKS, and will always refuse to use the
>> fallbacks if that's set. That's a good idea anyway, because right now if
>> you e.g. uninstall Error.pm on Debian (which strips the CPAN fallbacks)
>> you get a cryptic "BUG: ..." message, it should instead say "we couldn't
>> get this module the OS promised we'd have" or something to that effect.
>
> Teaching Git::LoadCPAN to never fallback sounds like a good
> idea.  At least then if the packager intended to avoid the
> fallbacks and didn't get it right the error message could be
> more useful.
>
> Hopefully that's not a common problem for packagers though.
> (And adding the Makefile knob was intended to help make it
> easier for packagers to achieve this common goal.)
>
>> The latter is trickier, I don't see an easy way to coerce the Makefile
>> into not copying the FromCPAN directory without going back to a
>> hardcoded list again, the easiest thing is probably to turn that:
>>
>>     $(TAR) cf - .)
>>
>> Into:
>>
>>     $(TAR) cf - $(find ... -not ....)
>>
>> Or something like that to get all the stuff that isn't the Git/FromCPAN
>> directory.
>>
>> Other suggestions most welcome.
>
> What about moving perl/Git/FromCPAN to perl/FromCPAN and
> then including perl/FromCPAN in LIB_PERL{,_GEN} only if
> NO_PERL_CPAN_FALLBACKS is unset?
>
>  LIB_PERL := $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl/Git/*/*/*.pm)
> +ifndef NO_PERL_CPAN_FALLBACKS
> +LIB_PERL += $(wildcard perl/FromCPAN/*.pm perl/FromCPAN/*/*.pm)
> +endif
>  LIB_PERL_GEN := $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_PERL))
>
> I haven't tested that at all, so it could be broken in many
> ways.

Yes that's a much better idea, it evades the whole problem of conflating
the perl/Git* glob.
