Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEA913CFA4
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713907705; cv=none; b=NIkCr9DVtgReZc01nceLac7rw/CtiLc91hidjjFVgsTn+BxU+p/x9aW+FxzBCTRXOvksRjLQ/k7T4b77BNFV7tGIlTOOQMTqhw5RDiKmUTBxyty+LJ2xNoAVAEE32VL5BzSbS8moucKx8osXk57xaUPttGur1YW0gDd4g2VZZLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713907705; c=relaxed/simple;
	bh=hJ/auEehtNGqidQ0CVeYcgPU2sFtNG52w360Y8RKvVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyHR+0PkJ2GiwXy2VJrt2qMy/ZFuBCZAdproLRUi8egLnEveffeBTAenj6fV3Jtf6AAMcWNbXQ+w/FAAxFQMCLxu6NnQXKzTh8GfhQNKU45qxfoVmzBxJlOP9MjLtAV8B/ZqfoUyaR/Zev7vo9otTdd1Us5HJA/AN/0MOrS+x5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZ4hfp6F; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZ4hfp6F"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a55b2f49206so48917666b.1
        for <git@vger.kernel.org>; Tue, 23 Apr 2024 14:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713907702; x=1714512502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vso8Ad1NUpKFZPfWye35XnT+f02fIpyITaSVUVsUxi0=;
        b=FZ4hfp6FKQ59fWyge8fvTQnjTr14CGHrr1soYrGE2kPeF3RcRgHYPpFRI4I5XACrvn
         TBBuBXMUA4TShZ3x5YzUvXEVca8251RDZm5vSewnqJqvaI9XSPDf88yPiiSqmyAKMbS7
         fb4IsTbL++2bv67rBbIIlJ3cCD6j+pWxGTIZPmOHVKybmP+Jm/T4X1aZ5hSQsXK8H9VM
         w3j95pLreyBrdjTUmwL+6xSEIjPGhqR6eZS5m3HTDUKbyKbKo0iQQeJqZlcNY1f6zAQx
         MZhwXWzcQvU9/sAw6R0JEETgRlKtlzLTmkkCJyV/+fvl7H77Lb/sRv17K0Gh+mGzE5XR
         JJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713907702; x=1714512502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vso8Ad1NUpKFZPfWye35XnT+f02fIpyITaSVUVsUxi0=;
        b=iGxBpXCSazIO1AemmS+QOZ5PnmPFsvp5/Mpx4NCNHAxcrloIMFTKWhvGqJ9sCSZYvu
         pDrNemKWX1z53Ki6U547x6K2lNbj0ojqP1h5cajYDBLrq9mMPIaZ+fczjWqjz7fUEUcA
         RjwrjTv3WVWQs70kDzjQiTmIUxUtEry8BLXyMpOCqqK76hNi2AIu0iwM86ala/MtHXuK
         y5+oj7TiJXnoceMX98Pox759eacftxaPH6kxA7wtO9wo5p2fLy2pn3dmGeL26TPW5CEJ
         mJ5oPnuu3vwmB98Q7/28T1ZFKTgx42LACcQ09CNza6IVxbYpWv5Ok6XkkR49Ks5wwVWY
         sgFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkY/5c83HMZmU2eK7Wr15ZFRmdjc0n2mU5qAKn05mVy7kyHwC8mu8nBC264mipIYKRym2ZMJNQ9OvliWSr6rRl9tAe
X-Gm-Message-State: AOJu0YxAgLhMWj36VqKz5oSzXRmmG1q513gix44wd/QpVbgTJB3zwwp5
	t4aa4GzBzkMJXeI8xV6QphDdVGCcnuHSNs2MTBmTn4JsUpNTHjVQ
