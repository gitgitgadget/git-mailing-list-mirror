Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 943011F424
	for <e@80x24.org>; Tue, 17 Apr 2018 07:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752116AbeDQHdO (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 03:33:14 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34391 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbeDQHdN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 03:33:13 -0400
Received: by mail-io0-f182.google.com with SMTP id d6so21240747iog.1
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 00:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+tIeFOQR9MGB4jPyewYVdqTomcWo2vEevT1pY4TUeRk=;
        b=ZyW+y5O3aoiI7GzTo9Cq+4xh18736j8P4s7lkswDP9nNn1oRIRBUl26wgBBj7WTmmS
         7p/338hYJGAmgD3Eb6hsEba1+nIa/Av/QKMFL0ipaOFnGRXv5XDOP4spw4KRObzjtVmp
         mLw+Mq2iBC5xpbQqF/eYrK8DkZYUWFqXPHNBdDnhQjx65RfgrRRko4jKEt0rauzWTMQG
         txqdcmzjYpkV2vrT33xmdNr2C4CN2G75YylZHTbSTegMnvykgMw2DWImbMH+5/zZF7Dw
         IJoDhpQx5GKMyjAqSbsJFjDrXt9KscASoXc0vBJMlZSiN+Z1/zRcR6Z0Km9o4tPiiYoa
         tvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+tIeFOQR9MGB4jPyewYVdqTomcWo2vEevT1pY4TUeRk=;
        b=Vn6NDvc3ZLoMUt8TdfP3lwJaZSMEOgf2cbwY4JzaPFPkF4BKFbarwnP/58wuOBRxon
         Vh+7NTAtOcnXz+I0f9IQemA+YG+Fh7n27WKRZJckpBq3Tqc3YAS0VfovtXgyZeSQkMSA
         cn959baP1i6awe76wEk+k1sIOw6c9Wa79pgM8z80JFMbnYK6Ao5UCaJ09eNgWPX+BzXf
         at0Dgox7FoGm3AAB9SfuHjCKukqr1Y3KRjBs6IU7d4LyWxOvexZMPfL0WnXZy42QmQWJ
         NZSQk9v/Km7jsDAF7CzWeyne392nmjXY/raRQrvyuzx4OR9fhlRtr/UXvo8SkY7NAO0r
         O3gw==
X-Gm-Message-State: ALQs6tAgvN8wUnVe/r4Kb8XtVpLMS7fWvfDZZBeD9pRZu+mztpna6gY7
        jKEPH6VnLTnZ1Vbe/Xgio8LaIqrCBN/lxk2xlyE=
X-Google-Smtp-Source: AIpwx4+aSYcqevibdekgsJhbFYC4hmCZHI5B49cnjzIr4MK0iFbWcRwfXs3NUYtuXzcXIF3n32LienTid/uRExAWEgk=
X-Received: by 10.107.144.11 with SMTP id s11mr853454iod.223.1523950392520;
 Tue, 17 Apr 2018 00:33:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22db:0:0:0:0:0 with HTTP; Tue, 17 Apr 2018 00:33:11
 -0700 (PDT)
In-Reply-To: <c805a84c-a29e-6652-d644-ee1ccf4c7fbc@gmail.com>
References: <CAP8UFD0DagacfeismKoVgo=O1guRUV=u1=EbbwRyrY3g1MeQ8Q@mail.gmail.com>
 <CAP8UFD1vFM8k-1Po=2QXZdBOuCca1Dg_FGaPnSi85hKp1je54w@mail.gmail.com>
 <87in8rz65t.fsf@javad.com> <CAP8UFD3JwHfyr=bByvjDrxboFL+yHVdZnbkXztsUuOU0aRD-9w@mail.gmail.com>
 <87sh7v6vn4.fsf@javad.com> <72f42205-c9c6-03aa-e8df-12e7062e8e62@gmail.com>
 <CAP8UFD34Y0KRY7vqXU_jWGUc3tdDHB1h67ARZxi_vk1EyUV+zQ@mail.gmail.com> <c805a84c-a29e-6652-d644-ee1ccf4c7fbc@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 17 Apr 2018 09:33:11 +0200
Message-ID: <CAP8UFD2h=_jHzCjaFgQwm_RqpYF1ditPbBB6FybB2V6Fw6boXQ@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 38
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Apr 17, 2018 at 4:17 AM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> On Tuesday 17 April 2018 03:56 AM, Christian Couder wrote:
>>
>> Thanks for your comments!
>
> You're welcome!
>
> I'm sorry to say that I read only part of the draft  when I sent my
> previous email though I accidentally didn't mention it explicitly.

No problem.

> Now that I have read the draft completely I find a few typos in the
> "Developer Spotlight: Jiang Xin" section:
>
> 1.
> "... because I feel it is hard to track changes of GitHub UI and the
> book will become obsolte very quickly."
>
> obsolte -> obsolete

Yeah.

> 2.
> "We also developped ..."
>
> developped -> developed

Sure. Both typos have been fixed. Thanks!

> On seeing the section "Light reading" to be empty, I thought I could
> suggest something. I'm not sure whether you take Stack Overflow answers
> for a light reading but I found the following answer to be interesting,
>
> https://stackoverflow.com/a/6521223/5614968

I am a bit reluctant to add random SO pages to this section. I think
we have used it to suggest real articles and I would prefer to keep it
that way. Maybe we could add another section with links from SO or
other Q & A sites, but until we decide to do that and find people
interested to regularly contribute to it, I would prefer not to add
such links.

Usually Jakub Narebski (in Cc) and a few other persons contributes to
the Other News sections ("Various", "Light Reading" and "Git tools and
sites") sometimes just before publication time, and I might contribute
a little to them too this evening or tomorrow. So it's not a big deal
if there is not much in these sections at this time.

Thanks,
Christian.
