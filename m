Received: from mail-lr2-f33.google.com (mail-lr2-f33.google.com [74.125.230.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC5D389100
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790876241; cv=pass; b=jw7BBWwi8LNKQS2BaFkJcfiPGWDwHROx8gji/8g6Gnz889Skf1dNBrfZLBc7EOnzCTru+wwsO+EA01RtkByTnemL4mUwiE7T6TsgBtseFrxSwWsxVt31ew9AV2BKMdCOLVI8Eht4rngCHCMsJZ7A5ziNLCpkwBBFxUQcrbQ658g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790876241; c=relaxed/simple;
	bh=OWRRTilC2eUGFePBPOln7iGtikGcs4ddegq3ZAF6tgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJtrq6R9ZMGtzMOxXA2dGCXs76z5itUBpuGz2O1VzCd5sBVfrQ9DRNt4jVDo6UDiTiE+5beyIkfJOm1RJJXtT+j5wnwOh1Tb5BIIY3dNtWKXg+BsmZR9Hs8tYWZyyjwLoDXAS6REF9r9dkCkAS3iifJAYeXTcL6Rjjz4Joe4zHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVBRtYCe; arc=pass smtp.client-ip=74.125.230.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVBRtYCe"
Received: by mail-lr2-f33.google.com with SMTP id 38308e7fff4ca-3a8736cfa68so6970841fa.3
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 10:37:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790876237; cv=none;
        d=google.com; s=arc-20260327;
        b=Yz5qgHYrNptRjOTwDzj65JOwXP/M24hIpIwY5yTF2Rm1t6LZutgYwvLR6lEOGSGPFi
         UI292WgCtfDZPuPt7jnRp/DAN7NQJOvBuj5YehZ77WDhqR9uU7DtDnqniCGWaqCQkcAC
         UDyhxe7k5I3prPQBelBicg9jLQcP7dtsByL4G9HTtzgUBtRFn5ki+2Q6q1fDdf21/LCu
         IpRDgVxxLyIADpgqgJ8q9H1mZCijP5dpyvj+Xu+ZpjRM9pqylPWqyKO+KyAukuDqJjPM
         vtmnnWfDpezLuAwrJutpWuFbtzrMhyzqi8R968z5Q8dJLZ9z0HLKuiQKSkhL9KlEuRO6
         LyNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=37Kh+t/x6nuqvruY+Ud+Lhit7YGKtEUbnfiDtDKm9FQ=;
        fh=L1yafwIze6xUY2o9eVHBQzfz0sUnW3NspKTnW32t2Ms=;
        b=Ut0+no9lbg0t/1RgRE5RZQDJyyQ7gu1/z0SAu9W6vDWpWoTe96Cmz29e/sRWP/MJ+S
         Pu3kEqyB363dJ+onxocBc3dCA8rfXCpI44baXgSBej6XUXJFY4qnOJiudk9zpHh/u+Bp
         Fqe/MIyxpIF/ljo+Xt/Fi37rwXnGM0Tr37wJRiHs82h8f8itfSeql9Bp1M4VWa6VGEkR
         3HoDIQcm2iZ2iMePRjCM07KKtPYERmoOqmwXWETZPHn4p8fCJ+TGCXTS1U04vvCCLmWR
         D4uPFR5V+UKGFp6Djs9SIy4lgrEuaiIaTbPdshwHYYtT/JSSSBBOCVEZ/RTvMtzQUAIO
         o6mA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790876237; x=1791481037; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=37Kh+t/x6nuqvruY+Ud+Lhit7YGKtEUbnfiDtDKm9FQ=;
        b=hVBRtYCeR4+FGEkHy/ZjlaKKhd9E/X530b2c7qeAYl/dcMTpqdV7rPOp35qSUFsLl1
         5Yv/fW3+5XP8T1s6SlASof5Tk2InSd4knWkyLcHrErLIe1+Pi6E8V95qybsY4IZwpPfa
         YMlMOZiAGEaVks4OSaTosuEiGwu27WN4xh0rrUIXJ2fbap3rSPC8RXt+Wsuz23Xo5zWt
         RDnImzXJmdX6YtrFDbw/TMJYN/XHps8IspdYcnvH2tccML5neeqMm6PPrfSvpriZIb9x
         xPpKkd42QZ4y0/igL+9XRaYnqasEMOUkosdCe2C4ZRWQQtdkVIcXtOyYRgvd/5Sz08TC
         Keag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790876237; x=1791481037;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=37Kh+t/x6nuqvruY+Ud+Lhit7YGKtEUbnfiDtDKm9FQ=;
        b=n4hT3ipzWaBgiQ4phAppN38YKl887ZPxlWEkvlHnQVYT/nRIwcIOkbyjlkwC85YKMo
         KnztwSiA5OQQhUtMiqH/fPzG/2JE+wp9QLUnLbfmDFW0W3mieYmBms7l9OO5PV2YhSFc
         XzXUPxlbsqO/sa+aNHfOfK7dVUOXBUcj4H60vOlDsL83s9Z0zutn4DWhkrcthaWOVwbQ
         EV4FCzi8w890l27bqvhGSdDi/2vbo/t0GpYWfI4Pl0Phhjl5uc3+gCEUa5uCHVYrWz4n
         2rtI3TpRDoLIfTd11j8T4nYRQCftsJQpy8VbxVeX4eV+TJJD/ALdKgkh27GHXWlwETZI
         nfdw==
X-Gm-Message-State: AFq9FYLMuFyAvXTZvTVsHsKsCGwZ1CyF9MrJhjxJWrjoinLeh8lCw/MB
	lVNqv45Kp+aGdMGlnI0bzDPjQKG7ooWcgsieWgG4FONCB8IFmTPtLZMufXo6Iv8ysw3+QKF+4xs
	kyXq2VwrZECPYPhXAzXdHRpOp62u6I9CGL3MqzjY=
X-Gm-Gg: AYBFou0I3lfIeUIwGcQJK9tsYGZZirrsVPwdKBINW2RiS7eefJCQP9MX5MxxLZOxPiG
	xyfY3tTNGr4kiTXAAQIExf2PloW0jHU2LmA4IcC/NTUhDdX9IGuEgJJB4JkJJvbSx/K62ABkLkj
	x1KqEZ8dLyz7p1SjYfVWhQvmZFwODljCHKGcLcaHDY5QQE/HtLhB9NsOnS5/49LUtwHyTY200YM
	n1/FWr023CZtfaFQccxrl6o6yogTNd30E+UTmzINMNhzlLXke7zuej3pyzyDfLk5RZBgs29l0iq
	Yp5/PYpHHGvY24273sBtcKuo5ZNWYEdkYzfdlOTfV6Hvee/deAZS1Y58P/SjeVA5FHHjmsVzxtb
	kBgJPvfd1F+5tmjJFdwUa0QkDJ9FetFOUz23ryvyoNoIWc/yBF+QMEJd7uaX0FshfLkgQ3g==
X-Received: by 2002:a2e:a585:0:b0:3a6:61a1:ad9f with SMTP id
 38308e7fff4ca-3a7791dbeb3mr15362311fa.6.1790876237111; Thu, 01 Oct 2026
 10:37:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790196627.git.maciej.ciemborowicz@gmail.com>
 <cover.1790269745.git.maciej.ciemborowicz@gmail.com> <2af3eeadd18806c5298d53072428656885cff89d.1790269745.git.maciej.ciemborowicz@gmail.com>
 <CACQ=SRFWAJSRO7d5PcTK_FZBJrhdcr1ff_FfTUWmnQNB-WBnUA@mail.gmail.com>
In-Reply-To: <CACQ=SRFWAJSRO7d5PcTK_FZBJrhdcr1ff_FfTUWmnQNB-WBnUA@mail.gmail.com>
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Thu, 1 Oct 2026 19:37:05 +0200
X-Gm-Features: AclHuK9zylLXqDJJJB69FRT4S54IgRn6LCZ8RmulY1U2wHfjmcvlTFe1ahstwN0
Message-ID: <CACQ=SRGuk2+b2o=xG=fYVM4-RZw1bg_Lw002w1Ytv4-1GfnXKA@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] refs: report old values to transaction hooks
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>, Phil Hord <phil.hord@gmail.com>, Elijah Newren <newren@gmail.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	"D . Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Change of priorities. I originally reported this bug while working on
git-hooks-ext and semantic events for reference transactions:

https://github.com/ciembor/git-hooks-ext

However, today I managed to resolve the issues I had encountered with
branch and tag deletion by using the data returned earlier by the
transaction in the prepared state.

As a result, this bug is now a much lower priority for me. The last
issue I still need to resolve (and I don't see a reasonable way to
address it without fixing the bug in Git) is branch renaming:

https://lore.kernel.org/git/CAOLa=3DZTN1TU2A1sgEhiw=3DymMYr6Ge11cMEubSaeKqr=
4WNU=3D2EQ@mail.gmail.com/T/#t

I would appreciate it if more attention could be given to that bug instead.

Thanks,
Maciej Ciemborowicz

On Wed, Sep 30, 2026 at 5:11=E2=80=AFAM Maciej Ciemborowicz
<maciej.ciemborowicz@gmail.com> wrote:
>
> If anyone finds the time, I=E2=80=99d appreciate a code review. I=E2=80=
=99d like to
> close this chapter (hopefully get it upstream) and move on to working
> on the next bug.
>
> Thanks,
> - Maciej Ciemborowicz
>
> On Fri, Sep 25, 2026 at 12:33=E2=80=AFAM Maciej Ciemborowicz
> <maciej.ciemborowicz@gmail.com> wrote:
> >
> > The reference-transaction hook reports an all-zero old object ID whenev=
er
> > the caller does not supply an expected old value. Consequently, batched
> > branch, tag, and remote-ref deletions report zero as both the old and n=
ew
> > object IDs because refs_delete_refs() intentionally queues unconditiona=
l
> > deletions.
> >
> > Changing those callers to provide expected old values would make the
> > deletions conditional and alter existing command behavior. Instead, rec=
ord
> > the current raw ref value separately for the hook. Read it before the
> > "preparing" hook, then refresh it after the backend has locked the refs=
 so
> > that the "prepared" and later phases report the value protected by the
> > transaction's locks. Keep this value separate from old_oid and old_targ=
et so
> > it does not set REF_HAVE_OLD or otherwise constrain the update.
> >
> > Only resolve these values when a reference-transaction hook exists. Pre=
serve
> > symbolic refs as targets, consistent with the hook's existing symref fo=
rmat.
> > Document that an unlocked "preparing" value may differ from later phase=
s if
> > the ref changes before it is locked.
> >
> > Add coverage for batched branch deletion, tag deletion, and remote prun=
ing.
> > Also exercise a concurrent update from the "preparing" hook to verify t=
hat
> > the deletion remains unconditional while later hook phases report the v=
alue
> > actually removed.
> >
> > Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
> > ---
> >  Documentation/githooks.adoc      | 17 +++++----
> >  refs.c                           | 54 ++++++++++++++++++++++++---
> >  refs/refs-internal.h             |  8 ++++
> >  t/t1416-ref-transaction-hooks.sh | 64 +++++++++++++++++++++++++++++++-
> >  4 files changed, 128 insertions(+), 15 deletions(-)
> >
> > diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
> > index ed045940d1..f60dd1d582 100644
> > --- a/Documentation/githooks.adoc
> > +++ b/Documentation/githooks.adoc
> > @@ -509,14 +509,15 @@ receives on standard input a line of the format:
> >    <old-value> SP <new-value> SP <ref-name> LF
> >
> >  where `<old-value>` is the old object name passed into the reference
> > -transaction, `<new-value>` is the new object name to be stored in the
> > -ref and `<ref-name>` is the full name of the ref. When force updating
> > -the reference regardless of its current value or when the reference is
> > -to be created anew, `<old-value>` is the all-zeroes object name. To
> > -distinguish these cases, you can inspect the current value of
> > -`<ref-name>` via `git rev-parse`. During the "preparing" state, symbol=
ic
> > -references are not resolved: `<ref-name>` will reflect the symbolic re=
ference
> > -itself rather than the object it points to.
> > +transaction, or the value observed while preparing the transaction if =
no
> > +old object name was passed. `<new-value>` is the new object name to be
> > +stored in the ref and `<ref-name>` is the full name of the ref. When t=
he
> > +reference does not exist, `<old-value>` is the all-zeroes object name.
> > +Because references are not yet locked in the "preparing" state, its ob=
served
> > +old value may differ from the value reported in subsequent states if t=
he
> > +reference changes before it is locked. During the "preparing" state,
> > +symbolic references are not resolved: `<ref-name>` will reflect the sy=
mbolic
> > +reference itself rather than the object it points to.
> >
> >  For symbolic reference updates the `<old_value>` and `<new-value>`
> >  fields could denote references instead of objects. A reference will be
> > diff --git a/refs.c b/refs.c
> > index 92d5df5b71..d2d25402c3 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -1260,6 +1260,7 @@ void ref_transaction_free(struct ref_transaction =
*transaction)
> >                 free(transaction->updates[i]->committer_info);
> >                 free((char *)transaction->updates[i]->new_target);
> >                 free((char *)transaction->updates[i]->old_target);
> > +               free(transaction->updates[i]->hook_old_target);
> >                 free((char *)transaction->updates[i]->rejection_details=
);
> >                 free(transaction->updates[i]);
> >         }
> > @@ -2606,6 +2607,8 @@ static int transaction_hook_feed_stdin(int hook_s=
tdin_fd, void *pp_cb, void *pp_
> >         struct transaction_feed_cb_data *feed_cb_data =3D pp_task_cb;
> >         struct strbuf *buf =3D &feed_cb_data->buf;
> >         struct ref_update *update;
> > +       const struct object_id *old_oid;
> > +       const char *old_target;
> >         size_t i =3D feed_cb_data->index++;
> >         int ret;
> >
> > @@ -2619,12 +2622,18 @@ static int transaction_hook_feed_stdin(int hook=
_stdin_fd, void *pp_cb, void *pp_
> >
> >         strbuf_reset(buf);
> >
> > -       if (!(update->flags & REF_HAVE_OLD))
> > -               strbuf_addf(buf, "%s ", oid_to_hex(null_oid(transaction=
->ref_store->repo->hash_algo)));
> > -       else if (update->old_target)
> > -               strbuf_addf(buf, "ref:%s ", update->old_target);
> > +       if (update->flags & REF_HAVE_OLD) {
> > +               old_oid =3D &update->old_oid;
> > +               old_target =3D update->old_target;
> > +       } else {
> > +               old_oid =3D &update->hook_old_oid;
> > +               old_target =3D update->hook_old_target;
> > +       }
> > +
> > +       if (old_target)
> > +               strbuf_addf(buf, "ref:%s ", old_target);
> >         else
> > -               strbuf_addf(buf, "%s ", oid_to_hex(&update->old_oid));
> > +               strbuf_addf(buf, "%s ", oid_to_hex(old_oid));
> >
> >         if (!(update->flags & REF_HAVE_NEW))
> >                 strbuf_addf(buf, "%s ", oid_to_hex(null_oid(transaction=
->ref_store->repo->hash_algo)));
> > @@ -2660,6 +2669,36 @@ static void transaction_feed_cb_data_free(void *=
data)
> >         free(d);
> >  }
> >
> > +static void resolve_transaction_hook_old_values(struct ref_transaction=
 *transaction)
> > +{
> > +       struct ref_store *refs =3D transaction->ref_store;
> > +       struct strbuf referent =3D STRBUF_INIT;
> > +
> > +       if (!hook_exists(refs->repo, "reference-transaction"))
> > +               return;
> > +
> > +       for (size_t i =3D 0; i < transaction->nr; i++) {
> > +               struct ref_update *update =3D transaction->updates[i];
> > +               unsigned int type =3D 0;
> > +               int failure_errno;
> > +
> > +               if (update->flags & (REF_HAVE_OLD | REF_LOG_ONLY))
> > +                       continue;
> > +
> > +               oidclr(&update->hook_old_oid, refs->repo->hash_algo);
> > +               FREE_AND_NULL(update->hook_old_target);
> > +               strbuf_reset(&referent);
> > +
> > +               if (!refs_read_raw_ref(refs, update->refname,
> > +                                      &update->hook_old_oid, &referent=
,
> > +                                      &type, &failure_errno) &&
> > +                   (type & REF_ISSYMREF))
> > +                       update->hook_old_target =3D xstrdup(referent.bu=
f);
> > +       }
> > +
> > +       strbuf_release(&referent);
> > +}
> > +
> >  static int run_transaction_hook(struct ref_transaction *transaction,
> >                                 const char *state)
> >  {
> > @@ -2709,6 +2748,8 @@ int ref_transaction_prepare(struct ref_transactio=
n *transaction,
> >         if (ref_update_reject_duplicates(&transaction->refnames, err))
> >                 return REF_TRANSACTION_ERROR_GENERIC;
> >
> > +       resolve_transaction_hook_old_values(transaction);
> > +
> >         /* Preparing checks before locking references */
> >         ret =3D run_transaction_hook(transaction, "preparing");
> >         if (ret) {
> > @@ -2720,6 +2761,9 @@ int ref_transaction_prepare(struct ref_transactio=
n *transaction,
> >         if (ret)
> >                 return ret;
> >
> > +       /* Refresh old values now that the references are locked. */
> > +       resolve_transaction_hook_old_values(transaction);
> > +
> >         ret =3D run_transaction_hook(transaction, "prepared");
> >         if (ret) {
> >                 ref_transaction_abort(transaction, err);
> > diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> > index c3ac7b556f..a7471b2481 100644
> > --- a/refs/refs-internal.h
> > +++ b/refs/refs-internal.h
> > @@ -99,6 +99,14 @@ struct ref_update {
> >          */
> >         struct object_id old_oid;
> >
> > +       /*
> > +        * The old value observed for the reference-transaction hook wh=
en the
> > +        * caller did not provide an expected old value. Unlike old_oid=
 and
> > +        * old_target, these fields do not constrain the update.
> > +        */
> > +       struct object_id hook_old_oid;
> > +       char *hook_old_target;
> > +
> >         /*
> >          * If the new_oid points to a tag object, set this to the peele=
d
> >          * object ID for optimized retrieval without needed to hit the =
odb.
> > diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction=
-hooks.sh
> > index 4fe9d9b234..fcc7404943 100755
> > --- a/t/t1416-ref-transaction-hooks.sh
> > +++ b/t/t1416-ref-transaction-hooks.sh
> > @@ -14,6 +14,66 @@ test_expect_success setup '
> >         POST_OID=3D$(git rev-parse POST)
> >  '
> >
> > +test_expect_success 'hook gets old values for batched unconditional de=
letion' '
> > +       test_when_finished "rm -f actual" &&
> > +       test_when_finished "git remote remove origin && rm -rf empty.gi=
t" &&
> > +       git init --bare empty.git &&
> > +       git remote add origin ./empty.git &&
> > +       git branch delete-a PRE &&
> > +       git branch delete-b POST &&
> > +       git tag delete-tag POST &&
> > +       git update-ref refs/remotes/origin/to-prune $PRE_OID &&
> > +       test_hook reference-transaction <<-\EOF &&
> > +               if test "$1" =3D committed
> > +               then
> > +                       cat >>actual
> > +               fi
> > +       EOF
> > +       git branch -D delete-a delete-b &&
> > +       git tag -d delete-tag &&
> > +       git remote prune origin &&
> > +       cat >expect <<-EOF &&
> > +               $PRE_OID $ZERO_OID refs/heads/delete-a
> > +               $POST_OID $ZERO_OID refs/heads/delete-b
> > +               $POST_OID $ZERO_OID refs/tags/delete-tag
> > +               $PRE_OID $ZERO_OID refs/remotes/origin/to-prune
> > +       EOF
> > +       test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'unconditional deletion remains unconditional' '
> > +       test_when_finished "rm -f actual" &&
> > +       test_when_finished "rm -f \"$(git rev-parse --git-path delete-r=
ace-once)\"" &&
> > +       git branch delete-race PRE &&
> > +       test_hook reference-transaction <<-\EOF &&
> > +               state=3D$1
> > +               while read -r old new ref
> > +               do
> > +                       if test "$state" !=3D aborted
> > +                       then
> > +                               case "$new" in
> > +                               *[!0]*) ;;
> > +                               *) echo "$state $old $new $ref" >>actua=
l ;;
> > +                               esac
> > +                       fi
> > +               done
> > +               marker=3D$(git rev-parse --git-path delete-race-once)
> > +               if test "$state" =3D preparing && test ! -e "$marker"
> > +               then
> > +                       >"$marker"
> > +                       git update-ref refs/heads/delete-race POST
> > +               fi
> > +       EOF
> > +       git branch -D delete-race &&
> > +       cat >expect <<-EOF &&
> > +               preparing $PRE_OID $ZERO_OID refs/heads/delete-race
> > +               prepared $POST_OID $ZERO_OID refs/heads/delete-race
> > +               committed $POST_OID $ZERO_OID refs/heads/delete-race
> > +       EOF
> > +       test_cmp expect actual &&
> > +       test_must_fail git show-ref --verify refs/heads/delete-race
> > +'
> > +
> >  test_expect_success 'hook allows updating ref if successful' '
> >         git reset --hard PRE &&
> >         test_hook reference-transaction <<-\EOF &&
> > @@ -65,7 +125,7 @@ test_expect_success 'hook gets all queued updates in=
 prepared state' '
> >                 fi
> >         EOF
> >         cat >expect <<-EOF &&
> > -               $ZERO_OID $POST_OID refs/heads/main
> > +               $PRE_OID $POST_OID refs/heads/main
> >         EOF
> >         git update-ref HEAD POST <<-EOF &&
> >                 update HEAD $ZERO_OID $POST_OID
> > @@ -87,7 +147,7 @@ test_expect_success 'hook gets all queued updates in=
 committed state' '
> >                 fi
> >         EOF
> >         cat >expect <<-EOF &&
> > -               $ZERO_OID $POST_OID refs/heads/main
> > +               $PRE_OID $POST_OID refs/heads/main
> >         EOF
> >         git update-ref HEAD POST &&
> >         test_cmp expect actual
> > --
> > 2.39.3 (Apple Git-146)
> >
