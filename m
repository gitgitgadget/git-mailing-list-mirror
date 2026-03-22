Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CECD332615
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774189633; cv=pass; b=bta0/H0El/3ahTxPwp68b6BJtu/7g7QkhUlWc4kCfppOWzArs1PYCcx67fXdHcfBOxHdjpjJeO7D1m2EHpIgXyvYS48G5i+nwpQEZURoC+MRGgJ9qOsIFWOcGbamCmTC3jMBlvZO52C/H5nQQMBlsNoeyNVrEG+uk34O0SKTMfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774189633; c=relaxed/simple;
	bh=g15i+6dDGVUEUddcJ2Ceu/5j14z6EGIs6Vr0Z5mFD9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWwJhbcQLeZtHjUQEwbozfJiWjLdes+nZDVE52tyYnvMtyCgGLpz2ED3VLK1mMd+g/zzlO1Qpo7nM9oWyipI2naX6Nv2Zk77YZdVEr/3G4qnzPBYpvWnOuHZFBwC47no5+Kh0Em5aWcA6Wtsqm0sD3altvgzpoJeSELG+l8Kdxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idcIxbq7; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idcIxbq7"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50b2b289925so29533011cf.2
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 07:27:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774189631; cv=none;
        d=google.com; s=arc-20240605;
        b=D22AcUmTmNeL7BjNhtyQuorqO2QRAn1Xkn6JLtGbFxCEdIhk7kxiZuaRzNQXnt+eQc
         IVIm7lc9M97Ke9xvwpOil+f6JCd2RiE2tvPT5WchdSWCZMUFGcOZztgNN4LFGIV6qg6q
         vYxjvCEqyrILEkl3VPIAT2HsDUOkg2r4A4uTDqUhGPUErCzCjmuXqQUV4WQXgkCLTOXC
         8P3g/IHOMQmFZe1fozNI9TYcYUiFP54Ty1CDVcUgG9UUMuLDWr6LNj4dz8KvdCjyoBqe
         hlYXqeWtrsD43/cxqKrISSJckjH0WJlATU2SmVDVBieLwAYZjrsmIk5Z9agXyLFs7ojZ
         A/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g15i+6dDGVUEUddcJ2Ceu/5j14z6EGIs6Vr0Z5mFD9w=;
        fh=9y8NJmi2+ppLJJdRZAoHepeqeLo7nORGTTrngf6iLP0=;
        b=Q0F4qOUMqonQB7R9+5JKtREZMCrR0j3x3vT3fsV3qpLysedSrql0XuDFSEu3kHodZN
         +WPxBG60iGvJz6mXEIyW+CJMIaCtRqkUbbT6+Ed4bad6GAYarD6b19uy0lbvEMacb/02
         A4bcDkqE+9rKbDhlHtWBVM0S/cYGivQTrn2Ohm5nSzdQKTAC+zmLrZP1v46NlGZm3/tA
         5L+mtcS4oFY5xNLj1EBV6NoDkq6m6de/7/S+fanjDQDaeuHLbOuqr3zNTC+VgSFstkAO
         vMbHZuu6CeygNoRmIDaLRY5qMhtiQVHAiQay2esJVniho64wlMeKt43PzEFIsr4Cbh0s
         zJRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774189631; x=1774794431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g15i+6dDGVUEUddcJ2Ceu/5j14z6EGIs6Vr0Z5mFD9w=;
        b=idcIxbq7arJza7ALRy6LVR5zkCposEmON7hTHREB5pDB6ekddJiSR0MCBbXcbcc4Yk
         EQdzNUUm85Qa3/WI64j2J5ur07o2ojl4FqC/gnV6AsJkCsJdEZ5NyXBp/oUmXxcn2RsC
         dhUz212JdhhInsBcErWvzU/QtNmBQbhoJ03WdJasYqZSBXFNCid33PUxDz9MTiA1+Smk
         EfGKxoKz3Wo/vT5ZNYrl9l5pSNp8tU7vmhxPaeIOA8Y/FOk/hALzwSf5SuvDRGhuwfkk
         rnip/rKwTceeNzg/JqVCNJ/UGDewIGA1tAmXuXITksqJ49FcPINHU9JQMBCv9hkpgnFT
         +s7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774189631; x=1774794431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g15i+6dDGVUEUddcJ2Ceu/5j14z6EGIs6Vr0Z5mFD9w=;
        b=WtMxdwWpGeERw7Q60RbmR7MC8cCeItjLJMdWErA+goS9fhgU7d/vBVZL32j4xXq4ec
         xSKQBY4x++GpcoycZyp7rOIsz3F31lgbW5LhQJYA3Sc4vF1FvpjA9rn8IWw/kjMXyJXA
         GrODBv4K90JTsuQtTuOoFoXB8ecTc/KwlO3BtkBIKpiH/B0okQG4aiTT7yYEda8JF8Fm
         qGqTqxPYOfUjKPsC/E9TgX9U9nrGELNmsjBoVk+XdrMuSgQT/mpPIcvFbIkfUoxf23Nf
         UHzFirjF7EyD0NxD+nEuL8IrZE47iAHbxHkWftPv4XwP/9BrFcHLh1ccPRDr/gei0i8g
         AyJg==
