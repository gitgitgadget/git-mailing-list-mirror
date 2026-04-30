Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD9E2BDC0F
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777540221; cv=pass; b=Uc2U+4xtizkc7u2sP2QwlP5TmHC/jxA3qOiQbfQulsf3mvEs76Qs3Uf9OMdahzwPdRlnQMFX6KjVL30UeCpp4ujWG0A3hzltU/urh3bTIWJL8I/3V9HLBwUOiuo1wfSVQlDU8ntIfRkwFgWylZzgRuZ/O1h13DIpa9xvXqT8nM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777540221; c=relaxed/simple;
	bh=lRhu5HPeh5pX9FvBlV7QgPpbOf4LQsLII2u5XlbIFfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cKmtq+MinSB6mfeTzP6C957jLjV6TlSQrjwWCX5RfC/axK8EtxbJ9xejN1Ra/yQBAie3gRI+520sRoBLyzM1T0TYdbc2fO3ZYFuZSRI1JaNQab20umC7BeJ0oH2UPfu4qqEEXney8jzPyHqCrcLDlDV9apMl2yDdFW3/zmYWn24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joJRkw1/; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joJRkw1/"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9c01854477so94649166b.0
        for <git@vger.kernel.org>; Thu, 30 Apr 2026 02:10:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777540218; cv=none;
        d=google.com; s=arc-20240605;
        b=dLDXvOyUknvGlxE6l9J0e8RHH5/BX7GAbatYM1bmhff8OMPCgshF5ofYWXokUEjT9F
         d3G6tFwxXsvfSG9a3PN8iTNQmPJAOs1Ri0MV5xxOUAslDqP4fredTQovy5cb9ruZjjSw
         JP+iyehtjz0Qzd3g/mfxLLzqCkptT9k3FZl8iTFhj6f5qEs6nsU/+WLSck8zBsZpsY32
         EZ2XHiLOyPOBeoIgptpuL9wGimlAOjJ+uRzejNLlFb77NUAexGeCsBeKTL3I6oPaF4S7
         eamBUPTDk//v2onB52eK/gx0zyh/dkNkKh9aLvU5EkGlfEeYIELSM+KB8nVYlMKvKaqY
         I+vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1V75YAvR5UaeHBUfAMVYROHEKLZLAXE9IonVhu49WhA=;
        fh=OZSnGcTC8SIn8kbcZd8ZMI8+piuQJHkvIUyYJ/suMnc=;
        b=KtlkXUDZA5J5DXtk0U2N2d/ZvUU1GY7P8RtXs7KkRoZKtH5CdoB7RY5RnBCjqaAEUH
         gN1gooqAuIjtXj8hmW9CptGxcipRF3cW9hYQaAjXxveCKfJfOWX/GriRaNeQMhpi3IYs
         a99WyTegdGTs5FVe4fxLzEsBZBeEUYzCx9QrhMqdwJpwUilqnFFfjD2t3je5XLcm6mc8
         O6oPcphlFbEaHEyhtm/ZuqG98bw8NXsbz6gTv2+5Hj6c79Wnsxe3+1s2iSeOD4Rn3hOM
         6Q0SF9VxpIG93uFRvY+WUUgS1mdXePJCZLs4l+873SDQa0oeBA4ebo3LBtoppdvhdByF
         A7vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777540218; x=1778145018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1V75YAvR5UaeHBUfAMVYROHEKLZLAXE9IonVhu49WhA=;
        b=joJRkw1/I7UGbPt/RkYzLAmWdl500klVeP15z6EyGplpiicYWzLsWiZOHtoruu5kGS
         j6dltfAzsJLD7vX/4Bm1bGKvJfXpuciGClcBs8HK4k7I/m9Wc++btR3ap8/2PJoMKKBw
         1/Ft8D4XejXytQq7zYqJjffX97IeswQhGc0x3NW9e6KfFtgYsoc9GuatfpgXFTNN94j7
         Ud/Sh9XQnIOGfGaNDUjCxiuGRU/CVMitSPW/hOY9T94kunrsirKf3b0xo8gPX4p7Vejl
         6R3OM0SnLkMK6k+oTm+AyvZlO8JHSnjOX3yW3P8ZmYkTCEXSYxVmzcXJ2Thj95W3kP3g
         472g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777540218; x=1778145018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1V75YAvR5UaeHBUfAMVYROHEKLZLAXE9IonVhu49WhA=;
        b=rXKTzYcnsA87xkun3EuVMa+8r3fKL3eDGRyusSxWYM0pRr1ozMV64BCv8udhhGkKmq
         eVRqU133ZFEOV/1i6qjSmLa+ynNuHcGxaRwh3BMlEkCldqHK+kbPrfQRa4jK1cWAVykm
         xQT6J7lj8u6Dk+JMJ3dlJbdBO1ZD6Rr2ij7DhSm9ZckQmxnG0om/lnbxy2qnrNWUj2ml
         YJv6E/4dAHfySNxY4TAZK/p/KccwgnzFVqoGouKs612LtUrpHltTPPgjzm6Yhzqpz8Ms
         5NufSrikxTyzxQSpK5BaIDRXFVVSusNufgIKXvj0GGOPl93QVIwTJMbFSBoZz7+BfOzl
         1t5w==
