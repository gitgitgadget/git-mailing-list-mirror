Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000EA2ECD1D
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933642; cv=none; b=RdPtOngmFzLLldK6yJxFF+y3QC5AWnsUHwnDRLcUUHwPF908ImVW9Xzfr0PEKqgYR9B3azF5Cqz58LA1pAfYOXtvsw4vYBrFViOQTDYYN4zkvpDSCO9smofVYnbxkRkdwFxHNods9FlZCeqPHYdGz6EGANaahdYlHYrMDqvsmWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933642; c=relaxed/simple;
	bh=5v9tdKtT7b90bczl/8xAlO/hNWEb/CgYOuQMMyMiuBk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=h9AY3fP2oN1wHUyunJdcrMTTTG7Zv7cd1rJpOKkU5UMONRDW9f55oWKJetJBBc7yk1KlR314Ex01JtWieipNqrAvAL4IyL7UliHjCvyndzJHh3mEXnLc7pc/0No4PP1TbrCNbspBuY46h7aPwexLJmoaWwdi/Hw7UZ2PZDckCs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p+6WQn3h; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+6WQn3h"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso65745375e9.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 01:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776933639; x=1777538439; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zVmhpv1uDySH/HF2oJCr3MI4w0l62FqeQ8MOjLisfys=;
        b=p+6WQn3hhgqo0nr6Gs5cnUyEhykXM3WAbW9j9epypnrpusdboCIPJSm3nIS4QRwPwn
         K9HeTqvy8ai7EZ2QxO+fHcaEKYBs1niBAY5cLek5kz72e+EzojfJykkSBtSOQyQtaFBd
         AfRCiIOurFUwSV4ECKYSHsjDlA8a/0PLa0Kfh1w3IQiSVJj6oq4e1O1Cf85tzH/JKnbj
         di9ltulLLg0PQ2BdeXQDaKpkUd/kCOXjjpOiyt+b7zA+Me+wBXI1TLIWI9r+z22G/vfy
         30+jUucXjl5AtYkZ1kcQ6tDuRUA4rjDS/vR7O1jlF5gKCZT++R3XsWbpc7vWeKNKTtB8
         erHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776933639; x=1777538439;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVmhpv1uDySH/HF2oJCr3MI4w0l62FqeQ8MOjLisfys=;
        b=CnlKWbTWzsyYdVxVzgTJjQl4IalT/QpidgFv6W9yiP4mlrWO8d/9Zte+0iGUpctK1X
         N9pti5PKvcruL3N2O0qll3TuNhfF9p5h9AcrewWT2Gu16M3wQIPCs3HxOZ+GL0UWgths
         f/l6mzNI5X7M/y5UbiqbvReNpzGRZuchxf17hFWMs8Ca9wNk2EMa6wJTaNO0wRmhB4YC
         AOr41uxNaVh8h3mL2jT9EvvTVd8tX9S8NosLuPHMkilpVgr+lsGsxQeLg4ytGKAIxsSz
         wWemNoTIx7Z7JDLGm9giAZYO1ft7Ns3qV+NVTtTg5x5U4EIicCHz8pK8Z8BDDMWwiNnY
         nKLA==
X-Gm-Message-State: AOJu0YxYol5wk7BrpRYsGrU9v3vkSn383b4RHr0dHhUMt9ylzjcUCfsi
	cI/E/E0s03/i3/UQDO7mQQ6qbCNvfQLICQREopZKMiNfHa+uI9bu8RpyOjKfrQ==
