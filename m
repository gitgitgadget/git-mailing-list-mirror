Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8E833556D
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 01:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787276659; cv=pass; b=iE2PcnzX+RbglBTHoHVnHGY8/Ggsgba+9+Le2cr3MLvKhFyCZvpT8ETVUCAPHhxpF1AQzKO30GLa4kC5knfj1rdgdu3rflMzym+TJHIIy9Mh6zqUYsVv2OTjKBS3v0k6FM1oWbrblTFiIOC7yLbjnNXbE2DCEYkHSeEPO8AvGos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787276659; c=relaxed/simple;
	bh=xSz8g8P+4blqmsZrj3ObikhWI/MNpZCohM721ECcz8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+qfeGr6RBPmUE7HpCpt6C+LUmy5/ZV3O+gdThhOnw9j4WMlESqZXYuryuRJdTKcnpR1YmIHtejevsyW3SWWHt/GF33G6QmtuvpW7qPpcLcJQ9vQ3MiW8Q6FzIimTaBjcQGd7o+Uz51DEFdU1kv7eW+vepZbUwxAgKQuvcXJG8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9BT8viZ; arc=pass smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9BT8viZ"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-49ff971e903so1134717b6e.0
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 18:44:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787276656; cv=none;
        d=google.com; s=arc-20260327;
        b=BeT2mK7Vz0yZECN42RR+DdGdGtHd+ADb+qnMbpzRp8ZfksYwATfPeuqF1lx8FlzgSm
         65ExP+jwYigIma1i16IYdUUVGnWB8DZL5/hBPla7XQI3WG/crTFGdeJC/TKF+0f5wDsH
         IyLOs2NgQgBik5SZQVzaUI2berbg4FGp41GyC0iAQ6Ns5eqWuJ96j6v+vDR413yCJQQq
         xcyMitJlBv6bmrJZ/Q+4yzy3fsbqFCMyzg+8iJB8ZveyBAk2J6sQBcwF/I6y4DnkSRfC
         qZy1aIc0uozxecT9TiTRZGyZfTD+yOrmjuDjnLiZ7Hs+tRWtYJh+ECCdfXa54Tl+ngHk
         9VJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KAqJ4nH2FZYnt/QVbsimN3resQk98XIAVAJjBkwAGKg=;
        fh=ZoYMX4CE6Nj+TQb/ORsafggn5GaZ6eK222dztSSfULs=;
        b=kt0AMpHUJWAysAeTHGyTMm14ag5alKTwa9v9C3KOBQU3SLECiDovMlOL0YRKHwLOJb
         FFr+Boo+dpO9SC8ve0oLPTGsmeSb1RREyZkJ9TNY0tAJJq728dif2XbW42bFUQqaj/RT
         LKu3G36mFWUmQ4nqj0W4bGrXhB0BJ7O+NcDuY0wsIVVpC0lL2zUawutAZlsOrLlQlZAE
         cv38rmemWHL3GEZdXJAQMwKFUP8Df4YKo738Ak8kqRLS8cZvmyszFEFEVub5Ijcdzlud
         qYjp7NUDMWUpu/CIL9dataSKVim+ysgCdWUPZ/HUOedIpAdLF+LjVjveWf6dIOC0sUo7
         GIPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787276656; x=1787881456; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KAqJ4nH2FZYnt/QVbsimN3resQk98XIAVAJjBkwAGKg=;
        b=l9BT8viZ/2k8q3yxTdk43sPqmmebFNYe0DynToW/6a0qTCkcooAhJBp3k/ZNgu7w49
         BgCXDdcmVkLNntuHq5XLq8Mu38t8L0HNMvptcxCzpSqcnwnm18VLoMYbc4TQv0HlmDiy
         Lhx1uLlfD6EwgPEUeK8osJsK0GNlb5T3VJl4a7uy5ojciUFmHiV5mkhbUgN74pU5ESHW
         fBSKnp/RagI13WOwAFlDYLQZg9EmzBaT75DVwNn0+VcW4+SIViNgaH/JObJBawIEFhBq
         LZzmj7eORONg3hBsrUU5qa4PR5TBowd3ZqUxS5XpZAQoGqofYn0zQPj5aBBP1IBXNRCX
         cOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787276656; x=1787881456;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KAqJ4nH2FZYnt/QVbsimN3resQk98XIAVAJjBkwAGKg=;
        b=pToNacQomSOdxyf0MjQCUCAbfkDzh9nuwdT7krmBa21pEIaa1ijl3/zWlxcbbi74Ei
         dRNlJbrrkd8+WoX5iUCRO+YCdiRWMcbf47mYFNVTk3LABRKhq31Dvk1pZXu9xJTjsRav
         IMhY3BYa5d3LVQgMP3OV77jn+goSEdsb3u90JZhfbx4fSC5brq8aTsZ0kcgBOacSJKFZ
         tYqlItULHoJy6TD9YYQGNWXLcuC9OIJ3g3MX09VO7tSkeXlVGHz0Yar/S844S0EqRjGZ
         uywc3szl/IR4JEPDOjfXkcLlXMnPe0vvjEldJmo10iZ2qxIoIMUverrY8MiVkReL3bq/
         54mg==
