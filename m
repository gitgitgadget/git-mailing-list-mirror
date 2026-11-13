Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794554514;
	b=sqXxXuqmes7tipoe6HWC80kN07ayjp94xua2nMtnpwUNKYolAczi4zOgHVWaevEV0v+r
	 U+stkBltuB1F2v07yWFnPWK7CUUcvZOChlpNU5ibGJGMX+nEs5W6QOwVe/fH+y1Jyws+L
	 EyoW0e0wLsiBk47S0uQLGcfNReCh5XPq6Yydb3767BUDQuDIS7RP3zi8TZlF//WW+bjdm
	 0mXpj/hFfeqYylc0s6Xwxf9Heg7s59yEfyuwMGjeXcTLlY0V+cbQVfyRdNBPwsviQQxlk
	 RUrGnKZ1A+wBFF7rYbIJvC3SVO6KE+MyfzxSyN5Pf8H2Pv3m9rbMHb0wR0BLANGJQhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794554514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=1bs8HndgpKn802z7wIm6pf9JY4zSQdrZbTHmU1p55gM=;
	b=H6x91SYmq1vA7PXaFkWylmHbBMSopOj46TlGnB54PpMMn+JHLK8MlcAO711x4p1DhPRn
	 W6yGQySfVIS+0NQBN6uGukpdxvuNE16a/f3ku/EF/sPJoPVlXAIgX2DKrcg28mq0VPeve
	 jr1hXU/X2ra1/una3YRxISczjL8Zz8E0E6ZNi+7630Vj4l/VL4TymWMg9eLYJg5RAou6V
	 QiOzO6Rr0fiR7HjWYbfYrkJZNSyhRM2EoDR6GBhMs7xhAkNK81ryMha/xvpzSfEhX9pBK
	 Zkl55+ItB5iXoxIVuvPdNVVXZJ7pm1assH3Y89JTXQchdlmyCI4s+jbm6ZYW9U5532g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="DtHL/FyL";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49DE606A321
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 07:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C49DE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DtHL/FyL
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5ecba17565dso28708e0c.0
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 23:21:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794554513; cv=none;
        d=google.com; s=arc-20260327;
        b=ZwyL0mDIWZBAtqAEbd2xg0FmFS9dzm+MN9MIfEeAl/RZwUm9HkIO0R2AfHoihskf9W
         XzjkdV4XLl9+QYY/pfbWQN2ioaki3WtE3UZ3/OVJ8WabAEC+08cpHz/d6m71UQQB5+53
         +EtvI/GbI5c9BV9vMHYfkY0QJlDgGQUdYa0FstRVDmRTpsExFP6UE4hE3LVnG5VzLJ48
         0mGbnhxtCeyt7HTXRGQTIdlv8DGr2c3+a2iNd+Zi+OyXrqU9zd3mKU3ncGeLthkroh3T
         uqgd/XteR9MzlANwDeXgSG7ZzN+0dGZfR2ZY2xF0KpH5zmItNtvGjSExK3XmRCFBWOEv
         Atfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1bs8HndgpKn802z7wIm6pf9JY4zSQdrZbTHmU1p55gM=;
        fh=jmd1vECO2w/BS7dzlj8PvIv2Gs0wmMPspz9UOROCxQc=;
        b=nriev93irI5lY+QOSCzpb8LrcQoQVi04LEP54HwEQo4NUsoRHHY/37wkGKvSFf13Qu
         LLXv8njE2yfuSpUePqgfF3Rzxes88GxsyWIc/RyfktR7SO+EpDm0aQ3LZDmPFXEeIiV/
         2Uq6AHwugzVXxpR5ypmLWG5HSaAWi+oKmjfdWcFXdDyWHXLys8hjEXvFGoIWi5ya8U25
         DWPMoVXMN2kiM+X8FWPtpcNtvc5HshkWibaB2W2pnvo3uvgBxQt94ikSy4vAu6RaxoZh
         htJqPaaJfxEUG7h4zgxmBTK/SeVoMy17jTEEFgiA04ze/SDuUYPwXgAwHzzao5xF+FEV
         DzkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794554513; x=1795159313; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1bs8HndgpKn802z7wIm6pf9JY4zSQdrZbTHmU1p55gM=;
        b=DtHL/FyLIta62I50068k+25DduurTfLnC05HoSMs1DjzVDuBYH+YoungCPHhvLlaXa
         lqLoHioaGlbGkI568oQb29Qyu/BEjUGwulPW0580wNO9GzMF9cphOkuVJJGX9DeD4QgC
         JVw+BEhkv1TM1XhEpeFUSWm/36RS2WTTL85C4FYXoGSXc2UUUZ8TQfwtNbVbMbAZtq/D
         MVg3Ny/mWYq9xA5HXIeG/pvIe973ou5cdXuLmq14x6/iLY96L1Hlu4TZag1MM6i4BFgr
         07s7Qo56XCQ+dOrYNp0+ksr2azpw4z1J7loqnupKZVlan8IJ36U9euqf+75Y3RGjKyGT
         wMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794554513; x=1795159313;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1bs8HndgpKn802z7wIm6pf9JY4zSQdrZbTHmU1p55gM=;
        b=aezq/ZdC3SIQCP0S1PgXc+TtojyPgJWU4VHlnu7hcnDxn0us3Byj4PGHqfZ5cDtLnd
         0yBdbg9vzsLcI3jQyo/mO4jCSiGq6G+nyFqp+JYbgvcQ+ROVaSohxb6x91zUxulghdVX
         I/VyIFJkJIPEKpdXmPsRvsuWFeHtR8BgIpWIRnuK50xJb1PE/TJNQB0ozFqHJNfl+Wpa
         LqatqTm+dVRclVYdS6fAgGuwOsRCeWFHAAz7+qMh+o6R+hoUHBNKEM38N5FqFo3zQU1s
         DZCoNk3BEw+l+j9LHsjB1KQ0IPqlRMFAT3X7ekpJGNthSn+AN8HjvDa79XVZlaJa7x2/
         tVGA==
