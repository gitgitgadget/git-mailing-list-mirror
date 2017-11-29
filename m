Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 391C620A40
	for <e@80x24.org>; Wed, 29 Nov 2017 20:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752594AbdK2UDf (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 15:03:35 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44943 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbdK2UD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 15:03:26 -0500
Received: by mail-wr0-f196.google.com with SMTP id l22so4517537wrc.11
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 12:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u6bfMv+8iq+jd5gNs803TNAZRfUg+jDEKP+Ch2SD12k=;
        b=tqzWgJGHvoRfcAaIYK7BvzJ8deXbHlDAi4S3Gr2pwXSjk4i/7kBzhNSWYwmE3PeNz8
         wgwZe+80Fqfe82l0w0Hi8P5cohkLcy6ega62iLkqBKBN8bwKhSLeN5xQfc0qYM2oEFXC
         S9o6ySt8s4ZpNVa1KEoJpo9CQyZ1vulMGe8NTCIXUpFWJbIzHp92ON6+DxOj/weWLlEp
         i5fBZlSHUi8fI8KlPU2Tu9WPVa/959dtEXI8jWmo62rdhyMZg7y/mM1Xikm+/uVFVyLG
         S7rEpK8BKKWxiF8A1nlwcVizN64GcKXpNO9vT7Kp8NGApJkcLWZPaDIhZw1/H0is7BBh
         VQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u6bfMv+8iq+jd5gNs803TNAZRfUg+jDEKP+Ch2SD12k=;
        b=Hm6RS+XD6zd75MooGZN46koCxmba29nXg63R+cb5SGiZWeKZ+M4whD6bvdo5fJ7hLH
         J+Z5pJA/g2Rn0aHNehjDyEULBzsl2LeObgdSozXajI5/tfZIb1FihPfyOeEAlRlXCk5F
         7MFQPg+/m7ooAro0BMLASjRqumaHGC7qhBEZfQp2e8in515QUmFJHVihKRdjhpkprtQo
         HoTu6zgwGKwJZbPc3tGbX5yFk0sH0biLhT+1ryC2CRA3qufH2GErOPeQZc+hpugrNL1D
         sHVkK5HyRnRbhm0no1ru6sQ22ysrjZYTpmYUaW5Oc27m5qmieIZW+yP9S/AT+6n0ImFV
         +M3w==
X-Gm-Message-State: AJaThX4LJn4qnmYkzQswZgME+fWQA36XtihrKWs1ZE+ElwPZX9/k3VFo
        /jKCAuQHWWDgnht1BTVCnHd7Tey5
X-Google-Smtp-Source: AGs4zMbCKjoiL+z3DY6yZVPNHG3FFTvyz/EsLzKKHB+8qwNnLcsBoB8c0tv4JdtaxdDxNbTUSQ3n8Q==
X-Received: by 10.223.163.216 with SMTP id m24mr25378wrb.107.1511985804680;
        Wed, 29 Nov 2017 12:03:24 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 90sm4473158wrp.93.2017.11.29.12.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 12:03:23 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Paul Smith <paul@mad-scientist.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v6 4/6] worktree: make add <path> <branch> dwim
Date:   Wed, 29 Nov 2017 20:04:49 +0000
Message-Id: <20171129200451.16856-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.426.gb06021eeb
In-Reply-To: <20171129200451.16856-1-t.gummerer@gmail.com>
References: <20171126194356.16187-1-t.gummerer@gmail.com>
 <20171129200451.16856-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently 'git worktree add <path> <branch>', errors out when 'branch'
is not a local branch.  It has no additional dwim'ing features that one
might expect.

Make it behave more like 'git checkout <branch>' when the branch doesn't
exist locally, but a remote tracking branch uniquely matches the desired
branch name, i.e. create a new branch from the remote tracking branch
and set the upstream to the remote tracking branch.

As 'git worktree add' currently just dies in this situation, there are
no backwards compatibility worries when introducing this feature.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-worktree.txt |  8 ++++++++
 builtin/worktree.c             | 16 ++++++++++++++++
 t/t2025-worktree-add.sh        | 19 +++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 15e58b18f7..3044d305a6 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -52,6 +52,14 @@ is linked to the current repository, sharing everything except working
 directory specific files such as HEAD, index, etc. `-` may also be
 specified as `<commit-ish>`; it is synonymous with `@{-1}`.
 +
+If <commit-ish> is a branch name (call it `<branch>` and is not found,
+and neither `-b` nor `-B` nor `--detach` are used, but there does
+exist a tracking branch in exactly one remote (call it `<remote>`)
+with a matching name, treat as equivalent to
+------------
+$ git worktree add --track -b <branch> <path> <remote>/<branch>
+------------
++
 If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
 then, as a convenience, a new branch based at HEAD is created automatically,
 as if `-b $(basename <path>)` was specified.
diff --git a/builtin/worktree.c b/builtin/worktree.c
index ea9678cac8..7021d02585 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "checkout.h"
 #include "config.h"
 #include "builtin.h"
 #include "dir.h"
@@ -390,6 +391,21 @@ static int add(int ac, const char **av, const char *prefix)
 		opts.new_branch = xstrndup(s, n);
 	}
 
+	if (ac == 2 && !opts.new_branch && !opts.detach) {
+		struct object_id oid;
+		struct commit *commit;
+		const char *remote;
+
+		commit = lookup_commit_reference_by_name(branch);
+		if (!commit) {
+			remote = unique_tracking_name(branch, &oid);
+			if (remote) {
+				opts.new_branch = branch;
+				branch = remote;
+			}
+		}
+	}
+
 	if (opts.new_branch) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		cp.git_cmd = 1;
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 72e8b62927..96ebc63d04 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -365,4 +365,23 @@ test_expect_success '--no-track avoids setting up tracking' '
 	)
 '
 
+test_expect_success '"add" <path> <non-existent-branch> fails' '
+	test_must_fail git worktree add foo non-existent
+'
+
+test_expect_success '"add" <path> <branch> dwims' '
+	test_when_finished rm -rf repo_upstream repo_dwim foo &&
+	setup_remote_repo repo_upstream repo_dwim &&
+	git init repo_dwim &&
+	(
+		cd repo_dwim &&
+		git worktree add ../foo foo
+	) &&
+	(
+		cd foo &&
+		test_branch_upstream foo repo_upstream foo &&
+		test_cmp_rev refs/remotes/repo_upstream/foo refs/heads/foo
+	)
+'
+
 test_done
-- 
2.15.0.426.gb06021eeb