X-Gm-Gg: AeBDievl/v0kEwtcI24MzGJGkTZRuqPqAXy7WNjAd79qOp035yfcgBeP39PjaHFIO3d
	+oeLtqK/o+3EoJ9e/wY9Vc+viL7J5v9FAnkhiLdhr45HDqQ4cRJ++UivFO/MMu1DfiFMSkZJOMa
	qBqiS1LZFcrKtkQj/ldEWzEDNx9xdNNy2fcfw3aY2tPYLG+vpZb3hHiQ1m51ivGRGxUDLo7uy16
	SjzWt4quxGgSrwJSm1Et3BQp1Apdqqd2EVGM9tqrtFqABpKvgRHae7ZMRESltASMpAsqS/nuzFb
	0NTOvy8O8xfiw4F0YH4QcEe51nc74AW9I9VPvl7kgUpScHdi0lj9Pep4AKuR3kAJ2eAX+nF2MFV
	X3yjAdvliQKTcmdVHcT39nDL8f2FwrMbOZLUbQUTFJilrj/QpcAY0C3p1F1iXFSbDElMpBs+vqc
	ojbAIH4luyUzfzUI0BpHrD6GeUzJzCgja0vN57FPIJ
X-Received: by 2002:a05:600c:3e1a:b0:489:1ca2:eafd with SMTP id 5b1f17b1804b1-4891ca2ee65mr228463055e9.11.1776933638776;
        Thu, 23 Apr 2026 01:40:38 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1cda:f096:cc8c:a0e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489fec8f7cbsm234286785e9.11.2026.04.23.01.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:40:38 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/9] refs: move some of the generic logic out of the
 backends
Date: Thu, 23 Apr 2026 10:40:29 +0200
Message-Id: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP7a6WkC/32NQQ6CMBBFr0Jm7Zi2UGpceQ/DAuoAY4SaFhsJ4
 e4WdO3yJe+/v0AgzxTgnC3gKXJgNyZQhwxsX48dId8SgxKqFIU06KkNOLhIODnsaExzi496Jo+
 t0UpbTSdTFpACz+Tye49fqy+HV3MnO23Fzeg5TM7P+3uUm/c7UuLfUZQoUMuccl20uSmbSzfU/
 DhaN0C1rusHTl9ZY9YAAAA=
X-Change-ID: 20260417-refs-move-to-generic-layer-f7525c5e8764
In-Reply-To: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
References: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13883;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=5v9tdKtT7b90bczl/8xAlO/hNWEb/CgYOuQMMyMiuBk=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnp2wLcalMtOsKj3V7vxgesqjyb4lz34NxM7
 Ul9lZ6MLNme7okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp6dsCAAoJED7VnySO
 Rox/nrML/jaQeDB3p9VXb8azVlG9fSCNEdYr90HJLyYbyBPAos6X7Ql9t8LznLF7Duy2bKVWErC
 AIcdaKzc57bnZpIz8RZV2z9C+cOvCjR9vbZ6lj9Gy3IYa5Ky8wnHez9GowU5RNAcqNDzI8zfKBn
 TwPJrpxB1iDj/7MWmKIFmCfijoHnYo9eyrGUpo39/GF9w79DPPTGfGBqnUNeeUEMDF//qusXVI2
 qgMxQeJaBASSP84/mp7Sij4nV2wxY3qcHyuG7x9a/b2QQjWW9LZz6JJ4r07nYJ+invSXVymzytz
 H5HMDxxkHIoIU/XqltJEPYLFzK+Q//Fx54h6YNboUAZvMkEM7jPZIXQg4qBJHQNVK7rp+WGisyH
 lSltH6sm8aJDXn7LudBRIF+1AOkxrn4UBHE5kzNtRSMeuvo+IwRt3ldCh06w9WUJ5IrxoeuTZVU
 ACJPnMVc/JfeeyKm/FShCRj00h6wmg3bawqWBZFslOR5Fl+7v8terR3vngXoNuHWH9gdN5Lj5Y9
 vQ=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

This series came together while I was working on other reference related
code and realized that some of the individual logic implemented with the
reference backends can be moved to the generic layer.

Moving code to the generic layer, simplifies the responsibility of
individual backends and avoids deviation in logic between the backends.

The biggest changes are related to moving out usage of `parse_object()`
and `peel_object()` from reference transactions. The former is used to
validate that the OID provided points to a commit object. The latter is
an optimization technique where the packed/reftable backend store the
peeled OID whenever available, so reading such references provides the
peeled OID without having to call the ODB.

