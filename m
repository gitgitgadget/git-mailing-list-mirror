Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D5CC1F461
	for <e@80x24.org>; Mon, 13 May 2019 10:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfEMKuh (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 06:50:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33349 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbfEMKuh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 06:50:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id z28so7015612pfk.0
        for <git@vger.kernel.org>; Mon, 13 May 2019 03:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=chhSTbciD1R/usyDipUtUc/hrvrx+XSGXEFDmxIeukc=;
        b=so9Dg9M8tlXszsT4VQo2M4lYagnCyFS5R0mODPDTDsGnf/tzpwehqTz+VfkXxrBZqq
         GPAwlTCFU3Hjf5Ug2EtOo7aHJllVNJ1imH2bQij3ubFepmswMOOIINjrIHWjEqpZQ9Ux
         nWLxnqfCVS/wWLcSNeLERCN6KfaNALR4x1TlLqe+KCIdJCuGcPQhH8X5xB4Mpsu4kI6V
         7r2oEeB2UIVEQPUduLMttSrvChbKg3rlJ9lhGF8i1fNmG+oYMzAJuJN6IpVPmiAkGhh6
         YqSLnRbLIzcx8LRy0O3wIaRCRr6sd8dqccH6hm/jNrcxLb+Q8ZhNTV4lWKeNTttW80xd
         ACFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=chhSTbciD1R/usyDipUtUc/hrvrx+XSGXEFDmxIeukc=;
        b=ZktJ7ytM6Sja7zmDlEP0ZnLUMUFprdBNE4IBFIB/HspG5zF/ZPQEO7BW7uDpXYyqgW
         d/N2Rm3KjNIYQh2zvKJekIYJtw61A8ussJbMHuzsWuhvNHnvDl8GvSTafXttaQnGyKEr
         OO/wVmovMzlgjChbUIy2zxw661FhsHeyxj9fnJpOHEkCGdegvfTqjN5MbBAJD8Osu2Z6
         7OJQ6e3HOl6ykQRQa+wu4lJ55Jt4Vnsuq/di284TmDKWVZQS/YzVKC5vk+O+yKc0W1uu
         ihAaIZcOyVQIEX4Kmr6+emwInTLefXx5b3REaYt9zHZvhdO1e8zgs7pVkaHMc7Oz7T7x
         8DFA==
X-Gm-Message-State: APjAAAUjJOuW6JzKvH1zIzWmmsr7z5GjRAa3J7Stf4oULfFRuqmrW4xp
        kVE/2xZJCd2u0g//El/LQmM=
X-Google-Smtp-Source: APXvYqzxm/L64CcZ7yJ+H7sfUbxIHWeHtTC1tzu+VPmTMlzsxYrVMKYo22lEy5QXSqW3acVIn0ESIA==
X-Received: by 2002:a62:304:: with SMTP id 4mr14338113pfd.186.1557744635824;
        Mon, 13 May 2019 03:50:35 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id n35sm1332340pgl.44.2019.05.13.03.50.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 03:50:34 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 13 May 2019 17:50:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     shaheedhaque@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] worktree add: be tolerant of corrupt worktrees
Date:   Mon, 13 May 2019 17:49:44 +0700
Message-Id: <20190513104944.20367-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.1141.gd54ac2cb17
In-Reply-To: <CAHAc2je-Yz4oej-sqvp+G+2Wv+eBABeJWUMm4scRwF2z_diUXw@mail.gmail.com>
References: <CAHAc2je-Yz4oej-sqvp+G+2Wv+eBABeJWUMm4scRwF2z_diUXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

find_worktree() can die() unexpectedly because it uses real_path()
instead of the gentler version. When it's used in 'git worktree add' [1]
and there's a bad worktree, this die() could prevent people from adding
new worktrees.

The "bad" condition to trigger this is when a parent of the worktree's
location is deleted. Then real_path() will complain.

Use the other version so that bad worktrees won't affect 'worktree
add'. The bad ones will eventually be pruned, we just have to tolerate
them for a bit.

[1] added in cb56f55c16 (worktree: disallow adding same path multiple
    times, 2018-08-28), or since v2.20.0. Though the real bug in
    find_worktree() is much older.

Reported-by: Shaheed Haque <shaheedhaque@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t2025-worktree-add.sh | 12 ++++++++++++
 worktree.c              |  7 +++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 286bba35d8..d83a9f0fdc 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -570,4 +570,16 @@ test_expect_success '"add" an existing locked but missing worktree' '
 	git worktree add --force --force --detach gnoo
 '
 
+test_expect_success '"add" should not fail because of another bad worktree' '
+	git init add-fail &&
+	(
+		cd add-fail &&
+		test_commit first &&
+		mkdir sub &&
+		git worktree add sub/to-be-deleted &&
+		rm -rf sub &&
+		git worktree add second
+	)
+'
+
 test_done
diff --git a/worktree.c b/worktree.c
index d6a0ee7f73..c79b3e42bb 100644
--- a/worktree.c
+++ b/worktree.c
@@ -222,9 +222,12 @@ struct worktree *find_worktree(struct worktree **list,
 		free(to_free);
 		return NULL;
 	}
-	for (; *list; list++)
-		if (!fspathcmp(path, real_path((*list)->path)))
+	for (; *list; list++) {
+		const char *wt_path = real_path_if_valid((*list)->path);
+
+		if (wt_path && !fspathcmp(path, wt_path))
 			break;
+	}
 	free(path);
 	free(to_free);
 	return *list;
-- 
2.21.0.1141.gd54ac2cb17

