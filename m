Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F7E4A6CF5
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 19:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790279834; cv=pass; b=joor1A6z204bGrvlezVJAxT5mojo3jqjlQZ7st/i3RhRAR8ll9MfHs+wp+H5TUj56hUBtxWjBkdd4bcG2xvka+H3svX2kIpmGY8sVswIJJzx1D3myBQ2gehgm+QCOVlr4p6JFuNtwjy+duGjQxWVkP2ZAPWotg9Jub+zpf5k+1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790279834; c=relaxed/simple;
	bh=hEsPNNN7jW44KzV4rd0kY0bRrR0c9kJ2GIicusVJnd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dH23KevHgYcoBcsQnCDUNAqNLqzqWQ8ur36pwXjSCD5Emk2RTHh66pLzD1Alqam7fuhLmniNHfOxHAWkAam79e1Eo1EXNnASG4uBze/qfnGBld9JQt3Du9+JWYG75jHvnwhUUIXNlTFEzvYBTWT4nKh/s2NY/etmSRI9tljDogQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyE0VSAw; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyE0VSAw"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff163f65so939541fa.1
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 12:57:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790279821; cv=none;
        d=google.com; s=arc-20260327;
        b=Cv53JeZzRD8cPmTsKVxEhqYqwuP2RPtAmU5o0Vze0KeefhgwoD80CPBwOkhgxd1Mlq
         HBkKVbKG3OqEBTN/puqEPqt1SkRf+YK/fMr/56mcEVhWXQPAr+ZixY04pdYce4aVbeVi
         oUaiEEtVkUvL6DiLuRdcVj5gxgEBjjeYcs4rrwIdT7ziMEACHeYf9iO0A/nk5aIGOn/h
         GMXq3qzALHXqGgaDK159YE/gSvbmr4F58cYGnkswI7ksrYa24Fp8J1FH8Y7JCoew0j9J
         SDHZ+fMxHzgEHalCGbGZ8RghvO2nqtObB5RKP4R37Jn3HTCG7jXhzSfJ1sPV4PG5nwu2
         BdRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HORXT1aZ2xo/LCUQDROYJEBvM0Vb25q4BmduWozXyUU=;
        fh=1zplb4Yre2Dgu3TW3JfDYIRmGU4qgaHRtGD+TAzNK8Q=;
        b=W328lgTRU4UuXoxrIlefF8GF0w2hk1a/OguKDEMcDRgWUGHidbdl2i3rYFdUws5md0
         2x28IJeHMEwaSYBdNP+Q5TfZEQHRrngoyDXgETrBh6g6COI9Ecvw5AzOGBRyyA2KgL0/
         ckdfMJMMxPz1/EKlS2/O/R3kxrX0RGWykX+ZWSI+nlVXO+hDPwBPVo7ESXHvuKE8Lv2V
         uZS5vjifCMJVp4Kjzt3YjbGL/J9HCbUmNGWDi8nKhSFKd9ZnzjsCTg8igT8koUHcyH5n
         OIQ3dlkuD6LWvaj3sqZgbNPrYM/6Zxs5oaF6eDZ7rR2K4qYjjMpjEF2BVGLrSqjsix/r
         yhxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790279821; x=1790884621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HORXT1aZ2xo/LCUQDROYJEBvM0Vb25q4BmduWozXyUU=;
        b=ZyE0VSAwU/10YipHU5NDLlY8FvS84sZ+krIigsNxpWyeiv+FoUfNOqR4yOylAyX8vT
         DwaJcIcsoxlziVM7D0dRlZJAlrsbwIuFModwW7gKNi1Sjp7bvqrbgSlxwRRplqOV5SAu
         8nHz5fT3YjEOq6Nz6RqC8i5y5pHpKX79en3IaFuPsLpKRUtEJeE75VJMW+kr+zZgfm3x
         5tAPj5HTBKCA6LuAvcj59j+Q4lsyV9oN9w9eNyY3q0c1oxfdzWHSySQE9vQC3THqnIe4
         TKpqFZvLAP5+2SlSqsqTrQ0OFQV26MMMJHfQMimh/dYwAMzZKZ+bMSWqG6gkF6Fq1ebh
         KfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790279821; x=1790884621;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HORXT1aZ2xo/LCUQDROYJEBvM0Vb25q4BmduWozXyUU=;
        b=trgJwkHvkNg341ADu3uBJX8+HT/1uajdFOOTTkzoETU9GXVMxosxNyU4Vg08nBjsaj
         39DdclCEMOIoit6TDQDaKhhTeA/959lnquz4dOHygGU4pzOdMeNR6fDKOtkTwKpzM3JM
         jaWI0DC8sVzUpnDl6iY9oEzCKfTwrW9IzucyQ6IPjh/dFX6lXaLI+DPOhHcCAOSyan5U
         lA2ygiVKR5CNdMu+3hSbZ/6avw1xeJPlkbsFqQf36VLyrKFKdpNljKEnCIsy08ynvt2Y
         qOJLzXtDePc0xX1Kb2qRcf9XkpVIV8uj0izEVKVBRQS9yI95fETSCjQCa0b6EFkcJm8r
         xXiA==
