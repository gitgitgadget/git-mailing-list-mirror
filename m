Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039D93EBF3D
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771064051; cv=pass; b=DwG2HqQM4Z+p1tPQjkLvvrQAyygE5sX9yjqqG7pCgeoCa3zJUxqbhQs1re3EM31sr8f0+GlB8/nV6+fWjWEuFVJR0aNtmau9QG4GYca16hlaW6RpqAt4ufF7iqV1ooctUI9sdayAoYXfrvyYhr1FZladdfzEk3PaAq7UlTco69I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771064051; c=relaxed/simple;
	bh=FbRBsqi1o2lh9B0mdipPFG3nb5mvJf/h+akLSmF8cd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pgezzr6/IQIQ+NHPHU1Z2MZGQNu9zmPRxY+xWtS6qWyQpNvo5nEoZFwOandXrZvRkEY4Cub5N1uSfbYjlgXR9t0gsW+zYtPl/0or6fRpsv0WaokEhm9/I9jaLVDoBBurCHb7ttFOB7eBMABnsK2TXDXd9U3aE0PybhT3Z9qFoD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2hcxnYh; arc=pass smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2hcxnYh"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-566390e7db3so1265561e0c.1
        for <git@vger.kernel.org>; Sat, 14 Feb 2026 02:14:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771064049; cv=none;
        d=google.com; s=arc-20240605;
        b=ak9kHbdDFrVmV9vpqfJgRbdXJMlPRodZ14GW0Z1zs6Q1s2D5z+efIBJHKOZXLjHD0A
         Qq/4U+LnDzpF4LdPBa/DtHugMZ0OQke8gWWF13KiB73pr/RiHA6YwMjcCf43MLA/jzbp
         jBABqgQzdQunEIwRm2lyhuBKi5fyqy83qGltOSVdmT9thh+ZddzfgRw06AA2kf1MGL88
         7+ap0ASjmuV6DtQbUG3hyi1xwvGpxS/Ju/DMGmBlbUycLMrjAx/ySay1eMpQZ8ERu5nL
         Ltz2X1Kevr0InBILEneeyejtaB7HLM2Aallttqm9Ni8RFEDVmLaPwjEUna/irEpoOTd2
         CEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YpEKytcxZX28su8hfG2iiEL/gGPpZ1LC0XIlOXiTgqM=;
        fh=wMEuQs+GpV4sPE9aqLGoS837e9vPIyS4RJzxckXqt0E=;
        b=T0gpaCwdJDG5pQkOfRBm9Xj54cTHQPYf3vmGnowLF8Jjs7XjCyUXeICPycbHJ6XGjQ
         jxq4kyXOTXqPNP9OwOPrudhvOvmpTPyKnrtlvYNU6uyRQG4BupixLKysqmBQwxC3loxr
         GpsKpO3rw1bjSwVw1SkczJnBKAsCQgP3CivaIB8pYee9wUHBE/QdTjWB85sF8nzYoh5L
         zZqds4WL2vz5qSbmfwLxn5y6YftGldQlDTNs97J3nUIIp/4gJW7bA0TeGF02MYVy2b/5
         fBYlNRk4/ymtXAt2JS/CP2ArhDYHcnYFqLSFlT+yUl+GmOxQEItLsCLiUEQqBfdOsf3Y
         3izg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771064049; x=1771668849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpEKytcxZX28su8hfG2iiEL/gGPpZ1LC0XIlOXiTgqM=;
        b=F2hcxnYh+p+KkzJpH6iC5wZNpqZJ/az8QMxHiZPCOHyxa7G4n2xgqY4Bq4rLQ+rn1P
         KdqVGOzd/FU8zR7Fg31Ko0utA3YI+ZQ7kp2BfUvpNNva2RpduRngkk4V7vmROY26sPRf
         X7cXcul2bHHSluIc+xT3h2RX8M4O4Qd/QBlJjByDZoEGid91mNhYBeuZC+ky3qim/5O4
         KdZYQAE6aZqsDGJUwFcXbY3BnltFibs3ExtBelLxq4SsF0DTf58/JfRyef8nCAe8lheX
         6PCc7DRmM2W0R2lFQdKb3lkLw0Q3iM0Wh5pTuZZCmAggm9VCBZK0csT8RqCRKywr0kYz
         sRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771064049; x=1771668849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YpEKytcxZX28su8hfG2iiEL/gGPpZ1LC0XIlOXiTgqM=;
        b=ErdW8sQgEhbhee49f9BQh+jxlniqxo9q70DOyRNRtZCZs5dRObe2EJsYPS3pqZvtFO
         22Nhjbr6uYu2nSTx0MjVzOAIA2Qo9bnPLExOmQPH2QJgRn4r1wnYLvl79GnL+3XGsfU+
         uvN3lvbXotkO0/UJOWVdvd/8js1rMB6gSG+OQJ1UolCt6u7SI8reDJCB7dBqFyOxZvmh
         iatGCXR7LKLP9wLp3h+OmgcpKyLDEyYdD8vUUHKIoZvigLJKKP5/oaqSHT0W9umQWAgh
         jOwUY1HpHB7MQHteluOc+GLsM5ZDoKt9ZgKb/r7BL2Y2yUkcAX36saVFagpFernQyJ3T
         Vh0w==
