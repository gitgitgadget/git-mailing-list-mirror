Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512D724C68B
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 21:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755639900; cv=none; b=TPOyO7zZxr5SgmWCXrg/pOjP2IsexSdhq8llUbBNtHStGVaFImguHEUpe9lb/kLEdOaRizkJpVACPcrQKlROiV5rFzYM6w5PMHTDGxNYeNWKaL3VK+675DvOVVLKLkofPSXVg+pYoo2g5vSzmyU6oSKXy0m3lS0jkS87s6jC+eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755639900; c=relaxed/simple;
	bh=8NeRCTJqEFllOYyZNM7UFwRpvA0DqQzNgQNsieVObwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BGOZ76JarHDUjdKotIPsVHIOzjpdc0y/R8LfGKN+Pp3E6p2Lew/ygHZ7cEAvWkbhTkdEhYYP9cEXLHD+4SLm2/pqrnUwedcI72iOhHtvT2oQKWzEHkMkppHhmzWP5zojx2fR0trr+gRkxgjjQwqcawzfx1Kxj9DWTbKGLZtvDzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqxeCXui; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqxeCXui"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb78da8a7so935277066b.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2025 14:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755639895; x=1756244695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23v33muqUGusrOWC7rB7QCW98x6JJB2sMkOLzp6OSa0=;
        b=UqxeCXui7x99HVAui5YYfBlHEc4Te3CVqFUq5LwDol/IkJwElSisHyCLqhTRe7TjWC
         N+0XQx37g+BXntEjN0Q7v34cOzyNf8n8yb4dfFz986GGvHkJbyb889mlLws6pi7eBPce
         8+e/jpEk/LaYxp7gjV0jx1VRyjnkcXxV2KaINTmkYTwqfnfIdTjO53lv8DK+DPdvcHlK
         EuGxq/ze8nFOOUi9X3Hwv0xDW7IuGM6bUMdN/1657ouPvd4ZBvLHaMCPCEnTWi1Mfjpk
         GXZfH55/ElZ8gQWCtP2g3FEfe/o/wWGQySvYywPpYcVYgTZkffG3qXyq531fow24A519
         GRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755639895; x=1756244695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23v33muqUGusrOWC7rB7QCW98x6JJB2sMkOLzp6OSa0=;
        b=jvG2inrCuMhcPKcBLD0mkymtDXKcQNUi7WVEfQDwHmZqN0xKUS4IvRjXS2nvk+CwLJ
         o+Gk3fe1vHSf3UvtBn1hbs/7UTuX7Ua2y2gBdp4hvf96BcP6Xi8x+riErnQjWmPERZWX
         Iy3AJhT1BVRgV4bee60PoD4tuaFWp4b5aYnZmRzkxY+OdlLumN4wp8pc4hSOPIOFa3Gy
         mZv3buj7PzNzoee24NKyv/vwrMxGV7qBns8rGqPy76vYdrPIsqrC4EEa4Eq33KooqQ04
         Mmi88cDDLFSnW85+UmojiOLWZDnXFV+21OF5YdFrXq4WaR5mRaYzmgK/KTY/VI7bPrwd
         73Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUt+3FVY4Pma7JLSWcd+XspKw1d/K2ycxw36cV0GAWCP5kPWAX4AofTFLw3Mp+lT2UwHL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBuuh/gf4rI0OrpSYea3YOSBV4alPm9te9icYGR3sNkVi3+UMf
	GiDssi8QsWI7h0I7a+2Mw+iVVZytgbhQoz0mopQutbextStwM06QY1I79JbVBCNfgIti1Z9wXUZ
	DBeXGPPkUN3X87omlGDrgVHxwp19t6K4=
X-Gm-Gg: ASbGncu8zURAlWPwpZpMlJDwTXIwEis5fOJImPd1INmFUuaL5GXr9+nQKBJ0aYmGGHT
	xMlinWoLZEDvOgBG112mOxBYDA/zVS0/hQ2wzeqsyZeShSuNdRhKUMrRAAoOoXfVwV80nXjAt0F
	z82Awmglw9ISfRB1se8psBU5cClmjODIJNrcKuVmJgN3wtRlEWJOe5RwliJDb4QKhnFkndg+PI6
	QAhajH2C9WPqkPY8HPxIBspp8KdY4LzRzjo5sgoTqpjNQaSC8Cb
X-Google-Smtp-Source: AGHT+IGsyJI2nh4j0GF4nruBhLfU0m44KVK3UwSlgILXmUjA0xZ+mDhLAI+qW0Kz2h3Ea2OKCLY22GcHM2AJHXnHR14=
X-Received: by 2002:a17:906:9fd0:b0:aec:64bf:a393 with SMTP id
 a640c23a62f3a-afdf01c5451mr31207766b.38.1755639895490; Tue, 19 Aug 2025
 14:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
 <pull.1952.v3.git.1755636370.gitgitgadget@gmail.com> <c44beea485f0f2feaf460e2ac87fdd5608d63cf0.1755636370.git.gitgitgadget@gmail.com>
 <011b01dc114d$201c45b0$6054d110$@nexbridge.com> <xmqqfrdnc7s2.fsf@gitster.g>
In-Reply-To: <xmqqfrdnc7s2.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 19 Aug 2025 17:44:44 -0400
X-Gm-Features: Ac12FXw0wZWUrGWbOK4YASwQIqPG0EZKr70gK_UMU_dv4vQraX8hBRKGgoaSeCI
Message-ID: <CALnO6CDh1PYb40UxPWj=HZgrQh6tj-PgzVqzi2eMimQrn-Ajxg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] Git 2.51
To: Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, 
	Junio C Hamano via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Chris Torek <chris.torek@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 5:37=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> <rsbecker@nexbridge.com> writes:
>
> > On August 19, 2025 4:46 PM, Junio C Hamano wrote:
> >>Signed-off-by: Junio C Hamano <gitster@pobox.com>
> >>---
> >> GIT-VERSION-GEN | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >>diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN index
> >>be801415bddc..64cbc5833536 100755
> >>--- a/GIT-VERSION-GEN
> >>+++ b/GIT-VERSION-GEN
> >>@@ -1,6 +1,6 @@
> >> #!/bin/sh
> >>
> >>-DEF_VER=3Dv2.51.0-rc2
> >>+DEF_VER=3Dv2.51.0
> >>
> >> LF=3D'
> >> '
> >
> > Will this cause a re-roll of the git 2.51.0 release?
>
> I don't know.  This is not something I did.

I also don't see any such PRs at GitGitGadget:
https://github.com/gitgitgadget/git/pulls?q=3D2.51.0

But when triple-checking the lore archive, I realized that I think
this is a result of Julia's PR getting rebased on top of 2.51.0?
https://github.com/gitgitgadget/git/pull/1952/commits

Perhaps Julia didn't use `--keep-base`, which I often forget to do
when rebasing for contribution to Git (it's common in my other
projects to omit it when working on the next version of a series).
Indeed, fetching the published branch shows it's sitting on top of the
v2.51.0 tag.

--=20
D. Ben Knoble
