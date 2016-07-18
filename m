Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDCEB2018B
	for <e@80x24.org>; Mon, 18 Jul 2016 16:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbcGRQwV (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 12:52:21 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34398 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbcGRQwS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 12:52:18 -0400
Received: by mail-io0-f182.google.com with SMTP id q83so165432800iod.1
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 09:52:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=n3HVhED3f7rpi0zBBMvjA63Ts0pc8WSFulh/Aw2gzj0=;
        b=Nxmw9+h75E/BN5vJ+VlJ9Mpm1wcO78xcXWDMe861vKUxAuMG0+PcscKuUIWvyOlrYg
         BW7XMS+GaTTA5wMtIsG0XHoOGmdwiBo+FiYWqwqbQfiM6uwxygqpVwkJBj4eGQH2lqXP
         qQvzBVS7ayxpCVuswN2EDp8OnD8qnnXx9NVtgAWjSq2htZ2fOLSYipBvCouRiLVNC0IQ
         9lK9Asy7eplhCWmh2S+skqHRUOmpwoIMziY0lLfSHOK0NcsMTw8t3KNL2PCQyeJHFBtM
         l/PJFFT62e6Gdr/Q8R3ZTKLOaq07pdjukXgpoJAMFt7gPjYEkawFma0uZytjEbt+7n1D
         2Jag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=n3HVhED3f7rpi0zBBMvjA63Ts0pc8WSFulh/Aw2gzj0=;
        b=iUphb6jIODdqIE48r4bQAuAysuJ72xPPEzmzEJfE9HH+Vh8YLoj0UZsCKPkMq76v0z
         sPG0W/bEizPMj3HzT3nyGe4mMJOzg0joEfUs/RYs7QQp/n7PWJmRzQTQi+xKZpNMOxK7
         8xl1ntNJ0T9k5d5BK8Idkqj9ViAGqijQt9FgosG0yi2MMWWFW65FCzvrRburIZlkAnHz
         kiIHR+hMQQXNg0sRH2LNalRNE9YINz2UiE22GYgNJez58BCD5WTewETuIj60628wDlIv
         /eFxdNqODla2MWjHM4XXE2K+iG8AuVgeKGaLGe78HAf3N1l8TonFaPO8LYWxJc1EqrXa
         UPWg==
X-Gm-Message-State: ALyK8tJyNOk2+LyolAZrlMbCzSkYpkwiwkmhvV2GKF2zwQTFUM9GuK7NQ3aGCo/v31MIaGnKhGUsLuH+QOqCvQ==
X-Received: by 10.107.22.6 with SMTP id 6mr34696041iow.128.1468860732902; Mon,
 18 Jul 2016 09:52:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Mon, 18 Jul 2016 09:51:43 -0700 (PDT)
In-Reply-To: <20160717142157.GA6644@vauxhall.crustytoothpaste.net>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <20160716201313.GA298717@vauxhall.crustytoothpaste.net> <alpine.DEB.2.20.1607170949360.28832@virtualbox>
 <20160717142157.GA6644@vauxhall.crustytoothpaste.net>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Mon, 18 Jul 2016 18:51:43 +0200
Message-ID: <CACsJy8AH9Q6rOgvcWGsLGPaP96koGA=k0PYgXP6F3RZ=XAwaSw@mail.gmail.com>
Subject: Re: Git and SHA-1 security (again)
To:	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Herczeg Zsolt <zsolt94@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 17, 2016 at 4:21 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> I'm going to end up having to do something similar because of the issue
> of submodules.  Submodules may still be SHA-1, while the main repo may
> be a newer hash.

Or even the other way around, main repo is one with sha1 while
submodule is on sha256. I wonder if we should address this separately
(and even in parallel with sha256 support), making submodules work
with an any external VCS system (that supports some basic operations
we define).
-- 
Duy
