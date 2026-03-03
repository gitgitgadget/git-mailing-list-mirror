Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFF9377027
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 03:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772508471; cv=pass; b=nPqySoWyFyUq7YQXEX4AzbAASOzsdX3PuMLZzj4MJIjLkoI3XXAZZnLrof4+4cnK0yyM4JoMF988RQAPZcnUwy5rTFc8lpyCqWvrgRw5R/XJCr7o7rT2lsl+LFiIFaipoPG5ggdnro56GEfkMrcyX0fAZ5DeeZz7PpFZ1Q0/7XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772508471; c=relaxed/simple;
	bh=fNGiGu7iJxbnMa5GyI4w6jlzcW/6pyizMnUZK/qwIsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3TPguODwUKtBb/InJsC2az2kpcozy0JmBujAsvUko6HnYQoHA7dTIl6NbCZbUne6CQsDpuk5ww4becYxUzWq9uzdDGPY33uxpCqCQyqsI1IpAvF+EYBdwzfd8JfSmGQvd1M36aZNMvI1cKQr/WB5sza+wIF2d+v4BadZVwBaR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3dhmGRM; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3dhmGRM"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-389fa352b0eso74148041fa.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 19:27:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772508468; cv=none;
        d=google.com; s=arc-20240605;
        b=NlnPO+Xi7dYHTatqYqa2qI5tb6kdkUI/Cd1EB9U4apKMbl/Jva6h+Ok/U8jzot/8eQ
         bZwwwZE+P6Rvdg/dA0B/FD5BIyg3UE88TmOBsPZCiYkY0vvfCxgalNhTNlU7G6lsC8CE
         xzPVMPKQQbGJA5f/nCWzmr44XjlnVcGJcC5LZYc5+CfFIMQRQz850WtPYQa2BoGXCT2s
         IC7fDs5A+bg1RvmQOrjM96lKhC/jxBJLDczMzZA5fwJ1jddHL/5KYPut4mzdx2BY5d3J
         FLdyOoSqxtJSU+kLxFmD5ickMExJQ9F17uF07aQOV/LrYiEi6qQTLoUmF2wHSC19bLyz
         049Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fNGiGu7iJxbnMa5GyI4w6jlzcW/6pyizMnUZK/qwIsY=;
        fh=6HtJDVB824boFXmT3cWxiKIYXNf4ZEFPQG8ED0mEja8=;
        b=PQCQIQF8SFcBoHFWRhp9T8qNYhQEC3b2hZ8v93XIMHlrEv5a6mz4KuMK/UPaRKWKg0
         WQcVqeI03ZDBt3LNA50JdQWnJPgUzY8B4fZ7+b6u+y4lbpG7x7fphvKJr7N7mB3seccT
         Ej6l+P43u2frOktvrCY+2FgdQiLjCFNiSETGG+gF3JCgyzh+t2zX+t/d3C59yfwOTqF9
         USxzJxz5NqjY5uhPvrl8Q+Uj8aH+QpumFgNTFJBu1bgvTtuimDslK9jbP3ZMk7BX+Qz8
         M1jwmcaGFq1XWBMZTupxMgW35m8BXoKVIbVCjsz9OzgPnLtpN4ah8zebrleFTNBDpMnD
         g9pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772508468; x=1773113268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNGiGu7iJxbnMa5GyI4w6jlzcW/6pyizMnUZK/qwIsY=;
        b=T3dhmGRMxaAsQG2ZKWqJMGkWx66pTDhR6f8x4om5rBPeSwCa5ulS/x8qcWQ8P4jkzM
         lX9RpgnWS/LKX6p8IRtU6g2XpmuTMwmGbgEwIb0kbe/FkWpRScTeAbCqUieje4igBNtp
         U4oss9B3D6Nh9mrV5k/aQihLRvDwBHpxEunXHiHABmseIR3SG+b/7EhQV8hJG79vlUv0
         V5v5ngKZrLWw9ebhB0OhUnGxQrkjCpW4OjO8w7Fg0xQeC9K9TUk0RvG7IYYD+5zkK3Kg
         SCIlz2z13fmx6i80ZtEEXk2sIt3ZZWZ8fRbdt7GUJzMSRYy2QA5tjVXbk3pVjqgKeT22
         SJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772508468; x=1773113268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fNGiGu7iJxbnMa5GyI4w6jlzcW/6pyizMnUZK/qwIsY=;
        b=If5qbPsEOSRSAeWiHNQqiFzB/arTrhg2wwyIFeRiZxbJw5Rqtpo3gKEZZNe5LciAIh
         XkX4sL5CgZqbvfi1DrhOkEmlwKvH14z8Uzcul7XZKCNZJfmTtnlxSRQMfrOlq1hXyMTM
         p60/65yikU+mrVlZwihrXmz1c0e4KYvJIUjRBQKPp3sL8JGQNWCW8jnGBuirhkTIEAl3
         Krl8bZToo9Ku9nZ2pSiWpkRu6qcD9L+ErQ68H9Ikj2ADJoaC94fKM28av8qTI9IFdWKe
         tAVQ8M1WQBaYS1/voQNrw8BDYMXLXspOKKLFiSu+pmONuHk/KhVCNxh/J7Ljn1/KwMQR
         paBg==
