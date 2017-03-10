Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F71C202C1
	for <e@80x24.org>; Fri, 10 Mar 2017 05:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932505AbdCJFBr (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 00:01:47 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35683 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932332AbdCJFBn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 00:01:43 -0500
Received: by mail-pf0-f195.google.com with SMTP id 67so9493847pfg.2
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 21:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lrp4Y3aff/T86EdnY0GrPJsWWMFsuBQMOssJK9y+tvY=;
        b=GjMkOHOU0/c8a69yZqwoZeJlO9VcK6od1p53LQ/pXpM22BcqPZofJ5mv3rJgBR3Nnx
         +LsTUXtwIsEzlX1Vq7h5fZ+zq+TKx0cpzqMvBtV64Xe8+znWKUpuVkAvLJkRJ00OiPre
         dkQHrZNe5+XEaaC8H48HRgR/NkglLPX+2abNtPJdfO7P/igVfgarXPtkP3Pjj6RWHWpN
         nt1pFbbgEaQYIXmHeM4/SC5VAdONRLgSpVR3vb6trtQDn9euoKMYHQGaih9WD8ai2L6i
         jpsxkC/zT71LflnMWCa+AGjqVY1Dd1rePJedVky9p3WsaDTQ8MLL5MyKKV5uIgin/WnM
         Xo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lrp4Y3aff/T86EdnY0GrPJsWWMFsuBQMOssJK9y+tvY=;
        b=qRjgUAd3R4oAj60IW6hVGesorLbho57H01pzr6G0XxsT42mp43afW+GNKQflYLQnvf
         AUIRfan/Hu4hoMVAKVc4ZfHdoMuwNPrGThYN6xcYz0tRKv23ILVbn9Z2kIx0WO/rdY3D
         xPSZAEYazBAxtewxEW834jzDttQhD2x3BzQGqme/wM5OFCDa8wyWUfdNt1QcNO534xQs
         B5Z9lbhIMdGOvlUu42zIHfuys2U/DizfmFiDzYnK7w3vBwXuwWoiC5mqL8Nfxy9qyhhA
         vbcHAT7N8KETN6Gt/+ePo/mqlcYxolTCqcgQSCaDOxwDEhfj8/Pe/2ZpgQW7ofa20H2B
         b1zQ==
X-Gm-Message-State: AMke39lZwh9/9FMg0R3T50JyzeCJrbzIJtSHtTzESLx3rvZXXtkQtmvP5pUWnX5gDRXDGA==
X-Received: by 10.84.138.1 with SMTP id 1mr22624598plo.29.1489122048294;
        Thu, 09 Mar 2017 21:00:48 -0800 (PST)
Received: from localhost (37.147.199.104.bc.googleusercontent.com. [104.199.147.37])
        by smtp.gmail.com with ESMTPSA id x15sm15536779pgo.56.2017.03.09.21.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Mar 2017 21:00:47 -0800 (PST)
Date:   Fri, 10 Mar 2017 05:00:46 +0000
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     mash <mash+git@crossperf.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vegard Nossum <vegard.nossum@oracle.com>, stepnem@gmail.com,
        Stefan Beller <sbeller@google.com>,
        Vedant Bassi <sharababy.dev@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 GSoC RFC] diff: allow "-" as a short-hand for "last
 branch"
Message-ID: <20170310050046.GB2417@instance-1.c.mfqp-source.internal>
References: <1cm4dm-0007OE-MZ@crossperf.com>
 <20170310034106.GB1984@instance-1.c.mfqp-source.internal>
 <1cmCXH-0000ND-9K@crossperf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cmCXH-0000ND-9K@crossperf.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 04:52:07AM +0000, mash wrote:
> Maybe you can reuse the diff tests. I'll do another microproject then.

Yeah, definitely. If there are more tests required, then I will reuse
your ones!
> 
> mash
> 
> The original message doesn't seem to cc the mailing list:

Thanks! It was rather daft of me to not realise this. I was waiting
for it to appear on public-inbox.

I re-sent it with the CC. The timestamp is a little bit
skewed, but I think it should make sense.

Thanks,
Siddharth.
