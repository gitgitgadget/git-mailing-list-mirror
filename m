Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31F5194A48
	for <git@vger.kernel.org>; Sun, 15 Dec 2024 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734279963; cv=none; b=qOwU5LZQsQhVhIL0bpQBZddHDEtX2xOZGadaSO0wEZX6RBqGajrZNnRalv1WaS3NpUdSCtwYaNwrhNOISAZse56SqZKDRraZoK436J01UBZyh8YUd61wqD44tPkLKB8vVb2Vf9yYAqN1PzLrRcbBk73F5NCv2yiWnM26QhmERRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734279963; c=relaxed/simple;
	bh=zW/FnKkrM2PUKFsvbiMZ/XJ09fEZtN+WkaFko91Fvzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HTUGlYXXnWfnqcqcKj3Gbzc3E3mSoYFuBZW3ro63hqpc7rG6HJmY1onSsXhM1lFeJQREJHtesmUApxozfvLnWaWOavzeq3WSRoGEyAvFzwYy0HjIFs6KIi3YzKDcwAa95baCEgJ6BVbRSzJWt2FF4MguHtc1YSo/G5+ZbxgDLkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RP0jriJ0; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RP0jriJ0"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d27243ba8bso6260673a12.2
        for <git@vger.kernel.org>; Sun, 15 Dec 2024 08:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734279959; x=1734884759; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xzx/hpb0tlRTDTgKeQlXGTFN5b9cnPUAa/S44t41PsI=;
        b=RP0jriJ0Dd/dYD7BByYUgO5oEJEBfR03delVjBJHWoi0FGlu5sJVYi5dfkJNLJjvBy
         3j6i4Lx3BGjGJ0H8lMP4xSP1gxlb9LEQn3DgsgRqEBFYw9aZIAJB1fDrrTz/nYz9GRhs
         Fk8/MT+ITTCedGCy4xDMUqiBvEkfdZptbXGLF4m+T/h002IBss2s2gNORParTMie0zpP
         DNBNe43VWBNfcjZ1btmJqcKPi8ES3Zbu79YdCDzcA8/J00ouBiLoNv/50stNnnXLJqMM
         IPWNBZlQehmD1RvyeBfYrsiurc+XYgdM/1Kq7A4tYbHiO9HJo9HWU1/jFqiw71xvKZKU
         LTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734279959; x=1734884759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzx/hpb0tlRTDTgKeQlXGTFN5b9cnPUAa/S44t41PsI=;
        b=hgxhxJWFIId7IYVeUMEQJ8T0QYCe3tlraBkphgnwRtJgYYMfKoWI12R3u24ESu670W
         NGZP8yYssZPHx5NAaUk6kYCF61QM1P0TKDE1HEkfJLNdxH29OJ6mZNBD9Px8FnP6h+Ul
         w2g8ldV112yyH1zplW4SmDKH0YjspZOmJ8/oMQEDygPqqdrLMVoY4ipynqlYuwnhtAMS
         4qiGN4f0gfsX9eLxKbE/1NbyDW4qgrizgY/LSQKnqFjPyzs2q21oYl9ZSVaePWXm540x
         cid/1smWORAQEGSKfxqyqpszHH9Zdv9/kCHAU0fivUi+mG7OvYC3V6H8AHBDdF2NOl5/
         C3qA==
X-Gm-Message-State: AOJu0YwZDXMvMwlkJbvks+Vra+nTDtyVYC6f6lmgeC0fyV3NCZM/NzjT
	d262hVnb/W6I+vbS8pR1ti03IPs8caZvp8Toy+uALAY0TiyVJpY/
X-Gm-Gg: ASbGnctIjedDWpA6g63N+5AOBjwLZhl9K2WtpE2EHCW4wODlgwBpvUMCCF1PbdJho+t
	LXeht01n88F90lIqU8QKO4N8AWi9tK/XEcXymcFz6oLbpaDXKssqgAusU8f/qbEgXDFiyE76a0j
	217e+cV8soRC1N41lz7zwgsNFjgMzRH8547DNNnfeYcrabPvLVllI3GHWRTOUate0uuwSkbTXYm
	fVuq/XmEtzSZyM+uusz+40vjZPiydFvr1nv2oAPbxRDroLZFglyZD/tgfTfbcP7JKz2iw==
X-Google-Smtp-Source: AGHT+IFO44eVBYAJtHmJkxXFIkaaAd2JgTbLYvx0J177wsqTOG3Dwi+ZGIAtgLuUB47aRvJsg6qhbA==
X-Received: by 2002:a17:907:7f17:b0:aa6:519c:ef9a with SMTP id a640c23a62f3a-aab77ead24bmr888229566b.53.1734279958814;
        Sun, 15 Dec 2024 08:25:58 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9638ad1asm224887866b.139.2024.12.15.08.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 08:25:58 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sun, 15 Dec 2024 17:25:45 +0100
