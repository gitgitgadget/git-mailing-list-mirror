Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBA6D20A10
	for <e@80x24.org>; Sun,  1 Oct 2017 14:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbdJAO5C (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 10:57:02 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36680 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdJAO5B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 10:57:01 -0400
Received: by mail-wr0-f193.google.com with SMTP id k10so2237839wrk.3
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 07:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C24tWCcWNhfQHTzK+m2aa/GWLZS74Tb0133g/x3ntls=;
        b=GhD3Ssk0nLwYf2bbgm+0ZrxNzOA5wSOCkopwAWS+64Dw5FMSbu/4qmflv6P4n9QmPb
         kL1MuK/J7yvv7l+6/CJo9rxu3BteMnutwmQPulHLzqG6Pb3cTwmHQxwMxf+2j1XQp1Vg
         dJ6/89IO6xbekFgkfTdhJKBySDrRxMLaqRTkj3hOS6CIW13oPuzBSTgVHxhTqI/4XDO9
         Zh7K/HXtLSSuPJzK3oovY8fARVRUsqUhDushWBUh+NU9/E3j77ZrrE/e1iN2eB8jCpeK
         3QnOr6H7HKAvFJrcHFJVZ/OY3uEJPURUEK/8H0w/7gF3JBoelyZ3fNS2BWrLqAhh/dA3
         A0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C24tWCcWNhfQHTzK+m2aa/GWLZS74Tb0133g/x3ntls=;
        b=juyronHXQwmXD1BjDS8jLhRAyb32J/3gbBNAvUcYMf+gMye9NA6t/e2HXt2PY+lhOI
         yWZ9aLRLiZMKAGK9JDqCqml0NZbiaxiFs0O18oQ5T4kpaG/egmMgATmM0pX9QS0nElax
         EktdtdytYiTNFVUnV8p+4AksngR8cO3i9N9eIVzwAUettaFsEmwb8s8XpUvk4Xe375ul
         FzUMDpYb2h7tRT21lzDGvYZm015UWa6KCW8NEWAbTQzx6CYAV2XcV3eKpvpr+yu53N5t
         3k5jz3e54AaWPI03zyDn5nJfkovZ+Pk+P5BXfc45Dycmr+VSjpn8JOesR69TYHQpivqe
         U9Tg==
X-Gm-Message-State: AHPjjUhFlCAI7qCCmgRElcIEn09jtR3thHJIphZoOuQqo6XzuYcLYcnd
        hZY5vvz/HflZ2t0s+OgTVB3bRg==
X-Google-Smtp-Source: AOwi7QCQE09FhffMgpZ9f4lAVDygVSI4mRwnwXQU3KSIoXkTDrr7SJRPOCKSY1CER7DPChKJWTIRlQ==
X-Received: by 10.223.135.66 with SMTP id 2mr11994804wrz.208.1506869819915;
        Sun, 01 Oct 2017 07:56:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id w82sm10473516wme.5.2017.10.01.07.56.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Oct 2017 07:56:59 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/11] cache.h: document `write_locked_index()`
Date:   Sun,  1 Oct 2017 16:56:09 +0200
Message-Id: <0d0e97dc97676a23b93db795e00d67544e6c250e.1506862824.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.727.g9ddaf86
In-Reply-To: <cover.1506862824.git.martin.agren@gmail.com>
References: <cover.1506862824.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The next patches will tweak the behavior of this function. Document it
in order to establish a basis for those patches.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 cache.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/cache.h b/cache.h
index ea6c236e0..4605e8228 100644
--- a/cache.h
+++ b/cache.h
@@ -601,9 +601,25 @@ extern int do_read_index(struct index_state *istate, const char *path,
 extern int read_index_from(struct index_state *, const char *path);
 extern int is_index_unborn(struct index_state *);
 extern int read_index_unmerged(struct index_state *);
+
+/* Flags for `write_locked_index()`. */
 #define COMMIT_LOCK		(1 << 0)
 #define CLOSE_LOCK		(1 << 1)
+
+/*
+ * Write the index while holding an already-taken lock. The flags may
+ * contain at most one of `COMMIT_LOCK` and `CLOSE_LOCK`.
+ *
+ * Unless a split index is in use, write the index into the lock-file,
+ * then commit or close it, as indicated by `flags`.
+ *
+ * With a split index, write the shared index to a temporary file,
+ * adjust its permissions and rename it into place, then write the
+ * split index to the lockfile. If the temporary file for the shared
+ * index cannot be created, fall back to the normal case.
+ */
 extern int write_locked_index(struct index_state *, struct lock_file *lock, unsigned flags);
+
 extern int discard_index(struct index_state *);
 extern void move_index_extensions(struct index_state *dst, struct index_state *src);
 extern int unmerged_index(const struct index_state *);
-- 
2.14.1.727.g9ddaf86

