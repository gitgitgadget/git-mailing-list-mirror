Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AA671F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 10:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404124AbfAPKcb (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 05:32:31 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45544 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731929AbfAPKca (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 05:32:30 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so2642780pgc.12
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 02:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nIk9BOlvOrOPVhAeryZlwC53d+4V9mjhIjKaVE4th9w=;
        b=i7dVzkNzLWAsxQgp1M+CsYqc9A6alsaERJ09XvBjlhvrSHKKd9jeNqZe041KkziqjU
         qy6aFH3DtKTL/OpUUf9zDMQw5wqhRYjUibctRH4e0EmtM/Sun17UxgQOd7OYSDkvP8+6
         5D8KqpH220G4WtOEJd9/rvvYtIXAmL6AVnJ6oeotzL0qlNrOGV0z88M0te89ZOgTiLK9
         o5uGfFCnmotYOkGAzqoNu8TgE5uBa6Mdi2c0VkgPP4srafL++NxYIfQropcXi8qi8DEF
         Ec7GZxCfNK64hmnlXAuCpA3z28QjpXzkpdHzLKUj4YB85p1eCnuX31scdRo2ZMFWBz9p
         bSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nIk9BOlvOrOPVhAeryZlwC53d+4V9mjhIjKaVE4th9w=;
        b=Ek3w5dL3tHU2a2R2D5SrssCc71n/UGj7+6tlyFtwOBlcL59wq/Cqe8OrK6RqB37926
         JkCckX6jUUicksBCum0Y5F/4o9keXataj++YW/iBc4eLTI0hOXWdea0at0QMU7Ho6nKP
         ucgWD64JRzVEmHJskTZGIIj8WuVTfzaRxiSVxDP+THQh5WHIR7fzXXDWeY9vSgTJeR8Q
         1p+OEK+TaqktEHaZV4qE8dy5sscoYyWeDS3Al1RYRduYrCmhnPtv3qBu7Y0u7PUbqH8x
         KX6nPyH8Zbp1v11NVCesLJePUtwS7XjdEnyygmx2TPva1NJRkC4BnNAOxFpX+xOFWzvG
         viIQ==
X-Gm-Message-State: AJcUukeX9slKjmYp7qElNhVC7IlwR7V04S2Fz5ihrHhbwBvLQU31pv63
        aZ6z7NCbH18ELiduPZ5wz212O+oe
X-Google-Smtp-Source: ALg8bN4p4nUjAbevOQ9GDScYlRo+SOqniVWuXHqE1mMHAMK9sMnQ2oJT7A+AmE2zhgnvVKNY6ajgkw==
X-Received: by 2002:a62:220d:: with SMTP id i13mr9026491pfi.162.1547634749553;
        Wed, 16 Jan 2019 02:32:29 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 125sm9451716pfg.39.2019.01.16.02.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 02:32:28 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 16 Jan 2019 17:32:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>, tsniatowski@vewd.com,
        Jonathan Nieder <jrnieder@gmail.com>, marcnarc@xiplink.com,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/10] submodule init: support multiple worktrees
Date:   Wed, 16 Jan 2019 17:31:53 +0700
Message-Id: <20190116103159.9305-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190116103159.9305-1-pclouds@gmail.com>
References: <20190116103159.9305-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The entire submodule section in the superproject will be per-worktree
and written to $GIT_DIR/config.worktree.

The behavior when you only have one worktree (and not enabled
extensions.worktreeConfig) is the same as before, everything is still
written in $GIT_DIR/config

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/submodule--helper.c    | 14 +++++---------
 t/t2405-worktree-submodules.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7b328ec060..6b749b41fb 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -639,15 +639,11 @@ static void init_submodule(const char *path, const char *prefix,
 		die(_("No url found for submodule path '%s' in .gitmodules"),
 			displaypath);
 
-	/*
-	 * NEEDSWORK: In a multi-working-tree world, this needs to be
-	 * set in the per-worktree config.
-	 *
-	 * Set active flag for the submodule being initialized
-	 */
+	check_multi_worktree_support();
+
 	if (!is_submodule_active(the_repository, path)) {
 		strbuf_addf(&sb, "submodule.%s.active", sub->name);
-		git_config_set_gently(sb.buf, "true");
+		repo_config_set_worktree_gently(the_repository, sb.buf, "true");
 		strbuf_reset(&sb);
 	}
 
@@ -672,7 +668,7 @@ static void init_submodule(const char *path, const char *prefix,
 			free(oldurl);
 		}
 
-		if (git_config_set_gently(sb.buf, url))
+		if (repo_config_set_worktree_gently(the_repository, sb.buf, url))
 			die(_("Failed to register url for submodule path '%s'"),
 			    displaypath);
 		if (!(flags & OPT_QUIET))
@@ -693,7 +689,7 @@ static void init_submodule(const char *path, const char *prefix,
 		} else
 			upd = xstrdup(submodule_strategy_to_string(&sub->update_strategy));
 
-		if (git_config_set_gently(sb.buf, upd))
+		if (repo_config_set_worktree_gently(the_repository, sb.buf, upd))
 			die(_("Failed to register update mode for submodule path '%s'"), displaypath);
 	}
 	strbuf_release(&sb);
diff --git a/t/t2405-worktree-submodules.sh b/t/t2405-worktree-submodules.sh
index 3ee5380e88..2ee3e2d039 100755
--- a/t/t2405-worktree-submodules.sh
+++ b/t/t2405-worktree-submodules.sh
@@ -39,4 +39,32 @@ test_expect_success 'add submodules' '
 	test -d .git/worktrees/secondary/modules/sub2
 '
 
+test_expect_success 'init submodules' '
+	git clone --no-local .git cloned &&
+	(
+		cd cloned &&
+		git config extensions.worktreeConfig true &&
+		git submodule init sub1 &&
+		git worktree add secondary origin/secondary &&
+		cd secondary &&
+		git submodule init sub2
+	) &&
+
+	git -C cloned config --get-regexp "submodule.*" | sort >actual1 &&
+	cat >expected1 <<-EOF &&
+	submodule.sub1.active true
+	submodule.sub1.url $(pwd)/submodsrc
+	EOF
+	test_cmp expected1 actual1 &&
+	! test -d cloned/.git/modules/sub1 &&
+
+	git -C cloned/secondary config --get-regexp "submodule.*" | sort >actual2 &&
+	cat >expected2 <<-EOF &&
+	submodule.sub2.active true
+	submodule.sub2.url $(pwd)/submodsrc
+	EOF
+	test_cmp expected2 actual2 &&
+	! test -d cloned/.git/worktrees/secondary/modules/sub2
+'
+
 test_done
-- 
2.20.0.482.g66447595a7