X-Forwarded-Encrypted: i=1; AJvYcCWNl4nXqTXG12euVwoZ9wR7yFhHGqb7F6xThduQ00NhHYuhN3YQiUG3m0Gu2FNEsg9qOr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDeaKVUE+gvwEYo3phPRjNcgszHot7ea8t2fQJejBsLZTeWwsZ
	8MgZGs7GrOVpHW9wwr+AvtB8V1YD0QIqwYVjpyljmRy+3xLob8t/DEiODlQRhiZNyRG5v+BTfAr
	gRG88uL6VUFpIwyp/bVoo5ZxuU6R/p24=
X-Gm-Gg: ATEYQzwmupjjA/08hWhtsWldpRgmo/t07zS5fA18k3ZcItX8x5WqZNwOxtNKjZyPKj1
	jB2l740vmQYvjfukqKN4nqsDUD/yFeqFKNRGI69ChvxJMZIOAvL1AdnHRXWeXtCUovcvuW5qaul
	nJpLszlBWBUGPbsb2Q1HcW80HQHXCvDinnT1E3it0KibdT1POGd6KyKTX7Asc/t8lITXBoHU+Lx
	vkAxXIFvSYZTo+Gz7TH9l7Ea86T9qUgEiAUjKFsgM8UzMk5kIBENxIoCMUbFwWJ957I5/omUAH/
	tTVjMHJ+Vg==
X-Received: by 2002:a2e:9595:0:b0:385:d162:bf3d with SMTP id
 38308e7fff4ca-389ff118ca3mr73372661fa.4.1772508468149; Mon, 02 Mar 2026
 19:27:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
 <CA+rGoLdTc2caDUsQedpegL+T4MqwwiA62uuDSFSawAT5vcPvWQ@mail.gmail.com>
 <CAFNBzOdCx=R3r9+m5eDyAykMAbmbcfpX3kPeEPjqXPYT-_89+g@mail.gmail.com> <B46AA932-28EF-4A2C-96B9-0F05D9641C1C@gmail.com>
In-Reply-To: <B46AA932-28EF-4A2C-96B9-0F05D9641C1C@gmail.com>
From: Ayush Jha <kumarayushjha123@gmail.com>
Date: Tue, 3 Mar 2026 08:57:38 +0530
X-Gm-Features: AaiRm52sGZ-Zs-5SzJfe4Wg_FHghDcXeI_XuP0CozNJEXceVcCWBr5Jh22iUHkY
Message-ID: <CAFNBzOeDU3BGdZjP0edvcd6OZxrP0VgN=AHSYTFseoKdMdu70g@mail.gmail.com>
Subject: Re: [PATCH 0/4] repo: add support for path-related fields
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>, git@vger.kernel.org, 
	sandals@crustytoothpaste.net, a3205153416@gmail.com, valusoutrik@gmail.com, 
	pushkarkumarsingh1970@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

I completely agree that having --all dump three variants of every path
(default, relative, absolute) would be far too noisy and defeat the
purpose of a clean metadata dump.

My thought is that the path.absolute.* and path.relative.* keys could
be treated as "virtual" or computed keys.

If a user runs --all, the command would only iterate over and print
the base keys (e.g., path.toplevel, path.git-dir). The specific format
variants would simply be hidden from the iteration list, much like how
some APIs only return expensive or highly-specific fields if they are
explicitly requested.

This way, --all stays perfectly clean and concise, but scripts that
need mixed granular control can still invoke git repo info
path.absolute.git-dir path.relative.toplevel in a single pass without
relying on global state flags.

Do you think treating them as explicit-request-only fields strikes the
right balance between a clean --all output and a stateless API?

On Mon, Mar 2, 2026 at 1:25=E2=80=AFAM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
>
>
> > Hi Lucas,
>
> Hi, Ayush!
>
> > Thanks for sharing this series =E2=80=94 moving the path formatting log=
ic into
> > path.c makes a lot of sense and avoids duplication with rev-parse.
>
> Yeah, but since git-repo-info was written as a better home for
> some features currently in git-rev-parse, now we can think in
> better solutions.
>
> > For example, something along the lines of:
> > path.toplevel
> > path.absolute.toplevel
> > path.relative.toplevel
>
> I also thought about that, but what would happen with --all?
> If --all returns both absolute and relative, then we would
> have the third solution.
