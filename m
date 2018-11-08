Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 801B61F453
	for <e@80x24.org>; Thu,  8 Nov 2018 17:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeKIDRD (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 22:17:03 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42860 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbeKIDRD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 22:17:03 -0500
Received: by mail-qk1-f195.google.com with SMTP id m5so4229265qka.9
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 09:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FCYiy+NMMYPq5dMpKltcOEvPknZX2zXVogz8dAYuYfI=;
        b=MKwBYpLopAwrkmgBqPOY0u5AeCIRhvEiuG1+n3FJAceP8iNUTQspprQrPum51Deh4V
         MCTI5RXk6/nDUPSy1dPX7tGOSPezGIR8Zo2JAQ58rry1A+qcAlPRjLcUO02GArKjbmCI
         PI6bUcsYyNRrFnpVHel5PI1EP6/DC7doJh52C3A52Fjn1UMC9LcbirBosqvXvt+VhnO7
         H334xG59WnRkWxDqx8ygR4Zu1iJyJfUFmIl1zHnMXO9bJzh4d8zd+MTJflfalel+kihy
         Z6F14A5eeKGofyvg8fqbCzHPMx1xH13mLiPqVUMyAp4tnD8oKYkchuBkfi0TIZ3+uUHB
         TMLA==
X-Gm-Message-State: AGRZ1gKsndO0zgPBoL+ID/NYaN6l3R/Yl69aEL+8Fmb8ry74CdgaN2lV
        vYlZuSHcx+pNoeVATh0xxBtg8L/cZgt6RIjNLB0=
X-Google-Smtp-Source: AJdET5cVEW8VdpWWErqqCmqXBLEIUZcFvSOQ2cho8Kpx5lVFzwq7JtKeoYYDR5Bf5LbUGU0m/O8umtweR9cr8ZWwSiA=
X-Received: by 2002:a37:9584:: with SMTP id x126mr5152832qkd.36.1541698829078;
 Thu, 08 Nov 2018 09:40:29 -0800 (PST)
MIME-Version: 1.0
References: <pull.66.git.gitgitgadget@gmail.com> <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
 <a374e4bb-1970-9ec7-fe94-a273f1206d6b@kdbg.org> <nycvar.QRO.7.76.6.1811071222200.39@tvgsbejvaqbjf.bet>
 <efd57458-07f6-2813-483b-dc7fba785dc0@kdbg.org> <20181107204142.GA30078@sigill.intra.peff.net>
 <e7ff6f22-fe5a-3cca-9305-2c8a6fb55d45@kdbg.org> <20181107220320.GA8970@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1811081408310.39@tvgsbejvaqbjf.bet> <CACsJy8AdRqKKFFO80p8jdMGaH6+Pj833nUEd7Xe6SWLQB=80UQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1811081639210.39@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1811081639210.39@tvgsbejvaqbjf.bet>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 8 Nov 2018 12:40:17 -0500
Message-ID: <CAPig+cQMR8PGhtQUTtdshNy80Ej-L2vT8_3yHXm=jCM58_fAjQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>, gitgitgadget@gmail.com,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 8, 2018 at 10:45 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Thu, 8 Nov 2018, Duy Nguyen wrote:
> > One thing I had in mind when proposing $VARIABLE is that it opens up a
> > namespace for us to expand more things (*) for example $GIT_DIR (from
> > ~/.gitconfig).
> >
> > (*) but in a controlled way, it may look like an environment variable,
> > but we only accept a selected few. And it's only expanded at the
> > beginning of a path.
>
> I understand that desire, and I even agree. But the fact that it looks
> like an environment variable, but is not, is actually a point in favor of
> *not* doing this. It would violate the principle of least astonishment.

Perhaps something like $:VARIABLE, which gives the convenience of
$VARIABLE, but looks sufficiently different that it shouldn't trip up
readers into thinking it is one. (Well-written code checking for a
DOS/Windows drive letter at the beginning of a path shouldn't be
confused by it.)
