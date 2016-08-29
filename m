Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4121D1F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 09:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932626AbcH2JTZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 05:19:25 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37945 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932346AbcH2JTY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 05:19:24 -0400
Received: by mail-wm0-f47.google.com with SMTP id o80so81385798wme.1
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 02:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=seDY+ZX7/kNtMf3PDvnYu9vsMbqYS/sf2FWIPVjZ70s=;
        b=UOSOxAA4y5OUPuYLX9ga/eJdeSrE0hPULBykFS6DM3yAHMNCNR0/kKFT/fpxBy1pSU
         h2C5aKEdupbDurl1DQTHpJ0RW0ybQoC6RP0Sic5uFbCyMhtKuSIMw2FiooQEF3Lan9LV
         JD5LwO+sWw8/3njgvctk90q00OGEFIEiRofQWjNYskuZtRJR15DbB0H3Z6M3D+z0ygzl
         ynYMBUdQQiwBDpOf1W0sETd1TuqyoPfot+81q5+mcPCVIP8EpaPsE4RMKSdpx70cFJL3
         lhql7JvqA2GfC1qGJvfu2PE8srYo2sdRLA6Z9A0zQL+8sF2O9AO3BzXJUtsWMfhlCHWP
         bLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=seDY+ZX7/kNtMf3PDvnYu9vsMbqYS/sf2FWIPVjZ70s=;
        b=aNQO4V2lBaIobdYQyv2hR/8vInIX/jGlnFsqmXatQrSavWV6eiRHZYFUCej0ER+5PC
         jC3Roe+HK5Rg4uMpsm/M+PH/hyZ3d+EBUZ3w2epRiuR0zEPl0LKJphEhgUESND4Xlaxe
         8q5a45Zp5u4OZq3IFzJure9OZy7JnsD2eB5qJIbYxwuqZNfjpHG2RdPfUYXnp6mX0PAW
         WnVlaEGO89lCEWEMM4l6uPjOFBz8tL6kb59npptc/BjZpYngAkehqXKuVRci1x8uErmJ
         LI+wbttVxY5o4maIsqcTgn3HZr8fbVkNy9sNjiCVITwBPbcXAT3sdEVz0EoddxuPnPq+
         /fPQ==
X-Gm-Message-State: AE9vXwNIv2Zg6AqOf9uD9ddH+ATOYfoN7cUBgcASad1Lra0PW52UQOVLSMQ7NrjWwhDiww==
X-Received: by 10.194.77.174 with SMTP id t14mr16020358wjw.146.1472462362616;
        Mon, 29 Aug 2016 02:19:22 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id m5sm13494988wmd.1.2016.08.29.02.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Aug 2016 02:19:21 -0700 (PDT)
Message-ID: <1472462360.4265.21.camel@kaarsemaker.net>
Subject: Re: [PATCH 01/22] sequencer: use static initializers for replay_opts
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Date:   Mon, 29 Aug 2016 11:19:20 +0200
In-Reply-To: <66d69469a64bd80d3bf2b99a250ae04a649d94d1.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
         <66d69469a64bd80d3bf2b99a250ae04a649d94d1.1472457609.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On ma, 2016-08-29 at 10:03 +0200, Johannes Schindelin wrote:

> +#define REPLAY_OPTS_INIT { -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 0, 0, NULL }

This looked off to me, as it replaces memset(..., 0, ...) so is not
100% equivalent. But the changed functions both set opts.action and
call parse_args which sets opts.subcommand.

D.
