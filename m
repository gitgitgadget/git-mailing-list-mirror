Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B7411F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 20:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbeJKEUH (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 00:20:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36358 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbeJKEUH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 00:20:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id l81-v6so3233888pfg.3
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 13:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xcTguXShlPDqRxCQtuoB3UQWlDX1WisHbso4f3TJU/A=;
        b=LseBjx3q2pFo/InJYdyyRstJj3WU9R0YiT2rqC7Md4uiNfZ2GT+SPeOkAA/IEi2mWS
         34A0Hr+H2+lw9jRNWcU1v+d0xa9VuAJy+tYG0VaDKpXpbsZ7rhdiXMpQweJjH+OzIcDQ
         VNX3W1rJsjgfOBXG82aC9msMm/y7OC+zFxAFe3x7zMv+Blou8y2rYlXn3Z0Lp9tqj2MQ
         xPwwhZk0NxWbzrzSVkQDLeuWz+JGWxJNh2uJy+wQHg3wppcDWnSeN9xR0oLv2jabu+Bg
         ftvaSTqgxfm5TwB65dwzvCkoA1ImHpYWO/hPYgNti69NLmVwDEW38FkU3Rp/mReZ6uRT
         +Q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xcTguXShlPDqRxCQtuoB3UQWlDX1WisHbso4f3TJU/A=;
        b=qorWJBLE13EVrn9BnYPvXLOQDPtsqYSJMTAlKDCHnYeS9U06OZGbmMsHfRjDUQAzZw
         jS7c7IR1BlGOHinj0iNPS+rsWUOjHDIFPXjyPPX3UTitarzAuDH2NMuMLtHskbq3sSnL
         Sjx028+FIE4hZmUWrxoS7eoZDw9Qi1RKBdqvs8zAsT++iai5/WH4J/+wZ8TWFVUEWHTk
         WURs6tAJJbivW1QvriLruja9pP/D+zoMln7mdzRjdzV/Taaj3noDCOjJZ6qw4gnds7LO
         TcAnFgwzH4zPFtT99VRAr4gy4bX5t414v+DJEP1b90CEbSlRh4rBuK7fffj4olG482cr
         /Ewg==
X-Gm-Message-State: ABuFfoih6ZRh+80I3gnL+c1U7+sxePI6yZS6L1fNnrqljm+rZMQ67vxW
        ST5t6bhqLRxGUu/lIpWgh5IiSM5t
X-Google-Smtp-Source: ACcGV63klcdwT7McBmMLlSLZhJlgSBQ1cWNVS6PppxwolBGay1n2iDvf5SSmnWpntdTFWkGU/H++ZQ==
X-Received: by 2002:a63:d10b:: with SMTP id k11-v6mr11283377pgg.80.1539204973287;
        Wed, 10 Oct 2018 13:56:13 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id o62-v6sm32508467pfb.0.2018.10.10.13.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 13:56:12 -0700 (PDT)
Date:   Wed, 10 Oct 2018 13:56:11 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] gc: introduce an --auto-exit-code option for undoing
 3029970275
Message-ID: <20181010205611.GA195252@aiede.svl.corp.google.com>
References: <20181010174624.GC8786@sigill.intra.peff.net>
 <20181010192732.13918-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181010192732.13918-1-avarab@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> Add an --auto-exit-code variable and a corresponding 'gc.autoExitCode'
> configuration option to optionally bring back the 'git gc --auto' exit
> code behavior as it existed between 2.6.3..2.19.0 (inclusive).

Hm.  Can you tell me more about the use case where this would be
helpful to you?  That would help us come up with a better name for it.

Thanks,
Jonathan
