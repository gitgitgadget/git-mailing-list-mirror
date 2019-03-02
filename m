Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB6B5202AA
	for <e@80x24.org>; Sat,  2 Mar 2019 03:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfCBDfv (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 22:35:51 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46446 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfCBDfv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 22:35:51 -0500
Received: by mail-lj1-f193.google.com with SMTP id v16so22153140ljg.13
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 19:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v8Qbti8gcB+Xg38b6JvCD6xiOot64nBQFV349b8ph00=;
        b=F8m1L3Un14xvnmUMJ6gOO1h1JZtq/kaXeeXmAjGY+SoYys5f0OAVJ9diKH4dcLq9Kc
         PxknwcKdLpifcabYYt9gytxoj2bsoZcqy2TwLZEFW0o1+8DFt5WUAoEUxcMgkYprhuZa
         kb9vBotDO1TdZ3kGxVmsUhCr29HEECf8pIA8xg7UQicRT9VdRbMUDLjPQpos8Yqg/noH
         YTRjitDoI7+oz4mFSbAdy5yTQLDjiiUiD58Xi3Q37Jt/sqBTTQqi/cTPlFNsEcyL9HDU
         /vTtCdw737RGLcjlAdQEVdfxvW2F4FDrIAWaGZbNTyO4UHSAe4VwaCXcWIKhZlYy+ZYt
         5SQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v8Qbti8gcB+Xg38b6JvCD6xiOot64nBQFV349b8ph00=;
        b=RGXC9gxuD1HOW5RiWBWcoy6XpTeEmjoo0HcZXXG88JO28jzU/BDaKQKwsq/q0LRXSq
         Yrd8EFniAByqKiLdy2FARrumWBtJ4pdBPDJ0yOvHNaQaTSgFrcVoQ2Kht+Yz9scQAcQr
         wEPPuLNrwdfrAtxx1Cfojoemiuo0A8iZdEfQugDPoPbAhPl7RIsgb3ltwb6ELmX9fvST
         F9QmZqlaXntGDParz1dkOoiQllBmUF9l6wotW+aOng5CQLVo/o/QK1uJ3QGvCQRithkk
         +qzOjJEcgDozQekOpxdw5ju0kfA38tf898YWTneMvBUss54I8Yyunl27/QXPe8s9fPBl
         hz7Q==
X-Gm-Message-State: APjAAAX9fKsxKZYisxQ5dMmFVNamr8ZTmI4f5STTNtzqFUwdoe1KwUO6
        hmcbzTRamZT8eMQ/Qc6k2KsuWVggXGSikWr1+AE=
X-Google-Smtp-Source: APXvYqwifAour5rh4yFTSbM2vpVUat1ElxxfF1j+F5urkI83Q7ZoxC8TJB2e79pH4rD3nn+2K2OIQpiHEvFxRx/qS9s=
X-Received: by 2002:a2e:9105:: with SMTP id m5mr4743505ljg.100.1551497749343;
 Fri, 01 Mar 2019 19:35:49 -0800 (PST)
MIME-Version: 1.0
References: <20190301171304.2267-1-brandon1024.br@gmail.com>
 <20190301190954.GG30847@sigill.intra.peff.net> <CAPig+cQoZQCTAzaDiaAdAvSqHBHSoapDoVLjPtpKjCEVSBL57g@mail.gmail.com>
In-Reply-To: <CAPig+cQoZQCTAzaDiaAdAvSqHBHSoapDoVLjPtpKjCEVSBL57g@mail.gmail.com>
From:   Brandon Richardson <brandon1024.br@gmail.com>
Date:   Fri, 1 Mar 2019 22:35:23 -0500
Message-ID: <CAETBDP5vU7DAAT+qgr8bBukYy2YxABPXO0WTrr+gEfdw1_4mEg@mail.gmail.com>
Subject: Re: [PATCH v2] commit-tree: utilize parse-options api
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Fri, Mar 1, 2019 at 3:53 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> Note, in particular how Peff used !(arg) rather than (!arg) in your
> patch. This distinction is subtle but important enough to warrant
> being called out. The reason that Peff did it this way (the _correct_
> way) is that, as a macro argument, 'arg' may be a complex expression
> rather than a simple boolean. for instance, a caller could conceivably
> invoke the macro as:
>
>     BUG_ON_OPT_NOARG(unset, foo || bar)

Thanks for pointing this out. I caught this shortly after I submitted
v2. I hadn't
considered that the argument could be an expression. Will fix in v3.
