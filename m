Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A4B346774
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771441914; cv=pass; b=CyNYc7tjGB5VsXoCB1ZXAoJxeqVWzqDEHpvaEcxV/Sj1z0WHJ4SYaJvVxSxrqvRRqYx5VTFGMDSmMbnHgutUgwwZ7oFzNJfrV/BA9vGeVNel8PHOwJFb/+tqvhBWoOxP/KvbuHmJMF9BUUl8K7kVYRcZopzQu/xqgp8+n1QMNAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771441914; c=relaxed/simple;
	bh=rku4vAAKy1zJzgdMmMJDE+tQs9lwybrGVbQVYRpcI1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYIX+NZCbN6IK/ML4bHNpxvUDB1zKjje6ZHiN8AuJ6zwEc1EPIF6seANQm9RSQ+jGvcZ+eNP2DcGUankE/Y/n8goay1uZV7bymd2e/QA5Ox6xsaaqhq1R4LYmNzpENO2duJ8j9ohKSmX7vPXYE09j1c2fncawYyV84OOcDvaVUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b=ufOwj6J+; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b="ufOwj6J+"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-126ea4e9694so228874c88.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 11:11:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771441912; cv=none;
        d=google.com; s=arc-20240605;
        b=bFxEE5VpgVihdAJRH2OVkw00TNJ3Cg/swLpNgYJITIZ/muGO5Xf5j399kRhW4GtXQw
         hy2fbWlPk03HJCSVS1zAFHdDeiOCj0RbIfUXkzO/CDpYXPDmCqHxPL/RO6qFTUPsx7IC
         YoQ8xjy675eO6YInvdTC9MaL6kc9Wu6cR/EzIIbsHVKoBYvj9C+vsdgnM4HzfgahS5j5
         hkcAOagOnRRQydVW/PoZwD15JYLVEig/uhMyayvMPGSiosumh0luO/E1TK5h/0VPp8Jl
         6lDbKzo7lfEeHDfZPS5m0vH0EXGFnSXxZpIl0ukmHKKrwKNKijX/OF45gJ7ligGjk6yk
         j4YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DhummzunepqBKxkSOMuPvhvFEZgK6RYOC5P5i1aXNds=;
        fh=Fijgd4WVKvFM4OjrSehwjrj60XszmU8tP9G4VU5nYH8=;
        b=MxQHN9FK7jLsJBzACNJPk5RC2az7cNa/SL4z/K/Qn13+OBOZjCx8YkG5nOyS5oMCz0
         I6Y2k98nrwxKM+Wk60t5bfvgrlmj2WXTVv9kz0Vx18L9spa1Qq7YCk+CSl0jxnOBuDs4
         iL+G4ORjfGFV5o95OoKbnh4rujiYhhSpB35uThGqeGC6W9WSOVnp2A+IkZ6DT6loMPXg
         fLE1caXE7oCKUrSBSYheloh9iXhNr1rYhbeW7u4kd2XDAwfovV/zqNxyBeJl3Y3k4SD2
         C6TE7PofehbIAHDyb4XyTb56q00yBnY7Zoi8qrmH7MDPB5amHM8VZolAwYYgxa08FBPX
         sVYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree.net; s=google; t=1771441912; x=1772046712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhummzunepqBKxkSOMuPvhvFEZgK6RYOC5P5i1aXNds=;
        b=ufOwj6J+VGSpXXTNo/4OkkinSiAp3XK+TOqKp0Ega7WThe7Ox8nUJi1XHGKC8Jsz6D
         yatpXP4hvH3GVkFAfZacQHTKH4W1sVHaaF4mIiQ0l3PoAWg714E9GEg2T+SAyivjQ7HL
         9V6WHYWzDY6HP3VbR1VwntVxCFvYiNktWmaYRTg6lDVYShznavv/QAiTN+njluFWRd8C
         ca1lFOSB5LZ15hSZ4ylWJMWUbeRrXvV1xyT/jcssE2WeyZk7N4UWw7TVeAWnu+xOTXpR
         nzqQ/7QXLA9wqraiR6hCc4zkbEyxS88QsYfzELZp2UrSGOg6LVi8f3jtasP4X+sUgQSx
         KikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771441912; x=1772046712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DhummzunepqBKxkSOMuPvhvFEZgK6RYOC5P5i1aXNds=;
        b=fbOGrFvUaFOq0FNjb9Vt92LfkCglDUqgFvSqtOqfst2E86hFax6oKW9uE5dbUSh2jq
         uYIT9HTfOdtAGFiOzdHCRFPZATzBgzxAZs+0XxWJUnA2rIMXkjPC+O4BLkSzwJ+Qv97e
         DOhbjpnN3Suffh4VFOXa4SHY5vHMJBzAHdy1w2TduMPi5iMlUtLfw59T3nOa2OMZCqbj
         66s9MvyuSkRDvB6OP7T84XIJERM0rQGEZFKKgogddUbQg5/qN//jtqrtKf1/KU0fBump
         5osK6Kwb60Cct9mA7vbQO11IxLJlOkdJHGI5ngjE8BT/CcSFoVjPxdigHFoVFTNJ+W9T
         J9fg==
