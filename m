Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E4101F461
	for <e@80x24.org>; Thu, 29 Aug 2019 17:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfH2RBe (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 13:01:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46470 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfH2RBe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 13:01:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id h7so2858844wrt.13
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 10:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=sKMKpS7fN/0Cqu0WEZw87WMOTtCcLgqS3u0tsvsF5JI=;
        b=r+GEA91MsIVRkckoX8g9wHowPd0R9zdqs+PBw5zftrBDU0VC200zUyxe1CCXDDHqiK
         jBd2Sl2YoncEo1YmqR1/F+jymMKaNrpIJvjj0H8PukqkRhcnB9q9R0veOfYrOM/gRZay
         PxVPHzziaL7MVLBRqS2h5WFMy81PeTjLyIDd0d29cKM9mAGWrz9PKxgaUQUV5e56KVN8
         pZmrvUWVYW8AlCtZF1MVYDEPMId09RnfZwSpipcKdCGNXTL05aoC5C1L6jIZJJwurJf4
         u2/MOYtb34mCT3nHbT37UTkmlES4lb5HI05GbkjEK+FRvdkhrcPDwnB2Qx1ab9Tqq2kq
         2vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sKMKpS7fN/0Cqu0WEZw87WMOTtCcLgqS3u0tsvsF5JI=;
        b=IBlLLniP2GnPzJ7RTSmxEa3cUaYE5Az1N/t9SNvNAZiYffLe/TjoLmVzoWsvyoil32
         R28LCsJxon9/Wv/RYfhU9j6n+ZvDgNQac04DMlJe5cLAJ/9SyXQoD7IbR7SVG+BVJxIO
         A1qOc1RykIVx7CvAtGiGc/FL81QxzOujapBVNhZT0KqKByf78x528X0TPExSBsfABx3a
         xPF5YV2xNDWZK8+YdAgQ3VSdddsz/lgdEycdDKpoRK4Pxf4KLQ/Bq2o+gXgL8NMpYn5D
         jnPPlXVCULH4hSqvpWNWA01HvQMsV+Ny6h8ZEIq3Wa7izSIaCneCX6JZIpX5HErl0kdX
         i40Q==
X-Gm-Message-State: APjAAAWUyKrZl0D10OLmIudH6htzzedpJHt32XsBZWFZwsniY5umRYqH
        72HVxYgdgj/7j33G/tWXXlyrnSVA
X-Google-Smtp-Source: APXvYqyF8QIU2R7wcia52BbBAL+RIdVFsphVFE8QenEZ2gDLNgDABi3pC4+CEvyhNd8arcAVka7JZQ==
X-Received: by 2002:a5d:404d:: with SMTP id w13mr12953079wrp.253.1567098091887;
        Thu, 29 Aug 2019 10:01:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h5sm1903437wrr.10.2019.08.29.10.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 10:01:31 -0700 (PDT)
Date:   Thu, 29 Aug 2019 10:01:31 -0700 (PDT)
X-Google-Original-Date: Thu, 29 Aug 2019 17:01:29 GMT
Message-Id: <pull.325.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] checkout: add simple check for 'git checkout -b'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series replaces "[RFC] Revert/delay performance regression in 'git
checkout -b'" [1].

The community response to that series seems to be:

 1. 'git switch' is still experimental, so don't warn that users should
    adopt it right away.
    
    
 2. 'git checkout -b ' should do the fast thing, and we should check the
    arguments directly.
    
    

This series makes 'git checkout -b ' do the same thing as 'git switch -c '.

Thanks, -Stolee

[1] https://public-inbox.org/git/pull.317.git.gitgitgadget@gmail.com/

Derrick Stolee (1):
  checkout: add simple check for 'git checkout -b'

 builtin/checkout.c | 9 +++++++++
 1 file changed, 9 insertions(+)


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-325%2Fderrickstolee%2Fcheckout-b-fast-again-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-325/derrickstolee/checkout-b-fast-again-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/325
-- 
gitgitgadget
