Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE3C298CA4
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757968211; cv=none; b=bXyKEaYtcm07PHIxOus6vPek+FcPplALCfnNQBdBi2m81TrNvyXKrI4yVEfvG/+v/k4szYVpJPsjCAsA8OAr4Xi7qVU7Ab+zFf2NXsB9hOdFJdz6k8jrBfEcWjtgr7IaUJ1/7dvV7/yuww7OzLXoKwlKMXU4knmhubJP3loapI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757968211; c=relaxed/simple;
	bh=ewsJfVOdOzhQ5sDcyX2yrdZZqXvLSqk7T/YvUBJhXIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hudKMb9V79qzuY9ql+joE5Xc+obRDMJ4IoY4sAQD4h20+YwOhYwpYfyM5bLip94zUJHAjMsxKWl25FxKAVXy1F57FvGYOKBj4NziIZfqzolksxkw45W3DWF0glb10wuIG82OvTDVrHT01+4sUixC+0C8guuJpAjZkUonqsUjz34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNrNKNRu; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNrNKNRu"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-32be6bc21c7so3497943fac.3
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 13:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757968208; x=1758573008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRImoucyz4sqFhYjjvdfJUNqTZqNvUmE9qm8ACHzRog=;
        b=fNrNKNRukl9u7l2vMu31zWQy7EKQpJ4m2/y2GCEakAaBAzmt5CpiZcumSdXKHTc+Dg
         kKdRgktlX/UQfcTJW3Z8ZO2UzzwtbBpyoouXYqd7mcCsmjWlecLz4bhnmQcFR0MQ24RH
         R4OC6+y5Y6rK5z6vTJrYWfTEgr1A5v09zrCH75ab1B7exFPtDBwB19etydC3qACSBRcP
         W6XkA/ldJsicoKMQYiXefZuIq5KoI42qRxDr+PlKIBuY3eAla/OPFlAAosWUwCzPxPl3
         Ojp6LV68jJ8UcH1nH8UFzmnB3UjkT0c0zhNTMBL+716SDIVZoRWsHqHL5YI1oi6y+O+V
         b5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757968208; x=1758573008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRImoucyz4sqFhYjjvdfJUNqTZqNvUmE9qm8ACHzRog=;
        b=Qa+6IqRThSaFLRTwXi0sBzLcHZbCHe+hFhh710qJDWFE2VIExxY1iHwZto6bXib7X0
         WbRgesMDevBlrFUuEyo+Sw9ngAHDwQLiXNKlvDbo0aQ5oglOQSYp6n/c0PmYuIj0WczR
         ISRMvQlYP8AmXaaYQqO4FXiaBCCuX+u82mqsjk9y7SbRc6evNBD0hhbGp/MyjMVFDuNd
         +t3XIQw9gDhm+m7nq78mTLwNrLwfCGDBkFtMTKET6mUSMAuF53io3h4pWSvLmgUn8qsi
         UmL6ao1olWO7Wdz44Vy50OufWvLaCOaqVFw8/esgsymgX/00VIKgwnelEb1oF0wHeleR
         AB9Q==
X-Gm-Message-State: AOJu0YyhPMfsUMcqJhGyUX+XhhOxaBWGX5bNgF9v1lQSzpn/oGsatjnC
	vyGjgEenDXu8zywNYmL18ibXfgb5Sb21O7LgBltYXjLlpix2snTyPi+daU0vDA==
X-Gm-Gg: ASbGncviLnR5bvbcDheOBDDnPAL4w6K+To4byGH9rVE2a0+1zgBQ82kNWVxgyVP6p2A
	e3z6noO1pKfnMI6kE0FMovw2n1rwHLRK28v/PsYmXwO+Hdz13rAXHI82sQ09VDq5nP46qnkiUd5
	m+EfAIsfWPjTCFCswVnJBs3Ifk0awFyVRumEl81xramzjYGz+aov4qNjADmTDMmCJzofrewTMYM
	DUmA7NPxDqHb0yifgAkvXeNZkXY32ueTiPqAUMWmI2OHoOMJ9wyHhR/aDsNpCuo1YomZd4O443X
	4d0vWwIEeda63JT22jrh5X3UGEuq02dIEDv+lzTaEKvbZb35ub7aYkK2BB32aRCjLlSOUpNEoWq
	4luzvo0jbKTY2fgUgjSN3ZxtimUyOudc=
X-Google-Smtp-Source: AGHT+IGEiRLNSwD6FS4J+MDIKAnK0dCQOKR3/taSdfGsQ3MSovk0KWEoegm5RjblfxCy7fPLbptTXg==
X-Received: by 2002:a05:6870:891d:b0:2ff:a399:c0fc with SMTP id 586e51a60fabf-32e54779084mr7045245fac.5.1757968207726;
        Mon, 15 Sep 2025 13:30:07 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524c260735sm3114325a34.39.2025.09.15.13.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 13:30:07 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 0/6] odb: add transaction interfaces to ODB subsystem