X-Forwarded-Encrypted: i=1; AFNElJ9QW6KnR1rlslREJzOg5fOUSgHa4BzW5asKQinqPTWWdZ3IVA9WiSLS6mA50gvx64p07U4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIgj+dbE4SgCN0IHRrBz3vt0QFwxtZ2S49QH4BCEbaYrY0b75t
	oPQljZYQ2xbjvzBuJvHIQ8rbmJWnu3MRlczYG/AASQDM1KMTJjdqXYWjyXxEi2lO4QnbhgAaosD
	lDw8Yyb88KzB0d5lv2G9PwTLxG+t4lmB68A==
X-Gm-Gg: AeBDiet/ZFhqPwHG85s+rxViSNLcXuf7Q03EwKmgJPa+8k3zx865kz+eAF+i2XiAWYw
	oZR+aann3ZSQ/GOLBTd5HlQzQ3fu1d0zYHtnibh6VyL3XZfMQgLSf4rg+St0xmBwo6CaSiV1h0+
	CjGxOAcxmCNygPt9Psas7k0bbn7bxB9FrG96H4CqZ4DqTqgG+kZKDK31mHCShQYz2eIq85fyj8z
	xtiTFJws+/jh9iMtoaJaqQvDDYNizy1M9mGzpvv3GbDh6zWmn+//A7L4VArfbt2chSenGXONZk6
	KsKZU48L/8h1eCB1
X-Received: by 2002:a17:907:6ea9:b0:ba7:4cd9:ca12 with SMTP id
 a640c23a62f3a-bbb69330e97mr104235366b.13.1777540218010; Thu, 30 Apr 2026
 02:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANOh7gEEw+6146NN3JV8EYxQarj0KkyA7r3RZ6v-DxeqQZLrCA@mail.gmail.com>
 <CALnO6CBzd0coeyJ9B+EkGWsSNEVTdVLvcVmEraGNxnUm5wXy=g@mail.gmail.com>
In-Reply-To: <CALnO6CBzd0coeyJ9B+EkGWsSNEVTdVLvcVmEraGNxnUm5wXy=g@mail.gmail.com>
From: Mikael Magnusson <mikachu@gmail.com>
Date: Thu, 30 Apr 2026 11:10:05 +0200
X-Gm-Features: AVHnY4IvQYsz0KkUucEeuKOWJ2aMhBAzgSD17s1q6_ljyKTW6HOs8nJV9yoGZzo
Message-ID: <CAHYJk3QZDYv+393ptB9FGuYwSmYKmqw6mWd+fn1bgost-5Ayqg@mail.gmail.com>
Subject: Re: [Bug] fetch --deepen truncates history in v2.54.0
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Owen Stephens <owen@owenstephens.co.uk>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 3:23=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> On Wed, Apr 29, 2026 at 7:27=E2=80=AFAM Owen Stephens <owen@owenstephens.=
co.uk> wrote:
> >
> > > What did you do before the bug happened? (Steps to reproduce your iss=
ue)
> >
> > Repeatedy called `git fetch --deepen 2` inside a shallow repo that was =
a
> > file:// clone of another repo. Once all commits had been fetched, a sub=
sequent
> > `fetch --deepen` appears to "reset" the repo back to being shallow with=
 a depth
> > of 2. A reproduction script is included below. This issue appears to ha=
ve been
> > introduced in v2.54.0.
> >
> > > What did you expect to happen? (Expected behavior)
> >
> > I expected `git fetch --deepen` in a non-shallow repo with no upstream =
commits
> > to be a no-op.
>
> Here's the relevant part of git-fetch(1):
>
>        --depth=3D<depth>
>            Limit fetching to the specified number of commits from the tip=
 of
>            each remote branch history. If fetching to a shallow repositor=
y
>            created by git clone with --depth=3D<depth> option (see git-cl=
one(1)),
>            deepen or shorten the history to the specified number of commi=
ts.
>            Tags for the deepened commits are not fetched.
>
>        --deepen=3D<depth>
>            Similar to --depth, except it specifies the number of commits =
from
>            the current shallow boundary instead of from the tip of each r=
emote
>            branch history.
>
> I can see how one might read this as implying that when fetching in a
> non-shallow repository, there's no effect, but I don't think the text
> explicitly says that. In fact, the first sentence under "--depth"
> (which is of course relevant for "--deepen") is unconditional.

One would assume that this 'shallow boundary' on a non-shallow
repository would be the *start* of the history, not the current tip,
and thus it would be a no-op. Especially if you consider the position
of this 'shallow boundary' throughout the process.
consider the repo
A-B-C-D-E
you have a shallow repo with
A-B*
where * marks the shallow boundary, after another fetch --deepen=3D2 we get
A-B-C-D*
and then
A-B-C-D-E*
you're proposing that it's reasonable that this should instead be
*A-B-C-D-E
such that another fetch gives us
A-B*

> So I'm not sure it should be a no-op.

I think it's pretty obvious that it should be.

> That said, it is possible the behavior changed between 2.53 and 2.54?
> I haven't tried to reproduce or bisect yet.

The mail you're replying to already answers this question.

--=20
Mikael Magnusson
