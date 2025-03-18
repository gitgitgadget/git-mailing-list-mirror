Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26680204080
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 11:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299171; cv=none; b=EwraMc8lYRuQTH2F0Y1C6+ZGPWEBt/Ohy2LLZpdZ5md5JhG+QQ0sIwv4M9SBfpB7zYTfoy+3G5K/YjCC235yL2vp/qN7GqCFALvCaigo/0fnutmTJBpur8BG+uLfFmEzAay6VV1vyP8/ongYyygZhdzEUi9uVdHpP3ZevELMZ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299171; c=relaxed/simple;
	bh=U6cmTbxV4tCdvBmncexg+swheF19OVuQ+W1ra8DB9vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMBAdZWmzBgqSVjd5YMos3IylNITVcSILDWMA3XDgEdMllxrmMTZ3Uu0h8LL7HcKiO835s924EwDs7ijlafpsOLX5Rz0KhN0eCkBzpw6Ib3/G2WJo3rqr1jtSUoR1AFCKy/jZKfOv/0OHnkAUV+pZBFEFSXyOMRxPnJ/94G6t/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ac/QaaTi; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ac/QaaTi"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22359001f1aso58255995ad.3
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 04:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742299168; x=1742903968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzH0GxcUvPZP2/UeP0dJFg2sRLWgXweOioqvjIfY+08=;
        b=Ac/QaaTijm/yijHHhtTOsj3u8/ISe/+hDyJ6/yTxTFHsfqdrF6cgJQxuhXkISGDPaN
         wiPgDo/eIAVE0M90uYvg3OEe11y7yQZkP7/aUbYbTWeoYgrQFkd1hf84oU76NIdEqcuj
         3aymzbnAD7LCgUmKgX8WcneYw4ky+MHKoJyWvYKqFCwwKPuPme8KT4URwTrmICJeyN7Z
         PMcldeL3VbhHJ5iMEaTW+9cy3mstgS+/H+ujjAyAMjOPX01822c5w+Ah28C/EIX/I7l8
         7uxccxS3/Vry+rykb5Sa8UOwC6an8Nyf1H+bGm6Y43Fynb5gUzj3Pw5zLa4tEeA/j6qT
         kSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742299168; x=1742903968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzH0GxcUvPZP2/UeP0dJFg2sRLWgXweOioqvjIfY+08=;
        b=kp1JPLbGxbiBwFbDRsTFESqxPzc7dIK9mrCdVlYg65PanoZxD0+vMRPRETDdFSROvS
         NMvMhsnSlTFu8V76l7MbYZ1cXTxHUHFBO3fAYO+MUheEiUQu71LihRVi2q6vXJK3QCXf
         MoR7ZO2+H8B3GeZDRbkWku2l5uFppoMYsW5vIUUcAbwrpkRe6MHe5KJ0raPItLIolkjD
         fGAlvTeGJtnGA+UIg/9fsDh3h/UWKHsU2KlX56LnLQOfptK/Hmo1iUaQbES7sTT0w2xu
         Zt2/AcScsFCLBPdlk0CNepUgjS9WWDqcz7hi0oM+ID1SxcgC5PtZsX1YBmVS5sRB0N3H
         e+Mw==
X-Gm-Message-State: AOJu0YzLu1/4W5lhLj+tt6L+SVQrTfOyqp6NWpUGFukAM/QBEbclJWWW
	dfsq9TKfos7qCHZdcEDNVDqqAQaCVIdyugtQ7hbaOZGqnU02+vEfq0pfwqI4
X-Gm-Gg: ASbGncsHWtK0ytgG2g7wtvgpJygCOqVNMHp5v1b6lVyM4HjCNKdS9PDD5Lolvwo1gGR
	/CJMUCmadUD5nyxOeHL1rKSFQ8qj4i7OJcpuRHjFSYqaTAlMzf6Gj0Nz7CPWBzF7NGif+ikkKbO
	3ap3wDHyMTtD6G3aXawSD0CcqFs28s3dnSTzqaCgkBk+uJM7jeNS7+1QPuzF/gi/Y7vorX9KbiR
	EaYRaBbo1tpsKpzCxZWVGqCVhwEE8pe1dqGtDRXHbW6Nba0mzMUUMVzXUppjjDyFaI4hTF4WZqu
	k9ixb7Z+nK81n+Ko/nR6XU8+eRzbMM9fLQ7aJxkVVRZ0pbC6mlCxCjGimR566ONIiC28Tg==