X-Google-Smtp-Source: AGHT+IHSjVIKXB4hFaIsDfHoLb8kmrX3jPYC4ANEwqvsc5us/ju5SucvVYVC4fqNc8EOzmi0gavARA==
X-Received: by 2002:a17:907:7b8e:b0:a55:88a0:4b7c with SMTP id ne14-20020a1709077b8e00b00a5588a04b7cmr646996ejc.38.1713907701394;
        Tue, 23 Apr 2024 14:28:21 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:23ba:342:e06:b489])
        by smtp.gmail.com with ESMTPSA id f17-20020a17090660d100b00a587236e646sm1864275ejk.174.2024.04.23.14.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 14:28:20 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v3 0/8] refs: add symref support to 'git-update-ref' 
Date: Tue, 23 Apr 2024 23:28:10 +0200
Message-ID: <20240423212818.574123-1-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412095908.1134387-1-knayak@gitlab.com>
References: <20240412095908.1134387-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The 'git-update-ref(1)' command allows transactional reference updates.
But currently only supports regular reference updates. Meaning, if one
wants to update HEAD (symbolic ref) in a transaction, there is no tool
to do so.

One option to obtain transactional updates for the HEAD ref is to
manually create the HEAD.lock file and commit. This is intrusive, where
the user needs to mimic internal git behavior. Also, this only works
when using the files backend.

At GitLab, we've been using the manual process till date, to allow users
to set and change their default branch. But with the introduction of
reftables as a reference backend, this becomes a necessity to be solved
within git.

The patch series adds symref support to the existing commands {verify,
create, delete, update} within 'git-update-ref'. This is done by parsing
inputs with the 'ref:' prefix as symref targets. This updates our current
commands to:

update SP <ref> SP (<new-oid> | ref:<new-target>) [SP (<old-oid> | ref:<old-target>)] LF
create SP <ref> SP (<new-oid> | ref:<new-target>) LF
delete SP <ref> [SP (<old-oid> | ref:<old-target>)] LF
verify SP <ref> [SP (<old-oid> | ref:<old-target>)] LF

Wherein, when ref:<new-target> is provided, the update ensures that
the <ref> is a symbolic ref which targets <new-target>. When
ref:<old-target> is provided, we ensure that <ref> is a symbolic ref
which targets <old-target> before the update.

With this it is possible to:
1. Create, verify, delete, and update symrefs
2. Create dangling symrefs
3. Update regular refs to become symrefs
4. Update symrefs to become regular refs

V1 of the patch series can be found here:
https://lore.kernel.org/git/20240330224623.579457-1-knayak@gitlab.com/
V2 of the patch series can be found here:
https://lore.kernel.org/git/20240412095908.1134387-1-knayak@gitlab.com/

Changes from v2:
1. We no longer have separate commands for symrefs, instead the regular
commands learn to parse 'ref:<target>' as symref targets. This reduces
the code in this series. Thanks Patrick for the suggestion.
2. Apart from supporting regular refs => symrefs. We also support the
inverse now.
3. Also allow creation of dangling refs.
4. Bunch of cleanups
   - whitespace issues in the previous patch series
   - uneeded header includes
   - uneeded tests
5. Added more documentation and better error messages, especially in reftables.
6. Better assertions around the input data.

Thanks all for the reviews on the previous iteration. Appreciate the support!

Range diff against v2:

