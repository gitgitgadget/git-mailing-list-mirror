Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795047655;
	b=1QKgBd1ojeNcRzEjikUvmGHJG7wDIJgoEDH4NVAB+88pLVqR/NmFH4j2c1k3IkRPpllx
	 ADrWU+RNB9+yefIh72XQ8mJV60fxUJQe1rWJn+eXTjj61rw1laijxOUSOhphmyxHuDG6z
	 ZzmNvgNGGXH6swRKRluKfxvxXFXzvn6fz9WSLEk5I/qleJgBtjOC6MKpAS6jL+CnFVNBr
	 L5U+WMo54Q/0Tbk/u0DJ54mcV6fZUcEihm49UK8AMrwsiUACqhNd8aSIE2Z1TQygMwMck
	 0+IVF+i6+0yXh+WCpZwsDafyNKsY5eEy9jWA1CHL7601iHNksnZ3izwIDYThfoKzd1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795047655;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Ky/gOzLqSs+zSGlXolLfhJr5ruBh35+JGGdhTF6h++E=;
	b=BQPH/9GAGVO24e8MERy59172aSCxITeuh3vQTzzfqhIcq/72AGUal9lRzPPY3DyXm3hV
	 i5krhFPWuFPNytIByLUjR7UY4RTDX9i9XyPSVF6THGdc9/GLDe2w/x/h2oBT2l8X00dXA
	 +3fBjLc10IkUWYR++jag7sAMiM7WSSuwGbg9xFj8JVJc5E7EKgiEfpO4ocdEOblmoms3b
	 U4bOGDavMXc9aCgXtZP64ShzKjoCeN9bhVc4mNxGdMZNT9KoFNHM/1cHwixXotgR3PE2P
	 trdMdMS9YBOaR3BgZ2c3xwWvptmug51+yLAfFL7Gn9waEevr/GRDlOTVxVfuVJW0XIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rFbGztr1;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C153D606A32F
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 00:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C153D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rFbGztr1
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7f84a55e31aso1069079a34.2
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 16:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795047654; x=1795652454; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ky/gOzLqSs+zSGlXolLfhJr5ruBh35+JGGdhTF6h++E=;
        b=rFbGztr1ufS9BerEzUzA6GCeqI5ufZ5M4Yh2W7iNPTNiNKN1ScAlmAwtos6/JeHkt4
         AtNgUhO/O9IeZc4dA4vtEKhcUJfwme5ejFyCOqcRqAae0HNhSoAnPQD5pEAH4UQ9HSNB
         RRZ0H0xROIRsvgY0GH5why5ZnSEWsyZ4eACT6jG2WwbcpT95lr6ILn3qcgLzFwIZy98k
         bfs+aJ8AR9xgmbeZuFioIur5W/rB4eik7Z1q4LgO1BMFSFe8iBiq5aXZEFVrYQpfEw6t
         J4zZkjUtBZGTytD1B8MHDplJ61QirYa79oqrBaadUui4CsmMZZ8SSkSOOagGHl1KzE/V
         8j1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795047654; x=1795652454;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ky/gOzLqSs+zSGlXolLfhJr5ruBh35+JGGdhTF6h++E=;
        b=2Cp0OcYSD2GB98ijIK1TzaPdFfj1tZysLXsSbZ5ukmx9Wv9QTHUbk4fKMwvUOJoIxd
         bzmjwFHTgL5rBpoICpd3Dk/YG8Wz3Bj7Rcq0N7MsvalYDgX0Cibp1sR7W1x0Kt8DuzgJ
         VnClpYEUtYNc7QPTzTO0LYf2/BNwhZOuNYUPhaV8FUYMpo2LyISjp9anFIXXrCMS+Ycq
         bbcjeG1iU+tqTxoz2QuZ86Fb1xv9/+Rtvg22P3knHCD2Vpx2KUh8Z9yoG6347I04Xxwl
         mdLJKjJUxUt06lMq8Uk2CsIjuFZ/pHu+VgZO7nNmfPpBuZ1F069dAeKPxJJlaCUvnbtp
         H4NA==