Moving object parsing to the generic layout involves moving it out of
the prepare stage of the transaction and into `ref_transaction_update()`
where every added update is checked. As such, this also involves
modifying update-ref(1) and receive-pack(1) to follow this paradigm.

---
Changes in v2:
- Split the second commit into two: one introducing
  `ref_store_init_options` and the second to use it for reflog config.
- Use opts as the variable name consistently.
- A bunch of grammar fixes.
- Link to v1: https://patch.msgid.link/20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com

---
 builtin/receive-pack.c  |  22 +++++---
 builtin/update-ref.c    | 145 +++++++++++++++++++++++++++++++-----------------
 refs.c                  |  60 +++++++++++++++-----
 refs.h                  |  16 +++---
 refs/files-backend.c    |  58 +++++++------------
 refs/packed-backend.c   |  10 ++--
 refs/packed-backend.h   |   3 +-
 refs/refs-internal.h    |  35 ++++++++++--
 refs/reftable-backend.c |  40 +++----------
 9 files changed, 225 insertions(+), 164 deletions(-)

Karthik Nayak (9):
      refs: remove unused typedef 'ref_transaction_commit_fn'
      refs: introduce `ref_store_init_options`
      refs: extract out reflog config to generic layer
      refs: return `ref_transaction_error` from `ref_transaction_update()`
      update-ref: move `print_rejected_refs()` up
      update-ref: handle rejections while adding updates
      refs: move object parsing to the generic layer
      refs: add peeled object ID to the `ref_update` struct
      refs: use peeled tag values in reference backends

