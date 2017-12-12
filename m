Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 158D01F406
	for <e@80x24.org>; Tue, 12 Dec 2017 22:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbdLLW0S (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 17:26:18 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36379 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbdLLW0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 17:26:16 -0500
Received: by mail-wm0-f54.google.com with SMTP id b76so1581037wmg.1
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=lgvSxqNxW7CRqU1vqlTHRvb+OnuBdUBsxE7siLb38BQ=;
        b=Aw9FTm/vCYcL1qpaoJFV7W22d1IlibWOxZ4+18ACtyfNpsPA9rloCr9TfwrkjZApHt
         DGsuLsj1egnfw0TTMuTMRSlBWLQqcPgR49ZNZj/w90cGTzJe4HczR77BGloUwK5wF44u
         cF02UC73/9q8jTIpRfUmvGiT7YqYJfUQxw7EGY/csZhkwUT7zyq3ziX3wbXbffyRXTeg
         ZmQ/3z7FBZ8wM1Xgniqz4fEWR1x9EaYsjVVSaa0nGxAEd27CG11WYuWSguR/hMpKsMF7
         9S2r64nPw4a+pdN/SAG/MByiRXb73gS7PGw+Ezt9fh7g+b2gMSBJ9SNnfzijaFwVeS0l
         Abcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=lgvSxqNxW7CRqU1vqlTHRvb+OnuBdUBsxE7siLb38BQ=;
        b=IHIyg2j2ei2WekV/cS9nKP26E4WN7c4w6pcG05sOrOG6JRWte/yjHT8QyIXCY21XCb
         MHF78hLr3U2mlROpzVUIjBqffHMmz9HdYB/a9R11ZuOXDKH7WIlLl6YkqzynTx3pO4Nk
         Za2bIilA/IUYJY+0nOAVw8iI3ncKbQeTdZaoUpNDM3p9VZVro+3rstvuu1jDbCstytl+
         MzdxpYe7dIo4RqXNVrQBUuKYkZ0lf6CYKAHtGUobOhkOMm8OSSlFNZvNUTZCAhC3EzN+
         jx7p5B7+9AozkKc9feI4+G/yCjOg22WSD/IiXuJZTv8fknBZ6ewLicpYitLcXbmFh3jD
         C6Ew==
X-Gm-Message-State: AKGB3mL1zqJar+362zSSv4ZZPNFarV2sGnCQQFgLnWPK5MORyUrt5Hj1
        n7hWIoBP8wwdXcKMuwNQJs0=
X-Google-Smtp-Source: ACJfBos8mFtz+vZD6k97FNsCZ9uNey/KdOHLCkx4BIjM3JfZi4tFAO6+EDB8SzVg5w1/bNEsYObSjw==
X-Received: by 10.80.213.22 with SMTP id u22mr4773912edi.270.1513117574542;
        Tue, 12 Dec 2017 14:26:14 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id j27sm354604eda.59.2017.12.12.14.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Dec 2017 14:26:13 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eOt06-0006Gs-Nw; Tue, 12 Dec 2017 23:26:11 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org, 'Junio C Hamano' <gitster@pobox.com>,
        'Jeff King' <peff@peff.net>, 'Dan Jacques' <dnj@google.com>,
        'Alex Riesen' <alexander.riesen@cetitec.com>,
        'Jonathan Nieder' <jrnieder@gmail.com>,
        'Brandon Casey' <drafnel@gmail.com>,
        'Petr Baudis' <pasky@ucw.cz>, 'Gerrit Pape' <pape@smarden.org>,
        "'martin f . krafft'" <madduck@madduck.net>,
        'Eric Wong' <e@80x24.org>,
        'Ramsay Jones' <ramsay@ramsayjones.plus.com>,
        'Joachim Schmitz' <jojo@schmitz-digital.de>,
        Bill Honaker <bhonaker@xid.com>
Subject: Re: [PATCH v3] Makefile: replace perl/Makefile.PL with simple make rules
References: <20171129195430.10069-1-avarab@gmail.com> <20171210211333.9820-1-avarab@gmail.com> <003f01d37390$ed0e0440$c72a0cc0$@nexbridge.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <003f01d37390$ed0e0440$c72a0cc0$@nexbridge.com>
Date:   Tue, 12 Dec 2017 23:26:10 +0100
Message-ID: <87a7ynd1ml.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 12 2017, Randall S. Becker jotted:

> -----Original Message-----
> On December 10, 2017 4:14 PM, Ævar Arnfjörð Bjarmason wrote:
> Subject: [PATCH v3] Makefile: replace perl/Makefile.PL with simple make rules
>
>>Replace the perl/Makefile.PL and the fallback perl/Makefile used under NO_PERL_MAKEMAKER=NoThanks with a much simpler implementation heavily inspired by how the i18n infrastructure's build process works[1].
>>The reason for having the Makefile.PL in the first place is that it was initially[2] building a perl C binding to interface with libgit, this functionality, that was removed[3] before Git.pm ever made it to the master branch.
> <big snip>
>
> I would like to request that the we be careful that the git builds do not introduce arbitrary dependencies to CPAN. Some platforms (I can think of one off the top, being NonStop) does not provide for arbitrary additions to the supplied perl implementation as of yet. The assumption about being able to add CPAN modules may apply on some platforms but is not a general capability. I am humbly requesting that caution be used when adding dependencies. Being non-$DAYJOB responsible for the git port for NonStop, this scares me a bit, but I and my group can help validate the available modules used for builds.
>
> Note: we do not yet have CPAN's SCM so can't and don't use perl for access to git anyway - much that I've tried to change that.
>
> Please keep build dependencies to a minimum.
>
> Thanks for my and my whole team.

I think you should be happy with this patch then, and it doesn't add any
more CPAN dependency than before, and sets up a framework (as discussed
in [1]) where we can use more CPAN modules while not requiring packagers
such as yourself to package CPAN modules.

However, it doesn't sound believable to me that even on NonStop you
can't install any CPAN modules whatsoever.

That would also mean that this patch doesn't work for you, because it
means that you either don't have anything resembling a hierarchical
filesystem on which git can be installed in the first place (in which
case it wouldn't work), or perl doesn't have an @INC to search through
perl libs on on NonStop. What does:

    perl -V

Return for you on that system?

If this patch works, and if at the bottom of `perl -V` you see some
directories which you could write a package to drop some static *.pm
files, then you can grab a *.tar.gz from CPAN such as the one for
Error.pm[2] and arrange for the *.pm files contained within its lib/
directory to be dropped into one of those @INC directories.

It may be that some aspect of the CPAN toolchain is broken for you, or
even ExtUtils::MakeMaker, but you typically don't need that to package
non-XS perl modules, certainly not any of the ones we've discussed
possibly bundling up in git.git on-list recently. As a (very occasional)
contributor to perl.git I'd be interested to know if that's what you
mean is broken, and if so see if it could be fixed for you.

1. <CACBZZX58KpQ7=V8GUFfxuMQq_Ar6cmmoXyPx_umUTbU19+0LCw@mail.gmail.com>
   -- https://public-inbox.org/git/CACBZZX58KpQ7=V8GUFfxuMQq_Ar6cmmoXyPx_umUTbU19+0LCw@mail.gmail.com/

2. https://cpan.metacpan.org/authors/id/S/SH/SHLOMIF/Error-0.17025.tar.gz
