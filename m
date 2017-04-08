Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38F76209F1
	for <e@80x24.org>; Sat,  8 Apr 2017 10:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbdDHKKd (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 06:10:33 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:36112 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751777AbdDHKKc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 06:10:32 -0400
Received: by mail-lf0-f44.google.com with SMTP id s141so16558151lfe.3
        for <git@vger.kernel.org>; Sat, 08 Apr 2017 03:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ow/T+rNeIZ2yDe9EkvHCt5vadBjNfmsAu4oL+jDPN0k=;
        b=m7mcaK1vCkmIM2FcLPJphfD+sLfOXBDxkAEats893e8D7HHQrfcdS4qz/uQ8JbYfzs
         NXZki3dKa+zj0U/AOHbkFyDSZodWxWqret+kVRIXXHqijV0FV59iZEVloTsZNO35XVSX
         Ev4VCOe9SnQkZ09ktEI5pPy88McsUbU53nKWM1W3WauIb+03QYOUvqQ2Qz7MLyScBY3r
         HhoU/mOUyjzG8ConFm2Lr93J26dg1I58LNi7xuk0H8sEXs7MpblVfrcaqgiMlQQ2qpb2
         IKQnsI4KU8C70UUAtNG4ZbRhXh+kynyEG3fGdjonks//0W0Hixa8rpUW3xj6iQaVMFxV
         6tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ow/T+rNeIZ2yDe9EkvHCt5vadBjNfmsAu4oL+jDPN0k=;
        b=mGZDvI6av4Vil/q0dhPgUdFPlC3u5w4bnPlKRwUYtyapXwhAv8wp8L+lAJBSjTmCYr
         Zt5sLWSZy2jlj0p7HufiDfj/LKeP6rz6esXHvtRRTxQLPs+tzkfP2oen+A9RZ65VAPST
         MC1owbs+hM5B7tFUSxOBJFgMEbVAC42O5AedEVfKuVUyWKtxqdAfZ4DttIIoEgbMAMZU
         rrTveVbIrLbLiPOTUxgRzPIpiZBn3srlMUFFtAuvALKrdXdHgCK03GrnQyYVjXrcCuy5
         Vkv6u473R8I56lp5T7tTKgTv/dGemRzuvxq3JlpMbZgorkuDkIrCsDjbUW+SUWYk+r/V
         wSBw==
X-Gm-Message-State: AFeK/H3KKijzSXV/PN+I69DGftNd5d9oImNeQmT9TqfQ/7rjYCpFmX3VCCbHXTooL0jGoA==
X-Received: by 10.25.74.146 with SMTP id x140mr15489473lfa.67.1491646230545;
        Sat, 08 Apr 2017 03:10:30 -0700 (PDT)
Received: from [192.168.1.26] (dcf95.neoplus.adsl.tpnet.pl. [83.23.57.95])
        by smtp.googlemail.com with ESMTPSA id m203sm1486700lfm.28.2017.04.08.03.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Apr 2017 03:10:29 -0700 (PDT)
Subject: Re: Tools that do an automatic fetch defeat "git push
 --force-with-lease"
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
References: <1491617750.2149.10.camel@mattmccutchen.net>
 <CACBZZX7MeX-6RHgh2Fa9+YL03mjxs8xmyE86HnVxBxjMYizcig@mail.gmail.com>
 <20170408092910.g5wl2ew4cfu7wzft@sigill.intra.peff.net>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <487622bf-00d0-e4fc-4a74-08e18d59336a@gmail.com>
Date:   Sat, 8 Apr 2017 12:10:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170408092910.g5wl2ew4cfu7wzft@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 08.04.2017 o 11:29, Jeff King pisze:
[...]

> Perhaps it would be enough to reset the markers whenever the ref is
> pushed. I haven't thought it through well enough to know whether that
> just hits more corner cases.

I wonder if using a separate remote for pushing (with separate remote-
-tracking branches) would be a good solution for this problem...

-- 
Jakub Narębski

 