Date: Mon, 15 Sep 2025 15:29:50 -0500
Message-ID: <20250915202956.3784935-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250909191134.555689-1-jltobler@gmail.com>
References: <20250909191134.555689-1-jltobler@gmail.com>
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

Note I've opted to leave transaction handling in git-update-index(1) the
same as the previous version as sorting out the quirky options parsing
behavior is probably out of scope for this change.

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
 cache-tree.c             |  12 +-
 meson.build              |   1 -
 object-file.c            | 409 ++++++++++++++++++++++++++++++++++++++-
 object-file.h            |  17 ++
 odb.c                    |  10 +
 odb.h                    |  14 ++
 read-cache.c             |  10 +-
 13 files changed, 478 insertions(+), 501 deletions(-)
 delete mode 100644 bulk-checkin.c
 delete mode 100644 bulk-checkin.h

Range-diff against v1:
1:  d5a3035a00 ! 1:  217f3eb6d2 bulk-checkin: remove ODB transaction nesting
    @@ Commit message
         optimized via ODB transactions without having to worry if a transaction
         has already been started or not. This can make the interface a bit
         awkward to use, as calling {begin,end}_odb_transaction() does not
    -    guarantee that a transaction is actually started or ended.
    +    guarantee that a transaction is actually started or ended. Thus, in
    +    situations where a transaction must be explicitly flushed,
    +    flush_odb_transaction() must be used.
     
    -    Instead, be more explicit and require callers who use ODB transactions
    -    internally to ensure there is not already a pending transaction before
    -    beginning or ending a transaction.
    +    To better clarify ownership sematics around a transaction and further
    +    remove the need for flush_odb_transaction() as part of the transaction
    +    interface, instead be more explicit and require callers who use ODB
    +    transactions internally to ensure there is not already a pending
    +    transaction before beginning or ending a transaction.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
    @@ bulk-checkin.c: void flush_odb_transaction(struct odb_transaction *transaction)
     -	transaction->nesting -= 1;
     -
     -	if (transaction->nesting)
    --		return;
    --
    ++	if (!transaction)
    + 		return;
    + 
    ++	/*
    ++	 * Ensure the transaction ending matches the pending transaction.
    ++	 */
    ++	ASSERT(transaction == transaction->odb->transaction);
    ++
      	flush_odb_transaction(transaction);
      	transaction->odb->transaction = NULL;
      	free(transaction);
    @@ cache-tree.c: int cache_tree_update(struct index_state *istate, int flags)
     +
      	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
      		       "", 0, &skip, flags);
    --	end_odb_transaction(transaction);
     +
    -+	if (transaction)
    -+		end_odb_transaction(transaction);
    + 	end_odb_transaction(transaction);
     +
      	trace2_region_leave("cache_tree", "update", the_repository);
      	trace_performance_leave("cache_tree_update");
    @@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
     +		ret = index_blob_bulk_checkin(the_repository->objects->transaction,
      					      oid, fd, xsize_t(st->st_size),
      					      path, flags);
    --		end_odb_transaction(transaction);
     +
    -+		if (transaction)
    -+			end_odb_transaction(transaction);
    + 		end_odb_transaction(transaction);
      	}
      
    - 	close(fd);
     
      ## read-cache.c ##
     @@ read-cache.c: int add_files_to_cache(struct repository *repo, const char *prefix,
    @@ read-cache.c: int add_files_to_cache(struct repository *repo, const char *prefix
     +		transaction = begin_odb_transaction(repo->objects);
     +
      	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
    --	end_odb_transaction(transaction);
     +
    -+	if (transaction)
    -+		end_odb_transaction(transaction);
    + 	end_odb_transaction(transaction);
      
      	release_revisions(&rev);
    - 	return !!data.add_errors;
2:  6d9cb6c9f7 ! 2:  16af9f1169 builtin/update-index: end ODB transaction when --verbose is specified
    @@ Commit message
         object directory and migrated to the primary object database upon
         transaction commit.
     
    -    When the --verbose option is specified, each individual object is
    +    When the --verbose option is specified, each of the following objects is
         explicitly flushed via flush_odb_transaction() prior to reporting the
         update. Flushing the object database transaction migrates pending
         objects to the primary object database without marking the transaction
    @@ Commit message
         git-update-index(1) callers using the --verbose option and that rely on
         parsing verbose output to know when objects are written.
     
    -    As soon as verbose output is requested in git-update-index(1), all
    +    Due to how git-update-index(1) parses options, each filename argument is
    +    evaluated with only the set of options that precede it. Therefore, it is
    +    possible for an initial set of objects to be written in a transaction
    +    before a --verbose option is encountered.
    +
    +    As soon as the --verbose option is parsed in git-update-index(1), all
         subsequent object writes are flushed prior to being reported and thus no
         longer benefit from being transactional. Furthermore, the mechanism to
         flush a transaction without committing is rather awkward. Drop the call
    @@ builtin/update-index.c: int cmd_update_index(int argc,
      			setup_work_tree();
      			p = prefix_path(prefix, prefix_length, path);
      			update_one(p);
    -@@ builtin/update-index.c: int cmd_update_index(int argc,
    - 	/*
    - 	 * By now we have added all of the new objects
    - 	 */
    --	end_odb_transaction(transaction);
    -+	if (transaction)
    -+		end_odb_transaction(transaction);
    - 
    - 	if (split_index > 0) {
    - 		if (repo_config_get_split_index(the_repository) == 0)
3:  9b290c72fa ! 3:  ae6199a3c8 bulk-checkin: drop flush_odb_transaction()
    @@ bulk-checkin.c: struct odb_transaction *begin_odb_transaction(struct object_data
      }
      
     -void flush_odb_transaction(struct odb_transaction *transaction)
    -+void end_odb_transaction(struct odb_transaction *transaction)
    - {
    +-{
     -	if (!transaction)
     -		return;
     -
    - 	flush_batch_fsync(transaction);
    - 	flush_bulk_checkin_packfile(transaction);
    +-	flush_batch_fsync(transaction);
    +-	flush_bulk_checkin_packfile(transaction);
     -}
     -
    --void end_odb_transaction(struct odb_transaction *transaction)
    --{
    + void end_odb_transaction(struct odb_transaction *transaction)
    + {
    + 	if (!transaction)
    +@@ bulk-checkin.c: void end_odb_transaction(struct odb_transaction *transaction)
    + 	 */
    + 	ASSERT(transaction == transaction->odb->transaction);
    + 
     -	flush_odb_transaction(transaction);
    ++	flush_batch_fsync(transaction);
    ++	flush_bulk_checkin_packfile(transaction);
      	transaction->odb->transaction = NULL;
      	free(transaction);
      }
4:  390a4e177e ! 4:  01f5485441 object-file: relocate ODB transaction code
    @@ bulk-checkin.c (deleted)
     -
     -void end_odb_transaction(struct odb_transaction *transaction)
     -{
    +-	if (!transaction)
    +-		return;
    +-
    +-	/*
    +-	 * Ensure the transaction ending matches the pending transaction.
    +-	 */
    +-	ASSERT(transaction == transaction->odb->transaction);
    +-
     -	flush_batch_fsync(transaction);
     -	flush_bulk_checkin_packfile(transaction);
     -	transaction->odb->transaction = NULL;
    @@ object-file.c: int read_loose_object(struct repository *repo,
     +
     +void end_odb_transaction(struct odb_transaction *transaction)
     +{
    ++	if (!transaction)
    ++		return;
    ++
    ++	/*
    ++	 * Ensure the transaction ending matches the pending transaction.
    ++	 */
    ++	ASSERT(transaction == transaction->odb->transaction);
    ++
     +	flush_batch_fsync(transaction);
     +	flush_bulk_checkin_packfile(transaction);
     +	transaction->odb->transaction = NULL;
5:  cad54137b7 ! 5:  333319a63d object-file: update naming from bulk-checkin
    @@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
     +						      xsize_t(st->st_size),
     +						      path, flags);
      
    - 		if (transaction)
    - 			end_odb_transaction(transaction);
    -@@ object-file.c: struct odb_transaction *begin_odb_transaction(struct object_database *odb)
    + 		end_odb_transaction(transaction);
    + 	}
    +@@ object-file.c: void end_odb_transaction(struct odb_transaction *transaction)
    + 	 */
    + 	ASSERT(transaction == transaction->odb->transaction);
      
    - void end_odb_transaction(struct odb_transaction *transaction)
    - {
     -	flush_batch_fsync(transaction);
     -	flush_bulk_checkin_packfile(transaction);
     +	flush_loose_object_transaction(transaction);
6:  b74fe6c392 ! 6:  30759bbd0d odb: add transaction interface
    @@ Commit message
     
         Update call sites to instead manage transactions through the odb
         subsystem. Also rename {begin,end}_odb_transaction() functions to
    -    object_file_transaction_{begin,end}() to clarify the object source it
    +    object_file_transaction_{begin,commit}() to clarify the object source it
         supports.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
    @@ builtin/update-index.c: int cmd_update_index(int argc,
      			}
      
     @@ builtin/update-index.c: int cmd_update_index(int argc,
    + 	/*
      	 * By now we have added all of the new objects
      	 */
    - 	if (transaction)
    --		end_odb_transaction(transaction);
    -+		odb_transaction_commit(transaction);
    +-	end_odb_transaction(transaction);
    ++	odb_transaction_commit(transaction);
      
      	if (split_index > 0) {
      		if (repo_config_get_split_index(the_repository) == 0)
    @@ cache-tree.c: int cache_tree_update(struct index_state *istate, int flags)
      	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
      		       "", 0, &skip, flags);
      
    - 	if (transaction)
    --		end_odb_transaction(transaction);
    -+		odb_transaction_commit(transaction);
    +-	end_odb_transaction(transaction);
    ++	odb_transaction_commit(transaction);
      
      	trace2_region_leave("cache_tree", "update", the_repository);
      	trace_performance_leave("cache_tree_update");
    @@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
      
      		ret = index_blob_packfile_transaction(the_repository->objects->transaction,
      						      oid, fd,
    -@@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
    + 						      xsize_t(st->st_size),
      						      path, flags);
      
    - 		if (transaction)
    --			end_odb_transaction(transaction);
    -+			odb_transaction_commit(transaction);
    +-		end_odb_transaction(transaction);
    ++		odb_transaction_commit(transaction);
      	}
      
      	close(fd);
    @@ object-file.c: int read_loose_object(struct repository *repo,
      }
      
     -struct odb_transaction *begin_odb_transaction(struct object_database *odb)
    -+struct odb_transaction *object_file_transaction_begin(struct object_database *odb)
    ++struct odb_transaction *object_file_transaction_begin(struct odb_source *source)
      {
    ++	struct object_database *odb = source->odb;
    ++
      	if (odb->transaction)
      		BUG("ODB transaction already started");
    + 
     @@ object-file.c: struct odb_transaction *begin_odb_transaction(struct object_database *odb)
      	return odb->transaction;
      }
      
     -void end_odb_transaction(struct odb_transaction *transaction)
    -+void object_file_transaction_end(struct odb_transaction *transaction)
    ++void object_file_transaction_commit(struct odb_transaction *transaction)
      {
    - 	flush_loose_object_transaction(transaction);
    - 	flush_packfile_transaction(transaction);
    + 	if (!transaction)
    + 		return;
     
      ## object-file.h ##
     @@ object-file.h: struct odb_transaction;
    @@ object-file.h: struct odb_transaction;
      /*
       * Tell the object database to optimize for adding
     - * multiple objects. end_odb_transaction must be called
    -+ * multiple objects. object_file_transaction_end must be called
    ++ * multiple objects. object_file_transaction_commit must be called
       * to make new objects visible. Only a single transaction
       * can be pending at a time and must be ended before
       * beginning another.
       */
     -struct odb_transaction *begin_odb_transaction(struct object_database *odb);
    -+struct odb_transaction *object_file_transaction_begin(struct object_database *odb);
    ++struct odb_transaction *object_file_transaction_begin(struct odb_source *source);
      
      /*
       * Tell the object database to make any objects from the
       * current transaction visible.
       */
     -void end_odb_transaction(struct odb_transaction *transaction);
    -+void object_file_transaction_end(struct odb_transaction *transaction);
    ++void object_file_transaction_commit(struct odb_transaction *transaction);
      
      #endif /* OBJECT_FILE_H */
     
    @@ odb.c: void odb_clear(struct object_database *o)
     +
     +struct odb_transaction *odb_transaction_begin(struct object_database *odb)
     +{
    -+	return object_file_transaction_begin(odb);
    ++	return object_file_transaction_begin(odb->sources);
     +}
     +
     +void odb_transaction_commit(struct odb_transaction *transaction)
     +{
    -+	object_file_transaction_end(transaction);
    ++	object_file_transaction_commit(transaction);
     +}
     
      ## odb.h ##
    @@ odb.h: struct object_database {
      struct object_database *odb_new(struct repository *repo);
      void odb_clear(struct object_database *o);
      
    ++/*
    ++ * Starts an ODB transaction. Subsequent objects are written to the transaction
    ++ * and not committed until odb_transaction_commit() is invoked on the
    ++ * transaction. Caller are responsible to ensure there is only a single ODB
    ++ * transaction pending at a time.
    ++ */
     +struct odb_transaction *odb_transaction_begin(struct object_database *odb);
    ++
    ++/*
    ++ * Commits an ODB transaction making the written objects visible. If the
    ++ * specified transaction is NULL, the function is a no-op.
    ++ */
     +void odb_transaction_commit(struct odb_transaction *transaction);
     +
      /*
    @@ read-cache.c: int add_files_to_cache(struct repository *repo, const char *prefix
      
      	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
      
    - 	if (transaction)
    --		end_odb_transaction(transaction);
    -+		odb_transaction_commit(transaction);
    +-	end_odb_transaction(transaction);
    ++	odb_transaction_commit(transaction);
      
      	release_revisions(&rev);
      	return !!data.add_errors;
-- 
2.51.0.193.g4975ec3473b

