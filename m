Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA6D32D5CF
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047388; cv=none; b=fKrEkqPiynaWljeJ5e8XQCW96Ik1B9BO3cWNsXihWfXZ36TzdLaVncXpgK7GF2eQRcR+dPdYNTmSdMSqgZ7WLf/abU32A1ewB37HKFxxEW76Gynu1RvXO3MyVlE49vWUhSE+uBSdOwDRSXlTtcjzHwGK9CaT7egvXNkmL7kA9/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047388; c=relaxed/simple;
	bh=6/FYEvVaQzXHgnLE+vEo+yaIZCccvp4uWXpxgGIg4m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o095Lx27NVnDT777FHBn0DfTZBdx5f8yL7u+0wZpyjGr0yGQslI4YTxdTXnpZk7ctzadCB6j0Fj1G3ztjPQWgLipKVSjG9T+yRtSChxb8DmPfBo1Mw0FUXsifr2kqOhHwo+NJo/kWhFdSEgKD3nIR/iVEPe+dapE5HtZNcjdrwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFE7mVM4; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFE7mVM4"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-30cceb3be82so4145089fac.2
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 11:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758047385; x=1758652185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aWZTepcYz9GoRNx+yEJl6LIIFyUBZYrjJzX1qF2SBU=;
        b=SFE7mVM41gxbt3LSqaoGfWqvFilCGwOM4yr8n40SuEFETzN5Tj7RdddLYpOaILbrad
         0BVX47kIrlf+0K/uXDdsibnCw1Y+cWAHgxrsDWz1ZV2KjjEeirFCkKPKFA/RkBt7kxjr
         tgWUUF3YHFARU4Y/yxa996hgUl5EvwMhRudS83dKg++mXejYYGcax3gV0/u4F73LqUrf
         +jFMDOyYsSLCisH/PKPoz46/izxiDy6nE+t1QjUO/wqNW5zRYuv54W95HfHhZFJRjDG3
         c8oCwYWSGRM70zkEqk0xG+p7JUIU9UYqUDj1olq4pXOqpyt08URdU8Xl/TeedPW5WKbY
         1U5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758047385; x=1758652185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aWZTepcYz9GoRNx+yEJl6LIIFyUBZYrjJzX1qF2SBU=;
        b=KIS1BICRfUOfoRIUD9sIfnV0VojqkD2UFsmfH5tusp0H2exBxQcrXNA5F2Pj+j93Lb
         MpWGbdtfdljZY4sHEk4YZPUoxRglpap7JzRfXP+WjoDoNTiJ26NwniFLRvL82nB2UlBd
         0jLn5JBg0Ayy9Z7KDpZiDwToHMN3cw4z8PJ50+wgMCKzj9cfFCt7H+/Eg6wYsRnSteUr
         f8NSy8ID/BbzHel0MKyokUNxUNZ+/wAhbC1HMurE3zy3VFdk6EXjARs0zy4rdUAPL4c8
         RdMiT8JuhD78WRZXl6jyR8WOqCKPqjQaHGVqTc+sWo4OeZIUSNmMpgeXtsXppk8GMoWj
         GzMw==
X-Gm-Message-State: AOJu0YwsDQ9t3PKRIy8SqRQUqSOUadqri1sH+CZW8H8i/Lqvvb5pyBr1
	8nq3MdUTcvXunMWpHKE2C+PhlUN4pttp0BIlz3BV8sKpk+9RfLwKGzuuF/AoNg==
X-Gm-Gg: ASbGnctU4rlupQYhQPsNWPFwVaaPSu5b15u9fMiN8eKAVIz+xOKXk7VldbqEqcg8x3p
	eNO9WX+H+FmfAYZ5+WxeM3vOVTeHug4VrEVOi5XDERp+hdH3i1FDuPq6fPhvJ3njGuAFLqILnA8
	z45oOL7weaGvH/V/ZqSYW59s/oAViBvf5b+izktS8WcZ06OkV4NI/DWmBeIfyFjrPJQmfMzWRVo
	7I4xY0QR9gyt1XDqIoNTkCRMytZqU2C3VAK4Q9NW/aYM/UAEjvrbSOXlgysmdwzkXa+k8pvqnfT
	hQdUOYMipQ+IroS3HBcslwO1R9mR/3UGo8jkVhCRqf+2H93BEHWnuUJ7f80BsJqDDsshcAvQ8Tm
	pJGDCIXgpgOk+RIfAjt52CUia1W4e59U=
