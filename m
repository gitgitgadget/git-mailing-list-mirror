Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58F7F1F453
	for <e@80x24.org>; Sat, 19 Jan 2019 01:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfASB0p (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 20:26:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35884 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfASB0p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 20:26:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so17209229wrp.3
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 17:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=lPfFr48HUJxtv5JDad2CoeAwL4cRvAEQP+VPP1knEMI=;
        b=Z7s9ENA6z2ohpjwr01nkCi/SefI0RD12/55rC65jyPJrGg6ZRzx6PKy6KQEvoEjjjP
         4kZvaLi9NW/twtHX4EbFnnagXeOzpWLskz82bh7K66qiKpJUQMBSm/ECu/9tjeLKHrtZ
         /dvaLrV0wYSJ+c1Gm+EcV/TFghLik3g3EBH1WKGJY/8fP2c5ewk7KjZtO3P3Jhrit276
         VGYvzvNxsCrUGBCqi3a8kDlPZRRCBnLHpgOT6N5ssCWUjxSdADDId5MKU/022Wo0PNzA
         abtIQppmhvC/4VVrwGTotFOls/iRR2aARWVEO9WGbg9/9SNSlRPal8c8/rhB4i3RJMm7
         gN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=lPfFr48HUJxtv5JDad2CoeAwL4cRvAEQP+VPP1knEMI=;
        b=uMFIY9sdPjeZQ57p2+BBPazkK4XDxJuzLdqm0Sl7YRvnfjNHi9B6qPULgfgVsblWW0
         KznaDrFcAc1wwAjA4cEPaI6cuyjeFeqGhQPMwOFmcxc7ZTQFPxGGNRZoRl0Cl/MHd8ZA
         1P/9OZST0e8cwF1oUl1bo0Y4bsFfCB47cCKyP5w99cBTDlGo3c4s2bkz6zBbEiaQ1ZMq
         A61Id/biJBvGu3cozlRQ9yIBgRR+sXZmM5DLhGu3cVEWQi8OLYf2HtRW8EMhWINW/l2q
         jk0ursWANcLsWZxxzy7jGU25/xTMSDl78D+FUAcL6pBCNudbGxLOnw7T0yUQqovtf2ZA
         6bUQ==
X-Gm-Message-State: AJcUukdqfppZzfYN+/KKsDEH2rt97lsNL8Mj96Hebx9e1gIdM1yqhGhv
        ri7FxPoD6IpKGJq2M3BealY=
X-Google-Smtp-Source: ALg8bN6hUoXvNBDZSt3o5SKr+itTzywW/8/XpKZAeIDxCP9CXq1tOn8En6kOMrEashvayInVy7HMCg==
X-Received: by 2002:a5d:4d46:: with SMTP id a6mr19074176wru.28.1547861202971;
        Fri, 18 Jan 2019 17:26:42 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x15sm96458970wrs.27.2019.01.18.17.26.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 17:26:42 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com, asottile@umich.edu,
        pclouds@gmail.com
Subject: Re: [PATCH v1 0/2] Fix regression in checkout -b
References: <CA+dzEB=DH0irkFaRzkKERSjdZ=EJ+mG3Ri2Xeobx9Yu_eDd+jg@mail.gmail.com>
        <20190118185558.17688-1-peartben@gmail.com>
Date:   Fri, 18 Jan 2019 17:26:41 -0800
Message-ID: <xmqq1s59igj2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

>   checkout: add test to demonstrate regression with checkout -b on
>     initial commit
>   checkout: fix regression in checkout -b on intitial checkout
>
>  builtin/checkout.c         |  6 ++++++
>  t/t2018-checkout-branch.sh | 11 +++++++++++
>  2 files changed, 17 insertions(+)
>
>
> base-commit: 77556354bb7ac50450e3b28999e3576969869068

After applying these two patches on this exact commit, I tried to
run the usual test; t1090 seems to break.
