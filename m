Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFDA21F89C
	for <e@80x24.org>; Sun, 15 Jan 2017 22:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbdAOWRE (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 17:17:04 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33697 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbdAOWRE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 17:17:04 -0500
Received: by mail-qk0-f179.google.com with SMTP id s140so103562947qke.0
        for <git@vger.kernel.org>; Sun, 15 Jan 2017 14:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FDe96KENPK99Zp8UjXZrM/bqlDMwiRU8dRQFC3LItQg=;
        b=MXx/8e8Nwn77tMpqLd41xaw5UEFVJB0ahJjXMNtsu8o8dJ55zXOkanrmLVu8+B3a6/
         tIgaVbF45E1qov9N76IkuCmRM2TCx5AFUaFHQ41lAZvBcr4fUuQDlc9aLie8BaOn2AzA
         Q+2x26LtWJVS1BUjCNXi1YGQNV4EfnrkGOTECu/UeTZCuhLtWAdfuspNwylxYZenaDJa
         WT+TfKRcBFbmkpM2GNRwXsmVRSPu89Zn+8Z9og8ZXyQ8/S+DHIzKl9K5ck6gjrIsC+hB
         /hVOVHtBtF9HFIl/8vCvmaV8OVFOo9lb4paLgP18b8ZB4ftm46NG+Xuh/TwFtLcNHxhL
         rAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FDe96KENPK99Zp8UjXZrM/bqlDMwiRU8dRQFC3LItQg=;
        b=XC/p1sx1ZwwHfGPkj1gYrxWPtZqrOTHs67pc5WMB8r0g29l5aGzPs0wj2jiQe8evro
         CbwzBamAXhG2MpdK7jUd8yILgGoUduTvLNthaKLOCC2tGLhLABhWjfg24pIxaVvB4lEJ
         kYdXRPn2lJovwI2iDUEyKy1V+Tb79P8n4j4/eoRluR+jYk5Y9NAPuDe0zjmgNJYbJis3
         i/Hv3NC4ghUkn3bRGXRD6WZQXN7V83pWvJ2ZJi2C/oKTAxJ524JlurHYXhdOdADVlrwb
         tiIA8zBAa2TXbtCo+vuT9fP4foxaBuqxbztOc1b75FPShxk+qrMXBPx8yi8yhIkzyssK
         5pqg==
X-Gm-Message-State: AIkVDXJxDSUJF4KX3te2dCE7uqVQopUDbh3ShtfK68LCOLkcVOnAk6wDi69lIHwZKc6S9Ecj
X-Received: by 10.55.97.75 with SMTP id v72mr31361099qkb.80.1484518623103;
        Sun, 15 Jan 2017 14:17:03 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id o7sm1374511qte.30.2017.01.15.14.17.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 Jan 2017 14:17:02 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v3 0/2] diff orderfile documentation improvements
Date:   Sun, 15 Jan 2017 17:16:29 -0500
Message-Id: <20170115221631.78838-1-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170111015720.111223-1-hansenr@google.com>
References: <20170111015720.111223-1-hansenr@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from v2:
  * The orderfile feature doesn't set the WM_PATHNAME flag when it
    calls wildmatch(), so document the pattern format accordingly.

Richard Hansen (2):
  diff: document behavior of relative diff.orderFile
  diff: document the format of the -O (diff.orderFile) file

 Documentation/diff-config.txt  |  7 ++++---
 Documentation/diff-options.txt | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 5 deletions(-)

-- 
2.11.0.483.g087da7b7c-goog

