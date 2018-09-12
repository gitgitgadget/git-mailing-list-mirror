Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89B151F404
	for <e@80x24.org>; Wed, 12 Sep 2018 15:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeILUwt (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 16:52:49 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:54687 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeILUwt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 16:52:49 -0400
Received: by mail-ua1-f73.google.com with SMTP id l14-v6so934389uaf.21
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 08:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mSb4aPbkR/3erYIjWZ2IEt0F7p6jrRd7HX3DiCjF6K8=;
        b=D/7vlXqII8YDhggxIdYbZBjC6/9J/gsguMjbrF3R5D2pYUV8V+J9tI7eysAgb1xv8V
         juP0tblm+/I9ldXxiFGpubybh9OQuCFmalf9UIqnLD7zZF6eDc8DMzBNlyaPab1/wQc+
         VRelOOf87/i7bKqH/QuDDJY2cdcpivOk2EFo7D8svIRWje3n+e1Wr8BGEDRET743BO5O
         MjK8RpNY5gzg6X16X6ttK+6N8GpL/+/HGX9+IXMqBOs3IC66DJUfUTsE6XjqxvOCH83N
         oXw6AbRG/nofJdAdqjE/IniwC09qCwLTx9jCzMQFzwiSu8pL92axDGTa1nl5ApbUdiaO
         2hkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mSb4aPbkR/3erYIjWZ2IEt0F7p6jrRd7HX3DiCjF6K8=;
        b=DGL2Rt+TlyFByt/zvGxJoo5gD9M+cMTeaxCBPmqpGNpSxfpYgCt8U7vvc0F8ac7WSO
         zIjWXuF6y7dpmcY4EgIk8m1fkAL+6vFcdwCZZs/hyeh91+Qqz8OiX8QG1o87CjJVSaQ3
         Pfr6MNWvt6p3rbugJR4Tqv8lpQEhs3k/r5rqbeAjoIw57rWXtFT02sfWlgV5fXTupMy8
         1bDVpXMT1cAzd9rWS3A7XgmDe/4b+NxCRelA1nAy+Qn5mh9/nVYgIjIRtREwED2OU3M0
         DrRlbo78g54KYf7ij8COxIAXSg9A0lOQygljFlRHsPF1xxjXekgVUVF8hQ9WFFLVUDwS
         7CWQ==
X-Gm-Message-State: APzg51CKLhlL1GZ3yhJnT1r5nMibXxXHyjyOVINh5aTyQgFEonq1opN3
        vlsiBEcb8x9Nd4alGg79T3QvTHm3UYRewZ7k8oBBtEKvtdJuAP1C55mSou4DQuFcgYFQ3YzZb5A
        HX39bctKvH4Mz+y+oaGATTmLjZKaasRwGb8WSsDEOj0B1okxkVR5JDlmgIKbExjT7vET5y535d7
        2u
X-Google-Smtp-Source: ANB0Vdao+8CSUS7P9GbzYAsHZGcVAqxbasEq0ks+mcsK43vp3XN0SIykkb434lxRYIN1l27CIDxz7RKHn1wl2VzHUYEq
X-Received: by 2002:a67:8e06:: with SMTP id q6-v6mr446509vsd.59.1536767263095;
 Wed, 12 Sep 2018 08:47:43 -0700 (PDT)
Date:   Wed, 12 Sep 2018 08:47:36 -0700
Message-Id: <cover.1536767071.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 0/2] Bugfix for partial clones and ref-in-want servers
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A coworker discovered a bug when having a partial clone against a server
that supports ref-in-want - the lazy fetches no longer work, because the
client attempts to fetch with "want-ref <hash>", which is not permitted
by the protocol.

The first patch deduplicates some code, so that the bugfix need only be
applied once, and the second patch contains the actual bugfix.

Jonathan Tan (2):
  fetch-object: provide only one fetching function
  fetch-object: set exact_oid when fetching

 fetch-object.c           | 17 ++++++-----------
 fetch-object.h           |  8 ++------
 sha1-file.c              |  2 +-
 t/t0410-partial-clone.sh | 12 ++++++++++++
 unpack-trees.c           |  2 +-
 5 files changed, 22 insertions(+), 19 deletions(-)

-- 
2.19.0.397.gdd90340f6a-goog

