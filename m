Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B48FA1F42D
	for <e@80x24.org>; Sun, 20 May 2018 10:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbeETKS0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 06:18:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55917 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbeETKSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 06:18:25 -0400
Received: by mail-wm0-f68.google.com with SMTP id a8-v6so20637120wmg.5
        for <git@vger.kernel.org>; Sun, 20 May 2018 03:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4S7uF1dJfaR0CH3dUQu7CFMUNW8B+5WpL/Jm8UMj6Qg=;
        b=rR4Kt15OP/wpFV/ftnRKmfuY/FC88Pq8whVWOBE2qGOLpXdbxJ9Ic26oQAe41UjiNc
         cR/UbIGfU5yQ98Twam0gCUMxTeUB9+NwVpqIXRkpSoBCBl3NJuRnmV3pwUJjNCYV4dmQ
         q/ZsPuu4zEASKs1pnRfDTyBiGVCdY2nR5lqVulXOqiO2sRTsI+mjA2Ww7oXVRY+8tRTc
         DUIvqFiWXIpGwjmCxDYqBkKNYCJKcGqELmOfr2E4D9ZHCdypDjD0354tJzMsigsw31an
         PCLsSAmLfV4QpgLZqJTlgNbiMxvGIakFJUFfPwIRo/KYNUEge3atdKQWVn9flUExT025
         hPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4S7uF1dJfaR0CH3dUQu7CFMUNW8B+5WpL/Jm8UMj6Qg=;
        b=iTSwLW5ahw1iE5vPyAqrc+t3JhZEt7HVMCMNd8ehaTWEJiS676f+zBJ7kkk+Pdjo09
         hyyRHoc7y7T/G8nbGUlx+iTR6rZktuBny4pRPIjN4HtUCFv8+QKHXi1Z6XvYyixngiQu
         6mxI2pwbbqVeFw1gjPV+Qaq9TNqL6IYbFr5Yih2O14ZeFKLTaa/NC5FMqdZD2ylNIB+r
         2tW0+GQ6iC0RX301+QSB8qwweTcYDF6kUCBTZzGFLJH/ykmyA6YL/UptkSCnea6tprK0
         uW8tR+/4SqsjeUZedyy/2jjkrYP8l6VbPeZO0AvDNQikz05gKmlFULHWkPXCkFQrM7k0
         QBTA==
X-Gm-Message-State: ALKqPwc2FUOtpT+biSvJQ3iq5Mmy1lvgaN4CqdKzZMVHFadsSghVHEw3
        JPqZOc/M6KfYNS8+k0JvC1IHuOLYj2c=
X-Google-Smtp-Source: AB8JxZroFmpOqn49092RXzw7ZllOLhjYKETp67Dox0Vw17kkTCvgJvkM+E6JS1Z7zl/cywWTokMhuA==
X-Received: by 2002:a1c:cb03:: with SMTP id b3-v6mr7720625wmg.45.1526811503655;
        Sun, 20 May 2018 03:18:23 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id t189-v6sm10210374wmf.22.2018.05.20.03.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 May 2018 03:18:22 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 1/4] merge: setup `opts` later in `checkout_fast_forward()`
Date:   Sun, 20 May 2018 12:17:34 +0200
Message-Id: <27965d978f203c5b55ce19fa03fb3e183d442c70.1526810549.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.840.g5d83f92caf
In-Reply-To: <cover.1526810549.git.martin.agren@gmail.com>
References: <CAN0heSp7DqxOy-UeLgj8t_T_4f-fNthMpGNS8oUbcs7+NvS-zw@mail.gmail.com> <cover.1526810549.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After we initialize the various fields in `opts` but before we actually
use them, we might return early. Move the initialization further down,
to immediately before we use `opts`.

This limits the scope of `opts` and will help a later commit fix a
memory leak without having to worry about those early returns.

This patch is best viewed using something like this (note the tab!):
--color-moved --anchored="	trees[nr_trees] = parse_tree_indirect"

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/merge.c b/merge.c
index f06a4773d4..f123658e58 100644
--- a/merge.c
+++ b/merge.c
@@ -94,23 +94,7 @@ int checkout_fast_forward(const struct object_id *head,
 		return -1;
 
 	memset(&trees, 0, sizeof(trees));
-	memset(&opts, 0, sizeof(opts));
 	memset(&t, 0, sizeof(t));
-	if (overwrite_ignore) {
-		memset(&dir, 0, sizeof(dir));
-		dir.flags |= DIR_SHOW_IGNORED;
-		setup_standard_excludes(&dir);
-		opts.dir = &dir;
-	}
-
-	opts.head_idx = 1;
-	opts.src_index = &the_index;
-	opts.dst_index = &the_index;
-	opts.update = 1;
-	opts.verbose_update = 1;
-	opts.merge = 1;
-	opts.fn = twoway_merge;
-	setup_unpack_trees_porcelain(&opts, "merge");
 
 	trees[nr_trees] = parse_tree_indirect(head);
 	if (!trees[nr_trees++]) {
@@ -126,6 +110,24 @@ int checkout_fast_forward(const struct object_id *head,
 		parse_tree(trees[i]);
 		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
 	}
+
+	memset(&opts, 0, sizeof(opts));
+	if (overwrite_ignore) {
+		memset(&dir, 0, sizeof(dir));
+		dir.flags |= DIR_SHOW_IGNORED;
+		setup_standard_excludes(&dir);
+		opts.dir = &dir;
+	}
+
+	opts.head_idx = 1;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
+	opts.update = 1;
+	opts.verbose_update = 1;
+	opts.merge = 1;
+	opts.fn = twoway_merge;
+	setup_unpack_trees_porcelain(&opts, "merge");
+
 	if (unpack_trees(nr_trees, t, &opts)) {
 		rollback_lock_file(&lock_file);
 		return -1;
-- 
2.17.0.840.g5d83f92caf

