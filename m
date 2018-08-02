Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D7341F597
	for <e@80x24.org>; Thu,  2 Aug 2018 17:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387570AbeHBTh2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 15:37:28 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34694 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387562AbeHBTh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 15:37:28 -0400
Received: by mail-yb0-f195.google.com with SMTP id e9-v6so1534348ybq.1
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 10:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GogkqSHfNaJdwAcQAukHJy/CGr1kmoVID8XgnO64M+k=;
        b=tK9k0ml4Zc0Agqc8jCEnNd13U8fHaYcZ2JKnWd/wsLh5ak5s/QiPd3DvOvrVYAn/Fw
         dtyvJgsXJOkxBgYqALE0IffF+5hMTYBhoHB26mpbauzRfKWjt1QuEW1sJYgYd2pOLbS0
         z0ChdcEN6e5/T7739SDeHn6bt4KOAmiwtS71HQPmQ8VL8OIK82wlnTCM6krd/okgy3K4
         FSY6QmE6oEjpgH9UdhGIv34uCuwuTl1tihMNzxGwYkEFUb1V9f/0oep2syEcQgAuuKil
         qTptwGrM6wnqMnzbMt12TpJjwZtrqx6jqptArWXiJy53xyqg8Xg2wLDeBkqpm/tiw16J
         QcnQ==
X-Gm-Message-State: AOUpUlElu99F8H5ZTw070+89Sc0a6OQ6m/gwim6zmpy+tJbCRWxEnb6H
        YUZrkZCZsFh6RdSWL/Wun3TrMbYc1/fomfYVryBI0wkC
X-Google-Smtp-Source: AAOMgpf+YR05oAlbBJ+gd6KFz6uvvcydayIEdfu6SwNDfHYDO8NMB3L/UgEM7miqb2MbE6CLlYsEeqEIw8WTychyHsE=
X-Received: by 2002:a25:488a:: with SMTP id v132-v6mr297549yba.263.1533231919350;
 Thu, 02 Aug 2018 10:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180802093208.27420-1-sunshine@sunshineco.com>
 <nycvar.QRO.7.76.6.1808021438460.71@tvgsbejvaqbjf.bet> <xmqqftzw3c21.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftzw3c21.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 2 Aug 2018 13:45:08 -0400
Message-ID: <CAPig+cQyYRvF5QkJRUi6W2LiOo_poxWyJw9dn+FOimb1ryX8Mg@mail.gmail.com>
Subject: Re: [PATCH] color: protect against out-of-bounds array access/assignment
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 2, 2018 at 1:37 PM Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > ACK!
>
> Did you write a buggy caller that would have been caught or helped
> with this change?  You did not write the callee that is made more
> defensive with this patch, so I am being curious as to where that
> Ack is coming from (I wouldn't have felt curious if this were
> a reviewed-by instead).

The code being made more defensive with this patch was authored by Dscho[1].

[1]: 295d949cfa (color: introduce support for colorizing stderr, 2018-04-21)