X-Gm-Message-State: APuU4Z9yNvnhnBh+fXpp5VaDz79Px7ILKjWTevDnG6hPVBzuq0Rkvf9B
	3rsVeUXjS9fiDWSvSSWIj6julEpHrI5HyhuDVw/TVc31uMakh1ROy+PXEZIQV+q1Nx2iBVLUPSd
	sl0z9WH/sv5/MpvVW5SbkAW7KvqJV+9g=
X-Gm-Gg: AYBFou3cOrQQCYT4J4iRALxizURYcwnn0ufNGg61Et9oKkIJ2GxRZASb9e1Jii6g3Yn
	n+N86TMP/Yt62mmFftcKQl0KhyB0lexuVvxCgmNBi6rWxqzINq+yIWSQVsKlddiwyz2OMbQlisz
	Se2t2HwAKxakDSoZb7HfHn7edaloN9xE41U4fm8Tr2/YxRwSUa3mbSgk8qvL8g4mOKIlWb8KQ0G
	G8+MasXHhSbBu6rDSGHDGO/Bb1Z/xZ7ZSKWkxU8tY/RnkYB3YolhP1x9DYAQ+cTx2FJ6yn985lW
	lixCKekZu+nnGA9oMmt0xqKnVQ0jTSVro3LpyKhS0mxkb30MnpPl42Ep8y4Cccl+pqasE4m5ufP
	USKpIT7c2TyPpNY59u2EVDKwUDnpsIfs4+uZCaA==
X-Received: by 2002:a05:6122:6c08:b0:5ea:e18b:16a8 with SMTP id
 71dfb90a1353d-5ee344e846emr597466e0c.0.1794554512643; Thu, 12 Nov 2026
 23:21:52 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAOLa=ZTYevwM0YF0iQFnEwKG_buV7qg0QdjoaTkw0c8OQSd-mQ@mail.gmail.com>
 <20261110133457.43700-1-inoue.tsukasa.4@gmail.com> <CAOLa=ZQ559k_jrSrubdRcZofxLT+Fj=fi_e6BY=e2KJX_OJRag@mail.gmail.com>
In-Reply-To: <CAOLa=ZQ559k_jrSrubdRcZofxLT+Fj=fi_e6BY=e2KJX_OJRag@mail.gmail.com>
From: =?UTF-8?B?5LqV5LiK5Y+4?= <inoue.tsukasa.4@gmail.com>
Date: Fri, 13 Nov 2026 16:21:41 +0900
X-Gm-Features: AclHuK_mcKKhPNrubt4GCv54rSxOTJJkjYRQ7PSyf3FV5XVfS1cauek5bQUAuAs
Message-ID: <CAP8tz2+0+N1HLKc3y9hB-Ncaah7ni8ykrm5mB7N9Ji+Gc7zNaw@mail.gmail.com>
Subject: Re: [PATCH] refs: fix reflog of a symref whose target is in the same transaction
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Karthik Nayak <karthik.188@gmail.com> writes:

> Can't we use `string_list_lookup(&transaction->refnames, refname)`,
> which is a sorted list and uses a binary search.

