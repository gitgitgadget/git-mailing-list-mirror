Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 299A81F45F
	for <e@80x24.org>; Sun,  5 May 2019 18:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfEESJm (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 14:09:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41527 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfEESJl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 14:09:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id m4so12709447edd.8
        for <git@vger.kernel.org>; Sun, 05 May 2019 11:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Fbba7wbpI9ieScK/hxWNb9zaOQmuy9NPxThstMpRpk=;
        b=klSPBk48XYIQKM959ncJpl8H6pfjEZTfZPTECekvGoY1q/mHyG7kI+agaQAtiP3CJb
         bxStQ9r1u8tDCP8p90JANyBuaB4C0Vs0wOll8IufXcouwtvX24AnHswGeZqfVRCqjmbd
         xUJsZh6nLXnjWDDaAWry+MwO5hj34qT7i8qIgCdVQqhd9zMUUbAWXoqVACoYCbaFFVLb
         /Gk4fLy2zohuaqPmq0P1rASizilZHTEGWHexnv76zl7/JxCpU2kFGnUccAplgMTzKd2s
         r17N0er94plxjJSB5yzjXkZm0yXnk65+BnC9orGVs4W+Fa0owN10XOZnCPVNK9UFameo
         0DRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Fbba7wbpI9ieScK/hxWNb9zaOQmuy9NPxThstMpRpk=;
        b=deAtrF+NDgO9FtPjkMCGTSxs052wvobDSaZBpSjsyMxHg8G5Ore5/dDd0/twApURLe
         y9PRzfCvYCo9cucuHQBzI6qhHy7vRKqovVJ8+uDnMBLGp/027jES+BgQWT9D1oS2xsOx
         qksEslXOkdxefbGTJu3dY4CPV5YEpkMzXypT8SbLPOGOuAjXQCUFt6LALvDyse2Bk7Nm
         guWRvVHUz7pHuJZtv60X5wE+OlUCnmv3Ld++v0BfQyBr+2qHzHWo97o8wfcf3u5rNRX0
         RVisM+Nh1f/ybxDLrwV3sjbn78moJbze+YV1b45hqRpiAoFD1GDhq3CiEG1NBWZmo8wX
         dVKw==
X-Gm-Message-State: APjAAAVvSY7MiBLBl7lm/e5NqAUsz5nPTRdn7s1UN1cAQ5UxJUI6qQPL
        pBhru+Az9BxojiLbDQXjGpbvew6mQWDPI68Ni0Q=
X-Google-Smtp-Source: APXvYqzIG7GBcoOWAbm6fyXh+sZsB0nA3OjRtxtLZn7A/urqQNjvdx0vvl6NHxs95mmCxMeTU/vyYyPOVDrNRu6ByXM=
X-Received: by 2002:a50:8965:: with SMTP id f34mr21443776edf.296.1557079780248;
 Sun, 05 May 2019 11:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555352526.git.liu.denton@gmail.com> <cover.1555487380.git.liu.denton@gmail.com>
 <20190422214901.GA14528@sigill.intra.peff.net> <20190425120758.GD8695@szeder.dev>
 <nycvar.QRO.7.76.6.1904301919580.45@tvgsbejvaqbjf.bet> <20190501100108.GA8954@archbookpro.localdomain>
 <20190502000422.GF14763@szeder.dev> <nycvar.QRO.7.76.6.1905031127170.45@tvgsbejvaqbjf.bet>
 <20190503144211.GH14763@szeder.dev> <20190503174503.GA8242@sigill.intra.peff.net>
 <xmqqo94hsc63.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo94hsc63.fsf@gitster-ct.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 5 May 2019 11:09:30 -0700
Message-ID: <CA+P7+xonqw76E4FU3NX7gGafWy3YAcyeQgvYsPjgBvUh_KD_=A@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] remove extern from function declarations
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 4, 2019 at 10:28 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > I think spatch is smart enough not to hit the same header multiple
> > times. But the problem is that we invoke it once per file, so it
> > actually processes cache.h many times. That's slow, but also produces
> > bogus patches.
>
> Yes, I've seen this and was a bit irritated myself, but not enough
> to do something about it myself, yet.
> >
> > Jacob Keller's patches to collapse this to a single invocation do fix it
> > (and I've used them selectively in the past rather than cleaning up the
> > resulting patch manually ;) ).
>
> Ah, that is nice to know.  Do we want to resurrect it?

I remember deciding that the memory cost trade off was too high back then.

Thanks,
Jake
