Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077E04A21
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743074015; cv=none; b=cFZlsYfKjpijey1j0T2tZqw/jj1XbobRjUPuS+75dxZEePeRXHn/sWPsA9J0CW81R0W1d0VjArC/1cHdLhXvJN1liW5a4YpbxNRvDmpn3kMUEyFucjSbr1xwI1caJ5KxA8hHjFevRDPPrmxc6xM6hNuqEKsnBs1hbqBmoakrKvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743074015; c=relaxed/simple;
	bh=Axfp7HH7H5bjSVZF7bYagOqpmAFzWBvU/w0X79T/9m0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=hwy/naNzb0z0MtAvlAsrKBIvZNssAZbzmoe62epxDPkkSkYJvVIoIvhsI9vRGv01B+VH7vF6S4L4nyQNFxkPauU3YY4JEDWo4l4rvjlL1HmRp7flbyeZCdSgaWGtonQ7otp0XPaijzfcS3ac77PBhom1snLJkT7xpIEyRrW8E2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5/PzZnu; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5/PzZnu"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso172074566b.0
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 04:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743074011; x=1743678811; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J63aCL33uHP4S+XPtEmGaUk072I2vdIUH/KuR1uiuCQ=;
        b=K5/PzZnuxSshn8RgVpTg/7vHHcw9HsE0Drm8myzGOAsqShgoK0a1x4oCgc0+Esql/T
         bwKXZgcPZPd5EPt7+0bRd6b/c3D6crvpTVqzW96Bn4dwZ0hH289zNuazY1Tubo+O6fFz
         Ub0307g9X+LUl/2jBMDGsD2wuRqYGY0+Hso/YyD/c1K+yCp7NCV+uhNGIrBB9T6pZ2CQ
         Es7Q450svqcblOBqsK1FrOnpLhfyPSbqyk8qnZgh9/wQMKPYnCEDqrfCFKnMs/xTZR4Z
         K83wQ6OpCg+2w1k75IEob712USGpQtDO+IWfew3K0RSLAz9tIkqEsvLOm5D2ij23nznm
         Woxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743074011; x=1743678811;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J63aCL33uHP4S+XPtEmGaUk072I2vdIUH/KuR1uiuCQ=;
        b=AaKUPJp6sxtH/xawMSEY68K9JWxQbOuJL6Z/wL1/TPgVvLbXKehuh1165YK1Hhvwj2
         gS9RRfASfAiVzvIIdL50ovTqeyGxJFrZdWwUTnTgBfIW6KXw8L78w0siSq1OhRcmmVkx
         KLnQYcrpvKTw+hLXQJ7tQXWj2e0qryPqv5DAHdLU38SYar6OHaarFRuldqDPO5aGOppL
         HzLfdXPrcy+tmjYVzHbVKKlq8r4H1n9B43U62W6Z0INTog0ofm8EmgNsovD3B9VWBLlt
         TKu84/Nnp5zEEKL2w0Th2DL8cePLa2Q/FWcxfRQKOUPg2LTgIbQn7tPCstSv8FZKSw+B
         0D4w==
X-Gm-Message-State: AOJu0Yz4uq+HJbZQ3gSCbzvqGOJMCCUI8Mpd3wSTfbHUvTfuyamp2CLd
	nUUWl43yfNLZ2Nst5Lr9xXU0hjnEZ4SRwEJ32Zwo0DWU5J9xGhqc
X-Gm-Gg: ASbGncs1UiE47RB52Q9LtSHA19vfGTj5GkLjF+CP2HO5C5AH/tUYzdFjQilviHidUTI
	pgp01G9ijuxel5N7wLcTu39x9Ddmnz3y7ynvWtVc5m21norVbQVmh+UKrAg/sqK9fJ0TkY5p8vF
	QYNWbLCxIP8ZApuh8jJgfMwQAF2uFXoRUOr4Ad81i8VVu3U8yITI1hv25ibQ6FVEm6F6YTVIVqt
	N3E2TI6WhkXJZtiOzhg61EDAq5k5Wde1nae89J+mk+dHQioURhJpUQwLISKbiKOG7mzErHFv9RL
	6ijhRnyn1roBNz6ylqeP1MVfiENOIZiU1HyKXkL3YQfMv9s=
