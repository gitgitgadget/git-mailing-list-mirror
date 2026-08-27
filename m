Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E944C9013
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855354; cv=none; b=ViCfCebL2og5y1YUSSZGnAqVan9ulWNTdoMU5xAy4TBXeW017MW+mdsZvWVrIGpM+48aIeVK8BGBQ4/wEnOHVcq8E2YwvzV9p1OX+ZwTY78LRnKQfFSwGpUOVVjDFtNQa3T4zWWgJrm7QFBihAW4CfE0IUfaF5Hyv5gMy/wZ/Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855354; c=relaxed/simple;
	bh=l5zxuUiyiKVhezhI8UfbKj7N+gz8LK/WhCBiybM9MiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RuYuxiFLH+slANkPhBQqopP2Ol4dDVgw4VNDsIUGmDV7LJywcUNHVUMFuCzQr1QT0/RAtYlIuFEXNlfiyf3xYjyiBJEt9+GANzpdNk4uqvF6z8VLnuaANH45vj/NyJ5jY/KVn5cwiyHH1ueSYz1djgrEUGNpDxaeLFFCMO6UZyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/QLY4fC; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/QLY4fC"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so346733a91.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 11:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787855353; x=1788460153; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IQMImssOZ9DSbaRvZlK8UXXQJQdFW/DoQfsoGxbODIM=;
        b=E/QLY4fCjetn+Yo7vD6DK8EM6sUzL2ocxljQ8OSrOTon4rqpzy5GFJFhDj35vA3BwK
         rqlvb5uV53fKZpMGcZ4jdz99KBKocj721GQPf7JfgvLLefB6wMd9/T/CmQFXVulasTNR
         OiSEmbKzxmDLvEBL57WBPG6iEcZXjEnkbLo7vLX+D4/JBt5WnLm2qcB92JRVkwfT1vkh
         ZV+5SVc+aKhBxELwF5UGbhQ0hPbDfaY22QujxJd2qQ9MLh0MIF+vDsz2CL/UDSHJrU9M
         gXXPwSZjEv7dflgHOtaq0M/6jDqHSGhl4pDyQ8EOI2L/lTgPu1lasjxF00RFZSL8FS6a
         7ppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787855353; x=1788460153;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IQMImssOZ9DSbaRvZlK8UXXQJQdFW/DoQfsoGxbODIM=;
        b=jtRd2ZlDAh6FGAMsk54dHqtvDq3Ed4xVmhpAnDDbk9jui07upfWRnt9UkBUrgMvm4c
         KYrICVShuMpaPhmQg1eE2Z9yG3Irfbezrh7h2tYWm863yvIF/12MWKdFxx0cUXeR4SPk
         4qlTjn91S7zieqV14Q7UyD3BdS0/IajgjVzi0c1b4x/l92KrCID3crjoDeHs0+PPx0Q9
         HyTstRpJ/vgenLdo0sbWGW0kqgzStT3bDcY+k9q4sbByr77GhbcRdamahVjVA9VqHAF3
         c0PJwId7QWNfmaW+V6nt6mYf9aUusXi9PNgth1CG98gS6B+2A+mxlKawyCCC1DUg/0HT
         jVdw==
X-Gm-Message-State: AFuF++m0L4suOHAk31FWzkOHn3LSt4N95IdMCLV6dvVlbd8HgYuHAVwL
	MRfCbwnPJlaykR8eKxEch+gsaLgWBkjAOLI06Jf3piiFkNlyubt5FnKuWZK9uw==
