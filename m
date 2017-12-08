Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 493791FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 21:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753171AbdLHVQI (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 16:16:08 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:40629 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752572AbdLHVQD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 16:16:03 -0500
Received: by mail-wm0-f47.google.com with SMTP id f206so5086346wmf.5
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 13:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=CaTOkTIm6nMEl/hvxSTLLarB9VqS1wC+GD+D0l/abPA=;
        b=RmmXj7YieYDW7922K2A0Is7OOjNOc84XNntwuwN0oPHu9Bi40eFInkZcO+09qHMgHJ
         N4nGQjl4TO9Va69w0OVK0il+nKG+0p8e/TKshU5BEgE1aeZFKRdljfs396FQHd2Hag5Q
         KCiPDcVZZq2FSEBy/9h8RCJi5LlGDLSk6u5cIFvZJfa/C1WSPwlQysxLRX8o6B5kjo7Q
         YeQBFpsIRkGJjDujfYlmuxQubYQbMrA5Pt0vPcVqhwBTwdYu1jtRJ7TAgEL8GnZllHba
         4A/o5pWGq4ulY7QACiNmi3S8EBRkzNtkyhZOo53rKTfR64qgkLMw3cu5NDoj0JN/9fUM
         nX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=CaTOkTIm6nMEl/hvxSTLLarB9VqS1wC+GD+D0l/abPA=;
        b=rZnp5ITCiShQUcGpviPOmStAAQafKs9v+kvJp9NKnTZc7ZYmvCkp3dRg+/eCM8LZ5l
         nNsg5Faf6Qy7zm2H8myDY42U8jrVq+aj0QW96WDz1jbatRhWty4f5v48B6CZ5OZqG0T0
         PujdPsKTu5ErTjyLIBNJs1dtoQaaRM14f0PPr08sM8hCdclCuaKaMZZdSsgvt9/P4aAo
         9cRmNb6mHbj8Vw77o54PZCzI9SAPznlhvKQuK3pOmMOsor9Ns3ahPPLi4znyDhtFhsAn
         61MHGbe8kG4gVozvEzE2DodQvafN+B+sXfvXgEpVpsHfJi4QECivhZZpKdE4x2wTysA/
         XM0g==
X-Gm-Message-State: AKGB3mLF2XkaNqyL7ujGoH017hzzeQSmVtYI78CmbV/kw8j3g6pkpHdP
        Fvgce8UtvgAiZxC41qpW+JFve8W5
X-Google-Smtp-Source: AGs4zMZ4YWwHqJ2liXtAOA0OK+OWx9EV8uauWzoEyUElHqi4uB6lWYA4MhPibPpBxGJ4Gs2l4pphwA==
X-Received: by 10.28.170.75 with SMTP id t72mr4659654wme.15.1512767762104;
        Fri, 08 Dec 2017 13:16:02 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id r14sm8800810wra.71.2017.12.08.13.16.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Dec 2017 13:16:01 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eNPzz-0005LL-UW; Fri, 08 Dec 2017 22:15:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Daniel Jacques <dnj@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] Makefile: generate Perl header from template file
References: <f0ad1ad4-67d8-21e2-fdd0-0a08328c1eaa@kdbg.org> <20171205212625.6616-1-dnj@google.com> <xmqq7eu0j1th.fsf@gitster.mtv.corp.google.com> <e0a22ee4-9503-760f-293c-be56fa46fa04@kdbg.org> <xmqqd13rhewu.fsf@gitster.mtv.corp.google.com> <CAD1RUU8BO7J=rV6XgLZ0xN-ikLsanwqHVBnRE9468xVE5EEMvA@mail.gmail.com> <CACBZZX4JKhprF-3L3===XOBJ3Gp7W2xbeJshZFAmnjwevs0JoQ@mail.gmail.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <CACBZZX4JKhprF-3L3===XOBJ3Gp7W2xbeJshZFAmnjwevs0JoQ@mail.gmail.com>
Date:   Fri, 08 Dec 2017 22:15:59 +0100
Message-ID: <87fu8kex9s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 06 2017, Ævar Arnfjörð Bjarmason jotted:

> On Wed, Dec 6, 2017 at 7:56 PM, Daniel Jacques <dnj@google.com> wrote:
>> On Wed, Dec 6, 2017 at 1:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> Johannes Sixt <j6t@kdbg.org> writes:
>>>
>>> > The updated series works for me now. Nevertheless, I suggest to squash
>>> > in the following change to protect against IFS and globbing characters in
>>> > $INSTLIBDIR.
>>>
>>> Yeah, that is very sensible.
>>>
>>> > diff --git a/Makefile b/Makefile
>>> > index 7ac4458f11..08c78a1a63 100644
>>> > --- a/Makefile
>>> > +++ b/Makefile
>>> > @@ -2072,7 +2072,7 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES perl/perl.mak Makefile
>>> >       INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
>>> >       INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
>>> >       sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
>>> > -         -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' \
>>> > +         -e 's=@@INSTLIBDIR@@='"$$INSTLIBDIR"'=g' \
>>> >           -e 's=@@GITEXECDIR@@=$(gitexecdir_relative_SQ)=g' \
>>> >           -e 's=@@PERLLIBDIR@@=$(perllibdir_relative_SQ)=g' \
>>> >           $< >$@+ && \
>>
>> Sounds good; I'll apply that to my working patch and include it in my
>> next ("v5") submission, which is currently blocked pending avarab@'s Perl
>> Makefile changes:
>> https://public-inbox.org/git/20171129195430.10069-1-avarab@gmail.com/T/#t
>
> Thanks, FWIW I'll send another version of that at the end of the week
> or so, I'm waiting to see if there's any more comments on it to reduce
> list churn.

Sorry, I got this conflated with my sha1collisiondetection series, I
have nothing new to send out.

It seems everyone's happy with the version of my v2 (with Junio's
<xmqqzi6ympi9.fsf@gitster.mtv.corp.google.com> on top) from this series,
so it's just a matter of waiting.
