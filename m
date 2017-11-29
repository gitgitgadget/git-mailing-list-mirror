Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1F2120A40
	for <e@80x24.org>; Wed, 29 Nov 2017 21:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbdK2VNA (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 16:13:00 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37765 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752418AbdK2VM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 16:12:59 -0500
Received: by mail-wm0-f52.google.com with SMTP id f140so8628544wmd.2
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 13:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=cdiXOsLbwsANykBmNnxEwVgUqKGhiflD445bQK0dPYs=;
        b=lmdGcDVqeGN74dbFdNaUde+Y9/Cq8OXn4HFEgsX0vkIgfPgLbAqGlqjgYEXmDYXI2p
         rr/DwZISO4z0jqi76GRsAMPoZKG/l1HDM3sbVzV3Vh4HLaZQ1Mragig3WDjmKHLG1GyO
         Qp0MjUch+hQyYKOXgHK65iJeeyeCKMmjALeiSeje48CYKaUyAq0J08Tixtr3UQdqU63J
         kwsKPwEqJKBvzFpB7MhcQwGEt1YMJChISUqHQ24Q1MdpXpvVsBsH4ufsCwBSmSOXiMXx
         ITCl78bafV6BlycZvKvuKyCkiQjyqrKgZ06n9wb3Ulc3NLvo2h3B2SH9sC8muhC8r6qO
         wYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=cdiXOsLbwsANykBmNnxEwVgUqKGhiflD445bQK0dPYs=;
        b=E4M9i5+l/iW3X52oj/w0Gxb5BLdWom39W5ud1sOZBeN3BH9uhG5JXULmaycx1JiyFa
         V6lLZLzGlkPRKTr2Dib3PWRlAzaONqcvwIiIktdORlqdgsHti32iw6FFbTVwGKwmG19K
         fDusoNKPPB8jat8aoC3tFUfogRslBT5utnsWc0ZKAq2QDskwYKlKr7PJMWO2fytauXv4
         RgYSngK4bX3lam8n+asL81df2AacRFw0iWTqcxqs4v0e9h0Ml83l1abv8fAIPSzgKnd/
         G0HPh5XeHRw1TNnMhp3Sbo2kTAVcW8ZFO6Hvkq3Ixfp6cyEfk0qGLhq/kDG4NvMkBVIF
         g3Qg==
X-Gm-Message-State: AJaThX6wMaFikACexvwLyuj1zbBvR+zVDHI/NVtvcJPTl9ScaxyWFBFh
        uqobhlzoiYOFnWASOVdkpa1aamTt
X-Google-Smtp-Source: AGs4zMZiq7FCHUgvAxzTpZVVA54bKt9rFm53yej+b8qu5JkXkoBzNXe96pqBnhc9i14xyDYG0KmzJw==
X-Received: by 10.80.138.99 with SMTP id i90mr9850201edi.207.1511989978253;
        Wed, 29 Nov 2017 13:12:58 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id e29sm2300986edd.44.2017.11.29.13.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 13:12:57 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eK9f5-00007B-Qv; Wed, 29 Nov 2017 22:12:55 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dan Jacques <dnj@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v4 0/4] RUNTIME_PREFIX relocatable Git
References: <20171129155637.89075-1-dnj@google.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171129155637.89075-1-dnj@google.com>
Date:   Wed, 29 Nov 2017 22:12:55 +0100
Message-ID: <87h8tcvlew.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 29 2017, Dan Jacques jotted:

> This is a small update to incorporate some Windows fixes from Johannes.
> At this point, it passes the full test suite on Linux, Mac, and FreeBSD,
> as well as the Travis.ci test suites, with and without
> RUNTIME_PREFIX/RUNTIME_PREFIX_PERL flags.
>
> I'm happy with the patch set, and feel that it is ready to move forward.
> However, while it's been looked at by several people, and I have
> incorporated reviewer feedback, the patch set hasn't received any formal
> LGTM-style responses yet. I'm not sure what standard of review is required
> to move forward with a patch on this project, so maybe this is totally
> fine, but I wanted to make sure to point this out.
>
> I also want to note Ævar Arnfjörð Bjarmason's RFC:
> https://public-inbox.org/git/20171129153436.24471-1-avarab@gmail.com/T/
>
> The proposed patch set conflicts with the Perl installation directory
> changes in this patch set, as avarab@ notes. The proposed Perl installation
> process would simplify patch 0002 in this patch set. I don't think the
> landing order is terribly impactful - if this lands first, the patch in the
> RFC would delete a few more lines, and if this lands later, patch 0002
> would largely not be necessary.

In general this whole thing structurally looks good to me with the
caveats noted in other review E-Mails.

I haven't done anything but skim the details of the "where's my
executable" C code though, just looked at what it's doing structurally.

I think it makes sense for this to land first ahead of my patch. This is
an actual feature you need, whereas I just hate our use of MakeMaker,
but that can wait, unless you're keen to rebase this on my patch. Would
probably make your whole diff a bit shorter.

The whole converting our absolute to relative paths in the make code is
unavoidably ugly, but after having an initial knee-jerk reaction to it I
don't see how it can be avoided. I was hoping most of these paths
could/would just be a fixed path away from our libexec path, but alas
due to having had these configurable all along that simplicity seems out
of reach.

Maybe I asked this before, but I don't see any obvious reason for why
RUNTIME_PREFIX_PERL is a different thing than RUNTIME_PREFIX as opposed
to us just doing the right thing for the perl scripts.