X-Gm-Gg: AR+sD11ivEdlLjlMWIe1bw+sd/Px53wMHC3Fq0WA48V1oRCBbNl6G/krBe0d1iXpeiV
	nwKZYbnyvak+B/b9gU15TdKiVAmkR3qSth3/i5OjNvTJ6QheeNnCcENf/OQMn1JftLsG906LAAq
	DGsXJuRF9hDy47+Bz3GbopzEMG5Qka0ZYdQf3tiC9Krj0HTu9fheMn0Za86QSadHNPtyopa0aiL
	DOwkwHRV7sEKGv8rk19sVyN2iDTwIGpe09avumrxpXjBPan7qtl5QdoTTzYhioSEWfiYvWrU8lv
	d+UErohCb/jLivxm7W0AsrIlZzHPJM5gjC1vjpZnOlCkjOAS0JVsZ9ba69Mq6z4bl1BuOp2sAw7
	KK7sFtQ6h5rhDSEketI6EOHEktIleaumvBFBPQYFZhPZ7jqNN3TCeq2X5zevK84z2gjN8t+XNyx
	8z7H1DyYNUa4tKuY+oTG40hSnAipDhALIl6vHf3gmMNa7iC/g+1KgyDP6y1Jz02eM=
X-Received: by 2002:a17:90b:518f:b0:38e:9eb2:9d43 with SMTP id 98e67ed59e1d1-396d0ff2eccmr2206138a91.16.1787855352541;
        Thu, 27 Aug 2026 11:29:12 -0700 (PDT)
