Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8DD1991A4
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 21:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737407718; cv=none; b=OIRVdACpep/5zByE9Gpe+UanXg8N6J1oxjdzxtaXiABsqSlXBE0jeuiKOqmWh9flSi2zqssHMEzPCLpTWBCu/UUUbt5cx38NSvI65h+0xoPvh95jnrS8utieglhMvjokS1WNBUPF/1i312Phd4xFMuek6u+Uh0q7pma32pEp3Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737407718; c=relaxed/simple;
	bh=p/CQKjB3o2DSgAi1zEbnwbKNmQHYMLBuKfVdTp2elDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=BtEyXkwM5KsvU4XBWtj4AULSZiFMOa5aoqP3wWi5EzDMPpBGOiPR/3tjoVrfDnDWryR60M/1XIU8UBMHPRzV0ckZ/AH1wYkQu3jr1vbfy6QJDGKdKy255tfB3b1E6KzcyBh9h8GNfvrqsuzN5G1jAOQHnGND7+1fYIqbZVj71Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqINs6pv; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqINs6pv"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso832070666b.1
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 13:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737407715; x=1738012515; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiHxX04CG4/4KlVzY4mHosJsKrFmd4MaDeiY2xstmE0=;
        b=kqINs6pv+HSgKpZdUnWYzJpGcMnIJIVJzbejugT8KOPXO0JgKfRr8VCZlv/TbUEiDu
         dqYOhzonHxE5ZPX/jtcrqLyP72qI0yUVzOIML4YJtSNkDEivnQuj0ubvYGxwBOwkb2rL
         bWao51kW9NsgfsNE1FxEd7LRIbsiQ8bNKtL2H0lEdnVyTY4rTbBkRv9+JqvBDw/ynxJF
         JDvNc8UkMh7OzVvGVhprV9EUdaZUVw/StJ7OJOJzsCNgfxRcfBuhM2eZtw4wGQ+2tfe+
         sbyDmmbIMW3vrbJCdAmX5BKHtYX6yqctja9uWWiDT2Ay5xPtqhqbqKmqGeQkmJjGVsVH
         5lnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737407715; x=1738012515;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiHxX04CG4/4KlVzY4mHosJsKrFmd4MaDeiY2xstmE0=;
        b=CTvrFVmT4hVLB3NUBu+G5p4/EqOyhB7J4CTPO6Itn6HAL2WbbwjAiJSNCdo2NA0i3D
         uaO2UVrbnpiDH3wEWlerJW5UjV0TgVLuGlpSxIhXFOgkNJUVvIrWA6+Ux8Twx7eRUHdp
         oWmhD/UIP11FBfd59xH7YJDXKLPXnnCyTqcR7CDOErMM0HPKJ8YPPNFZM4id4cUnTk1b
         N96xRlm1y7hx4+7fO1OE3ma6hmSQkLm6icdcv613YYeTfkmMnSCakxV/EQzhnGi+kLJW
         Bm6PkPVmS9FOPgU1jFwdAoV2K04BsBBDM2EU8B6tW/sFyK/t/e5TDWaDqH07s64i5k/G
         HoHg==
X-Forwarded-Encrypted: i=1; AJvYcCW5nh5lzVoIA8Kblks+2gqmSL66tSXNQWbJewfeLneMynJtfG1VIGbVIVwaosoa0EhapBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP9nfPDTI5fELbhwjoXacJuwSljnyhVVGu/jbzPOY4QhGhj0DR
	gQzVAQnUsSY0IC7/K9I6pIRUCDsfALGxj6WA8gMHGEdEZ89g0mCzh7SFj6HG1XC5d0gEbKde9CT
	zcN8gBpUnehTESWYMZW6IQzxFGB4=
X-Gm-Gg: ASbGncv+N5QUR2ZxoVdJtmqYNSCA8gn/jLG6ba/ECn9LYmOGgY52nq7nAOVAwkGsGf+
	vOYVTddWCOdrSvMnObekkxiKzlNNcyXxBfK+33RQzFQgjMaz3ES0=
