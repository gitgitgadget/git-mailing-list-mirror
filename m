Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E354D3B8BCB
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 21:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792186653; cv=none; b=itRrN9i0ZDy/5ju2Jjh6tbVCdIFwg+Ig9m9ops7XG+7+D++lAINt72oeWIGH7Dptq1VtYGaLkc0sEp9d3v9RplokWF+fjuKShPOxu1ClQ8WjMNLjrmiecpKFV4Y7XNawG1cdBKCNT+AQt9l0L6b352Zc1JL0VuNUcqZbht0GWi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792186653; c=relaxed/simple;
	bh=BDsufEsSpKaNE0xplPXhj+SzTeCUoDTTZ1FcMMYW0L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f90TjaBWxjkC0MZA/h+9hzfK/Hx9oQRPGNcnoFUX5BNB9hq0RXs+fBM41rHfdWdXewxyRwUu9nwxE81sM0er3wRikYs6VWN4n6hGVzyUxHtLUU1uTsXAkdFBnyqVoia7yvbZ2/IMQRixAN9lBOZ2jhUjZZ/4/Hz5oqnbWL3AyFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ox5FH2Wi; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ox5FH2Wi"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-82478760557so183922a34.3
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 14:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792186651; x=1792791451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AIvrh2K0fH3mHWeevYfzyQGssIc66lRJSv3dkgOgAgs=;
        b=ox5FH2WiR6zYMQahRC8pE7b8uacu4dcdR+TjvSrDl3FyJfXLHq7N9KCY3wf21NfBxz
         GiJS/xvNmqvGVwbNJZOnhj9t5i+TyPGT5jEVnCwo8P6+e1i21wRpT7cyWH+5wsuBwByB
         Y7kAX51aUZmqzjXy3XDZrYyTlsHD8AWA+BOOS7jPUAP/d82VxDGQwpm7LzkhX0RmyRdc
         U5AFQWBH5qAzmRWzOq0Bhc3uUkHggvRLXzjQOuWboAwSpbwGbozm9JnPNDKE4vBPbns/
         8NYmMmgI1pNfvz48awqK4RwAk1aYQ6Ae953ospmdDO0kDo5IObvYQ6EXoVL797au1Apq
         MGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792186651; x=1792791451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AIvrh2K0fH3mHWeevYfzyQGssIc66lRJSv3dkgOgAgs=;
        b=QWhnAzkMfwQbKzuW/BIY3yDSFQGLodIF/7Wm4VjViVY4FwQJmsCTZZ5uLiybeTRhDe
         mva8zxXzIPs9YLkBzPw4TQVlWCl0blbzGVEEWnu7iPYu2y2JlqWXetCt3wbtkAJMsw1R
         3LjMXve2aFEecOkQrS/iWCSy+9ph6bxC0ebc02P26mIZNaN2AVCaYQlqdgOwGRxwNrMw
         GheUEgM3UY4cUsP0VVVIF6qcJ2ak/yysMC4qUL0xV7EEu6JOkf0JgU6vrosP9v5EhZB7
         8rGOVxcS31I07Hqo9mLHDwgtN4sj/MZESY9ZgAqpxnZUl6yx1T92QKmPXO5dGliww9AA
         yw8A==
X-Gm-Message-State: AFq9FYI49DJCrzUbskZLEfivZE2ApjZLftm1q0BveW9OzYZyQx1GC0xb
	Nna0rWFmJosW7EpltDgGjNTDp1d2nZWorpEEtJ0ZN1HG2DaQRY/IDj6wmperww==
X-Gm-Gg: AYBFou2I4e9HL9oq5cgtJNWmKcZfqkhlW7ms6ISphugFzvY2X1hE9TWLpnBQYyhp/qJ
	oOvhZDqaWIK7FMgqOhm/+tj1pmN5PCj4nJng8NRgXoF0Rzlrm0eRW2ZmN6nJ5si9G/VsLARcTIJ
	1gDqRsvsFdJPr1+f0f0arbaGwV8TK/5wEpFY8eDwHzsD8tqONGjggK4RegWkPCCyXyu5OG7fJRf
	OQbeAvPJuBpAL5q8jajG9L4Y5nXKn4IpGOZc5u1eBGCJeSVdq7LDt4bP5ig9W4gGs37ZjGcp5aU
	YBNoOXrgv21wNpns+7OHlMiR+OOav3ADfQL9RSUkeFHsCJ37sraD3dERJvsVQNJRgIgjHXbHvb3
	apwuNgHvhvQSY1W+3SoLATdORxIvKF0AZ4tFpXA3uqW1cMXOVpU0WtjJNX3EGlsQkKz3sDqATvc
	2AKdu07oSLiotx4gwrc0PWKRjKDW+jlrOUVXam3tH/YcqBMJXstSV/RaZSbfLqwkkh3J+S8l29v
	VXqvUUZ4scRqDr6PmCfQVhxYHaDmvpGRZ6g4EG8XUiWR4yO
