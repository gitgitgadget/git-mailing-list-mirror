Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2647F1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 19:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfBHTva (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 14:51:30 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42853 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfBHTv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 14:51:29 -0500
Received: by mail-qt1-f194.google.com with SMTP id b8so5311113qtr.9
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 11:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X1zCF1gBuubO1ljHS+whfS2YVpisXxmp9tTf1rHHsO8=;
        b=AotQD2Sm+J2P73XT2966KwxY0KAFcJam/+wjC2hZb2H7GQalOtFiBlyj3AHF6jbJ9R
         r8pdzb9rmM1a+C9G0diTCwO1X5pp96hB1QzroIvKa698RAV4K0E/Ltkw1QZWrwjMN1CV
         gNyq9X7dqkmpt/g3WobzCJ+AqQqifLvTAwQQ7o1Gfw96sy9RpFLMd6eC3Lzxyr+XgFLV
         F31TDVps1oTsY/t04T1nA0P5zZjhhoHSGiT8zC+ZKVzKSmOYFQtGZ7q4quHHbPIQ/mhA
         t+hlq1GTZzKj0ltITQExUK3c6SZx9UIrEGGGnbWjGC8NSEVY3GwOW2toHQ+/deE9HcEc
         ip/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X1zCF1gBuubO1ljHS+whfS2YVpisXxmp9tTf1rHHsO8=;
        b=MINcEjmba/eXHapSR3ScbGqOgXi4Wsn0cOIpfo2L6xqx1CF5gZ8nFj/ILe7DqYrCJ1
         K51Pe8yJDaIqPZtw4r6V9rNKhZyH5QNQNrdhm4MCvATl4UUpinQQZ4HwApVDcfkndGRv
         P5NIGT/P3CkVx7GbGdzxlhpXCqfF7lWWIVTFQWP0JrtP77qZ3m31UyJ6zAMdGV1/0GH4
         XQZJBFhaKpxWo3qeyczP3b8/le6MReDjDF/Cpzt+NnzU32cKvwm+60tDZ4iPdgy/w3pr
         k+48aU4e++RM2OZ6z2P3OEUETCjhj7u2XqqMs+ljGx01DBR9wTS+sEh/KByb1t6HFfgn
         cRPA==
X-Gm-Message-State: AHQUAuYJWjFn1DZgLbvpO2/4LWFdoNpC14Tm2nyTX3LNydGg50tNtK9i
        dI2gcqKXD5JmjBHXhMLArj1IzFOeq6c=
X-Google-Smtp-Source: AHgI3IaJWQ63EQSkU5Engsm1y1yhI90B3SfRSDJEkP6ZjTPRaqzEZE4/sWh/RjP/YOY07zIgCrRI9g==
X-Received: by 2002:ac8:520f:: with SMTP id r15mr17390027qtn.167.1549655488035;
        Fri, 08 Feb 2019 11:51:28 -0800 (PST)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id 12sm8253054qka.83.2019.02.08.11.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 11:51:27 -0800 (PST)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     benpeart@microsoft.com, kewillf@microsoft.com
Subject: [PATCH v1 3/3] read-cache: Add documentation for the post-indexchanged hook
Date:   Fri,  8 Feb 2019 14:51:15 -0500
Message-Id: <20190208195115.12156-4-peartben@gmail.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190208195115.12156-1-peartben@gmail.com>
References: <20190208195115.12156-1-peartben@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kevin Willford <kewillf@microsoft.com>

Document the new post-indexchanged hook with information on when it is
called as well as the flags passed and what each of them mean.

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/githooks.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 959044347e..9349cd8900 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -492,6 +492,24 @@ This hook is invoked by `git-p4 submit`. It takes no parameters and nothing
 from standard input. Exiting with non-zero status from this script prevent
 `git-p4 submit` from launching. Run `git-p4 submit --help` for details.
 
+post-indexchanged
+~~~~~~~~~~~~~~~~~
+
+This hook is invoked when the index is written in read-cache.c
+do_write_locked_index.
+
+The first parameter passed to the hook is the indicator for the
+working directory being updated.  "1" meaning working directory
+was updated or "0" when the working directory was not updated.
+
+The second parameter passed to the hook is the indicator for whether
+or not the index was updated and the skip-worktree bit could have
+changed.  "1" meaning skip-worktree bits could have been updated
+and "0" meaning they were not.
+
+Only one parameter should be set to "1" when the hook runs.  The hook
+running passing "1", "1" should not be possible.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.20.1.windows.1

