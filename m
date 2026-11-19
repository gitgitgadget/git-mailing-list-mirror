Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795047660;
	b=YPj2+dHBUTjgisSc/nbao7z82DnNa5FV/OgmSFjrYsghy2dDENrnKQ0q5YeOUfFEzccg
	 vy9b8L18qPIapCfB1/NnymY4SMT6Zlp6PIe2zUrqTXj6O6F75simZKm64KPgGU9I5J8g5
	 /0KGVEpgUuHqsFGh8mW6RxEzDwxZ33ydP6S5EAq2+7smUasYXG9OWz6U3mJqvNuY3RvAU
	 PnKnKlDErnISf7TjDs/e9G7x9DFZmaKYlREjf4mpNS5n4j9kOU2/3kdJxEBZLkWu5/LF+
	 u/Q6PopaCk1ESMULsypftC7Kvyyutbwd03KdAjDTJ79Vmw4IeEFunMXk8qWp5p6I9gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795047660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=XUUqE1XrIoxP0AJd9iz0zC8BQbRMogpYKh0LrcLZrSI=;
	b=OrX5RkdPT8C+m7P5+tDQasntNO/77i0RYwK5Tx/oQUu3Sa4GUH7gEHuUeHbXm3E0r08I
	 9dj+AugagOVZuwH65yiyxcTrgoPjA8rWN9pMhew1+0RSnxiEkCvIYYc/q4NvjbkzR91oq
	 /QtZcVOQj8AMsEVIhvcBO3qSgxEf8SnKPZjMVoeHhjKlx0P6j0X9FjaFjTqtlw0ha7Am7
	 x4juJ2tG7jy/+axpah4YOG3UwV6gUdEuZulgQsKxtHWMmzVY93f3LhVCyKziCOD4Um463
	 LbiOAJ+7UmLH7tBbgvHXAGwEMAQJmxZYQ+9faTJA58a7PAhvAVEuNFrwg2RUpAOmFpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wwnzAFkS;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF89160A2608
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 00:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF89160A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wwnzAFkS
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-85c1135c286so1222051a34.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 16:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795047659; x=1795652459; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XUUqE1XrIoxP0AJd9iz0zC8BQbRMogpYKh0LrcLZrSI=;
        b=wwnzAFkSWGvs5oNOqLWqBl1ALSPe/WQWFZ0cRBNuLTfD300pWmW2uNSSkXaty35n5b
         OLWetwwG3KCKC+gAb0SRIvO62sCGR27vZMwRSPg8L8NsinV9HNgAJwu3g02muUAQn9g8
         Ejx8cHWVjlUDo5IHKGEX41dPYhBEyt8b/SDgeGfjKHCGb6nh66dqzb3/fQ0sDvhdZBx8
         j4vYKG4NgD4yN+0udBzWm8pIUO6VVOG4pWX+8A9iQ7nq2q79OHC+Fhig0+ggKd79xksJ
         MVPT4ju9LlOk/4FlGmCAlRNY9ZPC53ihWU7BeFHzIZASp8kzH1wWeJpIAVLG04+4a1Ou
         wnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795047659; x=1795652459;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XUUqE1XrIoxP0AJd9iz0zC8BQbRMogpYKh0LrcLZrSI=;
        b=ytdNqT41Ch8G15dUC/jcoZlcWtqH3/v15vatiBywrllDiiT+mlRA5PHaDfsJlqHYOp
         2ylBRUImLcZdb/GWSKSs8IWBX05DkdKLdwSLsEcX0Joq4S3P8nMRTeUVjrVU3GAQCMcS
         B53ITTpUHr8dpnk8kOYlACP18kaHdGWJmKNZvP5WcWYx5tj0RPjcMqkrRFQLDaXN65Fs
         JJUVX53C9TExAJpQ7enCLGD5YbJwkDwEbW/hW1rii3+CikWMG+plR6t0/uDuLMFSHSg3
         jpPyUYjNjwFF0/FCh8Oc8y03AP1s2Ks4KuRyKCCjnSK+ovT3rqWp3ett37H66uTNJMov
         Cc1Q==
X-Gm-Message-State: APuU4Z933AygMBDiJjaKz3wcs9608DLXEga9BzMorD/iXc1f73wwgeTD
	n+CvZ1DKpglSYmIHXHQmBHYF2/W9R3ib9v37KGagDPwzHABy41Gk33uTdef1UQ==
