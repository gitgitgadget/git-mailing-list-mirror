Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC07321C19C
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 19:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749497876; cv=none; b=ndJ9wXQSKBUYM4z1aODG/RoM5JQAkFHzjGde6NLD4Ilmg7SGSR7BmN1tVKF77xt6uPyMnYejtZhsS/sBU8wv1G5vmEzbWMinxa9xb8v2zV3P07KMNXXZNnxCo0ONemjPqRj0UMCgueXy02Woq5xWbzXUjsLRka+9wlN/oGuy+TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749497876; c=relaxed/simple;
	bh=sPkKtIUn70tCqh3J+ET02hqXbbi8CAJEtRXomqg0gVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqfRTrXW7dtcQ0BW1ctnpuscX+/GrxXuUor//YYg4aaIm6NsvAlqd+btLl5nwQo+e6+gzeqL9Qv4iRoMlv8KGHcdeoNNW0pQHev6kf2a/70hlQcgizm5ph6Vxlq8cNzzogJ/KbFGDbWVgD9RD535qQb4StCd1yQEX5aa6XHeLS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUmsyDFo; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUmsyDFo"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ade5a0442dfso248433066b.1
        for <git@vger.kernel.org>; Mon, 09 Jun 2025 12:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749497873; x=1750102673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sEZlkRi1FAesXMYsZAq8oe9KZy+SGMaEVevT/KMScE=;
        b=gUmsyDFoQt5O0A9XDHBLqGBq7mxVYe23R/KcbAMHabFKpGruOfPhxgcP9xSWVeo0eZ
         fTe2GCuI1aNy8oCOfHeQA5ezWX+WyPr7rHvCWXi8rknqYTaPiVlGMA6m4bYTlW7xgY5P
         GTsyNDlZvYnoFC+S29lMM1wIp88E5yYSxOGNilWEg5sPuaUKnDGUNKPQEOrb6y6qnUUN
         /Z6qSacjexMIm/YKFAUSe/qltSz6xl2x7D6sl6oF6XjAk1d1UEvGFU2/vxWroqJs/tde
         yhauyCL3pniIx4ohkGhoot+BXpuZlHLdVNi15A5DX9OfvlhMg7/TXKxkDE5hRlVhdidj
         UZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749497873; x=1750102673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sEZlkRi1FAesXMYsZAq8oe9KZy+SGMaEVevT/KMScE=;
        b=JZm7kH0VA2jg5/2x9ZTM4L4M0ldSLdJQ+ww8MbWs5ci7WN8VjtixqcbfmsX9k/ci3h
         HavOzOMK0SMNRl21mUyVlRmGlKoPSjzfCQe2vFxsK1IJUprf+YEeg7DuTUgO0IZ85W/G
         9jgptB1yOi8YuYZLCdAb6xoougWZ4lmvAwsQaAsmbyDSiuM8Cn1H+/qbfJRCcnA374i8
         gB3KDn3zYiIwrg7aw3wj1KtpKUyVuk0FcesEnQLLEzXCrQyqIcDTjJzuPv+/gjK0FA9V
         mnylrBN8rXORWIsOtpJeJCUP5w8nCGNv2RUOQfvKM7jktVkLSD4kefPZa7pVYJzgX27S
         OPYA==
X-Forwarded-Encrypted: i=1; AJvYcCVlGJPZb16qWjvREipXmzbKQtVFqQnayYEaZ3a/lvw/Uew3oYZEEq0UmIAZFAZtUXy5Ns8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc2sleR3bTac1Uk0VPqlOEx3BwAS8YImTHTuna//pOagZZJQr6
	p7mFHsUt8WCtjrMlHd3EL/8COI52mjZ32qRoZiEF0U5OUNj4rAnpTbrK5TrarpaHOFdrbWXBKD8
	f1DufGTBgbTVR515uHwdHU9vCjFqjwVI=
X-Gm-Gg: ASbGncu4pmLcV6fUl520+fbymrGbEOknhJWFp53aHR7STUZMumhVlRjBkC3fToa44xL
	fGr+vQOfNEJ/Lt3dkZPfBR7hnP7jQy/FyOX/7ElWE1HQcV78q9aG9cgRSaXBeclSOxz95vimJ7H
	fv63JGKcahvaCMy/X1cQhiYzzzhW0R21rUWDdL7XhRYd1jc6u3x9N4egdoyNUZQWypag==
X-Google-Smtp-Source: AGHT+IHg+ltw7D5/a8lZdL0j2nGJp3RGEZNYmnzsJaKUftbSekHf0Had1EcQpblZuj4+emzvxDRtkIzy2RNtWoL54yo=
X-Received: by 2002:a17:907:7fa3:b0:add:f39e:dc91 with SMTP id
 a640c23a62f3a-ade1ab5ec4emr1353930466b.59.1749497873068; Mon, 09 Jun 2025
 12:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGJzqsnvTnp3k8Ab2exaBAw5pszQRz00UcucnK=ECtY5vhG+1A@mail.gmail.com>
 <xmqqcybcrc2u.fsf@gitster.g>
In-Reply-To: <xmqqcybcrc2u.fsf@gitster.g>
From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Date: Mon, 9 Jun 2025 12:37:41 -0700
X-Gm-Features: AX0GCFtW2QjXzIdtnjbn1Sa097vC4IYEA3m5sjL2oOlduLPioLTzz5laDMXYHQ8
Message-ID: <CAE1pOi34+btHyV8GbjpFPcJ+2ixu59ce4eAE=Q7F4JEcuJyXnw@mail.gmail.com>
Subject: Re: Suggestion: error "tag ... already exists" should distinguish
 between tagging different or same commit:
To: Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Does it really make sense for that first example to fail, though? "git
tag hello v1.9.5" is an idempotent operation, isn't it? The second
attempt is a no-op?

If "git tag ..." simply does nothing if the tag already exists (as
requested) then that would make the OP's issue go away: only the 2nd
example would fail.

On Mon, Jun 9, 2025 at 11:45=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> M Hickford <mirth.hickford@gmail.com> writes:
>
> > Hi. Presently, the error "tag ... already exists" doesn't distinguish
> > between tagging the same commit or a different commit:
> >
> >      >git tag hello v1.9.5
> >
> >      >git tag hello v1.9.5
> >      fatal: tag 'hello' already exists
> >
> >      >git tag hello v2.0.0
> >      fatal: tag 'hello' already exists
> >
> > To inform the user, it would be nice to distinguish these cases, perhap=
s:
> >
> >      >git tag hello v1.9.5
> >      fatal: tag 'hello' already exists pointing at
> > d4e6038a068d0aecd5ec28c83afbfc6d4903092f
> >
> >      >git tag hello v2.0.0
> >      fatal: tag 'hello' already exists but points at
> > 18a07354e33f86c8349ffdc300d9087876658264
> >
> > The second error is typically more concerning than the first.
> >
> > What do you think?
>
> Not interested.  When the user gets that "fatal" message, the
> existing tag did not get modified, so they can just do whatever
> check they want (like "git range-diff v1.9.5...hello") themselves.
>
> Besides, in the above examples, is d4e6038a something the user
> immediately recognises as the same as v1.9.5 or the object existing
> v1.9.5 tag points at?  I somehow doubt it.  So after getting the
> error, there needs some digging to figure out how v1.9.5 and
> existing hello are related to each other _anyway_, I would think.
>
>
>
