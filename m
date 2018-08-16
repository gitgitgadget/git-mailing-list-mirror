Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A21231F404
	for <e@80x24.org>; Thu, 16 Aug 2018 06:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388856AbeHPJJj (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 05:09:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33722 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387491AbeHPJJi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 05:09:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id g6-v6so3056948wrp.0
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 23:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rgCBPEhV4gacAR1O6Zxe5iOScuCYy+833Tj8UmkEGqw=;
        b=jsPlFeQ6fHCImc7Yyk9hDYotGdKkBfpwXV7ariPLio9pTU5W/UvTinQGjnAcPbO72/
         Vuq/4jfdN/4+zM3eEFGCQoF2TrKH9mDIlr3krqXY8Ame4u2mKImybhzTb243n8dnFcmi
         9HNj06pkHKza2n69gfjYE3WnWk8luPA6sOorcOFIZ8WSzVd3n471Xln3Wa7muRZw+rB8
         En5ZG/D+LUx4SpPJIjbyGYzd1Tv9Y6aXiLMj6KrE7DyPlx8W6ijNcSYymTdS7CkDcKSI
         UW7Nk/FOvgsjkJxxf+d8WTt181jGuyrE6z/EbwWtmNx3fhEYkyeEUmNYtlf4APBr5xZX
         lFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rgCBPEhV4gacAR1O6Zxe5iOScuCYy+833Tj8UmkEGqw=;
        b=dcrCi5xRkcPVj2CJbrbV6+zeX2JlKJCr3I4XtEodfaflqlrH0ZMspax6+PJhlw5F31
         4WWuQ6vZ/n0fdDU80ipu9gfFge1LiHNerHpVdq/BOJg9Txs4zkJKIZyjE2b+0GvoDwMK
         E++8B+WtKNh35uBTDxKGeohJorQjTWrSxwRBjEBU8G1JUl7uVXUplhmTyLz3SYMNFFhe
         SeXq0ZMVSUKhs4QXpNVFjNT3zd5SnIzRneVWoy4gsnptt67jHQwI63/MeFbyb46a84/d
         D3gLZVle6Jf5IWRgvo5XxuE8kUmlmEBXQmmvbZlh1o7ae7nrh5QELO3VXBEh0XkqNjAn
         EZ6g==
X-Gm-Message-State: AOUpUlH3/TVj9pU46ipvYhAHBBs+UawHVTOQsONbJtszQTPvX08QedBF
        qAN3Ai/XYHbG7g11hhZsVyxPglZ5
X-Google-Smtp-Source: AA+uWPyuflvbK/jWm24rKAzAyca4p1an9USm7J3lo9twYpMj0OZuNCQPH2PKRWuH3z29SGgR5NuS4w==
X-Received: by 2002:a5d:6601:: with SMTP id n1-v6mr17662050wru.281.1534400009656;
        Wed, 15 Aug 2018 23:13:29 -0700 (PDT)
Received: from localhost.localdomain (228.14.112.78.rev.sfr.net. [78.112.14.228])
        by smtp.gmail.com with ESMTPSA id d8-v6sm22325182wrv.68.2018.08.15.23.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 23:13:28 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER Gabor <szeder.dev@gmail.com>
Subject: [PATCH v5 0/7] [PATCH v4 0/7] Add delta islands support
Date:   Thu, 16 Aug 2018 08:13:06 +0200
Message-Id: <20180816061313.19298-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.673.gcd86e60100
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is upstreaming work made by GitHub and available in:

https://github.com/peff/git/commits/jk/delta-islands

The above work has been already described in the following article:

https://githubengineering.com/counting-objects/

The above branch contains only one patch. In this patch series the
patch has been split into 4 patches (1/7, 3/7, 4/7 and 5/7) with their
own commit message, and on top of that 3 new patches (2/7, 6/7 and
7/7) have been added. The new patches implement things that have been
requested on the mailing list.

I kept Peff as the author of the original 4 patches and took the
liberty to add his Signed-off-by to them.

As explained in details in the "Counting Objects" article referenced
above, the goal of the delta island mechanism is for a hosting
provider to make it possible to have the "forks" of a repository share
as much storage as possible while preventing object packs to contain
deltas between different forks.

If deltas between different forks are not prevented, when users clone
or fetch a fork, preparing the pack that should be sent to them can be
very costly CPU wise, as objects from a different fork should not be
sent, which means that a lot of deltas might need to be computed
again (instead of reusing existing deltas).


The following changes have been made since the previous iteration:

* suggested by Ramsay: fix typo in "deltified" in commit message in
  patch 1/7

* suggested by Ramsay and Peff: use FLEX_ARRAY when defining 'struct
  island_bitmap' in delta-islands.c in patch 1/7

The diff against v4 is:

=======
diff --git a/delta-islands.c b/delta-islands.c
index 2ced34d99c..8e5018e406 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -35,7 +35,7 @@ struct remote_island {
 
 struct island_bitmap {
        uint32_t refcount;
-       uint32_t bits[];
+       uint32_t bits[FLEX_ARRAY];
 };
 
 static uint32_t island_bitmap_size;
=======

This patch series is also available on GitHub in:

https://github.com/chriscool/git/commits/delta-islands

The previous versions are available there:

V4: https://github.com/chriscool/git/commits/delta-islands32
V3: https://github.com/chriscool/git/commits/delta-islands29
V2: https://github.com/chriscool/git/commits/delta-islands19
V1: https://github.com/chriscool/git/commits/delta-islands6

V4: https://public-inbox.org/git/20180812051151.6425-1-chriscool@tuxfamily.org/
V3: https://public-inbox.org/git/20180809155532.26151-1-chriscool@tuxfamily.org/
V2: https://public-inbox.org/git/20180805172525.15278-1-chriscool@tuxfamily.org/
V1: https://public-inbox.org/git/20180722054836.28935-1-chriscool@tuxfamily.org/


Christian Couder (3):
  pack-objects: refactor code into compute_layer_order()
  pack-objects: move tree_depth into 'struct packing_data'
  pack-objects: move 'layer' into 'struct packing_data'

Jeff King (4):
  Add delta-islands.{c,h}
  pack-objects: add delta-islands support
  repack: add delta-islands support
  t: add t5319-delta-islands.sh

 Documentation/config.txt           |  19 ++
 Documentation/git-pack-objects.txt |  97 ++++++
 Documentation/git-repack.txt       |   5 +
 Makefile                           |   1 +
 builtin/pack-objects.c             | 137 +++++---
 builtin/repack.c                   |   9 +
 delta-islands.c                    | 502 +++++++++++++++++++++++++++++
 delta-islands.h                    |  11 +
 pack-objects.c                     |  12 +
 pack-objects.h                     |  39 +++
 t/t5319-delta-islands.sh           | 143 ++++++++
 11 files changed, 932 insertions(+), 43 deletions(-)
 create mode 100644 delta-islands.c
 create mode 100644 delta-islands.h
 create mode 100755 t/t5319-delta-islands.sh

-- 
2.18.0.673.gcd86e60100

