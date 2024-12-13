Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C534B1BFE03
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086220; cv=none; b=Ns3SBYLJOWNtZ7A6/uhkHdF1M5aiimMXVaHMFniKQwU6aeFqWJ+ROqg5D7+WFdj7vi0QE1xqxvcZRnltUjrHOan6ywwA2d+uLn9GMER833po22eOZLKJ15ewlAA493z5ziFbYrF30fEc9k2ovzX7hLZjA3gl724NclJb5myQPKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086220; c=relaxed/simple;
	bh=Y66dCnSC946I5gvH4/GQmG/6YgI4VpaE3ph4AtJnKe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FLYgw5amvNeZTgd28c2A8gx2KfjOaF0qkHRM1jBgMKHx32S1KDVMnvxLlHN6/XsT7HMptuBvANQ9jxUcdkjTpDH1+/1/cSES/NUnJSISCoGoOTOnD17FvV4SAhGj2UP3SrpBjaxk8AQS7cnVuCClU7w8xU2dYCLzerWzIkZRML0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMOjgYeT; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMOjgYeT"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa692211331so311037266b.1
        for <git@vger.kernel.org>; Fri, 13 Dec 2024 02:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734086217; x=1734691017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2xJZv3kmXE2qjjDNYApZXtq0V9WPB5zDJrYsdgLbgc=;
        b=dMOjgYeTqVMzyKPkGW+1wOWFwMyzg3Ghz7v+ohL6yAcBdbN9P0P2OhzkyUg+Jbz3FZ
         khk2p3Wam9dwyS70dJJLZt/IT7n7m8o5LPuoBqnEI8Kgo3M4DQjy4FjG06L009Je7cNd
         aAcFJoz/w8htaN5Uqol/qs0PCMCy43HelDvwLEql0DjHZvoYOuxNf4/zx+vWNGvgocYt
         yATmNl8La6aCuGNZWwMGebVYZN89laN60Kv9Fg5Los0pyzE+xJ/InjOgYKpeH//2SWgI
         KHdRRjQKsT11FXS07J49QWJfrQpf7sQM4Yu86FgQt8g9a5d/OYzECxsWSymMzkQhoNYs
         ttnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734086217; x=1734691017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2xJZv3kmXE2qjjDNYApZXtq0V9WPB5zDJrYsdgLbgc=;
        b=jkmdwUt9qP/HtUXbo0YRbdYyJsvLeRNnPVH0ZeELIFt+Nz+vmA6dz49vU2BOFMIDWC
         gZz6PNYFOQ9gPkRRuQfSE1LKAHf2eCWtD308xZ/2gMCxnYx6SnYGs7Etu9D1KRu3+4Tw
         P/XV6YsYYzRy70UqJPvFs+Zil9ZKV9ODIUmoELk6tHlpu8N8wnMGz05vt4MxJyDACX4A
         EwhB3lx0WJ9e3vSQ+BzLnVjpXm6VFv0rMEPZnwOTOrmXFCmlw916Zv8yKInl7ZZ9YOKH
         KotxtiBpj66mxG8xhmjKtHDVq89bCciGgntJTpo/2dW5R3Sp/Cdrc8/cqLFNjDgOgzo5
         efPQ==
X-Gm-Message-State: AOJu0YxMF6lwks9WFE22mxT6AXAftfWYLXv75dDB9nqkT6hGVcXGTIeg
	aQ6SkVeOb233+wBsU4roJ4FsNfmNNK6waWHPoEq+8YqdZ5G7qtGVvYa/GZBL
X-Gm-Gg: ASbGncvNkM7VlqqodWONLKgD4pflL8aHSVyXZ/pV2hwPrOKlNADoI2omUmQNqo9wYrw
	krjtuDfoiEK7JLzKT1TNUkeeLMl12QqWtJYBf8OxbJAbLRBCvTQuNFUJ9nclugMlED6AoiOP7mG
	bKSgE4aLtJurhZOnkneBcEUGcnEJ1P2XXcJjSzdgU1hFh7h37HagInYG9mL4Htu0+P3NIyGOShP
	O7HHNaogogbOufUAWIuamIhMEATgwO7ns6RrcDeDZBQqTRE5J4pf4keHiCY/E2HCIqcLw==
X-Google-Smtp-Source: AGHT+IGuRwxZTw8LBy7tl3jV450KXzIxXf3uWo/N2ckbNaVgpe54CO3TJ1rUfpjkbnxcoLwuQw0ORA==
X-Received: by 2002:a17:907:d92:b0:aa6:ade8:2d8c with SMTP id a640c23a62f3a-aa6c40ba702mr741321166b.5.1734086216949;
        Fri, 13 Dec 2024 02:36:56 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6883f65c3sm686785266b.157.2024.12.13.02.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 02:36:56 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 13 Dec 2024 11:36:53 +0100
