Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A63F1F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 22:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfKRWa0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 17:30:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40031 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRWaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 17:30:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id q15so8660157wrw.7
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 14:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cS2bzFP/oiedtl+UasziLX6iVUmcp29A/7MBfSKsdgo=;
        b=jZukAd2KHONPxUuoqrT5ViTQiioUtwGSGbcEP68JDvcjR2Bm2KUoyNVat1ZRPMDKw2
         UyzpiRXo0unYR65IGqSNVBuwRsei29Zrb5Dht2SI6xVnMcPP4tHZRvypsRsT3SBYHByo
         rHtIpL0g4KHYJ2xSRbrZXtVdOqht7zPsLd5oS/Be3DiU1RexrNss5WZOVCXm6tTeJlja
         GS62EBeYB5dw91+bnx6QCMiuxRr9OWesUsa/5fU3CL38KE9b+w/iyobZz58a5+W6CqUg
         Io7HmF9CDT79L0ZZo4+u5Bv9Qhh4FrdXmxPnltD0M8hQvZZpMM9TuscMJkW/r0T2Y/jh
         RojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cS2bzFP/oiedtl+UasziLX6iVUmcp29A/7MBfSKsdgo=;
        b=jTl7IujrER1p5tofQyBn/JmGy1gmQgeFIBpbiUfTCYSx8/22f32aRFUBwJ2jmB+xWg
         Zm0vb1hfhZ+fSzZGqNWMmYeSKIs9sti2DkB4PYsonhChmPGGNJwaGxQoiMxUbsbRbL+F
         0Q4wjATJ4rUp0ol8UOG0DfPJMqFB3wEh1q8ZYQHP8cVUV1KHMA3fMvV2KhLhOUz8+N4s
         uJTf/4jTaK8kw1RiSIxAUd1NkbacGJl6EmZAfnXyKLifE3UQ98J/tSW5lj+ZgzzE+NAq
         uQDhjzfffnf3gle+bmIJ3wC35ARe9ByBKdKhMSWHgfr/f4n5Ac54b7XYxbfogHQgDvKC
         f5CA==
X-Gm-Message-State: APjAAAXM9lpwWGDaZMg/E+sjp03lzTlmw9YAuf3CKxl+hOP1SFsl5uw5
        1xvW3D1Sm+x/XwFZ1NLBnf4=
X-Google-Smtp-Source: APXvYqwxLclrf/pIGRAeunMquYYeOsrgjwVSPQOvtMMl8p6CFF6MENWNhYs56KEWux8IkNfjKuTjvg==
X-Received: by 2002:adf:e449:: with SMTP id t9mr34665039wrm.196.1574116223807;
        Mon, 18 Nov 2019 14:30:23 -0800 (PST)
Received: from szeder.dev (x4d0c3ed7.dyn.telefonica.de. [77.12.62.215])
        by smtp.gmail.com with ESMTPSA id j12sm5316558wrb.82.2019.11.18.14.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 14:30:22 -0800 (PST)
Date:   Mon, 18 Nov 2019 23:30:20 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: do people find t5504.8 flaky?
Message-ID: <20191118223020.GB23183@szeder.dev>
References: <xmqqmukh5tj6.fsf@gitster-ct.c.googlers.com>
 <20190423030254.GA19604@sigill.intra.peff.net>
 <20191113000747.GQ4348@szeder.dev>
 <20191113010337.GA20023@sigill.intra.peff.net>
 <20191113020719.GA435@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191113020719.GA435@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 12, 2019 at 09:07:19PM -0500, Jeff King wrote:
> On Tue, Nov 12, 2019 at 08:03:37PM -0500, Jeff King wrote:
> 
> > So with that second patch above, the test failure goes away for me.
> 
> After poking at the behavior around connection dropping, I've convinced
> myself this is the right thing to do. So here it is with a commit
> message. I can't get the flaky test to fail anymore, but please let me
> know if you do.

FWIW neither can I.  I clocked in ~3 hours of --stress with the patch
applied, and no failures  (before it usually failed within 30s).