X-Gm-Message-State: APuU4Z8zD67QOJ87blhjjCcr84APS3Jj3f2pxH8H9TWAolKHnA/hOKHu
	F2eO0d+7X5dgUUzoPgMet0TerVYP4QZebnjnRElEJVvTc3vNlGXmfrRnPXf2AQ==
X-Gm-Gg: AYBFou0QShcf37GlRYuLW//EXEnQVZ9xPa80oR5F50HfxA5DANIzGBUD2ZPgEQTy9ig
	NwU3TBK6zN2CctDMubTN31cONcdn3JesbYL1XK9e7bodgfR/ctJjTN/vRr52sgMw+Sou6n+WYf7
	q2bg4PSLz68/VxB/IWz2zlgI81707K8HIOpgIDCnCF3pT/rEtA/9WvwywCuFT2kUFLph2l0BMoB
	vQDxrKDc+jPRVrmSiL9UTQ+Q2/qHueZnR5ftWwHunc9rq1MXHfMkOfF0fqx1ct6Ld5l/KyFzO0p
	p0pZlS7uFb3n/jJk68kiFaVL++qO49nykYDlmplycCbD8QsRAze55iN3jWvhvBhGrLohHnJ23B6
	4p/9WJR0pp9qZM74gamaPxnuUZGWa7ZC5MzENFhGpBj7Pq0D426ua+Ph6Hvzzzab26qIdHrOpkr
	HfynKaLbZUIsXdhKxBwV5jMG2JNe77u+5Pe0d6nKh1bVV0/Qa2EuYfsT7zd8HhWK3XvHTS+GooC
	cn8ccy/An+8QEXBuDRnN4durpKrvJAgCWw6+c2em0VEDtPd7VzX+yVh7HE4tK7h3VvsH6isYh7C
	KLZfygD/hbHyW6x2mtGfvhHbEQc/EKU1hEKM7jAuZV9MWN52c4/GzgfBAU2Z0UG8SB/2
X-Received: by 2002:a05:6830:2695:b0:862:c3b7:c2b0 with SMTP id 46e09a7af769-862f08ed656mr4449075a34.9.1795047653607;
        Wed, 18 Nov 2026 16:20:53 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f01d492dsm3293400a34.6.2026.11.18.16.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 16:20:52 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 0/6] object-file: eagerly create ODB transaction temporary directory
Date: Wed, 18 Nov 2026 18:20:37 -0600
Message-ID: <20261119002043.2108654-1-jltobler@gmail.com>
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

Greetings,

This series continues work for the "files" ODB transactions and makes it
so the underlying transaction temporary directory is created eagerly.
Previously, by default, it would wait for the first object write to
lazily create the temporary object directory, and only did so if batched
fsync was configured. This lazy setup is awkward for a couple of
reasons. Writing loose objects has to know about transaction internals
to trigger the creation of the temporary directory, and whether objects
written in a transaction become visible at once on commit depends on the
configured fsync method. Creating the temporary directory eagerly
removes both of these special cases and ensures that objects are written
to the temporary directory for all transactional object writes.

The first five patches consist of some minor preparatory refactors. The
final patch swaps to creating the temporary directory eagerly and drops
the lazy setup.

Changes since v1:
  - Moved the comment for `flush_batched_fsync()` above the function and
    documented that batch fsync only applies to loose objects.
  - Added a new patch that inlines `setup_tmp_objdir()` into
    `tmp_objdir_create()`, which now restores `errno` ina  single exit path.
  - Added a new patch that avoids the "ODB" term in user-facing error
    messages.
  - Clarified some commit messages.

This series is based on 3c60ef1e38 (The 17th batch, 2026-11-08) with
jt/tmp-objdir-loose-idx-merge merged into it.

Thanks,
-Justin

