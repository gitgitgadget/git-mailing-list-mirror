Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502953;
	b=pBs4k0Qp8fQBKnIjDmhJB0KhSlxSv9+T8O/1jFmLILa0OODJdGeP1eZKoEawiMi8rzYZ
	 luFbaXMsT7PmsDqiwdEAXtXddtnATqv5iuG6pU22ILzDuYleJAejs+m2PCHb8EXvkzYz+
	 T8xucj52zcWDTDVTAJznyZc/g6elXlE0gtmVWIZpyTe2BrJEDA9Fh/BHDCcsVbL01rdse
	 HVDsb6TFqA691WboWwsJnzlHO9kS1QZDO76zinVHPZP/4XZrCLcCjSRaVsPCY/AkX34wv
	 aFCGzW/Oh1AHpEz+DYx3Ox4Py3iwHeOqYl0arPyw8CSHlyEFEsh40+E/q6QXtZ+Sxrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pECF16QejQ6Mt3aafyrwrs82aOiePvUpd+gNI7qGIZM=;
	b=4rYo0q7ezYr+kBtEStLGYJJKU35gKsfW9Yp/HK6wNzp/8o5WwRvOaqEBqwQJEZs9daR5
	 qM7iIcEsifwnwNI48PNLnDLAsGiJzefQ6lXn1tlUjgb+/pUiB+i4M+moWJw9n2N9cGp34
	 PMjtviZjCwFPT6IDCdMvo9V+clxQ/87dm2vEdh10R/m1UQiFouOGUok74EeyeX0eXPalV
	 pr/lpyVCYmIh9R8DrFbkbHM0mgu9siXI8/QGLqUhRuET27DczRLnoMrna7DK+GhvoynqD
	 OmKIcp2EqfaUs0zOf96suvUfXNPqrvso6ZQSzV7yvjx2eCJgo9Dqy2imYavku/eJ/dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WjRD+rwA;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8816D606A31E
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 13:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8816D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WjRD+rwA
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6aa9606ddadso2359089eaf.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 06:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792502952; x=1793107752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pECF16QejQ6Mt3aafyrwrs82aOiePvUpd+gNI7qGIZM=;
        b=WjRD+rwAvkJhFFAMfG2mfv/Ve4p7kqh5/5v1Uh2KlxUTbPioDK7llaTqcww63T3iDu
         AB42ChWQPwcCk60nqToXKGFZbJe+YyI1JrEQMEU//EjVQlMzIe+cHDAfN5t6b0sUdT3h
         FN5iVQ63LxCJi8Sx/dc05SiGP4r2Mo/wM5PQqgjEDkMgjO46jcDGNZU58jmUkB20UlPv
         3YaSTnD7DKxOzsyk750M/rQQTqE/DYkQbHgxBg60EE1HLGnUy/JD9mrkkgY6sBu2gXqn
         etHwnhVW769ElYxzG2KXRRHrA2OhHSWrkDtfbSmB+Gh/LKcg7YxwrAd5bZQUgvXAZcB2
         Kj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502952; x=1793107752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pECF16QejQ6Mt3aafyrwrs82aOiePvUpd+gNI7qGIZM=;
        b=NUKZXmpDTWzaWxL28TQjyc3UG5g2Tcsu/Mv2MpH2n45L0nEZYznzLto0Igjipv8iIR
         IJOyB/hVTsPlFvvRQR83oN+NRW6btc24kU1KJrlXod+IwxAQqqsvo1CcWA/G4FyVD+7q
         mrTvTPvjrRjONIgmXOdCy1wXHiyb0//wUKNAtGdVmPzfsyYDGNavcZPFJXAn+/KBv0W2
         Qi5CtVYUmNIIlOc5xjIDdIisvL1ON6Pqrh7YBkDHICuDIH+P/sCq4N7Qayhsh2Hk74TZ
         l1puYteQ+OOYYSu3cZ4M4QhPoDFuLdcDpThd1W3PZtjDiXYG1TIzlqD1UiKJx4db3M2S
         AvuQ==
X-Gm-Message-State: AFq9FYIBJpCYZ2/M5Av/qkeBHtpmiOxGWkU3Zmt4e5hFa3hn336klVH4
	X4yqMQM9GCCeB1lzwVaFnHu+4Ki+3ZmQ9bUiL2Qjc+trU9D/2C2YAKY8Ip5sfQ==
