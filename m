Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A5AD20401
	for <e@80x24.org>; Thu, 15 Jun 2017 20:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752661AbdFOUjk (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 16:39:40 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34235 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752553AbdFOUji (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 16:39:38 -0400
Received: by mail-pf0-f177.google.com with SMTP id s66so12476433pfs.1
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 13:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mmSlH6SsS0ilu5dPv2w2U9Y5tTjLKrm26Z0ORfALmr0=;
        b=aSNZ009O05R/OIz++D7dawqhAVGuHDmDUTbpWsrF9j/eqtCoiemnf3cqIGJGGMW498
         UVKt7Pw35DbnjuNfdrQitSvKxVrl3RxqTUxh0RypVdQv5pKKfGHpHRItyzm4pKSOourU
         6DHAvrCT3qkMYD1y/Z7B5Ir8qN5igEXYmytnrgXuCQi9Hhuk5S9hICd4HDevAGS0CAkq
         SB6RVNZRbAYQLL2++1QyNMGq6DulcSIvGAR16OYw574+OEj08a2GQNzeJcrLjkgfPgkO
         WoIEeC6bWbaR6uiZDvNbV4jb8+cVGUBDLQhX2HyogTj4AIStZjLBQAmbtpZpDnCv5jyk
         0EFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mmSlH6SsS0ilu5dPv2w2U9Y5tTjLKrm26Z0ORfALmr0=;
        b=s8uiuk1j1DFyU90QXmR8NRAQC1BJCJtPtmSrdxZ6xwvLo0O9BqY0k1YxuQ4jf/X7vZ
         /zV4MZ1OLaQchWAuwvj8BIWcCz/diiPMkyP86RSVXZPZv91Oki66ZxyU9c1JNd6tbbwL
         wPCH955MawMh1gPYhxLzTLoGN8cxalmhTQd2H1KsKSSAYqEZe9WxzXmWn9MdPimjDL4w
         76HNiCu0B+iJh/AUbNlmqDRmJ7IX84O9GPLvdH6nbQHkrJlpYUdp91LmICFy8dRQgA8a
         PQrDNOf3QxSh37UJW9L21A5sfQbZLrLxLtotrqwlt91GIb5WKEEs5Ny2NXK6HfRq6VMN
         xSeQ==
X-Gm-Message-State: AKS2vOzZSzDyP7lyAIZLSGQlXKL0Z/uOIyXRjVs91mP0n0+sR0p4Gowr
        q8vy3hkZMGwppP0gLjK6kA==
X-Received: by 10.84.133.162 with SMTP id f31mr8152928plf.83.1497559177373;
        Thu, 15 Jun 2017 13:39:37 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id i2sm274226pfe.89.2017.06.15.13.39.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 13:39:36 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 0/4] Improvements to sha1_file
Date:   Thu, 15 Jun 2017 13:39:27 -0700
Message-Id: <cover.1497558850.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <cover.1497035376.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks - this has been updated following Junio's comments.

Patch 1 is unmodified from the previous version.

Patch 2 has been modified to remove the extraneous code pointed out by
Junio. I previously had an idea of populating those fields in
packed_object_info(), but later changed my mind, but a rebase went
wrong.

Patches 3-4 have been updated as I have described in [1] and [2].

[1] https://public-inbox.org/git/20170615111447.1208e02b@twelve2.svl.corp.google.com/
[2] https://public-inbox.org/git/20170615111447.1208e02b@twelve2.svl.corp.google.com/

As before, I would like review on patches 1-3 to go into the tree.
(Patch 4 is a work in progress, and is here just to demonstrate the
effectiveness of the refactoring.)

Jonathan Tan (4):
  sha1_file: teach packed_object_info about typename
  sha1_file: move delta base cache code up
  sha1_file: consolidate storage-agnostic object fns
  sha1_file, fsck: add missing blob support

 Documentation/config.txt |  10 +
 builtin/fsck.c           |   7 +
 cache.h                  |   8 +
 sha1_file.c              | 474 ++++++++++++++++++++++++++++++-----------------
 t/t3907-missing-blob.sh  |  69 +++++++
 5 files changed, 400 insertions(+), 168 deletions(-)
 create mode 100755 t/t3907-missing-blob.sh

-- 
2.13.1.518.g3df882009-goog

