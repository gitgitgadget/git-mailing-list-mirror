Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B7C320382
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765821125; cv=none; b=SAf0rQSb0rWUgm5THd9JAWk5TJNltE+m2gNJrxrnSgmUGFb95mf/7/K329IAuzgrZ/8a/gqcsnHvPr9Y1Sa15RUdFsCodtt2XIKDyugp54p8fjoTdFEpCzx3rN6l48cCST67xZnDh/lPv9UZhleoQ6GRmkK559On+tGozsUpgd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765821125; c=relaxed/simple;
	bh=DmN75eLvNUeDJ8J36KJGwWQSWHBUGd7qOvOINwma0gY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8Plt7Clo3F8rQqeVOIldT3lcekbOxbqKPp6x5JnE3X2PC2jaMPJ03+1SIoAvrxzxMTceccl4d5Xo/6k0zH1ybToVHy5RQhzCLfD9v5f2NIELQtY6foTu1UleV/2h7tYCJcWDE7I0U4jyl43mODA64XhSEWTMR3ASv9WdrtOGIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8887165aaabso6297496d6.1
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 09:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765821122; x=1766425922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5LOWWiC2wdP5B1dWzuiblxhDd8U1LZ4RBgq2vlkFMag=;
        b=Klp5HzbHma1ndbPT4ZwqFJiFNUPiXYbyhB5E0VznZM8pjazqJYXX6R4Uewqqo/29FI
         wqZR7ppi3d1+PPurjy8tDBsohCD9lRB6I4qRo7+YxYKjh1nSJ1eBDU7jvD02x2X6Ffz0
         kp/1JgQyWzvP1FUf13LPI3YytEmOIqqjoa/DoDLnqWgzA++16csMYyX9xsrcGs0DXwp0
         IHEBAQFdcXjddg0s7mxRp7DF9HM0POwOj+qsrq1qUf0gwskGfyYhIu5p/OcjpDZc7JZr
         FG07FPGuBTcbUYhS27Yyhc3pPRoXUESd4P2eJKmSSPeOn8nPOqNEHXmRMdwsHA/219TB
         9Trg==
X-Forwarded-Encrypted: i=1; AJvYcCX5264mqqb79q2mxLzSAlxGSzfD0xERot6DGhYjyE60ioLOC8Zy+HP6RDFA1QPOGpsT3ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQW0XHD1cL5edKYhMN4I2le2Ov0NpUp8VmRB6skqc9tAoyl1da
	GkfMq3WId9qlVvWTFKj4+37fnfn5vfm7nl2hRpp5WZD4aJPjQb39YLvHK3SJgF3KV6xk5hr4qNE
	zGNrYyjkms8rrux+vFI80j+0vx5L+btc=
X-Gm-Gg: AY/fxX7gZMxuKhZ3g/wyCsjIkTTxWhhEKtkDYCV3agy27EfTCsL9agyqe7ipG6jKM4I
	Zl7VN33L6a3adbHxlp2ePlfR7F99lL/taqj/Lu7zG+7h9LJN/SZiZwMrhkUvnCayHUfGlH7aa+K
	QOPPZa2hGqmYBTsWzI7NAIb6AxFhDP1xFk7NEuJkVqGc33lQKyAPzob8l+UocWPLPa43PL16f+v
	poY0JOVaBq6lrR83kkl6JcVwwfAhg1yALKx8veg0OO3xhADH1bnMktTb8a7Aohl6eXW+UQ=
X-Google-Smtp-Source: AGHT+IFicRZkZukvoPgEuhs/hTzNp4FrwZg1NPEYQHpqLtrfuycVtaeaaVlRB957j3FTLs1954uMN5F6nfkMqYjBpsQ=
X-Received: by 2002:a05:6214:c42:b0:880:4bab:466f with SMTP id
 6a1803df08f44-8887e004782mr145193046d6.0.1765821122288; Mon, 15 Dec 2025
 09:52:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALnO6CCu7A7mkLy==K9a-u-z0kYBKLiyBz+Qq8c7PWLHO-YuNw@mail.gmail.com>
 <CAPig+cSctvQoCNvQqrsLjzLQBc7H9u2hpxeBHE19_AQsup+kFQ@mail.gmail.com> <aUApKxjYHMPHNIac@pks.im>
In-Reply-To: <aUApKxjYHMPHNIac@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 15 Dec 2025 12:51:50 -0500
X-Gm-Features: AQt7F2rOlVvymx9Bb_r5qI0R3_C16aJMKxmss95PTvHyg_FLMBnck-Cz-Up3eGw
Message-ID: <CAPig+cTrLkEPGb=7dU1pnB9ir+vMaJ2W=J3R6+9kLuHkubtS_g@mail.gmail.com>
Subject: Re: meson -Drust=enabled fails on macOS without GNU sed
To: Patrick Steinhardt <ps@pks.im>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, Git <git@vger.kernel.org>, 
	Ezekiel Newren <ezekielnewren@gmail.com>, Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 10:28=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> On Fri, Dec 12, 2025 at 03:32:30PM -0500, Eric Sunshine wrote:
> > On Fri, Dec 12, 2025 at 3:01=E2=80=AFPM D. Ben Knoble
> > <ben.knoble+github@gmail.com> wrote:
> > > I think it's due to e509b5b8be (rust: support for Windows, 2025-10-15=
)
> > > [relevant folks CC'd], where we assume sed can take "-s" (which AFAIC=
T
> > > is a GNU extension). But perhaps "-n" was intended with a "p" flag on
> > > the substitution?
> >
> > Yup, that's a strange one. Indeed:
> >
> >     sed -n 's/^host: \(.*\)$/\1/p'
> >
> > would be the correct way to do it, while also being compatible with
> > BSD-lineage `sed` (such as `sed` on macOS).
>
> Ah, indeed. Would one of you want to turn this into a patch?

I'm not likely to have the time, presently. Ben is welcome to attack
the task if he desires.
