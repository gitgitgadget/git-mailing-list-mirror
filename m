Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE0331D366
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 05:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775109227; cv=pass; b=C+4PdRNeCNt386gp0wfU5g/NTX8YwUOOw7rB/HU5WpwI00u6axkWAX7j90y3Q7W1CbLNE/heK1hU62Rd074+D/AhwOkbcMgOB+m/9jpM5mgeo8syvYato4Ymm2NA5Z5BJT33oO8aL7OdfFBrD3Apcr+w/69P6uvR8YaIZH9EGkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775109227; c=relaxed/simple;
	bh=MCSoKD93wCaZoOH7QrO6cW1MEh08XWYs6+xSdpUlKWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jezt7mTl8xwJHLrK1a2UyGffHn1C4GMc7DNsc2H9t8Z+ZsG7GNw5cd2YK2fe+E7VJG5gBHUnlsWX3xTb/cEvFZEPFQFVCqAe440cWTAo4C5mweFES+c/Z0YQNfAbsVTLYoCe1GwKqjWJSm0IbDXzOZL+7EbgPGnNOlZ5EKfANp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jb5Eq9km; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jb5Eq9km"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65006c99d38so523258d50.3
        for <git@vger.kernel.org>; Wed, 01 Apr 2026 22:53:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775109225; cv=none;
        d=google.com; s=arc-20240605;
        b=d60ljVZ6n+muEi248l0sFIhL+uyGDxp5Oinp/xxBlfA4DfrCyt1pqKT5h5rX9rTURW
         Ty4nFAar+g4GU8UknF8fPmXslLhfTfq1couSaLADTGMTiHUMxwsoyXa92XcHwe0F9CyS
         Wa4b9V9URn1pUURKxwx73FTYtI2Ajok/F3rNcmCIrZfaroAj37ENL9RHPtyHSMiq8Yid
         9mdEf/4lZyuxI1yPKsQdRzn41AXgG7zY8QxwufBU9JjsDMbqzK79kIhag5MfQZiGh2G/
         5VS74HrIHzVKtPLZgTY63fbwHFxhnx+VqbNK7TUZZT34dyQMJ+mLWmSrN9NpCSlgR76e
         EjVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CL6Dkq1lAaX79LWLAEYs5H4VDh9FRJZZlj5PzI1WW2A=;
        fh=gilwEWxR/9bLNvNFxCfRNtWTbSvNZpT36bRHXU+fCTs=;
        b=FxQR/hNOMUglJLdi2LOP6bgOs/Ndu0pYUUrsJv8CLko1PSbMpiLDFdhvTWJUIbFMlN
         7taAfgTyalI7tUs8DXNAomdVnDo4+0YAyS+fdpEjvkuZzoQDDS2GswLyVlczoDni4p7u
         GCkP2dJxIjmyXjvKziQjgR5v4wMwrnxFnVfJX9dZjvri/MxGXcpFXR0vhZLuZvg5NeB/
         yQaBDgwyk3mL25ztI8ddQQLKKCuAnLs+zUKB/p6MYlFP4FJq7g9Ipe1iWEMl2Ti4IjvP
         FlysKo2wZG80h0vryDSSU9FlgGfh/+MvQR9iLNXlKxttKID/Rh7Cl+1lWOLIWE6x1IF/
         ZJ5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775109225; x=1775714025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CL6Dkq1lAaX79LWLAEYs5H4VDh9FRJZZlj5PzI1WW2A=;
        b=Jb5Eq9km3i3wA69iAoLKVj5UDlYKRKf0oDCNYxm6vhyx91H3jq/afqlg2QD/nbDuyO
         Zr803ejQsypbu+dM1u06mls4XinQbmTf1y+x5YA8Gp/ZdyxSIADTU8pOfzFCKvbkK2aP
         WLV61OY1EfrTA3AVrONpLE8dBc11scr+YqMb+k2dFR/BWJU5E/XFQ77fF6u90BABA+L9
         cb5EDzPxoqvW3TmT5M8Xh9mVzmGhI4wh214bHmy/HOszoynDtJCPe44Yw8u+XpIaGIQJ
         m9v55KsmdjUijmsHaWB1KS4aE7InbWz856iiu9t3qGaj5x12W/FyxLRpJwg4Ef3qb3xn
         LZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775109225; x=1775714025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CL6Dkq1lAaX79LWLAEYs5H4VDh9FRJZZlj5PzI1WW2A=;
        b=EfkyuspUe7g9mGcGjSOaUikdcrDhf+iEIHulAr36jLwt76V/L8oDxhQnHefEEOUlqt
         i1IfVipE7YGn6w6/3MZsn8cWJpPEh4myiC5bouikffOn4pxW2nYM1okJjwqQKG9XaKl2
         Jhd3yjyZVl9ZEGkt4u6mmMhFZVQEOaLwGhcRKPaKwMmKLYPe25Mx/BF6KLzUZhYnmw4J
         alfDEO7O19dGUu67A1krX4swZZ2QEDEP89arSsa1rTZGygEJ6LiHDMedTnYClxKJM11t
         /RTQxDR2JBpCNQ6KdVZ9fN4Hw/45Nr0S1QZo2BcjuWmbA4+cB2PjGxjh1baLc7EL6y0V
         MzRA==