X-Gm-Message-State: AFuF++mVLN/Ul3qcaq2YeW39xVGbHjIdHSLZbEH9w9Ixyt0WfieO9GLT
	baTnNAwJOFPTzPqMO3+X3K8hitOXpIMEQkQtSRH+GeZzY+kwBli0YgZ8VHsR55KRgmF8sAic9oY
	nAwpiH/4SoL1obMdJzABbwC+nOolvO5Y=
X-Gm-Gg: AYBFou3OQYWL7ai15RrPQIGDHwFT5+1eV3dNz6imwBQXvmqowQ1RI0VDHe9P5st2+t/
	YyBB1bu0f0P+MMCHeFhdYWlj67MMboBoufa63Ctt7DR5yIaNqh305HO8XW3+5zMON4z6chg5jeL
	kzDoQa+RlBipPSYp7GQNuM9TnH9SQP3vYk1I/BAGh1UBuP5dHieunsup9EUE0EU0gdnxAJp2w+c
	R1veFf+utADcV86ybKheXMhLUgPTM4k0zpy+nzYZGnvjU3PvwvTbR1500gcVTXoP+8ZJqNE7pSt
	ZdyESKO6JwexkAzEiFj4fD6uSKFkI1/QeUpWK4+Vp1D5a5Za+UT12SLgvIp9hQXkH9LecNHZ/oS
	nx52E5DXw6MGGYxyRBxFgLo4mwKQynbOjDi0dL+xhAg8eKFNbyyvnGxjXjMn4J8SKEswTNw==
X-Received: by 2002:a2e:a812:0:b0:3a3:749e:31a1 with SMTP id
 38308e7fff4ca-3a63de5c715mr7419751fa.21.1790279821209; Thu, 24 Sep 2026
 12:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790113781.git.maciej.ciemborowicz@gmail.com>
 <cover.1790196627.git.maciej.ciemborowicz@gmail.com> <9b76cc2c40a2b1fe727677a9400e3b26ec1ab437.1790196627.git.maciej.ciemborowicz@gmail.com>
 <arUEhkuC448hUTCw@pks.im>
In-Reply-To: <arUEhkuC448hUTCw@pks.im>
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Thu, 24 Sep 2026 21:56:49 +0200
X-Gm-Features: AclHuK8JQ6A9F78hQwZr8-Lnl0tfPM6Ge5vhv5i8324CdvHmQHPacDSXtdR9gJI
Message-ID: <CACQ=SRG4GEOzym27GxkR7Cu+Rq5o0Wbr75AU5sA7awKa2eHuUQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] refs: allow callers to supply old OIDs for batch deletion
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Phil Hord <phil.hord@gmail.com>, 
	Elijah Newren <newren@gmail.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	"D . Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Taking a step back though... the only reason that this function really
> exists is to provide a convenience wrapper that deletes references while
> we don't care for the old state. If we want to not do that anymore and
> instead want to expect a specific old OID, is this function still the
> right function to use?

Agreed. Extending refs_delete_refs() seems to be the wrong layer for this.

I will try to rework the patch so that refs_delete_refs(),
ref_transaction_delete(), and callers remain unchanged. Instead, the
common transaction hook layer could record a separate observed old value
for updates whose callers did not supply one. That value would be used only
as hook input and would not set REF_HAVE_OLD or otherwise constrain the
update.