X-Google-Smtp-Source: AGHT+IHxsPdscrIivpEusdZXlHvUQf7gM9G5t6QkiNK6+eClq9RwZ1W/JOa1pwIBhXUFwh5JOIjf9w==
X-Received: by 2002:a17:902:ce89:b0:224:13a4:d61d with SMTP id d9443c01a7336-2262c55f498mr46179335ad.23.1742299167867;
        Tue, 18 Mar 2025 04:59:27 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bc012bsm92101605ad.205.2025.03.18.04.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:59:27 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/9] builtin/verify-commit: stop using `the_repository`
Date: Tue, 18 Mar 2025 17:28:55 +0530
Message-ID: <20250318115912.2978992-4-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318115912.2978992-1-usmanakinyemi202@gmail.com>
References: <20250318115912.2978992-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the_repository global variable in favor of the repository
argument that gets passed in "builtin/verify-commit.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_verify_commit()` function with `repo`
set to NULL and then early in the function, `parse_options()` call will
give the options help and exit.

Pass the repository available in the calling context to `verify_commit()`
to remove it's dependency on the global `the_repository` variable.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/verify-commit.c  | 13 ++++++-------
 t/t7510-signed-commit.sh |  7 +++++++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 779b7988ca..5f749a30da 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -5,7 +5,6 @@
  *
  * Based on git-verify-tag
  */
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
@@ -33,15 +32,15 @@ static int run_gpg_verify(struct commit *commit, unsigned flags)
 	return ret;
 }
 
-static int verify_commit(const char *name, unsigned flags)
+static int verify_commit(struct repository *repo, const char *name, unsigned flags)
 {
 	struct object_id oid;
 	struct object *obj;
 
-	if (repo_get_oid(the_repository, name, &oid))
+	if (repo_get_oid(repo, name, &oid))
 		return error("commit '%s' not found.", name);
 
-	obj = parse_object(the_repository, &oid);
+	obj = parse_object(repo, &oid);
 	if (!obj)
 		return error("%s: unable to read file.", name);
 	if (obj->type != OBJ_COMMIT)
@@ -54,7 +53,7 @@ static int verify_commit(const char *name, unsigned flags)
 int cmd_verify_commit(int argc,
 		      const char **argv,
 		      const char *prefix,
-		      struct repository *repo UNUSED)
+		      struct repository *repo)
 {
 	int i = 1, verbose = 0, had_error = 0;
 	unsigned flags = 0;
@@ -64,7 +63,7 @@ int cmd_verify_commit(int argc,
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, verify_commit_options,
 			     verify_commit_usage, PARSE_OPT_KEEP_ARGV0);
@@ -78,7 +77,7 @@ int cmd_verify_commit(int argc,
 	 * was received in the process of writing the gpg input: */
 	signal(SIGPIPE, SIG_IGN);
 	while (i < argc)
-		if (verify_commit(argv[i++], flags))
+		if (verify_commit(repo, argv[i++], flags))
 			had_error = 1;
 	return had_error;
 }
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 0d2dd29fe6..39677e859a 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -8,6 +8,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
+test_expect_success GPG 'verify-commit does not crash with -h' '
+	test_expect_code 129 git verify-commit -h >usage &&
+	test_grep "[Uu]sage: git verify-commit " usage &&
+	test_expect_code 129 nongit git verify-commit -h >usage &&
+	test_grep "[Uu]sage: git verify-commit " usage
+'
+
 test_expect_success GPG 'create signed commits' '
 	test_oid_cache <<-\EOF &&
 	header sha1:gpgsig
-- 
2.48.1