X-Forwarded-Encrypted: i=1; AJvYcCXZxE1s81m+VBYlhaJ8cjV0R95EWNTP0T/iGdu9kFpZxEugfMzY5tOb0kDVWJQup6Mu32Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz4aie+GQYlo+ak0+tuTAW+07ZaDne4ugoGjOT/e30lglEW+se
	QSt7Xq5RL611+KMsuseBlGvuh9UhIp6cP3jijxyKaifVVfnw/RaPhfX2RfkfAMN//m6Mop+WRrR
	0PDn7QNrEA8Yv+EoPAVE8P5NPTnaJom7laE+pJrDAdg==
X-Gm-Gg: AeBDiet/N+mb84yfo+M1l+pCWIVMnx3IkD9XRtVqkBjS2HdBYyRjGLc+5Hjv3kvHcgh
	gr0/3gy4+TppqFVLHkRusR6CSRd9kMM6IBn+sYFpfTMtApvksUwYfusspijsgOfEu2KnkFHBk6D
	DzmeZbCHE0iODdlbfaKKfcmdQM/1FSZVPdvmvg7TbstjYZoQ0Ht4HCSt/ESX4gDxc8viF1lInJ1
	ERMRtxoRPBWqX1d8uc4xm7btIEFbtPJ3bWi1DsHUQySYZIe2xD71wPzsmMUptlhwigeqrfzPc8A
	Uwxv1VRvFKAEvBo04oIs7ft2hET9cqq3YDX7YFqbZr2hPzWuTIs97TIbwpX6oglLuvkW6fWBYK9
	0laADT8FgJEKrpTL5ogEwmQ==
X-Received: by 2002:a05:690e:43db:b0:64c:f7d0:5c07 with SMTP id
 956f58d0204a3-6502fda4b02mr5660318d50.10.1775109224831; Wed, 01 Apr 2026
 22:53:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325174401.217577-1-pabloosabaterr@gmail.com>
 <20260328001113.1275291-1-pabloosabaterr@gmail.com> <bdff0a5d-b738-4053-9b72-08eba88156de@kdbg.org>
 <CAN5EUNR_yfkv_hC4wg-nHNg=3FnkYdvFm6FcOUNG2A=MdGs7ZQ@mail.gmail.com> <xmqqikaawrpx.fsf@gitster.g>
In-Reply-To: <xmqqikaawrpx.fsf@gitster.g>
From: Pablo <pabloosabaterr@gmail.com>
Date: Thu, 2 Apr 2026 07:53:32 +0200
X-Gm-Features: AQROBzCqANpHHmoDB-FEGtw3ZF7eVJ56sPmxVdFJHWUhOMlpOH03g0ZXdCm1edQ
Message-ID: <CAN5EUNRvsUgZPQhk4vj-QY8k+iCkTHQsgO8RJj1gNkYBDChsZg@mail.gmail.com>
Subject: Re: [GSoC PATCH v6 0/3] graph: add --graph-lane-limit option
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>, christian.couder@gmail.com, karthik.188@gmail.com, 
	jltobler@gmail.com, ayu.chandekar@gmail.com, siddharthasthana31@gmail.com, 
	chandrapratap3519@gmail.com, szeder.dev@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mi=C3=A9, 1 abr 2026 a las 18:49, Junio C Hamano (<gitster@pobox.com>) e=
scribi=C3=B3:

> Oh, I may have found a volunteer to fix one of my pet peeves ;-)
>
> Imagine a history with multiple root commits and you are drawing the
> history near one of the roots.  Immediately fater pacing that root
> commit, the graphing engine seems to say "ah, the next display row
> immediately below this commit '*' is vacant because it does not have
> any parent.  We can draw a commit right there" and draws a commit
> that is unrelated to that root commit it just has drawn.
>
> Which of course makes it impossible to tell that the commit on the
> earlier row is a root, if we draw a commit immediately below it.
> We'd want to leave that column/lane open for at least one row.
>
> Instead of
>
>     * a child of the root commit below
>     * one of the root commits
>     * an unrelated commit X
>     * the parent of X
>     * the other root commit that is a grandparent of X
>
> we could probably draw
>
>     * a child of the root commit below
>     * one of the root commits
>       * an unrelated commit X
>      /
>     * the parent of X
>     * the other root commit that is a grandparent of X
>
> or you or somebody who stared at the graph engine much longer than I
> have may have even better ideas to draw such a history.

Ok, I like the idea and I think it should be relatively easy,
something like if the last commit had no interesting parent to keep
the padding like if it is still there for at least a row, then
collapse the commit (unrelated X) back to the first column. So far
I've got this:

  * B
  | * A2
  * A1
  * A

Once I've got something more close to what you said I'll send a RFC
PATCH on a clean thread and CC you.

About other ways to draw it, I actually like yours, other way I can
think of is to make a hard separation row something like

>     * a child of the root commit below
>     * one of the root commits
       ---
>     * an unrelated commit X
>     * the parent of X
>     * the other root commit that is a grandparent of X

But I think yours is more minimal, with this it would be a new type of
row to handle, etc. yours is to pretend that there is something, hide
it and let it naturally collapse.
