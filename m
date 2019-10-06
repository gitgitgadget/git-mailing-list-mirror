Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5160B1F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 17:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfJFR6f (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 13:58:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42589 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbfJFR6e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 13:58:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id z12so6755853pgp.9
        for <git@vger.kernel.org>; Sun, 06 Oct 2019 10:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4vi7VOiDRr8NmB4nfCbU2v7byWC3GmqVvbh5BQFc2gY=;
        b=lpyl3VRdzvcViKtZvnpDS5u+tCMN0htbJW356IYi4a+Kfl0cOJXr7ZagnW34JsSxun
         Ci9ElNqzxg5ReVTTmggfDkOhxcyZw5trhaGWHXWg0/Ynpt6Hi8+MO9cOfQatHdAE2A6M
         LDarW0YOPxXOmKep6YNypJT26MZb70mf8p/1XIqBxfL/t5QzO1OaICeAW1GAaPRkTbOd
         YEfExULrQdaREUhSngWkReTt5kuAGGmM5DC9Sp/e9UdTA72jI7ZUqetjNJ2GeY0j8qGr
         jLlLHXM2TiUnVM68h84RWTa1bjtD8pisba+hMtmxTDRYPB0NJxwybdB03q8iAf+V5ZOc
         f/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4vi7VOiDRr8NmB4nfCbU2v7byWC3GmqVvbh5BQFc2gY=;
        b=mys5PNoz6ABY20OU2B/3q6UJGwEp80vc9pxEWTKvW7q3fof/ug1f/pWKF03Kp3PvK1
         oTXmDKMOOtUb8xJozGrZkPlnCajWLnDegYV6hksAIa1oce3U/yDmZihM184t19210hqX
         sn5t76h+I4KfaJ3vN2HxvxyleGurIFdh1zrfeN2JwFJeDmNSyun5y6XstanNIZxoB4iQ
         XGb6uaPvZcIT1EhUNZEckr5XBJULzzyOx42epSRDBiCVeA0r8DyVEIZMILOqr1+QMLLS
         YmmWMEnDUgXX/5qa9ySyMH1Br7TLVgMsY1ILoHgBLPeDIAF+Mcg0XuTHrL6vMGY6nofs
         nQYw==
X-Gm-Message-State: APjAAAUmJyJVlmt14Ze3Ga6cEUw+Mpx67KmalA+BtCTit9glIXd0JLeu
        WzvX4A93wlIg7dRdoVMDahRLEoq3AdY=
X-Google-Smtp-Source: APXvYqwPQn2zSZxacSdeMYToBYW3ttwm+EOzrfY+UsUmJ/59YsLbsPx7tiMsk+PMb9Xu4kzkPKdzfQ==
X-Received: by 2002:a17:90a:7d06:: with SMTP id g6mr27713855pjl.53.1570384713188;
        Sun, 06 Oct 2019 10:58:33 -0700 (PDT)
Received: from ar135.mshome.net ([103.37.200.227])
        by smtp.gmail.com with ESMTPSA id b5sm12884980pfp.38.2019.10.06.10.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 10:58:32 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     phillip.wood123@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        rohit.ashiwal265@gmail.com, t.gummerer@gmail.com
Subject: Re: [PATCH v4 5/6] rebase -i: support --ignore-date
Date:   Sun,  6 Oct 2019 23:27:47 +0530
Message-Id: <20191006175747.17340-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <5adde732-173b-d24d-d23f-bb4d043076d7@gmail.com>
References: <5adde732-173b-d24d-d23f-bb4d043076d7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 27 Sep 2019 11:00:58 +0100 Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> [...]

Thanks for all the advice and improvements.

> [...]
> It's good to see the new test. Did you see Stolee's email [4] about the
> test coverage of the previous version of this series? You should check
> that this series tests all the untested non-error handling lines.
>
> [4]
> https://public-inbox.org/git/1ed86989-9ba2-0cd7-b6f7-654d1943b1d7@gmail.com/

Yes, I've seen it and have improved the test since.

Thanks
Rohit

