Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759F342AD6D
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174212; cv=pass; b=Kf4AaF2lwmOOF48n3I9DV2WQ1AGIzdYDsqFOljNts8haVkryq2m4KWGlRHm99Ix2HXSnCW5iRBzs+A7XCvt8IDz/0fF1h7/CKlQ1408gz0+3rs+XKxbJKlVtDHKGfDo1iBVxYy7igyfmarpUrkVNmwyVZs8GgGtjlDIelGuqiWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174212; c=relaxed/simple;
	bh=SDLZOa5d3lfUT8btfa+9Yu5rm4KgXthDuu2qCrONdiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nn7aobfqkCwP6fX5r1n0a4T/djQ7b6K8qUxn1sZoAlO1CYUFDuCVOc3ncQ8ml7HZDoEmfY7/uDYx4pR9QnLYwBPc9+3gIcOU4nexbP61SpJ3d9svkVlE1Pb7MxQGBDlpkeB4fSOTR2gsaXHu0E7CzGSEEj4Qdg/MFxXuFbUG8zY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hm14MPum; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hm14MPum"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d6d28aa26cso465845ad.2
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 11:10:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792174209; cv=none;
        d=google.com; s=arc-20260327;
        b=SypIPJnbtolm50oxpAp5pbgCVeMsdQhTmqClQJ4rylPr3DfvD81SUaE1HZmNEGD+A7
         jmoqjQlVZPPion1fv1G6p/SJXKZIG57j2QGiiPGBjIwikXX3XkrHoRM1eimq8p9steFA
         0kn92jiyboNfTa6odhgqJQZrnZUkRl8XXGM82OoSFzCN6fhm1pdTuTKdknw2NDyZEi2D
         p0t5GpnxtFBKVlHbp9gmLAg8zgFDLA3ROOsAg2vQnECb2g3doHF0hEoXCsv9Iw3/pNVK
         wGxR1ej8qqOqPCcKH9dVjGr1wqORpkwrWz4rN9EuwOyeeP7Wj5Cd5yQxD8/2Khmzzsb/
         5kaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j/MHnAIlbGyBcdvSK1uZYL3hNTogShSwdahUPUE7E6o=;
        fh=fyQfJNcdp5qIYXJheLsrAY0pPZ7Vze8cj7TKG6LRV68=;
        b=s9fp4HFpACn3AYSXtXRqibSsbYDrEKdLqYCKIu2jO8ISC03I3IXAkDAJGTdLKm8vpI
         AxUjm8aCXsZ6ZH6MY45WwfO9dwFvCG0aXktzL8cUmvgICtAF+FTcigs5r3DKcZ+DDkAx
         DyVVviat8TePcOnc3/EPwmC2r4/ccsCPu+PIkqvprkgg7ZcBPm739II3LcCAIhzjZD+5
         sCRxxzdzCY0yuMBwJRp3ieh+lJu3bz4qeSTd9YG8MAR252tdkTFnPibtWC+8qcshSRaQ
         sPATunn5rQSivvJvEZinRfWMh8ocLCIesR3oCvlpq7OMN0Ht+Ti5mU4BLlSPQuZhV2FV
         P9KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792174209; x=1792779009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j/MHnAIlbGyBcdvSK1uZYL3hNTogShSwdahUPUE7E6o=;
        b=Hm14MPumHcSGD9CqNcZkoqT1fRj0IA8XLt3B7aUaPAQPEoNp/s+QJ1Xra7Q/gurPZ0
         6YIFBQhs7DuzNNNK1QKFjVpsT49ueQvf7ZVPKuu+WkEfYX/84TyQxKizjBEnE70rPMak
         byNOV39jMf5yLJ+HUoS5p/7AjMwNCbGcQKZkGnza/g+y3MuuWu5SZ6Iz4I/Py/Vhsb++
         z9NQAnQsbTrEeVvL224zgLAqaV3hYoF3f60R4hf6DT4Rdudpij5ll5MBBdU7MgeJSnd8
         iC4mReMWFwhzxfMNYIttS+FLoiC9RoWaVuxJrDiWPDDHd0aG9eM269yEB1p0SFn/sscQ
         seug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792174209; x=1792779009;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j/MHnAIlbGyBcdvSK1uZYL3hNTogShSwdahUPUE7E6o=;
        b=tE1B8wMu/NMzPWe6X+jSvRrcNCOq56iDGHi725PGkbvM/5agUxcs0OzpqIFFfZ1UTL
         tPNt248dmoK7oRdSU5VkNDAjbhmpVnnRxnN4LKB2nC7Hh2msbkiT/rIPTvcE7JC7mBqZ
         l8l87XqtKvTkZwQiBusSIQjbBMUzvHcI6G2+kXJX8Mf8JOtdsKpShhEN7uZmNkzwk7jw
         Rn1CRN3X0h3jRe/qsEUCpKUhagxSLtw6iFqZ/iJ9cl5MAkz+AY8XcS/Ewl7mJqhH8skC
         oHocYXtODapnDsG65U3geUC3bU8utLocR+u3Uk4i2r6HpZGUb0xUnbfFEh+2U+vv8Dva
         Vi4g==
