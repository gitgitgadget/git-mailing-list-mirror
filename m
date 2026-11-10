Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270181;
	b=tg3UBBO3hXewYdi67DQ2Wqx9ec8gyzzS62zdjYxpKejzsaJiXu9BD+yfKSUqOky5AQpH
	 BEYbc7HsbXKjZNprwgUdwVwuE3MPSvedyefcq+DrQaeR1mgW/jv3Woe4YWC3tpiDWiIV5
	 mIHCjKjc6J26Sm0fX2i2Mmuq9TFkwf+Ao9DieawxM2BCkbmc7O6ds2lmGf3LkzT26f1bI
	 DVJcBfEb8oiJwJ7QYKD6z2oF4vfR0jQGwlT2O5TcG/G0abr5dlrINYYKqHASqEiSV3k1q
	 grwrYebM6r8s2UOIHyt2ZT7LcMHP+qw1vFeJt6+M23KdEyYKMxL0j1HrJ2QHgLwkCrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=OezcFG63M82lSJr6bQ3jUWJr55KbbsDg9YtQgQ52Pb8=;
	b=YgDwYPuUEjaMeSYoiclp7keYrkxmaqb9c0C9C1Xzg6bkdS76rTnAK+IcMjJbQye3+yDT
	 1xUg0vi31ugnWp9DVYM4rwRnI8QOmiCJpHW6Nt9rrUhFvifmMscbpSXbkSHPLtF9xaear
	 H2H0HRoW07aGzPuhTQZzwmb/URc3NPpoOZxuzzYcUOyQlOxonpKfNDP9eya6x5+SNj1gb
	 9SbavSuWRNt9OypfwtmIEJb3ZTbKBugAXameeN5Uf8Q9PitJ7Dz8tejFPAMSGJ7kj7FYx
	 uXG/Lacof4C6wIICPAbx2NrV+BOAXzHAw/ZU3wQZT+g2qRy7mN8mF27Gdmp8zZn3L6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rssz7sFU;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E5760A261D
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 00:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9E5760A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rssz7sFU
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6f5a0893610so898880eaf.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 16:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270180; x=1794874980; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OezcFG63M82lSJr6bQ3jUWJr55KbbsDg9YtQgQ52Pb8=;
        b=Rssz7sFUwIq6LF9bO19hSMhqyHETUccw7iKDYyW9NUXDWqX2iz8bp/B0WhW1pXbJO/
         PibzB4KOEdQ9aW36jI0Ch5PInao6Ndpc4K+xlc2fNi0HGg6Zbgk74pou2P5cMBlSw/x9
         SoFLIfcXjEUy3wJMrGhtiKyrmKEJ0qvK0CmVb69TGBZs1/uOPo0sSIE8lHWgTbBbS1qK
         Ckk0LeCYI/Z6HXzMVZG+Bxk8j1EcfRryRtfyyDCn9eBmWqG/QVE2gnDRy+vY0TPMyrPJ
         OxzWyySIQJkma64vlZIU182qUvTMAD7YKLkQOROYzA6mxWKZywMz0DKv+GTGVqq1Ca0v
         zgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270180; x=1794874980;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OezcFG63M82lSJr6bQ3jUWJr55KbbsDg9YtQgQ52Pb8=;
        b=0mCyDXnmvlrcOdLpbYmzb0zNJ0td4H1NJaH5S3iy0Rp3UFJF8CwOGz+gF5MMmdZhSL
         RNQGgThCBCHY10rjUndmisHaNGwpS9H2DZAJaArmOz1Kn6tjhPfxBhY1bKp2u1jkLxia
         DZf80m2cDZGIYo6DZ2WWcg32ZybrTDoQEntF6EP3HhYCJl/A/Ve4RKaX9tr+823hk8Bh
         9KzRnQpL8YMOlWiill56oj3gSUUFNJpEtEN9Cm5kaF+IJ+GhtIsFv+dchy7I058W79AV
         NCJtZh7x4oBQkPdQgux11lSEmNiVfFZ/fOzq+rmX6H/C41qoDyDT2s9TlI0AzoIoX/Nz
         oHeA==
