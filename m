Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 032AE1F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 18:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752928AbdBASdm (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 13:33:42 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33394 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750777AbdBASdl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 13:33:41 -0500
Received: by mail-pf0-f193.google.com with SMTP id e4so32279829pfg.0
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 10:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xa8XjrPZ8biwUS4jtMbqaaLgBzKiSGvtHCZLRaYCNm0=;
        b=ExfRBqf130W5Z3RUgr72AiZPchJYpOqn0QrJ6a5nOXpROZrliQ8MFwlIo7R8uPU86F
         Ghg14dkXVzwBuYrIZt+v8/EwAxF01Px4KhxlgQMfp2ejNMERlyUVXe8zRTkZlbAi2+xs
         WxRGKGyQTqKdxN8vDayVuplpAObZ8flcmHfp5+r/I+3hZ7kQkLcEkOiSaYadS2xARx5t
         pS3HuML0c5VsqYVjbe96t6eD/xj2qo+bVBNkoF+vf6Fq+BZjJ6ywGAMCuQTmSD1rpc8W
         SZop7/GZrZBSobZSFv2eIzuscPn2twBB/Bc0KeRy3LzhPMi6H6mKwsN94KpBiIc7tC2A
         Fgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=xa8XjrPZ8biwUS4jtMbqaaLgBzKiSGvtHCZLRaYCNm0=;
        b=Y96GOiTsAg9sIeCHx3x2+mYBY+tNZ/cOSoofls3GJFpoVQwGCkRXDcN0fWZnV5vsVX
         mmuC/AnHw85O/BjLiX6DBNbeQuxCpB+Q0ckbiKmpBltSz8WBZYTkBxxP7fWcQq9a222T
         lKY8IXt/T7U8ZoOL83VcAosFZSezNmyQC2t80uAadzM/W2kOLsiTDEXqM2PqUseBRJlL
         cTESkLMKrJtHA25EYiV+PjIksVZbBP9sGw7rpEYzAy+4ijZjr2mUYs27sFyO0do4rO96
         juDOuBXtPHm+xBxzwOi1HE2RLu7S880NOjlBi2eocODaXBMmZ7pKXdd1xKQhHN2oYtH7
         salg==
X-Gm-Message-State: AIkVDXIbLOBMbvQOfLKSEaDJlx15IpwDxLSOJAQXyZC7RoLMekV5e+dfN2Ka3JFqW4CmMQ==
X-Received: by 10.84.214.150 with SMTP id j22mr6472133pli.23.1485974020894;
        Wed, 01 Feb 2017 10:33:40 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:25a6:b4bd:905a:8303])
        by smtp.gmail.com with ESMTPSA id w16sm51964913pgc.15.2017.02.01.10.33.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Feb 2017 10:33:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/5] add SWAP macro
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
        <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
        <alpine.DEB.2.20.1701301643260.3469@virtualbox>
        <aa653d57-4a97-ac50-b20c-f94ed43a22fb@kdbg.org>
        <alpine.DEB.2.20.1701302158110.3469@virtualbox>
        <77098ac8-1084-a5c4-a5e6-fb382e3dc3a0@web.de>
        <20170130222157.GC35626@google.com>
        <8e94756a-c3a5-9b81-268d-d0f36876f710@web.de>
        <20170131213507.uiwmkkcg7umvd3f4@sigill.intra.peff.net>
        <alpine.DEB.2.20.1702011225250.3469@virtualbox>
        <20170201114750.r5xdy6emdczmnh4j@sigill.intra.peff.net>
        <bfd0d758-a9c8-9792-6294-9f9ed632cc98@web.de>
Date:   Wed, 01 Feb 2017 10:33:31 -0800
In-Reply-To: <bfd0d758-a9c8-9792-6294-9f9ed632cc98@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 1 Feb 2017 19:06:03 +0100")
Message-ID: <xmqqd1f1pxqc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Size checks could be added to SIMPLE_SWAP as well.

Between SWAP() and SIMPLE_SWAP() I am undecided.

If the compiler can infer the type and the size of the two
"locations" given to the macro, there is no technical reason to
require the caller to specify the type as an extra argument, so
SIMPLE_SWAP() may not necessarily an improvement over SWAP() from
that point of view.  If the redundancy is used as a sanity check,
I'd be in favor of SIMPLE_SWAP(), though.

If the goal of SIMPLE_SWAP(), on the other hand, were to support the
"only swap char with int for small value" example earlier in the
thread, it means you cannot sanity check the type of things being
swapped in the macro, and the readers of the code need to know about
the details of what variables are being swapped.  It looks to me
that it defeats the main benefit of using a macro.

> The main benefit of a swap macro is reduced repetition IMHO: Users
> specify the variables to swap once instead of twice in a special
> order, and with SWAP they don't need to declare their type again.
> Squeezing out redundancy makes the code easier to read and modify.

Yes.
