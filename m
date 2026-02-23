Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6EE36073E
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850978; cv=pass; b=NvjftzsfHzeV1jRJRCgYhOPQQ/TicWyCS8CvcOdCIk+N2z8U40X6+DS4HUsttDM7Z8Z9oX2BgSBIpgUOrfQonZi1kRbZqiJEZl00gcNJWmPPlHvDfPWfjLIYlITrfJ6zcMr5jp2+bcLijAd/nqdnaoSBiH6PKg+esWJATKhRpg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850978; c=relaxed/simple;
	bh=OeSKHcEm+oLyfyy9NWH0oUBE0zGslshddg5H73j218Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OidWB6tmeyldGJfEIUqd7W8VjAFrsjDwcrkOfN20Kvvvtm4sNnw7K0Nu5tKOtA8yr3EpJGDqryNhptRs0QnfjVpz5bihymHVd/nPaFXNUaQ5D8NzrP5aSW3yhN3p6bwm5+lD4imNun3niysGIMT+/PojUMtMBG2elFOuXG9+TmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopify.com; spf=pass smtp.mailfrom=shopify.com; dkim=pass (1024-bit key) header.d=shopify.com header.i=@shopify.com header.b=ilpXhkSf; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=shopify.com header.i=@shopify.com header.b="ilpXhkSf"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38710d7d8baso32880381fa.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 04:49:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771850975; cv=none;
        d=google.com; s=arc-20240605;
        b=bzqIhpnaQQooXKbfHuJK05VMeaCmY+TAtVoDy5DgDTd7ghSxlLU8gVvITOo/riC5sw
         X5JdnBjsGiWdr+mthwjxs6e2/+8HLvnEi9QXXk2iQaDQnbN0PBDG6xyEqaZteB+pl4Lk
         4W34RXMk8Uw8WptJLAL9cQEKH1UtsV8khBKplUojzUTjKhPIj+aOHfPR1b4k55sVwvrt
         /euQWQCNKogTmEF+Th/EOGTN+T2tj3Xif54gkZdFsIU9LZN+l+V9t5Z8bnRWVLXaB+/K
         rAFSy65IcAb1rMehgH/hsk1Ymbzt/fzl6+8evMj4ZjiYGBObFmdKCQlHxlWqRfGgSRIq
         wk5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9DQiZzZHG7oMwCb+n3UGEJC0IzUXrrBULYwvWKbJYrA=;
        fh=Da6HE5biy/3dHQaqZlewo2+9LhXYm/JveSxLkqx1u3w=;
        b=BnbQMN1e7d0Wis0JARnaZIekEifkmrMc3BPLyEaCJfq+BLLFHhntDYczPgUd/PMJq7
         brQ/hkx45Uknf9tiyqnP7aa5L80Vw/9dEb+qz2flPOPDZkVK80lP2dsMt2bglJBp2a5w
         uKCmeuiSoKkFtt+IuaiF/QfcxJF7jRbal6i9sO2ibcctUbd0ujnAPDop2t1ZPBef/L4e
         +/Taei5nBYt6Z82LlTwhOz4k9MYpDiOEBsLnu0PV9TtptrtWiBg0g7a7QeGV70KXRRkr
         oSBTljV0FO6ady6PRDDsSkjj0EJQchKneAHgO7HpqOc1qXzcRgVrBFh+7z4UgGzyxDa4
         mwsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopify.com; s=google; t=1771850975; x=1772455775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DQiZzZHG7oMwCb+n3UGEJC0IzUXrrBULYwvWKbJYrA=;
        b=ilpXhkSfLnPz9k4dENkIXkZ58lEaMuDjifR9gd2eDsE8qbIOnwlDzV7IvPQlQ2EIca
         pMkWF8lfvsRh5xyyCqNhgr6H2xWEmLw8Q4rWKVJTcRZepCgp9IDZGRD3Wib6Iv8eGDiF
         GglQie7dUxlW88vNqpfkZc3XbEtpzjopY4yes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771850975; x=1772455775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9DQiZzZHG7oMwCb+n3UGEJC0IzUXrrBULYwvWKbJYrA=;
        b=QMHh2UF6QDOhML92UGMmplWYZ9LwX287vZX4tvzlhXafbFAfrTGhArt+EbUUl0j6XQ
         YRdbsOtbbzwRJ5/TdzvbU9Hg0ZvGiOT8Zoy+ayqjHRXcm5uAa6sKar0rQqM3V+xesFIM
         dyC1Nj+micAL7BetNpwRmr9x5DzOO/zqnGTy+Lwe++tZ71vIg+JTKwygjgSocGHKMnIJ
         VZHk2X5SPyZZ3Sm0DJ3x88FUH2eRQXN1E6LpBp4fUJ0LuZuDlp6bBhzza/fyCU3Rjvna
         Yt4vyd+jsibj8GOobW7ATIihEXmHRFs4KJVvc+AuJAb4WzACZ1B5bo1uw80ackgb8Rj6
         siug==
