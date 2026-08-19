Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EA03A5430
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 21:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787176398; cv=none; b=uX15NQ4fszYeA8TPnSPc1nBLrpYRctHsg+fORA4v2K2Yt7bPW9jrwbeIzWT/LpHH+X3sIuBMz0xR8TV701uEXKIJd4gHXg2PYUO7zF86XL1XNdii+KETsv8PwgdCO9u4lTxtMm7GT+Fx/VcqUq2tnQEcDNgykGMMfiY8OtEliCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787176398; c=relaxed/simple;
	bh=9r2uy5+qCVXUQElWKXvKTRNKQRQ9xxz/FXYhayHjLJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNWyKJVWDBhdjaR9BaEU2vV8WEJLaQ67HLz/oq8q4tQbQNasfLXlYwFBfy6bv1Zn7h7afKgRuuXHIeXYJvQp8qqSsAf5Cs9vNpsUIRZl/I9juvMuQpAfkkPstt5LSbe7/Tx39JSOOam1kBCCO2sjZqPfUsrlVtFotD53eAZ/Ax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFkMxd14; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFkMxd14"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6b145a9623fso353746eaf.3
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 14:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787176395; x=1787781195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o7v+Qmes+kOtAwwkIpbgRnUcoREc9cNQ2yK6AeQgyLk=;
        b=BFkMxd14xuzji95oew0g8U9J9gbSU/JrEIimx5II+tN+nnbVY+UjncLSdLxQMJgU72
         7/y2vJx13leoT5f6RmW1/c8KxRQz0aP8jhSaubjScdTNBaLrNf4sPcXGyDiK4WP7LdQ1
         W7RdPnRPKz7a+AzljIjDabONcBIW9VVyOYvkISRO76x8EhW4piLx0jJfwiVBIyEoaI0E
         lH6A7StU26fqONEsm7hZ5y9pPypNtEtVufYmApXLQRVMMwJxKwbLm7s6yMp8g5j4tvmu
         DFdI9MdLj7617OkB5czlwtToqLcQGTn6rMDsS9uVxkkSBNTiJRiyBK5dwLbiPGOzmHAq
         m3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787176395; x=1787781195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o7v+Qmes+kOtAwwkIpbgRnUcoREc9cNQ2yK6AeQgyLk=;
        b=pw9g5QTTWsniIgQoolUz+ZwfiGrmVluIk9FBPibaBQCU26rgB/emsBTavXytdUCmCF
         Ui5qkXtgE9CHaN+eOa5ZYa21bfhwDEpjXEv6ZoTjoPdUv6kzUyOEh3RfmIz/XlJ6qqOl
         PJOFemIPFBdAZw20mwl6BAiluxU//WBPNOscxMA3hdB3aYl3ZQQBLi5OqMwdRL3amb/G
         g+2oKDj5Eg7eSpA2hskESXOxQ7wCQ8/NtjgyAdZzDe9QGddk7105n9zgnz0Sf1RAHQU8
         2g//qiBzdB+o8swtmy955VHY6bIfIRXCmS5WTZ3Bf+brLfA1pKRAf70kTjMWfzV6cfug
         6GUw==
X-Gm-Message-State: AOJu0YzTGA4SO/nWwu0NlyjUaweNlW3GjQ5e7wF2K7EEfDTiTs5i4RPW
	zgwik/kb8II35xVfU/4W8lkVs/eZ7ly40zmLkDcaQ6/PpblZ8qgVKmYW7kDlxA==
X-Gm-Gg: AR+sD10lIKua04fJy5n5/EqH1SqTwDQ6oQj1AyocbGZdqtWbbbhcYOZc5vbygRsOTzz
	CPu2sW/UAaCKcSA564is/KgST16D7XApMZoTomkLyApPzO+M3aVTqU/hoMM7G5eQYAn1+gBrmxO
	SfczAz0StlR97p5EDFV7IOehxDpC4hIKmqFn6/q9Cw3X+NGP7muQidiOrTtwBDDsYgOpMxiUAii
	8iHjj3Xzny4Ux2z+5LIAdm4o0BFl5k+LF+Avq+KiRpiYfrgdrEVuB6Fg4hpvWcMeqK0JDNkFjEV
	V0tgKoyFCrC/v3N1l78qixdOTFAf+DKWZzG8FtMo6UCKaV9sWL5WUTVfgnG6+gjrx/vSpK8+lwb
	ZnE/qkwbgrMns2f5W5o6WpLL64zG/+TbckOwuC9/pIhJf0EJqOU2urCCQ1ogzgyLxqcN/r1fGv+
	DzBAkYv262P6sRzKJaGleJ68lppwZf1zbxTkxBEUPofiJqqA8D33wD0ygwUyM0GyCLyAFg
X-Received: by 2002:a05:6820:6ae3:b0:6b1:4280:9e18 with SMTP id 006d021491bc7-6b14280b3c3mr5104376eaf.13.1787176394908;
        Wed, 19 Aug 2026 14:53:14 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f43fe7029dsm2718026a34.2.2026.08.19.14.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 14:53:14 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 1/9] builtin/receive-pack: properly clean up keep files
Date: Wed, 19 Aug 2026 16:53:03 -0500
Message-ID: <20260819215311.3880274-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260819215311.3880274-1-jltobler@gmail.com>
References: <20260811175415.2044235-1-jltobler@gmail.com>
 <20260819215311.3880274-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When git-receive-pack(1) stores an incoming packfile with
git-index-pack(1), a ".keep" file is written alongside it in the
transaction quarantine directory and also gets migrated to the main ODB
when the ODB transaction is committed. This keep lockfile ensures the
packfile remains in place until the references have been updated and is
removed afterwards. The path used to remove it is derived via
`index_pack_lockfile()` from the repository's primary object directory.