X-Forwarded-Encrypted: i=1; AJvYcCVjtLeyKxM4dh1amsFZe4889LqpvGTnbYDWdyGJcxsIPkKgYG2IuoxqB1kfsIqJbP9CUf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQNQjnVBtPuWFVarEvkiczYLbYLvrs06gtCtiPoXoKe0zPVGVr
	fvpcHkPi4f7A/sC8FPCax8IdkDbra2OX3aLJLpgr36LbvVMHjHqyC+boJJ+hD0mOvt3/f3x5PR2
	ka5jv9v2i/RrLGnnbpUcjC7Brf7xBmb0f3MgeijQZQ3BxXvs5/YVbBkjAQ9vCrBhEsOQ6vJ/tw1
	3N4sxZXXnkylflR/auUZIEc+wD9L39rrvnV+u1S9nsDiE9EaMz3XX9ef1h1FEoXgVMg5OzppE0Q
	Xyou+2OPuhQ5Hy2vrmlEcUFHiIHZbBWsDfM4WHJRD2bhAvadnX4HybhDVHuh6Zy+Op9zkX95lWt
	M8BvvCiBkcL6GDE=
X-Gm-Gg: AZuq6aJl6IGxWrRtd8cX0PqI+vHmik2wcHMSssY9OOOR/FUGaBVV20x8jOzdQjsq4Dw
	ODOkghHSBWUx260FAwP/ThokpSOH6X95crk9QODFgrMiXur5EWgfFJLHsikjrXNMEnIQ3wH6ogK
	h3FI1PBA1i7rPCPnOrYI0/KUBhD/+BaK5pfvOubmmL1Qcu8nXBhchPvquPKjqfujOQhVsuVWX6k
	Dk+iQoxCxJDuZwKfSnxfGa9/bpA7IWvUqazwgYb1xMB/CeJnN8Uhb5aaOUKC7a4ZmX/m8WsbrF1
	JRR1b+TTHsewk5aGUgY=
X-Received: by 2002:a05:7022:458f:b0:11b:9b9f:426b with SMTP id
 a92af1059eb24-1273addfcaamr8365343c88.20.1771441911681; Wed, 18 Feb 2026
 11:11:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2046.v2.git.1770775169908.gitgitgadget@gmail.com>
 <pull.2046.v3.git.1771391650713.gitgitgadget@gmail.com> <11a91368-7dc8-4081-bd13-d208126beb7b@app.fastmail.com>
In-Reply-To: <11a91368-7dc8-4081-bd13-d208126beb7b@app.fastmail.com>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Thu, 19 Feb 2026 04:11:40 +0900
X-Gm-Features: AaiRm52R7tyw9sd8g6d-aiSfNrLAhg9L4QrUqw_Kr_Ws-7uJ3bpEhYZ9I1xGAj4
Message-ID: <CAOTNsDyVqooYkSXv3U-SwAqiSqTnwDCOXpRr9AZjgbv5P=dbqw@mail.gmail.com>
Subject: Re: [PATCH v3] osxkeychain: define build targets in the top-level Makefile.
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 1:10=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Wed, Feb 18, 2026, at 06:14, Koji Nakamaru via GitGitGadget wrote:
> > From: Koji Nakamaru <koji.nakamaru@gree.net>
> >
> > The fix for git-credential-osxkeychain in 4580bcd235 (osxkeychain: avoi=
d
> > incorrectly skipping store operation) introduced linkage with libgit.a,
>
> Nitpick: Commit references should have the date:
>
>     4580bcd235 (osxkeychain: avoid incorrectly skipping store operation, =
2025-11-14)
>
> Like the rest of the commits you reference here.
>
> > and its Makefile was adjusted accordingly. However, the build fails as
> > of 864f55e190 because several macOS-specific refinements were applied t=
o
> > the top-level Makefile and config.mak.uname, such as:
> >
> >   - 363837afe7 (macOS: make Homebrew use configurable, 2025-12-24)
> >   - cee341e9dd (macOS: use iconv from Homebrew if needed and present,
> >     2025-12-24)
> >   - d281241518 (utf8.c: enable workaround for iconv under macOS 14/15,
> >     2026-01-12)
> >[snip]

I see. I'll fix the commit message in the next reroll.

--
Koji Nakamaru