I tried that first, but ref_transaction_prepare() sorts refnames only at
its start. The backends then add updates while preparing, for example
split_symref_update() for an update through HEAD, and
ref_transaction_add_update() appends those to refnames. A binary search
can then miss a target added that way. With HEAD pointing at
refs/heads/a:

    update HEAD <new>
    option no-deref
    symref-update refs/heads/s refs/heads/a

refnames becomes [HEAD, refs/heads/s, refs/heads/a], and a binary search
for refs/heads/a does not find it. I checked this on both backends: with
string_list_lookup() the reflog of s records the old value of a, with
the linear scan it records <new>. Keeping refnames sorted with
string_list_insert() would drop the duplicates that
ref_update_reject_duplicates() is meant to catch, so I left the scan in.
It only runs for symref updates that write a reflog. I'll add this case
as a test in v2.

> So `update->rejection_err` would be set only if the reference update
> failed. This would only happen if it was applied before the reflog
> update. What about reference updates which fail after the reflog update?

As far as I can see, the backends record all rejections while preparing
(in files_transaction_prepare(), reftable_be_transaction_prepare() and
the packed backend's write_with_updates()), and write the reflogs when
finishing. When the helper runs, the rejected updates are already
marked. A failure while finishing fails the whole transaction rather
than rejecting a single update.

> We could use a subshell, cd into it and then we don't have to
> 1. Do `-C repo` everywhere
> 2. Cleanup 'branch-cmd' and 'head-cmd'

Will do, and I'll add the blank lines.

> We should also probably add tests which use
> `REF_TRANSACTION_ALLOW_FAILURE` and check if a given reference
> update fails and do we apply the new/old value for the reflog then.

Good idea. I'll add a --batch-updates test where the update of the
branch is rejected and HEAD is pointed at it, and check that HEAD's
reflog records the branch's current value.

Thanks for the review!
Tsukasa

2026=E5=B9=B411=E6=9C=8812=E6=97=A5(=E6=9C=A8) 22:38 Karthik Nayak <karthik=
.188@gmail.com>:
>
> tsukasa inoue <inoue.tsukasa.4@gmail.com> writes:
>
> > When a transaction updates a ref and also points a symref at it, for
> > example
> >
> >     update refs/heads/y <new>
> >     symref-update HEAD refs/heads/y
> >
> > the reflog entry for HEAD should record <new>. Both backends get the
> > value for that entry by resolving the target with
> > refs_resolve_ref_unsafe(), which reads the refs as they are before the
> > transaction is applied.
> >
> > The reftable backend writes all updates into one table at the end, so
> > it always sees the old value of y. When y is created by the same
> > transaction it sees no y at all, takes the symref as dangling, and
> > writes no reflog entry. The files backend commits the updates one at a
> > time in the order they were queued, so it gets it right only when the
> > update of y comes before the one of HEAD.
> >
> > Add ref_transaction_resolve_new_oid(), which takes the new value from
> > the transaction when it updates the target, following symref updates
> > within it, and reads the ref store otherwise. Use it in both backends.
> >
> > Signed-off-by: tsukasa inoue <inoue.tsukasa.4@gmail.com>
> > ---
> >
> > Notes:
> >     This follows up on the report at
> >     https://lore.kernel.org/git/CAP8tz2L3Dfhd+ec4+SFkZgXmzQnBg+3Y0REAV+=
1Hf5X415qnfw@mail.gmail.com/
> >
> >     As discussed with Karthik there, this only moves the lookup of the
> >     target's new value to refs.c. Moving the rest of the reflog logic o=
ut
> >     of the backends, and resolving conflicting updates within a single
> >     transaction, are left for later.
> >
> >  refs.c                  | 47 +++++++++++++++++++++++++++++++++++++++++
> >  refs/files-backend.c    | 10 +++++----
> >  refs/refs-internal.h    | 12 +++++++++++
> >  refs/reftable-backend.c |  9 ++++++--
> >  t/t1400-update-ref.sh   | 36 +++++++++++++++++++++++++++++++
> >  5 files changed, 108 insertions(+), 6 deletions(-)
> >
> > diff --git a/refs.c b/refs.c
> > index 951db56113..3a5c225fc9 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -1388,6 +1388,53 @@ struct ref_update *ref_transaction_add_update(
> >       return update;
> >  }
> >
> > +static struct ref_update *find_ref_update(struct ref_transaction *tran=
saction,
> > +                                       const char *refname)
> > +{
> > +     size_t i;
> > +
> > +     for (i =3D 0; i < transaction->nr; i++) {
> > +             struct ref_update *update =3D transaction->updates[i];
> > +
> > +             if (!(update->flags & REF_LOG_ONLY) &&
> > +                 !strcmp(update->refname, refname))
> > +                     return update;
> > +     }
> > +
> > +     return NULL;
> > +}
>
> Can't we use `string_list_lookup(&transaction->refnames, refname)`,
> which is a sorted list and uses a binary search.
>
> > +
> > +int ref_transaction_resolve_new_oid(struct ref_transaction *transactio=
n,
> > +                                 const char *refname,
> > +                                 struct object_id *oid)
> > +{
> > +     int depth;
> > +
> > +     for (depth =3D 0; depth < SYMREF_MAXDEPTH; depth++) {
> > +             struct ref_update *update;
> > +
> > +             update =3D find_ref_update(transaction, refname);
> > +             if (!update)
> > +                     break;
> > +
> > +             if (!(update->flags & REF_HAVE_NEW) || update->rejection_=
err)
> > +                     break;
> > +
>
> So `update->rejection_err` would be set only if the reference update
> failed. This would only happen if it was applied before the reflog
> update. What about reference updates which fail after the reflog update?
> Would it make sense to schedule all reflog updates to the end, this
> would mean we know the status of all reference updates by then.
>
> > +             if (update->new_target) {
> > +                     refname =3D update->new_target;
> > +                     continue;
> > +             }
> > +
> > +             if (is_null_oid(&update->new_oid))
> > +                     return 0;
> > +             oidcpy(oid, &update->new_oid);
> > +             return 1;
> > +     }
> > +
> > +     return !!refs_resolve_ref_unsafe(transaction->ref_store, refname,
> > +                                      RESOLVE_REF_READING, oid, NULL);
> > +}
> > +
> >  static int transaction_refname_valid(const char *refname,
> >                                    const struct object_id *new_oid,
> >                                    unsigned int flags, struct strbuf *e=
rr)
> >                                        * symref updates. It would be ni=
ce to capture this as
>
> [snip]
>
> > diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> > index 1a164c96f9..19f0987d2f 100755
> > --- a/t/t1400-update-ref.sh
> > +++ b/t/t1400-update-ref.sh
> > @@ -853,6 +853,42 @@ test_expect_success 'stdin delete symref works opt=
ion no-deref' '
> >       test_cmp expect actual
> >  '
> >
> > +for action in update create
> > +do
> > +     for order in branch-first head-first
> > +     do
> > +             test_expect_success "stdin symref-update HEAD logs target=
's new value ($action, $order)" '
> > +                     test_when_finished "rm -rf repo branch-cmd head-c=
md" &&
>
> We could use a subshell, cd into it and then we don't have to
> 1. Do `-C repo` everywhere
> 2. Cleanup 'branch-cmd' and 'head-cmd'
>
> > +                     git init repo &&
> > +                     test_commit -C repo one &&
> > +                     test_commit -C repo two &&
> > +                     new=3D$(git -C repo rev-parse two) &&
> > +                     if test "$action" =3D update
> > +                     then
> > +                             git -C repo branch topic one
> > +                     fi &&
> > +                     echo "$action refs/heads/topic $new" >branch-cmd =
&&
> > +                     {
> > +                             echo "option no-deref" &&
> > +                             echo "symref-update HEAD refs/heads/topic=
"
> > +                     } >head-cmd &&
> > +                     if test "$order" =3D branch-first
> > +                     then
> > +                             cat branch-cmd head-cmd >stdin
> > +                     else
> > +                             cat head-cmd branch-cmd >stdin
> > +                     fi &&
> > +                     git -C repo update-ref -m "move HEAD" --stdin <st=
din &&
> > +                     echo "move HEAD" >expect &&
> > +                     git -C repo reflog -1 --format=3D%gs HEAD >actual=
 &&
> > +                     test_cmp expect actual &&
> > +                     echo $new >expect &&
> > +                     git -C repo reflog -1 --format=3D%H HEAD >actual =
&&
> > +                     test_cmp expect actual
>
> Nit: A few newlines to separate out blocks like the first few lines are
> setup and so on, could help readability :)
>
> > +             '
> > +     done
> > +done
> > +
>
> We should also probably add tests which use
> `REF_TRANSACTION_ALLOW_FAILURE` and check if a given reference
> update fails and do we apply the new/old value for the reflog then.
>
> >  test_expect_success 'stdin update symref works flag --no-deref' '
> >       git symbolic-ref TESTSYMREFONE $b &&
> >       git symbolic-ref TESTSYMREFTWO $b &&
> > --
> > 2.56.0
>
> Thanks for the patch. Some small comments from me.