X-Forwarded-Encrypted: i=1; AHgh+RrbqJ8sVl+M+mLIn+/ASafxneRPvMlZaY/cQHeJcIgdkG9bomof8qLIynqiQSM2RZmP6iM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYWOLozBfs/zhFDzFme7us2hP/QPMgBqW1BMdOQjW7ugm17tOU
	FRoaYdN4VvU2NVU9t4HNgPMCEfCWxkxT/agpdEbmV6wgJs8TSlPGTNMNq3BDl5JP0AjqYzo/Xcp
	YhKalsu338sF5mRRv7WI5SnS6TeQKuSY=
X-Gm-Gg: AR+sD12vb9vNwJ8C+KHTBT8lke+udaqb4dt7G8Qn1G5+lEsON7EeZTmat8uFrXc1uZk
	Z1IKIQ5bCBFrgmVJ+AXtYEeAnb6dqpmF8ODXC4/pYZBS4W2oPYMZoiFLrZcJcHy7P58yPbXCsop
	jnjim4PBBK0TbJnBxH1ubhWjdAmcT0fflEzdR47ceIm5Hdo5Tl7B2ZI4MEwGdVYFRriPKGGrp3k
	Rk/SXNu+ptGryL/95a5mPbpknR7wH+tUr+As30E31GIHHOpHYEPBPr+R//e5S4YFMnkhYJBh0lf
	gpug2Zggh/GtOPlddhj3V4oBMYSeQ387O8j71recCzuNLNDbdn6D3mtwB8QUS7ddp1IPtfdYJ34
	5KWBwLD2ot5M8fsdmWwYGebs+UmcyRkiYUpBvV1VohY46VtAyDQBOi+VooeY1VsFLmZbC
X-Received: by 2002:a05:6808:1911:b0:4a4:989:bb1f with SMTP id
 5614622812f47-4b2cdcc4f08mr10372370b6e.9.1787276656520; Thu, 20 Aug 2026
 18:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <321af575e0a9e0c22c70c1809f6fbf0265b05d4c.1787092446.git.gitgitgadget@gmail.com>
 <xmqqfr0augls.fsf@gitster.g>
In-Reply-To: <xmqqfr0augls.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 20 Aug 2026 18:44:05 -0700
X-Gm-Features: AcwNN1UKEv2QCKCn7mXV52YJeMPj0JNsLqtteUw1FPVXb94jmo2vWyEv0nKMjp8
Message-ID: <CABPp-BGFpLi+FEoJOXvT=wBtexXiDmJ9vXQfc5JnBDrUk+zbDA@mail.gmail.com>
Subject: Re: [PATCH 1/2] replay: fail gracefully when a merge input is unreadable
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 11:09=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > When objects involved in the merge cannot be read, the merge machinery
> > will return early with result.clean =3D -1, and result.tree left as NUL=
L.
> > pick_regular_commit() tested only "if (!result->clean)", ignoring the
> > case where "clean < 0".  That causes the code to try to use
> > result->tree, resulting in a SIGSEGV.
> >
> > Handle clean < 0 explicitly; the merge machinery will already have prin=
ted
> > messages such as "Could not read <object>" and "collecting merge info
> > failed for trees...", so we don't need to add much detail beyond the
> > fact that the merge failed.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  replay.c                 |  7 +++++++
> >  t/t3650-replay-basics.sh | 35 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 42 insertions(+)
> >
> > diff --git a/replay.c b/replay.c
> > index 463c900d6c..33e21b2032 100644
> > --- a/replay.c
> > +++ b/replay.c
> > @@ -327,6 +327,13 @@ static struct commit *pick_regular_commit(struct r=
epository *repo,
> >       merge_opt->ancestor =3D NULL;
> >       merge_opt->branch2 =3D NULL;
> >
> > +     if (result->clean < 0) {
> > +             error(_("merge of %s onto %s failed"),
> > +                   oid_to_hex(&pickme->object.oid),
> > +                   oid_to_hex(&replayed_base->object.oid));
> > +             return NULL;
> > +     }
> > +
> >       if (!result->clean)
> >               return NULL;
>
> Hmph, so anything but "0 < result->clean" is a failure, but we by
> mistake took any non-zero value as OK?  That is an obvious mistake.
> Well spotted and fixed.

Thanks, but the bug was also caused by me -- e787e664da64 (replay:
introduce pick_regular_commit(), 2023-11-24) -- so not sure I should
get much credit for finding it three years later.

> > +             # Ensure replay gracefully handles the missing object
> > +             test_must_fail git replay --onto onto base..side 2>err &&
> > +             test_grep ! "[Ss]egmentation" err &&
> > +             test_grep "Could not read\|collecting merge info failed" =
err
>
> "test_must_fail" means "the tested command must fail voluntarily and
> in a controlled way", so a segfaulting git-replay invocation would
> not pass test_must_fail.  Hence, there is no need to separately
> test "test_grep ! '[sS]egmentation'".

Oops, you're right.

You said on 2/2 that I don't need to rebase because you're putting
together an evil merge.  Do you want me to resubmit with this line
removed (without changing the series' base), or would you rather I
avoid that to prevent merging work for you?