Received: from [100.87.176.22] ([117.213.200.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d63bb23sm22184713eec.7.2026.08.27.11.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:29:12 -0700 (PDT)
From: Hardik Kumar <hardikxk@gmail.com>
Date: Thu, 27 Aug 2026 23:59:00 +0530
Subject: [PATCH] builtin: replace the_repository parameter in
 is_bare_repository()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-env-is_bare_repo-v1-1-aa99600dc213@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MywqAIBBA0V+JWSeYvfuViPAx1WwsRpBA/Pek5
 VncmyAgEwZYqgSMkQLdvqCpK7CX9icKcsWgpBrkpEaBPgoKu9GMO+Nzi37o5ma0yrXaQMkexoP
 ef7luOX+qQIPoYgAAAA==
X-Change-ID: 20260827-env-is_bare_repo-564917c2d3ab
To: git@vger.kernel.org
Cc: Hardik Kumar <hardikxk@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787855350; l=4892;
 i=hardikxk@gmail.com; s=20260827; h=from:subject:message-id;
 bh=l5zxuUiyiKVhezhI8UfbKj7N+gz8LK/WhCBiybM9MiA=;
 b=GQHA/GaJAJksoUTFXVzIp9kVkll0qhfy6lO/cw7B3JwHXAzwdSieoWOLfSoP/GDLc4MabvyH1
 VA/Ev4gI4eOB9Kj9WvtGgbStTE9Dbb816ZdZP/blRJDPAOnO2LdBYOY
X-Developer-Key: i=hardikxk@gmail.com; a=ed25519;
 pk=56yFuFlLHAdRemUZghoGHVCijEX767atrut3dPD0thQ=

Many functions receive a `struct repository *repo` parameter but do not
use it (marked UNUSED) and instead pass the global `the_repository`
parameter to the `is_bare_repository()` function.

Replace the argument passed to `is_bare_repository()` from the global
`the_repository` parameter to take the unused repository parameter so
that we no longer depend on `the_repository`. Patch covers the sites
that were not updated previously.

The patch leaves some instances of this case that would require
additional changes rather than simply replacing the arguments passed to
the function call.

- Only update sites that do not introduce any functional changes.
- `UNUSED` is dropped from `*repo` parameter to match the changes.

Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
---
 builtin/blame.c | 4 ++--
 builtin/gc.c    | 4 ++--
 builtin/repo.c  | 4 ++--
 builtin/reset.c | 4 ++--
 transport.c     | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 48d5251c6d..dbf4b4ffc7 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -957,7 +957,7 @@ static void build_ignorelist(struct blame_scoreboard *sb,
 int cmd_blame(int argc,
 	      const char **argv,
 	      const char *prefix,
-	      struct repository *repo UNUSED)
+	      struct repository *repo)
 {
 	struct rev_info revs;
 	char *path = NULL;
@@ -1187,7 +1187,7 @@ int cmd_blame(int argc,
 
 	revs.disable_stdin = 1;
 	setup_revisions(argc, argv, &revs, NULL);
-	if (!revs.pending.nr && is_bare_repository(the_repository)) {
+	if (!revs.pending.nr && is_bare_repository(repo)) {
 		struct commit *head_commit;
 		struct object_id head_oid;
 
diff --git a/builtin/gc.c b/builtin/gc.c
index de2f9e7fed..8e82cce86b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -582,7 +582,7 @@ static int maintenance_task_odb(struct maintenance_run_opts *opts,
 int cmd_gc(int argc,
 	   const char **argv,
 	   const char *prefix,
-	   struct repository *repo UNUSED)
+	   struct repository *repo)
 {
 	int aggressive = 0;
 	int force = 0;
@@ -637,7 +637,7 @@ int cmd_gc(int argc,
 		die(_("failed to parse gc.logExpiry value %s"), cfg.gc_log_expire);
 
 	if (cfg.pack_refs < 0)
-		cfg.pack_refs = !is_bare_repository(the_repository);
+		cfg.pack_refs = !is_bare_repository(repo);
 
 	argc = parse_options(argc, argv, prefix, builtin_gc_options,
 			     builtin_gc_usage, 0);
diff --git a/builtin/repo.c b/builtin/repo.c
index 84e012f83f..0bf3c0a475 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -58,9 +58,9 @@ struct repo_info_field {
 	get_value_fn *get_value;
 };
 
-static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
+static int get_layout_bare(struct repository *repo, struct strbuf *buf)
 {
-	strbuf_addstr(buf, is_bare_repository(the_repository) ? "true" : "false");
+	strbuf_addstr(buf, is_bare_repository(repo) ? "true" : "false");
 	return 0;
 }
 
diff --git a/builtin/reset.c b/builtin/reset.c
index 78e69bd84b..e029b7e99a 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -336,7 +336,7 @@ static int git_reset_config(const char *var, const char *value,
 int cmd_reset(int argc,
 	      const char **argv,
 	      const char *prefix,
-	      struct repository *repo UNUSED)
+	      struct repository *repo)
 {
 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
 	int no_refresh = 0;
@@ -470,7 +470,7 @@ int cmd_reset(int argc,
 	if (reset_type != SOFT && (reset_type != MIXED || repo_get_work_tree(the_repository)))
 		setup_work_tree(the_repository);
 
-	if (reset_type == MIXED && is_bare_repository(the_repository))
+	if (reset_type == MIXED && is_bare_repository(repo))
 		die(_("%s reset is not allowed in a bare repository"),
 		    _(reset_type_names[reset_type]));
 
diff --git a/transport.c b/transport.c
index 25e2c14a7b..82eea3024b 100644
--- a/transport.c
+++ b/transport.c
@@ -1528,7 +1528,7 @@ int transport_push(struct repository *r,
 
 	if ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
 		      TRANSPORT_RECURSE_SUBMODULES_ONLY)) &&
-	    !is_bare_repository(the_repository)) {
+	    !is_bare_repository(r)) {
 		struct ref *ref = remote_refs;
 		struct oid_array commits = OID_ARRAY_INIT;
 
@@ -1555,7 +1555,7 @@ int transport_push(struct repository *r,
 	if (((flags & TRANSPORT_RECURSE_SUBMODULES_CHECK) ||
 	     ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
 			TRANSPORT_RECURSE_SUBMODULES_ONLY)) &&
-	      !pretend)) && !is_bare_repository(the_repository)) {
+	      !pretend)) && !is_bare_repository(r)) {
 		struct ref *ref = remote_refs;
 		struct string_list needs_pushing = STRING_LIST_INIT_DUP;
 		struct oid_array commits = OID_ARRAY_INIT;

---
base-commit: f78ce2f7b6df702f93d40b85d6bda92a3f65da79
change-id: 20260827-env-is_bare_repo-564917c2d3ab

