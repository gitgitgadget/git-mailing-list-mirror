Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792607139;
	b=G0DVwlYI3wX/++2GFp1FjdL+bwxrRJtj/GCaalHHRN+QTHM8g0BHYOmeitAL2xJRb/VQ
	 vWEwE+EmbFBV1EMMaoBwLXdrz6TePnp7D69KEWRavsaR+RoatKfuY7Cha2Cludvk871VB
	 whHAR3olyA+JZEHssDlC0Proq5ueDih3cAn7nl7QZ0rYPJH1W/cyfhbyIeyi19aMVDYrW
	 /ZTguCpJ0huuTdH/WRiUd1vnEElj7pckeo0fZpgqqTuJPXtNNNBUrfHK2ORmkypdItsPI
	 QTqTlnKX/NBaOd0OKxyIoSL9IZdgDL8xAfT98IPG/N94umnyhIanib1rccOILoGlOHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792607139;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1f3YWSP/YIxhpIsYQ/3Sslfb6o25fznKXT9kKHN8EUc=;
	b=BJvEkvPjxFP4JRk7WMjose48dtA8/xuaVZbFHNR35tROTE0JCPYfyq+6kA926hrYZFSM
	 IqF+EjWVqA5DXALV3qs+8KNBxxQFp0udnoOraJKfWnHqroZgp4lJ85ClIj5k+N71kD/rU
	 5m5VJywHnwPBGWthu9pt1ubf3bRUrmm6sfla/cvzUgKLr7iIvRVsKQcCRhQiw6KoUPQWa
	 kgCm7YB5UKWAkxmYcqVrgnqOaz9PaVbrZ0Y3TcTEIBA85Si4ck54Ap6O/UdcwfXIWBhca
	 Fp8mWxZ9hp8dD5i4DN6U7efU5puCGBw5RRJ0n2uajIy+3yz60YtpyzAnsi/817Nh/Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OdomwyzB;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF2606A31E
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 18:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FAF2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OdomwyzB
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-8256106635eso556978a34.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 11:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792607138; x=1793211938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1f3YWSP/YIxhpIsYQ/3Sslfb6o25fznKXT9kKHN8EUc=;
        b=OdomwyzB/4g+CqmOSVFRXbaOQfXznif7rpERkgXBucqZlMGObXt5WyscCvressxiUc
         L10+YrMd1pGigmTYMepjq0jODOfbJ8jqD5BIguDQ3rEE+85scQFX5dm616mG9lk/EPsI
         Fcx0e4xFYXeIQB9FlfjJBoPMrtZX7KgdDxq0Lslp2XVe7GnEmva8iZwVDv/WJaG9j+ZX
         EAs7CNulEEVI+RAsk/Iv+X5Wukr0AzNynw3TcKF8Q57XvuD188UwU61ZL5U/I+H+BQtx
         07SQutCoeI7HmgzOucYHov4iVY1gMzGJWC0rIBvneb7RyvouyE9HOV9CwspWqbuyrxKe
         fBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792607138; x=1793211938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1f3YWSP/YIxhpIsYQ/3Sslfb6o25fznKXT9kKHN8EUc=;
        b=iUlBL/y2NAo/1CgI+RnK1bAaHCM8DaSxwy5Zkes7/2Zyspc035e3R3kCZawzOSZhf4
         S16i9/OE2uq7MsbtSTA/goUFp3BLuw/xYnpCk9XqdYrtelRQSpZinAhQp+qhWUl7rtBc
         demV4Uhp2msyaxjwAZRLk19e7bLhT+D7EvQE5aFDQvEjYv9TczGj+72RvwXD/8E2NN0m
         l4ssabpK6778bFe2K6XZYK1xMGIYtN2xjU1+6c53SKotUpQdhpPEBq+mnsmC304SQh/P
         Txr1FuYcKcaEn4eWNCe76oFqYdxYtUrGPmeYbICyTbjOK5HJHXOO7ukxM+txAlCXOSN1
         rOEQ==
X-Gm-Message-State: AFq9FYJ6lImHZA4vuyuPJgr5Zz1yCLfnCVDJCDO5UQFNcZQI212Z1mLW
	R5c+z8reuvp3cvl7Gp4gyi2/nLa3bbrWwBdDejQa8OxPVD4tFOndEeX+1JJ44A==
X-Gm-Gg: AYBFou1UAdi/mV8rkILQtZXPQTVKMJxYClajF6ZzX04YfEhdCTdqCX3+UHjR4+sMdHo
	rCKum40h/8TrbYGq5rqSDF3raQmYngpec970697aJhwG/ULgOzG3DB/ucFyssgoP8/gjWkb3zlz
	UYkUNNdPDJ7lfRLGkSLPkah2/uV1+ENnhKrvA4nNmkHVN2XfoVkyfNV6rJKCRd5r10s7rQznP5d
	Pu6Mj4ldjTGGnYrSkPfKmNjbK10HO/uG0S+4oVM6hTjr8wxKmccdm9fxAsiZA0NGVFdY0tplxiB
	0IZw/kNZzb6J+S44aifJ0lfgk8fFkwsadqj7vOBJFTd+kUOQr2E/1tTA4maB0XM27A2BK1GMx7p
	o4HURc/N/A/vPLJE0Dlscyjbw7pm1SqtrlngU0mQONUwPgxYuDSRjDHo6diESTqa7QGEkT2Niv0
	JGkyP+ZFDBghw5BWZktGG5T2zihIouu+HYz/EpCbVmj8Mq4gB6jHACY0ATXYNOzQtbl7nniz6Ym
	LoowUxBYPiL6yv41Hs6Py4uMW5+3yx74U2ZdWVKLe1XVQTQS0bAtHGo5GfL7Z9DDtAjei5F+X9n
	5bPlKO1FpHcjBK8PqpY=
X-Received: by 2002:a05:6830:6ae8:b0:7e9:5022:3639 with SMTP id 46e09a7af769-84d07e0fe54mr2503697a34.15.1792607138157;
        Wed, 21 Oct 2026 11:25:38 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbcdd9d3csm2831887a34.9.2026.10.21.11.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 11:25:37 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>,
	Qin ShiCheng <qeesung@live.com>
Subject: [PATCH v4 4/4] object-file: write ".keep" lockfiles during transaction commit
Date: Wed, 21 Oct 2026 13:25:28 -0500
Message-ID: <20261021182528.3055494-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261021182528.3055494-1-jltobler@gmail.com>
References: <20261020132900.1208343-1-jltobler@gmail.com>
 <20261021182528.3055494-1-jltobler@gmail.com>
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
 object-file.c              | 76 +++++++++++++++++++++-----------------
 t/t5547-push-quarantine.sh | 30 +++++++++++++--
 2 files changed, 70 insertions(+), 36 deletions(-)

diff --git a/object-file.c b/object-file.c
index 74a31760bc..e67c0865a2 100644
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
@@ -1479,29 +1511,7 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
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
@@ -1510,9 +1520,7 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
 	ret = 0;
 
 out:
-	strbuf_release(&final_path);
 	strbuf_release(&pack_name);
-	strbuf_release(&keep_msg);
 
 	return ret;
 }
@@ -1527,6 +1535,7 @@ static int odb_transaction_files_finalize(struct odb_transaction *base)
 		ret |= delete_tempfile(&transaction->pack_lockfiles[i]);
 
 	free(transaction->pack_lockfiles);
+	strvec_clear(&transaction->pack_names);
 
 	return ret;
 }
@@ -1559,6 +1568,7 @@ int odb_transaction_files_begin(struct odb_source *source,
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