In bdee7b3013 (builtin/receive-pack: stage incoming objects via ODB
transactions, 2026-07-10), git-receive-pack(1) started using the ODB
transaction interfaces instead of managing a temporary directory
directly. When starting an ODB transaction, the sources list is
reordered to insert the newly created transaction source first as the
primary to ensure writes are routed to it accordingly.

Prior to using ODB transactions, git-receive-pack(1) would only set the
temporary directory as the primary source for the child
git-index-pack(1) and git-unpack-objects(1) processes it spawned and the
parent process would set the temporary directory set as an alternate
only. By using ODB transactions, the ODB source list is also reordered
for the parent process which results in `index_pack_lockfile()` deriving
the ".keep" path relative to the temporary directory instead of the
actual main ODB source path. Consequently, this prevents the ".keep"
file from being properly removed after being migrated into the main ODB
source post-commit.

Update `index_pack_lockfile()` to operate on an ODB source explicitly
provided to it and update call sites accordingly to pass the expected
ODB source.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/receive-pack.c     |  8 +++++++-
 fetch-pack.c               |  2 +-
 pack-write.c               |  7 ++++---
 pack.h                     |  4 +++-
 t/t5547-push-quarantine.sh | 22 ++++++++++++++++++++++
 5 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 86933d8d7e..d74b787148 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2412,7 +2412,13 @@ static const char *unpack(int err_fd, struct shallow_info *si,
 		if (status)
 			return "index-pack fork failed";
 
-		lockfile = index_pack_lockfile(the_repository, child.out, NULL);
+		/*
+		 * The lockfile filepath is expected to be the final location of
+		 * the ".keep" file after being migrated to the main ODB source.
+		 * This ensures the lockfile can be found and removed later
+		 * after the ODB transaction has been committed.
+		 */
+		lockfile = index_pack_lockfile(transaction->source, child.out, NULL);
 		if (lockfile) {
 			pack_lockfile = register_tempfile(lockfile);
 			free(lockfile);
diff --git a/fetch-pack.c b/fetch-pack.c
index 922a9b2581..6df5813b33 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1075,7 +1075,7 @@ static int get_pack(struct fetch_pack_args *args,
 		die(_("fetch-pack: unable to fork off %s"), cmd_name);
 	if (do_keep && (pack_lockfiles || fsck_objects)) {
 		int is_well_formed;
-		char *pack_lockfile = index_pack_lockfile(the_repository,
+		char *pack_lockfile = index_pack_lockfile(the_repository->objects->sources,
 							  cmd.out,
 							  &is_well_formed);
 
diff --git a/pack-write.c b/pack-write.c
index 24033a9101..85674e4b72 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -469,10 +469,11 @@ void fixup_pack_header_footer(const struct git_hash_algo *hash_algo,
 	fsync_component_or_die(FSYNC_COMPONENT_PACK, pack_fd, pack_name);
 }
 
-char *index_pack_lockfile(struct repository *r, int ip_out, int *is_well_formed)
+char *index_pack_lockfile(struct odb_source *source, int ip_out,
+			  int *is_well_formed)
 {
 	char packname[GIT_MAX_HEXSZ + 6];
-	const int len = r->hash_algo->hexsz + 6;
+	const int len = source->odb->repo->hash_algo->hexsz + 6;
 
 	/*
 	 * The first thing we expect from index-pack's output
@@ -489,7 +490,7 @@ char *index_pack_lockfile(struct repository *r, int ip_out, int *is_well_formed)
 		packname[len-1] = 0;
 		if (skip_prefix(packname, "keep\t", &name))
 			return xstrfmt("%s/pack/pack-%s.keep",
-				       repo_get_object_directory(r), name);
+				       source->path, name);
 		return NULL;
 	}
 	if (is_well_formed)
diff --git a/pack.h b/pack.h
index 1cde92082b..ada506b5c5 100644
--- a/pack.h
+++ b/pack.h
@@ -7,6 +7,7 @@
 struct packed_git;
 struct pack_window;
 struct repository;
+struct odb_source;
 
 /*
  * Packed object header
@@ -105,7 +106,8 @@ off_t write_pack_header(struct hashfile *f, uint32_t);
 void fixup_pack_header_footer(const struct git_hash_algo *, int,
 			      unsigned char *, const char *, uint32_t,
 			      unsigned char *, off_t);
-char *index_pack_lockfile(struct repository *r, int fd, int *is_well_formed);
+char *index_pack_lockfile(struct odb_source *source, int fd,
+			  int *is_well_formed);
 
 struct ref;
 
diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
index 0798ddab02..3da253cc1a 100755
--- a/t/t5547-push-quarantine.sh
+++ b/t/t5547-push-quarantine.sh
@@ -70,4 +70,26 @@ test_expect_success 'updating a ref from quarantine is forbidden' '
 	git -C update.git fsck
 '
 
+test_expect_success '.keep file is removed after push' '
+	test_when_finished rm -rf keep.git &&
+	git init --bare keep.git &&
+
+	git -C keep.git config set receive.unpackLimit 0 &&
+
+	# While incoming objects are still quarantined, validate that the keep
+	# lockfile does indeed exist.
+	test_hook -C keep.git pre-receive <<-\EOF &&
+	keep="$(ls "$GIT_QUARANTINE_PATH"/pack/pack-*.keep)" &&
+	test -f "$keep"
+	EOF
+
+	test_commit foo &&
+	git push keep.git HEAD &&
+	pack="$(ls keep.git/objects/pack/pack-*.pack)" &&
+	keep="${pack%.pack}.keep" &&
+
+	test_path_is_file "$pack" &&
+	test_path_is_missing "$keep"
+'
+
 test_done
-- 
2.55.0.424.g13c7afec21

