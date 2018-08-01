Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 013B71F597
	for <e@80x24.org>; Wed,  1 Aug 2018 22:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbeHBAOh (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 20:14:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36528 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbeHBAOh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 20:14:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so172910wro.3
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 15:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2N07UdsVs5qrVJbgLMmTIVEGPX7dMVdzq68W9DPox70=;
        b=mh4HGv7j2kF1JbNx4xFisTu/3k18CFK3egJXHF8aTsx1+a3V9eBVRoLhvxCwFqTlGD
         XentwnGJzYrZHAFKVfiosMu2TosiTduxK6KJ/6fzh9WTwHBowKQpTdc1Mq/cdGUa1Cj1
         +a+1DVfP3etu4e6N/VpyKH7iVO/mJwcsm7UVye47Ptw4HuUCSYcYgoRaPbmh/Lupf7Ow
         L2OHdmjAfsBmcKGuyMopMKAiJlGmlrqotWn+SBuUdUh5kdQW6Wm506pCZqlnqw9iDV+G
         B+PJ8TeT6OpPnY2kVpwN1LEBTiAVj63RwJRpTDbHeetBBcJYjdj12lKsFyB5JSI/UNw3
         hlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2N07UdsVs5qrVJbgLMmTIVEGPX7dMVdzq68W9DPox70=;
        b=pxp+j8yAYtVvUpUQGZY+zFTxhtKJJ0sMCuXPw7ScQjwsQ9PcfN3zKR4mkYSM7fMHck
         4rzzvxj1ant2Ezno+fUT2glKgMf6xw1VH7mWZEckWicBmRo+Nv1QhkuYTOVU4URLlbAC
         eXxvaf8o6rKxlOGpBnbD7w9fkUYDYCI6rATtyFb8Z8kO8HtcOGYsbidwgu2LKlu0eikD
         DYzeUcAGgU6/bc+sCr/VKSm6/O4Kl0JuyaWCw8tD7v0yinVQgl/zK6XlVxHJ7n5Sl9+E
         4TGGCgUaJt+BgycwKj2iGINBoxTWBgpttWYwlumSjFmDH/Mt9tj6EnglqkP5IMxpsic2
         8gIw==
X-Gm-Message-State: AOUpUlEHM9xTCjdLNhzQCYZ/9qoeKEp334ZZgSpfkJJH3eZgnPknCYDk
        OLOjaMw8S3526jGXTMPE+Cw=
X-Google-Smtp-Source: AAOMgpcDRFVs99NjsQmjhM50gMAZd0xuhAC7b3WqS3BHEcg6boHCAb+0zIi58xypg7ZnwT08U6zfUA==
X-Received: by 2002:adf:e24d:: with SMTP id n13-v6mr113013wri.205.1533162397105;
        Wed, 01 Aug 2018 15:26:37 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x7-v6sm98817wrr.95.2018.08.01.15.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 15:26:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Stefan Beller <sbeller@google.com>, bmwill@google.com,
        git@vger.kernel.org, johannes.schindelin@gmx.de, peff@google.com
Subject: Re: [PATCH 2/3] config: fix case sensitive subsection names on writing
References: <xmqq7elbe8po.fsf@gitster-ct.c.googlers.com>
        <20180801193413.146994-1-sbeller@google.com>
        <20180801193413.146994-3-sbeller@google.com>
        <15bd43c8-361a-eb05-3712-e9fd02428b72@ramsayjones.plus.com>
Date:   Wed, 01 Aug 2018 15:26:35 -0700
In-Reply-To: <15bd43c8-361a-eb05-3712-e9fd02428b72@ramsayjones.plus.com>
        (Ramsay Jones's message of "Wed, 1 Aug 2018 22:01:21 +0100")
Message-ID: <xmqqftzx67vo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 01/08/18 20:34, Stefan Beller wrote:
>> A use reported a submodule issue regarding strange case indentation
>
> s/use/user/ ?

True.  Also s/indentation/something else/ ?

Insufficient proofreading, perhaps?

