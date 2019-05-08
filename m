Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E8851F45F
	for <e@80x24.org>; Wed,  8 May 2019 00:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfEHANT (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 20:13:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38400 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfEHANT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 20:13:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id v11so4530228wru.5
        for <git@vger.kernel.org>; Tue, 07 May 2019 17:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ECiS3gbMx4ytWbpfFMx49BViOX/CnCW4n6byFv6bCCs=;
        b=UVGBDWJcAFrg9h80tD6fW00+rclaGGJ+99rdaCYRO+DBfYNr4yznKQWAyZKG6W9x4W
         +4ndNbHJ2N6gKyCQuvW8hLaeB+xCVQQ5oIaHvqmXU+LdskwhF+CKkq5azCfa8qm0XI5E
         3Xm99cG6VPycdjePHwgvVR3D0VOg/wIAxTAPw1JvcTILYItvBk4Kkmcclxsw/wDU/8fR
         zhf+nzOEKzoklwnel7WZHuY7ZB0cYOjdzWNPFDFTcNZETrDNz47zOTZY1iG2VV/1O++y
         kfmlkjFKaBKF88OZrTLpFbuteTrVwLOMy/p/9Sry/9twzJQkD2A7DtG+dvOvR2RgGXbg
         7Lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ECiS3gbMx4ytWbpfFMx49BViOX/CnCW4n6byFv6bCCs=;
        b=P6jE818vEmFUcOteppYYxQB1CB5+/OMP5VH9ttJr8CRvHAv1VYwBVZbBvvsMMymCPP
         rpKMEgatuse6/E9yyNaQ90nPxhnG1Q37E3TUA0/Dk2cYhCQ7krKRldyt00Rn73itoLs5
         g9DRwjdoiJPTs91DXhOCqjxoZqVF/XRsmQfgIdSzgt4THBBNbG8+E7ka47U+3I6l+O7g
         zustZM5qBzP8yDHiYbIwdgMoqjUMELo6/A0tilZ9mx8u+VHWGpLmX1ZHYQsZ3cPXxp20
         sZSI+hWG3RyWHKMutl2eVt7mlSD/XpmZzlZ+hy8jXgevh8e7ngbSvG6Zk322DQOgf3RS
         qLAA==
X-Gm-Message-State: APjAAAU41A65sMy3ITO92KIOnsKul1bh3RajaBP3gLOfgO1F1+rJwyN7
        KUnhP82t5LAYrMYSC0amlc79pV2wXV0=
X-Google-Smtp-Source: APXvYqwecF0LQabaSuYHoA5CFNgIeNqchroahAU8z9/u0g4s8hTia1zWTN4kNUhUDFeDmH8YcDVwMA==
X-Received: by 2002:a5d:6b10:: with SMTP id v16mr1735997wrw.294.1557274396548;
        Tue, 07 May 2019 17:13:16 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm5167825wrp.58.2019.05.07.17.13.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 17:13:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC WIP PATCH v8 07/13] rebase: fast-forward --fork-point in more cases
Date:   Wed,  8 May 2019 02:12:46 +0200
Message-Id: <20190508001252.15752-8-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <cover.1555832783.git.liu.denton@gmail.com>
References: <cover.1555832783.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Denton Liu <liu.denton@gmail.com>

Before, when we rebased with a --fork-point invocation where the
fork-point wasn't empty, we would be setting options.restrict_revision.
The fast-forward logic would automatically declare that the rebase was
not fast-forwardable if it was set. However, this was painting with a
very broad brush.

Refine the logic so that we can fast-forward in the case where the
restricted revision is equal to the merge base, since we stop rebasing
at the merge base anyway.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/rebase.c               | 10 +++++++---
 t/t3432-rebase-fast-forward.sh | 20 ++++++++++----------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index c1000c159d..5f9beda46b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -879,6 +879,7 @@ static int is_linear_history(struct commit *from, struct commit *to)
 }
 
 static int can_fast_forward(struct commit *onto, struct commit *upstream,
+			    struct commit *restrict_revision,
 			    struct object_id *head_oid, struct object_id *merge_base)
 {
 	struct commit *head = lookup_commit(the_repository, head_oid);
@@ -898,6 +899,9 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
 	if (!oideq(merge_base, &onto->object.oid))
 		goto done;
 
+	if (restrict_revision && !oideq(&restrict_revision->object.oid, merge_base))
+		goto done;
+
 	if (!upstream)
 		goto done;
 
@@ -1679,9 +1683,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * with new commits recreated by replaying their changes. This
 	 * optimization must not be done if this is an interactive rebase.
 	 */
-	if (can_fast_forward(options.onto, options.upstream, &options.orig_head,
-		    &merge_base) &&
-	    !is_interactive(&options) && !options.restrict_revision) {
+	if (can_fast_forward(options.onto, options.upstream, options.restrict_revision,
+		    &options.orig_head, &merge_base) &&
+	    !is_interactive(&options)) {
 		int flag;
 
 		if (!(options.flags & REBASE_FORCE)) {
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 59cd437301..8f4996e476 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -70,32 +70,32 @@ test_rebase_same_head_ () {
 }
 
 changes='no changes'
-test_rebase_same_head success work same success work same
+test_rebase_same_head success noop same success work same
 test_rebase_same_head success noop same success noop-force same master
 test_rebase_same_head success noop same success noop-force diff --onto B B
 test_rebase_same_head success noop same success noop-force diff --onto B... B
 test_rebase_same_head success noop same success noop-force same --onto master... master
 test_rebase_same_head success noop same success noop-force same --no-fork-point
-test_rebase_same_head success work same success work same --fork-point master
-test_rebase_same_head failure noop same success work diff --fork-point --onto B B
-test_rebase_same_head failure work same success work diff --fork-point --onto B... B
-test_rebase_same_head success work same success work same --fork-point --onto master... master
+test_rebase_same_head success noop same success work same --fork-point master
+test_rebase_same_head success noop same success work diff --fork-point --onto B B
+test_rebase_same_head success noop same success work diff --fork-point --onto B... B
+test_rebase_same_head success noop same success work same --fork-point --onto master... master
 
 test_expect_success 'add work same  to side' '
 	test_commit E
 '
 
 changes='our changes'
-test_rebase_same_head success work same success work same
+test_rebase_same_head success noop same success work same
 test_rebase_same_head success noop same success noop-force same master
 test_rebase_same_head success noop same success noop-force diff --onto B B
 test_rebase_same_head success noop same success noop-force diff --onto B... B
 test_rebase_same_head success noop same success noop-force same --onto master... master
 test_rebase_same_head success noop same success noop-force same --no-fork-point
-test_rebase_same_head success work same success work same --fork-point master
-test_rebase_same_head failure work same success work diff --fork-point --onto B B
-test_rebase_same_head failure work same success work diff --fork-point --onto B... B
-test_rebase_same_head success work same success work same --fork-point --onto master... master
+test_rebase_same_head success noop same success work same --fork-point master
+test_rebase_same_head success noop same success work diff --fork-point --onto B B
+test_rebase_same_head success noop same success work diff --fork-point --onto B... B
+test_rebase_same_head success noop same success work same --fork-point --onto master... master
 
 test_expect_success 'add work same  to upstream' '
 	git checkout master &&
-- 
2.21.0.1020.gf2820cf01a