Range-diff versus v1:

 1:  bbcc7bff38 =  1:  807f23ee66 refs: remove unused typedef 'ref_transaction_commit_fn'
 2:  57a66ae8d5 !  2:  f63583d8b0 refs: extract out reflog config to generic layer
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    refs: extract out reflog config to generic layer
    +    refs: introduce `ref_store_init_options`
     
    -    The reference backends need to know when to create reflog entries, this
    -    is dictated by the 'core.logallrefupdates' config. Instead of relying on
    -    the backends to call `repo_settings_get_log_all_ref_updates()` to obtain
    -    this config value, let's do this in the generic layer and pass down the
    -    value to the backends.
    +    Reference backends are initiated via the `init()` function. When
    +    initiating the function, the backend is also provided flags which denote
    +    the access levels of the initiator. Create a new structure
    +    `ref_store_init_options` to house such options and move the access flags
    +    to this structure.
     
    -    Instead of passing this in as a new argument, let's create a new
    -    `ref_init_options` structure which will house information required to
    -    initialize a reference backend. Move the access flags here as well.
    +    This allows easier extension of providing further options to the
    +    backends. In the following commit, we'll also provide config around
    +    reflog creation to the backends via the same structure.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ refs.c: static struct ref_store *ref_store_init(struct repository *repo,
      {
      	const struct ref_storage_be *be;
      	struct ref_store *refs;
    -+	struct ref_store_init_options options = {
    ++	struct ref_store_init_options opts = {
     +		.access_flags = flags,
    -+		.log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo),
     +	};
      
      	be = find_ref_storage_backend(format);
    @@ refs.c: static struct ref_store *ref_store_init(struct repository *repo,
      	 * allow the backend to handle how it wants to deal with worktrees.
      	 */
     -	refs = be->init(repo, repo->ref_storage_payload, gitdir, flags);
    -+	refs = be->init(repo, repo->ref_storage_payload, gitdir, &options);
    ++	refs = be->init(repo, repo->ref_storage_payload, gitdir, &opts);
     +
      	return refs;
      }
    @@ refs/files-backend.c: static void clear_loose_ref_cache(struct files_ref_store *
      					      const char *payload,
      					      const char *gitdir,
     -					      unsigned int flags)
    -+					      const struct ref_store_init_options *options)
    ++					      const struct ref_store_init_options *opts)
      {
      	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
      	struct ref_store *ref_store = (struct ref_store *)refs;
    @@ refs/files-backend.c: static struct ref_store *files_ref_store_init(struct repos
      	refs->gitcommondir = strbuf_detach(&ref_common_dir, NULL);
      	refs->packed_ref_store =
     -		packed_ref_store_init(repo, NULL, refs->gitcommondir, flags);
    --	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
    -+		packed_ref_store_init(repo, payload, refs->gitcommondir, options);
    -+	refs->store_flags = options->access_flags;
    -+	refs->log_all_ref_updates = options->log_all_ref_updates;
    ++		packed_ref_store_init(repo, payload, refs->gitcommondir, opts);
    ++	refs->store_flags = opts->access_flags;
    + 	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
     +
      	repo_config_get_bool(repo, "core.prefersymlinkrefs", &refs->prefer_symlink_refs);
      
    @@ refs/packed-backend.c: static size_t snapshot_hexsz(const struct snapshot *snaps
      					const char *payload UNUSED,
      					const char *gitdir,
     -					unsigned int store_flags)
    -+					const struct ref_store_init_options *options)
    ++					const struct ref_store_init_options *opts)
      {
      	struct packed_ref_store *refs = xcalloc(1, sizeof(*refs));
      	struct ref_store *ref_store = (struct ref_store *)refs;
    @@ refs/packed-backend.c: static size_t snapshot_hexsz(const struct snapshot *snaps
      
      	base_ref_store_init(ref_store, repo, gitdir, &refs_be_packed);
     -	refs->store_flags = store_flags;
    -+	refs->store_flags = options->access_flags;
    ++	refs->store_flags = opts->access_flags;
      
      	strbuf_addf(&sb, "%s/packed-refs", gitdir);
      	refs->path = strbuf_detach(&sb, NULL);
    @@ refs/refs-internal.h: struct ref_store;
     +struct ref_store_init_options {
     +	/* The kind of operations that the ref_store is allowed to perform. */
     +	unsigned int access_flags;
    -+
    -+	/*
    -+	 * Denotes under what conditions reflogs should be created when updating
    -+	 * references.
    -+	 */
    -+	enum log_refs_config log_all_ref_updates;
     +};
     +
      /*
    @@ refs/refs-internal.h: struct ref_store;
      					    const char *payload,
      					    const char *gitdir,
     -					    unsigned int flags);
    -+					    const struct ref_store_init_options *options);
    ++					    const struct ref_store_init_options *opts);
      /*
       * Release all memory and resources associated with the ref store.
       */
    @@ refs/reftable-backend.c: static int reftable_be_config(const char *var, const ch
      					  const char *payload,
      					  const char *gitdir,
     -					  unsigned int store_flags)
    -+					  const struct ref_store_init_options *options)
    ++					  const struct ref_store_init_options *opts)
      {
      	struct reftable_ref_store *refs = xcalloc(1, sizeof(*refs));
      	struct strbuf ref_common_dir = STRBUF_INIT;
    @@ refs/reftable-backend.c: static struct ref_store *reftable_be_init(struct reposi
      	base_ref_store_init(&refs->base, repo, refdir.buf, &refs_be_reftable);
      	strmap_init(&refs->worktree_backends);
     -	refs->store_flags = store_flags;
    --	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
    -+	refs->store_flags = options->access_flags;
    -+	refs->log_all_ref_updates = options->log_all_ref_updates;
    + 	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
    ++	refs->store_flags = opts->access_flags;
      
      	switch (repo->hash_algo->format_id) {
      	case GIT_SHA1_FORMAT_ID:
 -:  ---------- >  3:  15fd026e85 refs: extract out reflog config to generic layer
 3:  1c05642914 !  4:  a389011125 refs: return `ref_transaction_error` from `ref_transaction_update()`
    @@ Commit message
     
         The `ref_transaction_update()` function is used to add updates to a
         given reference transactions. In the following commit, we'll add more
    -    validation to this function. As such, it would be more beneficial if the
    +    validation to this function. As such, it would be beneficial if the
         function returns specific error types, so callers can differentiate
         between different errors.
     
 4:  6d9544a834 !  5:  3a203ace83 update-ref: move `print_rejected_refs()` up
    @@ Metadata
      ## Commit message ##
         update-ref: move `print_rejected_refs()` up
     
    -    The `print_rejected_refs()` is used to print any rejected refs when
    -    using git-updated-ref(1) with the '--batch-updates' option. In the
    -    following commit, we'll need to use this function in other places, so
    +    The `print_rejected_refs()` function is used to print any rejected refs
    +    when using git-updated-ref(1) with the '--batch-updates' option. In the
    +    following commit, we'll need to use this function in another place, so
         move the function up to avoid a separate forward declaration.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
 5:  fd3b66ec45 !  6:  e6b2c7b523 update-ref: handle rejections while adding updates
    @@ Commit message
     
         When using git-update-ref(1) with the '--batch-updates' flag, updates
         rejected by the reference backend are displayed to the user while other
    -    updates are applied. This only applies during the committing of the
    +    updates are applied. This only applies during the commit phase of the
         transaction.
     
         In the following commits, we'll also extend `ref_transaction_update()`
    -    to reject updates before even a transaction is prepared/committed. In
    +    to reject updates before a transaction is prepared/committed. In
         preparation, modify the code in update-ref to also handle non-generic
         rejections from `ref_transaction_update()`. This involves propagating
         information to each of the commands on whether updates are allowed to be
    @@ builtin/update-ref.c: static void parse_cmd_update(struct ref_transaction *trans
     +					msg, &err);
     +
     +	if (tx_err && tx_err != REF_TRANSACTION_ERROR_GENERIC &&
    -+	    opts->allow_update_failures)
    ++	    opts->allow_update_failures) {
     +		print_rejected_refs(refname, have_old ? &old_oid : NULL,
     +				    &new_oid, NULL, NULL, tx_err, err.buf,
     +				    NULL);
    -+	else if (tx_err)
    ++	} else if (tx_err) {
      		die("%s", err.buf);
    ++	}
      
      	update_flags = default_flags;
    + 	free(refname);
     @@ builtin/update-ref.c: static void parse_cmd_update(struct ref_transaction *transaction,
      }
      
    @@ builtin/update-ref.c: static void parse_cmd_symref_update(struct ref_transaction
     +					msg, &err);
     +
     +	if (tx_err && tx_err != REF_TRANSACTION_ERROR_GENERIC &&
    -+	    opts->allow_update_failures)
    ++	    opts->allow_update_failures) {
     +		print_rejected_refs(refname, have_old_oid ? &old_oid : NULL,
     +				    NULL, have_old_oid ? NULL : old_target,
     +				    new_target, tx_err, err.buf, NULL);
    -+	else if (tx_err)
    ++	} else if (tx_err) {
      		die("%s", err.buf);
    ++	}
      
      	update_flags = default_flags;
    + 	free(refname);
     @@ builtin/update-ref.c: static void parse_cmd_symref_update(struct ref_transaction *transaction,
      }
      
 6:  3be9566bf9 !  7:  36a6284ac1 refs: move object parsing to the generic layer
    @@ Commit message
         refs: move object parsing to the generic layer
     
         Regular reference updates made via reference transactions validate that
    -    the provided object ID exists in the object database, this is done by
    +    the provided object ID exists in the object database, which is done by
         calling 'parse_object()'. This check is done independently by the
    -    backends.
    +    backends which leads to duplicated logic.
     
         Let's move this to the generic layer, ensuring the backends only have to
         care about reference storage and not about validation of the object IDs.
 7:  5e6a26567a =  8:  32f3bc52f1 refs: add peeled object ID to the `ref_update` struct
 8:  27914d0556 =  9:  bbcdbd3d18 refs: use peeled tag values in reference backends


base-commit: f65aba1e87db64413b6d1ed5ae5a45b5a84a0997
change-id: 20260417-refs-move-to-generic-layer-f7525c5e8764

Thanks
- Karthik

