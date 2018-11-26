Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4D231F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 16:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbeK0C5C (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 21:57:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44129 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeK0C5C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 21:57:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so15187815wrt.11
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 08:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=urvmQ4V1IZJl8G+pAgdPPe+H9uozr2IDr01WLlLwAB8=;
        b=FcHnIw04jKG5r+3S3ScEl7Kp0/arXYK30745kZ2URdJyQnG+dwWN61BBAz3rOKu9Hb
         R9GA+r1dApHwXoz9NCrWiBl/gk0YbTe+0nSsH5x4pAqGn994ddueJ4y19f+AUiwhMPrW
         tVnwOaLX0oHbccagKqp7GXdBuBGFvKwZkdE2c3w0CvLNTbb96ZpBH7DxzIAYpUCZ4JWz
         I6TCZoSb18QEx7mYYLpxGFw+J11F/mvI7805FlQb0z9zSjXYjmzr7e/gc+iu9DaBd1l5
         IySlVuZ5t43TiLKLlp+HOD06pVPatHwQPXZpUB0gavnFF/6KqpzexXtEwVTUTf+7yqO8
         hQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=urvmQ4V1IZJl8G+pAgdPPe+H9uozr2IDr01WLlLwAB8=;
        b=hDVHSFL6gRmfOY9lohBfK+5o+XTFNkJibOdZ3Esy25d5bBbYyUetb5i+Wu/YixuZPC
         QrBSEZGgWRPkH4zDaTEAsX1MRr8NLBew2vCNPGpCNHF0yts5JldnATKiCCzt8HCAOTfy
         BUb5DR0Bxb+1oTOfdqoksCJo1dkv5mmAXRZd0Jgr1aN1tqBvapMd8Tdlq00giusaa3lq
         JasOiIn6mwZ2UuV2St47CYwRLLWgEQ4iIdUmEH1xwYfRPCyV9/Dcnje0fhzxExvzc4kV
         9tRPZBGW2INwCVcuqRqvN2EtVqsSt5+n+JTLG9D+toYs0h1cQiMAg4cGiG7CnlwfuW9E
         lQiA==
X-Gm-Message-State: AA+aEWZUeqsFwyUB+DJSlKLhb7ZdT7rsA8YOTB2r3m5LIFlX3NbdNU3O
        z3r/YFDI7NOKPQJAFixt2pk=
X-Google-Smtp-Source: AFSGD/VR1Kq7ZbBoNMhZcZX0eOCJhQfHOkZ+tUrVFI24rURzDJKkhG4f4g0uBq6hgdH3jODzuqsCEQ==
X-Received: by 2002:adf:9f10:: with SMTP id l16mr24855918wrf.206.1543248148980;
        Mon, 26 Nov 2018 08:02:28 -0800 (PST)
Received: from esm (ipbcc038b1.dynamic.kabel-deutschland.de. [188.192.56.177])
        by smtp.gmail.com with ESMTPSA id z13sm388092wrq.19.2018.11.26.08.02.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:02:28 -0800 (PST)
From:   "Eckhard =?iso-8859-1?Q?Maa=DF?=" <eckhard.s.maass@googlemail.com>
X-Google-Original-From: Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@gmail.com>
Date:   Mon, 26 Nov 2018 17:02:26 +0100
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Per Lundberg <per.lundberg@hibox.tv>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Clemens Buchacher <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
Message-ID: <20181126160226.GA20885@esm>
References: <20181111095254.30473-1-pclouds@gmail.com>
 <875zxa6xzp.fsf@evledraar.gmail.com>
 <871s7r4wuv.fsf@evledraar.gmail.com>
 <20181112232209.GK890086@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112232209.GK890086@genre.crustytoothpaste.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 11:22:09PM +0000, brian m. carlson wrote:
> This is going to totally hose automation.  My last job had files which
> might move from tracked to untracked (a file that had become generated),
> and long-running CI and build systems would need to be able to check out
> one status and switch to the other.  Your proposed change will prevent
> those systems from working, whereas they previously did.

Wouldn't those systems not use -f right now? And shouldn't Git have the
same semantic for -f to clobber everything in the proposed use case?
Like it does right now for untracked files which are not ignored. So to
be save going back and forth I would expect those systems to use -f
anyway. Have I missed something here?

Regards,
Eckhard
