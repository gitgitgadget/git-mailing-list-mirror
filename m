Received: from mail-lr2-f34.google.com (mail-lr2-f34.google.com [74.125.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C3736D9F5
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 03:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790737906; cv=pass; b=TYXxaRNq0R5Zju1wYtYob2g+n6J6izQZltMVpLY+vT8jtuU/9l03Hu0Vo19si8B5jaL2Yuqbh4np6+KWd55VkS0xtrkYoRONYpTVdkMp9GwGS0MQmLDXwO9a035k+g+dDBGQxl+895zPtTbeChvU6JPZvAo/iEaekfa027YggKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790737906; c=relaxed/simple;
	bh=WHwNcsrzgCGZ6IG1SiDj1olGCsG4R+hZoDXoGX32SSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KP0i8zcbbyZ/9Xj5On7/ZuYv3Xdd69RcfjNCIv9jVV00t7Nv9rY5WKt1wmiT1OdpY/egy7ar6W6CU5atoMscxGrR799sMbMnQlPST9vJxSgA3K6vONwsi6IAORnuiM+WVo763aefBk38DXADvC8mbzmww5Et7oy9MzNrggwQIEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFTY+X6t; arc=pass smtp.client-ip=74.125.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFTY+X6t"
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a652b710a5so45956781fa.3
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 20:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790737902; cv=none;
        d=google.com; s=arc-20260327;
        b=F4oLeWdcLFj82mpS7IsHL2O8eF5AS4d3lyrKGJim5i0wf1PMlM2+NCt6b6kyyl+gzE
         /5b28zH2ppH1RALm+yuAcpyex92LOBcfidaql0Lh/hRr4g79YGQA6ZazNEyrgh7LUQPP
         DGWiTxtF8QrhddXKw7IisffTrRF0L1zVueR7ZgVCh4837MQgM1MA+4+Z1UwhtCeaFnfA
         +5P/CeOldqIfkzI7PF46J5SgR3zcFm/cJH+X1+ucrQoFhntldJhLuFNvBh9B2PZfupZf
         k+TIfeV19JtD1hEGGOmYJUsuTjtMO5X4Q783UsYgLiJA+pnUMC4omaRQJl0HbI/eqFCf
         7IRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WZS4mDBnozAb4WuNf1Hd6kWnFF3mD7L7n4xR0mLf1gs=;
        fh=L1yafwIze6xUY2o9eVHBQzfz0sUnW3NspKTnW32t2Ms=;
        b=poLPLQhuPO6Kl+BIuKQ6IIAf4iBir2mXqp7hyi2ahPZnnS2SECnBBZGBWzz0tS2FpF
         63Jg4npoae5aH+1J8UzwFwLIDoSLwn5l5YttbLU1OtoWnvg6ukYtTzr26QOIsLLx9yUW
         z3v/yteX/kzY7nJOWbbZJ+vbh38/cfQA0CeetuKIps2HU+vfyoYYup0PQwksLal8h4+Z
         kXWfZ+wp2m4Syehkl70deDG6js+EgZF/UubRhouVNphL0rXEjWksqG2RCGUlXG9leIsm
         579c/Ghj4wXvFAAaHRGP76YHFfNDBaPkyFvoP1FzA2C3X+opbZkEUCT7RvRa+hBICA7t
         GkgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790737902; x=1791342702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WZS4mDBnozAb4WuNf1Hd6kWnFF3mD7L7n4xR0mLf1gs=;
        b=UFTY+X6tibwqtkj8/fo7z/3BjO4VRQmeQgTBJd6v0H7zNQHdOKJp0Al7K+fCuUaVaq
         X9Y3k/nuHf04ujAfDzGU01QVVt/Cx9jwA88oihT/yEwNlpGGhOwyDcyKjeY0j08o5SMf
         Mot5EaucQZm6R8huD1KQVYbSHsqfBLRCJcc7OivMYvPr/NH0X5aoD1uoBfhQ6BS14raX
         TKXlW3Nwiy1YemtgsSiSXb6MS4xswa7oBrigpiRO1nz31gyDxfcRYCkQPfNrCT/qU2wt
         YzKkrYVLulHW0q+Vhj7AGfXfRuKQqgn12AHZLbriJkUvngBjfUvgBIDJtOijclTSRyM6
         9x2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790737902; x=1791342702;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WZS4mDBnozAb4WuNf1Hd6kWnFF3mD7L7n4xR0mLf1gs=;
        b=l9RUhKS3VtpLQp3UYKYhU+bVX4bc13x8uIaCrDeSSdOM/LuUrRax8XGjGzgmW3Idjn
         TN5o+LB6PupkV5cRlC6nRXzRPRAJ9FRU62mIQRv/PqAmHwXucf0p0z8HsA3WxelHW7+3
         kGDWbLws+KkBnesLT/NtzuwQ2mn/8BbjFyL3eIqVGQqLUePwVQD9ZmxKL/6XSAH3mHmI
         DHwzlph3aFHK0oY/6t85Zt2tn5Dwbo8G/02F8E+u4N3EllDPxgwdH6r1e45dtrNOLUTS
         IKEuYPFcxUdJxo15427/6oQVUdW16e6ZsqikfEdeGp2RFl/9RljvM5scnXJEB2QBMrFn
         SqSQ==
X-Gm-Message-State: AFq9FYIQ42RkjrdTvae1vlS7hAhvhrK1Prp2CRD2qK58sHkXSokL8gWO
	7C5W6a0is1oc0WPMKco7MzSQ4yw+ohYtH62WOoHcT30oDqpRvdlU1WML6lIcts2UIcAWhlF8rsT
	kHNJBfcSfca5KSxSJvudHFmkk4CXOUpeP8+yajUQ=
X-Gm-Gg: AYBFou3yjBNmP6pBfuI0aGZi0ZZiTiFkgB615HJ05pYhnqIo2FTHcapueAF/tofIso+
	PXBQJKKpUs++uY3KQ1/IfUArEaTb6iEpFFGHc2mjRl51bBbaM2TcxVO0SAVvWp95mP1dwX9jiSF
	DpoNg8n9zYOq6O7INu30yXbwRbUZbAVwHztS2c4TssKlgT5XmXtReXVDW0X9W+ZHEKj3+q0s7xA
	OlZo3glpHlEwHGt3ohkUfIdAl+mcIlFbgGeSrxIEpPdoesTJDpjdvIMSbfKfMSyNimz+AWVCcHR
	Fv6eO8jl4OtLtB7JO22SF2fNfDOaymqDDFHYNdss9+42vxez7udz/1NnNYjb9YVyRAIFokXJqAE
	dpjkTqWVvVYZXZFjmRScIu72TTQ5sIj/DnDX2hJ09OcaRCteVQpErq88j4a3Tz73Ie7MwwYfQ8p
	84M8vL
X-Received: by 2002:a2e:a993:0:b0:3a7:7a0e:56ef with SMTP id
 38308e7fff4ca-3a77a0e5db2mr90671fa.4.1790737901672; Tue, 29 Sep 2026 20:11:41
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790196627.git.maciej.ciemborowicz@gmail.com>
 <cover.1790269745.git.maciej.ciemborowicz@gmail.com> <2af3eeadd18806c5298d53072428656885cff89d.1790269745.git.maciej.ciemborowicz@gmail.com>
In-Reply-To: <2af3eeadd18806c5298d53072428656885cff89d.1790269745.git.maciej.ciemborowicz@gmail.com>
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Wed, 30 Sep 2026 05:11:30 +0200
X-Gm-Features: AclHuK-ug-rIX8qy6eLexeQ5CuNCPqFOYwJHSj5r3-_DDYgZgNbe7LzlA7ozF5k
Message-ID: <CACQ=SRFWAJSRO7d5PcTK_FZBJrhdcr1ff_FfTUWmnQNB-WBnUA@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] refs: report old values to transaction hooks
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>, Phil Hord <phil.hord@gmail.com>, Elijah Newren <newren@gmail.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	"D . Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If anyone finds the time, I=E2=80=99d appreciate a code review. I=E2=80=99d=
 like to
close this chapter (hopefully get it upstream) and move on to working
on the next bug.

Thanks,
- Maciej Ciemborowicz

On Fri, Sep 25, 2026 at 12:33=E2=80=AFAM Maciej Ciemborowicz
<maciej.ciemborowicz@gmail.com> wrote:
>
> The reference-transaction hook reports an all-zero old object ID whenever
> the caller does not supply an expected old value. Consequently, batched
> branch, tag, and remote-ref deletions report zero as both the old and new
> object IDs because refs_delete_refs() intentionally queues unconditional
> deletions.
>
> Changing those callers to provide expected old values would make the
> deletions conditional and alter existing command behavior. Instead, recor=
d
> the current raw ref value separately for the hook. Read it before the
> "preparing" hook, then refresh it after the backend has locked the refs s=
o
> that the "prepared" and later phases report the value protected by the
> transaction's locks. Keep this value separate from old_oid and old_target=
 so
> it does not set REF_HAVE_OLD or otherwise constrain the update.
>
> Only resolve these values when a reference-transaction hook exists. Prese=
rve
> symbolic refs as targets, consistent with the hook's existing symref form=
at.
> Document that an unlocked "preparing" value may differ from later phases =
if
> the ref changes before it is locked.
>
> Add coverage for batched branch deletion, tag deletion, and remote prunin=
g.
> Also exercise a concurrent update from the "preparing" hook to verify tha=
t
> the deletion remains unconditional while later hook phases report the val=
ue
> actually removed.
>
> Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
> ---
>  Documentation/githooks.adoc      | 17 +++++----
>  refs.c                           | 54 ++++++++++++++++++++++++---
>  refs/refs-internal.h             |  8 ++++
>  t/t1416-ref-transaction-hooks.sh | 64 +++++++++++++++++++++++++++++++-
>  4 files changed, 128 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
> index ed045940d1..f60dd1d582 100644
> --- a/Documentation/githooks.adoc
> +++ b/Documentation/githooks.adoc
> @@ -509,14 +509,15 @@ receives on standard input a line of the format:
>    <old-value> SP <new-value> SP <ref-name> LF
>
>  where `<old-value>` is the old object name passed into the reference
> -transaction, `<new-value>` is the new object name to be stored in the
> -ref and `<ref-name>` is the full name of the ref. When force updating
> -the reference regardless of its current value or when the reference is
> -to be created anew, `<old-value>` is the all-zeroes object name. To
> -distinguish these cases, you can inspect the current value of
> -`<ref-name>` via `git rev-parse`. During the "preparing" state, symbolic
> -references are not resolved: `<ref-name>` will reflect the symbolic refe=
rence
> -itself rather than the object it points to.
> +transaction, or the value observed while preparing the transaction if no
> +old object name was passed. `<new-value>` is the new object name to be
> +stored in the ref and `<ref-name>` is the full name of the ref. When the
> +reference does not exist, `<old-value>` is the all-zeroes object name.
> +Because references are not yet locked in the "preparing" state, its obse=
rved
> +old value may differ from the value reported in subsequent states if the
> +reference changes before it is locked. During the "preparing" state,
> +symbolic references are not resolved: `<ref-name>` will reflect the symb=
olic
> +reference itself rather than the object it points to.
>
>  For symbolic reference updates the `<old_value>` and `<new-value>`
>  fields could denote references instead of objects. A reference will be
> diff --git a/refs.c b/refs.c
> index 92d5df5b71..d2d25402c3 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1260,6 +1260,7 @@ void ref_transaction_free(struct ref_transaction *t=
ransaction)
>                 free(transaction->updates[i]->committer_info);
>                 free((char *)transaction->updates[i]->new_target);
>                 free((char *)transaction->updates[i]->old_target);
> +               free(transaction->updates[i]->hook_old_target);
>                 free((char *)transaction->updates[i]->rejection_details);
>                 free(transaction->updates[i]);
>         }
> @@ -2606,6 +2607,8 @@ static int transaction_hook_feed_stdin(int hook_std=
in_fd, void *pp_cb, void *pp_
>         struct transaction_feed_cb_data *feed_cb_data =3D pp_task_cb;
>         struct strbuf *buf =3D &feed_cb_data->buf;
>         struct ref_update *update;
> +       const struct object_id *old_oid;
> +       const char *old_target;
>         size_t i =3D feed_cb_data->index++;
>         int ret;
>
> @@ -2619,12 +2622,18 @@ static int transaction_hook_feed_stdin(int hook_s=
tdin_fd, void *pp_cb, void *pp_
>
>         strbuf_reset(buf);
>
> -       if (!(update->flags & REF_HAVE_OLD))
> -               strbuf_addf(buf, "%s ", oid_to_hex(null_oid(transaction->=
ref_store->repo->hash_algo)));
> -       else if (update->old_target)
> -               strbuf_addf(buf, "ref:%s ", update->old_target);
> +       if (update->flags & REF_HAVE_OLD) {
> +               old_oid =3D &update->old_oid;
> +               old_target =3D update->old_target;
> +       } else {
> +               old_oid =3D &update->hook_old_oid;
> +               old_target =3D update->hook_old_target;
> +       }
> +
> +       if (old_target)
> +               strbuf_addf(buf, "ref:%s ", old_target);
>         else
> -               strbuf_addf(buf, "%s ", oid_to_hex(&update->old_oid));
> +               strbuf_addf(buf, "%s ", oid_to_hex(old_oid));
>
>         if (!(update->flags & REF_HAVE_NEW))
>                 strbuf_addf(buf, "%s ", oid_to_hex(null_oid(transaction->=
ref_store->repo->hash_algo)));
> @@ -2660,6 +2669,36 @@ static void transaction_feed_cb_data_free(void *da=
ta)
>         free(d);
>  }
>
> +static void resolve_transaction_hook_old_values(struct ref_transaction *=
transaction)
> +{
> +       struct ref_store *refs =3D transaction->ref_store;
> +       struct strbuf referent =3D STRBUF_INIT;
> +
> +       if (!hook_exists(refs->repo, "reference-transaction"))
> +               return;
> +
> +       for (size_t i =3D 0; i < transaction->nr; i++) {
> +               struct ref_update *update =3D transaction->updates[i];
> +               unsigned int type =3D 0;
> +               int failure_errno;
> +
> +               if (update->flags & (REF_HAVE_OLD | REF_LOG_ONLY))
> +                       continue;
> +
> +               oidclr(&update->hook_old_oid, refs->repo->hash_algo);
> +               FREE_AND_NULL(update->hook_old_target);
> +               strbuf_reset(&referent);
> +
> +               if (!refs_read_raw_ref(refs, update->refname,
> +                                      &update->hook_old_oid, &referent,
> +                                      &type, &failure_errno) &&
> +                   (type & REF_ISSYMREF))
> +                       update->hook_old_target =3D xstrdup(referent.buf)=
;
> +       }
> +
> +       strbuf_release(&referent);
> +}
> +
>  static int run_transaction_hook(struct ref_transaction *transaction,
>                                 const char *state)
>  {
> @@ -2709,6 +2748,8 @@ int ref_transaction_prepare(struct ref_transaction =
*transaction,
>         if (ref_update_reject_duplicates(&transaction->refnames, err))
>                 return REF_TRANSACTION_ERROR_GENERIC;
>
> +       resolve_transaction_hook_old_values(transaction);
> +
>         /* Preparing checks before locking references */
>         ret =3D run_transaction_hook(transaction, "preparing");
>         if (ret) {
> @@ -2720,6 +2761,9 @@ int ref_transaction_prepare(struct ref_transaction =
*transaction,
>         if (ret)
>                 return ret;
>
> +       /* Refresh old values now that the references are locked. */
> +       resolve_transaction_hook_old_values(transaction);
> +
>         ret =3D run_transaction_hook(transaction, "prepared");
>         if (ret) {
>                 ref_transaction_abort(transaction, err);
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index c3ac7b556f..a7471b2481 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -99,6 +99,14 @@ struct ref_update {
>          */
>         struct object_id old_oid;
>
> +       /*
> +        * The old value observed for the reference-transaction hook when=
 the
> +        * caller did not provide an expected old value. Unlike old_oid a=
nd
> +        * old_target, these fields do not constrain the update.
> +        */
> +       struct object_id hook_old_oid;
> +       char *hook_old_target;
> +
>         /*
>          * If the new_oid points to a tag object, set this to the peeled
>          * object ID for optimized retrieval without needed to hit the od=
b.
> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-h=
ooks.sh
> index 4fe9d9b234..fcc7404943 100755
> --- a/t/t1416-ref-transaction-hooks.sh
> +++ b/t/t1416-ref-transaction-hooks.sh
> @@ -14,6 +14,66 @@ test_expect_success setup '
>         POST_OID=3D$(git rev-parse POST)
>  '
>
> +test_expect_success 'hook gets old values for batched unconditional dele=
tion' '
> +       test_when_finished "rm -f actual" &&
> +       test_when_finished "git remote remove origin && rm -rf empty.git"=
 &&
> +       git init --bare empty.git &&
> +       git remote add origin ./empty.git &&
> +       git branch delete-a PRE &&
> +       git branch delete-b POST &&
> +       git tag delete-tag POST &&
> +       git update-ref refs/remotes/origin/to-prune $PRE_OID &&
> +       test_hook reference-transaction <<-\EOF &&
> +               if test "$1" =3D committed
> +               then
> +                       cat >>actual
> +               fi
> +       EOF
> +       git branch -D delete-a delete-b &&
> +       git tag -d delete-tag &&
> +       git remote prune origin &&
> +       cat >expect <<-EOF &&
> +               $PRE_OID $ZERO_OID refs/heads/delete-a
> +               $POST_OID $ZERO_OID refs/heads/delete-b
> +               $POST_OID $ZERO_OID refs/tags/delete-tag
> +               $PRE_OID $ZERO_OID refs/remotes/origin/to-prune
> +       EOF
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'unconditional deletion remains unconditional' '
> +       test_when_finished "rm -f actual" &&
> +       test_when_finished "rm -f \"$(git rev-parse --git-path delete-rac=
e-once)\"" &&
> +       git branch delete-race PRE &&
> +       test_hook reference-transaction <<-\EOF &&
> +               state=3D$1
> +               while read -r old new ref
> +               do
> +                       if test "$state" !=3D aborted
> +                       then
> +                               case "$new" in
> +                               *[!0]*) ;;
> +                               *) echo "$state $old $new $ref" >>actual =
;;
> +                               esac
> +                       fi
> +               done
> +               marker=3D$(git rev-parse --git-path delete-race-once)
> +               if test "$state" =3D preparing && test ! -e "$marker"
> +               then
> +                       >"$marker"
> +                       git update-ref refs/heads/delete-race POST
> +               fi
> +       EOF
> +       git branch -D delete-race &&
> +       cat >expect <<-EOF &&
> +               preparing $PRE_OID $ZERO_OID refs/heads/delete-race
> +               prepared $POST_OID $ZERO_OID refs/heads/delete-race
> +               committed $POST_OID $ZERO_OID refs/heads/delete-race
> +       EOF
> +       test_cmp expect actual &&
> +       test_must_fail git show-ref --verify refs/heads/delete-race
> +'
> +
>  test_expect_success 'hook allows updating ref if successful' '
>         git reset --hard PRE &&
>         test_hook reference-transaction <<-\EOF &&
> @@ -65,7 +125,7 @@ test_expect_success 'hook gets all queued updates in p=
repared state' '
>                 fi
>         EOF
>         cat >expect <<-EOF &&
> -               $ZERO_OID $POST_OID refs/heads/main
> +               $PRE_OID $POST_OID refs/heads/main
>         EOF
>         git update-ref HEAD POST <<-EOF &&
>                 update HEAD $ZERO_OID $POST_OID
> @@ -87,7 +147,7 @@ test_expect_success 'hook gets all queued updates in c=
ommitted state' '
>                 fi
>         EOF
>         cat >expect <<-EOF &&
> -               $ZERO_OID $POST_OID refs/heads/main
> +               $PRE_OID $POST_OID refs/heads/main
>         EOF
>         git update-ref HEAD POST &&
>         test_cmp expect actual
> --
> 2.39.3 (Apple Git-146)
>