X-Gm-Gg: AYBFou3z4B/QEcY8RSq+7m/2H421AGohyv4FgfQRfpSSoS0bTTjEAfk54r8n5UCmyQZ
	OXOKik26z7LqO+ve1G1eLhiTL9f/yWvsfCAKOagXcqWZv9VN3egArL64xzql097zt6KvVEufFWl
	Ioiyxm3KzIUFxkaNo+AyywdD1U+jiKAYuuufB7tDtRLImaFWx6NvAjRfCi7gQa79w3/QJxrIXDn
	UenRyk6knB+9HOwv5zYeZE2uVivZDoHHyBMOFSkcRdcxzt0lco1GBWeIEzbRLk9K/c/OslBa4GS
	/fgfx8s6DwEevYg0Xt+3XLMo+CNsMuagNlVRsxuBhQUYnQCCFRfZs4zCgfdlu9C7Ywv8XlrfWJZ
	OHb8G0EnYRVPMFrCjJzdT/trO1VWqG7QKJj1QZKiHpopU8cGpHbd+JYn86jtyjre2rdoPQ/Lnu1
	yin2itw8v1aSCAP+tNwduZurVadw+EIx4QfjD70YZ5NMuuxYOtgwx3KOERRxb31ogganMOB00oq
	RAT/C1d2IftY5UBZuouoeKYwEiEPb/6DP029Q==
X-Received: by 2002:a05:6820:1526:b0:6f7:6416:a2d with SMTP id 006d021491bc7-7035649c032mr7342521eaf.41.1792502952376;
        Tue, 20 Oct 2026 06:29:12 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7018f2e0d89sm9973129eaf.6.2026.10.20.06.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:29:11 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>,
	Qin ShiCheng <qeesung@live.com>
Subject: [PATCH v3 4/4] object-file: write ".keep" lockfiles during transaction commit
Date: Tue, 20 Oct 2026 08:29:00 -0500
Message-ID: <20261020132900.1208343-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261020132900.1208343-1-jltobler@gmail.com>
References: <20261016213716.593278-1-jltobler@gmail.com>
 <20261020132900.1208343-1-jltobler@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
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
 object-file.c              | 77 ++++++++++++++++++++++----------------
 t/t5547-push-quarantine.sh | 30 +++++++++++++--
 2 files changed, 71 insertions(+), 36 deletions(-)

diff --git a/object-file.c b/object-file.c
index ad55c01198..383aac8e3f 100644
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
@@ -1288,6 +1289,8 @@ static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
 		goto out;
 	}
 
+	*out = register_tempfile(lock_path.buf);
+
 out:
 	strbuf_release(&lock_path);
 	strbuf_release(&contents);
@@ -1295,6 +1298,40 @@ static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
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
@@ -1323,6 +1360,9 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
 		delete_tempfile(&temp);
 		strbuf_release(&temp_path);
 
+		if (write_pack_lockfiles(transaction))
+			return error(_("unable to lock packfiles"));
+
 		/*
 		 * Make the object files visible in the primary ODB after their data is
 		 * fully durable.
@@ -1387,9 +1427,7 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
 		container_of(base, struct odb_transaction_files, base);
 	struct repository *repo = base->source->odb->repo;
 	struct child_process child = CHILD_PROCESS_INIT;
-	struct strbuf final_path = STRBUF_INIT;
 	struct strbuf pack_name = STRBUF_INIT;
-	struct strbuf keep_msg = STRBUF_INIT;
 	struct pack_header hdr;
 	const char *hdr_err;
 	int err_fd = opts->err_fd;
@@ -1432,14 +1470,9 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
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
@@ -1477,29 +1510,7 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
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
@@ -1508,9 +1519,7 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
 	ret = 0;
 
 out:
-	strbuf_release(&final_path);
 	strbuf_release(&pack_name);
-	strbuf_release(&keep_msg);
 
 	return ret;
 }
@@ -1525,6 +1534,7 @@ static int odb_transaction_files_finalize(struct odb_transaction *base)
 		ret |= delete_tempfile(&transaction->pack_lockfiles[i]);
 
 	free(transaction->pack_lockfiles);
+	strvec_clear(&transaction->pack_names);
 
 	return ret;
 }
@@ -1557,6 +1567,7 @@ int odb_transaction_files_begin(struct odb_source *source,
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