X-Forwarded-Encrypted: i=1; AKwUvBzIKZcVVp5RDXYMt1xU6yAwE7mKaMkBr0lLDBaylbLziloJDgr6zHbc9ztHkbahvX5hHM8=@vger.kernel.org
X-Gm-Message-State: AFq9FYINRHeYaglMgThWAZIx5qhYqJdzDr0gv65Gt3jRNH/nTkCLxKh1
	UWLj5Ye7HuisHjmEpbzpFpRSIpPJRJjUP5mF9tT6iE4yKOD1KfbA0Za0FnLbHawojqF3SN5vq/3
	vx2zdxWVtAqKer8lZhfjMEHMrTurwJzP1oQ==
X-Gm-Gg: AYBFou3VFcwGEz/FRmb3iWYkAxYy0L1LcLz+P7yIicaW2gv0QcdxrlEZy1BTsW8W4aJ
	TARYX1QuEQk8gCurKdnW/3IfxqUaOSFrckpGLTfpIay5qDJoXZaTaIqS3q1ou6/Ll5ylNE1pD10
	NhTG6QY5UTHjXhPfj7UWFfxF+rR355vVtR/jxQrziSc0tpW4wk+RMEjGQsSIfK9UXNyDLHJI0qg
	w2/mJnJwJYVeRxVrk29VXaPWXYIBWcp7ZwANy769LVsGo57r/7G2g5E/QJ+IgKLHSyB0GN4LW0+
	tT1JGMY7yggFHZ9H1cy9hIRAxtwUS5Sk8ANAR7pzkEj6StIXVSPLdi94k1I/w9xYbAPA0iRFaAU
	ORIS6r9Z4ayZfYjEhQwIL0NM7yoM1N+VA3/i4ciNF3bNFPjtYqnXZZwPd6UOEoxygVkCTy3XAfr
	LIdxRHZOydeyI2ni7ww+ANcix7sNtu+4qSqpYwCzCW
X-Received: by 2002:a17:903:178e:b0:2e9:5c55:c477 with SMTP id
 d9443c01a7336-2e9a683467emr7048665ad.4.1792174209471; Fri, 16 Oct 2026
 11:10:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4e8d8b75-ddf4-4602-a2a8-26e5214c65f0@arm.com> <CALnO6CCph_xC394v_BetLPyoriYc9dLZY42LsXhjVNdvt2e-cQ@mail.gmail.com>
 <958622c0-e0a5-4e27-9815-cd1fff2ed111@app.fastmail.com> <2006115b-bcf2-486a-ac7a-681caae686b4@arm.com>
 <fc3de093-a051-415c-b40e-f9df5c914704@arm.com> <xmqq4ielirpr.fsf@gitster.g>
In-Reply-To: <xmqq4ielirpr.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 16 Oct 2026 14:09:57 -0400
X-Gm-Features: AclHuK81NVrulPFpmXdH0_zecgTPI_9uEjHpTRRuMprnG5JEaOImDvNoL3J43wM
Message-ID: <CALnO6CA7vxpmhVB3pi3gpVcbtCS_yHtA+a1Ud25P00JDAqboAA@mail.gmail.com>
Subject: Re: [Bug] Porcelain allows creation of '@' branch
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <bence.csokas@arm.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 11:35=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Bence Cs=C3=B3k=C3=A1s <bence.csokas@arm.com> writes:
>
> > On 2026. 09. 03. 14:35, Bence Cs=C3=B3k=C3=A1s wrote:
> >> On 2026. 09. 03. 10:38, Kristoffer Haugsbakk wrote:
> >>> Not a bug (2024) https://lore.kernel.org/git/xmqqy12z7eti.fsf@gitster=
.g/
> >>>
> >>>      I suspect that it is much more productive to deprecate and remov=
e
> >>>      "@" that is a built-in synomym for HEAD (but "refs/remotes/origi=
n/@"
> >>>      does not act as a synonym for "refs/remotes/origin/HEAD"). [...]
> >> I would not want to see @ removed, I have abandoned using HEAD years
> >> ago, too much typing (especially if you want to express more complex
> >> things, e.g. `git range-diff long-branch-name{^..otherbranch,..@}`, to
> >> pick an example out of my bash-history).
> >>
> >> Bence
> >
> > P.S.:
> >
> > $  history | grep 'git .*@' | wc -l
> > 74
> > $  history | grep HEAD | wc -l
> > 0
> >
> > ;)
>
> You have some unlearning of a bad habit to do, then ;-)

Phaw! What's good (short and easy to type) for interactive use may not
be great for scripts, sure, (in which case spelling out long options,
writing HEAD, etc., is advisable).

But shorthands are convenient day-to-day. What's a bad habit about that?

(Besides, the OP's grep also counts uses of
@{upstream}/@{u}/@{push}/reflog syntax/etc.)

--=20
D. Ben Knoble