Justin Tobler (6):
  object-file: rename default transaction prefix
  object-file: only flush batched fsync writes when enabled
  tmp-objdir: inline `setup_tmp_objdir()`
  tmp-objdir: preserve errno when directory creation fails
  odb/transaction: avoid "ODB" in error messages
  object-file: create ODB transaction temporary directory eagerly

 object-file.c         | 98 ++++++++++++++++---------------------------
 object-file.h         |  1 -
 odb/source-loose.c    |  6 ---
 odb/transaction.h     |  6 +--
 t/t0004-unwritable.sh | 19 ++++-----
 tmp-objdir.c          | 30 ++++++-------
 tmp-objdir.h          |  3 +-
 7 files changed, 63 insertions(+), 100 deletions(-)

Range-diff against v1:
1:  eb3679a4ea = 1:  eb3679a4ea object-file: rename default transaction prefix
2:  392893af4e ! 2:  e2fb4b4833 object-file: only flush batched fsync writes when enabled
    @@ Commit message
         unnecessary. Only issue the flush when batched fsync is enabled
         accordingly.
     
    +    Note that batched fsync only applies to loose objects. Other files
    +    written as part of the transaction, such as packfiles, are fully synced
    +    when written or not synced at all, and thus do not rely on this flush.
    +
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
      ## object-file.c ##
    @@ object-file.c: static int write_pack_lockfiles(struct odb_transaction_files *tra
      	return ret;
      }
      
    ++/*
    ++ * Issue a full hardware flush against a temporary file to ensure that all
    ++ * objects are durable before any renames occur. The code in
    ++ * odb_transaction_files_fsync has already issued a writeout request, but it has
    ++ * not flushed any writeback cache in the storage hardware or any filesystem
    ++ * logs. This fsync call acts as a barrier to ensure that the data in each new
    ++ * object file is durable before the final name is visible.
    ++ */
     +static void flush_batched_fsync(struct repository *repo)
     +{
     +	struct strbuf temp_path = STRBUF_INIT;
     +	struct tempfile *temp;
     +
    -+	/*
    -+	 * Issue a full hardware flush against a temporary file to ensure
    -+	 * that all objects are durable before any renames occur. The code in
    -+	 * odb_transaction_files_fsync has already issued a writeout
    -+	 * request, but it has not flushed any writeback cache in the storage
    -+	 * hardware or any filesystem logs. This fsync call acts as a barrier
    -+	 * to ensure that the data in each new object file is durable before
    -+	 * the final name is visible.
    -+	 */
     +	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX",
     +		    repo_get_object_directory(repo));
     +	temp = xmks_tempfile(temp_path.buf);