Subject: [PATCH v2 8/8] refs: add support for migrating reflogs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-320-git-refs-migrate-reflogs-v2-8-f28312cdb6c0@gmail.com>
References: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
In-Reply-To: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11041;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=Y66dCnSC946I5gvH4/GQmG/6YgI4VpaE3ph4AtJnKe8=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnXA5BKnm+9CtHZQsTPxdaYljFytP9GA+e/LfJR
 sh3TVvYMfaJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ1wOQQAKCRA+1Z8kjkaM
 f9Z7C/9jg3xVNPrpgWogvVpBj7qMwnHxsb1/L+gB2CD2RFCdQt0fhIDvpLVyp32EuY9G406GHf/
 /6lvaWM/tBW643WWR0KdzevxIaLAOC3llx+/UvbjHDbRPCa1lqmTYXGD0kZxSgIn8NVuUmGQvaV
 8EO3YkMi4sL/3vgTM5oYP3zUrlsrXPySQeso64pck/+F9m9XAVK2067lksowMBexHDc9rdd4pCD
 h6SAkdGlB2yyVpaGG/pl1yFZnd8oDSN7JSH2k/9KxeSnhU4DRlCa/+Twhq/tFpvJJgZcDbNDRMV
 u2e9kxOCgz+6W9F/rWdERrJnCha8al5+2ePb1SFeDHDXfogI/gg9Twb1q4zevJ62qOceCNuu5jt
 iKzimobfLGYr+bIxvt4wv39Lld5WWpqJtp42QLDuxx+A5JbyEyp90DYzAIfZmS728K2qrUyvhFN
 1VXLneznzj6qb41aozidTDW//U9CTnEJ2wNkfRNgXXKBheEtqnFPTlXKb5nmL6h0jO310=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `git refs migrate` command was introduced in
25a0023f28 (builtin/refs: new command to migrate ref storage formats,
2024-06-06) to support migrating from one reference backend to another.

One limitation of the command was that it didn't support migrating
repositories which contained reflogs. A previous commit, added support
for adding reflog updates in ref transactions. Using the added
functionality bake in reflog support for `git refs migrate`.

To ensure that the order of the reflogs is maintained during the
migration, we add the index for each reflog update as we iterate over
the reflogs from the old reference backend. This is to ensure that the
order is maintained in the new backend.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-refs.txt |  2 --
 refs.c                     | 89 ++++++++++++++++++++++++++++++++--------------
 t/t1460-refs-migrate.sh    | 73 +++++++++++++++++++++++++------------
 3 files changed, 113 insertions(+), 51 deletions(-)

diff --git a/Documentation/git-refs.txt b/Documentation/git-refs.txt
index ce31f93061db5e5d16aca516dd3d15f6527db870..9829984b0a4c4f54ec7f9b6c6c7072f62b1d198d 100644
--- a/Documentation/git-refs.txt
+++ b/Documentation/git-refs.txt
@@ -57,8 +57,6 @@ KNOWN LIMITATIONS
 
 The ref format migration has several known limitations in its current form:
 
-* It is not possible to migrate repositories that have reflogs.
-
 * It is not possible to migrate repositories that have worktrees.
 
 * There is no way to block concurrent writes to the repository during an
diff --git a/refs.c b/refs.c
index 9f539369bc94a25594adc3e95847f2fe72f58a08..f19292d50f0003881220e8f7cfcf6c7eb4b2e749 100644
--- a/refs.c
+++ b/refs.c
@@ -30,6 +30,7 @@
 #include "date.h"
 #include "commit.h"
 #include "wildmatch.h"