X-Gm-Message-State: AOJu0Yzo0olmp5l9sJcYelbkk4EoOK3Bubt/NQpLZaB1hP/TbQ+bq6CI
	o+QyR36P96JAsKL3eLPgJlGw9+MAeZgFZOhMdc5cbsZhSy0Zb9zpiuSBYmLe5nwOVVF0rqx/D10
	NyAN3kUcAargfOFzrIbzLc8Lm9CoLhi8=
X-Gm-Gg: ATEYQzztCkFOUJFNjyb15t/miW70xjKoOLpltx/jI7IuwkGA9X+EHS/pEuehUvROewc
	grgjOq5idP474/rJZ1yzjabl1fMVGYhthHWL4T7tGQIITXVLTOZmL8+bWqvEiwNxmnfhYjxSr8t
	Wc8H62REeuwy7hx9yuNGBoNV8ugtOF30rZEMPzoBNXkrvWDLfGZ9lEblkKkJ+18M7bts0qYa3/n
	RrtUd5IW063e8lKMMenxWo/WUMXbJngUmxY+0ikyk/5Uu7z8nDUc7v3GwBbznva1bck+TJDIty2
	xA9lAC1e4mJ023tKP4MHXhHBZRdqZX8UV0DrusFnLV/KgfevcGctRIOAYKTD36CuoWTvNxkrTin
	RkBNlEuiqKxHhpDotsXMOpspUyxqSX/pP/Zh8
X-Received: by 2002:ac8:5f92:0:b0:509:18f4:6dba with SMTP id
 d75a77b69052e-50b375c0a25mr150036981cf.62.1774189631260; Sun, 22 Mar 2026
 07:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2248.git.git.1774187447563.gitgitgadget@gmail.com>
In-Reply-To: <pull.2248.git.git.1774187447563.gitgitgadget@gmail.com>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Sun, 22 Mar 2026 19:57:00 +0530
X-Gm-Features: AaiRm53papd7P2t1yoNFD5lFFxYEit-Z5i9WOb8XBkZV5g6MSay1hJ2A5fwqCzg
Message-ID: <CA+rGoLdZWz2vfkvv3jm5_yX73gitWPGfySqbkw4e8Upy_2Hv9g@mail.gmail.com>
Subject: Re: [PATCH] t/pack-refs-tests: drop '-f' from test_path_is_missing
To: Jayesh Daga via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jayesh Daga <jayeshdaga99@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2026 at 7:20=E2=80=AFPM Jayesh Daga via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: jayesh0104 <jayeshdaga99@gmail.com>
>
> test_path_is_missing expects exactly one argument: the path to
> check for absence. Passing '-f' is incorrect and results in
> "bug in the test script: 1 param" during test execution.
>
> The '-f' flag appears to have been carried over from the
> equivalent 'test -f' usage, but test_path_is_missing does not
> accept such flags.
>
> Remove the extraneous '-f' to use the helper correctly and
> restore proper test behavior.
>
> Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>


While the code itself is now fine in my eyes, you aren't actually
removing a -f flag here as described in the commit message.
In the diff, you are entirely replacing the raw command with the
test_path_is_missing helper.

I did a similar microproject earlier this year,
and you can look at my commit message here for a reference [1]

Also, if this is for your GSoC microproject,
you should probably add a tag in your patch subject line (something
like [GSoC] ).

One other thing I should mention: you should make sure to CC the mentors
for the specific project you are applying to so they see your work!
or if you think the change is directly based on someone's work you can
CC them as well.

I am happy to review the code and help out,
but just letting you know I am a fellow GSoC applicant and not an
official mentor.

Regards,
- Jayatheerth

1 - https://lore.kernel.org/git/CALE2CrS0Q2NS1DbFv4pyRQsuypu=3DKH6Kurs=3Dm4=
yWrFbR9QosoA@mail.gmail.com/T/#mbbd865b0c73a93096df476621d485f15674f475b