X-Forwarded-Encrypted: i=1; AJvYcCVVy6GZJnnCFHjyzE3bc2ur7ZFdHYM0rCvqmYSLOXB2F8oysZ16yL5pR6bzKXEfdsP38L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE6NkUFgj2e0A3f4yYXfypaMVwk8BGcrG7vygzxcdUEx3NnTVP
	2Io4KaAUSFnbJEREMOQO05YMp+BmvHsSS1scJkiVo9EUUAWFCVfT1/KVClamoNXLasVILu6v1wW
	OKwYkYMN8bEI/fjfUDG+grYP+bPwgQp6I5MRI0lbrFQ==
X-Gm-Gg: AZuq6aJ59iZM83FjPq4uXtA3AL8U/fwsaSmDAzikwTVbAej6NmvTwxBnQ5aeE7r9VZQ
	gKCpmqfZVLQbrUUSO/qbbgVNgMF804MydC5MZrgvAzdxyWXGauEtMzE1oltq/REO1XzOtuCrjta
	xKwrv9mLzp3pKeIkIHjT/qOqTgS3UitHgU/qqNC+Q7NAmAKUcByDHdWFeMh0hSEfN7xcBMpZena
	M3bU14tawu3qUOPEaPbNCtwtx0wKrE5alqwyamMD2iZjVGGDsjII+c9ErFRv/+dxMQPtlhXSk26
	s70=
X-Received: by 2002:a05:651c:41d6:b0:383:1c18:adfd with SMTP id
 38308e7fff4ca-389a5d517edmr21628271fa.7.1771850974476; Mon, 23 Feb 2026
 04:49:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2008.v3.git.1771326521.gitgitgadget@gmail.com>
 <pull.2008.v4.git.1771423748.gitgitgadget@gmail.com> <f48b1f07c45f6237f91fa6f746c58b791edef5bd.1771423748.git.gitgitgadget@gmail.com>
 <xmqqfr6vuisp.fsf@gitster.g>
In-Reply-To: <xmqqfr6vuisp.fsf@gitster.g>
From: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
Date: Mon, 23 Feb 2026 14:49:22 +0200
X-Gm-Features: AaiRm51CJRrU7k3kzrpQO0ZArGUi7-Ak64nDDEJ45xVgFlq-ab8QbB91DypjLUI
Message-ID: <CAGjQmDOfikPmyouaG9zzAYxsEZsW_0p5UU=k_0NkGvUcGa9-Zw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] strbuf_attach: fix all call sites to pass correct alloc
To: Junio C Hamano <gitster@pobox.com>
Cc: Vaidas Pilkauskas via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 21, 2026 at 12:55=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> > - rerere, apply: ll_merge returns a buffer with exactly result.size
> >   bytes (no extra NUL). Use strbuf_add() to copy and NUL-terminate
> >   into the strbuf, then free the merge result, so alloc is correct.
>
> I am not sure about this, because this will result in unnecessary
> reallocation.
>
> For example
>
> > -     strbuf_attach(&image->buf, result.ptr, result.size, result.size);
>
> This would have resulted in realloc(result.ptr, result.size + X) to
> preserve the strbuf invariants that len + 1 <=3D alloc inside the
> strbuf_attach().
>
> It depends on what the system allocator does, but when X is a small
> number, often no new memory needs to be carved out when this
> realloc() happens, and all that needs to happen is that the size of
> the memory region recorded by the system allocator is adjusted, and
> the program will keep using the same memory region plus X bytes out
> of the slop that has already been there when result.ptr was
> allocated.  We will call realloc(), and it may result in a true
> allocation and copy when X is larger than the existing slop, but it
> may end up to be a cheap operation.
>
> But if we rewrite it to do this ...
>
> > +     strbuf_add(&image->buf, result.ptr, result.size);
> > +     free(result.ptr);
>
> ... we will allocate as much as result.size and copy the bytes.
> Guaranteed, regardless of how much slop the system allocator left
> after result.ptr+result.size when it allocated result.ptr.
>
> Of course, we could rewrite the original to
>
>         result.ptr =3D realloc(result.ptr, result.size + 1);
>         strbuf_attach(&image->buf, result.ptr, result.size, result.size +=
 1);
>
> which would avoid the extra allocation and copy when there is even a
> single byte of slop after result.ptr+result.size, but at that point,
> for the sake of simplicity, we may be better off with the original
> implementation of strbuf_attach() that automatically does that for
> us.

It seems reasonable to stay with the original implementation. So I'll
change this patch to keep original calls to strbuf_attach() in rerere and
apply. And I'll remove patch which enforces strbuf_attach() contract with
BUG().
