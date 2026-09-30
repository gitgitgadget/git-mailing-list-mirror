Received: from mail-lr2-f34.google.com (mail-lr2-f34.google.com [74.125.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F4B36F419
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 03:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790739196; cv=pass; b=M86W0tMyy0Mp5OQJBA5Czxe9e18/c2iPnSIQaPwGAmFBu+DKVOfjO00KfG0EQVbcrD7CBC4/9UepuKVqtyUVhyMV+2gWTFxRC17dBqqbrkXsxPbItElEjZHM6aV22w3oY/mgC/I+EC/FjjUsSnJAVQOy3/bnxf1lD3Tt3iNTY9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790739196; c=relaxed/simple;
	bh=OFAmRSkFnZXnYAH5IIbVRGHC4Q7nwbkWJQHM1oIAu+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXnpyF1Ggo/PZwY1/Bok2lsmao25Isjpe8NYKa9pjS5qjVayj08Fj39/Pzv+5sjje6y0NVfG+1JQSybRIeMd49MiEX0EKKwUVUDcHTwqQL9VVf5GPxtQQYK1bM0VI88o3/d3a0qEqfDWrPAIf1gaxktmZlJyKEU9qvYsZ05JrdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mezqNTdj; arc=pass smtp.client-ip=74.125.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mezqNTdj"
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a773bdf720so1902641fa.1
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 20:33:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790739185; cv=none;
        d=google.com; s=arc-20260327;
        b=GHjNiET2mTnM0s2oRvrnjQilaUH8QIS7ppZbW74qW32dScypRSPsaXZIMRZOXQ+pbS
         6GR126S1+GJ6+TOuJhKoTDbdnOaMvpgPOQNO+jMEbeJbHajyyZCBKRuxH571edRlsf7R
         pZzSMButUCSk9cfmSg0Jgyn/+/X41rlsMlRYOBJFzm37+6tugNluNRbMUcNs3CQWyU2l
         f+VNjLMOv5SgWa7US541nG+B2e4yZAqsXASVJj3ASCmZt97DOS11gBloLvuLOh1dIE2o
         PbE3q00J6umyQu9EA2WjfCxG3wvVITJtNfRGrcAnEBU/fxFE5UEl3qYvWtWS5WvKjQCz
         vC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PIasYdDPIdr6z1l8sSQQjBg5VEwbl8pWhchd1qD8wV0=;
        fh=B6reE5atUiuJSMq87cLJNd/IQsvXZABHAck4c76r4hY=;
        b=a6NOe05gmw1hTM1gtaEndEwgDm8EL/31t59dZ1rD/oCnU4cvLTi7U3YPgP8cOFQyHD
         HHK7tnq/mGOFHKgdZhI8K8HN3Ov0XKOKyFvE9NOFe2SNj1lkvJ7aZ+KgSZKhpUMUH1+k
         ElscHu8eUkPz878Oe6FDMrX++Z9CEtVl8bySdrtRfeUyNJ9Tv+zW/h7BZyV0QwqNkznN
         VCj9lZIOrk3ujGmyPkEAlTz9N5kCcdtNAnZyS7AHjATWhj/B2b9ybhZgr1qe6KUTQb1I
         9/0DBctrVOBDOnzG/TMVESn0RYKXum0DvxrebuLpmIqouUrp/B0exa+rHNImWZUjKDFy
         X7Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790739185; x=1791343985; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PIasYdDPIdr6z1l8sSQQjBg5VEwbl8pWhchd1qD8wV0=;
        b=mezqNTdjOhvannHZSYcnWDxaUxogCOw8nPHfzAWb77AQhq5kLgdQRrZQ9jJxsKEJHx
         leVOQ1auQWcC9FnnAgy+65etUxAlbC8FXfbVM8WX2ezfZyAmjZqRmSFJuB1vVJZ68SHY
         tKiShRBYtv2DseKQKx3U0DfrAgn/PeeaaB7DXtmKQqwJN6xJWAPk0XKdIE6YJ6sE1iL0
         ao23YfsMA0dMSNlwlVNgpRXap40V6ULzQ9PS6FfwjP1rFAGWsTo/TaFUbb7kpUL3thzE
         64L6c4CkAuml8kbxNYCQUvroMyzpLd6NSLpcWnlSHYOiNkz+eu0APYhdYhw+QkJLuL5v
         UKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790739185; x=1791343985;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PIasYdDPIdr6z1l8sSQQjBg5VEwbl8pWhchd1qD8wV0=;
        b=VSmpeos9RvJLLDeWQf1LQozvxLPEgaYyXTuJB9DL4R7nV7itEiJfjvPphOKRwHHs3m
         li1D/b0VFuzgVP786J9+kWzgqQ2daNtYGaXx+QcBxMp55XJoLPit7Xv2964mTLrFCQt/
         gC60C+pBIrf5ool/TT4pc5Eeg4GA09lwa87JhVWhaFM4/1Ob3uxrL87dKcF9z7kRG1gr
         KBsEZZbHIjtuac3+IFfTpNDwRxa+W8kPMqmXHq+BP54BE821HPxrh+XeNnn85LDacog3
         aucOFK8rI6byGe4nb/tGpC+/o0Urh0a7Q4Rre+nGGhZGPbcCqr+Pz8QP1YEmrBo4qmD6
         60Xg==
X-Gm-Message-State: AFq9FYIccM4y0YIs2XnJwpkDI6zHj8vg6U7VCxjYyxg/XmKtURqfR9bR
	E6GBIeYmCwIEe2dZvonhdGwhYbIKqyPHwVrfdJx1AX2RTKl2E88cOM+zfw+jt8YgED90zCCgwyx
	m8cb0mGodEXNPaxoN2OXz9h0dGOXykyQu2hr2ehM=
X-Gm-Gg: AYBFou1+FK2TqGRAwHsqcNennt1//vGlnMmQtqJM/I61fsah3+kOO1j9TohmxriIdvB
	e12xETsmzdVnom/s+JoEeATGNITZvNI++cK52sqbZgqyl2J90i52V9eJBlNu44aXYA7ewl+UfDE
	va3qznHISr8weGuu55Yo75rEl0tuxZ7nCPwl2uiLEHLBlCEi0aQBOyN2/eYTCfYhSPA4rWvcy+z
	nhA5hl4Cr0RRE8CR0HdFjXVY8T4HnthaAybsaN7FvUuM2svn9E1/8G8m/be1bxb0hmxIOAmXMK9
	Dva8PfOQ1vgl5RPIfOOoNACfwks8owhyMN0r7CG0091vlmawHbRwoTK+RAc3MOxXBKzJuc7f+/Y
	VGLzDfgbnfVPsHBzkcevYYZI6oZyasueZo68Il+w1A3LNc+2fz8ALORmtpALpN6GAYgKjois=
X-Received: by 2002:a05:651c:a382:10b0:3a6:6e61:2884 with SMTP id
 38308e7fff4ca-3a7791d6d34mr313331fa.23.1790739184468; Tue, 29 Sep 2026
 20:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com> <20260923133651.74120-1-maciej.ciemborowicz@gmail.com>
In-Reply-To: <20260923133651.74120-1-maciej.ciemborowicz@gmail.com>
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Wed, 30 Sep 2026 05:32:53 +0200
X-Gm-Features: AclHuK-c0-fg4zrNrXnJhU7MIBJIOl8JB0r1gWFSlakB13mtirUxkt9mkfDdSLI
Message-ID: <CACQ=SRG5ajG-+vHT8TPDif2Y0C9JFaXFuUesyPFHbDpJCq-76Q@mail.gmail.com>
Subject: Re: [PATCH v2] refs: run copy and rename through transactions
To: git@vger.kernel.org
Cc: gitster@pobox.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'd appreciate a code review of v2.

Thanks,
- Maciej Ciemborowicz

On Wed, Sep 23, 2026 at 3:36=E2=80=AFPM Maciej Ciemborowicz
<maciej.ciemborowicz@gmail.com> wrote:
>
> Reference copy and rename operations bypass the transaction API.
> Consequently, the reference-transaction hook sees only the source deletio=
n
> with the files backend and no useful update with the reftable backend.
>
> Represent both operations as reference transactions containing their
> logical updates. A rename is a deletion of the old reference and creation
> of the new reference in the same transaction. Attach operation-specific
> state to the destination update instead of making copy or rename a proper=
ty
> of the entire transaction.
>
> Retain backend-specific reflog handling: the files backend stages its
> existing rename procedure across prepare, finish and abort, while reftabl=
e
> stages an addition while holding the stack lock. Suppress hooks for the
> files backend's nested deletion transactions so that callers observe one
> logical transaction.
>
> Record and verify the source and destination values after taking backend
> locks. This rejects concurrent changes instead of applying a rename or co=
py
> that differs from the payload shown to the preparing hook. Preserve D/F
> renames and restore overwritten references and reflogs when a prepared ho=
ok
> rejects the operation.
>
> Add tests covering rename, copy, forced updates, both directions of D/F
> conflicts, concurrent updates and prepared-hook rollback.
>
> Helped-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
> ---
> Apologies for the unrelated Subject header on my earlier reply. This
> reroll incorporates the points discussed there.
>
> Changes since v1:
>
>  * Keep copy/rename state on the destination ref update instead of the
>    generic transaction, so the operation is no longer a transaction-wide
>    property.
>  * Keep REF_TRANSACTION_FLAG_SKIP_HOOK private to the refs implementation=
.
>  * Use bool for the two-state copy parameter.
>  * Apply Junio's commit-message wording suggestions.
>
> Range-diff against v1:
> 1:  de0a5a9f7 ! 1:  d852537d8 refs: run copy and rename through transacti=
ons
>     @@ Metadata
>       ## Commit message ##
>          refs: run copy and rename through transactions
>
>     -    Reference copy and rename operations currently bypass the transa=
ction API.
>     +    Reference copy and rename operations bypass the transaction API.
>          Consequently, the reference-transaction hook sees only the sourc=
e deletion
>          with the files backend and no useful update with the reftable ba=
ckend.
>
>          Represent both operations as reference transactions containing t=
heir
>          logical updates. A rename is a deletion of the old reference and=
 creation
>     -    of the new reference in the same transaction. Retain backend-spe=
cific
>     -    reflog handling: the files backend stages its existing rename pr=
ocedure
>     -    across prepare, finish and abort, while reftable stages an addit=
ion while
>     -    holding the stack lock. Suppress hooks for the files backend's n=
ested
>     -    deletion transactions so that callers observe one logical transa=
ction.
>     +    of the new reference in the same transaction. Attach operation-s=
pecific
>     +    state to the destination update instead of making copy or rename=
 a property
>     +    of the entire transaction.
>     +
>     +    Retain backend-specific reflog handling: the files backend stage=
s its
>     +    existing rename procedure across prepare, finish and abort, whil=
e reftable
>     +    stages an addition while holding the stack lock. Suppress hooks =
for the
>     +    files backend's nested deletion transactions so that callers obs=
erve one
>     +    logical transaction.
>
>          Record and verify the source and destination values after taking=
 backend
>          locks. This rejects concurrent changes instead of applying a ren=
ame or copy
>     @@ Commit message
>          renames and restore overwritten references and reflogs when a pr=
epared hook
>          rejects the operation.
>
>     -    Add coverage for rename, copy, forced updates, both directions o=
f D/F
>     +    Add tests covering rename, copy, forced updates, both directions=
 of D/F
>          conflicts, concurrent updates and prepared-hook rollback.
>
>          Helped-by: Karthik Nayak <karthik.188@gmail.com>
>     @@ refs.c: int refs_delete_ref(struct ref_store *refs, const char *ms=
g,
>       {
>         char c;
>      @@ refs.c: void ref_transaction_free(struct ref_transaction *transac=
tion)
>     +   }
>     +
>     +   for (i =3D 0; i < transaction->nr; i++) {
>     ++          struct ref_copy_or_rename_update *operation =3D
>     ++                  transaction->updates[i]->copy_or_rename;
>     ++
>     +           free(transaction->updates[i]->msg);
>     +           free(transaction->updates[i]->committer_info);
>     +           free((char *)transaction->updates[i]->new_target);
>     +           free((char *)transaction->updates[i]->old_target);
>     +           free((char *)transaction->updates[i]->rejection_details);
>     ++          if (operation) {
>     ++                  free(operation->old_refname);
>     ++                  free(operation->logmsg);
>     ++                  free(operation->destination_target);
>     ++                  free(operation);
>     ++          }
>     +           free(transaction->updates[i]);
>     +   }
>
>     -   string_list_clear(&transaction->refnames, 0);
>     -   free(transaction->updates);
>     -+  free(transaction->old_refname);
>     -+  free(transaction->new_refname);
>     -+  free(transaction->logmsg);
>     -+  free(transaction->destination_target);
>     +@@ refs.c: void ref_transaction_free(struct ref_transaction *transac=
tion)
>         free(transaction);
>       }
>
>     ++struct ref_update *ref_transaction_copy_or_rename_update(
>     ++  struct ref_transaction *transaction)
>     ++{
>     ++  struct ref_update *operation =3D NULL;
>     ++  size_t i;
>     ++
>     ++  for (i =3D 0; i < transaction->nr; i++) {
>     ++          if (!transaction->updates[i]->copy_or_rename)
>     ++                  continue;
>     ++          if (operation)
>     ++                  BUG("multiple copy or rename updates in one trans=
action");
>     ++          operation =3D transaction->updates[i];
>     ++  }
>     ++
>     ++  return operation;
>     ++}
>     ++
>     + int ref_transaction_maybe_set_rejected(struct ref_transaction *tran=
saction,
>     +                                  size_t update_idx,
>     +                                  enum ref_transaction_error err,
>      @@ refs.c: int ref_transaction_prepare(struct ref_transaction *trans=
action,
>                 return REF_TRANSACTION_ERROR_GENERIC;
>
>     @@ refs.c: int refs_delete_refs(struct ref_store *refs, const char *l=
ogmsg,
>      -              const char *newref, const char *logmsg)
>      +static int refs_copy_or_rename_ref(struct ref_store *refs, const ch=
ar *oldref,
>      +                             const char *newref, const char *logmsg=
,
>     -+                             int copy)
>     ++                             bool copy)
>       {
>      -  char *msg;
>      -  int retval;
>      +  struct ref_transaction *transaction =3D NULL;
>     ++  struct ref_copy_or_rename_update *operation =3D NULL;
>     ++  struct ref_update *destination_update;
>      +  struct object_id old_oid, new_oid;
>      +  struct strbuf new_target =3D STRBUF_INIT;
>      +  struct strbuf err =3D STRBUF_INIT;
>     @@ refs.c: int refs_delete_refs(struct ref_store *refs, const char *l=
ogmsg,
>      +  transaction =3D ref_store_transaction_begin(refs, 0, &err);
>      +  if (!transaction)
>      +          goto error;
>     -+  transaction->type =3D copy ? REF_TRANSACTION_TYPE_COPY :
>     -+          REF_TRANSACTION_TYPE_RENAME;
>     -+  transaction->old_refname =3D xstrdup(oldref);
>     -+  transaction->new_refname =3D xstrdup(newref);
>     -+  transaction->logmsg =3D xstrdup(msg);
>     -+  oidcpy(&transaction->source_oid, &old_oid);
>     -+
>      +  if (!copy && ref_transaction_delete(transaction, oldref, &old_oid=
, NULL,
>      +                                      REF_NO_DEREF, msg, &err))
>      +          goto error;
>     @@ refs.c: int refs_delete_refs(struct ref_store *refs, const char *l=
ogmsg,
>      +  } else {
>      +          oidclr(&new_oid, refs->repo->hash_algo);
>      +  }
>     -+  transaction->destination_exists =3D new_exists;
>     -+  if (new_flags & REF_ISSYMREF)
>     -+          transaction->destination_target =3D xstrdup(new_target.bu=
f);
>     -+  else if (transaction->destination_exists)
>     -+          oidcpy(&transaction->destination_oid, &new_oid);
>     -+
>      +  if (ref_transaction_update(transaction, newref, &old_oid,
>      +                             (new_flags & REF_ISSYMREF) ? NULL : &n=
ew_oid,
>      +                             NULL,
>     @@ refs.c: int refs_delete_refs(struct ref_store *refs, const char *l=
ogmsg,
>      +                             NULL, &err))
>      +          goto error;
>      +
>     ++  destination_update =3D transaction->updates[transaction->nr - 1];
>     ++  CALLOC_ARRAY(operation, 1);
>     ++  operation->type =3D copy ? REF_UPDATE_COPY : REF_UPDATE_RENAME;
>     ++  operation->old_refname =3D xstrdup(oldref);
>     ++  operation->logmsg =3D xstrdup(msg);
>     ++  oidcpy(&operation->source_oid, &old_oid);
>     ++  operation->destination_exists =3D new_exists;
>     ++  if (new_flags & REF_ISSYMREF)
>     ++          operation->destination_target =3D xstrdup(new_target.buf)=
;
>     ++  else if (operation->destination_exists)
>     ++          oidcpy(&operation->destination_oid, &new_oid);
>     ++  destination_update->copy_or_rename =3D operation;
>     ++
>      +  if (ref_transaction_commit(transaction, &err))
>      +          goto error;
>      +
>     @@ refs.c: int refs_delete_refs(struct ref_store *refs, const char *l=
ogmsg,
>
>       const char *ref_update_original_update_refname(struct ref_update *u=
pdate)
>
>     - ## refs.h ##
>     -@@ refs.h: enum ref_transaction_flag {
>     -    * while rejecting updates which do not match the expected state.
>     -    */
>     -   REF_TRANSACTION_ALLOW_FAILURE =3D (1 << 1),
>     -+
>     -+  /* Suppress hooks for an update nested in another transaction. */
>     -+  REF_TRANSACTION_FLAG_SKIP_HOOK =3D (1 << 2),
>     - };
>     -
>     - /*
>     -
>       ## refs/debug.c ##
>      @@ refs/debug.c: static int debug_optimize_required(struct ref_store=
 *ref_store,
>         return res;
>     @@ refs/files-backend.c: static int refs_rename_ref_available(struct =
ref_store *ref
>      +};
>      +
>       static int files_copy_or_rename_ref(struct ref_store *ref_store,
>     -                       const char *oldrefname, const char *newrefnam=
e,
>     +-                      const char *oldrefname, const char *newrefnam=
e,
>      -                      const char *logmsg, int copy)
>     -+                      const char *logmsg, int copy,
>     -+                      struct ref_transaction *transaction)
>     ++                              struct ref_update *update,
>     ++                              struct ref_transaction *transaction)
>       {
>         struct files_ref_store *refs =3D
>      -          files_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
>      +          files_downcast(ref_store, REF_STORE_WRITE,
>      +                         "ref_transaction_prepare");
>     ++  struct ref_copy_or_rename_update *operation =3D update->copy_or_r=
ename;
>     ++  const char *oldrefname =3D operation->old_refname;
>     ++  const char *newrefname =3D update->refname;
>     ++  const char *logmsg =3D operation->logmsg;
>     ++  bool copy =3D operation->type =3D=3D REF_UPDATE_COPY;
>         struct object_id orig_oid;
>         int flag =3D 0, logmoved =3D 0;
>         struct ref_lock *lock;
>     @@ refs/files-backend.c: static int files_copy_or_rename_ref(struct r=
ef_store *ref_
>                                     oldrefname);
>                 goto out;
>         }
>     -+  if (!oideq(&orig_oid, &transaction->source_oid)) {
>     ++  if (!oideq(&orig_oid, &operation->source_oid)) {
>      +          ret =3D error("refname %s is at %s but expected %s",
>      +                      oldrefname, oid_to_hex(&orig_oid),
>     -+                      oid_to_hex(&transaction->source_oid));
>     ++                      oid_to_hex(&operation->source_oid));
>      +          goto out;
>      +  }
>         if (!refs_rename_ref_available(&refs->base, oldrefname, newrefnam=
e)) {
>     @@ refs/files-backend.c: static int files_copy_or_rename_ref(struct r=
ef_store *ref_
>      +                  goto out;
>      +          }
>      +  }
>     -+  if (destination_exists !=3D transaction->destination_exists) {
>     ++  if (destination_exists !=3D operation->destination_exists) {
>      +          ret =3D error("refname %s changed while renaming", newref=
name);
>      +          goto out;
>      +  }
>      +  if (destination_exists) {
>      +          if (destination_flags & REF_ISSYMREF) {
>     -+                  if (!transaction->destination_target ||
>     ++                  if (!operation->destination_target ||
>      +                      strcmp(destination_target.buf,
>     -+                             transaction->destination_target)) {
>     ++                             operation->destination_target)) {
>      +                          ret =3D error("refname %s changed while r=
enaming",
>      +                                      newrefname);
>      +                          goto out;
>      +                  }
>     -+          } else if (transaction->destination_target ||
>     ++          } else if (operation->destination_target ||
>      +                     !oideq(&destination_oid,
>     -+                            &transaction->destination_oid)) {
>     ++                            &operation->destination_oid)) {
>      +                  ret =3D error("refname %s changed while renaming"=
, newrefname);
>      +                  goto out;
>      +          }
>     @@ refs/files-backend.c: static int files_transaction_prepare(struct =
ref_store *ref
>         struct ref_transaction *packed_transaction =3D NULL;
>
>         assert(err);
>     -+  if (transaction->type !=3D REF_TRANSACTION_TYPE_NORMAL)
>     -+          return files_copy_or_rename_ref(ref_store,
>     -+                          transaction->old_refname,
>     -+                          transaction->new_refname,
>     -+                          transaction->logmsg,
>     -+                          transaction->type =3D=3D REF_TRANSACTION_=
TYPE_COPY,
>     -+                          transaction);
>     ++  {
>     ++          struct ref_update *operation =3D
>     ++                  ref_transaction_copy_or_rename_update(transaction=
);
>     ++
>     ++          if (operation)
>     ++                  return files_copy_or_rename_ref(ref_store, operat=
ion,
>     ++                                                  transaction);
>     ++  }
>
>         if (transaction->flags & REF_TRANSACTION_FLAG_INITIAL)
>                 goto cleanup;
>     @@ refs/files-backend.c: static int files_transaction_finish(struct r=
ef_store *ref_
>
>
>         assert(err);
>     -+  if (transaction->type !=3D REF_TRANSACTION_TYPE_NORMAL) {
>     -+          struct files_copy_or_rename_transaction_data *data =3D
>     -+                  transaction->backend_data;
>     -+          int special_ret;
>     ++  {
>     ++          struct ref_update *update =3D
>     ++                  ref_transaction_copy_or_rename_update(transaction=
);
>      +
>     -+          special_ret =3D commit_ref_update(refs, data->lock, &data=
->orig_oid,
>     -+                                          transaction->logmsg, 0, e=
rr);
>     -+          if (special_ret) {
>     -+                  error("unable to write current sha1 into %s: %s",
>     -+                        transaction->new_refname, err->buf);
>     -+                  data->lock =3D NULL;
>     -+                  files_transaction_abort(ref_store, transaction, e=
rr);
>     -+                  return special_ret;
>     -+          } else if (data->destination_log_backed_up) {
>     -+                  struct strbuf path =3D STRBUF_INIT;
>     ++          if (update) {
>     ++                  struct ref_copy_or_rename_update *operation =3D
>     ++                          update->copy_or_rename;
>     ++                  struct files_copy_or_rename_transaction_data *dat=
a =3D
>     ++                          transaction->backend_data;
>     ++                  int special_ret;
>     ++
>     ++                  special_ret =3D commit_ref_update(refs, data->loc=
k, &data->orig_oid,
>     ++                                                  operation->logmsg=
, 0, err);
>     ++                  if (special_ret) {
>     ++                          error("unable to write current sha1 into =
%s: %s",
>     ++                                update->refname, err->buf);
>     ++                          data->lock =3D NULL;
>     ++                          files_transaction_abort(ref_store, transa=
ction, err);
>     ++                          return special_ret;
>     ++                  } else if (data->destination_log_backed_up) {
>     ++                          struct strbuf path =3D STRBUF_INIT;
>      +
>     -+                  files_reflog_path(refs, &path, TMP_RENAMED_LOG_DE=
STINATION);
>     -+                  if (unlink(path.buf) < 0 && errno !=3D ENOENT)
>     -+                          warning_errno("unable to remove '%s'", pa=
th.buf);
>     -+                  strbuf_release(&path);
>     ++                          files_reflog_path(refs, &path, TMP_RENAME=
D_LOG_DESTINATION);
>     ++                          if (unlink(path.buf) < 0 && errno !=3D EN=
OENT)
>     ++                                  warning_errno("unable to remove '=
%s'", path.buf);
>     ++                          strbuf_release(&path);
>     ++                  }
>     ++                  free(data->destination_target);
>     ++                  free(data);
>     ++                  transaction->backend_data =3D NULL;
>     ++                  transaction->state =3D REF_TRANSACTION_CLOSED;
>     ++                  return special_ret;
>      +          }
>     -+          free(data->destination_target);
>     -+          free(data);
>     -+          transaction->backend_data =3D NULL;
>     -+          transaction->state =3D REF_TRANSACTION_CLOSED;
>     -+          return special_ret;
>      +  }
>
>         if (transaction->flags & REF_TRANSACTION_FLAG_INITIAL)
>     @@ refs/files-backend.c: static int files_transaction_finish(struct r=
ef_store *ref_
>         struct files_ref_store *refs =3D
>                 files_downcast(ref_store, 0, "ref_transaction_abort");
>
>     -+  if (transaction->type !=3D REF_TRANSACTION_TYPE_NORMAL) {
>     -+          struct files_copy_or_rename_transaction_data *data =3D
>     -+                  transaction->backend_data;
>     -+          struct strbuf new_log =3D STRBUF_INIT;
>     -+          struct strbuf destination_log =3D STRBUF_INIT;
>     -+          struct strbuf temporary_log =3D STRBUF_INIT;
>     -+          struct ref_transaction *restore_transaction =3D NULL;
>     -+          struct ref_lock *lock;
>     -+          int ret =3D 0;
>     ++  {
>     ++          struct ref_update *update =3D
>     ++                  ref_transaction_copy_or_rename_update(transaction=
);
>      +
>     -+          if (data->lock)
>     -+                  unlock_ref(data->lock);
>     -+          if (transaction->type =3D=3D REF_TRANSACTION_TYPE_RENAME)=
 {
>     -+                  lock =3D lock_ref_oid_basic(refs, transaction->ol=
d_refname, err);
>     -+                  if (!lock ||
>     -+                      write_ref_to_lockfile(refs, lock, &data->orig=
_oid, err) ||
>     -+                      commit_ref_update(refs, lock, &data->orig_oid=
, NULL,
>     -+                                        REF_SKIP_CREATE_REFLOG, err=
))
>     -+                          ret =3D -1;
>     -+          }
>     ++          if (update) {
>     ++                  struct ref_copy_or_rename_update *operation =3D
>     ++                          update->copy_or_rename;
>     ++                  struct files_copy_or_rename_transaction_data *dat=
a =3D
>     ++                          transaction->backend_data;
>     ++                  struct strbuf new_log =3D STRBUF_INIT;
>     ++                  struct strbuf destination_log =3D STRBUF_INIT;
>     ++                  struct strbuf temporary_log =3D STRBUF_INIT;
>     ++                  struct ref_transaction *restore_transaction =3D N=
ULL;
>     ++                  struct ref_lock *lock;
>     ++                  int ret =3D 0;
>      +
>     -+          if (data->logmoved) {
>     -+                  files_reflog_path(refs, &new_log, transaction->ne=
w_refname);
>     -+                  if (transaction->type =3D=3D REF_TRANSACTION_TYPE=
_RENAME) {
>     -+                          files_reflog_path(refs, &temporary_log, T=
MP_RENAMED_LOG);
>     -+                          if (rename(new_log.buf, temporary_log.buf=
) < 0) {
>     -+                                  strbuf_addf(err, "unable to resto=
re logfile %s: %s",
>     -+                                              transaction->old_refn=
ame, strerror(errno));
>     ++                  if (data->lock)
>     ++                          unlock_ref(data->lock);
>     ++                  if (operation->type =3D=3D REF_UPDATE_RENAME) {
>     ++                          lock =3D lock_ref_oid_basic(refs, operati=
on->old_refname, err);
>     ++                          if (!lock ||
>     ++                              write_ref_to_lockfile(refs, lock, &da=
ta->orig_oid, err) ||
>     ++                              commit_ref_update(refs, lock, &data->=
orig_oid, NULL,
>     ++                                                REF_SKIP_CREATE_REF=
LOG, err))
>      +                                  ret =3D -1;
>     -+                          } else {
>     -+                                  try_remove_empty_parents(refs,
>     -+                                                   transaction->new=
_refname,
>     -+                                                   REMOVE_EMPTY_PAR=
ENTS_REFLOG);
>     -+                                  if (rename_tmp_log(refs,
>     -+                                                     transaction->o=
ld_refname)) {
>     ++                  }
>     ++
>     ++                  if (data->logmoved) {
>     ++                          files_reflog_path(refs, &new_log, update-=
>refname);
>     ++                          if (operation->type =3D=3D REF_UPDATE_REN=
AME) {
>     ++                                  files_reflog_path(refs, &temporar=
y_log, TMP_RENAMED_LOG);
>     ++                                  if (rename(new_log.buf, temporary=
_log.buf) < 0) {
>      +                                          strbuf_addf(err, "unable =
to restore logfile %s: %s",
>     -+                                                      transaction->=
old_refname,
>     -+                                                      strerror(errn=
o));
>     ++                                                      operation->ol=
d_refname, strerror(errno));
>      +                                          ret =3D -1;
>     ++                                  } else {
>     ++                                          try_remove_empty_parents(=
refs,
>     ++                                                                   =
update->refname,
>     ++                                                                   =
REMOVE_EMPTY_PARENTS_REFLOG);
>     ++                                          if (rename_tmp_log(refs,
>     ++                                                             operat=
ion->old_refname)) {
>     ++                                                  strbuf_addf(err, =
"unable to restore logfile %s: %s",
>     ++                                                              opera=
tion->old_refname,
>     ++                                                              strer=
ror(errno));
>     ++                                                  ret =3D -1;
>     ++                                          }
>      +                                  }
>     ++                          } else if (unlink(new_log.buf) < 0 && err=
no !=3D ENOENT) {
>     ++                                  strbuf_addf(err, "unable to remov=
e logfile %s: %s",
>     ++                                              update->refname, stre=
rror(errno));
>     ++                                  ret =3D -1;
>      +                          }
>     -+                  } else if (unlink(new_log.buf) < 0 && errno !=3D =
ENOENT) {
>     -+                          strbuf_addf(err, "unable to remove logfil=
e %s: %s",
>     -+                                      transaction->new_refname, str=
error(errno));
>     -+                          ret =3D -1;
>      +                  }
>     -+          }
>     -+          if (data->destination_log_backed_up) {
>     -+                  files_reflog_path(refs, &destination_log,
>     -+                                     TMP_RENAMED_LOG_DESTINATION);
>     -+                  if (rename(destination_log.buf, new_log.buf) < 0)=
 {
>     -+                          strbuf_addf(err, "unable to restore logfi=
le %s: %s",
>     -+                                      transaction->new_refname, str=
error(errno));
>     -+                          ret =3D -1;
>     ++                  if (data->destination_log_backed_up) {
>     ++                          files_reflog_path(refs, &destination_log,
>     ++                                            TMP_RENAMED_LOG_DESTINA=
TION);
>     ++                          if (rename(destination_log.buf, new_log.b=
uf) < 0) {
>     ++                                  strbuf_addf(err, "unable to resto=
re logfile %s: %s",
>     ++                                              update->refname, stre=
rror(errno));
>     ++                                  ret =3D -1;
>     ++                          }
>      +                  }
>     -+          }
>      +
>     -+          if (transaction->type =3D=3D REF_TRANSACTION_TYPE_RENAME =
&&
>     -+              data->destination_exists) {
>     -+                  restore_transaction =3D ref_store_transaction_beg=
in(
>     ++                  if (operation->type =3D=3D REF_UPDATE_RENAME &&
>     ++                      data->destination_exists) {
>     ++                          restore_transaction =3D ref_store_transac=
tion_begin(
>      +                                  &refs->base, REF_TRANSACTION_FLAG=
_SKIP_HOOK, err);
>     -+                  if (!restore_transaction ||
>     -+                      ref_transaction_update(restore_transaction,
>     -+                                             transaction->new_refna=
me,
>     -+                                             data->destination_targ=
et ? NULL :
>     -+                                                  &data->destinatio=
n_oid,
>     -+                                             NULL,
>     -+                                             data->destination_targ=
et,
>     -+                                             NULL,
>     -+                                             REF_NO_DEREF |
>     -+                                                  REF_SKIP_CREATE_R=
EFLOG,
>     -+                                             NULL, err) ||
>     -+                      ref_transaction_commit(restore_transaction, e=
rr))
>     -+                          ret =3D -1;
>     -+                  ref_transaction_free(restore_transaction);
>     -+          }
>     ++                          if (!restore_transaction ||
>     ++                              ref_transaction_update(restore_transa=
ction,
>     ++                                                     update->refnam=
e,
>     ++                                                     data->destinat=
ion_target ? NULL :
>     ++                                                                   =
             &data->destination_oid,
>     ++                                                     NULL,
>     ++                                                     data->destinat=
ion_target,
>     ++                                                     NULL,
>     ++                                                     REF_NO_DEREF |
>     ++                                                             REF_SK=
IP_CREATE_REFLOG,
>     ++                                                     NULL, err) ||
>     ++                              ref_transaction_commit(restore_transa=
ction, err))
>     ++                                  ret =3D -1;
>     ++                          ref_transaction_free(restore_transaction)=
;
>     ++                  }
>      +
>     -+          strbuf_release(&destination_log);
>     -+          strbuf_release(&temporary_log);
>     -+          strbuf_release(&new_log);
>     -+          free(data->destination_target);
>     -+          free(data);
>     -+          transaction->backend_data =3D NULL;
>     -+          transaction->state =3D REF_TRANSACTION_CLOSED;
>     -+          return ret;
>     ++                  strbuf_release(&destination_log);
>     ++                  strbuf_release(&temporary_log);
>     ++                  strbuf_release(&new_log);
>     ++                  free(data->destination_target);
>     ++                  free(data);
>     ++                  transaction->backend_data =3D NULL;
>     ++                  transaction->state =3D REF_TRANSACTION_CLOSED;
>     ++                  return ret;
>     ++          }
>      +  }
>      +
>         files_transaction_cleanup(refs, transaction);
>     @@ refs/packed-backend.c: struct ref_storage_be refs_be_packed =3D {
>         .read_raw_ref =3D packed_read_raw_ref,
>
>       ## refs/refs-internal.h ##
>     +@@ refs/refs-internal.h: struct ref_update {
>     +    */
>     +   struct ref_update *parent_update;
>     +
>     ++  /*
>     ++   * Copy and rename operations require backend-specific handling w=
hile
>     ++   * still exposing their logical updates to transaction hooks. Kee=
p that
>     ++   * state on the destination update so it composes with other upda=
tes in
>     ++   * the transaction instead of making copy or rename a transaction=
-wide
>     ++   * property.
>     ++   */
>     ++  struct ref_copy_or_rename_update *copy_or_rename;
>     ++
>     +   const char refname[FLEX_ARRAY];
>     + };
>     +
>     ++enum ref_copy_or_rename_type {
>     ++  REF_UPDATE_RENAME,
>     ++  REF_UPDATE_COPY,
>     ++};
>     ++
>     ++struct ref_copy_or_rename_update {
>     ++  enum ref_copy_or_rename_type type;
>     ++  char *old_refname;
>     ++  char *logmsg;
>     ++  struct object_id source_oid;
>     ++  struct object_id destination_oid;
>     ++  char *destination_target;
>     ++  unsigned int destination_exists:1;
>     ++};
>     ++
>     + int refs_read_raw_ref(struct ref_store *ref_store, const char *refn=
ame,
>     +                 struct object_id *oid, struct strbuf *referent,
>     +                 unsigned int *type, int *failure_errno);
>      @@ refs/refs-internal.h: struct ref_update *ref_transaction_add_upda=
te(
>                 const char *committer_info,
>                 const char *msg);
>     @@ refs/refs-internal.h: struct ref_update *ref_transaction_add_updat=
e(
>       /*
>        * Transaction states.
>        *
>     -@@ refs/refs-internal.h: enum ref_transaction_state {
>     -   REF_TRANSACTION_CLOSED   =3D 2
>     - };
>     -
>     -+enum ref_transaction_type {
>     -+  REF_TRANSACTION_TYPE_NORMAL =3D 0,
>     -+  REF_TRANSACTION_TYPE_RENAME,
>     -+  REF_TRANSACTION_TYPE_COPY,
>     -+};
>     -+
>     - /*
>     -  * Data structure to hold indices of updates which were rejected, f=
or batched
>     -  * reference updates. While the updates themselves hold the rejecti=
on error,
>      @@ refs/refs-internal.h: struct ref_transaction {
>     -   void *backend_data;
>     -   unsigned int flags;
>         uint64_t max_index;
>     -+
>     -+  /*
>     -+   * Rename and copy operations need backend-specific reflog handli=
ng.
>     -+   * Their logical updates still live in `updates`, so hooks see th=
e
>     -+   * operation like any other reference transaction. The fields bel=
ow
>     -+   * retain the state that backends verify after taking their locks=
.
>     -+   */
>     -+  enum ref_transaction_type type;
>     -+  char *old_refname;
>     -+  char *new_refname;
>     -+  char *logmsg;
>     -+  struct object_id source_oid;
>     -+  struct object_id destination_oid;
>     -+  char *destination_target;
>     -+  unsigned int destination_exists:1;
>       };
>
>     ++/* Suppress hooks for a transaction nested inside another refs oper=
ation. */
>     ++#define REF_TRANSACTION_FLAG_SKIP_HOOK (1 << 2)
>     ++
>     ++struct ref_update *ref_transaction_copy_or_rename_update(
>     ++  struct ref_transaction *transaction);
>     ++
>       /*
>     +  * Check for entries in extras that are within the specified
>     +  * directory, where dirname is a reference directory name including
>      @@ refs/refs-internal.h: typedef int optimize_required_fn(struct ref=
_store *ref_store,
>                                  struct refs_optimize_opts *opts,
>                                  bool *required);
>     @@ refs/reftable-backend.c: static int reftable_be_transaction_prepar=
e(struct ref_s
>         size_t i;
>         int ret;
>
>     -+  if (transaction->type !=3D REF_TRANSACTION_TYPE_NORMAL)
>     ++  if (ref_transaction_copy_or_rename_update(transaction))
>      +          return reftable_be_copy_or_rename_prepare(ref_store, tran=
saction,
>      +                                                     err);
>      +
>     @@ refs/reftable-backend.c: static int reftable_be_transaction_abort(=
struct ref_sto
>      -  struct reftable_transaction_data *tx_data =3D transaction->backen=
d_data;
>      +  struct reftable_transaction_data *tx_data;
>      +
>     -+  if (transaction->type !=3D REF_TRANSACTION_TYPE_NORMAL) {
>     ++  if (ref_transaction_copy_or_rename_update(transaction)) {
>      +          struct reftable_copy_or_rename_transaction_data *data =3D
>      +                  transaction->backend_data;
>      +
>     @@ refs/reftable-backend.c: static int reftable_be_transaction_finish=
(struct ref_st
>      +  struct reftable_transaction_data *tx_data;
>         int ret =3D 0;
>
>     -+  if (transaction->type !=3D REF_TRANSACTION_TYPE_NORMAL) {
>     ++  if (ref_transaction_copy_or_rename_update(transaction)) {
>      +          struct reftable_copy_or_rename_transaction_data *data =3D
>      +                  transaction->backend_data;
>      +          int special_ret =3D reftable_addition_commit(data->additi=
on);
>     @@ refs/reftable-backend.c: struct write_create_symref_arg {
>         const char *newname;
>         const char *logmsg;
>         int delete_old;
>     -+  struct ref_transaction *transaction;
>     ++  struct ref_copy_or_rename_update *operation;
>       };
>
>       static int write_copy_table(struct reftable_writer *writer, void *c=
b_data)
>     @@ refs/reftable-backend.c: static int write_copy_table(struct reftab=
le_writer *wri
>      +          ret =3D -1;
>                 goto done;
>         }
>     -+  if (arg->transaction) {
>     ++  if (arg->operation) {
>      +          struct object_id oid;
>      +
>      +          if (old_ref.value_type =3D=3D REFTABLE_REF_VAL2)
>     @@ refs/reftable-backend.c: static int write_copy_table(struct reftab=
le_writer *wri
>      +          else
>      +                  oidread(&oid, old_ref.value.val1,
>      +                          arg->refs->base.repo->hash_algo);
>     -+          if (!oideq(&oid, &arg->transaction->source_oid)) {
>     ++          if (!oideq(&oid, &arg->operation->source_oid)) {
>      +                  strbuf_addf(arg->err,
>      +                              _("refname %s is at %s but expected %=
s"),
>      +                              arg->oldname, oid_to_hex(&oid),
>     -+                              oid_to_hex(&arg->transaction->source_=
oid));
>     ++                              oid_to_hex(&arg->operation->source_oi=
d));
>      +                  ret =3D -1;
>      +                  goto done;
>      +          }
>     @@ refs/reftable-backend.c: static int write_copy_table(struct reftab=
le_writer *wri
>      +                                        &destination_ref);
>      +          if (ret < 0)
>      +                  goto done;
>     -+          if (arg->transaction->destination_exists !=3D !ret) {
>     ++          if (arg->operation->destination_exists !=3D !ret) {
>      +                  strbuf_addf(arg->err,
>      +                              _("refname %s changed while renaming"=
),
>      +                              arg->newname);
>     @@ refs/reftable-backend.c: static int write_copy_table(struct reftab=
le_writer *wri
>      +          }
>      +          if (!ret) {
>      +                  if (destination_ref.value_type =3D=3D REFTABLE_RE=
F_SYMREF) {
>     -+                          if (!arg->transaction->destination_target=
 ||
>     ++                          if (!arg->operation->destination_target |=
|
>      +                              strcmp(destination_ref.value.symref,
>     -+                                     arg->transaction->destination_=
target)) {
>     ++                                     arg->operation->destination_ta=
rget)) {
>      +                                  strbuf_addf(arg->err,
>      +                                              _("refname %s changed=
 while renaming"),
>      +                                              arg->newname);
>     @@ refs/reftable-backend.c: static int write_copy_table(struct reftab=
le_writer *wri
>      +                          else
>      +                                  oidread(&oid, destination_ref.val=
ue.val1,
>      +                                          arg->refs->base.repo->has=
h_algo);
>     -+                          if (arg->transaction->destination_target =
||
>     -+                              !oideq(&oid, &arg->transaction->desti=
nation_oid)) {
>     ++                          if (arg->operation->destination_target ||
>     ++                              !oideq(&oid, &arg->operation->destina=
tion_oid)) {
>      +                                  strbuf_addf(arg->err,
>      +                                              _("refname %s changed=
 while renaming"),
>      +                                              arg->newname);
>     @@ refs/reftable-backend.c: static int write_copy_table(struct reftab=
le_writer *wri
>      +          reftable_be_downcast(ref_store, REF_STORE_WRITE,
>      +                               "ref_transaction_prepare");
>      +  struct reftable_copy_or_rename_transaction_data *data =3D NULL;
>     ++  struct ref_update *update =3D
>     ++          ref_transaction_copy_or_rename_update(transaction);
>     ++  struct ref_copy_or_rename_update *operation =3D update->copy_or_r=
ename;
>         struct write_copy_arg arg =3D {
>                 .refs =3D refs,
>      -          .oldname =3D oldrefname,
>     @@ refs/reftable-backend.c: static int write_copy_table(struct reftab=
le_writer *wri
>      -          .logmsg =3D logmsg,
>      -          .delete_old =3D 1,
>      +          .err =3D err,
>     -+          .oldname =3D transaction->old_refname,
>     -+          .newname =3D transaction->new_refname,
>     -+          .logmsg =3D transaction->logmsg,
>     -+          .delete_old =3D transaction->type =3D=3D REF_TRANSACTION_=
TYPE_RENAME,
>     -+          .transaction =3D transaction,
>     ++          .oldname =3D operation->old_refname,
>     ++          .newname =3D update->refname,
>     ++          .logmsg =3D operation->logmsg,
>     ++          .delete_old =3D operation->type =3D=3D REF_UPDATE_RENAME,
>     ++          .operation =3D operation,
>         };
>         int ret;
>
>     @@ refs/reftable-backend.c: static int write_copy_table(struct reftab=
le_writer *wri
>                 goto done;
>      -
>      -  ret =3D backend_for(&arg.be, refs, newrefname, &newrefname, 1);
>     -+  ret =3D backend_for(&arg.be, refs, transaction->new_refname,
>     ++  ret =3D backend_for(&arg.be, refs, update->refname,
>      +                    &arg.newname, 1);
>         if (ret)
>                 goto done;
>
>  refs.c                           | 161 ++++++++++++++---
>  refs/debug.c                     |  25 ---
>  refs/files-backend.c             | 297 +++++++++++++++++++++++++++----
>  refs/packed-backend.c            |   2 -
>  refs/refs-internal.h             |  47 +++--
>  refs/reftable-backend.c          | 197 +++++++++++++++-----
>  t/t1416-ref-transaction-hooks.sh | 142 +++++++++++++++
>  7 files changed, 732 insertions(+), 139 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 92d5df5b7..f036ae4b9 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1004,15 +1004,17 @@ long get_files_ref_lock_timeout_ms(struct reposit=
ory *repo)
>         return timeout_ms;
>  }
>
> -int refs_delete_ref(struct ref_store *refs, const char *msg,
> -                   const char *refname,
> -                   const struct object_id *old_oid,
> -                   unsigned int flags)
> +int refs_delete_ref_with_transaction_flags(struct ref_store *refs,
> +                                          const char *msg,
> +                                          const char *refname,
> +                                          const struct object_id *old_oi=
d,
> +                                          unsigned int flags,
> +                                          unsigned int transaction_flags=
)
>  {
>         struct ref_transaction *transaction;
>         struct strbuf err =3D STRBUF_INIT;
>
> -       transaction =3D ref_store_transaction_begin(refs, 0, &err);
> +       transaction =3D ref_store_transaction_begin(refs, transaction_fla=
gs, &err);
>         if (!transaction ||
>             ref_transaction_delete(transaction, refname, old_oid,
>                                    NULL, flags, msg, &err) ||
> @@ -1027,6 +1029,15 @@ int refs_delete_ref(struct ref_store *refs, const =
char *msg,
>         return 0;
>  }
>
> +int refs_delete_ref(struct ref_store *refs, const char *msg,
> +                   const char *refname,
> +                   const struct object_id *old_oid,
> +                   unsigned int flags)
> +{
> +       return refs_delete_ref_with_transaction_flags(refs, msg, refname,
> +                                                     old_oid, flags, 0);
> +}
> +
>  static void copy_reflog_msg(struct strbuf *sb, const char *msg)
>  {
>         char c;
> @@ -1256,11 +1267,20 @@ void ref_transaction_free(struct ref_transaction =
*transaction)
>         }
>
>         for (i =3D 0; i < transaction->nr; i++) {
> +               struct ref_copy_or_rename_update *operation =3D
> +                       transaction->updates[i]->copy_or_rename;
> +
>                 free(transaction->updates[i]->msg);
>                 free(transaction->updates[i]->committer_info);
>                 free((char *)transaction->updates[i]->new_target);
>                 free((char *)transaction->updates[i]->old_target);
>                 free((char *)transaction->updates[i]->rejection_details);
> +               if (operation) {
> +                       free(operation->old_refname);
> +                       free(operation->logmsg);
> +                       free(operation->destination_target);
> +                       free(operation);
> +               }
>                 free(transaction->updates[i]);
>         }
>
> @@ -1273,6 +1293,23 @@ void ref_transaction_free(struct ref_transaction *=
transaction)
>         free(transaction);
>  }
>
> +struct ref_update *ref_transaction_copy_or_rename_update(
> +       struct ref_transaction *transaction)
> +{
> +       struct ref_update *operation =3D NULL;
> +       size_t i;
> +
> +       for (i =3D 0; i < transaction->nr; i++) {
> +               if (!transaction->updates[i]->copy_or_rename)
> +                       continue;
> +               if (operation)
> +                       BUG("multiple copy or rename updates in one trans=
action");
> +               operation =3D transaction->updates[i];
> +       }
> +
> +       return operation;
> +}
> +
>  int ref_transaction_maybe_set_rejected(struct ref_transaction *transacti=
on,
>                                        size_t update_idx,
>                                        enum ref_transaction_error err,
> @@ -2710,7 +2747,8 @@ int ref_transaction_prepare(struct ref_transaction =
*transaction,
>                 return REF_TRANSACTION_ERROR_GENERIC;
>
>         /* Preparing checks before locking references */
> -       ret =3D run_transaction_hook(transaction, "preparing");
> +       ret =3D transaction->flags & REF_TRANSACTION_FLAG_SKIP_HOOK ? 0 :
> +               run_transaction_hook(transaction, "preparing");
>         if (ret) {
>                 ref_transaction_abort(transaction, err);
>                 die(_(abort_by_ref_transaction_hook), "preparing");
> @@ -2720,7 +2758,8 @@ int ref_transaction_prepare(struct ref_transaction =
*transaction,
>         if (ret)
>                 return ret;
>
> -       ret =3D run_transaction_hook(transaction, "prepared");
> +       ret =3D transaction->flags & REF_TRANSACTION_FLAG_SKIP_HOOK ? 0 :
> +               run_transaction_hook(transaction, "prepared");
>         if (ret) {
>                 ref_transaction_abort(transaction, err);
>                 die(_(abort_by_ref_transaction_hook), "prepared");
> @@ -2750,7 +2789,8 @@ int ref_transaction_abort(struct ref_transaction *t=
ransaction,
>                 break;
>         }
>
> -       run_transaction_hook(transaction, "aborted");
> +       if (!(transaction->flags & REF_TRANSACTION_FLAG_SKIP_HOOK))
> +               run_transaction_hook(transaction, "aborted");
>
>         ref_transaction_free(transaction);
>         return ret;
> @@ -2781,7 +2821,8 @@ int ref_transaction_commit(struct ref_transaction *=
transaction,
>         }
>
>         ret =3D refs->be->transaction_finish(refs, transaction, err);
> -       if (!ret && !(transaction->flags & REF_TRANSACTION_FLAG_INITIAL))
> +       if (!ret && !(transaction->flags & (REF_TRANSACTION_FLAG_INITIAL =
|
> +                                        REF_TRANSACTION_FLAG_SKIP_HOOK))=
)
>                 run_transaction_hook(transaction, "committed");
>         return ret;
>  }
> @@ -3123,28 +3164,102 @@ int refs_delete_refs(struct ref_store *refs, con=
st char *logmsg,
>         return ret;
>  }
>
> -int refs_rename_ref(struct ref_store *refs, const char *oldref,
> -                   const char *newref, const char *logmsg)
> +static int refs_copy_or_rename_ref(struct ref_store *refs, const char *o=
ldref,
> +                                  const char *newref, const char *logmsg=
,
> +                                  bool copy)
>  {
> -       char *msg;
> -       int retval;
> +       struct ref_transaction *transaction =3D NULL;
> +       struct ref_copy_or_rename_update *operation =3D NULL;
> +       struct ref_update *destination_update;
> +       struct object_id old_oid, new_oid;
> +       struct strbuf new_target =3D STRBUF_INIT;
> +       struct strbuf err =3D STRBUF_INIT;
> +       char *msg =3D normalize_reflog_message(logmsg);
> +       int old_flags, new_flags =3D 0, new_exists =3D 0, ret =3D 1;
>
> -       msg =3D normalize_reflog_message(logmsg);
> -       retval =3D refs->be->rename_ref(refs, oldref, newref, msg);
> +       if (!strcmp(oldref, newref)) {
> +               ret =3D 0;
> +               goto out;
> +       }
> +
> +       if (!refs_resolve_ref_unsafe(refs, oldref,
> +                                    RESOLVE_REF_READING | RESOLVE_REF_NO=
_RECURSE,
> +                                    &old_oid, &old_flags)) {
> +               error("refname %s not found", oldref);
> +               goto out;
> +       }
> +       if (old_flags & REF_ISSYMREF) {
> +               error("refname %s is a symbolic ref, %s it is not support=
ed",
> +                     oldref, copy ? "copying" : "renaming");
> +               goto out;
> +       }
> +
> +       transaction =3D ref_store_transaction_begin(refs, 0, &err);
> +       if (!transaction)
> +               goto error;
> +       if (!copy && ref_transaction_delete(transaction, oldref, &old_oid=
, NULL,
> +                                           REF_NO_DEREF, msg, &err))
> +               goto error;
> +
> +       if (refs_resolve_ref_unsafe(refs, newref,
> +                                   RESOLVE_REF_READING | RESOLVE_REF_NO_=
RECURSE,
> +                                   &new_oid, &new_flags)) {
> +               new_exists =3D 1;
> +               if ((new_flags & REF_ISSYMREF) &&
> +                   refs_read_symbolic_ref(refs, newref, &new_target) < 0=
) {
> +                       strbuf_addf(&err, "unable to read symbolic ref %s=
", newref);
> +                       goto error;
> +               }
> +       } else {
> +               oidclr(&new_oid, refs->repo->hash_algo);
> +       }
> +       if (ref_transaction_update(transaction, newref, &old_oid,
> +                                  (new_flags & REF_ISSYMREF) ? NULL : &n=
ew_oid,
> +                                  NULL,
> +                                  (new_flags & REF_ISSYMREF) ? new_targe=
t.buf : NULL,
> +                                  REF_NO_DEREF | REF_SKIP_CREATE_REFLOG,
> +                                  NULL, &err))
> +               goto error;
> +
> +       destination_update =3D transaction->updates[transaction->nr - 1];
> +       CALLOC_ARRAY(operation, 1);
> +       operation->type =3D copy ? REF_UPDATE_COPY : REF_UPDATE_RENAME;
> +       operation->old_refname =3D xstrdup(oldref);
> +       operation->logmsg =3D xstrdup(msg);
> +       oidcpy(&operation->source_oid, &old_oid);
> +       operation->destination_exists =3D new_exists;
> +       if (new_flags & REF_ISSYMREF)
> +               operation->destination_target =3D xstrdup(new_target.buf)=
;
> +       else if (operation->destination_exists)
> +               oidcpy(&operation->destination_oid, &new_oid);
> +       destination_update->copy_or_rename =3D operation;
> +
> +       if (ref_transaction_commit(transaction, &err))
> +               goto error;
> +
> +       ret =3D 0;
> +       goto out;
> +
> +error:
> +       error("%s", err.buf);
> +out:
> +       ref_transaction_free(transaction);
> +       strbuf_release(&new_target);
> +       strbuf_release(&err);
>         free(msg);
> -       return retval;
> +       return ret;
>  }
>
> -int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
> +int refs_rename_ref(struct ref_store *refs, const char *oldref,
>                     const char *newref, const char *logmsg)
>  {
> -       char *msg;
> -       int retval;
> +       return refs_copy_or_rename_ref(refs, oldref, newref, logmsg, 0);
> +}
>
> -       msg =3D normalize_reflog_message(logmsg);
> -       retval =3D refs->be->copy_ref(refs, oldref, newref, msg);
> -       free(msg);
> -       return retval;
> +int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
> +                   const char *newref, const char *logmsg)
> +{
> +       return refs_copy_or_rename_ref(refs, oldref, newref, logmsg, 1);
>  }
>
>  const char *ref_update_original_update_refname(struct ref_update *update=
)
> diff --git a/refs/debug.c b/refs/debug.c
> index 639db0f26..87b84e767 100644
> --- a/refs/debug.c
> +++ b/refs/debug.c
> @@ -143,28 +143,6 @@ static int debug_optimize_required(struct ref_store =
*ref_store,
>         return res;
>  }
>
> -static int debug_rename_ref(struct ref_store *ref_store, const char *old=
ref,
> -                           const char *newref, const char *logmsg)
> -{
> -       struct debug_ref_store *drefs =3D (struct debug_ref_store *)ref_s=
tore;
> -       int res =3D drefs->refs->be->rename_ref(drefs->refs, oldref, newr=
ef,
> -                                             logmsg);
> -       trace_printf_key(&trace_refs, "rename_ref: %s -> %s \"%s\": %d\n"=
, oldref, newref,
> -               logmsg, res);
> -       return res;
> -}
> -
> -static int debug_copy_ref(struct ref_store *ref_store, const char *oldre=
f,
> -                         const char *newref, const char *logmsg)
> -{
> -       struct debug_ref_store *drefs =3D (struct debug_ref_store *)ref_s=
tore;
> -       int res =3D
> -               drefs->refs->be->copy_ref(drefs->refs, oldref, newref, lo=
gmsg);
> -       trace_printf_key(&trace_refs, "copy_ref: %s -> %s \"%s\": %d\n", =
oldref, newref,
> -               logmsg, res);
> -       return res;
> -}
> -
>  struct debug_ref_iterator {
>         struct ref_iterator base;
>         struct ref_iterator *iter;
> @@ -453,9 +431,6 @@ struct ref_storage_be refs_be_debug =3D {
>         .optimize =3D debug_optimize,
>         .optimize_required =3D debug_optimize_required,
>
> -       .rename_ref =3D debug_rename_ref,
> -       .copy_ref =3D debug_copy_ref,
> -
>         .iterator_begin =3D debug_ref_iterator_begin,
>         .read_raw_ref =3D debug_read_raw_ref,
>         .read_symbolic_ref =3D debug_read_symbolic_ref,
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 71628550f..c28228116 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1594,6 +1594,7 @@ static int files_optimize_required(struct ref_store=
 *ref_store,
>   * live into logs/refs.
>   */
>  #define TMP_RENAMED_LOG  "refs/.tmp-renamed-log"
> +#define TMP_RENAMED_LOG_DESTINATION "refs/.tmp-renamed-log-destination"
>
>  struct rename_cb {
>         const char *tmp_renamed_log;
> @@ -1685,12 +1686,28 @@ static int refs_rename_ref_available(struct ref_s=
tore *refs,
>         return ok;
>  }
>
> +struct files_copy_or_rename_transaction_data {
> +       struct ref_lock *lock;
> +       struct object_id orig_oid;
> +       struct object_id destination_oid;
> +       char *destination_target;
> +       int logmoved;
> +       int destination_exists;
> +       int destination_log_backed_up;
> +};
> +
>  static int files_copy_or_rename_ref(struct ref_store *ref_store,
> -                           const char *oldrefname, const char *newrefnam=
e,
> -                           const char *logmsg, int copy)
> +                                   struct ref_update *update,
> +                                   struct ref_transaction *transaction)
>  {
>         struct files_ref_store *refs =3D
> -               files_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
> +               files_downcast(ref_store, REF_STORE_WRITE,
> +                              "ref_transaction_prepare");
> +       struct ref_copy_or_rename_update *operation =3D update->copy_or_r=
ename;
> +       const char *oldrefname =3D operation->old_refname;
> +       const char *newrefname =3D update->refname;
> +       const char *logmsg =3D operation->logmsg;
> +       bool copy =3D operation->type =3D=3D REF_UPDATE_COPY;
>         struct object_id orig_oid;
>         int flag =3D 0, logmoved =3D 0;
>         struct ref_lock *lock;
> @@ -1698,12 +1715,19 @@ static int files_copy_or_rename_ref(struct ref_st=
ore *ref_store,
>         struct strbuf sb_oldref =3D STRBUF_INIT;
>         struct strbuf sb_newref =3D STRBUF_INIT;
>         struct strbuf tmp_renamed_log =3D STRBUF_INIT;
> +       struct strbuf tmp_destination_log =3D STRBUF_INIT;
> +       struct strbuf destination_target =3D STRBUF_INIT;
>         int log, ret;
> +       int destination_exists =3D 0, destination_flags =3D 0;
> +       int destination_log_backed_up =3D 0;
> +       struct object_id destination_oid;
> +       struct files_copy_or_rename_transaction_data *data;
>         struct strbuf err =3D STRBUF_INIT;
>
>         files_reflog_path(refs, &sb_oldref, oldrefname);
>         files_reflog_path(refs, &sb_newref, newrefname);
>         files_reflog_path(refs, &tmp_renamed_log, TMP_RENAMED_LOG);
> +       files_reflog_path(refs, &tmp_destination_log, TMP_RENAMED_LOG_DES=
TINATION);
>
>         log =3D !lstat(sb_oldref.buf, &loginfo);
>         if (log && S_ISLNK(loginfo.st_mode)) {
> @@ -1727,11 +1751,67 @@ static int files_copy_or_rename_ref(struct ref_st=
ore *ref_store,
>                                     oldrefname);
>                 goto out;
>         }
> +       if (!oideq(&orig_oid, &operation->source_oid)) {
> +               ret =3D error("refname %s is at %s but expected %s",
> +                           oldrefname, oid_to_hex(&orig_oid),
> +                           oid_to_hex(&operation->source_oid));
> +               goto out;
> +       }
>         if (!refs_rename_ref_available(&refs->base, oldrefname, newrefnam=
e)) {
>                 ret =3D 1;
>                 goto out;
>         }
>
> +       if (refs_resolve_ref_unsafe(&refs->base, newrefname,
> +                                   RESOLVE_REF_READING | RESOLVE_REF_NO_=
RECURSE,
> +                                   &destination_oid, &destination_flags)=
) {
> +               destination_exists =3D 1;
> +               if ((destination_flags & REF_ISSYMREF) &&
> +                   refs_read_symbolic_ref(&refs->base, newrefname,
> +                                          &destination_target) < 0) {
> +                       ret =3D error("unable to read symbolic ref %s", n=
ewrefname);
> +                       goto out;
> +               }
> +       }
> +       if (destination_exists !=3D operation->destination_exists) {
> +               ret =3D error("refname %s changed while renaming", newref=
name);
> +               goto out;
> +       }
> +       if (destination_exists) {
> +               if (destination_flags & REF_ISSYMREF) {
> +                       if (!operation->destination_target ||
> +                           strcmp(destination_target.buf,
> +                                  operation->destination_target)) {
> +                               ret =3D error("refname %s changed while r=
enaming",
> +                                           newrefname);
> +                               goto out;
> +                       }
> +               } else if (operation->destination_target ||
> +                          !oideq(&destination_oid,
> +                                 &operation->destination_oid)) {
> +                       ret =3D error("refname %s changed while renaming"=
, newrefname);
> +                       goto out;
> +               }
> +       }
> +
> +       if (!lstat(sb_newref.buf, &loginfo)) {
> +               if (S_ISLNK(loginfo.st_mode)) {
> +                       ret =3D error("reflog for %s is a symlink", newre=
fname);
> +                       goto out;
> +               }
> +               if (S_ISREG(loginfo.st_mode)) {
> +                       if (copy_file(refs->base.repo, tmp_destination_lo=
g.buf,
> +                                     sb_newref.buf, 0644)) {
> +                               if (errno !=3D EEXIST)
> +                                       unlink(tmp_destination_log.buf);
> +                               ret =3D error("unable to back up logfile =
logs/%s: %s",
> +                                           newrefname, strerror(errno));
> +                               goto out;
> +                       }
> +                       destination_log_backed_up =3D 1;
> +               }
> +       }
> +
>         if (!copy && log && rename(sb_oldref.buf, tmp_renamed_log.buf)) {
>                 ret =3D error("unable to move logfile logs/%s to logs/"TM=
P_RENAMED_LOG": %s",
>                             oldrefname, strerror(errno));
> @@ -1744,8 +1824,10 @@ static int files_copy_or_rename_ref(struct ref_sto=
re *ref_store,
>                 goto out;
>         }
>
> -       if (!copy && refs_delete_ref(&refs->base, logmsg, oldrefname,
> -                           &orig_oid, REF_NO_DEREF)) {
> +       if (!copy && refs_delete_ref_with_transaction_flags(&refs->base, =
logmsg,
> +                                                        oldrefname, &ori=
g_oid,
> +                                                        REF_NO_DEREF,
> +                                                        REF_TRANSACTION_=
FLAG_SKIP_HOOK)) {
>                 error("unable to delete old %s", oldrefname);
>                 goto rollback;
>         }
> @@ -1760,8 +1842,9 @@ static int files_copy_or_rename_ref(struct ref_stor=
e *ref_store,
>         if (!copy && refs_resolve_ref_unsafe(&refs->base, newrefname,
>                                              RESOLVE_REF_READING | RESOLV=
E_REF_NO_RECURSE,
>                                              NULL, NULL) &&
> -           refs_delete_ref(&refs->base, NULL, newrefname,
> -                           NULL, REF_NO_DEREF)) {
> +           refs_delete_ref_with_transaction_flags(&refs->base, NULL, new=
refname,
> +                                                    NULL, REF_NO_DEREF,
> +                                                    REF_TRANSACTION_FLAG=
_SKIP_HOOK)) {
>                 if (errno =3D=3D EISDIR) {
>                         struct strbuf path =3D STRBUF_INIT;
>                         int result;
> @@ -1796,13 +1879,25 @@ static int files_copy_or_rename_ref(struct ref_st=
ore *ref_store,
>         }
>         oidcpy(&lock->old_oid, &orig_oid);
>
> -       if (write_ref_to_lockfile(refs, lock, &orig_oid, &err) ||
> -           commit_ref_update(refs, lock, &orig_oid, logmsg, 0, &err)) {
> +       if (write_ref_to_lockfile(refs, lock, &orig_oid, &err)) {
>                 error("unable to write current sha1 into %s: %s", newrefn=
ame, err.buf);
>                 strbuf_release(&err);
>                 goto rollback;
>         }
>
> +       CALLOC_ARRAY(data, 1);
> +       data->lock =3D lock;
> +       oidcpy(&data->orig_oid, &orig_oid);
> +       data->logmoved =3D logmoved;
> +       data->destination_exists =3D destination_exists;
> +       data->destination_log_backed_up =3D destination_log_backed_up;
> +       if (destination_exists && !(destination_flags & REF_ISSYMREF))
> +               oidcpy(&data->destination_oid, &destination_oid);
> +       if (destination_flags & REF_ISSYMREF)
> +               data->destination_target =3D strbuf_detach(&destination_t=
arget, NULL);
> +       transaction->backend_data =3D data;
> +       transaction->state =3D REF_TRANSACTION_PREPARED;
> +
>         ret =3D 0;
>         goto out;
>
> @@ -1821,38 +1916,40 @@ static int files_copy_or_rename_ref(struct ref_st=
ore *ref_store,
>         }
>
>   rollbacklog:
> -       if (logmoved && rename(sb_newref.buf, sb_oldref.buf))
> -               error("unable to restore logfile %s from %s: %s",
> -                       oldrefname, newrefname, strerror(errno));
> +       if (logmoved) {
> +               if (rename(sb_newref.buf, tmp_renamed_log.buf)) {
> +                       error("unable to restore logfile %s from %s: %s",
> +                             oldrefname, newrefname, strerror(errno));
> +               } else {
> +                       try_remove_empty_parents(refs, newrefname,
> +                                                REMOVE_EMPTY_PARENTS_REF=
LOG);
> +                       if (rename_tmp_log(refs, oldrefname))
> +                               error("unable to restore logfile %s from =
logs/"
> +                                     TMP_RENAMED_LOG ": %s",
> +                                     oldrefname, strerror(errno));
> +               }
> +       }
>         if (!logmoved && log &&
>             rename(tmp_renamed_log.buf, sb_oldref.buf))
>                 error("unable to restore logfile %s from logs/"TMP_RENAME=
D_LOG": %s",
>                         oldrefname, strerror(errno));
> +       if (destination_log_backed_up &&
> +           rename(tmp_destination_log.buf, sb_newref.buf))
> +               error("unable to restore logfile %s: %s",
> +                     newrefname, strerror(errno));
>         ret =3D 1;
>   out:
> +       if (ret && destination_log_backed_up)
> +               unlink(tmp_destination_log.buf);
>         strbuf_release(&sb_newref);
>         strbuf_release(&sb_oldref);
>         strbuf_release(&tmp_renamed_log);
> +       strbuf_release(&tmp_destination_log);
> +       strbuf_release(&destination_target);
>
>         return ret;
>  }
>
> -static int files_rename_ref(struct ref_store *ref_store,
> -                           const char *oldrefname, const char *newrefnam=
e,
> -                           const char *logmsg)
> -{
> -       return files_copy_or_rename_ref(ref_store, oldrefname,
> -                                newrefname, logmsg, 0);
> -}
> -
> -static int files_copy_ref(struct ref_store *ref_store,
> -                           const char *oldrefname, const char *newrefnam=
e,
> -                           const char *logmsg)
> -{
> -       return files_copy_or_rename_ref(ref_store, oldrefname,
> -                                newrefname, logmsg, 1);
> -}
> -
>  static int close_ref_gently(struct ref_lock *lock)
>  {
>         if (close_lock_file_gently(&lock->lk))
> @@ -2962,6 +3059,14 @@ static int files_transaction_prepare(struct ref_st=
ore *ref_store,
>         struct ref_transaction *packed_transaction =3D NULL;
>
>         assert(err);
> +       {
> +               struct ref_update *operation =3D
> +                       ref_transaction_copy_or_rename_update(transaction=
);
> +
> +               if (operation)
> +                       return files_copy_or_rename_ref(ref_store, operat=
ion,
> +                                                       transaction);
> +       }
>
>         if (transaction->flags & REF_TRANSACTION_FLAG_INITIAL)
>                 goto cleanup;
> @@ -3318,6 +3423,10 @@ static int files_transaction_finish_initial(struct=
 files_ref_store *refs,
>         return ret;
>  }
>
> +static int files_transaction_abort(struct ref_store *ref_store,
> +                                  struct ref_transaction *transaction,
> +                                  struct strbuf *err);
> +
>  static int files_transaction_finish(struct ref_store *ref_store,
>                                     struct ref_transaction *transaction,
>                                     struct strbuf *err)
> @@ -3333,6 +3442,40 @@ static int files_transaction_finish(struct ref_sto=
re *ref_store,
>
>
>         assert(err);
> +       {
> +               struct ref_update *update =3D
> +                       ref_transaction_copy_or_rename_update(transaction=
);
> +
> +               if (update) {
> +                       struct ref_copy_or_rename_update *operation =3D
> +                               update->copy_or_rename;
> +                       struct files_copy_or_rename_transaction_data *dat=
a =3D
> +                               transaction->backend_data;
> +                       int special_ret;
> +
> +                       special_ret =3D commit_ref_update(refs, data->loc=
k, &data->orig_oid,
> +                                                       operation->logmsg=
, 0, err);
> +                       if (special_ret) {
> +                               error("unable to write current sha1 into =
%s: %s",
> +                                     update->refname, err->buf);
> +                               data->lock =3D NULL;
> +                               files_transaction_abort(ref_store, transa=
ction, err);
> +                               return special_ret;
> +                       } else if (data->destination_log_backed_up) {
> +                               struct strbuf path =3D STRBUF_INIT;
> +
> +                               files_reflog_path(refs, &path, TMP_RENAME=
D_LOG_DESTINATION);
> +                               if (unlink(path.buf) < 0 && errno !=3D EN=
OENT)
> +                                       warning_errno("unable to remove '=
%s'", path.buf);
> +                               strbuf_release(&path);
> +                       }
> +                       free(data->destination_target);
> +                       free(data);
> +                       transaction->backend_data =3D NULL;
> +                       transaction->state =3D REF_TRANSACTION_CLOSED;
> +                       return special_ret;
> +               }
> +       }
>
>         if (transaction->flags & REF_TRANSACTION_FLAG_INITIAL)
>                 return files_transaction_finish_initial(refs, transaction=
, err);
> @@ -3476,11 +3619,105 @@ static int files_transaction_finish(struct ref_s=
tore *ref_store,
>
>  static int files_transaction_abort(struct ref_store *ref_store,
>                                    struct ref_transaction *transaction,
> -                                  struct strbuf *err UNUSED)
> +                                  struct strbuf *err)
>  {
>         struct files_ref_store *refs =3D
>                 files_downcast(ref_store, 0, "ref_transaction_abort");
>
> +       {
> +               struct ref_update *update =3D
> +                       ref_transaction_copy_or_rename_update(transaction=
);
> +
> +               if (update) {
> +                       struct ref_copy_or_rename_update *operation =3D
> +                               update->copy_or_rename;
> +                       struct files_copy_or_rename_transaction_data *dat=
a =3D
> +                               transaction->backend_data;
> +                       struct strbuf new_log =3D STRBUF_INIT;
> +                       struct strbuf destination_log =3D STRBUF_INIT;
> +                       struct strbuf temporary_log =3D STRBUF_INIT;
> +                       struct ref_transaction *restore_transaction =3D N=
ULL;
> +                       struct ref_lock *lock;
> +                       int ret =3D 0;
> +
> +                       if (data->lock)
> +                               unlock_ref(data->lock);
> +                       if (operation->type =3D=3D REF_UPDATE_RENAME) {
> +                               lock =3D lock_ref_oid_basic(refs, operati=
on->old_refname, err);
> +                               if (!lock ||
> +                                   write_ref_to_lockfile(refs, lock, &da=
ta->orig_oid, err) ||
> +                                   commit_ref_update(refs, lock, &data->=
orig_oid, NULL,
> +                                                     REF_SKIP_CREATE_REF=
LOG, err))
> +                                       ret =3D -1;
> +                       }
> +
> +                       if (data->logmoved) {
> +                               files_reflog_path(refs, &new_log, update-=
>refname);
> +                               if (operation->type =3D=3D REF_UPDATE_REN=
AME) {
> +                                       files_reflog_path(refs, &temporar=
y_log, TMP_RENAMED_LOG);
> +                                       if (rename(new_log.buf, temporary=
_log.buf) < 0) {
> +                                               strbuf_addf(err, "unable =
to restore logfile %s: %s",
> +                                                           operation->ol=
d_refname, strerror(errno));
> +                                               ret =3D -1;
> +                                       } else {
> +                                               try_remove_empty_parents(=
refs,
> +                                                                        =
update->refname,
> +                                                                        =
REMOVE_EMPTY_PARENTS_REFLOG);
> +                                               if (rename_tmp_log(refs,
> +                                                                  operat=
ion->old_refname)) {
> +                                                       strbuf_addf(err, =
"unable to restore logfile %s: %s",
> +                                                                   opera=
tion->old_refname,
> +                                                                   strer=
ror(errno));
> +                                                       ret =3D -1;
> +                                               }
> +                                       }
> +                               } else if (unlink(new_log.buf) < 0 && err=
no !=3D ENOENT) {
> +                                       strbuf_addf(err, "unable to remov=
e logfile %s: %s",
> +                                                   update->refname, stre=
rror(errno));
> +                                       ret =3D -1;
> +                               }
> +                       }
> +                       if (data->destination_log_backed_up) {
> +                               files_reflog_path(refs, &destination_log,
> +                                                 TMP_RENAMED_LOG_DESTINA=
TION);
> +                               if (rename(destination_log.buf, new_log.b=
uf) < 0) {
> +                                       strbuf_addf(err, "unable to resto=
re logfile %s: %s",
> +                                                   update->refname, stre=
rror(errno));
> +                                       ret =3D -1;
> +                               }
> +                       }
> +
> +                       if (operation->type =3D=3D REF_UPDATE_RENAME &&
> +                           data->destination_exists) {
> +                               restore_transaction =3D ref_store_transac=
tion_begin(
> +                                       &refs->base, REF_TRANSACTION_FLAG=
_SKIP_HOOK, err);
> +                               if (!restore_transaction ||
> +                                   ref_transaction_update(restore_transa=
ction,
> +                                                          update->refnam=
e,
> +                                                          data->destinat=
ion_target ? NULL :
> +                                                                        =
             &data->destination_oid,
> +                                                          NULL,
> +                                                          data->destinat=
ion_target,
> +                                                          NULL,
> +                                                          REF_NO_DEREF |
> +                                                                  REF_SK=
IP_CREATE_REFLOG,
> +                                                          NULL, err) ||
> +                                   ref_transaction_commit(restore_transa=
ction, err))
> +                                       ret =3D -1;
> +                               ref_transaction_free(restore_transaction)=
;
> +                       }
> +
> +                       strbuf_release(&destination_log);
> +                       strbuf_release(&temporary_log);
> +                       strbuf_release(&new_log);
> +                       free(data->destination_target);
> +                       free(data);
> +                       transaction->backend_data =3D NULL;
> +                       transaction->state =3D REF_TRANSACTION_CLOSED;
> +                       return ret;
> +               }
> +       }
> +
>         files_transaction_cleanup(refs, transaction);
>         return 0;
>  }
> @@ -4095,8 +4332,6 @@ struct ref_storage_be refs_be_files =3D {
>
>         .optimize =3D files_optimize,
>         .optimize_required =3D files_optimize_required,
> -       .rename_ref =3D files_rename_ref,
> -       .copy_ref =3D files_copy_ref,
>
>         .iterator_begin =3D files_ref_iterator_begin,
>         .read_raw_ref =3D files_read_raw_ref,
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index a73fc6aca..364a91291 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -2164,8 +2164,6 @@ struct ref_storage_be refs_be_packed =3D {
>         .optimize =3D packed_optimize,
>         .optimize_required =3D packed_optimize_required,
>
> -       .rename_ref =3D NULL,
> -       .copy_ref =3D NULL,
>
>         .iterator_begin =3D packed_ref_iterator_begin,
>         .read_raw_ref =3D packed_read_raw_ref,
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index c3ac7b556..5d4dc0171 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -155,9 +155,33 @@ struct ref_update {
>          */
>         struct ref_update *parent_update;
>
> +       /*
> +        * Copy and rename operations require backend-specific handling w=
hile
> +        * still exposing their logical updates to transaction hooks. Kee=
p that
> +        * state on the destination update so it composes with other upda=
tes in
> +        * the transaction instead of making copy or rename a transaction=
-wide
> +        * property.
> +        */
> +       struct ref_copy_or_rename_update *copy_or_rename;
> +
>         const char refname[FLEX_ARRAY];
>  };
>
> +enum ref_copy_or_rename_type {
> +       REF_UPDATE_RENAME,
> +       REF_UPDATE_COPY,
> +};
> +
> +struct ref_copy_or_rename_update {
> +       enum ref_copy_or_rename_type type;
> +       char *old_refname;
> +       char *logmsg;
> +       struct object_id source_oid;
> +       struct object_id destination_oid;
> +       char *destination_target;
> +       unsigned int destination_exists:1;
> +};
> +
>  int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
>                       struct object_id *oid, struct strbuf *referent,
>                       unsigned int *type, int *failure_errno);
> @@ -187,6 +211,13 @@ struct ref_update *ref_transaction_add_update(
>                 const char *committer_info,
>                 const char *msg);
>
> +int refs_delete_ref_with_transaction_flags(struct ref_store *refs,
> +                                          const char *msg,
> +                                          const char *refname,
> +                                          const struct object_id *old_oi=
d,
> +                                          unsigned int flags,
> +                                          unsigned int transaction_flags=
);
> +
>  /*
>   * Transaction states.
>   *
> @@ -242,6 +273,12 @@ struct ref_transaction {
>         uint64_t max_index;
>  };
>
> +/* Suppress hooks for a transaction nested inside another refs operation=
. */
> +#define REF_TRANSACTION_FLAG_SKIP_HOOK (1 << 2)
> +
> +struct ref_update *ref_transaction_copy_or_rename_update(
> +       struct ref_transaction *transaction);
> +
>  /*
>   * Check for entries in extras that are within the specified
>   * directory, where dirname is a reference directory name including
> @@ -451,13 +488,6 @@ typedef int optimize_required_fn(struct ref_store *r=
ef_store,
>                                  struct refs_optimize_opts *opts,
>                                  bool *required);
>
> -typedef int rename_ref_fn(struct ref_store *ref_store,
> -                         const char *oldref, const char *newref,
> -                         const char *logmsg);
> -typedef int copy_ref_fn(struct ref_store *ref_store,
> -                         const char *oldref, const char *newref,
> -                         const char *logmsg);
> -
>  /*
>   * Iterate over the references in `ref_store` whose names start with
>   * `prefix`. `prefix` is matched as a literal string, without regard
> @@ -577,9 +607,6 @@ struct ref_storage_be {
>
>         optimize_fn *optimize;
>         optimize_required_fn *optimize_required;
> -       rename_ref_fn *rename_ref;
> -       copy_ref_fn *copy_ref;
> -
>         ref_iterator_begin_fn *iterator_begin;
>         read_raw_ref_fn *read_raw_ref;
>
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 10db03991..589fcc998 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -953,6 +953,14 @@ struct reftable_transaction_data {
>         size_t args_nr, args_alloc;
>  };
>
> +struct reftable_copy_or_rename_transaction_data {
> +       struct reftable_addition *addition;
> +};
> +
> +static int reftable_be_copy_or_rename_prepare(struct ref_store *ref_stor=
e,
> +                                              struct ref_transaction *tr=
ansaction,
> +                                              struct strbuf *err);
> +
>  static void free_transaction_data(struct reftable_transaction_data *tx_d=
ata)
>  {
>         if (!tx_data)
> @@ -1326,6 +1334,10 @@ static int reftable_be_transaction_prepare(struct =
ref_store *ref_store,
>         size_t i;
>         int ret;
>
> +       if (ref_transaction_copy_or_rename_update(transaction))
> +               return reftable_be_copy_or_rename_prepare(ref_store, tran=
saction,
> +                                                          err);
> +
>         ret =3D refs->err;
>         if (ret < 0)
>                 goto done;
> @@ -1419,7 +1431,20 @@ static int reftable_be_transaction_abort(struct re=
f_store *ref_store UNUSED,
>                                          struct ref_transaction *transact=
ion,
>                                          struct strbuf *err UNUSED)
>  {
> -       struct reftable_transaction_data *tx_data =3D transaction->backen=
d_data;
> +       struct reftable_transaction_data *tx_data;
> +
> +       if (ref_transaction_copy_or_rename_update(transaction)) {
> +               struct reftable_copy_or_rename_transaction_data *data =3D
> +                       transaction->backend_data;
> +
> +               reftable_addition_destroy(data->addition);
> +               free(data);
> +               transaction->backend_data =3D NULL;
> +               transaction->state =3D REF_TRANSACTION_CLOSED;
> +               return 0;
> +       }
> +
> +       tx_data =3D transaction->backend_data;
>         free_transaction_data(tx_data);
>         transaction->state =3D REF_TRANSACTION_CLOSED;
>         return 0;
> @@ -1667,9 +1692,28 @@ static int reftable_be_transaction_finish(struct r=
ef_store *ref_store UNUSED,
>                                           struct ref_transaction *transac=
tion,
>                                           struct strbuf *err)
>  {
> -       struct reftable_transaction_data *tx_data =3D transaction->backen=
d_data;
> +       struct reftable_transaction_data *tx_data;
>         int ret =3D 0;
>
> +       if (ref_transaction_copy_or_rename_update(transaction)) {
> +               struct reftable_copy_or_rename_transaction_data *data =3D
> +                       transaction->backend_data;
> +               int special_ret =3D reftable_addition_commit(data->additi=
on);
> +
> +               reftable_addition_destroy(data->addition);
> +               free(data);
> +               transaction->backend_data =3D NULL;
> +               transaction->state =3D REF_TRANSACTION_CLOSED;
> +               if (special_ret < 0) {
> +                       strbuf_addf(err, _("reftable: transaction failure=
: %s"),
> +                                   reftable_error_str(special_ret));
> +                       return -1;
> +               }
> +               return 0;
> +       }
> +
> +       tx_data =3D transaction->backend_data;
> +
>         for (size_t i =3D 0; i < tx_data->args_nr; i++) {
>                 tx_data->args[i].max_index =3D transaction->max_index;
>
> @@ -1764,17 +1808,20 @@ struct write_create_symref_arg {
>  struct write_copy_arg {
>         struct reftable_ref_store *refs;
>         struct reftable_backend *be;
> +       struct strbuf *err;
>         const char *oldname;
>         const char *newname;
>         const char *logmsg;
>         int delete_old;
> +       struct ref_copy_or_rename_update *operation;
>  };
>
>  static int write_copy_table(struct reftable_writer *writer, void *cb_dat=
a)
>  {
>         struct write_copy_arg *arg =3D cb_data;
>         uint64_t deletion_ts, creation_ts;
> -       struct reftable_ref_record old_ref =3D {0}, refs[2] =3D {0};
> +       struct reftable_ref_record old_ref =3D {0}, destination_ref =3D {=
0};
> +       struct reftable_ref_record refs[2] =3D {0};
>         struct reftable_log_record old_log =3D {0}, *logs =3D NULL;
>         struct reftable_iterator it =3D {0};
>         struct string_list skip =3D STRING_LIST_INIT_NODUP;
> @@ -1789,14 +1836,75 @@ static int write_copy_table(struct reftable_write=
r *writer, void *cb_data)
>                 BUG("failed splitting committer info");
>
>         if (reftable_stack_read_ref(arg->be->stack, arg->oldname, &old_re=
f)) {
> -               ret =3D error(_("refname %s not found"), arg->oldname);
> +               strbuf_addf(arg->err, _("refname %s not found"), arg->old=
name);
> +               ret =3D -1;
>                 goto done;
>         }
>         if (old_ref.value_type =3D=3D REFTABLE_REF_SYMREF) {
> -               ret =3D error(_("refname %s is a symbolic ref, copying it=
 is not supported"),
> +               strbuf_addf(arg->err,
> +                           _("refname %s is a symbolic ref, copying it i=
s not supported"),
>                             arg->oldname);
> +               ret =3D -1;
>                 goto done;
>         }
> +       if (arg->operation) {
> +               struct object_id oid;
> +
> +               if (old_ref.value_type =3D=3D REFTABLE_REF_VAL2)
> +                       oidread(&oid, old_ref.value.val2.value,
> +                               arg->refs->base.repo->hash_algo);
> +               else
> +                       oidread(&oid, old_ref.value.val1,
> +                               arg->refs->base.repo->hash_algo);
> +               if (!oideq(&oid, &arg->operation->source_oid)) {
> +                       strbuf_addf(arg->err,
> +                                   _("refname %s is at %s but expected %=
s"),
> +                                   arg->oldname, oid_to_hex(&oid),
> +                                   oid_to_hex(&arg->operation->source_oi=
d));
> +                       ret =3D -1;
> +                       goto done;
> +               }
> +
> +               ret =3D reftable_stack_read_ref(arg->be->stack, arg->newn=
ame,
> +                                             &destination_ref);
> +               if (ret < 0)
> +                       goto done;
> +               if (arg->operation->destination_exists !=3D !ret) {
> +                       strbuf_addf(arg->err,
> +                                   _("refname %s changed while renaming"=
),
> +                                   arg->newname);
> +                       ret =3D -1;
> +                       goto done;
> +               }
> +               if (!ret) {
> +                       if (destination_ref.value_type =3D=3D REFTABLE_RE=
F_SYMREF) {
> +                               if (!arg->operation->destination_target |=
|
> +                                   strcmp(destination_ref.value.symref,
> +                                          arg->operation->destination_ta=
rget)) {
> +                                       strbuf_addf(arg->err,
> +                                                   _("refname %s changed=
 while renaming"),
> +                                                   arg->newname);
> +                                       ret =3D -1;
> +                                       goto done;
> +                               }
> +                       } else {
> +                               if (destination_ref.value_type =3D=3D REF=
TABLE_REF_VAL2)
> +                                       oidread(&oid, destination_ref.val=
ue.val2.value,
> +                                               arg->refs->base.repo->has=
h_algo);
> +                               else
> +                                       oidread(&oid, destination_ref.val=
ue.val1,
> +                                               arg->refs->base.repo->has=
h_algo);
> +                               if (arg->operation->destination_target ||
> +                                   !oideq(&oid, &arg->operation->destina=
tion_oid)) {
> +                                       strbuf_addf(arg->err,
> +                                                   _("refname %s changed=
 while renaming"),
> +                                                   arg->newname);
> +                                       ret =3D -1;
> +                                       goto done;
> +                               }
> +                       }
> +               }
> +       }
>
>         /*
>          * There's nothing to do in case the old and new name are the sam=
e, so
> @@ -1815,7 +1923,7 @@ static int write_copy_table(struct reftable_writer =
*writer, void *cb_data)
>         ret =3D refs_verify_refname_available(&arg->refs->base, arg->newn=
ame,
>                                             NULL, &skip, 0, &errbuf);
>         if (ret < 0) {
> -               error("%s", errbuf.buf);
> +               strbuf_addbuf(arg->err, &errbuf);
>                 goto done;
>         }
>
> @@ -1980,68 +2088,63 @@ static int write_copy_table(struct reftable_write=
r *writer, void *cb_data)
>         for (i =3D 0; i < ARRAY_SIZE(refs); i++)
>                 reftable_ref_record_release(&refs[i]);
>         reftable_ref_record_release(&old_ref);
> +       reftable_ref_record_release(&destination_ref);
>         reftable_log_record_release(&old_log);
>         return ret;
>  }
>
> -static int reftable_be_rename_ref(struct ref_store *ref_store,
> -                                 const char *oldrefname,
> -                                 const char *newrefname,
> -                                 const char *logmsg)
> +static int reftable_be_copy_or_rename_prepare(struct ref_store *ref_stor=
e,
> +                                              struct ref_transaction *tr=
ansaction,
> +                                              struct strbuf *err)
>  {
>         struct reftable_ref_store *refs =3D
> -               reftable_be_downcast(ref_store, REF_STORE_WRITE, "rename_=
ref");
> +               reftable_be_downcast(ref_store, REF_STORE_WRITE,
> +                                    "ref_transaction_prepare");
> +       struct reftable_copy_or_rename_transaction_data *data =3D NULL;
> +       struct ref_update *update =3D
> +               ref_transaction_copy_or_rename_update(transaction);
> +       struct ref_copy_or_rename_update *operation =3D update->copy_or_r=
ename;
>         struct write_copy_arg arg =3D {
>                 .refs =3D refs,
> -               .oldname =3D oldrefname,
> -               .newname =3D newrefname,
> -               .logmsg =3D logmsg,
> -               .delete_old =3D 1,
> +               .err =3D err,
> +               .oldname =3D operation->old_refname,
> +               .newname =3D update->refname,
> +               .logmsg =3D operation->logmsg,
> +               .delete_old =3D operation->type =3D=3D REF_UPDATE_RENAME,
> +               .operation =3D operation,
>         };
>         int ret;
>
> +       CALLOC_ARRAY(data, 1);
>         ret =3D refs->err;
>         if (ret < 0)
>                 goto done;
> -
> -       ret =3D backend_for(&arg.be, refs, newrefname, &newrefname, 1);
> +       ret =3D backend_for(&arg.be, refs, update->refname,
> +                         &arg.newname, 1);
>         if (ret)
>                 goto done;
> -       ret =3D reftable_stack_add(arg.be->stack, &write_copy_table, &arg=
,
> -                                &reftable_be_write_options(refs)->opts);
> -
> -done:
> -       assert(ret !=3D REFTABLE_API_ERROR);
> -       return ret;
> -}
> -
> -static int reftable_be_copy_ref(struct ref_store *ref_store,
> -                               const char *oldrefname,
> -                               const char *newrefname,
> -                               const char *logmsg)
> -{
> -       struct reftable_ref_store *refs =3D
> -               reftable_be_downcast(ref_store, REF_STORE_WRITE, "copy_re=
f");
> -       struct write_copy_arg arg =3D {
> -               .refs =3D refs,
> -               .oldname =3D oldrefname,
> -               .newname =3D newrefname,
> -               .logmsg =3D logmsg,
> -       };
> -       int ret;
> -
> -       ret =3D refs->err;
> -       if (ret < 0)
> +       ret =3D reftable_stack_addition_new(&data->addition, arg.be->stac=
k,
> +                                         &reftable_be_write_options(refs=
)->opts);
> +       if (ret)
>                 goto done;
> -
> -       ret =3D backend_for(&arg.be, refs, newrefname, &newrefname, 1);
> +       ret =3D reftable_addition_add(data->addition, &write_copy_table, =
&arg);
>         if (ret)
>                 goto done;
> -       ret =3D reftable_stack_add(arg.be->stack, &write_copy_table, &arg=
,
> -                                &reftable_be_write_options(refs)->opts);
> +
> +       transaction->backend_data =3D data;
> +       transaction->state =3D REF_TRANSACTION_PREPARED;
> +       return 0;
>
>  done:
>         assert(ret !=3D REFTABLE_API_ERROR);
> +       if (data) {
> +               reftable_addition_destroy(data->addition);
> +               free(data);
> +       }
> +       transaction->state =3D REF_TRANSACTION_CLOSED;
> +       if (ret && !err->len)
> +               strbuf_addf(err, _("reftable: transaction prepare: %s"),
> +                           reftable_error_str(ret));
>         return ret;
>  }
>
> @@ -2872,8 +2975,6 @@ struct ref_storage_be refs_be_reftable =3D {
>         .optimize =3D reftable_be_optimize,
>         .optimize_required =3D reftable_be_optimize_required,
>
> -       .rename_ref =3D reftable_be_rename_ref,
> -       .copy_ref =3D reftable_be_copy_ref,
>
>         .iterator_begin =3D reftable_be_iterator_begin,
>         .read_raw_ref =3D reftable_be_read_raw_ref,
> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-h=
ooks.sh
> index 4fe9d9b23..116b2ff07 100755
> --- a/t/t1416-ref-transaction-hooks.sh
> +++ b/t/t1416-ref-transaction-hooks.sh
> @@ -93,6 +93,148 @@ test_expect_success 'hook gets all queued updates in =
committed state' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'hook gets both updates when renaming a branch' '
> +       test_when_finished "rm -f actual" &&
> +       git branch old PRE &&
> +       test_hook reference-transaction <<-\EOF &&
> +               echo "$1" >>actual &&
> +               cat >>actual
> +       EOF
> +       cat >expect <<-EOF &&
> +       preparing
> +       $PRE_OID $ZERO_OID refs/heads/old
> +       $ZERO_OID $PRE_OID refs/heads/new
> +       prepared
> +       $PRE_OID $ZERO_OID refs/heads/old
> +       $ZERO_OID $PRE_OID refs/heads/new
> +       committed
> +       $PRE_OID $ZERO_OID refs/heads/old
> +       $ZERO_OID $PRE_OID refs/heads/new
> +       EOF
> +       git branch -m old new &&
> +       test_cmp expect actual &&
> +       test_must_fail git rev-parse --verify refs/heads/old &&
> +       test_cmp_rev PRE refs/heads/new
> +'
> +
> +test_expect_success 'hook gets destination update when copying a branch'=
 '
> +       test_when_finished "rm -f actual" &&
> +       git branch copy-source PRE &&
> +       test_hook reference-transaction <<-\EOF &&
> +               echo "$1" >>actual &&
> +               cat >>actual
> +       EOF
> +       cat >expect <<-EOF &&
> +       preparing
> +       $ZERO_OID $PRE_OID refs/heads/copy-destination
> +       prepared
> +       $ZERO_OID $PRE_OID refs/heads/copy-destination
> +       committed
> +       $ZERO_OID $PRE_OID refs/heads/copy-destination
> +       EOF
> +       git branch -c copy-source copy-destination &&
> +       test_cmp expect actual &&
> +       test_cmp_rev PRE refs/heads/copy-source &&
> +       test_cmp_rev PRE refs/heads/copy-destination
> +'
> +
> +test_expect_success 'hook gets overwritten values for forced rename and =
copy' '
> +       git branch force-old PRE &&
> +       git branch force-new POST &&
> +       git branch force-copy-source PRE &&
> +       git branch force-copy-destination POST &&
> +       test_hook reference-transaction <<-\EOF &&
> +               if test "$1" =3D committed
> +               then
> +                       cat >>actual
> +               fi
> +       EOF
> +       git branch -M force-old force-new &&
> +       git branch -C force-copy-source force-copy-destination &&
> +       cat >expect <<-EOF &&
> +       $PRE_OID $ZERO_OID refs/heads/force-old
> +       $POST_OID $PRE_OID refs/heads/force-new
> +       $POST_OID $PRE_OID refs/heads/force-copy-destination
> +       EOF
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'hook can abort a branch rename after preparation' '
> +       git branch abort-old PRE &&
> +       git branch abort-new POST &&
> +       git reflog show --format=3D%gs abort-old >old-log &&
> +       git reflog show --format=3D%gs abort-new >new-log &&
> +       test_hook reference-transaction <<-\EOF &&
> +               test "$1" !=3D prepared
> +       EOF
> +       test_must_fail git branch -M abort-old abort-new &&
> +       test_cmp_rev PRE refs/heads/abort-old &&
> +       test_cmp_rev POST refs/heads/abort-new &&
> +       git reflog show --format=3D%gs abort-old >old-log-after &&
> +       git reflog show --format=3D%gs abort-new >new-log-after &&
> +       test_cmp old-log old-log-after &&
> +       test_cmp new-log new-log-after
> +'
> +
> +test_expect_success 'hook can abort a D/F branch rename after preparatio=
n' '
> +       git branch df-old PRE &&
> +       git reflog show --format=3D%gs df-old >df-log &&
> +       test_hook reference-transaction <<-\EOF &&
> +               test "$1" !=3D prepared
> +       EOF
> +       test_must_fail git branch -m df-old df-old/child &&
> +       test_cmp_rev PRE refs/heads/df-old &&
> +       test_must_fail git rev-parse --verify refs/heads/df-old/child &&
> +       git reflog show --format=3D%gs df-old >df-log-after &&
> +       test_cmp df-log df-log-after
> +'
> +
> +test_expect_success 'hook can abort a reverse D/F rename after preparati=
on' '
> +       git branch reverse/old PRE &&
> +       git reflog show --format=3D%gs reverse/old >reverse-log &&
> +       test_hook reference-transaction <<-\EOF &&
> +               test "$1" !=3D prepared
> +       EOF
> +       test_must_fail git branch -m reverse/old reverse &&
> +       test_cmp_rev PRE refs/heads/reverse/old &&
> +       test_must_fail git rev-parse --verify refs/heads/reverse &&
> +       git reflog show --format=3D%gs reverse/old >reverse-log-after &&
> +       test_cmp reverse-log reverse-log-after
> +'
> +
> +test_expect_success 'hook can abort a forced branch copy after preparati=
on' '
> +       git branch copy-abort-old PRE &&
> +       git branch copy-abort-new POST &&
> +       git reflog show --format=3D%gs copy-abort-old >copy-old-log &&
> +       git reflog show --format=3D%gs copy-abort-new >copy-new-log &&
> +       test_hook reference-transaction <<-\EOF &&
> +               test "$1" !=3D prepared
> +       EOF
> +       test_must_fail git branch -C copy-abort-old copy-abort-new &&
> +       test_cmp_rev PRE refs/heads/copy-abort-old &&
> +       test_cmp_rev POST refs/heads/copy-abort-new &&
> +       git reflog show --format=3D%gs copy-abort-old >copy-old-log-after=
 &&
> +       git reflog show --format=3D%gs copy-abort-new >copy-new-log-after=
 &&
> +       test_cmp copy-old-log copy-old-log-after &&
> +       test_cmp copy-new-log copy-new-log-after
> +'
> +
> +test_expect_success 'branch rename detects an update during preparing ho=
ok' '
> +       git branch race-old PRE &&
> +       git branch race-new POST &&
> +       test_hook reference-transaction <<-\EOF &&
> +               marker=3D$(git rev-parse --git-path rename-race-once)
> +               if test "$1" =3D preparing && test ! -e "$marker"
> +               then
> +                       >"$marker" &&
> +                       git update-ref refs/heads/race-old POST
> +               fi
> +       EOF
> +       test_must_fail git branch -M race-old race-new &&
> +       test_cmp_rev POST refs/heads/race-old &&
> +       test_cmp_rev POST refs/heads/race-new
> +'
> +
>  test_expect_success 'hook gets all queued updates in aborted state' '
>         test_when_finished "rm actual" &&
>         git reset --hard PRE &&
> --
> 2.39.3 (Apple Git-146)
