Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E68791F404
	for <e@80x24.org>; Sun,  7 Jan 2018 20:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754538AbeAGUA1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 15:00:27 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36109 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754356AbeAGUA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 15:00:26 -0500
Received: by mail-wm0-f68.google.com with SMTP id b76so10847280wmg.1
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 12:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wVv9eLJyc3m5kV+3YLUDACPtOAhX64QY6MqAUIX/Oio=;
        b=qkWLBbCIMG6wY8zOd0cwUr+1skCS2Dtionv0vMEIh4Cp/KaMB3vxb5DVqeVASlOU1p
         yZ0KBNYUOTUgU5ncvpyVwkwQBKJCtAu3gFELcsbfefdvu7T1c8vJ7b54CoX93l6BFpwx
         /o/IQl021xM38aWHdv1AqKhqd+g6cZS9bB4hFy+vo40/HAhL5qu/57YrtQm/L0o86qGB
         l7iq6NxWuCqUCcdIbzMDZwtHb8/LxC8HoJiYKwLrSDJVHsbNHCZaPbrT630Q32S9dXAH
         Ph+si1AzQLOtNU1urNh8Z9DOErtkH0qHMsnwyETZDf/Lv7SjRrP8NfhOqw+u6S+WD7ov
         oo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wVv9eLJyc3m5kV+3YLUDACPtOAhX64QY6MqAUIX/Oio=;
        b=kjesLjflD7G3fjZ8/+UFWyUflYye/g5urctrSyX3LJ2nAXTnF8bxhN+fqmLRU4S4om
         EMqa5BvV45j9Cg6xYgSB4YpWzathVDmNRM2p5XIOEuhpJ/527vv6JSnvkaBoiYLXdt0x
         BmaAnnOLs87Myuc2d9Qzb4CMjieqTyYNkloRxV8appPFtHXAqafpm0xgtFzNpBS2RN2m
         PG1Weql5YUEmSuKVzQMxfK7YgLiblpmM/l1PGSgYr/3dfWkpORzgwTI5cfCuRrB9Wppt
         t1rZ7pDMjWiQty9zyobUJ/1JVzaMr26djMk4EmnbvwoTDpi4pW0me+Vy98K3VNCr3PSa
         Y4Pg==
X-Gm-Message-State: AKGB3mIg6j1ICmAFCXOqNrcboE1Y8xz8PsbMzBtLxPoJERgcJKUtv1sQ
        xFq1D5s3WOCoSnLwJxLOSTolz+wr
X-Google-Smtp-Source: ACJfBovpIpnXvf1KrbAMwvNCrDJNPRGPIurHFV25KJPs77htgJfyF6ZwET7EoxV4cxeuXnZtFAJ94Q==
X-Received: by 10.28.95.135 with SMTP id t129mr8082212wmb.100.1515355225322;
        Sun, 07 Jan 2018 12:00:25 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id j125sm10992915wmd.24.2018.01.07.12.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Jan 2018 12:00:24 -0800 (PST)
Date:   Sun, 7 Jan 2018 20:02:34 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 3/3] travis: run tests with GIT_TEST_SPLIT_INDEX
Message-ID: <20180107200234.GB24806@hank>
References: <20171210212202.28231-1-t.gummerer@gmail.com>
 <20171217225122.28941-1-t.gummerer@gmail.com>
 <20171217225122.28941-4-t.gummerer@gmail.com>
 <CA6C93AD-B24D-43A2-8AAA-DE98A4C9E719@gmail.com>
 <20180104201312.GD2641@hank>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180104201312.GD2641@hank>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/04, Thomas Gummerer wrote:
> On 12/18, Lars Schneider wrote:
> > [snip]
> > For now I think that looks good. Maybe we could define additional test 
> > configurations with an environment variable. That could be an array variable
> > defined in the lib-travis.ci "case" statement:
> > https://github.com/git/git/blob/1229713f78cd2883798e95f33c19c81b523413fd/ci/lib-travisci.sh#L42-L65
> 
> That sounds like a good idea.  I'll try to see if I can come up with
> something.

On second thought I'd prefer to just leave it as is for now, and leave
defining additional test configurations for a future iteration.
Having it configurable makes it a bit uglier, and I'm not even sure
how many configurations we can just test at runtime vs. having to
compile with the flag set.  So I'd like to punt on that for now, and
introduce more configurability once we actually need it :)

> > - Lars