X-Google-Smtp-Source: AGHT+IGrXIZfFD9k8L5uW8HeQ83iZhHzBE9x1dxAdzC75OUikuJKKQTJEjwnNvCKVw2IjdXZmYJxhw==
X-Received: by 2002:a05:6871:5291:b0:316:8c45:3959 with SMTP id 586e51a60fabf-32e53f80959mr7990323fac.7.1758047384405;
        Tue, 16 Sep 2025 11:29:44 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-32d32d5653fsm5003058fac.7.2025.09.16.11.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 11:29:43 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 0/6] odb: add transaction interfaces to ODB subsystem
Date: Tue, 16 Sep 2025 13:29:32 -0500
Message-ID: <20250916182938.2193476-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250915202956.3784935-1-jltobler@gmail.com>
References: <20250915202956.3784935-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

This series is a followup to [1] and continues iterating on the ODB
transaction interfaces.

The bulk-checkin subsystem provides an interface to manage ODB
transactions. Apart from {begin,end}_odb_transaction(), these functions
are only used by the object-file subsystem to manage aspects of a
transaction implementation specific to the files object source.

In a pluggable object database future where we could have different
types of object database sources, transaction handling will have to be
implemented separately per source. Thus, the primary focus of this
series is to simplify the existing ODB transaction interface and provide
a means to manage transactions via the ODB subsystem in an object source
agnostic manner eventually.

This series is built on top of 4975ec3473b (The seventh batch,
2025-09-08) with jt/de-global-bulk-checkin merged into it at ddc0b56ad77
(bulk-checkin: use repository variable from transaction, 2025-08-22).

Changes since V1:

- end_odb_transaction() is now a no-op when no transaction is specified
  and also guards against the ending a transaction not set in the object
  database.
- The object_file_transaction_begin() now accepts a `struct odb_source`
  instead of `struct odbject_database`. Which is more in line with it
  being a transaction implementation specific to an object source.
- Further clarified some commit messages.
- Renamed object_file_transaction_end() to
  object_file_transaction_commit() to match the corresponding function
  in the ODB section.
- Add some missing documentation for odb_transaction_{begin,commit}().

Change since V2:

- begin_odb_transaction() now behaves as a no-op and returns a NULL
  transaction value when the ODB already has an active transaction.
  Callers are no longer required to manually check if there is an active
  transaction beforehand.
- Reworded several commit messages.

Thanks,
-Justin

[1]: <20250820225531.1212935-1-jltobler@gmail.com>

Justin Tobler (6):
  bulk-checkin: remove ODB transaction nesting
  builtin/update-index: end ODB transaction when --verbose is specified
  bulk-checkin: drop flush_odb_transaction()
  object-file: relocate ODB transaction code
  object-file: update naming from bulk-checkin
  odb: add transaction interface

 Makefile                 |   1 -
 builtin/add.c            |   7 +-
 builtin/unpack-objects.c |   5 +-
 builtin/update-index.c   |  29 +--
 bulk-checkin.c           | 403 --------------------------------------
 bulk-checkin.h           |  61 ------
 cache-tree.c             |   5 +-
 meson.build              |   1 -
 object-file.c            | 404 ++++++++++++++++++++++++++++++++++++++-
 object-file.h            |  16 ++
 odb.c                    |  10 +
 odb.h                    |  13 ++
 read-cache.c             |   5 +-
 13 files changed, 462 insertions(+), 498 deletions(-)
 delete mode 100644 bulk-checkin.c
 delete mode 100644 bulk-checkin.h