X-Gm-Message-State: APuU4Z/tdA2xUCiERcd48deN+I7SILtmxzDc/yEQArXlqPcJHhLZ5hcs
	Eve8uiVDdGJs5rEUPbJzxpYpHzo7gxKNUQZZlVkK4qM4OrUUAPtlcSAZEDvwkA==
X-Gm-Gg: AYBFou2wso4uX2Cag7mz7sysTF9d3B3TfbWoG/PN4QFgaep6PdL60tjysw8b1HfHCiO
	IEEm0fSSQ4MwAPmK0h+zLoa2SGW4Qv+8hKr4WJS0oZiEvWLWjSmF4uDofGILoAoOSTe/X4lfmtj
	IuEdayKI4Z6o2WluRJyVox5dOOXugl66h2YVBzOXyXZRSLSdRC8rmkUCfGPTbFVpzLl6dO62Wa0
	AEcaXqmvoKnUy9nBMypYRIPfKY5BMQSbZy82WAUXBlVkZ3tAqsVq6uXfUMNaQ+MsZ/ZpJ4snVvR
	sAo45LIAOZ+Z4h/8moX3/03vV3htOGrLu3EkRLD2i4tQG0keERditUuiPEMkSi70GBtQCIFRRq2
	z1Kniks66u5fEDJvT8xl4upTNaeYKX0LQCCaGlCbqDJZGsLCPwgFNpIt9U3ARnHhR5rzXklC6ev
	ZBV0weVumn2ei1sp2TRDmH4Xbxu+bQ33AWcoQUbhW7dMT7JjcbNSrfkp2i92bDClwmim/axTOQ6
	TcUDBwqRH/M0lKe5xeiju1hzet8gVzyZpMHocPDcVPtk5SNtsNl/rZ7PE3Eay813NAj711Yhnaz
	R8qCxx0ZQ0VBGI+1yUEmHniQMt1SolH4jvBoZMRdiYRrMmaY2pP4UkRzSq8Cs4qBhtH4
X-Received: by 2002:a05:6820:a649:10b0:716:d3dd:c505 with SMTP id 006d021491bc7-718a18826f0mr322965eaf.9.1794270179662;
        Mon, 09 Nov 2026 16:22:59 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcbc82b5sm680518a34.17.2026.11.09.16.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:22:59 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 4/4] object-file: create ODB transaction temporary directory eagerly
Date: Mon,  9 Nov 2026 18:22:51 -0600
Message-ID: <20261110002251.2007617-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261110002251.2007617-1-jltobler@gmail.com>
References: <20261110002251.2007617-1-jltobler@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

By default, ODB transactions for the "files" backend create their
temporary object directory lazily once the first loose object is about
to be written, and only if batched fsync is enabled. Transactions
configured for git-receive-pack(1) are the exception as the directory is
needed to quarantine incoming objects up front. Lazily creating the
temporary directory in this manner is awkward for a couple of reasons:

  - Writing loose objects has to know about the transaction internals to
    trigger the lazy creation of the temporary object directory.

  - Whether objects are staged in a temporary object directory, and thus
    whether they become visible at once on commit, depends on the
    configured fsync method.

Create the temporary object directory eagerly for every transaction when
it is started instead. This also ensures that no object is written to
the main object database before the transaction is committed.

Note that committing a transaction migrates every written object into
the primary object directory even when batched fsync is disabled. This
adds some minor overhead to ODB transaction callers that previously only
used a temporary directory if batched fsync was enabled. The following
benchmark uses the default fsync configuration and adds 10000 files of 4
KiB each to a freshly initialized repository via git-add(1):

  Benchmark 1: git add . (rev = HEAD~)
    Time (mean ± σ):     895.0 ms ±  23.8 ms    [User: 545.3 ms, System: 340.7 ms]
    Range (min … max):   866.7 ms … 928.7 ms    20 runs

  Benchmark 2: git add . (rev = HEAD)
    Time (mean ± σ):     956.3 ms ±  26.1 ms    [User: 541.4 ms, System: 405.2 ms]
    Range (min … max):   923.9 ms … 993.6 ms    20 runs

  Summary
    git add . (rev = HEAD~) ran
      1.07 ± 0.04 times faster than git add . (rev = HEAD)

