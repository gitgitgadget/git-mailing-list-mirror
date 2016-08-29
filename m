Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 814761F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 09:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757038AbcH2Jvi (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 05:51:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35744 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757027AbcH2Jvg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 05:51:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so8735088wmg.2
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 02:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wiNYZWLvETuZrCL3X6xiSlTpj+gSjw8jf0Crxf1tUO8=;
        b=ditGpfvCV5TaB5rqLYVO0kEANwOtcnEE79b0toUk/qt37wnSl2yPQmuqen5vMYlnc1
         SrsUEeAe9P+1rbCWYzUkCxu40xyj5KJwLWxTHM9CECYGX5nrtnTMMb0EUCHwdHdMCGjI
         ClyUt4OMMr12cxSs3Q9iy/iYRhnsEkM6yVFwCUZ5b7aNaGCsJ9Ra2FhR1Pm/WbSvjrIN
         YFqNWeTzFPbvV740GnfxNCdiS7AtaLyowwxnGni58HV1IQbv/lAUTWye5sVxJ9ulBfyK
         6z0a8VCq274nQIuMrnfQgLSKWXCh9Ca2d1FmTISwlts46JqmWGvww/YecR7K7pjgmXdP
         /cXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wiNYZWLvETuZrCL3X6xiSlTpj+gSjw8jf0Crxf1tUO8=;
        b=VSw1VLNrypZqC+CRbIJkyyqyjk9QuU73kF3Lh05wkFoVaNl8yGOAy/qVrRofhrHK+/
         n/CRzKBYsgt1+NHDitZvL7gYf6bfpiGGr1xSF1wyKZVkzcMJqd/5MJEY6ohGDECOW8u5
         ANVC7WHe0vrzogH6U63K7+5KsYyRG4Ix/GYSTQaDbjpJS+8d4cM6PA0hvCpc78CEFfi9
         2MRXtP+sZrEreVzJWGph+dRS2AM5y/HFySXiLvoGmQ9whExyn+RyL/mc9yIjHVxEoh9P
         vZV+jj+lPHqJVGfaGUWhxoOcagxcZVTDPfJj+QD4/nFYgp4htoMZlALOkhmc6MMiTZUZ
         tMWQ==
X-Gm-Message-State: AE9vXwOPA77IuumpsF9PWCfPf764dBkJjdZ/HbG89mhWeBJNE9IrajKvWZjMenX/Ac2B7g==
X-Received: by 10.194.222.194 with SMTP id qo2mr14249403wjc.109.1472464295114;
        Mon, 29 Aug 2016 02:51:35 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id n7sm33548785wjf.11.2016.08.29.02.51.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Aug 2016 02:51:34 -0700 (PDT)
Message-ID: <1472464293.4265.28.camel@kaarsemaker.net>
Subject: Re: [PATCH 20/22] sequencer: remember do_recursive_merge()'s return
 value
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Date:   Mon, 29 Aug 2016 11:51:33 +0200
In-Reply-To: <1f79d41e3417a0b1f0cffccc40e97f1a2c5ef987.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
         <1f79d41e3417a0b1f0cffccc40e97f1a2c5ef987.1472457609.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On ma, 2016-08-29 at 10:06 +0200, Johannes Schindelin wrote:

> The return value of do_recursive_merge() may be positive (indicating merge
> conflicts), se let's OR later error conditions so as not to overwrite them
> with 0.

s/se/so/?

D.
