Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B1692022D
	for <e@80x24.org>; Tue, 21 Feb 2017 20:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751462AbdBUULM (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 15:11:12 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33973 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751397AbdBUULL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 15:11:11 -0500
Received: by mail-pg0-f68.google.com with SMTP id s67so9255665pgb.1
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 12:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eiG74z3Zok9J5FGkAqlZYDLiP+07Lyp5j1d1soibcnQ=;
        b=VKBnJleJFkRmsN9qEMtuPeoSwujTpV1qnSBsMLTaHTUOtqtdjuGiP2oWxaNmmItGvA
         +rnAA4VI+SpAQGp8/INialkLsrviDUljAoHBLdY94w270GRBd3XmhUuSDsgmEUGQjItF
         f6e67SsZbndg1b8zBuhOknu2cNrZ1QCOXze/F7zwwDEB/unq79lMul9qOdcMN8gpNg0+
         yvB45Vo5qg9IFgWjclRrdEz7zoxzCixcls0f2Rp4zMw2/3+u4L4G52pOC0fzTZk9Ibqt
         Gz3BCSBxT2n0oelHv7Q3jyjk/c4NuCivp/hnRHsJW7YUmbLjnrUPzVEcyZUP/GPsUvYR
         VH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=eiG74z3Zok9J5FGkAqlZYDLiP+07Lyp5j1d1soibcnQ=;
        b=it1T0C1R4kCQSeOxJHm/q1tqDCRzSmYeWAsktwgfy0ph0OoYE9AWl/GLzMSxhTfQxZ
         7PI1w8CvbZzYaiOtnun4k3cba0NlvwpcfNk9nosrz+PnZD36MGjHEZAuHV2iAnDVbhe4
         vecCdzcCW1xUOx7m7dnsTAqXciF5DT0XiwCQME1A/dB+2D42ddO+tfK78fwmG7ByO14p
         D/OriVHGFZDxJ9+N+mLdaO3ZxShu+BIsUyse5AAuHpgbEi7n0h94LRks8IWcdXX2Tkf0
         OBnjiDgCWemUCorcWJnF+WFdstdlTBUgybReym7kS1KCk4cc9Wx36wZCitOG10zaGmvL
         QJ9Q==
X-Gm-Message-State: AMke39koa9BUHFsih/GQ5Jk87J9BTbj1lCuX1OsycxLplY6HLFy3jfRmHih0P7BuuBt5XQ==
X-Received: by 10.98.194.22 with SMTP id l22mr35202085pfg.178.1487707870299;
        Tue, 21 Feb 2017 12:11:10 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d997:8b5d:f579:2a90])
        by smtp.gmail.com with ESMTPSA id 73sm14691814pfh.56.2017.02.21.12.11.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 21 Feb 2017 12:11:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] show decorations at the end of the line
References: <alpine.LFD.2.20.1702110943460.31350@i7.lan>
        <CA+55aFw2S14a4_4YK0b6PNK4TH_AUo_+2JN+PTyBTufNeB5t6A@mail.gmail.com>
        <xmqq1sv2fq6m.fsf@gitster.mtv.corp.google.com>
        <CA+55aFy-vvOBu5Y4KDeteUyK-7U7yTa1HoqHo+hME1=8bq7Xhw@mail.gmail.com>
        <xmqq7f4tdcua.fsf@gitster.mtv.corp.google.com>
        <xmqqr330779h.fsf@gitster.mtv.corp.google.com>
        <20170215002901.gtzegvhyy7d6cvrb@sigill.intra.peff.net>
        <xmqqefywnk5a.fsf@gitster.mtv.corp.google.com>
        <CA+55aFw3ZRtgsLGW-TFqpq-3uCw55L42p7cF=Q-73qM_VPuYsQ@mail.gmail.com>
        <CA+P7+xqtPwzt3J6O05TP=E_hh-ko97adn+__Zmc0DNSDqEnEHw@mail.gmail.com>
        <20170220004648.c2zz6bm2hylvep6x@sigill.intra.peff.net>
        <CA+55aFwdUxCvmi28T3yn1K4rqn2bZmJBdTRr7tSbMa-g5izHbw@mail.gmail.com>
Date:   Tue, 21 Feb 2017 12:11:08 -0800
In-Reply-To: <CA+55aFwdUxCvmi28T3yn1K4rqn2bZmJBdTRr7tSbMa-g5izHbw@mail.gmail.com>
        (Linus Torvalds's message of "Sun, 19 Feb 2017 17:48:28 -0800")
Message-ID: <xmqqpoibfgo3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> That source showing should never have been in "show_decorations()" in
> the first place. It just happened to be a convenient place for it.
>
> So this attached patch is just my original patch updated to split up
> "show_source()" from "show_decorations()", and show it where it used
> to be.

The updated organization smells a lot better to me ;-) 

Most of the time it is convenient to have "show source" at the
beginning of a single helper that is to show both, but oneline
format is so special that it makes it inconvenient to have them at
the same place.

I can lose the patch to 4202 (update the expectation for --source)
I added to the previous one, but the patch to 4207 (update the
expectation for --decorate) needs to be kept with this round.

Will replace; thanks.
