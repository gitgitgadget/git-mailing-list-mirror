Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CE961F424
	for <e@80x24.org>; Fri, 27 Apr 2018 18:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757703AbeD0SiB (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 14:38:01 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40688 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753079AbeD0SiA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 14:38:00 -0400
Received: by mail-wr0-f195.google.com with SMTP id v60-v6so2634238wrc.7
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A1HciyKt/V46wtMtElf0xLlKk4Dg/jFGVsx2ASWA7l0=;
        b=CCdWskYGUXXKnYSr8B9L0U3q4ARqBanj5pROXfm+t9Yfchma5JsBiGjzPC8Tbb1jBW
         QUK3R14Gwm/cZRMPnvw5CzTJS9bs0QmtOSQYkNqWZ2DWaiTbyKgQINq/V3f3LDJc2Zng
         pA12+QAUxbuuCSYfyY6mlkxHkHm4mA+wI+7z2w5unaWBDE+HAXig7I5w/08jNII0dVjP
         LDImK0fXcVlUcucEsWnuYOf0S1O7ZoWg0RZmhPjwBQnFiXtcLENgwE/NDuan2WN1xoZN
         QOt+GmSpyd2qrtvh1mJkY0vyxXtYYkkwyDSB21sdBneJ0Vm/SvOJg5i/x7sdM/9Go1VP
         isWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A1HciyKt/V46wtMtElf0xLlKk4Dg/jFGVsx2ASWA7l0=;
        b=qxuUpMjw9xdRVAOU0G9dCEZr8iuw390dFSeUoVH9n/WyGSEAryndkGrqEK9lUPQgeJ
         f4mgfG5DQFxzVpfL1DEDDln3sZW2NycgUwzL3usysK1lnbN8svcuNwoyMjVejxpdKJOK
         RwVsbq+bJTMpk93l1ZVjYTHl/ypgOIX/1ha88wqoFr1/JgeqdMNPl84+6GbqK+emhBBg
         wwt/TAEF9xWr9Txk/9DxUaVv7SFN8PwijTXSj3WN4f6paHN4eWEjJDjKfWqtHKrLU16/
         wAxJUXJU5aGim90j5H+DfXLizIMvag3Hu6wwdgPDvCliN9UaYpiPKcEiQaZWC8oTpKBT
         Y97A==
X-Gm-Message-State: ALQs6tBMe1Ki49Z6aqIzszSkj48uCW+Q62D2FrKr/KbO2Csjzzl2er/6
        jGvU3QIyOUp5wuypE8s0hQI=
X-Google-Smtp-Source: AB8JxZoiEmOCjBQxwthURgSeYEFJazed5UV2QqgGwniU//1CADJfKHaZG66smAH0zim/rTTEDWltXQ==
X-Received: by 2002:adf:a158:: with SMTP id r24-v6mr2662591wrr.191.1524854279229;
        Fri, 27 Apr 2018 11:37:59 -0700 (PDT)
Received: from esm (ipbcc18eac.dynamic.kabel-deutschland.de. [188.193.142.172])
        by smtp.gmail.com with ESMTPSA id y42-v6sm2428585wry.21.2018.04.27.11.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Apr 2018 11:37:58 -0700 (PDT)
From:   "Eckhard =?iso-8859-1?Q?Maa=DF?=" <eckhard.s.maass@googlemail.com>
X-Google-Original-From: Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@gmail.com>
Date:   Fri, 27 Apr 2018 20:37:52 +0200
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>, Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
Subject: Re: [PATCH v3 2/3] merge: Add merge.renames config setting
Message-ID: <20180427183752.GA2799@esm>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180426205202.23056-1-benpeart@microsoft.com>
 <20180426205202.23056-3-benpeart@microsoft.com>
 <CABPp-BE29rwZCDqFHH-nzrDub6MMdtoiorj0jv3K6B6cmfcaLA@mail.gmail.com>
 <7de8f144-8a37-e471-48e8-0b6f17a7bf29@gmail.com>
 <xmqqy3h9z8sj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy3h9z8sj.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 27, 2018 at 11:23:56AM +0900, Junio C Hamano wrote:
> I think demoting from copy to rename-only is a good idea, at least
> for now, because I do not believe we have figured out what we want
> to happen when we detect copied files are involved in a merge.

Does anyone know some threads concerning that topic? I tried to search
for it, but somehow "merge copy detection" did not find me useful
threads so far. I would be interested in that topic anyway, so I would
like to know what the ideas are that floated so far.

Greetings,
Eckhard