This should also allow me to remove the failed_refs interface and the
special handling of null_oid from the current version.

Thanks,
- Maciej Ciemborowicz


On Thu, Sep 24, 2026 at 1:07=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Wed, Sep 23, 2026 at 11:04:40PM +0200, Maciej Ciemborowicz wrote:
> > refs_delete_refs() performs unconditional deletions, so callers cannot
> > preserve old values that they have already resolved. Consequently,
> > reference-transaction hooks see a null old OID.
> >
> > Let callers provide an optional array of expected old OIDs in parallel =
with
> > the refname list. Delete the ref at position N only if it still points =
at
> > the OID at position N. Treat a null OID as an unconditional deletion in
> > ref_transaction_delete(), allowing callers to include broken refs whose=
 old
> > value cannot be resolved.
> >
> > refs_delete_refs() has always promised best-effort deletion. Always use
> > REF_TRANSACTION_ALLOW_FAILURE and report rejected updates so one failur=
e
> > does not prevent independent refs in the batch from being deleted. Let
> > callers request the exact set of failed refs when they need to report
> > partial results. This also completes the conversion that was missed whe=
n
> > batched transaction failure support was introduced.
>
> Taking a step back though... the only reason that this function really
> exists is to provide a convenience wrapper that deletes references while
> we don't care for the old state. If we want to not do that anymore and
> instead want to expect a specific old OID, is this function still the
> right function to use?
>
> In other words, shouldn't the callers instead be updated to drive their
> own transaction if they want more complex behaviour?
>
> > diff --git a/refs.c b/refs.c
> > index 92d5df5b7..13ee2d459 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -1523,7 +1524,7 @@ int ref_transaction_delete(struct ref_transaction=
 *transaction,
> >                          struct strbuf *err)
> >  {
> >       if (old_oid && is_null_oid(old_oid))
> > -             BUG("delete called with old_oid set to zeros");
> > +             old_oid =3D NULL;
> >       if (old_oid && old_target)
> >               BUG("delete called with both old_oid and old_target set")=
;
> >       if (old_target && !(flags & REF_NO_DEREF))
>
> I'm not a huge fan of starting to treat a null OID as something other
> than "this branch should not exist". Everywhere else it still does, so
> mixing this feels fishy to me.
>
> Also, this change wouldn't have to exist if we instead started to drive
> a proper transaction.
>
> > @@ -3069,39 +3070,73 @@ void ref_transaction_for_each_rejected_update(s=
truct ref_transaction *transactio
> >       }
> >  }
> >
> > +struct delete_refs_rejection_data {
> > +     int failures;
> > +     struct string_list *failed_refs;
> > +};
> > +
> > +static void delete_refs_rejection_handler(const char *refname,
> > +                                       const struct object_id *old_oid=
 UNUSED,
> > +                                       const struct object_id *new_oid=
 UNUSED,
> > +                                       const char *old_target UNUSED,
> > +                                       const char *new_target UNUSED,
> > +                                       enum ref_transaction_error err,
> > +                                       const char *details,
> > +                                       void *cb_data)
> > +{
> > +     struct delete_refs_rejection_data *data =3D cb_data;
> > +
> > +     warning(_("could not delete reference %s: %s"), refname,
> > +             details ? details : ref_transaction_error_msg(err));
> > +     data->failures++;
> > +     if (data->failed_refs)
> > +             string_list_insert(data->failed_refs, refname);
> > +}
> > +
> >  int refs_delete_refs(struct ref_store *refs, const char *logmsg,
> > -                  struct string_list *refnames, unsigned int flags)
> > +                  struct string_list *refnames,
> > +                  const struct oid_array *old_oids,
> > +                  struct string_list *failed_refs,
> > +                  unsigned int flags)
>
> And here we also have to yield failed refs now because we don't have a
> better mechanism. Same as before though, if we used a ref transaction
> we'd already have that mechanism.
>
> So overall I'm not quite on board with this change, as I think it's going
> down the wrong route. If you want more complex behaviour when deleting
> refs you should use a ref transaction, as it would already handle all of
> what you're trying to do here.
>
> Patrick