X-Google-Smtp-Source: AGHT+IFNIEthWU0uHAc+bAbVavsp+Ac/d47rakYUHeB/OCj3mK6QbUuW/VN7QccQi/GVAXR0Pd78K68eP17+EXVuYnw=
X-Received: by 2002:a17:907:728c:b0:ab2:d96d:6362 with SMTP id
 a640c23a62f3a-ab38b0b7f16mr1578906666b.1.1737407714838; Mon, 20 Jan 2025
 13:15:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAODtcdcTjquNUBaTWKzyy54J5NoH7WO+9uMzJ+wWRDf0Na3OPA@mail.gmail.com>
 <Z40mlmfnUOXI2ghd@tapette.crustytoothpaste.net> <CAODtcdf-+QpPpB5R-hLkKWKacwM=N3=XRDs-tK60W9WzUJu7xw@mail.gmail.com>
 <CAODtcdfS+TVmrwohtHFUXRZRwC1WmF5ENpZLVoZTyJgA--SC-Q@mail.gmail.com> <Z42nq54yuWqiU4t6@tapette.crustytoothpaste.net>
In-Reply-To: <Z42nq54yuWqiU4t6@tapette.crustytoothpaste.net>
From: Al Grant <bigal.nz@gmail.com>
Date: Tue, 21 Jan 2025 10:15:02 +1300
X-Gm-Features: AbW1kvYDDiAfxelDR88YNFbwuWgEZZLWn5ZYs6VIGoqN7qhy084u5VXQ_qfWK_0
Message-ID: <CAODtcdfK2s0SP1dfTbic=pPbsdui4hudeUk2RXiLNLQe35UrDQ@mail.gmail.com>
Subject: Re: Rebase
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Al Grant <bigal.nz@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the explanation.

I think in this case, what happened was I created the branch without
doing a git push - and so local and remote were not in sync. when I
created the feature branch.

Then when I went to put the feature branch on to main it complained
about the merge because two lines on main were different.

Does that make any sense?

Regards,

Al

On Mon, Jan 20, 2025 at 2:32=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-01-19 at 20:39:13, Al Grant wrote:
> > Yes. But I'm keen to understand how to deal with a merge conflict.
> >
> > My IDE is VSCode and when I run the merge I get this image:
> >
> > https://imgur.com/a/vynTxaj
> >
> > Which highlights this code:
> >
> > 255: <<<<<<< HEAD
> > 256:        samples =3D signal.convolve(samples, [1]*189, 'same')/189
> > 257:
> > 258:        #for testing - log to file
> > 259:        #self.f.write(samples.astype(np.float32).tobytes())
> > 260:
> > 261:=3D=3D=3D=3D=3D=3D=3D
> > 262:        samples =3D signal.convolve(samples, [1] * 10, "same") / 18=
9
> > 263:
> > 264:        # for testing - log to file
> > 265:        # self.f.write(samples.astype(np.float32).tobytes())
> > 266:
> > 267:>>>>>>> 1f893dc (Make project runnable on Linux)
> >
> > Now I would assume that samples =3D .... from ln 256 abd 262 are the
> > differences between MAIN and FEATURE?
> >
> > But when I search main (at least I think its main - my IDE doesnt tell
> > me mid rebase process) for ` samples =3D signal.convolve(samples,
> > [1]*189, 'same')/189` AND `samples =3D signal.convolve(samples, [1] *
> > 10, "same") / 189` - those lines do not exists anywhere in MAIN???
> >
> > So what is going on????
>
> First, I recommend that you set the `merge.conflictStyle` setting to
> `diff3` so that you get the contents of the merge base as well.  That
> can be illustrative when you have conflicts.
>
> It's important to note that a rebase involves replaying individual
> commits from one branch on top of another, usually using a merge
> algorithm.  That means that it isn't necessarily the case during a
> rebase that one side is the complete base branch, but rather one side is
> the base branch _with all of the previous commits you've rebased on top
> of it_.
>
> So if you have this:
>
>  A - B - C - D - E - F (main)
>      \
>       - G - H - I - J (feature)
>
> and you rebase `feature` on to `main`, you're going to replay G, H, I,
> and J (in that order) on top of F.  So it might not be that the code
> exists in `main`, but that it comes from one of those intermediate
> commits.
>
> In this case, the conflict should be trivial to fix up in that the code
> appears (at least to a first glance) to be logically equivalent.  I
> would personally resolve this conflict in favour of the version with a
> little more whitespace, since that seems nicer to read.
> --
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA



--=20
"Beat it punk!"
- Clint Eastwood
