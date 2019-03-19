Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B611B20248
	for <e@80x24.org>; Tue, 19 Mar 2019 19:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfCSTFI (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 15:05:08 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:39613 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfCSTFI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 15:05:08 -0400
Received: by mail-pg1-f174.google.com with SMTP id h8so14492066pgp.6
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 12:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Mh7xovj3Ejr/v2zFNTvokgB9LhmMh18X5heiKOG+mOA=;
        b=UHSicA76uc+0FVdb47Z8kNraJty4yUv/7AJLK2/FIGHEssI3IKErL5OvO6RbEP4Owg
         6laDEWrvzrPNmawFIHVCPjSlRbEb1x5xwBj2+aASxQYuP9sU2ns0YFrpgL/SzKCiYDXs
         5DVmkuE7bUVLeY6192Fx7r8ctDIkjL5psqJp2kBOQ9w0zWVzuk8Odav6u5pPabe/DbJv
         zZJgn058/NjFy+ru1VBbqqkMsPZ9bx9MRnQFPlvMJ8EeIyNjyd46Ar1kKR1aCf1E0hGY
         d1eubTofoDkhy3QlMKXeiTbeWixFvXzZ3JWW7IMS0gCL6WcEylHPvqx57fMzqFqIqkVr
         /RiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Mh7xovj3Ejr/v2zFNTvokgB9LhmMh18X5heiKOG+mOA=;
        b=UHNdUara7VP+0JY4GodDFi2HLaE3lGOJNqizg7Q6buKC3dyHCESOmlHi/4BAcy5Z0h
         rRq8t62qwBs4W3pG0JQlmbym6sXmKNB1Yh2WVoLllymKkBOncP9u7v8jggFpjevnar08
         T72I0ryNLRVs77fTcbgH7Rs0cveryp8zadj6InfTdfTeiYLFhCx87FNcztfazgb7hMGh
         OUvrOonIvTi+cs1accwIhbSanBaWJJstHGKrrY6n25rbQYj4La4EjWIdQQM1ymjKc7do
         JBsR7nQl6ybBLm6KSdZcdsxBMwjS5zDcZgbMrGs24Zy/Ws+EziflCSSw4My6cNlM4/UU
         +GCQ==
X-Gm-Message-State: APjAAAUg6YUwYheoD42WaHrvBnt9q5IuTG7w27m1BwyF+pDbiagUVtxr
        DgR+taXUKufUzASfd7Dzb6vLwubHpaI=
X-Google-Smtp-Source: APXvYqyHq3VMrx1vIVIto+Ly6rlkY132VaRtf0tA90ksH/s9dlRfZ6qvJy5wcT0m7f4ERNEAFzq75w==
X-Received: by 2002:a17:902:15a8:: with SMTP id m37mr3816938pla.178.1553022307144;
        Tue, 19 Mar 2019 12:05:07 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id k83sm24422631pfj.178.2019.03.19.12.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 12:05:05 -0700 (PDT)
Date:   Tue, 19 Mar 2019 12:05:03 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Matthew Kraai <mkraai@its.jnj.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [REGRESSION ps/stash-in-c] git stash show -v
Message-ID: <20190319190503.GA10066@dev-l>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I've been using jch's branch and I discovered a regression in
ps/stash-in-c.

Here's a test-case on git.git:

	echo '/**/' >>abspath.c
	git stash
	git stash show -v
	# I am expecting the diff to show up here

I am expecting the diff to show up but in reality, I get no output.
However, if I compile the latest master, the diff does show up.

Note that I can get the patch to show up using "git stash show -p" so
it's not really a showstopper. However, my understanding is that this
was supposed to be a one-to-one (bug included!) port.

Please let me know if we're keeping this behaviour so I can retrain my
fingers.

Thanks,

Denton
