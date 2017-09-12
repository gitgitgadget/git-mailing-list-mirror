Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7C411FADE
	for <e@80x24.org>; Tue, 12 Sep 2017 14:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbdILOeu (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 10:34:50 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33248 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbdILOet (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 10:34:49 -0400
Received: by mail-pg0-f50.google.com with SMTP id u18so4995872pgo.0
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 07:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=lPVtO93GTOk6WDfNT3wQMJccO4bvBCWZllq+nv/dAVw=;
        b=cFWWU9isBgtvEq8jlJODQImIn24gXvgS0/ZlleCVej14CX4hqFMbcqgTGlE0xQ9OUS
         /I+KftnVBB60DWaBAN0HVk1ANWRrrcR7kl1W9+ryNLTjg1tFavH39HgjY00wGcURA4Uh
         5TDnDsby92mlYLebHj/QyzBwuZJ2syLwJlDVN6n3srQqzznioIYmPczzZKrqP9gpokrq
         EFvu8qrC0qWY6qpS3o8XbJu6FcrrTEC34mcsYdf5O/96S/KqHSL2CTUraR55+ZfEWJ9C
         M9Tbom3oJLxXEels6SUCmvscYWSLInhB1NaqHl3CUtK+XtsyOWeUcssrRGMQJRFlFgZ1
         G/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=lPVtO93GTOk6WDfNT3wQMJccO4bvBCWZllq+nv/dAVw=;
        b=UUnB1VJ30mv0u9ogs2Dm55G124BP2GUZ3VbMjpJPvVISCtzRTwwS8ZGIy9N+ujvjck
         m2+wNGpR2he4EKHL80MfMf6olaw+l9BH4q8Jhjb3/r5eDHMeBxpifAX47ETuQM04ROog
         RpCpl6jwmEnZ+G2XvEMLMrxxg8eKLyW8CduoTFQjGvRm/cgvLFsp3pOvjeibZX9E1V7o
         Sy5V6ry5a1zYoBhtBhux3jCqADSzsLQnb0OFbz8biRaK77YObD8pzC63AXSK/nskn00z
         XdT5kqaiBm9YMQFOtHBXyxBf2cC/ydjz6Mo+C9fK0rOhqnywXl5Cu5IPbHIgKsskv4Cf
         tP3g==
X-Gm-Message-State: AHPjjUgowptlUIjxJP9NGThFDFCBGudRmQyiNrJbjJIkun5wek21GqqW
        LzV5K7CjAtmgOw==
X-Google-Smtp-Source: ADKCNb76SK04QuqSP1pGkkBsgWirtRfJfWtnI0mAb0iYa4KYD5bgrgKJ3hA2I8MmX80upJPzWXhdLA==
X-Received: by 10.84.132.4 with SMTP id 4mr4319235ple.449.1505226888619;
        Tue, 12 Sep 2017 07:34:48 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id z89sm19493915pff.13.2017.09.12.07.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Sep 2017 07:34:47 -0700 (PDT)
Message-ID: <1505226892.27800.37.camel@gmail.com>
Subject: Re: [PATCH 10/10] add UNLEAK annotation for reducing leak false
 positives
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <CAGZ79kYmZJ8k2=SVrx9vpEXoKhRBGwu8J=fS=cYiCLdKf+nDGA@mail.gmail.com>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
         <20170905130505.him3p4jhxp64r2vy@sigill.intra.peff.net>
         <CAGZ79kYmZJ8k2=SVrx9vpEXoKhRBGwu8J=fS=cYiCLdKf+nDGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 12 Sep 2017 20:04:52 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.24.5-3 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, 2017-09-05 at 15:05 -0700, Stefan Beller wrote:
> 
> After having a sneak peak at the implementation
> it is O(1) in runtime for each added element, and the
> space complexity is O(well).
> 

Incidentally I was reading about "complexity of algorithms" and there
was the following paragraph in the book,


    Unfortunately, as Knuth observed, big-O notation is often used by careless writers and
    speakers as if it had the same meaning as big-Theta notation. Keep this in mind when you see
    big-O notation used. The recent trend has been to use big-Theta notation whenever both upper
    and lower bounds on the size of a function are needed.


So, if my interpretation is correct the above usage of O(1) and O(well)
should have been Θ(1) and Θ(well).

-- 
Kaartic
