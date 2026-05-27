Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C73737A488
	for <git@vger.kernel.org>; Wed, 27 May 2026 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896257; cv=pass; b=RrDPsB7DDB08JkBTpUYa9vO94D/LKGD5vvAfW/sqJx6E/I7B7y7vUJUms9hHE9thVHPCg+2sYoic6eeDOh86LKNYow/wUxdVi+rQaO2FWeWKTsrJq7i28xV+APufvpSA8OLG4nSId5Qo/Y22lppx7WGUvqlC6YOj5Fw2v/QlcVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896257; c=relaxed/simple;
	bh=ZLtbTWxa8fznBSchZel29NC3yGHedWpN8d1nyWdezkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYfpVBKxdYGFBwGvh771aJ5nJwIb37vIZJfnFECODrkM3ODRX/GYyjeMnIrZtghAl8ib3OjExtCqAGC4NnVAJM54XdVeRYYq35ciQnw2Osl+iFezTOwYHmKN7SKQVoxbin8ul5WUJOjYYE9vrkEisMJSllpI+IOzL/zHwSGfUEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxFwFIOq; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxFwFIOq"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-134ac81c445so20329687c88.1
        for <git@vger.kernel.org>; Wed, 27 May 2026 08:37:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779896255; cv=none;
        d=google.com; s=arc-20240605;
        b=WzEaar2s8k2Cek9H694xnXVeoVWiLAoseyVukyWXFzHZ/ocfdxhy74QRZvCmD+jAay
         SULbuiSQ2qfrOODTboOKnWsu5dGulRwXynUQCXpanAX0H2fmun3aEt+bwBv0vFYjY4lG
         11DqSn0cUclhq37a3KvCfumDif7/x7l26y2mA5qdBKym2N+BozQdndr3S6PyG78Zu8mC
         VK5lm612LIbBaRg/glAW+cZMMiraKaDkko5KNoqtUfvpxe7sKpr0P5UmNEg6x46E6ej8
         mUDY/J6gKK2Vh5DqhWGh/27h0gi8+jtbbrH/QJ/M4G6NH4UwfPvHocGkpLc9O/e1xWVN
         SKGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zqVj8JKNn4zO/sXzzG6jY80+UraIb1yP4XTDUKMlrMM=;
        fh=H7s48KkX+86qsoAa/1engEp2kkLtba5IzgUZWIMlixs=;
        b=ZGkoIiyWBwvxNqfgkq6qKSD2mC6a0svMBIZUUCkSDcMysZ1bibWTHyz1R89XBk2f98
         5EDGAZBJjG3G6OrC029DAuJjs7v9PSMaKgrlcDA60N1uz0QfC+7DjYeAumLuXVG66kdv
         S2M47bs2oxf+fIZ7ZBzRMX7NYJth8xvNw2Wq8uIEP/UwusxIUF538TdAKWmsnPahMCit
         cuUwf72HnRNBw5sR5By9ZTtF55zWuHVBktkOr1G8XUdtTpwOW9Ln2rLQrRz2EXKIDH//
         ID9mEDCCOPlu/S9lkHEbwSx2xE9fuDlj1P2T4z1MTF/+iuHOpJbwfJ2qCuJfEzExvxXY
         kBkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779896255; x=1780501055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqVj8JKNn4zO/sXzzG6jY80+UraIb1yP4XTDUKMlrMM=;
        b=CxFwFIOqwHVWWtmYExjvXr9MdZ8OaJ2Qe4yOma76w94zacrM343h8qKaIxOzNIVc+l
         CoiMn4bKvKMR287HJqKQFRjkuEOt8w+XVP5Es/zeL8Wu5I/7xWovK50l8ThyiRlVzhbf
         nHQPuk4wrziQ8+JVeRuTY8DXfWwTIhrJUi3KbChgpw+iUqqXxeK9W1YhQw2EO5zIgXJ0
         sWvZedyoq3R6D2iz2ruxJDP+p/Y0Bu5s0L+AwXQlL5ft4xS+ud/m7f7aTYZtKGF59TjX
         ni9CrYUrFdqgMw8A7PvwHFpIRy5g5JYfYkZRnjKtzkhq0rpatsCo9BKv3D/8QEO/YJFz
         muDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779896255; x=1780501055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zqVj8JKNn4zO/sXzzG6jY80+UraIb1yP4XTDUKMlrMM=;
        b=k4PTiEuKtF3yNIVTpdiFYstvPJ+HUkPXu7GPQ3bb49zK1U8ANz6eUkn6rLJrrOxTek
         uUdFOqVF7X+AQmW/wRzqHFbYwiKzL5FgYVd4OOD0OtMDjTEmsdCu2+ghRUK4WtIAyeCn
         yEhD23mAo/fehwN8Hqp67vvzeL6X8lx+tQk+wlSb+RmJ9N4j2Vd1bhOiuhOo7mPma2lg
         HNLhCdeYnKnPTSj2IBcNFI1pFru0tqhk5Hwa1yUHjtpq7pumHUfnI1ei3VyuOyE0cvjX
         4vzUVxTf2opIBincQnKJ0Ihk36suzzIq2GrRNk0ukSf3ZcWCsJF06o2vkipNKWjqMzUi
         D9Mw==