X-Gm-Gg: AYBFou0L+uaC2ZOR7QhWEb4GBZC70YB3tXR90LVplXmHNsiJwg+X85kyUdXApjZb535
	V+ZOfkLDZyI3C0jGO5Wdc/FpCja9kEf0IvXLHGFBO/sx3wMTjhGXDOnS4Gt6jO5SFzHkRSUfNdF
	0YE89y7MD5vmwlad7l8kfjTr9W8a2oYhohhlN54CqLg0a7uuJX3hzh0ZCzq/aoZigDkme4W8y7r
	piEjtjATq/nYMzqU2Mf5fDmolAj+1bw8jDIxvJ6ieu7KJVu46J23b/1bh0tzXgKK+IwrkM8Ywv2
	hFsvU67hdzDVvibA2RIQj3BGAhVz83/or9P0zTqRq8P2SSFXxSUBQLUFNHnox4kpAzZ4tNjYokX
	XWJQVD/XaTZvilwEuNGq5oSkRDEcS5znLw0SsOW9A5XirIeyxZDffrEARDHFXy8DCuQCV0i/U0Q
	JXoGNsmjWkLCBPCWK4XEVyWr/vEyTjx9GYxueySjOEtWxSTqeOgZX45OG1DZJx4Flr/IAzyPRuA
	+4LJ0nr7tH1hbbVuqnrh8JB9dzcp/gcpnd1ycj3KarKn4xS1Bpt1/uYHzXzTsg7N2b6OhRuVwWi
	GiohgyOTdJI8C3V8ynJ0v9yU/NRMm8V5Kiu2wuLfjCUcj7vSlz3GbHcBNbcEYySIzJP9
X-Received: by 2002:a05:6830:4429:b0:85e:ff79:a340 with SMTP id 46e09a7af769-862f09063fcmr4478658a34.11.1795047658838;
        Wed, 18 Nov 2026 16:20:58 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f01d492dsm3293400a34.6.2026.11.18.16.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 16:20:58 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 6/6] object-file: create ODB transaction temporary directory eagerly
Date: Wed, 18 Nov 2026 18:20:43 -0600
Message-ID: <20261119002043.2108654-7-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261119002043.2108654-1-jltobler@gmail.com>
References: <20261110002251.2007617-1-jltobler@gmail.com>
 <20261119002043.2108654-1-jltobler@gmail.com>
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

The overhead is a small fixed cost per object for migrating it into the
primary object directory, which is minor compared to the cost of writing
the object in the first place. It is most visible when adding many small
files at once, as in the benchmark above. Otherwise, transactions
typically write only a few loose objects, for example when unpacking a
pushed packfile with fewer objects than the unpack limit. So the
overhead is not expected to be noticeable in most cases.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c         | 56 +++++++++----------------------------------
 object-file.h         |  1 -
 odb/source-loose.c    |  6 -----
 t/t0004-unwritable.sh | 19 +++++++--------
 4 files changed, 19 insertions(+), 63 deletions(-)

diff --git a/object-file.c b/object-file.c
index 1926f61f53..8af9b0975a 100644
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
@@ -1547,13 +1525,10 @@ static int odb_transaction_files_env(struct odb_transaction *base,
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
@@ -1561,6 +1536,8 @@ int odb_transaction_files_begin(struct odb_source *source,
 				enum odb_transaction_flags flags)
 {
 	struct odb_transaction_files *transaction;
+	const char *prefix;
+	int ret;
 
 	transaction = xcalloc(1, sizeof(*transaction));
 	transaction->base.source = source;
@@ -1572,24 +1549,13 @@ int odb_transaction_files_begin(struct odb_source *source,
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
index 3bdafbae0f..4dca4ada91 100755
--- a/t/t0004-unwritable.sh
+++ b/t/t0004-unwritable.sh
@@ -24,8 +24,8 @@ test_expect_success POSIXPERM,SANITY 'write-tree should notice unwritable reposi
 test_lazy_prereq WRITE_TREE_OUT 'test -e "$TRASH_DIRECTORY"/out.write-tree'
 test_expect_success WRITE_TREE_OUT 'write-tree output on unwritable repository' '
 	cat >expect <<-\EOF &&
-	error: insufficient permission for adding an object to repository database .git/objects
-	fatal: git-write-tree: error building trees
+	error: unable to create temporary object directory in .git/objects: Permission denied
+	fatal: failed to start object transaction
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
+	fatal: failed to start object transaction
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
+	fatal: failed to start object transaction
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
+	fatal: failed to start object transaction
 	EOF
 	test_cmp expect out.add
 '
-- 
2.56.0.173.gf57c9a7388

