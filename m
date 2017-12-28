Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96F0C1F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753397AbdL1EPm (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:15:42 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:33694 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753061AbdL1EOG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:06 -0500
Received: by mail-io0-f181.google.com with SMTP id t63so88873iod.0
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=teP5+nAAmb4kPlA6W+z/aCcFrNdWMwNZ4G93NTZbFuE=;
        b=AcHbYbKzHw/mn8Gq4QRDpWE89gxpQN9g83Nt9H3zOhd2KUJc1sLPIBLnLQ82vv3flv
         mmRun+6xwtZagk3THTd8X7NFlMureniND1u1BseSD9e5dYlfDz4dEKwvld0qycb6Dexw
         tSjKXWzZW6ZIaA1PpmvojagbDhr9uMG1tZr32fIO7LvZN3875n4EfGdZ5xxxlOa//l2Y
         gjqfotwda8PYQ9QuDMhT0wOWdyVL7d5IZ0JtRa3W41gXQEIK4rgSBZx1XOPUEa7EuefC
         UfayCvrmdGH8WEIjVDi+ekN+SsO3ol1JJUCoXH7iwdV+WGMtlRV+VJN4XclO9I7PTIG7
         Imng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=teP5+nAAmb4kPlA6W+z/aCcFrNdWMwNZ4G93NTZbFuE=;
        b=Ox6lVPCBuMcDJIzVuV1kXpQV7xkaL6Q4BDknOXx6NZfZ2kIKQy9I8WkeDbpqVksoDs
         T8ebmyWmsktG4LXTBeC/NZtYrMPn/i46hNmsSjK0/MA6lg18U6V7MRoA0wVdvlUAFV6p
         t6rhZcO1ZDXVM3CYfSh5TEEFgXqIQiUTV7YViWZ6n7NJ11l8b2YVBsx4K8om9AA8B5kj
         /ypnUG+cpX05WlBBuyPq+PQr8/ckL/hcpKXy5ggkNsZNKVerzfTO6pzR8ffMTgPd4Rxt
         CRazJ9uMNAH+knXpckDIbp2HtLgmjlu/Jf2SQ+4Y5lOVwxmvKC+uN1XDPD/8lx4zegIT
         tXEw==
X-Gm-Message-State: AKGB3mLjO6vFt3sFIzt/REqfEN1mihY/zlYWm7hgO4HjMspZguRAzFvj
        Ehs/EMbu+s/K6H+D7MGieUNOaw==
X-Google-Smtp-Source: ACJfBouBBLF1M1IzFpTzwQTPaqRnLhd8izkUvYF+3pocoQBUUo0GRTwaw7ZB+EWU3I8wYqGCKXg2NA==
X-Received: by 10.107.136.217 with SMTP id s86mr41027079ioi.294.1514434445723;
        Wed, 27 Dec 2017 20:14:05 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:05 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 06/34] directory rename detection: testcases to avoid taking detection too far
Date:   Wed, 27 Dec 2017 20:13:24 -0800
Message-Id: <20171228041352.27880-7-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-rename-directories.sh | 150 ++++++++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index acf49d6b4..433d99584 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -564,4 +564,154 @@ test_expect_success '2b-check: Directory split into two on one side, with equal
 #   messages are handled correctly.
 ###########################################################################
 
+
+###########################################################################
+# SECTION 3: Path in question is the source path for some rename already
+#
+# Combining cases from Section 1 and trying to handle them could lead to
+# directory renaming detection being over-applied.  So, this section
+# provides some good testcases to check that the implementation doesn't go
+# too far.
+###########################################################################
+
+# Testcase 3a, Avoid implicit rename if involved as source on other side
+#   (Related to testcases 1c and 1f)
+#   Commit O: z/{b,c,d}
+#   Commit A: z/{b,c,d} (no change)
+#   Commit B: y/{b,c}, x/d
+#   Expected: y/{b,c}, x/d
+test_expect_success '3a-setup: Avoid implicit rename if involved as source on other side' '
+	test_create_repo 3a &&
+	(
+		cd 3a &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		echo d >z/d &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		test_tick &&
+		git commit --allow-empty -m "A" &&
+
+		git checkout B &&
+		mkdir y &&
+		mkdir x &&
+		git mv z/b y/ &&
+		git mv z/c y/ &&
+		git mv z/d x/ &&
+		rmdir z &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '3a-check: Avoid implicit rename if involved as source on other side' '
+	(
+		cd 3a &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 3 -eq $(git ls-files -s | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:x/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c O:z/d &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 3b, Avoid implicit rename if involved as source on other side
+#   (Related to testcases 5c and 7c, also kind of 1e and 1f)
+#   Commit O: z/{b,c,d}
+#   Commit A: y/{b,c}, x/d
+#   Commit B: z/{b,c}, w/d
+#   Expected: y/{b,c}, CONFLICT:(z/d -> x/d vs. w/d)
+#   NOTE: We're particularly checking that since z/d is already involved as
+#         a source in a file rename on the same side of history, that we don't
+#         get it involved in directory rename detection.  If it were, we might
+#         end up with CONFLICT:(z/d -> y/d vs. x/d vs. w/d), i.e. a
+#         rename/rename/rename(1to3) conflict, which is just weird.
+test_expect_success '3b-setup: Avoid implicit rename if involved as source on current side' '
+	test_create_repo 3b &&
+	(
+		cd 3b &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		echo d >z/d &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		mkdir y &&
+		mkdir x &&
+		git mv z/b y/ &&
+		git mv z/c y/ &&
+		git mv z/d x/ &&
+		rmdir z &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		mkdir w &&
+		git mv z/d w/ &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '3b-check: Avoid implicit rename if involved as source on current side' '
+	(
+		cd 3b &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+
+		test 5 -eq $(git ls-files -s | wc -l) &&
+		test 3 -eq $(git ls-files -u | wc -l) &&
+		test 1 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			:0:y/b :0:y/c :1:z/d :2:x/d :3:w/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c O:z/d O:z/d O:z/d &&
+		test_cmp expect actual &&
+
+		test ! -f z/d &&
+		git hash-object >actual \
+			x/d w/d &&
+		git rev-parse >expect \
+			O:z/d O:z/d &&
+		test_cmp expect actual &&
+
+		test_i18ngrep CONFLICT.*rename/rename.*z/d.*x/d.*w/d out &&
+		test_i18ngrep ! CONFLICT.*rename/rename.*y/d
+	)
+'
+
+###########################################################################
+# Rules suggested by section 3:
+#
+#   Avoid directory-rename-detection for a path, if that path is the source
+#   of a rename on either side of a merge.
+###########################################################################
+
 test_done
-- 
2.15.0.408.g8e199d483