1:  3269d0e91e ! 1:  4e49d54dcc refs: accept symref values in `ref_transaction[_add]_update`
    @@ Commit message
         flags to create a `ref_update` and add it to the transaction at hand.
     
         To extend symref support in transactions, we need to also accept the
    -    old and new ref values and process it. In this commit, let's add the
    -    required paramaters to the function and modify all call sites.
    +    old and new ref targets and process it. In this commit, let's add the
    +    required parameters to the function and modify all call sites.
     
    -    The two paramaters added are `new_ref` and `old_ref`. The `new_ref` is
    -    used to denote what the reference should point to when the transaction
    -    is applied. Some functions allow this parameter to be NULL, meaning that
    -    the reference is not changed, or `""`, meaning that the reference should
    -    be deleted.
    +    The two parameters added are `new_target` and `old_target`. The
    +    `new_target` is used to denote what the reference should point to when
    +    the transaction is applied. Some functions allow this parameter to be
    +    NULL, meaning that the reference is not changed.
     
    -    The `old_ref` denotes the value of that the reference must have before
    -    the update. Some functions allow this parameter to be NULL, meaning that
    -    the old value of the reference is not checked, or `""`, meaning that the
    -    reference must not exist before the update. A copy of this value is made
    +    The `old_target` denotes the value the reference must have before the
    +    update. Some functions allow this parameter to be NULL, meaning that the
    +    old value of the reference is not checked. A copy of this value is made
         in the transaction.
     
         The handling logic of these parameters will be added in consequent
    -    commits as we implement symref-{create, update, delete, verify}.
    +    commits as we add symref support to the existing 'git-update-ref'
    +    commands.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ refs.c: struct ref_update *ref_transaction_add_update(
      		const char *refname, unsigned int flags,
      		const struct object_id *new_oid,
      		const struct object_id *old_oid,
    -+		const char *new_ref, const char *old_ref,
    ++		const char *new_target, const char *old_target,
      		const char *msg)
      {
      	struct ref_update *update;
    +@@ refs.c: struct ref_update *ref_transaction_add_update(
    + 	if (transaction->state != REF_TRANSACTION_OPEN)
    + 		BUG("update called for transaction that is not open");
    + 
    ++	if (old_oid && !is_null_oid(old_oid) && old_target)
    ++		BUG("Only one of old_oid and old_target should be non NULL");
    ++	if (new_oid && !is_null_oid(new_oid) && new_target)
    ++		BUG("Only one of new_oid and new_target should be non NULL");
    ++
    + 	FLEX_ALLOC_STR(update, refname, refname);
    + 	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
    + 	transaction->updates[transaction->nr++] = update;
     @@ refs.c: int ref_transaction_update(struct ref_transaction *transaction,
      			   const char *refname,
      			   const struct object_id *new_oid,
      			   const struct object_id *old_oid,
    -+			   const char *new_ref, const char *old_ref,
    ++			   const char *new_target,
    ++			   const char *old_target,
      			   unsigned int flags, const char *msg,
      			   struct strbuf *err)
      {
    @@ refs.c: int ref_transaction_update(struct ref_transaction *transaction,
      
      	ref_transaction_add_update(transaction, refname, flags,
     -				   new_oid, old_oid, msg);
    -+				   new_oid, old_oid, new_ref, old_ref, msg);
    ++				   new_oid, old_oid, new_target,
    ++				   old_target, msg);
      	return 0;
      }
      
    @@ refs.c: int refs_update_ref(struct ref_store *refs, const char *msg,
     
      ## refs.h ##
     @@ refs.h: struct ref_transaction *ref_transaction_begin(struct strbuf *err);
    -  */
    - #define REF_SKIP_REFNAME_VERIFICATION (1 << 11)
    - 
    -+/*
    -+ * The reference update is considered to be done on a symbolic reference. This
    -+ * ensures that we verify, delete, create and update the ref correspondingly.
    -+ */
    -+#define REF_SYMREF_UPDATE (1 << 12)
    -+
    - /*
    -  * Bitmask of all of the flags that are allowed to be passed in to
    -  * ref_transaction_update() and friends:
    -  */
    - #define REF_TRANSACTION_UPDATE_ALLOWED_FLAGS                                  \
    - 	(REF_NO_DEREF | REF_FORCE_CREATE_REFLOG | REF_SKIP_OID_VERIFICATION | \
    --	 REF_SKIP_REFNAME_VERIFICATION)
    -+	 REF_SKIP_REFNAME_VERIFICATION | REF_SYMREF_UPDATE )
    - 
    - /*
    -  * Add a reference update to transaction. `new_oid` is the value that
    +  *         before the update. A copy of this value is made in the
    +  *         transaction.
    +  *
    ++ *     new_target -- the target reference that the reference will be
    ++ *         update to point to. This takes precedence over new_oid when
    ++ *         set. If the reference is a regular reference, it will be
    ++ *         converted to a symbolic reference.
    ++ *
    ++ *     old_target -- the reference that the reference must be pointing to.
    ++ *         Will only be taken into account when the reference is a symbolic
    ++ *         reference.
    ++ *
    +  *     flags -- flags affecting the update, passed to
    +  *         update_ref_lock(). Possible flags: REF_NO_DEREF,
    +  *         REF_FORCE_CREATE_REFLOG. See those constants for more
    +@@ refs.h: struct ref_transaction *ref_transaction_begin(struct strbuf *err);
    +  * beforehand. The old value is checked after the lock is taken to
    +  * prevent races. If the old value doesn't agree with old_oid, the
    +  * whole transaction fails. If old_oid is NULL, then the previous
    +- * value is not checked.
    ++ * value is not checked. If `old_target` is not NULL, treat the reference
    ++ * as a symbolic ref and validate that its target before the update is
    ++ * `old_target`. If the `new_target` is not NULL, then the reference
    ++ * will be updated to a symbolic ref which targets `new_target`.
    ++ * Together, these allow us to update between regular refs and symrefs.
    +  *
    +  * See the above comment "Reference transaction updates" for more
    +  * information.
     @@ refs.h: int ref_transaction_update(struct ref_transaction *transaction,
      			   const char *refname,
      			   const struct object_id *new_oid,
      			   const struct object_id *old_oid,
    -+			   const char *new_ref, const char *old_ref,
    ++			   const char *new_target,
    ++			   const char *old_target,
      			   unsigned int flags, const char *msg,
      			   struct strbuf *err);
      
    @@ refs/refs-internal.h: struct ref_update {
      	struct object_id old_oid;
      
     +	/*
    -+	 * If (flags & REF_SYMREF_UPDATE), set the reference to this
    -+	 * value (or delete it, if `new_ref` is an empty string).
    ++	 * If set, point the reference to this value. This can also be
    ++	 * used to convert regular references to become symbolic refs.
     +	 */
    -+	const char *new_ref;
    ++	const char *new_target;
     +
     +	/*
    -+	 * If (type & REF_SYMREF_UPDATE), check that the reference
    -+	 * previously had this value (or didn't previously exist,
    -+	 * if `old_ref` is an empty string).
    ++	 * If set and the reference is a symbolic ref, check that the
    ++	 * reference previously pointed to this value.
     +	 */
    -+	const char *old_ref;
    ++	const char *old_target;
     +
      	/*
      	 * One or more of REF_NO_DEREF, REF_FORCE_CREATE_REFLOG,
    @@ refs/refs-internal.h: struct ref_update *ref_transaction_add_update(
      		const char *refname, unsigned int flags,
      		const struct object_id *new_oid,
      		const struct object_id *old_oid,
    -+		const char *new_ref, const char *old_ref,
    ++		const char *new_target, const char *old_target,
      		const char *msg);
      
      /*
2:  a8cb0e0a1d < -:  ---------- update-ref: add support for symref-verify
3:  37c3e006da < -:  ---------- update-ref: add support for symref-delete
-:  ---------- > 2:  37b7aadca4 update-ref: support parsing ref targets in `parse_next_oid`
4:  53fdb408ef = 3:  9cb7817f94 files-backend: extract out `create_symref_lock`
5:  8fa0151f94 < -:  ---------- update-ref: add support for symref-create
6:  714492ede3 < -:  ---------- update-ref: add support for symref-update
-:  ---------- > 4:  c7f43f6058 update-ref: support symrefs in the verify command
-:  ---------- > 5:  4016d6ca98 update-ref: support symrefs in the delete command
-:  ---------- > 6:  9f19e82f00 update-ref: support symrefs in the create command
-:  ---------- > 7:  132dbfcc5f update-ref: support symrefs in the update command
7:  c483104562 ! 8:  1b709f995b refs: support symrefs in 'reference-transaction' hook
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    refs: support symrefs in 'reference-transaction' hook
    +    ref: support symrefs in 'reference-transaction' hook
     
         The 'reference-transaction' hook runs whenever a reference update is
    -    made to the system. In the previous commits, we added support for
    -    various symref commands in `git-update-ref`. While it allowed us to now
    +    made to the system. In the previous commits, we added symref support for
    +    various commands in `git-update-ref`. While it allowed us to now
         manipulate symbolic refs via `git-update-ref`, it didn't activate the
         'reference-transaction' hook.
     
    @@ Commit message
         new format described for this and we stick to the existing format of:
             <old-value> SP <new-value> SP <ref-name> LF
         but now, <old-value> and <new-value> could also denote references
    -    instead of objects.
    +    instead of objects, where the format is similar to that in
    +    'git-update-ref', i.e. 'ref:<ref-target>'.
     
         While this seems to be backward incompatible, it is okay, since the only
         way the `reference-transaction` hook has refs in its output is when
    -    `git-update-ref` is used with `update-symref` command. Also the
    -    documentation for reference-transaction hook always stated that support
    -    for symbolic references may be added in the future.
    +    `git-update-ref` is used to manipulate symrefs. Also the documentation
    +    for reference-transaction hook always stated that support for symbolic
    +    references may be added in the future.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ Documentation/githooks.txt: given reference transaction is in:
      `<ref-name>` via `git rev-parse`.
      
     +For symbolic reference updates the `<old_value>` and `<new-value>`
    -+fields could denote references instead of objects.
    ++fields could denote references instead of objects, denoted via the
    ++`ref:<ref-target>` format.
     +
      The exit status of the hook is ignored for any state except for the
      "prepared" state. In the "prepared" state, a non-zero exit status will
    @@ refs.c: static int run_transaction_hook(struct ref_transaction *transaction,
      
      	for (i = 0; i < transaction->nr; i++) {
      		struct ref_update *update = transaction->updates[i];
    -+		const char *new_value, *old_value;
    ++		strbuf_reset(&buf);
      
    --		if (update->flags & REF_SYMREF_UPDATE)
    +-		/*
    +-		 * Skip reference transaction for symbolic refs.
    +-		 */
    +-		if (update->new_target || update->old_target)
     -			continue;
    -+		new_value = oid_to_hex(&update->new_oid);
    -+		old_value = oid_to_hex(&update->old_oid);
    -+
    -+		if (update->flags & REF_SYMREF_UPDATE) {
    -+			if (update->flags & REF_HAVE_NEW && !null_new_value(update))
    -+				new_value = update->new_ref;
    -+			if (update->flags & REF_HAVE_OLD && update->old_ref)
    -+				old_value = update->old_ref;
    -+		}
    ++		if (update->flags & REF_HAVE_OLD && update->old_target)
    ++			strbuf_addf(&buf, "ref:%s ", update->old_target);
    ++		else
    ++			strbuf_addf(&buf, "%s ", oid_to_hex(&update->old_oid));
      
    - 		strbuf_reset(&buf);
    +-		strbuf_reset(&buf);
     -		strbuf_addf(&buf, "%s %s %s\n",
     -			    oid_to_hex(&update->old_oid),
     -			    oid_to_hex(&update->new_oid),
     -			    update->refname);
    -+		strbuf_addf(&buf, "%s %s %s\n", old_value, new_value, update->refname);
    ++		if (update->flags & REF_HAVE_NEW && update->new_target)
    ++			strbuf_addf(&buf, "ref:%s ", update->new_target);
    ++		else
    ++			strbuf_addf(&buf, "%s ", oid_to_hex(&update->new_oid));
    ++
    ++		strbuf_addf(&buf, "%s\n", update->refname);
      
      		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
      			if (errno != EPIPE) {
     
      ## t/t1416-ref-transaction-hooks.sh ##
    -@@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'hook gets all queued updates in aborted state' '
    - 	test_cmp expect actual
    +@@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'interleaving hook calls succeed' '
    + 	test_cmp expect target-repo.git/actual
      '
      
    -+# This test doesn't add a check for 'symref-delete' since there is a
    ++# This test doesn't add a check for symref 'delete' since there is a
     +# variation between the ref backends WRT 'delete'. In the files backend,
     +# 'delete' also triggers an additional transaction update on the
     +# packed-refs backend, which constitutes additional reflog entries.
    - test_expect_success 'interleaving hook calls succeed' '
    - 	test_when_finished "rm -r target-repo.git" &&
    - 
    -@@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'interleaving hook calls succeed' '
    - 	test_cmp expect target-repo.git/actual
    - '
    - 
     +test_expect_success 'hook gets all queued symref updates' '
     +	test_when_finished "rm actual" &&
     +
    @@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'interleaving hook calls s
     +
     +	cat >expect <<-EOF &&
     +		prepared
    -+		refs/heads/main $ZERO_OID refs/heads/symref
    -+		$ZERO_OID refs/heads/main refs/heads/symrefc
    -+		refs/heads/main refs/heads/branch refs/heads/symrefu
    ++		ref:refs/heads/main $ZERO_OID refs/heads/symref
    ++		$ZERO_OID ref:refs/heads/main refs/heads/symrefc
    ++		ref:refs/heads/main ref:refs/heads/branch refs/heads/symrefu
     +		committed
    -+		refs/heads/main $ZERO_OID refs/heads/symref
    -+		$ZERO_OID refs/heads/main refs/heads/symrefc
    -+		refs/heads/main refs/heads/branch refs/heads/symrefu
    ++		ref:refs/heads/main $ZERO_OID refs/heads/symref
    ++		$ZERO_OID ref:refs/heads/main refs/heads/symrefc
    ++		ref:refs/heads/main ref:refs/heads/branch refs/heads/symrefu
     +	EOF
     +
     +	git update-ref --no-deref --stdin <<-EOF &&
     +		start
    -+		symref-verify refs/heads/symref refs/heads/main
    -+		symref-create refs/heads/symrefc refs/heads/main
    -+		symref-update refs/heads/symrefu refs/heads/branch refs/heads/main
    ++		verify refs/heads/symref ref:refs/heads/main
    ++		create refs/heads/symrefc ref:refs/heads/main
    ++		update refs/heads/symrefu ref:refs/heads/branch ref:refs/heads/main
     +		prepare
     +		commit
     +	EOF


Karthik Nayak (8):
  refs: accept symref values in `ref_transaction[_add]_update`
  update-ref: support parsing ref targets in `parse_next_oid`
  files-backend: extract out `create_symref_lock`
  update-ref: support symrefs in the verify command
  update-ref: support symrefs in the delete command
  update-ref: support symrefs in the create command
  update-ref: support symrefs in the update command
  ref: support symrefs in 'reference-transaction' hook

 Documentation/git-update-ref.txt |  41 ++--
 Documentation/githooks.txt       |  14 +-
 branch.c                         |   2 +-
 builtin/clone.c                  |   2 +-
 builtin/fast-import.c            |   5 +-
 builtin/fetch.c                  |   4 +-
 builtin/receive-pack.c           |   4 +-
 builtin/replace.c                |   2 +-
 builtin/tag.c                    |   1 +
 builtin/update-ref.c             | 106 ++++++++--
 refs.c                           |  78 +++++--
 refs.h                           |  23 +-
 refs/files-backend.c             | 141 +++++++++++--
 refs/refs-internal.h             |  20 ++
 refs/reftable-backend.c          |  49 ++++-
 sequencer.c                      |   9 +-
 t/t0600-reffiles-backend.sh      |  32 +++
 t/t1400-update-ref.sh            | 346 ++++++++++++++++++++++++++++++-
 t/t1416-ref-transaction-hooks.sh |  41 ++++
 walker.c                         |   2 +-
 20 files changed, 817 insertions(+), 105 deletions(-)

-- 
2.43.GIT

