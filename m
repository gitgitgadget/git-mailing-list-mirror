Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7AD21F859
	for <e@80x24.org>; Wed, 31 Aug 2016 18:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933969AbcHaSjj (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 14:39:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36673 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933952AbcHaSji (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 14:39:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id i138so8842044wmf.3
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 11:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=deudpQ69mUX0x37E/bAbpiWv5kmqm/xVg4rTn/VgHVw=;
        b=KD1UWWd+HZ3+p9IJFlAJ2WejL3s5P0B5uTeh7/eIUOSev97NovW3heFyr6j5qPRi4Z
         4Gcw+b6sf1sEVoQzClmyHHxhFkhAcwYkjY0LXDx3vovGGUEFwIDfwHSYiVVw9VFhcdE6
         VrmPC+sd0H6ucxtvGI1qLyVYbfk0utmVho0tAY7m1uQA+PSsOsXeTIVT6ppSy+fqTBUF
         njIE3qz176+/jOUImoI1XCT2tx8i81J73UXrofbDaa1pstzU13lXEdikoTwdx883SbA0
         ZvcAEH7CUmIO2o0UGfKGb8CgdFra7dkXqzNi+T6SLT0N/3Pd6pLPPFwVnm5kQC4o3ahD
         arDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=deudpQ69mUX0x37E/bAbpiWv5kmqm/xVg4rTn/VgHVw=;
        b=UPyO6JZ5d87Un9IXioOO9WpV4y9Ajq5/oQb/RnS0izHxOABp0FPtPFKS9zmBrg7DbB
         r8QJd4iDRavaslL1PmhQl07Tgd4IwahCPtUJtIdKRViuuVf6+4QcWFec3LoOuA8ajwX2
         C9+c1+GJ4sw8676B3w5SCr8GNgbJtLulbIdEkkXo2746fpYc1m7IUx5D+drGCmR1F4xg
         457mmID4aKjueacZpfP/PfWUJwJ+1l23vJt/FD9eHZYkyNWTlxlfRF44bKupe+N4BiNh
         V3xtWDT1xOpJP+9xq/IHniWU/igWm6czIGwDz872htjkS/wUHLZwl6X7i/H3lHYsVBH3
         gSag==
X-Gm-Message-State: AE9vXwNIdP+aiIQAVbo9mnW5wudbM9psbHIj4S5IsM08aiAlIHPsM/hK8PYnC8txwPpriQ==
X-Received: by 10.28.25.71 with SMTP id 68mr21842798wmz.19.1472668776872;
        Wed, 31 Aug 2016 11:39:36 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id yt4sm1097492wjc.48.2016.08.31.11.39.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 11:39:34 -0700 (PDT)
Message-ID: <1472668773.4265.75.camel@kaarsemaker.net>
Subject: Re: [PATCH 00/34] Teach the sequencer to act as rebase -i's backend
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Date:   Wed, 31 Aug 2016 20:39:33 +0200
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On wo, 2016-08-31 at 10:53 +0200, Johannes Schindelin wrote:
> This marks the count down to '3': two more patch series after this
> (really tiny ones) and we have a faster rebase -i.

I got to 16/34 (and skipped 07/34), will continue tomorrow. I hope the
comments are useful.

D.
