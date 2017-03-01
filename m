Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 265482027B
	for <e@80x24.org>; Wed,  1 Mar 2017 23:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753658AbdCAXND (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 18:13:03 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:32846 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753488AbdCAXNB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 18:13:01 -0500
Received: by mail-it0-f66.google.com with SMTP id 68so6688125itg.0
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 15:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xrsW7YXzmK6csNbGhz+7pOnp+0QsfxONniSpfrVOx/U=;
        b=fqyH14L5p7x7h4CAyh0ydZeEvjAwXrL+8SVkcDcqu9QBXhxCwGvH+4Kzpr+O0BDcsk
         UCPDIx9t/wh9/z8+yrMCLZF6UoLdfqonhx1GKcABC3vEN6vA5A+vnbBca4KWk4iUp+kQ
         2h/JcbmITscIfrj2PSw0E4CndiTQl2kLJEn6xJ8x0JN2d84HKBY2hKBw3x9iiTv2pn5r
         gjTOm1ZpswdyrCvZT9OZQLpog89ThygZu0j6QkD1D5bqTlvPRbbXDD+3vP8hDHPiEj1/
         oUjTBEs0y9U3q+2/FSNH480KJQJBX9tyR7ZADwtLJofHPCaYVF77RtIYihJLMQlWBVRl
         ztCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xrsW7YXzmK6csNbGhz+7pOnp+0QsfxONniSpfrVOx/U=;
        b=ZWSt/i4XM3x35+bZEYWQHvePxFphHXzf3j9K2SQB/XnSaHgAI1wP2hlz7OsxWD/Zeh
         pod1wV6ATuvy9uhUmDLSpFUawE6qxleRXMptXOaCC063Ji0snYJrpOCA1/RFSMv1IN/y
         wZIYwS9sPeYhpRBfdODZ7hJapoGe7et/KBQgWHY3sjCyHhIdk4J+E2b/N9AzVNRfVvXZ
         8zKef7RBAyVf57/QxelItXiBwOsqV0qlVUQOEFq232m+C3CIgEl0tf/J07jYnTeOitci
         MM9v8o3v25lO6zNAd3eodt59Sy9C3ljo5mx4X/521k0IFYLYitt6xp1f2S7nrQAfyIaq
         R/YA==
X-Gm-Message-State: AMke39mny8npE2Oif7aj3+oHWgy/Vmhp5rEa0GyL9r9hBmPUFkaMrMcqJ6jGksvp8QU/XTcss8dPnuPi68kDCw==
X-Received: by 10.36.225.13 with SMTP id n13mr7246416ith.114.1488409525707;
 Wed, 01 Mar 2017 15:05:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.131 with HTTP; Wed, 1 Mar 2017 15:05:25 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1703012334400.3767@virtualbox>
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan> <xmqq7f48hm8g.fsf@gitster.mtv.corp.google.com>
 <CA+55aFx1wAS-nHS2awuW2waX=cvig4UoZqmN5H3v93yDE7ukyQ@mail.gmail.com>
 <xmqq37ewhji1.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1703012227010.3767@virtualbox>
 <CA+55aFys5oQ0RySQ+Xv0ZDussr-xZNh4_b3+Upx_d9VPWmpM8Q@mail.gmail.com> <alpine.DEB.2.20.1703012334400.3767@virtualbox>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Mar 2017 15:05:25 -0800
X-Google-Sender-Auth: SMZHEEea1zGDRJRKuKVYCQ_T-lA
Message-ID: <CA+55aFy9=jBJT36FC2HiAeabJBssY=jE=zLxwrXWzhpiFkMUXg@mail.gmail.com>
Subject: Re: [PATCH] Put sha1dc on a diet
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Marc Stevens <marc.stevens@cwi.nl>,
        Dan Shumow <danshu@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2017 at 2:51 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> But I think bigger than just developers on Windows OS. There are many
> developers out there working on large repositories (yes, much larger than
> Linux). Also using Macs and Linux. I am not at all sure that we want to
> give them an updated Git they cannot fail to notice to be much slower than
> before.

Johannes, have you *tried* the patches?

I really don't think you have. It is completely unnoticeable in any
normal situation. The two cases that it's noticeable is:

 - a full fsck is noticeable slower

 - a full non-local clone is slower (but not really noticeably so
since the network traffic dominates).

In other words, I think you're making shit up. I don't think you
understand how little the SHA1 performance actually matters. It's
noticeable in benchmarks. It's not noticeable in any normal operation.

.. and yes, I've actually been running the patches locally since I
posted my first version (which apparently didn't go out to the list
because of list size limits) and now running the version in 'pu'.

                Linus
