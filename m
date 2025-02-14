Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18521DA2E5
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 06:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513104; cv=none; b=IS+yeIllCfs739kOSoY27dGrBG/LXgE9yYyMx2LMgP6M2is4VwkMoI7XqFXfXewG0MIPdU5EHAxcthZw6s64SpojpQLibtGpHI2nPF1FrmoXjVZX9ijM79Vke7nAQryzB1FUZg9ahTwJRaShELH+PdqtPaMf5iegNYV4ih3ld78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513104; c=relaxed/simple;
	bh=fcknH4KgMrvngjWfymraIpDQ5QVMY3h/aT0fPMKFgg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhryFM/JmpiTfV9NESsLVwdy6KqZ8SgkSyvu+ZT0XHlahRp2dIRDd2epicwY2YGYzTb+MZ1urZmW+T7TJ2poVKL+/+Dp1shBSz5qsOunM9isKbzu91ukOA88KV5zFrOQaFtBf/8B9rJx+ZZuO5R6QvxC7W1vwmcxB/E1XRCFns4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnrzcERG; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnrzcERG"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8550803e1afso136117839f.1
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 22:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739513102; x=1740117902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krD6KNa3d25G+8fDHhOra3E08Xas51DpXFFEjYyga+I=;
        b=FnrzcERGAy+oZQpUdZoh2MSJhNQYN2AZRuTCvzs/ieMvj5GFAO7ub1y0KVtaM/dZgN
         FJ7208x3fBOcpRtXR9GaL4FdZok19GBEsp25yfeC1V0VtjvBCDMdK8j3rhXEoATIm/ky
         6HyI1AY2uvbdNX4TrlryykIj7dhPaFe4SLifLQxkGFMriVAAH2FSidRGp7T6ORO8ctmS
         DTT2ICCqjhV/0XSsURJUcHNK6ys3uOKZc8ksoFLLdAGCYPnnyfB6O57HIXt6mjhsGaRq
         fTvs0t5wvnwXfKL3KwsMH/zz/iYxQJ08swL5lt3p4R0Vm2YQnK32Oyoa71wiA8zR0lSv
         SXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739513102; x=1740117902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krD6KNa3d25G+8fDHhOra3E08Xas51DpXFFEjYyga+I=;
        b=vOj9HonZ0GHimlkqVer84hryYWZjMTEAFnJ/FOKfoB7sA9J1APo/nGMTq8anf1YUS2
         pRCJfyLw8ByfLxu/mWXhbFggLWdc8ZK3wGlqNO1uSmcaMpTxU6ajZs2RiYC5rnoULQ6F
         UGG8yBY8v7I6ddzKBykwgdd/mHMwSIrPfr8QTPqTlVc3dOIhsKT7ujDstFOSCJfm67VP
         /ST9y4SpC+cwk6sDpQ6llGMRbrpHBHnUD2irzelUJSZyNWMaey0pRg8aB2vez1zQ93ex
         bof9fJMHcEpCEizhWAoFnH7Mq1ulb1iKCdWRUhM3xpT8ubP0aftp8g5Y7lu0w/RRNVPX
         CaMQ==
X-Gm-Message-State: AOJu0Yw4bPgkiBTTvHZZMUx2GZlOlU2mH15ys4NGyxTN1N17+CRV6Hhd
	uVIb9EZuUCEum6WIerfhT10HI++5deidMnsxwXl8toBpK5zLi+IrI41E9MNBJFnR0MRYOdjbN77
	nqYoDug/bR4YtCx3vePfw/YCoT+MZVePU
X-Gm-Gg: ASbGnctyF8JIwdvhQel0wcuBI0I0lfaWYq81AgpvCZ9Boj18gunOpF24NgeKvNGaPXH
	y+FNv/YSRFSyc4K1XFD5m2KdVHpdFHGpbWw8/7G368sCBFUElTZZD7fLQ9ZJ2yhrEdqJ7laQR8S
	9s77WxjKKM603/AAcX1THuWHJ90ePtsA==
