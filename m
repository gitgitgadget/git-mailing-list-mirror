Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87DB81F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 10:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404156AbfAPKct (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 05:32:49 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44314 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731929AbfAPKcs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 05:32:48 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so2644671pgr.11
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 02:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=raBf4rrOnQDclOt2Ra7rjfRUnq9y0VAz+PqI4s2K8U4=;
        b=iPYvtDwwoV7LJBlN6mZnldIARh2yWInvwq1+PW//morOPh3WPed4DIu+XwWkTO3MT4
         m9i7znl1WE6rFxU9xBb330/uzXHPV8qg37lB1ZC7Y6VXE8AC1mka3yLhcsFF5qegSZx6
         Lcj83CeKJ+pRPPIz+kfE3kGjO103gHT/FaiqYYi/nKwtfB2Xu0C+GBPhgl0MJcogU5Ap
         3tSZOJgx1fLEAcy3/m/CeUKWIWmJ5iz8bTWXyJmxRSwycHkaVbaKJkB8uwq4qOuq5fEp
         nlZPkFTiaNZpFQz853sH0OvPYCK/UoWTIyR0vQOWNaHqht/q6RBgauWIfiOIoG7wiewC
         FZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=raBf4rrOnQDclOt2Ra7rjfRUnq9y0VAz+PqI4s2K8U4=;
        b=SvuxnjJuQN7A4nt9yRQb7KOqSmFczBoatc27KCVV5EA9mJAZlUOdU96zVyl/l+frOj
         eJKV047+fVgttkkPO9U7wpgWqlvcyZIgBhj0F4n18fi1iCWvpyNXQxB007HOS6HzidvQ
         VtWcBwL+O/z5LtuUATQUeBl3yhyixbn5gQx8HU3zScpqhV0sXU9bKim9S8YMkNE7XwoA
         6GJYHG1EHbuLBrLFJ/vLfZ793qq1xx+2tbS/dvLXTJ9FxNBIJUL2XSyWTe5wq8dG16Qu
         YWhScZxjOKqgFephd5D/mu26Z+lqRB/FRZo5M4ng4xrauLXVD1WDzGRX4oyzTyUjEN9z
         V5sA==
X-Gm-Message-State: AJcUukdaeaw6nM1gXdG1gF88CltE/fpZapaNSppuKFi0krfDa137kKT2
        bmOH2QYjuOLunRKQMY0TFfVFr9xW
X-Google-Smtp-Source: ALg8bN41lmogi6wULhQFliVvbvAgu5hMLdoGN3OfQ+jY9+sFadF8oQBDaKamU6/GmQRzzTduzJUDZQ==
X-Received: by 2002:a65:4b82:: with SMTP id t2mr8225177pgq.189.1547634766882;
        Wed, 16 Jan 2019 02:32:46 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id d129sm9583543pfc.31.2019.01.16.02.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 02:32:46 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 16 Jan 2019 17:32:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>, tsniatowski@vewd.com,
        Jonathan Nieder <jrnieder@gmail.com>, marcnarc@xiplink.com,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/10] submodule deinit: support multiple worktrees
Date:   Wed, 16 Jan 2019 17:31:56 +0700
Message-Id: <20190116103159.9305-8-pclouds@gmail.com>
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

This is the reverse of 'init' or 'add', config from superproject is
removed from config.worktree (or just config in standard single
worktree setup)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/submodule--helper.c    |  8 ++++++--
 t/t2405-worktree-submodules.sh | 11 +++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 288858af83..8943127ae7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1097,6 +1097,8 @@ static void deinit_submodule(const char *path, const char *prefix,
 	struct strbuf sb_config = STRBUF_INIT;
 	char *sub_git_dir = xstrfmt("%s/.git", path);
 
+	check_multi_worktree_support();
+
 	sub = submodule_from_path(the_repository, &null_oid, path);
 
 	if (!sub || !sub->name)
@@ -1150,21 +1152,23 @@ static void deinit_submodule(const char *path, const char *prefix,
 		      displaypath);
 
 	cp_config.git_cmd = 1;
-	argv_array_pushl(&cp_config.args, "config", "--get-regexp", NULL);
+	argv_array_pushl(&cp_config.args, "config", "--worktree", "--get-regexp", NULL);
 	argv_array_pushf(&cp_config.args, "submodule.%s\\.", sub->name);
 
 	/* remove the .git/config entries (unless the user already did it) */
 	if (!capture_command(&cp_config, &sb_config, 0) && sb_config.len) {
+		char *config_file = get_worktree_config(the_repository);
 		char *sub_key = xstrfmt("submodule.%s", sub->name);
 		/*
 		 * remove the whole section so we have a clean state when
 		 * the user later decides to init this submodule again
 		 */
-		git_config_rename_section_in_file(NULL, sub_key, NULL);
+		git_config_rename_section_in_file(config_file, sub_key, NULL);
 		if (!(flags & OPT_QUIET))
 			printf(_("Submodule '%s' (%s) unregistered for path '%s'\n"),
 				 sub->name, sub->url, displaypath);
 		free(sub_key);
+		free(config_file);
 	}
 
 cleanup:
diff --git a/t/t2405-worktree-submodules.sh b/t/t2405-worktree-submodules.sh
index 55daace672..8d53f639c9 100755
--- a/t/t2405-worktree-submodules.sh
+++ b/t/t2405-worktree-submodules.sh
@@ -111,4 +111,15 @@ test_expect_success 'reset sync submodules' '
 	git -C secondary submodule sync
 '
 
+test_expect_success 'deinit submodules' '
+	git submodule deinit sub1 &&
+	git -C secondary submodule deinit sub2 &&
+	git config --get-regexp "submodule.*" | sort >actual1 &&
+	test_must_be_empty actual1 &&
+	test -d .git/modules/sub1 &&
+	git -C secondary config --get-regexp "submodule.*" | sort >actual2 &&
+	test_must_be_empty actual2 &&
+	test -d .git/worktrees/secondary/modules/sub2
+'
+
 test_done
-- 
2.20.0.482.g66447595a7