X-Gm-Message-State: AOJu0Yw+21xSkYGQjqyxv0MSxKDSyOnPZ8rZazd8G49+sz+yGD2vtcCg
	X+7442ORzPGKMYBGr4uRtd/toVBcg7f97ghq5gAWpsqhhBSyJJBwJ11YGY1t9rCmjGijAFvUfnh
	oea9vVuTRQk05BJItfZCNWkTVJyhDMSY=
X-Gm-Gg: AZuq6aJ41QwwEDUQrvXNU/JQ1TCbuQhJDbZXeQHt7oaAJEoc9cZnHQaFm9b1lXO1kPf
	OMVeCD3jTKpeT5Op578dI8EFw8hF26NnwJBONWqzkD0zaSfjEnwloDeH3nLC/7BstDt/QD0zHQ2
	MXFaaJ1+/8wTjmGnc5AIlX59mOO3uJRe6p9qSkKDKypIdFnB2X1P4N1xMgKLrIjGBcM4LZeC5pq
	O2Ue2AA6bmITs1wBGN/JULQ4JJLoiQEzXcanLviATJFniLKiADgE96BDJxkSfs0et2KnFsZgoME
	b49vSJKP0HRwm1QV8UGmXxM=
X-Received: by 2002:a05:6122:8b0e:b0:55b:305b:4e41 with SMTP id
 71dfb90a1353d-5676aa6c837mr1515374e0c.18.1771064048798; Sat, 14 Feb 2026
 02:14:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771015581.git.abrahamadekunle50@gmail.com>
 <906f25e184d744f9d23681600a0d9e440b7f07df.1771015581.git.abrahamadekunle50@gmail.com>
 <xmqqms1ci5g8.fsf@gitster.g>
In-Reply-To: <xmqqms1ci5g8.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Sat, 14 Feb 2026 11:14:08 +0100
X-Gm-Features: AZwV_Qi2tcnbqRchtRL1IUiZ2XzuB5mLBdeElz3flGuCaAaTPTMI_obiboBmdHs
Message-ID: <CADYq+fa=-V9_gTpPRUvCDwFDShrUuxBqojOM+JSo_AvfvAJR7Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] add-patch: modify patch_update_file() signature
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, 
	Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 14, 2026 at 12:34=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:
>
> > -static int patch_update_file(struct add_p_state *s,
> > -                          struct file_diff *file_diff)
> > +static ssize_t patch_update_file(struct add_p_state *s, size_t idx)
>
> Why ssize_t?  Are we going to handle that many hunks that we do not
> expect to fit in a platform natural "int" type?  If we are not doing
> anything about "idx" being more than half the type, which apparently
> is the case ...
>
> >  {
> >       size_t hunk_index =3D 0;
> >       ssize_t i, undecided_previous, undecided_next, rendered_hunk_inde=
x =3D -1;
> >       struct hunk *hunk;
> >       char ch;
> >       struct child_process cp =3D CHILD_PROCESS_INIT;
> > -     int colored =3D !!s->colored.len, quit =3D 0, use_pager =3D 0;
> > +     int colored =3D !!s->colored.len, use_pager =3D 0;
> >       enum prompt_mode_type prompt_mode_type;
> > +     struct file_diff *file_diff =3D s->file_diff + idx;
> > +     ssize_t patch_update_resp =3D (ssize_t)idx;
>
> ... with the cast that is not checked here, wouldn't it make sense
> to just use the platform natural "int" everywhere?  Your code is not
> "safe" either way.  I do not think we expect to handle 2 billion
> hunks, so even on 32-bit platforms, platform natural "int" should be
> plenty.  Instead of religiously using size_t and ssize_t to count
> things without extra care, I'd rather see us check the error
> condition for real, if that is what we really care about (and that
> can still be done while leaving the codebase cleaner by sticking to
> the platform natural "int").
>
> Enough ranting.  Anyway.
>
> If we really are bothered that we cannot handle 3 billion hunks, we
> could avoid losing half the number range by returning
> s->file_diff.file_diff_nr (which is one more than there are elements
> in s->file_diff[] array) or ((size_t)-1).  That would allow us to
> return size_t from here.  I care about this a bit more than "why use
> size_t when int is perfectly fine", because some platforms that are
> not quite POSIX can have ssize_t that is not as wide as size_t.

Hello Junio.
Thank you for the review.

I wanted to be able to return a negative value while also making sure to
return a type of the same size as "i" since that is what we use to
update the caller
for the next or previous "i".
But I know better now to think about platforms that are not quite POSIX.
I will return the s->file_diff_nr and check for that instead.

Thanks
Abraham
