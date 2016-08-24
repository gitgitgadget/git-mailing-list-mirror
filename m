Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68B0D1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 12:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754244AbcHXMoh (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 08:44:37 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36184 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753012AbcHXMog (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 08:44:36 -0400
Received: by mail-wm0-f65.google.com with SMTP id i138so2489083wmf.3
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 05:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=B1p4oFimbznfbWkK/boPLt2tuRap/Nws2mN3mQ9n//c=;
        b=v+DZfYOENH5unwVHlQdZO2cYmqjXQYBHrmABHaBsnT9eMdbvmgs2xswuVt7k0ioOdK
         cl8CMgJyC5XCNDcAW1Vf64cA+aMjYKiW3RHyY8he+9kKhKfB/9ddAAvuzVBI0dulGwTh
         fYXdDV63gjqsZcjUIyQR/5NCu01QR6dCNNJ42OU96Qha69xSqYhcb/5FqjLOTUDyjvMJ
         DJckKmeK6v7M82AlleH4zAa0yus4R8di/LGwdjt1EYWdtD8OX4lDDI/wYBZA4kn7pJWH
         iRmFHtEUJ1nGj7pjxbTdKm3Ck3e/Duzkhb68QRq86VR+hU58aeMPT5JT9ewuOJbCuZCA
         wj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=B1p4oFimbznfbWkK/boPLt2tuRap/Nws2mN3mQ9n//c=;
        b=Zvgh22JggYUeBGQwNyeS9jvcqsEzHDux9FKjNG0chjdS27MCdEx2fhdpLgrR8FysKV
         DBj0FsRZVAtzF/5izFIqsc1sGXglCxrhfUAoFTrgmud6seu+qJJTMIwQdQVxxZ7zXdQk
         XEbd++py8QwOwd8lcm4HCQnUFGgkkPPzjoav4QnFlzqg9wrid8CF5pXjzh1sjig42MDv
         wtS8CqIFvvuBC0dlcVLjhyH4ZIYRLRJAUpCdzmGq7vk0/RZAWaPuQfe5q4MODfBPgDkb
         Wv1nIz4wK54yErxuukZZnse5BtkPdTgC5nbppQFia0x5tB0TPIOonlnFS9Sl0tmXgvaD
         CVPg==
X-Gm-Message-State: AEkoouszlrfDo0ZY1m9ao79Kd3kFbxrSqf5X8qk8BNPSNRfQ0mtAT/iIqUB4BeavwEVEJg==
X-Received: by 10.194.171.131 with SMTP id au3mr2591424wjc.125.1472042674857;
        Wed, 24 Aug 2016 05:44:34 -0700 (PDT)
Received: from [192.168.1.26] (epy16.neoplus.adsl.tpnet.pl. [83.20.66.16])
        by smtp.googlemail.com with ESMTPSA id g1sm9875110wjy.5.2016.08.24.05.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Aug 2016 05:44:33 -0700 (PDT)
Subject: Re: [PATCH v4] config: add conditional include
To:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20160712164216.24072-1-pclouds@gmail.com>
 <20160714153311.2166-1-pclouds@gmail.com>
 <CACsJy8Bw0ZNu-6SB0P3dBZCLMJWJkbUqb64H_QOcn4UH+_AcNA@mail.gmail.com>
 <20160819135408.ckyw6ruseicvg2jt@sigill.intra.peff.net>
 <5c131421-ae7f-8a37-76ab-0fd05cbe3530@gmail.com>
 <CACsJy8C30=-LGMYQJ6MO17L8Vv1q=iQGC=R8TDhC5qM1f5Lh5A@mail.gmail.com>
 <vpqr39harit.fsf@anie.imag.fr>
 <CACsJy8BNP8GDRxDGTQwcYWTovN9o11TCkUJ28=5zav3QnGv9nQ@mail.gmail.com>
 <vpqlgzp9bw1.fsf@anie.imag.fr>
 <CACsJy8BokiiDbheN1_CqWWgK3xRn8YP30t7ojjVeDnok5_M4Ow@mail.gmail.com>
 <alpine.DEB.2.20.1608231541420.4924@virtualbox>
 <CACsJy8CY1HqSTtmPw+H1yGXV_tBPt3GVU162ZTVecXFhPTnaYA@mail.gmail.com>
Cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Sebastian Schuberth <sschuberth@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <febf6605-70e7-4653-1e3e-cddc1882e037@gmail.com>
Date:   Wed, 24 Aug 2016 14:44:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8CY1HqSTtmPw+H1yGXV_tBPt3GVU162ZTVecXFhPTnaYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 24.08.2016 o 11:37, Duy Nguyen pisze:

> It works for me either way. So I'm going to assume we want
> "[include-if "gitdir-is:..."]", unless people think it needs more
> discussion (then just write something, anything, so I can put it back
> in my backlog)

A final note: [include "if-gitdir:..."] is inclusive by default
(I think), that is old Git would include it unconditionally,
while [include-if "gitdir-is:..."] is exclusive by default, that
is old Git would ignore it.

But I might be mistaken.

P.S. I personally prefer [include-if ...]
-- 
Jakub Narębski