X-Google-Smtp-Source: AGHT+IGFZqacOkxqNr5nUqbay5Vf42mTapgpwkuchGc7SSf0BLBjsugSW5LcbzYid7leFxXjOXiPrA==
X-Received: by 2002:a17:907:9410:b0:ac1:ecb5:7207 with SMTP id a640c23a62f3a-ac6faf38f97mr247464166b.29.1743074010730;
        Thu, 27 Mar 2025 04:13:30 -0700 (PDT)
Received: from [127.0.0.2] ([80.242.170.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e56dsm1195866866b.37.2025.03.27.04.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:13:30 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 0/8] refs: introduce support for batched reference
 updates
Date: Thu, 27 Mar 2025 12:13:24 +0100
Message-Id: <20250327-245-partially-atomic-ref-updates-v5-0-4db2a3e34404@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANUy5WcC/43OPW7DMAwF4KsEmquCIiXFztR7FB0Y/SQC7NiQX
 KNB4LtXzlIjSz0+kvgeH6KEnEIRp8ND5DCnkoZbDebtINyVb5cgk69ZIKBWCFaiNnLkPCXuurv
 kaeiTkzlE+T16nkKRbQzNGRogbZyozFiX6edZ8flV8zWVacj3Z+OM63TFDSCa//EZJUgXmZBs0
 xp//Lj0nLp3N/RixWe1AeG4A1QVDJbJthAjEr+C9AcS7PmQKgjO6lDPkYx+BfUGRNgB6gqSd06
 dSSnv2i24LMsvHcK8osMBAAA=
X-Change-ID: 20241206-245-partially-atomic-ref-updates-9fe8b080345c
In-Reply-To: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, phillip.wood123@gmail.com, gitster@pobox.com, 
 ps@pks.im, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13785;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=Axfp7HH7H5bjSVZF7bYagOqpmAFzWBvU/w0X79T/9m0=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGflMtj70ysvk0AiCrxkyK2dHKvGyG2DL6NJj
 yBOK8OhMf/izIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn5TLYAAoJED7VnySO
 Rox/9MgL+gMQzFC36bPI/Don6ZFp5CkxMOLwUVApLER9PS45zSuxu+czVnMvdBVb4RUzSFgIQRO
 BPEMWxVgO5Gehv/RCVLeVkbgUwmMJvzNh60i5ubzrYThe2xPLqI/8pHqBsNk2CNKO78vcmXvbkJ
 L2NqvScUPyrtOgH1pOh4pPfz4VTQ0Pw8mbhVeG9QKnoJfqkEcv5TH+sXSpjxWukHI94vbOulbrn
 Sd82jm8MjOc1SZtLpVCPEUjdEj118ajBTxq92rIRf+DrlEp9tXnlQD3sUz/mkdDKCF78HDBgf5e
 B5dWgPj9VjWi0c5zzzSfVYNCDwnlP9Msz2XdNA5Nv26Bj4dAlR+ppUW6Nk//8i81Ic555/nqAcg
 iEseqgHrfmj12cpcLaBS1nMMhH0ZcJg/7Go9XOvI1vILwgwjgi4t0RHhs1tsDOVztBAfAqnAs3k
 b/MyLUnBIZXIFlxrdcq/pUlG6RHm/3nsubO+MA116BOE2518eq8+nivJ/iTxVLYjQpTphXa/J+6
 wQ=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Git supports making reference updates with or without transactions.
Updates with transactions are generally better optimized. But
transactions are all or nothing. This means, if a user wants to batch
updates to take advantage of the optimizations without the hard
requirement that all updates must succeed, there is no way currently to
do so. Particularly with the reftable backend where batching multiple
reference updates is more efficient than performing them sequentially.

This series introduces support for batched reference updates without
transactions allowing individual reference updates to fail while letting
others proceed. This capability is exposed through git-update-ref's
`--allow-partial` flag, which can be used in `--stdin` mode to batch
updates and handle failures gracefully. Under the hood, these batched
updates still use the transactions infrastructure, while modifying
sections to allow partial failures.

The changes are structured to carefully build up this functionality:

First, we clean up and consolidate the reference update checking logic.
This includes removing duplicate checks in the files backend and moving
refname tracking to the generic layer, which simplifies the codebase and
prepares it for the new feature.

We then restructure the reftable backend's transaction preparation code,
extracting the update validation logic into a dedicated function. This
not only improves code organization but sets the stage for implementing
partial transaction support.

To ensure we only skip errors which are user-oriented, we introduce
typed errors for transactions with 'enum ref_transaction_error'. We
extend the existing errors to include other scenarios and use this new
errors throughout the refs code.

With this groundwork in place, we implement the core batch update
support in the refs subsystem. This adds the necessary infrastructure to
track and report rejected updates while allowing transactions to
proceed. All reference backends are modified to support this behavior
when enabled.

Finally, we expose this functionality to users through
git-update-ref(1)'s `--allow-partial` flag, complete with test coverage
and documentation. The flag is specifically limited to `--stdin` mode
where batching multiple updates is most relevant.

This enhancement improves Git's flexibility in handling reference
updates while maintaining the safety of atomic transactions by default.
It's particularly valuable for tools and workflows that need to handle
reference update failures gracefully without abandoning the entire batch
of updates.

This series is based on top of 683c54c999 (Git 2.49, 2025-03-14) with
Patrick's series 'refs: batch refname availability checks' [1] merged
in.

[1]: https://lore.kernel.org/all/20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im/

---
Changes in v5:
- Inline the comments around the 'ref_transaction_error'.
- Use 'strbuf_reset()' wherever possible instead of 'strbuf_setlen(err, 0)'.
- Use an extra 'conflicting_dirnames' strset in 'refs_verify_refnames_available()' to track
  dirnames which were found to be conflicting, this is to avoid re-reading those dirnames.
- Add curly braces style mismatch in if..else block.
- Link to v4: https://lore.kernel.org/r/20250320-245-partially-atomic-ref-updates-v4-0-3dcc1b311dc9@gmail.com

Changes in v4:
- Rebased on top of 2.49 since there was a long time between the
  previous iteration and we have a new release.
- Changed the naming to say 'batched' updates instead of 'partial
  transactions'. While we still use the transaction infrastructure
  underneath, the new naming causes less ambiguity.
- Clean up some of the commit messages.
- Raise BUG for invalid update index while setting rejections.
- Fix an incorrect early return.
- Link to v3: https://lore.kernel.org/r/20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com

Changes in v3:
- Changed 'transaction_error' to 'ref_transaction_error' along with the
  error names. Removed 'TRANSACTION_OK' since it can potentially be
  missed instead of simply 'return 0'.
- Rename 'ref_transaction_set_rejected' to
  'ref_transaction_maybe_set_rejected' and move logic around error
  checks to within this function.
- Add a new struct 'ref_transaction_rejections' to track the rejections
  within a transaction. This allows us to only iterate over rejected
  updates.
- Add a new commit to also support partial transactions within the
  batched F/D checks.
- Remove NUL delimited outputs in 'git-update-ref(1)'.
- Remove translations for plumbing outputs.
- Other small cleanups in the commit message and code.

Changes in v2:
- Introduce and use structured errors. This consolidates the errors
  and their handling between the ref backends.
- In the previous version, we skipped over all failures. This include
  system failures such as low memory or IO problems. Let's instead, only
  skip user-oriented failures, such as invalid old OID and so on.
- Change the rejection function name to `ref_transaction_set_rejected()`.
- Modify the commit messages and documentation to be a little more
  verbose.
- Link to v1: https://lore.kernel.org/r/20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com

---
 Documentation/git-update-ref.adoc |  14 +-
 builtin/fetch.c                   |   2 +-
 builtin/update-ref.c              |  66 ++++-
 refs.c                            | 171 +++++++++++--
 refs.h                            |  70 ++++--
 refs/files-backend.c              | 314 +++++++++++-------------
 refs/packed-backend.c             |  69 +++---
 refs/refs-internal.h              |  51 +++-
 refs/reftable-backend.c           | 502 +++++++++++++++++++-------------------
 t/t1400-update-ref.sh             | 233 ++++++++++++++++++
 10 files changed, 969 insertions(+), 523 deletions(-)

Karthik Nayak (8):
      refs/files: remove redundant check in split_symref_update()
      refs: move duplicate refname update check to generic layer
      refs/files: remove duplicate duplicates check
      refs/reftable: extract code from the transaction preparation
      refs: introduce enum-based transaction error types
      refs: implement batch reference update support
      refs: support rejection in batch updates during F/D checks
      update-ref: add --batch-updates flag for stdin mode
---

Range-diff versus v4:

1:  c682fce9d0 = 1:  cae24142a1 refs/files: remove redundant check in split_symref_update()
2:  7483120888 = 2:  239aecdb0f refs: move duplicate refname update check to generic layer
3:  e54c9042b5 = 3:  06404dd350 refs/files: remove duplicate duplicates check
4:  4f905880af = 4:  a3e645aa37 refs/reftable: extract code from the transaction preparation
5:  7846fc43f5 ! 5:  2615bfe78e refs: introduce enum-based transaction error types
    @@ refs.h: struct worktree;
      enum ref_storage_format ref_storage_format_by_name(const char *name);
      const char *ref_storage_format_to_name(enum ref_storage_format ref_storage_format);
      
    -+/*
    -+ * enum ref_transaction_error represents the following return codes:
    -+ * REF_TRANSACTION_ERROR_GENERIC error_code: default error code.
    -+ * REF_TRANSACTION_ERROR_NAME_CONFLICT error_code: ref name conflict like A vs A/B.
    -+ * REF_TRANSACTION_ERROR_CREATE_EXISTS error_code: ref to be created already exists.
    -+ * REF_TRANSACTION_ERROR_NONEXISTENT_REF error_code: ref expected but doesn't exist.
    -+ * REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE error_code: provided old_oid or old_target of
    -+ * reference doesn't match actual.
    -+ * REF_TRANSACTION_ERROR_INVALID_NEW_VALUE error_code: provided new_oid or new_target is
    -+ * invalid.
    -+ * REF_TRANSACTION_ERROR_EXPECTED_SYMREF error_code: expected ref to be symref, but is a
    -+ * regular ref.
    -+ */
     +enum ref_transaction_error {
    ++	/* Default error code */
     +	REF_TRANSACTION_ERROR_GENERIC = -1,
    ++	/* Ref name conflict like A vs A/B */
     +	REF_TRANSACTION_ERROR_NAME_CONFLICT = -2,
    ++	/* Ref to be created already exists */
     +	REF_TRANSACTION_ERROR_CREATE_EXISTS = -3,
    ++	/* ref expected but doesn't exist */
     +	REF_TRANSACTION_ERROR_NONEXISTENT_REF = -4,
    ++	/* Provided old_oid or old_target of reference doesn't match actual */
     +	REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE = -5,
    ++	/* Provided new_oid or new_target is invalid */
     +	REF_TRANSACTION_ERROR_INVALID_NEW_VALUE = -6,
    ++	/* Expected ref to be symref, but is a regular ref */
     +	REF_TRANSACTION_ERROR_EXPECTED_SYMREF = -7,
     +};
     +
6:  398b93689a ! 6:  d5c1c77b0d refs: implement batch reference update support
    @@ refs/files-backend.c: static int files_transaction_prepare(struct ref_store *ref
     -		if (ret)
     +		if (ret) {
     +			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
    -+				strbuf_setlen(err, 0);
    ++				strbuf_reset(err);
     +				ret = 0;
     +
     +				continue;
    @@ refs/packed-backend.c: static enum ref_transaction_error write_with_updates(stru
      					ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
     +
     +					if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
    -+						strbuf_setlen(err, 0);
    ++						strbuf_reset(err);
     +						ret = 0;
     +						continue;
     +					}
    @@ refs/packed-backend.c: static enum ref_transaction_error write_with_updates(stru
      					ret = REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE;
     +
     +					if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
    -+						strbuf_setlen(err, 0);
    ++						strbuf_reset(err);
     +						ret = 0;
     +						continue;
     +					}
    @@ refs/packed-backend.c: static enum ref_transaction_error write_with_updates(stru
      				ret = REF_TRANSACTION_ERROR_NONEXISTENT_REF;
     +
     +				if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
    -+					strbuf_setlen(err, 0);
    ++					strbuf_reset(err);
     +					ret = 0;
     +					continue;
     +				}
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
     -		if (ret)
     +		if (ret) {
     +			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
    -+				strbuf_setlen(err, 0);
    ++				strbuf_reset(err);
     +				ret = 0;
     +
     +				continue;
7:  965cd76097 ! 7:  4bb4902631 refs: support rejection in batch updates during F/D checks
    @@ refs.c: enum ref_transaction_error refs_verify_refnames_available(struct ref_sto
      					  struct strbuf *err)
      {
     @@ refs.c: enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
    + 	struct strbuf referent = STRBUF_INIT;
    + 	struct string_list_item *item;
    + 	struct ref_iterator *iter = NULL;
    ++	struct strset conflicting_dirnames;
    + 	struct strset dirnames;
    + 	int ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
    + 
    +@@ refs.c: enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
    + 
    + 	assert(err);
    + 
    ++	strset_init(&conflicting_dirnames);
      	strset_init(&dirnames);
      
      	for_each_string_list_item(item, refnames) {
    @@ refs.c: enum ref_transaction_error refs_verify_refnames_available(struct ref_sto
      		const char *extra_refname;
      		struct object_id oid;
     @@ refs.c: enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
    + 				continue;
    + 
      			if (!initial_transaction &&
    - 			    !refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
    - 					       &type, &ignore_errno)) {
    +-			    !refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
    +-					       &type, &ignore_errno)) {
    ++			    (strset_contains(&conflicting_dirnames, dirname.buf) ||
    ++			     !refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
    ++						       &type, &ignore_errno))) {
     +				if (transaction && ref_transaction_maybe_set_rejected(
     +					    transaction, *update_idx,
     +					    REF_TRANSACTION_ERROR_NAME_CONFLICT)) {
     +					strset_remove(&dirnames, dirname.buf);
    ++					strset_add(&conflicting_dirnames, dirname.buf);
     +					continue;
     +				}
     +
    @@ refs.c: enum ref_transaction_error refs_verify_refnames_available(struct ref_sto
      			strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
      				    refname, extra_refname);
      			goto cleanup;
    +@@ refs.c: enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
    + cleanup:
    + 	strbuf_release(&referent);
    + 	strbuf_release(&dirname);
    ++	strset_clear(&conflicting_dirnames);
    + 	strset_clear(&dirnames);
    + 	ref_iterator_free(iter);
    + 	return ret;
     @@ refs.c: enum ref_transaction_error refs_verify_refname_available(
      	};
      
8:  ed58c67cd7 ! 8:  674630f77c update-ref: add --batch-updates flag for stdin mode
    @@ builtin/update-ref.c: int cmd_update_ref(int argc,
     -		update_refs_stdin();
     +		update_refs_stdin(flags);
      		return 0;
    --	}
    -+	} else if (flags & REF_TRANSACTION_ALLOW_FAILURE)
    ++	} else if (flags & REF_TRANSACTION_ALLOW_FAILURE) {
     +		die("--batch-updates can only be used with --stdin");
    + 	}
      
      	if (end_null)
    - 		usage_with_options(git_update_ref_usage, options);
     
      ## t/t1400-update-ref.sh ##
     @@ t/t1400-update-ref.sh: do


---

base-commit: 679c868f5fffadd1f7e8e49d4d87d745ee36ffb7
change-id: 20241206-245-partially-atomic-ref-updates-9fe8b080345c

Thanks
- Karthik

