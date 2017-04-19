Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6237A1FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 11:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762521AbdDSLCV (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 07:02:21 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33376 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762502AbdDSLCT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 07:02:19 -0400
Received: by mail-pf0-f194.google.com with SMTP id c198so3218481pfc.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 04:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j+5zWu8i5SrWR/i53jp37Is+m/yBm6Q10T5E4mfb9+M=;
        b=jIHaTvfiKQA7wUsWKCGq5kQKMpSVkDQ4S5azqQSa2gqvAt+GP6Yl2awM9twmZH4bNn
         4pTJwu/PZBbHyODfRnEY0afnnXwFR/J+a0+UY9phe90DwFZ2PDUmZzPBfSKtooKq/qvJ
         cDLywOtTdF0UKHaHWY60qhJ8ykJRUjp8Uj8WjQu/Zf2urYivJsY89bfllv/kFeIuYSoQ
         42Ueo41QGOnsXhDfIrxl0mpijlYt/lKAeDMhdqyNSNmO2uS6ToxMHZ/ZlUBdb9fdRgDK
         GCg4ig6LC0cUjheBCKRnMwhr1GQNVy5RFwHrUEjzjSbsZSQ3J3C6GA+cYA8x0Mts2axf
         YGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j+5zWu8i5SrWR/i53jp37Is+m/yBm6Q10T5E4mfb9+M=;
        b=g1tocXzG6vNavNkRdfh2JjijyERI6UwHmxSoddgng9BVyuf/Jaa24nm2qgFw0ctMKL
         GFNFRCQaFzL1mR9BtiVFjYUP4Tj9aKOKWq+tBe2JN1OBu4+xyGg/Z/yIUhdxaL3SH1SA
         RQ+GZRH7SAmXOmsE4pPPvNPgS78P+F5omyZ0/wLNIAf9ai5ofm0b443J7FCkYH/VSpoN
         /5yTyyG6M6VU9g3bM9iYBdG9Kk4pEMnVTwuLv1+AnRaU4OWpbrH1QL0VnKaV6iim9GhP
         HePfOLaDcQ2X8JYWuvpkW43jkrlgcoIpplsfKi7WZ1fyhS3RpBOeck4KKqwaoheWwCSp
         0wPg==
X-Gm-Message-State: AN3rC/4ZbI6lE7DW1VemrJNf4U5DJ8kH8YCmNm7bTLZH3cNjXcwFYewf
        ZTDa+Jc7dXPXzQ==
X-Received: by 10.99.125.75 with SMTP id m11mr2465658pgn.13.1492599738869;
        Wed, 19 Apr 2017 04:02:18 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id c28sm4002177pfj.19.2017.04.19.04.02.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 04:02:18 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Apr 2017 18:02:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 03/12] revision.c: --indexed-objects add objects from all worktrees
Date:   Wed, 19 Apr 2017 18:01:36 +0700
Message-Id: <20170419110145.5086-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170419110145.5086-1-pclouds@gmail.com>
References: <20170419110145.5086-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the result of single_worktree flag never being set (no way to up
until now). To get objects from current index only, set single_worktree.

The other add_index_objects_to_pending's caller is mark_reachable_objects()
(e.g. "git prune") which also mark objects from all indexes.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c       | 21 +++++++++++++++++++++
 t/t5304-prune.sh |  9 +++++++++
 2 files changed, 30 insertions(+)

diff --git a/revision.c b/revision.c
index 98146f179f..295d4f8205 100644
--- a/revision.c
+++ b/revision.c
@@ -19,6 +19,7 @@
 #include "dir.h"
 #include "cache-tree.h"
 #include "bisect.h"
+#include "worktree.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -1291,8 +1292,28 @@ static void do_add_index_objects_to_pending(struct rev_info *revs,
 
 void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 {
+	struct worktree **worktrees, **p;
+
 	read_cache();
 	do_add_index_objects_to_pending(revs, &the_index);
+
+	if (revs->single_worktree)
+		return;
+
+	worktrees = get_worktrees(0);
+	for (p = worktrees; *p; p++) {
+		struct worktree *wt = *p;
+		struct index_state istate = { NULL };
+
+		if (wt->is_current)
+			continue; /* current index already taken care of */
+
+		if (read_index_from(&istate,
+				    worktree_git_path(wt, "index")) > 0)
+			do_add_index_objects_to_pending(revs, &istate);
+		discard_index(&istate);
+	}
+	free_worktrees(worktrees);
 }
 
 static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 133b5842b1..cba45c7be9 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -283,4 +283,13 @@ test_expect_success 'prune: handle alternate object database' '
 	git -C B prune
 '
 
+test_expect_success 'prune: handle index in multiple worktrees' '
+	git worktree add second-worktree &&
+	echo "new blob for second-worktree" >second-worktree/blob &&
+	git -C second-worktree add blob &&
+	git prune --expire=now &&
+	git -C second-worktree show :blob >actual &&
+	test_cmp second-worktree/blob actual
+'
+
 test_done
-- 
2.11.0.157.gd943d85