X-Gm-Message-State: AOJu0YxU9PnoqMZw0rrHUaHpyWxwuo0oU7RVxx0W+PzQ7CX7DkvfFh5q
	yRPc7y9UShN8nlqJJu3o43CyprtcDvhi7bfpJC1duVnKVGhv7iqYm4vHp2Grm/CC/BmY9tWUC9v
	hGgTmhhlxeZ5z7yeQ210Wlh67/LmuAXE=
X-Gm-Gg: Acq92OFQzPyTUI2CZC4GRAiJ0yiABv0HdRGMfjmoULyevrKRAIXa064MMhdMEak9d+g
	kc5jJ2V0jxYgMfTtZaZBxbcRD7upkQgC+XW6rfCX2K8Z0k7kExVMWcm7CtRRSvbNfXof/X1q3RE
	SNChZdpXoMUllQByeUE7JUkwWWCb9wPvvjNaqo2G60kdHfw4aEqlrJuKQ1QGwpVV6L3eXW4BT9g
	PJ2pQNUjy5uUwK07CeeTpzIEtAdJbEP8K5vAYBmq37R+z7eqrHXfCuuecvGsz8+kKK1YC5FAP4g
	faQ2Sp1DYxwyWymnrEZ37EfAPWi64uu2gLcLJA8P6ZZsI1pqa6sTrop7ghTnCFg3XULp
X-Received: by 2002:a05:701b:2905:b0:130:6904:e817 with SMTP id
 a92af1059eb24-1365fd74536mr5558185c88.39.1779896255390; Wed, 27 May 2026
 08:37:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427124108.3524129-1-christian.couder@gmail.com>
 <20260519153808.494105-1-christian.couder@gmail.com> <20260519153808.494105-7-christian.couder@gmail.com>
 <97b9f2cd-7c82-4d4c-b574-31176074e566@app.fastmail.com>
In-Reply-To: <97b9f2cd-7c82-4d4c-b574-31176074e566@app.fastmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 27 May 2026 17:37:24 +0200
X-Gm-Features: AVHnY4JXMXgnamJo1FIeoPZ4T6DEu96Kc8Z-5fvOQeZ5_xSqdSLDZINN8rspRNc
Message-ID: <CAP8UFD33N91V5dt3NL5xozfVm6rc=-6r11nTMq+RM=eNp+R2xg@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] promisor-remote: trust known remotes matching acceptFromServerUrl
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Elijah Newren <newren@gmail.com>, Toon Claes <toon@iotcl.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 5:17=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Tue, May 19, 2026, at 17:38, Christian Couder wrote:
> >[snip]
> >
> > Let's then use this helper in should_accept_remote() so that, a known
> > remote whose URL matches the allowlist is accepted.
>
> I don=E2=80=99t understand this comma break?

I have removed it in the v4 I just sent. Sorry for the confusion.

> > ++
> > +Before matching, both the advertised URL and the pattern are
> > +normalized: the scheme and host are lowercased, percent-encoded
>
> This next paragraph seems to go back to describing how things work. But
> this paragraph as well as all of the following ones belong to this list
> item:
>
>       4.   Be careful using globs [...]
>
>            Before matching, [...]
>
>            The glob pattern can [...]
>
>            If a remote with the [...]
>
>            For the security implications [...]
>
>     promisor.checkFields
>     [...]
>
> I don=E2=80=99t know what the intent is. But using an open block will del=
imit
> the ordered list.
>
>     diff --git Documentation/config/promisor.adoc Documentation/config/pr=
omisor.adoc
>     index cc728bb0b5e..f07a2e883bd 100644
>     --- Documentation/config/promisor.adoc
>     +++ Documentation/config/promisor.adoc
>     @@ -109,6 +109,7 @@ and to update fields (such as authentication toke=
ns) on known remotes
>      without further confirmation. To minimize security risks, follow the=
se
>      guidelines:
>      +
>     +--
>      1. Start with a secure protocol scheme, like `https://` or `ssh://`.
>      +
>      2. Only allow domain names or paths where you control and trust _ALL=
_
>     @@ -130,6 +131,7 @@ guidelines:
>         subdomain. This is extremely dangerous on shared hosting platform=
s
>         (e.g., `https://*.github.io/*` trusts every user's site on the
>         entire platform).
>     +--
>      +
>      Before matching, both the advertised URL and the pattern are
>      normalized: the scheme and host are lowercased, percent-encoded

Thanks for the suggestion, it is indeed much better this way, and this
is what is used in v4.