Range-diff against v2:
1:  217f3eb6d2 ! 1:  9fe2ab4198 bulk-checkin: remove ODB transaction nesting
    @@ Commit message
         bulk-checkin: remove ODB transaction nesting
     
         ODB transactions support being nested. Only the outermost
    -    {begin,end}_odb_transaction() start and finish a transaction. This is
    -    done so that certain object write codepaths that occur internally can be
    -    optimized via ODB transactions without having to worry if a transaction
    -    has already been started or not. This can make the interface a bit
    -    awkward to use, as calling {begin,end}_odb_transaction() does not
    -    guarantee that a transaction is actually started or ended. Thus, in
    -    situations where a transaction must be explicitly flushed,
    -    flush_odb_transaction() must be used.
    +    {begin,end}_odb_transaction() start and finish a transaction. This
    +    allows internal object write codepaths to be optimized with ODB
    +    transactions without worrying about whether a transaction is already
    +    active. When {begin,end}_odb_transaction() is invoked during an active
    +    transaction, these operations are essentially treated as no-ops. This
    +    can make the interface a bit awkward to use, as calling
    +    end_odb_transaction() does not guarantee that a transaction is actually
    +    ended. Thus, in situations where a transaction needs to be explicitly
    +    flushed, flush_odb_transaction() must be used.
     
    -    To better clarify ownership sematics around a transaction and further
    -    remove the need for flush_odb_transaction() as part of the transaction
    -    interface, instead be more explicit and require callers who use ODB
    -    transactions internally to ensure there is not already a pending
    -    transaction before beginning or ending a transaction.
    +    To remove the need for an explicit transaction flush operation via
    +    flush_odb_transaction() and better clarify transaction semantics, drop
    +    the transaction nesting mechanism in favor of begin_odb_transaction()
    +    returning a NULL transaction value to signal it was a no-op, and
    +    end_odb_transaction() behaving as a no-op when a NULL transaction value
    +    is passed. This is safe for existing callers as the transaction value
    +    wired to end_odb_transaction() already comes from
    +    begin_odb_transaction() and thus continues the same no-op behavior when
    +    a transaction is already pending. With this model, passing a pending
    +    transaction to end_odb_transaction() ensures it is committed at that
    +    point in time.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
    @@ bulk-checkin.c: void fsync_loose_object_bulk_checkin(struct odb_transaction *tra
     -		odb->transaction->odb = odb;
     -	}
     +	if (odb->transaction)
    -+		BUG("ODB transaction already started");
    ++		return NULL;
      
     -	odb->transaction->nesting += 1;
     +	CALLOC_ARRAY(odb->transaction, 1);
    @@ bulk-checkin.h: int index_blob_bulk_checkin(struct odb_transaction *transaction,
     - * to make new objects visible. Transactions can be nested,
     - * and objects are only visible after the outermost transaction
     - * is complete or the transaction is flushed.
    -+ * to make new objects visible. Only a single transaction
    -+ * can be pending at a time and must be ended before
    -+ * beginning another.
    ++ * to make new objects visible. If a transaction is already
    ++ * pending, NULL is returned.
       */
      struct odb_transaction *begin_odb_transaction(struct object_database *odb);
      
    @@ bulk-checkin.h: void flush_odb_transaction(struct odb_transaction *transaction);
      void end_odb_transaction(struct odb_transaction *transaction);
      
     
    - ## cache-tree.c ##
    -@@ cache-tree.c: static int update_one(struct cache_tree *it,
    - 
    - int cache_tree_update(struct index_state *istate, int flags)
    - {
    --	struct odb_transaction *transaction;
    -+	struct odb_transaction *transaction = NULL;
    - 	int skip, i;
    - 
    - 	i = verify_cache(istate, flags);
    -@@ cache-tree.c: int cache_tree_update(struct index_state *istate, int flags)
    - 
    - 	trace_performance_enter();
    - 	trace2_region_enter("cache_tree", "update", the_repository);
    --	transaction = begin_odb_transaction(the_repository->objects);
    -+
    -+	if (!the_repository->objects->transaction)
    -+		transaction = begin_odb_transaction(the_repository->objects);
    -+
    - 	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
    - 		       "", 0, &skip, flags);
    -+
    - 	end_odb_transaction(transaction);
    -+
    - 	trace2_region_leave("cache_tree", "update", the_repository);
    - 	trace_performance_leave("cache_tree_update");
    - 	if (i < 0)
    -
      ## object-file.c ##
     @@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
    - 		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
    - 				 type, path, flags);
    - 	} else {
    --		struct odb_transaction *transaction;
    -+		struct odb_transaction *transaction = NULL;
    + 		struct odb_transaction *transaction;
      
    --		transaction = begin_odb_transaction(the_repository->objects);
    + 		transaction = begin_odb_transaction(the_repository->objects);
     -		ret = index_blob_bulk_checkin(transaction,
    -+		if (!the_repository->objects->transaction)
    -+			transaction = begin_odb_transaction(the_repository->objects);
    -+
     +		ret = index_blob_bulk_checkin(the_repository->objects->transaction,
      					      oid, fd, xsize_t(st->st_size),
      					      path, flags);
    -+
      		end_odb_transaction(transaction);
    - 	}
    - 
    -
    - ## read-cache.c ##
    -@@ read-cache.c: int add_files_to_cache(struct repository *repo, const char *prefix,
    - 		       const struct pathspec *pathspec, char *ps_matched,
    - 		       int include_sparse, int flags)
    - {
    --	struct odb_transaction *transaction;
    -+	struct odb_transaction *transaction = NULL;
    - 	struct update_callback_data data;
    - 	struct rev_info rev;
    - 
    -@@ read-cache.c: int add_files_to_cache(struct repository *repo, const char *prefix,
    - 	 * This function is invoked from commands other than 'add', which
    - 	 * may not have their own transaction active.
    - 	 */
    --	transaction = begin_odb_transaction(repo->objects);
    -+	if (!repo->objects->transaction)
    -+		transaction = begin_odb_transaction(repo->objects);
    -+
    - 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
    -+
    - 	end_odb_transaction(transaction);
    - 
    - 	release_revisions(&rev);
2:  16af9f1169 ! 2:  f24c28ec56 builtin/update-index: end ODB transaction when --verbose is specified
    @@ Commit message
         object directory and migrated to the primary object database upon
         transaction commit.
     
    -    When the --verbose option is specified, each of the following objects is
    -    explicitly flushed via flush_odb_transaction() prior to reporting the
    -    update. Flushing the object database transaction migrates pending
    -    objects to the primary object database without marking the transaction
    -    as complete. This is done so objects are immediately visible to
    -    git-update-index(1) callers using the --verbose option and that rely on
    -    parsing verbose output to know when objects are written.
    +    When the --verbose option is specified, the subsequent set of objects
    +    written are explicitly flushed via flush_odb_transaction() prior to
    +    reporting the update. Flushing the object database transaction migrates
    +    pending objects to the primary object database without marking the
    +    transaction as complete. This is done so objects are immediately visible
    +    to git-update-index(1) callers using the --verbose option and that rely
    +    on parsing verbose output to know when objects are written.
     
    -    Due to how git-update-index(1) parses options, each filename argument is
    -    evaluated with only the set of options that precede it. Therefore, it is
    -    possible for an initial set of objects to be written in a transaction
    -    before a --verbose option is encountered.
    +    Due to how git-update-index(1) parses arguments, options that come after
    +    a filename are not considered during the object update. Therefore, it
    +    may not be known ahead of time whether the --verbose option is present
    +    and thus object writes are considered transactional by default until a
    +    --verbose option is parsed.
     
    -    As soon as the --verbose option is parsed in git-update-index(1), all
    -    subsequent object writes are flushed prior to being reported and thus no
    -    longer benefit from being transactional. Furthermore, the mechanism to
    -    flush a transaction without committing is rather awkward. Drop the call
    -    to flush_odb_transaction() in favor of ending the transaction early when
    -    the --verbose flag is encountered.
    +    Flushing a transaction after individual object writes negates the
    +    benefit of writing objects to a transaction in the first place.
    +    Furthermore, the mechanism to flush a transaction without actually
    +    committing is rather awkward. Drop the call to flush_odb_transaction()
    +    in favor of ending the transaction altogether when the --verbose flag is
    +    encountered. Subsequent object writes occur outside of a transaction and
    +    are therefore immediately visible which matches the current behavior.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
3:  ae6199a3c8 = 3:  6268b2934a bulk-checkin: drop flush_odb_transaction()
4:  01f5485441 ! 4:  e5f1d93797 object-file: relocate ODB transaction code
    @@ Commit message
         are only used by the object-file subsystem to manage aspects of a
         transaction implementation specific to the files object source.
     
    -    Relocate all the transaction code in in bulk-checkin to object-file.
    -    This simplifies the exposed transaction interface by reducing it to only
    +    Relocate all the transaction code in bulk-checkin to object-file. This
    +    simplifies the exposed transaction interface by reducing it to only
         {begin,end}_odb_transaction(). Function and type names are adjusted in
         the subsequent commit to better fit the new location.
     
    @@ bulk-checkin.c (deleted)
     -struct odb_transaction *begin_odb_transaction(struct object_database *odb)
     -{
     -	if (odb->transaction)
    --		BUG("ODB transaction already started");
    +-		return NULL;
     -
     -	CALLOC_ARRAY(odb->transaction, 1);
     -	odb->transaction->odb = odb;
    @@ bulk-checkin.h (deleted)
     -/*
     - * Tell the object database to optimize for adding
     - * multiple objects. end_odb_transaction must be called
    -- * to make new objects visible. Only a single transaction
    -- * can be pending at a time and must be ended before
    -- * beginning another.
    +- * to make new objects visible. If a transaction is already
    +- * pending, NULL is returned.
     - */
     -struct odb_transaction *begin_odb_transaction(struct object_database *odb);
     -
    @@ object-file.c: int read_loose_object(struct repository *repo,
     +struct odb_transaction *begin_odb_transaction(struct object_database *odb)
     +{
     +	if (odb->transaction)
    -+		BUG("ODB transaction already started");
    ++		return NULL;
     +
     +	CALLOC_ARRAY(odb->transaction, 1);
     +	odb->transaction->odb = odb;
    @@ object-file.h: int read_loose_object(struct repository *repo,
     +/*
     + * Tell the object database to optimize for adding
     + * multiple objects. end_odb_transaction must be called
    -+ * to make new objects visible. Only a single transaction
    -+ * can be pending at a time and must be ended before
    -+ * beginning another.
    ++ * to make new objects visible. If a transaction is already
    ++ * pending, NULL is returned.
     + */
     +struct odb_transaction *begin_odb_transaction(struct object_database *odb);
     +
5:  333319a63d ! 5:  76eabfb6a1 object-file: update naming from bulk-checkin
    @@ object-file.c: static int index_blob_bulk_checkin(struct odb_transaction *transa
      			return error("cannot seek back");
      	}
     @@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
    - 		if (!the_repository->objects->transaction)
    - 			transaction = begin_odb_transaction(the_repository->objects);
    + 		struct odb_transaction *transaction;
      
    + 		transaction = begin_odb_transaction(the_repository->objects);
     -		ret = index_blob_bulk_checkin(the_repository->objects->transaction,
     -					      oid, fd, xsize_t(st->st_size),
     -					      path, flags);
    @@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
     +						      oid, fd,
     +						      xsize_t(st->st_size),
     +						      path, flags);
    - 
      		end_odb_transaction(transaction);
      	}
    + 
     @@ object-file.c: void end_odb_transaction(struct odb_transaction *transaction)
      	 */
      	ASSERT(transaction == transaction->odb->transaction);
6:  30759bbd0d ! 6:  9accbfdbf0 odb: add transaction interface
    @@ builtin/update-index.c: int cmd_update_index(int argc,
     
      ## cache-tree.c ##
     @@ cache-tree.c: int cache_tree_update(struct index_state *istate, int flags)
    - 	trace2_region_enter("cache_tree", "update", the_repository);
    - 
    - 	if (!the_repository->objects->transaction)
    --		transaction = begin_odb_transaction(the_repository->objects);
    -+		transaction = odb_transaction_begin(the_repository->objects);
      
    + 	trace_performance_enter();
    + 	trace2_region_enter("cache_tree", "update", the_repository);
    +-	transaction = begin_odb_transaction(the_repository->objects);
    ++	transaction = odb_transaction_begin(the_repository->objects);
      	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
      		       "", 0, &skip, flags);
    - 
     -	end_odb_transaction(transaction);
     +	odb_transaction_commit(transaction);
    - 
      	trace2_region_leave("cache_tree", "update", the_repository);
      	trace_performance_leave("cache_tree_update");
    + 	if (i < 0)
     
      ## object-file.c ##
     @@ object-file.c: static void prepare_loose_object_transaction(struct odb_transaction *transaction
    @@ object-file.c: static void prepare_loose_object_transaction(struct odb_transacti
      	if (!transaction || transaction->objdir)
      		return;
     @@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
    - 		struct odb_transaction *transaction = NULL;
    - 
    - 		if (!the_repository->objects->transaction)
    --			transaction = begin_odb_transaction(the_repository->objects);
    -+			transaction = odb_transaction_begin(the_repository->objects);
    + 	} else {
    + 		struct odb_transaction *transaction;
      
    +-		transaction = begin_odb_transaction(the_repository->objects);
    ++		transaction = odb_transaction_begin(the_repository->objects);
      		ret = index_blob_packfile_transaction(the_repository->objects->transaction,
      						      oid, fd,
      						      xsize_t(st->st_size),
      						      path, flags);
    - 
     -		end_odb_transaction(transaction);
     +		odb_transaction_commit(transaction);
      	}
    @@ object-file.c: int read_loose_object(struct repository *repo,
     +	struct object_database *odb = source->odb;
     +
      	if (odb->transaction)
    - 		BUG("ODB transaction already started");
    + 		return NULL;
      
     @@ object-file.c: struct odb_transaction *begin_odb_transaction(struct object_database *odb)
      	return odb->transaction;
    @@ object-file.h: struct odb_transaction;
       * Tell the object database to optimize for adding
     - * multiple objects. end_odb_transaction must be called
     + * multiple objects. object_file_transaction_commit must be called
    -  * to make new objects visible. Only a single transaction
    -  * can be pending at a time and must be ended before
    -  * beginning another.
    +  * to make new objects visible. If a transaction is already
    +  * pending, NULL is returned.
       */
     -struct odb_transaction *begin_odb_transaction(struct object_database *odb);
     +struct odb_transaction *object_file_transaction_begin(struct odb_source *source);
    @@ odb.h: struct object_database {
     +/*
     + * Starts an ODB transaction. Subsequent objects are written to the transaction
     + * and not committed until odb_transaction_commit() is invoked on the
    -+ * transaction. Caller are responsible to ensure there is only a single ODB
    -+ * transaction pending at a time.
    ++ * transaction. If the ODB already has a pending transaction, NULL is returned.
     + */
     +struct odb_transaction *odb_transaction_begin(struct object_database *odb);
     +
    @@ odb.h: struct object_database {
     
      ## read-cache.c ##
     @@ read-cache.c: int add_files_to_cache(struct repository *repo, const char *prefix,
    + 	 * This function is invoked from commands other than 'add', which
      	 * may not have their own transaction active.
      	 */
    - 	if (!repo->objects->transaction)
    --		transaction = begin_odb_transaction(repo->objects);
    -+		transaction = odb_transaction_begin(repo->objects);
    - 
    +-	transaction = begin_odb_transaction(repo->objects);
    ++	transaction = odb_transaction_begin(repo->objects);
      	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
    - 
     -	end_odb_transaction(transaction);
     +	odb_transaction_commit(transaction);
      
-- 
2.51.0.193.g4975ec3473b

