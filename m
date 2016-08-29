Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DB211FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 21:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756195AbcH2Vbb (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 17:31:31 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35062 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753322AbcH2Vba (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 17:31:30 -0400
Received: by mail-wm0-f46.google.com with SMTP id f65so95319361wmi.0
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 14:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R68VokxhI+t9Mygf0FvdkI1lV0OMH7/27dmRkQGtY8k=;
        b=M8VWBGPsx5JKJlNvLemuOmds+xEG26gMZlzmGRO09f/LsAfW1LFkRvEiFZBLKceacN
         sgkZYFqc0J17zBlxj56oFZ6j+6zZPrBPfyKNgAsLCbYF2izwoHW4L8gSkUCnbqFGlM6X
         Qz+ciU1tTOOnE0V7ZApHiBFpWgl09ZfaSUcZaXaKqA9CTI2w163ASGYVsBUEwfLt8wsF
         2LjjRYVPnH6sv+awh9vq73cdeJir/RosQwxZbCJFqosNCp7p6usXju1EGhsWaZRYZMcj
         FvtzG7U7rQWzb3PZoM0bEAu5wAIjh3Q31kP501NR0FLXEusYqFYOd/NUEIeQuEQNLHC2
         2pVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R68VokxhI+t9Mygf0FvdkI1lV0OMH7/27dmRkQGtY8k=;
        b=LS0gMyrsAcy01+RONvvfym6hh3c8qu1MBtywGgtXaD06ScmaN2KrqVDJTodNaA89BV
         /nLpYyrhy1v8zFCbkitMiLy69PaxnVejgUaG52N8JxrkQd2T3WtQ9vZUlfx6ZVN5PNt0
         lNoy1EpVUj9RCGuOBuCQiJ71P140xrCtN5pR5s0vKHG1xSIyMWEQIhCTxsDUjHPH6f9f
         kCSxb+5tB5GnI8eMZl2S8J045s5eq/EFQQcFOmG8d0J+TsTCqvycOkxX0eSTYzMhBsSr
         LJgUomaq7mILtzvxXmHXWhmtNkQoyr6+6wRGyBqtwEPra6MJYyVyzW0PaLcL9FvTYV+Y
         oBaA==
X-Gm-Message-State: AE9vXwMGFlWfUgP9bOlP8Z6UKdpR8rczDAQHDJyBLBv29fxr3TNNUO/NYTg/3aBHJDcezQ==
X-Received: by 10.28.183.134 with SMTP id h128mr506593wmf.7.1472506288684;
        Mon, 29 Aug 2016 14:31:28 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id o2sm36151291wjo.3.2016.08.29.14.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Aug 2016 14:31:28 -0700 (PDT)
Message-ID: <1472506287.4265.36.camel@kaarsemaker.net>
Subject: Re: Reducing CPU load on git server
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     "W. David Jarvis" <william.d.jarvis@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git <git@vger.kernel.org>
Date:   Mon, 29 Aug 2016 23:31:27 +0200
In-Reply-To: <CAFMAO9wQD5GtGRGv-sMy=NA1q8kbu6n3FFbWuJ+W5-qnRDKW-w@mail.gmail.com>
References: <CAFMAO9y3LsrAb_jp8XVq2mexaA4bBqmWFwJu55r4S6Dxd2-zxw@mail.gmail.com>
         <CACBZZX63DAmFt_ZiUHj-bs9dtwRd4MOxoLfM8r1uRi3q4Mwnkw@mail.gmail.com>
         <CAFMAO9wQD5GtGRGv-sMy=NA1q8kbu6n3FFbWuJ+W5-qnRDKW-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On ma, 2016-08-29 at 13:57 -0700, W. David Jarvis wrote:

> >  * If you do need branches consider archiving stale tags/branches
> > after some time. I implemented this where I work, we just have a
> > $REPO-archive.git with every tag/branch ever created for a given
> > $REPO.git, and delete refs after a certain time.
> 
> This is something else that we're actively considering. Why did your
> company implement this -- was it to reduce load, or just to clean up
> your repositories? Did you notice any change in server load?

At 50k refs, ref negotiation gets expensive, especially over http

D. 
