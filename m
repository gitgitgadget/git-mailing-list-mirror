Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4233741746
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUFNl+N5"
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0EB109
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 04:40:23 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9abc069c8bso5746637276.3
        for <git@vger.kernel.org>; Tue, 17 Oct 2023 04:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697542823; x=1698147623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AFfGJFSRc2tAJ8jWdzB3ElkUN1Hunq6c3upqY4apeVU=;
        b=EUFNl+N5usKQqk5J25RXha7njKwOxa8xkbryxmIj7My6RcxIX9nHSElKLkHXMQNlF0
         C93ElHZ79wmjAz6arxwi3VDXJdnpCW/BCv40wWYsYhqL5sZOgAnEAYjNmK/0fCxYY+e9
         cKn4ZnRPrpDsO3gLI0ZdPE4N7iDHCJjwN3GwA/iYf8SMZwhgMxKaPeOkMRhd4EL8CCxu
         lHc+2PgavXeKWu7BFrHqbRNYXAJ5e5UOngG4GAHFMvhiFEQd3mAKS2gRKnwrhWA3FFUY
         XYew6XG4rlTIEZIk0HSuWoDnrtGTIt4xR3IuWtmDQzZ9kZwVm4kldDBYYyV1/GctXZ2r
         8nOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697542823; x=1698147623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFfGJFSRc2tAJ8jWdzB3ElkUN1Hunq6c3upqY4apeVU=;
        b=QYUYhPVzqjF6y50QS8g/hIVEmUkkTjgO3G6zHSBvWt8S99HsvYCL5ZGs8nz4jqkb83
         HbXDYmsui8RIWKTNhA/tdtOzYg1mFgwSM4+vgSLqrOjkGfhIlQhPu9V9TfUO0VlhJimZ
         TrJ2ASnE4fDfiYupapHyw0VEp+mZKnNABqtXPHgqf+/SrJ5/0a4A8HjpQHtEQc5cq+mJ
         ZR/nIM4YGOW9iJy9iKrk+RqzvAR/PdJV7d0Hk6XrqlQjrGL+ITQco5jkmT6PjmqprUxo
         wxLz9JrI/UeknsmMkDFibleWiP+asCDH76mD3ix0C91UevuVZq/Vv153l12AVIrioOdS
         QP6g==
X-Gm-Message-State: AOJu0YzLUj6sLAVrCQhmxcBxIGz4tYAtlzFI0Y0VJf9rE5v7RUmdD46O
	YqzYtja2rW8yOvzuDTE0tCv+C3L7iYJmMZU=
X-Google-Smtp-Source: AGHT+IHZaKIvtY6YfSN/Gia5OGgvlFCG98uBUdnWW/FK5HyISFqyjwcNrMrHfgNQ0kbhAfn8JduzJw==
X-Received: by 2002:a25:b292:0:b0:d9c:1ef5:b12 with SMTP id k18-20020a25b292000000b00d9c1ef50b12mr1901893ybj.65.1697542822988;
        Tue, 17 Oct 2023 04:40:22 -0700 (PDT)
Received: from localhost.localdomain ([105.112.176.13])
        by smtp.gmail.com with ESMTPSA id l23-20020a25b317000000b00d9b4ddf1c32sm452122ybj.2.2023.10.17.04.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 04:40:21 -0700 (PDT)
From: Naomi Ibe <naomi.ibeh69@gmail.com>
To: git@vger.kernel.org
Cc: Naomi Ibe <naomi.ibeh69@gmail.com>
Subject: [PATCH v2 1/1] [OUTREACHY] add: standardize die() messages output.
Date: Tue, 17 Oct 2023 12:39:45 +0100
Message-Id: <20231017113946.747-1-naomi.ibeh69@gmail.com>
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
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
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

