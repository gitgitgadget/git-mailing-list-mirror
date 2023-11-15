Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B4E3307E
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NM4Ieqtb"
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531C3189
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:34:00 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-407da05f05aso51004225e9.3
        for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700058837; x=1700663637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0Lp+OwVfnW3WJA+jS6ViZyTYfL9erxx17/e1CCIZb0=;
        b=NM4IeqtbNAVXedgNO7vQ/r9ZRTxn+ss216D0OMdLnaWrf6rXpNpMNsp85jv3Rvf5je
         KtisgQLTlYW0A8/QG4ubw6YhqU3j1hkXE1qzu9ha7mcWyxr1bgi7UjtSNJyUVt+evDOQ
         LN3w7KfYQLic31Kq8ZQrZZbl6J+jOXZSokm7WMfTvFBj2YiN3pFj+5xeKrIbr98Of4mj
         S2Gk3UIdSyeRbDDC+qpdspxfy6/a3h6Uq9lD1OrdlqQFWgvC/1uTFPLdqY6Op5leWYb0
         KNcbTDgzVS1+3OABFfVCIZsseH9KefFZtaFm3qrJSF+eRNrc6vVyaGHiWWDivB0ZgK+v
         BivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700058837; x=1700663637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0Lp+OwVfnW3WJA+jS6ViZyTYfL9erxx17/e1CCIZb0=;
        b=d6YOvMHDJV57pZmkX/P5yOA5uFPvcZJnqEvBT51/2ZDHHrne3Ig6hRlIa2xZalpacK
         XP1rQghH8nSdoab1U+UkzerZwMoy/1onMAfB0jAwfDOdC0bhAME3TgP9kggjVur+o3NV
         Oat3DBmlFjVtmHJyMW4RUH5LCclS2fvwzs5f+ZrHvkr8soiqcOPy4ifJ/5fascFP7SJz
         b2YRTuPQTIWYZAdoyF+SfmstUrxTojcELX+w56R0nC52eIskm8xE6kcJHwFWL8pm0704
         mjfg11eFBLwl4HjWBKY3dUgkOgqUQk0A/H4dAU+oYE2rA8HA6K0x15Nq1eM+uw+qKsZc
         jaLg==
X-Gm-Message-State: AOJu0YzxYZ1QyhxR3WhdC4CnnkiiX8M8Hi3atQOsnju31xIF9lYlTzlK
	xZ9RsEbR+fzz97f/iVZ3daR+4wyKREg=
X-Google-Smtp-Source: AGHT+IF1OGIZ0b7RF1wnVGD3PAeKPft4zdfqlBoQzuLK6d0POdQN+1hyoj72+pNU5ueEiHT0vPHQHg==
X-Received: by 2002:a05:600c:2217:b0:408:3975:e225 with SMTP id z23-20020a05600c221700b004083975e225mr10749289wml.40.1700058837412;
        Wed, 15 Nov 2023 06:33:57 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:a40b:e654:dd4c:2f5f])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b004060f0a0fd5sm15207643wmo.13.2023.11.15.06.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:33:56 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Calvin Wan <calvinwan@google.com>,
	Toon Claes <toon@iotcl.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Linus Arver <linusa@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 08/14] replay: remove progress and info output
Date: Wed, 15 Nov 2023 15:33:21 +0100
Message-ID: <20231115143327.2441397-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.rc1.15.g29556bcc86
In-Reply-To: <20231115143327.2441397-1-christian.couder@gmail.com>
References: <20231102135151.843758-1-christian.couder@gmail.com>
 <20231115143327.2441397-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Elijah Newren <newren@gmail.com>

The replay command will be changed in a follow up commit, so that it
will not update refs directly, but instead it will print on stdout a
list of commands that can be consumed by `git update-ref --stdin`.

We don't want this output to be polluted by its current low value
output, so let's just remove the latter.

In the future, when the command gets an option to update refs by
itself, it will make a lot of sense to display a progress meter, but
we are not there yet.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 2e1df83027..1035435705 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -232,7 +232,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 
 	init_merge_options(&merge_opt, the_repository);
 	memset(&result, 0, sizeof(result));
-	merge_opt.show_rename_progress = 1;
+	merge_opt.show_rename_progress = 0;
 	merge_opt.branch1 = "HEAD";
 	head_tree = repo_get_commit_tree(the_repository, onto);
 	result.tree = head_tree;
@@ -240,9 +240,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	while ((commit = get_revision(&revs))) {
 		struct commit *pick;
 
-		fprintf(stderr, "Rebasing %s...\r",
-			oid_to_hex(&commit->object.oid));
-
 		if (!commit->parents)
 			die(_("replaying down to root commit is not supported yet!"));
 		if (commit->parents->next)
@@ -261,7 +258,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		exit(128);
 
 	if (result.clean) {
-		fprintf(stderr, "\nDone.\n");
 		strbuf_addf(&reflog_msg, "finish rebase %s onto %s",
 			    oid_to_hex(&last_picked_commit->object.oid),
 			    oid_to_hex(&last_commit->object.oid));
@@ -275,7 +271,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
 			die(_("unable to update HEAD"));
 	} else {
-		fprintf(stderr, "\nAborting: Hit a conflict.\n");
 		strbuf_addf(&reflog_msg, "rebase progress up to %s",
 			    oid_to_hex(&last_picked_commit->object.oid));
 		if (update_ref(reflog_msg.buf, "HEAD",
-- 
2.43.0.rc1.15.g29556bcc86

