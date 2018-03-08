Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F8CD1FAE2
	for <e@80x24.org>; Thu,  8 Mar 2018 08:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935082AbeCHILi (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 03:11:38 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:52230 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755117AbeCHILh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 03:11:37 -0500
Received: by mail-wm0-f51.google.com with SMTP id t3so9522385wmc.2
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 00:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BeSMU9pFq8qLvKwojDc8q61H6O/z5s4v5odOgVJBgmc=;
        b=HfolOShsO/I9LYNDT+STpk2tPYG/ROAq21uNz60N0KDVcxZBZ40QyC2MqKu/WWW2bV
         IijvfdcrHhCBJjF6VSWaL+3UMNKX7ISr4eixGzvu0hYcuybOeaFHLEx+XTTas98mtqDb
         rOML5zMciP3dmgt+TKEDBZkUtbL4y+c/28mxUGF8bxohvE4Sa7Ju9cF7tZ/iRzdmDeEg
         WgWZ2SZOHR0IOB/Jg8W+tDe8OSJM/lDjHmGY3P/eEF784nP/voHB6PTBEj5HmnMx8PSc
         1ZfT6DfAuSw64LtYQZoz81D6erk/IyG9/Eq2iH0Wzb2wDNz9cmAtJ2rDhkd7rFVSMt7b
         gtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BeSMU9pFq8qLvKwojDc8q61H6O/z5s4v5odOgVJBgmc=;
        b=CeWnN9ILCRKCAbsOCRKdJhNWDilwQmda9kcGGHKspc8qX23gmuvPj2TY3yzj6adGS6
         900MGRQm/1dm4BeYYirWaC8ererv8tg/nF1qVT+83fAv5CLtUgamL5wRtQJcl5s3fTVL
         Nr/pTdCOgThIzpJX3FkFgEGu6LhgVznfXzQ2egLLoUleXvS5V/DaYmw7iaBP1lDcRWCy
         EoEYBBc1xpyBGuv/J3fnRsrsNECtowPsyx81oM7PxWsTMEQGb/KEwV6MPcGbVzIK5VYr
         p5bARPmYr0xosY11ywmovOmhtbhSFUSgXeRvAtjAkHsB7UcvNydtEqrnfD0pEXZi74Gg
         pMnQ==
X-Gm-Message-State: AElRT7EsJKrhaPUuy6V5OX1ALRdza1MRuzfEry/zoka2By6yG2glk+Eu
        7YzJ9GkRUOv5mIoaxjr7ezAFaqgk
X-Google-Smtp-Source: AG47ELs3XcL+i68/e+Gl4C0SFcuZ7lR1cS+p2sRvQu5RGkbqWXMvr50AqWhyAq24mWzFDk0dFke0sg==
X-Received: by 10.28.67.65 with SMTP id q62mr15100394wma.110.1520496695573;
        Thu, 08 Mar 2018 00:11:35 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m15sm17766447wrb.58.2018.03.08.00.11.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Mar 2018 00:11:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution(RoadClear)
References: <87y3jtqdyg.fsf@javad.com>
        <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
        <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
        <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
        <87606hoflx.fsf@javad.com>
        <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
        <87a7vss6ax.fsf@javad.com>
        <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
        <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
        <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
        <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
        <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
        <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
        <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <xmqqzi3k23fu.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1803070804440.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <xmqqh8pr21f3.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1803080801230.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Thu, 08 Mar 2018 00:11:34 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1803080801230.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Thu, 8 Mar 2018 08:03:32 +0100
        (STD)")
Message-ID: <xmqqfu5bx9zd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> If we are talking about a drastic change, a few more days may not be
>> sufficient, but we are not in a hurry, as this already sounds like a
>> 2.18 material anyway.
>
> It is not at all a drastic change. It will actually make the current patch
> series better (simplifying the "can we fast-forward?" check).
>
> I just want to make sure that I already have Phillip's strategy working,
> but it will be yet another topic branch on top of the topic branch that
> will add support for octopus merges *after* the current --recreate-merges
> topic branch ;-)

Oh, if the "not redoing the merge afresh, but attempt to reuse the
previous merge" that was discussed is going to be done as an
update/addition to the "redo the merge afresh" you already had in
production forever (and I had in 'pu' for quite a while in various
polished-ness during iteration), then I do prefer merging down what
has already proven to be 'next' worthy without waiting for the
discussion and your local verification of Phillip's new thing,
especially given that you'll be giving an explicit control to the
users which variant of "merge" insn will be used and the addition
of the Phillip's thing won't be a backward-compatibility issue when
it comes later.

>> As you made it clear that it is OK not to merge the current one for now,
>> my objective of asking the question is already satisfied ;-)
>
> Depending how much GitMerge will occupy my time, I hope to have something
> polished by tomorrow.

My "for now" above was just for the coming few days.  Don't rush
things, and use valuable in-person time wisely, and have fun.

Thanks.