X-Google-Smtp-Source: AGHT+IFuPxCe50N3kBJjJZBKpUdKg2wKs4lL8qvImm40yHS7GduOhNhGfueG4uELjnSGJFkB8OwIZy9zTDZHndGCf7g=
X-Received: by 2002:a05:6602:6425:b0:855:4c22:27a8 with SMTP id
 ca18e2360f4ac-85563b94002mr480210039f.14.1739513101952; Thu, 13 Feb 2025
 22:05:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211194334.20710-1-meetsoni3017@gmail.com>
 <20250213090040.16133-1-meetsoni3017@gmail.com> <20250213090040.16133-3-meetsoni3017@gmail.com>
 <CABPp-BGqihkPq3o4jnqp2aGdqw12F8a8nOModuAB-5N7BQ1t0w@mail.gmail.com> <CAPhwyn0hz16mZ-UoVAczC4qDLx2i0LwfFhhDjdTahe0=4TO57g@mail.gmail.com>
In-Reply-To: <CAPhwyn0hz16mZ-UoVAczC4qDLx2i0LwfFhhDjdTahe0=4TO57g@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 13 Feb 2025 22:04:50 -0800
X-Gm-Features: AWEUYZl2FhZPRzsxEDN_uVKNKDVjQ9ZqtSXUhkJbWP8hbS8V6aw0Bi70uUuQV1Y
Message-ID: <CABPp-BGq-x9Z98scXRtEnqz7BCmPn9ONHd6wDnnm9jL4YeDHxQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] merge-recursive: optimize time complexity for get_unmerged
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 8:28=E2=80=AFPM Meet Soni <meetsoni3017@gmail.com> =
wrote:
>
> On Thu, 13 Feb 2025 at 22:41, Elijah Newren <newren@gmail.com> wrote:
> >
> > On Thu, Feb 13, 2025 at 1:01=E2=80=AFAM Meet Soni <meetsoni3017@gmail.c=
om> wrote:
...
> > > diff --git a/merge-recursive.c b/merge-recursive.c
> > > index 884ccf99a5..6165993429 100644
> > > --- a/merge-recursive.c
> > > +++ b/merge-recursive.c
> > > @@ -547,15 +547,15 @@ static struct string_list *get_unmerged(struct =
index_state *istate)
> > >                 if (!ce_stage(ce))
> > >                         continue;
> > >
> > > -               item =3D string_list_lookup(unmerged, ce->name);
> > > -               if (!item) {
> > > -                       item =3D string_list_insert(unmerged, ce->nam=
e);
> > > -                       item->util =3D xcalloc(1, sizeof(struct stage=
_data));
> > > -               }
> > > +               item =3D string_list_append(unmerged, ce->name);
> > > +               item->util =3D xcalloc(1, sizeof(struct stage_data));
> > > +
> > >                 e =3D item->util;
> > >                 e->stages[ce_stage(ce)].mode =3D ce->ce_mode;
> > >                 oidcpy(&e->stages[ce_stage(ce)].oid, &ce->oid);
> >
> > Did you run any tests?  I'm not sure you maintained correctness here.
>
> I didn't run any tests -- I wanted to, but I wasn=E2=80=99t sure how to d=
o it
> for this change. Since you suggested dropping this patch from the
> series, I=E2=80=99ll do that. But for similar changes in the future, how =
should I go
> about testing them?

As per Documentation/CodingGuidelines: "After any code change, make
sure that the entire test suite passes."  You can do that by running:
    cd t && make
(You probably want to also run that before making any changes, just to
verify that they all pass for you.  Then, if any test fails after you
make changes, you know it's because of your changes rather than
because you missed something in building or setting up the tests.)


And although it doesn't matter since we're dropping this patch, the
issue I noticed was that if there were, say, three unmerged entries
with the same path, the original code would create one entry in the
string list and modify it 3 times (each with a different ce_stage(ce).
Your modification would create three different entries (each with only
information from one stage) and drop two of them, meaning we no longer
have a single string_list_item that contains information from all 3
unmerged entries for the same path.  I'm pretty sure running the
existing tests would catch that kind of bug, which is what raised the
question.
