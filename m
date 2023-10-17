Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ECA430E8
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjyUKklJ"
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0E1D3
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 15:07:13 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a877e0f0d8so23588787b3.1
        for <git@vger.kernel.org>; Tue, 17 Oct 2023 15:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697580433; x=1698185233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AFfGJFSRc2tAJ8jWdzB3ElkUN1Hunq6c3upqY4apeVU=;
        b=mjyUKklJY70Ud0tA+CFNsUoY5bxTaKnKw9YYpQWHt3MkyA/K0llfA5s9ehuvim7iwc
         gMoFBoemWhnLPYWbl4gZqvbzE5TUkXqO9i/yfF2M8q1GYtQOxVjVWNvF6fa099jXPApK
         W6Jh0KLqL32oJYDSH8i1LCkkWmHyU9D6fxbofFhgnlTROIZ6hDBT7IAs8aehVA/NFngY
         MU/RvE4UXcgAEQMAjP08a5itANAFuUCDcTfSRRHGIeZ8EqwGnnkB9KsnsL0qbEgs2W/u
         7zdIgWReIqDAbtkgRrNFhPHXqiApYziiVlyQErPM0SpeHgsRFWDum+SpeqsMW/af59iF
         qQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697580433; x=1698185233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFfGJFSRc2tAJ8jWdzB3ElkUN1Hunq6c3upqY4apeVU=;
        b=q2hfXXlY9VptRuSm6I2y8Ic8zduULBpdX0Zb227yWnfhSML1osy0BGbWRqmoAgOdDa
         WFg72xznK6v5vNZ8Zvu+3urItPHXTJXaaIhj8XbTldv3jMbQnFrijtNErooO28j/Cgk+
         bOqrruGV6bZS9E7LqJBJm2mLdcrxbETHu3kLWtsSfa9tbDrkTg9JCK9OzwRranAMlufH
         f6I7L8MrGPXiOybTkoqKsiQK63caKco1sAXzXLslc+qOMJkLy9mcergjjH8G6HrThfjT
         m1vU0Ocw92S9cRQDt6zIPLApTfwOCy1OVnq/9X84sk5TVwNZAEBSx0BMeVoxbZVWs5Z/
         b/EQ==
X-Gm-Message-State: AOJu0YxTi2TUqy/Hy+47FdnJBsD2j6sDLUw3t4pf/wZTApl3kF3hnIIM
	ATGzayUo2k77h5vLl9RkjGr/wsUiA4+26eY=
X-Google-Smtp-Source: AGHT+IH9a36MlM5B32tfIOM/jr0cnX3JzENH/FCoOWBU19nzoF6s5xp1DvrYKApBiM5MhWI7u5hIjA==
X-Received: by 2002:a81:498e:0:b0:5a7:b53a:3223 with SMTP id w136-20020a81498e000000b005a7b53a3223mr2406882ywa.21.1697580432795;
        Tue, 17 Oct 2023 15:07:12 -0700 (PDT)
Received: from localhost.localdomain ([105.112.67.145])
        by smtp.gmail.com with ESMTPSA id p128-20020a0dcd86000000b005925765aa30sm972516ywd.135.2023.10.17.15.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 15:07:11 -0700 (PDT)
From: Naomi Ibe <naomi.ibeh69@gmail.com>
To: git@vger.kernel.org
Cc: Naomi Ibe <naomi.ibeh69@gmail.com>
Subject: [PATCH v2 1/1] [OUTREACHY] add: standardize die() messages output.
Date: Tue, 17 Oct 2023 23:06:42 +0100
Message-Id: <20231017220642.293-1-naomi.ibeh69@gmail.com>
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

 builtin/add.c: clean up die() messages

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