X-Received: by 2002:a05:6830:82f5:b0:81e:b506:592d with SMTP id 46e09a7af769-84501a03d61mr838988a34.27.1792186650848;
        Fri, 16 Oct 2026 14:37:30 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-844d2ffbf71sm834395a34.4.2026.10.16.14.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 14:37:30 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>,
	Qin ShiCheng <qeesung@live.com>
Subject: [PATCH v2 4/4] object-file: write ".keep" lockfiles during transaction commit
Date: Fri, 16 Oct 2026 16:37:16 -0500
Message-ID: <20261016213716.593278-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261016213716.593278-1-jltobler@gmail.com>
References: <20261016022901.3838402-1-jltobler@gmail.com>
 <20261016213716.593278-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "files" ODB backend writes a ".keep" lockfile into the transaction
quarantine directory via `odb_transaction_files_write_pack()`. When the
ODB transaction is committed, the ".keep" lockfile is migrated to the
primary ODB alongside its packfile. Writing the temporary lockfile in
this manner has a couple of downsides:

  - Migrating quarantined objects via `tmp_objdir_migrate()` doesn't
    immediately stop if a ".keep" lockfile already exists for the same
    packfile in the primary ODB and instead allows all the remaining
    objects to be migrated. So even though `odb_transaction_commit()`
    ultimately returns an error here, the objects are needlessly written
    to the primary ODB anyways.

  - Even more concerning, the ".keep" tempfile atexit(3) handler tries
    to remove any lockfile of the same name regardless of whether it was
    created by the same process. If the ".keep" lockfile of the same
    name for a concurrent process gets deleted prematurely, its packfile
    becomes at risk of being deleted by concurrent housekeeping.

Stop creating/registering the temporary lockfiles when writing the
packfile to the transaction and instead do so when committing the
transaction. This ensures the lockfile is properly acquired prior to
migrating objects and that only the owning process can delete its own
lockfiles.

Reported-by: Qin ShiCheng <qeesung@live.com>
Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c              | 77 +++++++++++++++++++++-----------------
 t/t5547-push-quarantine.sh | 30 +++++++++++++--
 2 files changed, 70 insertions(+), 37 deletions(-)

diff --git a/object-file.c b/object-file.c
index 07a61c610a..b7465adf04 100644
--- a/object-file.c
+++ b/object-file.c
@@ -492,6 +492,7 @@ struct odb_transaction_files {
 	struct transaction_packfile packfile;
 	const char *prefix;
 
+	struct strvec pack_names;
 	struct tempfile **pack_lockfiles;
 	size_t pack_lockfiles_nr;
 	size_t pack_lockfiles_alloc;
@@ -1257,7 +1258,7 @@ int read_loose_object(struct repository *repo,
 }
 
 static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
-			       const char *keep_msg)
+			       const char *keep_msg, struct tempfile **out)
 {
 	struct strbuf lock_path = STRBUF_INIT;
 	struct strbuf contents = STRBUF_INIT;
@@ -1288,6 +1289,7 @@ static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
 		goto out;
 	}
 
+	*out = register_tempfile(lock_path.buf);
 	ret = 0;
 
 out:
@@ -1297,6 +1299,40 @@ static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
 	return ret;
 }
 
+static int write_pack_lockfiles(struct odb_transaction_files *transaction)
+{
+	struct strbuf keep_msg = STRBUF_INIT;
+	char hostname[HOST_NAME_MAX + 1];
+	int ret = 0;
+
+	if (!transaction->pack_names.nr)
+		return 0;
+
+	if (xgethostname(hostname, sizeof(hostname)))
+		xsnprintf(hostname, sizeof(hostname), "localhost");
+	strbuf_addf(&keep_msg, "receive-pack %"PRIuMAX" on %s",
+		    (uintmax_t)getpid(), hostname);
+
+	for (size_t i = 0; i < transaction->pack_names.nr; i++) {
+		struct tempfile *lock;
+
+		ret = write_pack_lockfile(transaction->base.source,
+					  transaction->pack_names.v[i],
+					  keep_msg.buf, &lock);
+		if (ret < 0)
+			break;
+
+		ALLOC_GROW(transaction->pack_lockfiles,
+			   transaction->pack_lockfiles_nr + 1,
+			   transaction->pack_lockfiles_alloc);
+		transaction->pack_lockfiles[transaction->pack_lockfiles_nr++] = lock;
+	}
+
+	strbuf_release(&keep_msg);
+
+	return ret;
+}
+
 static int odb_transaction_files_commit(struct odb_transaction *base)
 {
 	struct odb_transaction_files *transaction =
@@ -1325,6 +1361,9 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
 		delete_tempfile(&temp);
 		strbuf_release(&temp_path);
 
+		if (write_pack_lockfiles(transaction))
+			return error(_("unable to lock packfiles"));
+
 		/*
 		 * Make the object files visible in the primary ODB after their data is
 		 * fully durable.
@@ -1389,9 +1428,7 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
 		container_of(base, struct odb_transaction_files, base);
 	struct repository *repo = base->source->odb->repo;
 	struct child_process child = CHILD_PROCESS_INIT;
-	struct strbuf final_path = STRBUF_INIT;
 	struct strbuf pack_name = STRBUF_INIT;
-	struct strbuf keep_msg = STRBUF_INIT;
 	struct pack_header hdr;
 	const char *hdr_err;
 	int err_fd = opts->err_fd;
@@ -1434,14 +1471,9 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
 			return -1;
 		}
 	} else {
-		char hostname[HOST_NAME_MAX + 1];
-
 		strvec_pushl(&child.args, "index-pack", "--stdin", NULL);
 		push_header_arg(&child.args, &hdr);
 
-		if (xgethostname(hostname, sizeof(hostname)))
-			xsnprintf(hostname, sizeof(hostname), "localhost");
-
 		if (!opts->quiet && err_fd)
 			strvec_push(&child.args, "--show-resolving-progress");
 		if (err_fd)
@@ -1479,41 +1511,16 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
 			goto out;
 		}
 
-		strbuf_addf(&keep_msg, "receive-pack %"PRIuMAX" on %s",
-			    (uintmax_t)getpid(), hostname);
-
-		if (write_pack_lockfile(transaction->quarantine, pack_name.buf,
-					keep_msg.buf)) {
-			strbuf_addstr(err_msg, "lockfile write failed");
-			goto out;
-		}
-
-		ALLOC_GROW(transaction->pack_lockfiles,
-			   transaction->pack_lockfiles_nr + 1,
-			   transaction->pack_lockfiles_alloc);
-
-		/*
-		 * The lockfile filepath is expected to be the final location of
-		 * the ".keep" file after being migrated to the main ODB source.
-		 * This ensures the lockfile can be found and removed later
-		 * after the ODB transaction has been committed.
-		 */
-		strbuf_addf(&final_path, "%s/pack/pack-%s.keep",
-			    base->source->path, pack_name.buf);
-		transaction->pack_lockfiles[transaction->pack_lockfiles_nr++] =
-			register_tempfile(final_path.buf);
+		strvec_push(&transaction->pack_names, pack_name.buf);
 
 		odb_source_prepare(transaction->quarantine,
 				   ODB_PREPARE_FLUSH_CACHES);
-
 	}
 
 	ret = 0;
 
 out:
