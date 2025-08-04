Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2701F4CBE
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 22:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754345344; cv=none; b=eD5cBiZH5+ZawkFreRUVHin1g6n9BnE23z+1CKZ/usbxdRl62LgnrXh9JSuClnw8kqvd2Dkz5fYM5AO0U0v9D6+vpI8z8IypspPMqrA37LdKLFEdDiwTH00QoU1E+gACeAF8ikcmkHN9RcnqRaD/CMFlG1cNsnZPZ1bYMkbJCKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754345344; c=relaxed/simple;
	bh=ipyt5WQGlB8GDvMbvyqTeiO6QjxoXHj2FQXckeRfDy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BR5qyAAmE8Xpa5EKG65pgfHaXyMksudWFiNfVPKCuLVRsXikYFvELIAU5aCAUkpgEIEHNlB1KfngLslt6HKvcCOiiGQ2rFpex5SlcFyYxeNNEBHc17AfAKXDnMPXQ2rohUPOBvdDphdpBP2yQeIE4ufl4yIZPHEG1r2Ork2t4ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBBK8vaW; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBBK8vaW"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-86a052d7897so223902539f.0
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 15:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754345342; x=1754950142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnF8MkOTDYnWwvcXuuSqlDL+mDAzHWHjlfwUnDC0gLw=;
        b=PBBK8vaWhNbBDmxp8xb2o9oG1hYe7itaoXVNsTfRitftnQHGDp84F8/IIgqLlhv6pP
         aOKiuF2UV5mun4nD0Nk8wZWXLOpx0VxmXAbwXzqt4uxUaT6iJDJ8fRFPScUFSTtWxZ5T
         SLGByapvsAoewwwAp9Byq1imhLT0QZDPMlnAVCUHTL42nXaHgpMtRUde+jX6NHVehyX5
         9oWs9kKzqgaEQx2kPukhItI0Ji7BsV20SoCVbd7ByQVkSKZ8nIApXN7Wx9y+EpM3a8Ng
         y76ycXk9NgIHMW99T+uRdVX9WiY21+fzYFORUXYE4d1WxYZhETaZbpzr/xyw9dbooT9N
         MNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754345342; x=1754950142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnF8MkOTDYnWwvcXuuSqlDL+mDAzHWHjlfwUnDC0gLw=;
        b=oenI9HoIh1SdxuEbz/ilVNjMzhNcBEUreidCuEe+4LALpEFIZ9b7dRCBE/Jj9hi3Y6
         m7prDPkFRcoo2ns5K8QhpF7IULYk+rlRZcB+bgne/K1S+mKsd4XvS1W38ZFvxiZjbIrh
         HiBB61ke3KhsUXDtbQkHYZyYkQdCMfhtziaJBVzlkdhtNDrucv/FrKVqtTJpVrChsd1Y
         ZKxnjfmNvTQALqdsyeGwPWlF/Wy8mufgUJ7X6LArc4cbLAZ35XK+iDEDsV4LAWEgC9NL
         5bZHNgd+z8B076f1UgtVNKiRIR+IQFMrglJxQA1gIj326krZgfS9cCByNDUDrnbK8fnp
         hLeg==
X-Forwarded-Encrypted: i=1; AJvYcCWKYYurtimJFR4uh9sbifas/3UHcXnT7JqePIFyv4EXSB6MsL8+Fnrg2T22zlcP4G3+ekE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwGyD0mrwhM1nJS7abJiKS+PpLJW94zZvW8rCKUgCv5yxE17G9
	BkgOmy1n1jlA2EK5hkvuTFkpDq9csXBgCksWHHJv4ryI8AeVaYab/a+rT1h4H+Kk+2cmRMqp0jo
	fEeGWcwE1ta3oB1UX+tgKPrp+oBfBWAv68A==
X-Gm-Gg: ASbGncs2tQ1/9dNtG+ICflfOGs9zdCKSp7GTNoMLgT93feHwNOBypAEa1OyO/dw/Qkn
	TignKGtzVdgddRxGIY15Rha0Q6aMfpsnp9kcolbl+IKOrUHS7aa4RDkLyZX2nWNLfuIrOacm2gp
	3aYZL78rIRJrhR67Kt0Xc43Imvkibvc3qWRosvzX4IuEBfO0z0fvqq2Nm/eCd7XZ8kiFgaYJs80
	7GI7pPvdwSzY/+q/hDK/Vo5TuH6GI258iOrlHW5
X-Google-Smtp-Source: AGHT+IHosviypm77CmAQP3VD0IVXNdJoAl/RrYg3r7Iqre6waLPlUoyVurgq90mU81/KdDzz3doDjtiAreNrDh6N5iA=
X-Received: by 2002:a05:6602:4809:b0:881:696:bf41 with SMTP id
 ca18e2360f4ac-881683ce76fmr1816041039f.10.1754345341694; Mon, 04 Aug 2025
 15:09:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
 <2c7d4e022c59609bf263a7045fceb1854441bb29.1753197791.git.gitgitgadget@gmail.com>
 <aIx7SXfRabJWpa0D@pks.im>
