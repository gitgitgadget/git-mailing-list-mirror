Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A28430F9
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 22:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNB4bZMw"
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DAA95
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 15:13:54 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a7ac4c3666so76309707b3.3
        for <git@vger.kernel.org>; Tue, 17 Oct 2023 15:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697580834; x=1698185634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aLmmbQMGnBtvmUtBajNzWBNAI48NH+utExeIyO8p6xo=;
        b=JNB4bZMwZOp0saroOUZRhAejaixp79QGkCSIQJ7Zk2IKlOlB09gkVGCjIS8pY88cD0
         eP333VbB56adr18UqPy3mHi1IL9eC0fdrdKdW1dP3mr9p82z9hhX5QVixmqI/SMzttKU
         xwkUcMbd6/wx4lhCLeEtwnPMVLuq3km7LqoMxkcg+q3TYuzvcv+ZeeQcFzD5Zr4LlBOo
         GQQbiP5FaVJ+lHdQIb2qOWyQo2NI5Gw2KjE2wKE+Jp78AA9GJtzAImKSvA6EyU+PHNId
         5A8PnN5vcPTd/0bWu/M+sDCx0/y2jq1gHyWkl7B8q5Ucj+V+skAAbYHEK8R5jVEs1F2Z
         +NEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697580834; x=1698185634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aLmmbQMGnBtvmUtBajNzWBNAI48NH+utExeIyO8p6xo=;
        b=OYIQyrUsX6RTsEplkbYol+vADHo+7iWwF5PNWIJ93yEfZLTiSjW9kiG2tIOaO9z4/w
         4bbv+3M/5WqvLPbXPqvnLs8ADDSppajJaY84sFpIqMFbd5KwALuhAZmxJJGmEHl+4d90
         90YM9kKll/JROV+1u4taJLt+u6Mbo+6fUvV0wRdXqclg7fmv2w8jm4aMM4/V7xXNT3hG
         k/muR5O4fvRi28Z7vVHnzk9UukS1bReIUoWXUHho2rYJFnygQ58l3LlegcGAlUjlEI74
         xsMvXQO2lpZsL/sQ7GUCMJdrTkmbpesJeHYeQqoLdTf1z10HR8PFWm3h5a/ZIPWkLLyt
         IGFw==
X-Gm-Message-State: AOJu0YzvmH0ZhvUEzfZ+yYQ7OhhMqieTeW+CAM2aVCgJixYyZ7hP7p35
	9NhIWhKIuWcEEyhkMSz1yKPfg1Lc7LGeszM=
X-Google-Smtp-Source: AGHT+IH9EHUiAMJdBjAw9WBT2QohFS4QRr2zH+LbQdqpXzD4BdJWFF6kQl52AKvd6hyLOzhT8Ct1Fg==
X-Received: by 2002:a0d:ea05:0:b0:5a7:aa54:42b1 with SMTP id t5-20020a0dea05000000b005a7aa5442b1mr3805475ywe.28.1697580833905;
        Tue, 17 Oct 2023 15:13:53 -0700 (PDT)
Received: from localhost.localdomain ([105.112.67.145])
        by smtp.gmail.com with ESMTPSA id c195-20020a814ecc000000b00570253fc3e5sm955373ywb.105.2023.10.17.15.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 15:13:53 -0700 (PDT)
From: Naomi Ibe <naomi.ibeh69@gmail.com>
To: git@vger.kernel.org
Cc: Naomi Ibe <naomi.ibeh69@gmail.com>
Subject: [PATCH v2 1/1] [OUTREACHY] builtin/add.c: clean up die() messages
Date: Tue, 17 Oct 2023 23:13:23 +0100
Message-Id: <20231017221323.352-1-naomi.ibeh69@gmail.com>
X-Mailer: git-send-email 2.36.1.windows.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As described in the CodingGuidelines document, a single line
message given to die() and its friends should not capitalize its
first word, and should not add full-stop at the end.

Signed-off-by: Naomi Ibe <naomi.ibeh69@gmail.com>
---
 builtin/add.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index c27254a5cd..5126d2ede3 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -182,7 +182,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 
 	if (repo_read_index(the_repository) < 0)
-		die(_("Could not read the index"));
+		die(_("could not read the index"));
 
 	repo_init_revisions(the_repository, &rev, prefix);
 	rev.diffopt.context = 7;
@@ -200,15 +200,15 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 		die(_("editing patch failed"));
 
 	if (stat(file, &st))
-		die_errno(_("Could not stat '%s'"), file);
+		die_errno(_("could not stat '%s'"), file);
 	if (!st.st_size)
-		die(_("Empty patch. Aborted."));
+		die(_("empty patch. aborted"));
 
 	child.git_cmd = 1;
 	strvec_pushl(&child.args, "apply", "--recount", "--cached", file,
 		     NULL);
 	if (run_command(&child))
-		die(_("Could not apply '%s'"), file);
+		die(_("could not apply '%s'"), file);
 
 	unlink(file);
 	free(file);
@@ -568,7 +568,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 finish:
 	if (write_locked_index(&the_index, &lock_file,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
-		die(_("Unable to write new index file"));
+		die(_("unable to write new index file"));
 
 	dir_clear(&dir);
 	clear_pathspec(&pathspec);
-- 
2.36.1.windows.1