Typically large numbers of loose objects are not expected to be written
into an ODB transaction so the overhead here should be marginal.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c         | 56 +++++++++----------------------------------
 object-file.h         |  1 -
 odb/source-loose.c    |  6 -----
 t/t0004-unwritable.sh | 19 +++++++--------
 4 files changed, 19 insertions(+), 63 deletions(-)

diff --git a/object-file.c b/object-file.c
index da189111bd..a9fb42705c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -489,7 +489,6 @@ struct odb_transaction_files {
 
 	struct tmp_objdir *objdir;
 	struct transaction_packfile packfile;
-	const char *prefix;
 
 	struct strvec pack_names;
 	struct tempfile **pack_lockfiles;
@@ -497,27 +496,6 @@ struct odb_transaction_files {
 	size_t pack_lockfiles_alloc;
 };
 
-int odb_transaction_files_prepare(struct odb_transaction *base)
-{
-	struct odb_transaction_files *transaction =
-		container_of_or_null(base, struct odb_transaction_files, base);
-
-	/*
-	 * We lazily create the temporary object directory
-	 * the first time an object might be added, since
-	 * callers may not know whether any objects will be
-	 * added at the time they call odb_transaction_files_begin.
-	 */
-	if (!transaction || transaction->objdir)
-		return 0;
-
-	transaction->objdir = tmp_objdir_create(base->source->odb->repo, transaction->prefix, 0);
-	if (!transaction->objdir)
-		return error(_("unable to create temporary object directory"));
-
-	return 0;
-}
-
 void odb_transaction_files_fsync(struct odb_transaction *base,
 				 int fd, const char *filename)
 {
@@ -1548,13 +1526,10 @@ static int odb_transaction_files_env(struct odb_transaction *base,
 {
 	struct odb_transaction_files *transaction =
 		container_of(base, struct odb_transaction_files, base);
-	int ret;
 
-	ret = odb_transaction_files_prepare(&transaction->base);
-	if (!ret)
-		strvec_pushv(env, tmp_objdir_env(transaction->objdir));
+	strvec_pushv(env, tmp_objdir_env(transaction->objdir));
 
-	return ret;
+	return 0;
 }
 
 int odb_transaction_files_begin(struct odb_source *source,
@@ -1562,6 +1537,8 @@ int odb_transaction_files_begin(struct odb_source *source,
 				enum odb_transaction_flags flags)
 {
 	struct odb_transaction_files *transaction;
+	const char *prefix;
+	int ret;
 
 	transaction = xcalloc(1, sizeof(*transaction));
 	transaction->base.source = source;
@@ -1573,24 +1550,13 @@ int odb_transaction_files_begin(struct odb_source *source,
 	transaction->flags = flags;
 	strvec_init(&transaction->pack_names);
 
-	transaction->prefix = "transaction";
-	if (flags & ODB_TRANSACTION_RECEIVE) {
-		/*
-		 * ODB transactions for git-receive-pack(1) eagerly create a
-		 * temporary directory and use a different temporary directory
-		 * prefix.
-		 *
-		 * NEEDSWORK: This transaction flag is only used by the "files"
-		 * backend to special case temporary directory set up and
-		 * handling. Ideally transaction users should not have to care
-		 * though. To avoid this, we could eagerly create the temporary
-		 * directory and use the same prefix name for all transactions.
-		 */
-		transaction->prefix = "incoming";
-		if (odb_transaction_files_prepare(&transaction->base)) {
-			free(transaction);
-			return -1;
-		}
+	prefix = flags & ODB_TRANSACTION_RECEIVE ? "incoming" : "transaction";
+	transaction->objdir = tmp_objdir_create(source->odb->repo, prefix, 0);
+	if (!transaction->objdir) {
+		ret = error_errno(_("unable to create temporary object directory in %s"),
+				  source->path);
+		free(transaction);
+		return ret;
 	}
 
 	*out = &transaction->base;
diff --git a/object-file.h b/object-file.h
index f44758c4f8..9ad79bbde0 100644
--- a/object-file.h
+++ b/object-file.h
@@ -177,7 +177,6 @@ int odb_transaction_files_begin(struct odb_source *source,
 				struct odb_transaction **out,
 				enum odb_transaction_flags flags);
 
-int odb_transaction_files_prepare(struct odb_transaction *base);
 void odb_transaction_files_fsync(struct odb_transaction *base,
 				 int fd, const char *filename);
 
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 50cb388c35..9330ae94b5 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -769,9 +769,6 @@ static int write_loose_object(struct odb_source_loose *loose,
 	static struct strbuf tmp_file = STRBUF_INIT;
 	static struct strbuf filename = STRBUF_INIT;
 
-	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
-		odb_transaction_files_prepare(loose->base.odb->transaction);
-
 	odb_loose_path(loose, &filename, oid);
 
 	fd = start_loose_object_common(loose, &tmp_file, filename.buf, flags,
@@ -860,9 +857,6 @@ static int odb_source_loose_write_object_stream(struct odb_source *source,
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
 
-	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
-		odb_transaction_files_prepare(loose->base.odb->transaction);
-
 	/* Since oid is not determined, save tmp file to odb path. */
 	strbuf_addf(&filename, "%s/", loose->base.path);
 	hdrlen = format_object_header(hdr, sizeof(hdr), in_stream->type, in_stream->size);
diff --git a/t/t0004-unwritable.sh b/t/t0004-unwritable.sh
index 3bdafbae0f..7292672a66 100755
--- a/t/t0004-unwritable.sh
+++ b/t/t0004-unwritable.sh
@@ -24,8 +24,8 @@ test_expect_success POSIXPERM,SANITY 'write-tree should notice unwritable reposi
 test_lazy_prereq WRITE_TREE_OUT 'test -e "$TRASH_DIRECTORY"/out.write-tree'
 test_expect_success WRITE_TREE_OUT 'write-tree output on unwritable repository' '
 	cat >expect <<-\EOF &&
-	error: insufficient permission for adding an object to repository database .git/objects
-	fatal: git-write-tree: error building trees
+	error: unable to create temporary object directory in .git/objects: Permission denied
+	fatal: failed to start ODB transaction
 	EOF
 	test_cmp expect out.write-tree
 '
@@ -39,8 +39,8 @@ test_expect_success POSIXPERM,SANITY 'commit should notice unwritable repository
 test_lazy_prereq COMMIT_OUT 'test -e "$TRASH_DIRECTORY"/out.commit'
 test_expect_success COMMIT_OUT 'commit output on unwritable repository' '
 	cat >expect <<-\EOF &&
-	error: insufficient permission for adding an object to repository database .git/objects
-	error: Error building trees
+	error: unable to create temporary object directory in .git/objects: Permission denied
+	fatal: failed to start ODB transaction
 	EOF
 	test_cmp expect out.commit
 '
@@ -55,9 +55,8 @@ test_expect_success POSIXPERM,SANITY 'update-index should notice unwritable repo
 test_lazy_prereq UPDATE_INDEX_OUT 'test -e "$TRASH_DIRECTORY"/out.update-index'
 test_expect_success UPDATE_INDEX_OUT 'update-index output on unwritable repository' '
 	cat >expect <<-\EOF &&
-	error: insufficient permission for adding an object to repository database .git/objects
-	error: file: failed to insert into database
-	fatal: Unable to process path file
+	error: unable to create temporary object directory in .git/objects: Permission denied
+	fatal: failed to start ODB transaction
 	EOF
 	test_cmp expect out.update-index
 '
@@ -72,10 +71,8 @@ test_expect_success POSIXPERM,SANITY 'add should notice unwritable repository' '
 test_lazy_prereq ADD_OUT 'test -e "$TRASH_DIRECTORY"/out.add'
 test_expect_success ADD_OUT 'add output on unwritable repository' '
 	cat >expect <<-\EOF &&
-	error: insufficient permission for adding an object to repository database .git/objects
-	error: file: failed to insert into database
-	error: unable to index file '\''file'\''
-	fatal: updating files failed
+	error: unable to create temporary object directory in .git/objects: Permission denied
+	fatal: failed to start ODB transaction
 	EOF
 	test_cmp expect out.add
 '
-- 
2.56.0.173.gf57c9a7388

