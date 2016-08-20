Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 241701FD99
	for <e@80x24.org>; Sat, 20 Aug 2016 21:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbcHTVIi (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Aug 2016 17:08:38 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35217 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbcHTVIh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2016 17:08:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id i5so7868619wmg.2
        for <git@vger.kernel.org>; Sat, 20 Aug 2016 14:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=laLb3wG3C0FJjghXBlEYwgqNGtmKNDUNMoXOUaXQQu8=;
        b=iNMdwrXY+io2BA8xcZuoOAUXUMFc6nxqE1RVXN02jNoixTzmwo6dxPvYAKUq/MWK2h
         8Ks/hBTvmYZOjE9C6tleb7a60zoRigbxaTx1OE+PLOp6KqDFFFWiyDEAasxR5/Uphy5O
         XZGqtoojxSWrMayxRcFQzeb4XUGabZ6sp1QbRNEsy7ufmqgOyI1AfEeYIysS7Oc1l2PT
         CfM8G5yECTJco8lUHpGibEQzx0Rd063itdyaxSN6y+6kPsxBerV1WB6tQpHZcicN0agi
         afL7MShn5/ShHl+pRA/LgPSEK8f/m1hZzXnuNPaQwpthoA0YVbLZkkECxxuByuRYbzDl
         KjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=laLb3wG3C0FJjghXBlEYwgqNGtmKNDUNMoXOUaXQQu8=;
        b=XJxr9VC6siIZADSs41tmLB9tP5e06uwH9kTUGBtVZRE4/FeQMQJd8yPOY+N1QtTAOP
         1c1pij43G/KF55i4lKgTDa6171lyyxNGKC+FJMD2fWkbcU7HjrhHo6gbZbRGM3ZEwWyz
         QNWFvzYrqVBbUr8EqVmR5m/I2/FwIFSgD8oiXPexdMsltue21dp1YhfFmA/ioKHgQ8Rh
         sgObQKhp3fV66Eq1hBtZMJfiTH6GA99DLLpJ+Erz7rWvguTcURC/hT6bNiKl6ucEW/aW
         iyYRRw7/GYD+eK2yj5icE/YuQwzgYwaM6jExOYBZFGs/7GZP3caPJdnbYei0GwruCcty
         KzzA==
X-Gm-Message-State: AEkoouuA6vMP4NA66oS7quzLb3kFSfVqtfeUV5SOJASCU/zni46Hfdm8oOb6+QlxfwKv9A==
X-Received: by 10.28.17.138 with SMTP id 132mr8569358wmr.81.1471727315443;
        Sat, 20 Aug 2016 14:08:35 -0700 (PDT)
Received: from [192.168.1.26] (dch196.neoplus.adsl.tpnet.pl. [83.23.59.196])
        by smtp.googlemail.com with ESMTPSA id o76sm11335544wmg.16.2016.08.20.14.08.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Aug 2016 14:08:34 -0700 (PDT)
Subject: Re: [PATCH v4] config: add conditional include
To:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
References: <20160712164216.24072-1-pclouds@gmail.com>
 <20160714153311.2166-1-pclouds@gmail.com>
 <CACsJy8Bw0ZNu-6SB0P3dBZCLMJWJkbUqb64H_QOcn4UH+_AcNA@mail.gmail.com>
 <20160819135408.ckyw6ruseicvg2jt@sigill.intra.peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Sebastian Schuberth <sschuberth@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <5c131421-ae7f-8a37-76ab-0fd05cbe3530@gmail.com>
Date:   Sat, 20 Aug 2016 23:08:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160819135408.ckyw6ruseicvg2jt@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 19.08.2016 o 15:54, Jeff King pisze:
> On Sat, Aug 13, 2016 at 03:40:59PM +0700, Duy Nguyen wrote:
> 
>> Ping..
>
> There was some discussion after v4. I think the open issues are:
> 
>   - the commit message is rather terse (it should describe motivation,
>     and can refer to the docs for the "how")
> 
>   - the syntax might be more clear as:
> 
>        [include-if "gitdir:..."]
> 
>     or
> 
>        [include "gitdir-is:..."]

Or

         [include "if-gitdir:..."]

to continue bikeshedding.

-- 
Jakub Narębski

