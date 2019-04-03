Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B97920248
	for <e@80x24.org>; Wed,  3 Apr 2019 22:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfDCWAH (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 18:00:07 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:38492 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDCWAH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 18:00:07 -0400
Received: by mail-pf1-f169.google.com with SMTP id 10so255014pfo.5
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 15:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=IE3MBwe4s5g0Lx1vCmIN/22wLrgdWfyH5d30wwP6/BE=;
        b=g18Wpz1fFg3uLWYBhUngjZwwH47tX3yuSyekRZSj6nitPEhLE+EPWkzj74L/qBS4sO
         mLZ5gI0Tw4QQyHJPV7lIDfEWb5HTkrMdKf5bxPmOJdyJg6QV9I2WG2B1fLikyv/yeoe1
         HwV9LdfH+TDNEcwOvTuxiWLGTUE3NCPv1iHBTaAyadrKuF36srdp0ovhL3r/B/lbKPc/
         l5Mlx9iT/ePbTBT5wFW8jmMxefR57mDDSgS24beR1OnN1VuRWJkG/tu/fLc5I6o8nFit
         OSzyOrb5H1lJMjPSFfKCXZdu+8SbEoocTdLX2sC74fN5nFmyWh7vzjSv5zjb9gD5QqBX
         GjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IE3MBwe4s5g0Lx1vCmIN/22wLrgdWfyH5d30wwP6/BE=;
        b=BdPZyOP/gSCMAS8GJQdkYIc1t0kW2uNUsacB927Ua8NANDdLDZfBt8JPae5EmsQ3u0
         Yibgx1XQuDUdOb1eIzepxnx6ZAJd7oq6y3Xz1nSuafe3QObSWAUbqyypPB0QnOJsOzTY
         Q8hGBqji32Vbd7EpcszYkUkolbHfFJaHXYoPxwWIop8H/NSF7Pn56u4212WRS/kS4RMI
         jaok1wSCB4ANEzQGDgcO1lAXAW6FvGw3BCOGfZkxr1Ks0GWfUMCkPg6h3ojI9b1BWHEM
         wi7Fhf9tCfhJohaidKaTIpTaqaFd4DP6l/PprlfgIJOx3H+Bn9F9/4ES/ygTAcDayGMZ
         OL6w==
X-Gm-Message-State: APjAAAXuKVghgcw8bwkwSYgNNVj4za3G+s/sSRZEN80ZqVnz6lM5zmXq
        LCKEmUXo35r6ZPIKa+1rhu4pTmX8
X-Google-Smtp-Source: APXvYqzyeWn4sGz/yigd5MaVS+7OKfIy30mVmiu0iTsMyTwNGYrW2z9wMQXfm+Ux4Atax2/5qj8UJg==
X-Received: by 2002:a62:1815:: with SMTP id 21mr1917258pfy.107.1554328805717;
        Wed, 03 Apr 2019 15:00:05 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id w3sm42214137pfn.179.2019.04.03.15.00.03
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 15:00:04 -0700 (PDT)
Date:   Wed, 3 Apr 2019 15:00:03 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/2] create FLEX_ALLOC_MEM to FLEX_ALLOC_STR cocci rule
Message-ID: <cover.1554328261.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was playing around with coccinelle and I noticed that we have a use of
FLEX_ALLOC_MEM that could be converted into FLEX_ALLOC_STR. Convert it
and write a cocci rule to prevent this from happening.

Note that this was more of an exercise to teach myself how to use
coccinelle. I'm just submitting a useful patch that came as a result of
this. Please let me know if this is unwelcome.

Denton Liu (2):
  midx.c: convert FLEX_ALLOC_MEM to FLEX_ALLOC_STR
  cocci: FLEX_ALLOC_MEM to FLEX_ALLOC_STR

 contrib/coccinelle/flex_alloc.cocci | 13 +++++++++++++
 midx.c                              |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 contrib/coccinelle/flex_alloc.cocci

-- 
2.21.0.834.geaa57a21fa