+#include "ident.h"
 
 /*
  * List of all available backends
@@ -2673,6 +2674,7 @@ int ref_update_check_old_target(const char *referent, struct ref_update *update,
 }
 
 struct migration_data {
+	unsigned int reflog_index;
 	struct ref_store *old_refs;
 	struct ref_transaction *transaction;
 	struct strbuf *errbuf;
@@ -2708,6 +2710,53 @@ static int migrate_one_ref(const char *refname, const char *referent UNUSED, con
 	return ret;
 }
 
+struct reflog_migration_data {
+	unsigned int *index;
+	const char *refname;
+	struct ref_store *old_refs;
+	struct ref_transaction *transaction;
+	struct strbuf *errbuf;
+};
+
+static int migrate_one_reflog_entry(struct object_id *old_oid,
+				    struct object_id *new_oid,
+				    const char *committer,
+				    timestamp_t timestamp, int tz,
+				    const char *msg, void *cb_data)
+{
+	struct reflog_migration_data *data = cb_data;
+	struct strbuf sb = STRBUF_INIT;
+	const char *date;
+	int ret;
+
+	date = show_date(timestamp, tz, DATE_MODE(NORMAL));
+	/* committer contains name and email */
+	strbuf_addstr(&sb, fmt_ident("", committer, WANT_BLANK_IDENT, date, 0));
+
+	ret = ref_transaction_update_reflog(data->transaction, data->refname,
+					    new_oid, old_oid, sb.buf,
+					    REF_HAVE_NEW | REF_HAVE_OLD, msg,
+					    (*data->index)++, data->errbuf);
+	strbuf_release(&sb);
+
+	return ret;
+}
+
+static int migrate_one_reflog(const char *refname, void *cb_data)
+{
+	struct migration_data *migration_data = cb_data;
+	struct reflog_migration_data data;
+
+	data.refname = refname;
+	data.old_refs = migration_data->old_refs;
+	data.transaction = migration_data->transaction;
+	data.errbuf = migration_data->errbuf;
+	data.index = &migration_data->reflog_index;
+
+	return refs_for_each_reflog_ent(migration_data->old_refs, refname,
+					migrate_one_reflog_entry, &data);
+}
+
 static int move_files(const char *from_path, const char *to_path, struct strbuf *errbuf)
 {
 	struct strbuf from_buf = STRBUF_INIT, to_buf = STRBUF_INIT;
@@ -2774,13 +2823,6 @@ static int move_files(const char *from_path, const char *to_path, struct strbuf
 	return ret;
 }
 
-static int count_reflogs(const char *reflog UNUSED, void *payload)
-{
-	size_t *reflog_count = payload;
-	(*reflog_count)++;
-	return 0;
-}
-
 static int has_worktrees(void)
 {
 	struct worktree **worktrees = get_worktrees();
@@ -2806,7 +2848,6 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	struct ref_transaction *transaction = NULL;
 	struct strbuf new_gitdir = STRBUF_INIT;
 	struct migration_data data;
-	size_t reflog_count = 0;
 	int did_migrate_refs = 0;
 	int ret;
 
@@ -2818,21 +2859,6 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 
 	old_refs = get_main_ref_store(repo);
 
-	/*
-	 * We do not have any interfaces that would allow us to write many
-	 * reflog entries. Once we have them we can remove this restriction.
-	 */
-	if (refs_for_each_reflog(old_refs, count_reflogs, &reflog_count) < 0) {
-		strbuf_addstr(errbuf, "cannot count reflogs");
-		ret = -1;
-		goto done;
-	}
-	if (reflog_count) {
-		strbuf_addstr(errbuf, "migrating reflogs is not supported yet");
-		ret = -1;
-		goto done;
-	}
-
 	/*
 	 * Worktrees complicate the migration because every worktree has a
 	 * separate ref storage. While it should be feasible to implement, this
@@ -2858,17 +2884,21 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	 *      This operation is safe as we do not yet modify the main
 	 *      repository.
 	 *
-	 *   3. If we're in dry-run mode then we are done and can hand over the
+	 *   3. Enumerate all reflogs and write them into the new ref storage.
+	 *      This operation is safe as we do not yet modify the main
+	 *      repository.
+	 *
+	 *   4. If we're in dry-run mode then we are done and can hand over the
 	 *      directory to the caller for inspection. If not, we now start
 	 *      with the destructive part.
 	 *
-	 *   4. Delete the old ref storage from disk. As we have a copy of refs
+	 *   5. Delete the old ref storage from disk. As we have a copy of refs
 	 *      in the new ref storage it's okay(ish) if we now get interrupted
 	 *      as there is an equivalent copy of all refs available.
 	 *
-	 *   5. Move the new ref storage files into place.
+	 *   6. Move the new ref storage files into place.
 	 *
-	 *   6. Change the repository format to the new ref format.
+	 *  7. Change the repository format to the new ref format.
 	 */
 	strbuf_addf(&new_gitdir, "%s/%s", old_refs->gitdir, "ref_migration.XXXXXX");
 	if (!mkdtemp(new_gitdir.buf)) {
@@ -2910,6 +2940,11 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	if (ret < 0)
 		goto done;
 
+	data.reflog_index = 1;
+	ret = refs_for_each_reflog(old_refs, migrate_one_reflog, &data);
+	if (ret < 0)
+		goto done;
+
 	ret = ref_transaction_commit(transaction, errbuf);
 	if (ret < 0)
 		goto done;
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index 1bfff3a7afd5acc470424dfe7ec3e97d45f5c481..f59bc4860f19c4af82dc6f2984bdb69d61fe3ec2 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -7,23 +7,44 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+# Migrate the provided repository from one format to the other and
+# verify that the references and logs are migrated over correctly.
+# Usage: test_migration <repo> <format> <skip_reflog_verify>
+#   <repo> is the relative path to the repo to be migrated.
+#   <format> is the ref format to be migrated to.
+#   <skip_reflog_verify> (true or false) whether to skip reflog verification.
 test_migration () {
-	git -C "$1" for-each-ref --include-root-refs \
+	repo=$1 &&
+	format=$2 &&
+	skip_reflog_verify=${3:-false} &&
+	git -C "$repo" for-each-ref --include-root-refs \
 		--format='%(refname) %(objectname) %(symref)' >expect &&
-	git -C "$1" refs migrate --ref-format="$2" &&
-	git -C "$1" for-each-ref --include-root-refs \
+	if ! $skip_reflog_verify
+	then
+	   git -C "$repo" reflog --all >expect_logs &&
+	   git -C "$repo" reflog list >expect_log_list
+	fi &&
+
+	git -C "$repo" refs migrate --ref-format="$2" &&
+
+	git -C "$repo" for-each-ref --include-root-refs \
 		--format='%(refname) %(objectname) %(symref)' >actual &&
 	test_cmp expect actual &&
+	if ! $skip_reflog_verify
+	then
+		git -C "$repo" reflog --all >actual_logs &&
+		git -C "$repo" reflog list >actual_log_list &&
+		test_cmp expect_logs actual_logs &&
+		test_cmp expect_log_list actual_log_list
+	fi &&
 
-	git -C "$1" rev-parse --show-ref-format >actual &&
-	echo "$2" >expect &&
+	git -C "$repo" rev-parse --show-ref-format >actual &&
+	echo "$format" >expect &&
 	test_cmp expect actual
 }
 
 test_expect_success 'setup' '
-	rm -rf .git &&
-	# The migration does not yet support reflogs.
-	git config --global core.logAllRefUpdates false
+	rm -rf .git
 '
 
 test_expect_success "superfluous arguments" '
@@ -78,19 +99,6 @@ do
 			test_cmp expect err
 		'
 
-		test_expect_success "$from_format -> $to_format: migration with reflog fails" '
-			test_when_finished "rm -rf repo" &&
-			git init --ref-format=$from_format repo &&
-			test_config -C repo core.logAllRefUpdates true &&
-			test_commit -C repo logged &&
-			test_must_fail git -C repo refs migrate \
-				--ref-format=$to_format 2>err &&
-			cat >expect <<-EOF &&
-			error: migrating reflogs is not supported yet
-			EOF
-			test_cmp expect err
-		'
-
 		test_expect_success "$from_format -> $to_format: migration with worktree fails" '
 			test_when_finished "rm -rf repo" &&
 			git init --ref-format=$from_format repo &&
@@ -141,7 +149,7 @@ do
 			test_commit -C repo initial &&
 			test-tool -C repo ref-store main update-ref "" refs/heads/broken \
 				"$(test_oid 001)" "$ZERO_OID" REF_SKIP_CREATE_REFLOG,REF_SKIP_OID_VERIFICATION &&
-			test_migration repo "$to_format" &&
+			test_migration repo "$to_format" true &&
 			test_oid 001 >expect &&
 			git -C repo rev-parse refs/heads/broken >actual &&
 			test_cmp expect actual
@@ -195,6 +203,27 @@ do
 			git -C repo rev-parse --show-ref-format >actual &&
 			test_cmp expect actual
 		'
+
+		test_expect_success "$from_format -> $to_format: reflogs of symrefs with target deleted" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=$from_format repo &&
+			test_commit -C repo initial &&
+			git -C repo branch branch-1 HEAD &&
+			git -C repo symbolic-ref refs/heads/symref refs/heads/branch-1 &&
+			cat >input <<-EOF &&
+			delete refs/heads/branch-1
+			EOF
+			git -C repo update-ref --stdin <input &&
+			test_migration repo "$to_format"
+		'
+
+		test_expect_success "$from_format -> $to_format: reflogs order is retained" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=$from_format repo &&
+			test_commit --date "100005000 +0700" --no-tag -C repo initial &&
+			test_commit --date "100003000 +0700" --no-tag -C repo second &&
+			test_migration repo "$to_format"
+		'
 	done
 done
 

-- 
2.47.1