Subject: [PATCH v3 8/8] refs: add support for migrating reflogs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241215-320-git-refs-migrate-reflogs-v3-8-4127fe707b98@gmail.com>
References: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
In-Reply-To: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11509;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=zW/FnKkrM2PUKFsvbiMZ/XJ09fEZtN+WkaFko91Fvzo=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnXwMPBAQCceFdbcLbEN7CsRB8GgrBga+8Ja6T/
 hUlBBLXZMGJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ18DDwAKCRA+1Z8kjkaM
 f5TwC/9idQ5f6+sMIBIhv5P7V+8MDoqcuZEPu7ejLzf10xptnbo+4MRbAc0eJWBFwuYrtPxmLWo
 PVSlvto4x3+T/BSHAPrYbpzVhJhY3NmWzueBqprIEB1NcW8lk/dScwyfQqvyyi3ZfdmSkJ8BlZJ
 oCMiWt+EdjXy05EJxm4LpGcneBQUP/iyKr/2F6D7n/mv0mQQxIVoCVPQlVA0da4CPXkW/y+dZIz
 xGWptBTXJ+d6LT9NjFc5hC7CGGxlRIbDPTKTVWRA3i/ccDLWzyr9uvwKolod8Wk7NBTEXcAiP24
 +FxMGnb3KCJl0R05rnhhGzHemj22vNRmE6x9tcx4+GV4l9JzITPhwH/opXFid++IaD8uGyoTxy+
 rng8pqycEcFfaQFzJCCVRPbfx2gH4M8SLwOz40qeLzEVVegUa8Ywwo8VEPUEl2XKq8d2A5vDxKF
 o2xlovzcLDOxsXfxnn6JoWKMFmpdT8RlTwjbl7Z3QSrr+zC54hBFWrbN02rv59y6+Y3Tk=
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
index 8b3882cff17e5e3b0376f75654e32f81a23e5cb2..4a74f7c7bd0314ad8e6c4cbea436df934b2c7f88 100644
--- a/refs.c
+++ b/refs.c
@@ -30,6 +30,7 @@
 #include "date.h"
 #include "commit.h"
 #include "wildmatch.h"
+#include "ident.h"
 
 /*
  * List of all available backends
@@ -2673,6 +2674,7 @@ struct migration_data {
 	struct ref_store *old_refs;
 	struct ref_transaction *transaction;
 	struct strbuf *errbuf;
+	struct strbuf sb;
 };
 
 static int migrate_one_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
@@ -2705,6 +2707,52 @@ static int migrate_one_ref(const char *refname, const char *referent UNUSED, con
 	return ret;
 }
 
+struct reflog_migration_data {
+	unsigned int index;
+	const char *refname;
+	struct ref_store *old_refs;
+	struct ref_transaction *transaction;
+	struct strbuf *errbuf;
+	struct strbuf *sb;
+};
+
+static int migrate_one_reflog_entry(struct object_id *old_oid,
+				    struct object_id *new_oid,
+				    const char *committer,
+				    timestamp_t timestamp, int tz,
+				    const char *msg, void *cb_data)
+{
+	struct reflog_migration_data *data = cb_data;
+	const char *date;
+	int ret;
+
+	date = show_date(timestamp, tz, DATE_MODE(NORMAL));
+	strbuf_reset(data->sb);
+	/* committer contains name and email */
+	strbuf_addstr(data->sb, fmt_ident("", committer, WANT_BLANK_IDENT, date, 0));
+
+	ret = ref_transaction_update_reflog(data->transaction, data->refname,
+					    new_oid, old_oid, data->sb->buf,
+					    REF_HAVE_NEW | REF_HAVE_OLD, msg,
+					    data->index++, data->errbuf);
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
+	data.sb = &migration_data->sb;
+
+	return refs_for_each_reflog_ent(migration_data->old_refs, refname,
+					migrate_one_reflog_entry, &data);
+}
+
 static int move_files(const char *from_path, const char *to_path, struct strbuf *errbuf)
 {
 	struct strbuf from_buf = STRBUF_INIT, to_buf = STRBUF_INIT;
@@ -2771,13 +2819,6 @@ static int move_files(const char *from_path, const char *to_path, struct strbuf
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
@@ -2803,7 +2844,6 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	struct ref_transaction *transaction = NULL;
 	struct strbuf new_gitdir = STRBUF_INIT;
 	struct migration_data data;
-	size_t reflog_count = 0;
 	int did_migrate_refs = 0;
 	int ret;
 
@@ -2815,21 +2855,6 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 
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
@@ -2855,17 +2880,21 @@ int repo_migrate_ref_storage_format(struct repository *repo,
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
@@ -2889,6 +2918,7 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	data.old_refs = old_refs;
 	data.transaction = transaction;
 	data.errbuf = errbuf;
+	strbuf_init(&data.sb, 0);
 
 	/*
 	 * We need to use the internal `do_for_each_ref()` here so that we can
@@ -2907,6 +2937,10 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	if (ret < 0)
 		goto done;
 
+	ret = refs_for_each_reflog(old_refs, migrate_one_reflog, &data);
+	if (ret < 0)
+		goto done;
+
 	ret = ref_transaction_commit(transaction, errbuf);
 	if (ret < 0)
 		goto done;
@@ -2982,6 +3016,7 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	}
 	ref_transaction_free(transaction);
 	strbuf_release(&new_gitdir);
+	strbuf_release(&data.sb);
 	return ret;
 }
 
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