-	strbuf_release(&final_path);
 	strbuf_release(&pack_name);
-	strbuf_release(&keep_msg);
 
 	return ret;
 }
@@ -1528,6 +1535,7 @@ static int odb_transaction_files_finalize(struct odb_transaction *base)
 		ret |= delete_tempfile(&transaction->pack_lockfiles[i]);
 
 	free(transaction->pack_lockfiles);
+	strvec_clear(&transaction->pack_names);
 
 	return ret;
 }
@@ -1560,6 +1568,7 @@ int odb_transaction_files_begin(struct odb_source *source,
 	transaction->base.write_pack = odb_transaction_files_write_pack;
 	transaction->base.env = odb_transaction_files_env;
 	transaction->flags = flags;
+	strvec_init(&transaction->pack_names);
 
 	transaction->prefix = "bulk-fsync";
 	if (flags & ODB_TRANSACTION_RECEIVE) {
diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
index 1b7097179e..6c14dfc42b 100755
--- a/t/t5547-push-quarantine.sh
+++ b/t/t5547-push-quarantine.sh
@@ -77,10 +77,9 @@ test_expect_success '.keep file is removed after push' '
 	git -C keep.git config set receive.unpackLimit 0 &&
 
 	# While incoming objects are still quarantined, validate that the
-	# ".keep" lockfile is present in the quarantine directory.
+	# ".keep" lockfile is not present in the quarantine directory.
 	test_hook -C keep.git pre-receive <<-\EOF &&
-	keep="$(ls "$GIT_QUARANTINE_PATH"/pack/pack-*.keep)" &&
-	test -f "$keep"
+	test ! -e "$GIT_QUARANTINE_PATH"/pack/pack-*.keep
 	EOF
 
 	# After quarantined objects are migrated, validate that the ".keep"
@@ -101,4 +100,29 @@ test_expect_success '.keep file is removed after push' '
 	test_path_is_missing "$keep"
 '
 
+test_expect_success '.keep file created outside of process is not removed' '
+	test_when_finished rm -rf keep.git &&
+	git init --bare keep.git &&
+
+	git -C keep.git config set receive.unpackLimit 0 &&
+
+	# Create a ".keep" lockfile matching the packfile to simulate a
+	# concurrent git-receive-pack(1) that has already written its lockfile.
+	test_hook -C keep.git pre-receive <<-\EOF &&
+	pack="$(ls "$GIT_QUARANTINE_PATH"/pack/pack-*.pack)" &&
+	pack="${pack##*/}" &&
+	echo "baz" >"objects/pack/${pack%.pack}.keep"
+	EOF
+
+	test_commit bar &&
+	test_must_fail git push keep.git HEAD &&
+
+	# The ".keep" lockfile of the concurrent git-receive-pack(1) should be
+	# left in its place.
+	keep="$(ls keep.git/objects/pack/pack-*.keep)" &&
+	test_path_is_file "$keep" &&
+	test_grep "baz" "$keep" &&
+	test_path_is_missing "${keep%.keep}.pack"
+'
+
 test_done
-- 
2.56.0.173.gf57c9a7388

