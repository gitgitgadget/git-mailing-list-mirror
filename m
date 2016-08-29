Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF5A21F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 09:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932642AbcH2J5S (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 05:57:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36164 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932584AbcH2J5R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 05:57:17 -0400
Received: by mail-wm0-f65.google.com with SMTP id i138so8731262wmf.3
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 02:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=My6aUGDfg4srERe89BJ1QUBzvHivLW/0XUUCDhCL8xg=;
        b=Am/rKodJf/LhZLmsCxGRAg/DKf+pTmqhgzU05ajZokAAMgGPgPZCLEvVDZHvTMm9eh
         QROR5wuPlrAw69sCPp0/p27CQOk7pA2PyRVRvkW/85/OBf5g4nXLH1tQ8GT8RxC6icIy
         9uEFAggs5mB7cD5ZDHBG3jb3rI1PvIb+PxLK5yIGRI6ONZALH3CzljeHt5Obce9r2WT0
         iRqTqbshy29Ia2qsHjYSWf9hBVnDxdHKpVXp43tq2qRmQypOusddQlsCTuHF5klnv8Qv
         EKNvwrXCs4RZgfW6FUtHlcC0eaE2jjAvdYD8nt4elMAI68FJQhpfSNiGlovg7BbWCnwQ
         0Haw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=My6aUGDfg4srERe89BJ1QUBzvHivLW/0XUUCDhCL8xg=;
        b=N6jr7VdzUszf4U2x79SCN0chtLbXh1rrCuDyVI1UGjPbO7j3Us0YGz+XnDAfGSd+xE
         WubIDtzhQNQHIvwC2QS01AdL3aHzCBYA84ca4YD3TE/pj+zSFcgL43IEupP8WLeSf3/+
         dJwZr2lmQmuhY20u8ST6Ndyv0IUs2lq6q/7mJgmPuzoy2YVhkWOA5oXdy6CoXxlQQQQl
         a7za3Q/w3lq37e8QjqmUqYGlW5G6bNf74pI3isxdeJSPxpDJ6yDGhUsqYy5SFvUt3/FI
         Kqp5Of5PPlifNInD9SLV0JR+Ejd7PbElV5NnPcgD1gmKcUvR9qrAOS/ZIzQPUdSLsb4W
         877Q==
X-Gm-Message-State: AE9vXwOzNcAUiUr9PJIDZf5XCMJz4xrdn3gYD+gY5PIyPUzlfMsC3MwYdmM/5uUGUIWmOg==
X-Received: by 10.194.126.168 with SMTP id mz8mr10080050wjb.27.1472464597901;
        Mon, 29 Aug 2016 02:56:37 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id w8sm6743537wjj.45.2016.08.29.02.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Aug 2016 02:56:37 -0700 (PDT)
Message-ID: <1472464596.4265.29.camel@kaarsemaker.net>
Subject: Re: [PATCH 00/22] Prepare the sequencer for the upcoming rebase -i
 patches
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Date:   Mon, 29 Aug 2016 11:56:36 +0200
In-Reply-To: <cover.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On ma, 2016-08-29 at 10:03 +0200, Johannes Schindelin wrote:

> Therefore I would be most grateful for every in-depth review.

Tried to do that, but could come up only with a few nits. I think the
approach is sensible.

D.