In-Reply-To: <aIx7SXfRabJWpa0D@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 4 Aug 2025 15:08:50 -0700
X-Gm-Features: Ac12FXzwhrARf5j5Cfv1RPAJ7L9yIL5DBX60UbGUdEx3wNvCSvnqc_ClKxq3Wkw
Message-ID: <CABPp-BF_UGf2VXvkAj=nkEPwo=FVQTgVvrDFURkBnFv4Wkiknw@mail.gmail.com>
Subject: Re: [PATCH 5/6] merge-ort: fix incorrect file handling
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 1:31=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Tue, Jul 22, 2025 at 03:23:10PM +0000, Elijah Newren via GitGitGadget =
wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > We have multiple bugs here -- accidental silent file deletion,
> > accidental silent file retention for files that should be deleted,
> > and incorrect number of entries left in the index.
> >
> > The series merged at commit d3b88be1b450 (Merge branch
> > 'en/merge-dir-rename-corner-case-fix', 2021-07-16) introduced testcase
> > 12i-12k in t6423 which checked for rename-to-self cases, and fixed bugs
> > that merge-ort and merge-recursive had with these testcases.  At the
> > time, I noted that merge-ort had one bug for these cases, while
> > merge-recursive had two.  It turns out that merge-ort did in fact have
> > another bug, but the "relevant renames" optimizations were masking it.
> > If we modify testcase 12i from t6423 to modify the file in the commit
> > that renames it (but only modify it enough that it can still be detecte=
d
> > as a rename), then we can trigger silent deletion of the file.
> >
> > Tweak testcase 12i slightly to make the file in question have more than
> > one line in it, but which doesn't change how it operates.
>
> Hm, the second part of this sentence doesn't quite parse for me. Do you
> mean to say that 12i is basically left intact except that you change the
> contents of one line?

Yeah, sometimes my repeated editing of text leaves things not so
clear.  You are correct that I meant leaving the testcase intact other
than changing the initial contents of one file (though I changed the
contents so it had multiple lines, not just giving it a different
single line).  I'll reword it.

> > Make this
> > change to otherwise minimize the changes between this testcase and a ne=
w
> > one that we want to add.  Then duplicate the testcase as 12i2, changing
> > it so that it adds a single line to the file in question when it is
> > renamed, as a testcase for this bug.
>
> Okay.
>
> > Further, commit 98a1a00d5301 (t6423: add a testcase causing a failed
> > assertion in process_renames, 2025-03-06), fixed an issue with
> > rename-to-self but added a new testcase, 12n, that only checked for
> > whether the merge ran to completion.  A few commits ago, we modified
> > this test to check for the number of entries in the index -- but noted
> > that the number was wrong.  And we also noted a
> > silently-keep-instead-of-delete bug at the same time in the new testcas=
e
> > 12n2.
> >
> > Fix to merge-ort to prevent multiple bugs with rename-to-self cases:
> >   * silent deletion of file expected to be kept (t6423 testcase 12i2)
> >   * silent retention of file expected to be removed (t6423 testcase 12n=
2)
> >   * wrong number of extries left in the index (t6423 testcase 12n)
>
> I think it would have been nice to also go a bit more in depth for what
> the bug actually was and how it's fixed. You do add a comment, but that
> only adds a single sentence of context.

Would something like this help:

...all of these issues come up because in a rename-to-self case, when
we have a rename A->B, both A and B name the same file.  The code in
process_renames() assumes A & B are different, and tries to move the
higher order stages and file contents so that they are associated just
with the new path, but the assumptions of A & B being different can
cause A to be deleted when it's not supposed to be or mark B as
resolved and kept in place when it's supposed to be deleted.  Since A
& B are already the same path in the rename-to-self case, we can
simply skip the steps in process_renames() for such files.

> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  merge-ort.c                         | 11 +++++
> >  t/t6423-merge-rename-directories.sh | 69 +++++++++++++++++++++++++++--
> >  2 files changed, 77 insertions(+), 3 deletions(-)
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index 9b9d82ed10f7..feb06720c7e1 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -2873,6 +2873,17 @@ static int process_renames(struct merge_options =
*opt,
> >                       newinfo =3D new_ent->value;
> >               }
> >
> > +             /*
> > +              * Directory renames can result in rename-to-self, which =
we
> > +              * want to skip so we don't mark oldpath for deletion.
> > +              *
> > +              * Note that we can avoid strcmp here because of prior
> > +              * diligence in apply_directory_rename_modifications() to
> > +              * ensure we reused existing paths from opt->priv->paths.
> > +              */
> > +             if (oldpath =3D=3D newpath)
> > +                     continue;
>
> Makes me wonder whether the additional brittleness is worth the saved
> `strcmp()` comparison. But on the other hand we do have tests now that
> would break if the memory allocation patterns ever changed, so that's
> reassuring.

There's no brittleness here; one of the many optimizations in
merge-ort.c was to intern *all* pathnames in struct
merge_options_internal's "paths" member; any code that needs to
generate/compute a filename that may be part of the merge must check
if that path already exists in opt->priv->paths, and if so use that
pointer instead so that all filename comparisons can be done with
cheap pointer comparisons.  See the big comment near the top of
merge_options_internal.  Nearly all such
string-equality-via-pointer-equality checks were introduced about the
same time, and in other functions, which makes this one kind of an
outlier.  I figured whoever reviewed this patch or ran across this in
the code might get surprised by the pointer comparison, so I tried to
add a comment to address any questions.  Looks like I wasn't thorough
enough (and the first paragraph of the comment pre-dated my finding
other bugs this patch fixed, which makes it slightly confusing), so
I'll try to see if I can improve it for v2.
