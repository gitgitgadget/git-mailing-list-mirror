Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AD5C2BA15
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 01:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2E8206C3
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 01:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgDEBeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Apr 2020 21:34:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37270 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgDEBeE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Apr 2020 21:34:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so13215031wrm.4
        for <git@vger.kernel.org>; Sat, 04 Apr 2020 18:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+vi9q5706ZXOKUacVvGzCUUFJbz7q/PgyQjsSH19rLk=;
        b=pAqjIepwMazWTJjmoFrGUxUaj9BIRP/SXCEO23EbG7KIqwuFx5RxaB7N9Mmcecycgl
         RtcCNw3+GtUMkRHcaAKenUu2s2m+DDc4F3LQKjk17o801NB8zUFW66d6mD3w+cEaakId
         D9LtThgJDXh51ykrPKCgf0F4CXK9kY86goo70MFiGadNK4IHKwLzYevl8vQIf65dMW90
         +/rQO0wLJbVebQ95yK2x/uCQueeLkZxN8DA0IhpVnj6aVn6KeTSLxFFT5S/GSVbLBZkx
         Tv4C2tVc1MgK4KkmlO9On5/rgCcD9vALk+VruEpsXxpACJv+YfGLM7bwtXT93Pbuc6kJ
         3Abw==
X-Gm-Message-State: AGi0PuYa3mSYAgehnd7nBqY4gEj1cFdlZwMClNtRekfiqG+KnktU2dC8
        yAjyVqJOlCEi/ySzfZWz3QOA2N2RkOckI1IHrHA=
X-Google-Smtp-Source: APiQypJ7cicyLbcksX+ULTgf0e5Thx6VcDzoWR3MuDoNDwCyuJK8B8Gcc5Q2IbyI+Vbrp73sLgn/VpW/z4XYtPi4X5s=
X-Received: by 2002:adf:94c6:: with SMTP id 64mr16863223wrr.386.1586050442561;
 Sat, 04 Apr 2020 18:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200326080540.GA2200522@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2004041535360.46@tvgsbejvaqbjf.bet> <20200404145829.GB679473@coredump.intra.peff.net>
In-Reply-To: <20200404145829.GB679473@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 4 Apr 2020 21:33:51 -0400
Message-ID: <CAPig+cR_ViZ2GWSs=grT=5bzQq44w+AAbXFsZaM_-CVMCELXQw@mail.gmail.com>
Subject: Re: [PATCH] Makefile: avoid running curl-config unnecessarily
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 4, 2020 at 10:58 AM Jeff King <peff@peff.net> wrote:
> This is our first use of eval in the Makefile, but that goes back to GNU
> make v3.80, which is from 2002. I think that should be OK.

Upon reading this, I was worried that it might trip up Mac OS which
has (often very) old versions of tools, but it's alright in this case,
as Apple ships GNU 'make' 3.81 from 2006.
