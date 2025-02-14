Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE721C84AC
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 23:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739574145; cv=none; b=oaPjk9WJCdFnCJUau3fdZ4g1AbWggNM2UNDiYIzrCPUtGbX0qthlIvEnLyHkdYE8r7ntM8fi61x7AAfJZEJzou5TQLPa/cJTJW5p40a+X/f746iACqEDFDMSXja6cRhuUs1YW/NpgCujDnVhBLlIhS9DlcFUkFUZ5uyQ9++ntEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739574145; c=relaxed/simple;
	bh=4aWowCXeM8KyGxQcAgI62Q78R9y6POq9UX85r/lKQb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBIrlV/WKsHBGF3mK4Oncxy1eJY7M9d/0HWDO+HPNwetTOnBkx+0318iPq7LQ1j17tjBnS9CifbgK3FC4jUGbZCgVPLZDaCBg8yRWm63QEIFedCoIxAYGRaPm/Ij5aZq6D0WkhPlYQp6y4h7S2A3U9HHPzVo63Zz5AmF22mIaA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROtrINnf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROtrINnf"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220d398bea9so37153365ad.3
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 15:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739574143; x=1740178943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjEfJ9D6FJVw+0rAxPOQyAKkoS5Fm0gi3EJkP22V0t4=;
        b=ROtrINnfEteaICR1WxpwuuC+T8b3e1Oolql+RqBlBGuzlPAWtXpikpMVogwyWT3qeE
         WSqQNJPkzDyAywuhAUgPgftZqHC2OaPAdL2/xmpOWFzGZza1YqVYe0LJOjhEy4VG6g31
         xm8xB6SCV1vKspPG82WmLK+AcCzqkA7Mmd6cJWLuQfrmvTX/SPSrKnLTiQ1k+lkiaxFs
         vz2dHyrVadukt0+DVjtJ96nsqCZoQy09XUsfECMQ7fs02c3NdPPqXFy+McZWom+hKD+f
         +4dqeMjGXNcdYnSom+8t4U9TpDkZF99uSm9YYFWbZWP9OwZ6zcoCZHR5zBk/pNCRI1Jt
         DObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739574143; x=1740178943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjEfJ9D6FJVw+0rAxPOQyAKkoS5Fm0gi3EJkP22V0t4=;
        b=jpq5JCb3J7IygGoJvT2fvrcUjTq8SOE5oPFa+4C51YNzHEk+7Vg16WJCnv2HpphHLY
         UUCJLcEQP93o0tlyezuZRLzwfCmHCGQvFZsUYiT9iRGcOC/ewyVGhZYfTh14l7N8aALp
         oMFy+5ytgw0+CTTN0woa9XAzWjOnno7YxYHlgubZRALcabbFzb8EacMkK2v8lpeHWUkT
         Vc+E40ENohq8lkOXjen9rVhFEIcze182rbUpR5VFCHE+P5C1FUCq6ZqN4nSWutmoAey0
         RusTTRZzypG9B/m9bwfjr6bCzSaiSCWJlcJUosiKsRsD3U2Vu17FI09PFXcJ9dR3eUFW
         Ymfg==
X-Gm-Message-State: AOJu0YyB3UXR6IMIlq9K2DKvm0P6t0XZvzDM9kggaFlxrZkKeVRecqxE
	3m5OXru3dKO8Unh/og4z7tuWfILj5qXzsByesWaT1f7kujysDGL8mxanRnm1
X-Gm-Gg: ASbGncueqeEMks1C2AmzvxPtZHWt5cq44US1CWrB8CuaoLDeRUFdWzv34cXw+Iz2FwD
	PImzM6Y8zdgu1t5G0kw9HRKcwMpF2kg5qDnzTvTu7xbSlix0p+IcztPQ5i6v8xGYv26DN7XBIGN
	nWK6LKQPPevp+3ISIYOkrq+J4UzpNIQZPjWoRgn17mC7E+QD3EJyrRorNTwYVgXyWQDHiyOIb4/
	sE0TlvzsJ4c0pFu813XynlXvf20orPvDg/E1k8KVnNUlJn2mZHTQ1Me8Y4NllUfhORTutAMhQ39
	HU+JPm4ZM/uiiNUTj4Akgldbj0Lzazw4pbUB3skA
X-Google-Smtp-Source: AGHT+IEVdYiWlzMegLjX1SW6MAYHuKS4VsCdlhtERx053TZMPRlmhcuyyeg+BQDgfm+Ow4m/bSY6Iw==
X-Received: by 2002:a17:902:e841:b0:21f:4144:a06f with SMTP id d9443c01a7336-22103f14b7cmr16643875ad.13.1739574143482;
        Fri, 14 Feb 2025 15:02:23 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22105174c73sm1495245ad.216.2025.02.14.15.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 15:02:23 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	johncai86@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com
Subject: [PATCH 2/7] builtin/verify-commit.c: stop using `the_repository`
Date: Sat, 15 Feb 2025 04:27:18 +0530
Message-ID: <20250214230210.1460111-3-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the_repository global variable in favor of the repository
argument that gets passed in "builtin/verify-tag.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_verify_commit()` function with `repo`
set to NULL and then early in the function, `parse_options()` call will
give the options help and exit, without having to consult much of the
configuration file. So it is safe to omit reading the config when `repo`
argument the caller gave us is NULL.

Let's pass `repository` argument to `verify_commit()` function to remove
it's dependency on the global `the_repository` variable.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/verify-commit.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 779b7988ca..50f56d296c 100644
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
@@ -64,7 +63,8 @@ int cmd_verify_commit(int argc,
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	if (repo)
+		repo_config(repo, git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, verify_commit_options,
 			     verify_commit_usage, PARSE_OPT_KEEP_ARGV0);
@@ -78,7 +78,7 @@ int cmd_verify_commit(int argc,
 	 * was received in the process of writing the gpg input: */
 	signal(SIGPIPE, SIG_IGN);
 	while (i < argc)
-		if (verify_commit(argv[i++], flags))
+		if (verify_commit(repo, argv[i++], flags))
 			had_error = 1;
 	return had_error;
 }
-- 
2.48.1