-:  ---------- > 3:  ae6548cd8f tmp-objdir: inline `setup_tmp_objdir()`
3:  ede4bc8aa1 ! 4:  f013767e55 tmp-objdir: preserve errno when directory creation fails
    @@ Commit message
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
      ## tmp-objdir.c ##
    -@@ tmp-objdir.c: static int setup_tmp_objdir(const char *root)
    - {
    - 	char *path;
    - 	int ret = 0;
    -+	int saved_errno;
    - 
    - 	path = xstrfmt("%s/pack", root);
    - 	ret = mkdir(path, 0777);
    -+	saved_errno = errno;
    - 	free(path);
    -+	errno = saved_errno;
    - 
    - 	return ret;
    - }
     @@ tmp-objdir.c: struct tmp_objdir *tmp_objdir_create(struct repository *r,
      	struct odb_source_files *files = odb_source_files_downcast(r->objects->source);
      	static int installed_handlers;
      	struct tmp_objdir *t;
     +	int saved_errno;
    + 	char *path;
    + 	int ret;
      
    - 	if (the_tmp_objdir)
    - 		BUG("only one tmp_objdir can be used at a time");
     @@ tmp-objdir.c: struct tmp_objdir *tmp_objdir_create(struct repository *r,
      		chdir_notify_register(tmp_objdir_reparent, t);
      
    @@ tmp-objdir.c: struct tmp_objdir *tmp_objdir_create(struct repository *r,
     +		saved_errno = errno;
      		/* free, not destroy, as we never touched the filesystem */
      		tmp_objdir_free(t);
    -+		errno = saved_errno;
    - 		return NULL;
    +-		return NULL;
    ++		goto error;
      	}
      
    + 	the_tmp_objdir = t;
     @@ tmp-objdir.c: struct tmp_objdir *tmp_objdir_create(struct repository *r,
    - 	}
      
    - 	if (setup_tmp_objdir(t->path.buf)) {
    -+		saved_errno = errno;
    + 	path = xstrfmt("%s/pack", t->path.buf);
    + 	ret = mkdir(path, 0777);
    ++	saved_errno = errno;
    + 	free(path);
    + 	if (ret) {
      		tmp_objdir_destroy(t);
    -+		errno = saved_errno;
    - 		return NULL;
    +-		return NULL;
    ++		goto error;
      	}
      
    + 	env_append(&t->env, ALTERNATE_DB_ENVIRONMENT,
    +@@ tmp-objdir.c: struct tmp_objdir *tmp_objdir_create(struct repository *r,
    + 	t->repo->disable_ref_updates = true;
    + 
    + 	return t;
    ++
    ++error:
    ++	errno = saved_errno;
    ++	return NULL;
    + }
    + 
    + /*
     
      ## tmp-objdir.h ##
     @@ tmp-objdir.h: struct tmp_objdir;
-:  ---------- > 5:  66eaf498e9 odb/transaction: avoid "ODB" in error messages
4:  dd36ba0fb7 ! 6:  6d2266ad20 object-file: create ODB transaction temporary directory eagerly
    @@ Commit message
             git add . (rev = HEAD~) ran
               1.07 ± 0.04 times faster than git add . (rev = HEAD)
     
    -    Typically large numbers of loose objects are not expected to be written
    -    into an ODB transaction so the overhead here should be marginal.
    +    The overhead is a small fixed cost per object for migrating it into the
    +    primary object directory, which is minor compared to the cost of writing
    +    the object in the first place. It is most visible when adding many small
    +    files at once, as in the benchmark above. Otherwise, transactions
    +    typically write only a few loose objects, for example when unpacking a
    +    pushed packfile with fewer objects than the unpack limit. So the
    +    overhead is not expected to be noticeable in most cases.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
    @@ t/t0004-unwritable.sh: test_expect_success POSIXPERM,SANITY 'write-tree should n
     -	error: insufficient permission for adding an object to repository database .git/objects
     -	fatal: git-write-tree: error building trees
     +	error: unable to create temporary object directory in .git/objects: Permission denied
    -+	fatal: failed to start ODB transaction
    ++	fatal: failed to start object transaction
      	EOF
      	test_cmp expect out.write-tree
      '
    @@ t/t0004-unwritable.sh: test_expect_success POSIXPERM,SANITY 'commit should notic
     -	error: insufficient permission for adding an object to repository database .git/objects
     -	error: Error building trees
     +	error: unable to create temporary object directory in .git/objects: Permission denied
    -+	fatal: failed to start ODB transaction
    ++	fatal: failed to start object transaction
      	EOF
      	test_cmp expect out.commit
      '
    @@ t/t0004-unwritable.sh: test_expect_success POSIXPERM,SANITY 'update-index should
     -	error: file: failed to insert into database
     -	fatal: Unable to process path file
     +	error: unable to create temporary object directory in .git/objects: Permission denied
    -+	fatal: failed to start ODB transaction
    ++	fatal: failed to start object transaction
      	EOF
      	test_cmp expect out.update-index
      '
    @@ t/t0004-unwritable.sh: test_expect_success POSIXPERM,SANITY 'add should notice u
     -	error: unable to index file '\''file'\''
     -	fatal: updating files failed
     +	error: unable to create temporary object directory in .git/objects: Permission denied
    -+	fatal: failed to start ODB transaction
    ++	fatal: failed to start object transaction
      	EOF
      	test_cmp expect out.add
      '
-- 
2.56.0.173.gf57c9a7388

