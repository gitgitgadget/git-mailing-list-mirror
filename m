Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D69533BBAF
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 12:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266339; cv=pass; b=fcoq3ZGlP9y3FNPWzgE9T55nYV/vo49jnYoqH6o/l6OD/Yfwu2gsr5y3mPTU5VVuakbj/g/aoJl1oqENq5Uc/6lJKQuvBFoxwyY3jdGqABZLOIrOosf3mmVrjIWUaaOmJzcKzIhSjxg3mcZb7GjBVpD2aYEd+h7fCUVeBKCSFds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266339; c=relaxed/simple;
	bh=oKB8Qw/V0HlJ8vE4VR9kjmcZvKfQsCxn2L3vTUYFm4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtpIit+iXp/4flHO4lO1Tv4S/Fyg+BVKGdXo4sa+NTPnA6tH+OFHpX/n7YTxAObxaT+Z4IVRXohZudwODTFpPxU/vy3guQ017nTB+pKGbGZEhxsCb6ElEGONN2Z71mtSm/WGJ6VDKq0PFJ8K3ln27zRBBbPLxLNYMr1NyY52uXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rRUDVN0J; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRUDVN0J"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc891373e0so42412955ad.2
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 05:38:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788266337; cv=none;
        d=google.com; s=arc-20260327;
        b=Tc78n74Y669U/4Lj157zLpHCHBiGHwZPpVZ1Xcj1Ao7//A/v+N6Fwnc/7ADaic9QCr
         c+4ZuMguR4Tg3AhBH9kMuppzelH2zWRfiVyvSoljp4G2EN0AQMQtaJN/MTXOr7mOsw/o
         9WRU2yn++eVG+GqrV1ijL1gxlEOzkL+XosHp6teTbftEpdDA2UMA2tDZJHNkiSQWD/TI
         YQeDNnu09p1qQgxhXdBt1BPD8DSIEJY9Yhcey18fyHRQccvdNx2iHdrdQUpLj6FQURrD
         Iw6U3WAgWGy5SRDX0ZqcXVeBe9Iebia92dyWUuUk6hzvXwwDkf3IoYPgUTGIXygPUiKW
         iDWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kBD1VXTcx3INIlD12hw73HSc8PdqDsF03C4cZ8o4ImU=;
        fh=0wEIVxwMkGK9gE6nlUa4xTpVJdSIAZp+rIkXZBN922M=;
        b=F+3868u5Gi42p+pTwQNs3+dwCWrdUFUUCjkrAXKAUOM2TMvsGQdDuVSHZKwkrlL9GM
         2bmXoVr6S0YsbkvKwh9Dex8fqFuJrPLIySbPwDetc1K3uOfeTHOfpeZyyMRZmrhyEVwc
         7TJpVZW19j6UEG2S5amzd4gE/Rq27OJpNXhzgxmsTbx2qrFlDohTyjVqsgrwxRQz7Cwv
         b9zwzn6l1f5lscTpTrytXMRmi9nT2SyxU3FlA3OSD+MQNiFiUJEeTJIXoqs8uIngxLdF
         Vrv0WZzWZRJ5E4cwJCfCA3S4ZXY9eCocZdAGnKE4pZiSi7kKCddAdEzGzvQtTxloSrCd
         fzvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788266337; x=1788871137; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kBD1VXTcx3INIlD12hw73HSc8PdqDsF03C4cZ8o4ImU=;
        b=rRUDVN0J8Dki3woDqYUTX6KM2pM89CedgerP1XFOH2m8CaE6E98eOuS/PS65ExX7vX
         yWAV5kZjS6bLSRFfBUREWuV94+XGwNMbV/8LGBSEIPIjxMxPTaOPbjJXfIecnVsCcFmb
         3vKV4VB610MrIEE1xpfwLv4XIbXLiYQbIl0B4aXjgYmk9X3BvQQugIzQszxLHVQvJWB5
         Gicp72hoXPZLtxlV2Ubotp5F6Itvo9KAVD3dhcExArYM8ZiWCWfXw1e2s72XjKQBiNpz
         sgSB17zT7E9AIId/SCn4tZR3GgzU5R6DfOS7qdzdCLlOFkgJaXFpluwNOevqKtTxFaeE
         YWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788266337; x=1788871137;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kBD1VXTcx3INIlD12hw73HSc8PdqDsF03C4cZ8o4ImU=;
        b=jLqdbL/G7neE9FS/MR/dDU6cvtvEQZkEstgHQwb7SDIPDr6/9+I4CI8Xaz6xiMWHDP
         dB3ITLW1QEc2RUP9dRCOWffJYFa91mXJV3kPFg+bwFujYJABhiuT9p0XNAbNX7l88daQ
         nT078JtZL8LECwFQFZQw0RP/f712hZ3sR3517D394ezMPsQTrir0NZOqUgyiqVFD3fzt
         pn1vuK5YOSh/t4aLTjp1K/x2GfyyIjpeRJsujk2l/TUKyx2VqblHWzEM7fb/BgOwtYcx
         5vaEF3LsuYqNEZTXASb42cRu+nHmn4AMODXfsaGnQDrg/qjicyiTzA2+Y6qCAx4btOhl
         37HA==
X-Gm-Message-State: AFuF++nSqSSyhuNW1RungYWQLoRxayt5KNmqUP7z5CgP0TdeNGnIXaxv
	P7qlUdzZyRZH7Zw5Dwyzd3wUXWanUVL2esqpzPsjJGfNJLp2+p2/lDcZ09a44VYSv14DKniZkr+
	hap/Gas7ARKPlsgR5ZvSZgCKOpKPTHic=
X-Gm-Gg: AYBFou32nb3e9bzJcwAoOaZgGZL74Q7xf1ZJ5psfkuGlDxmKKkFxZVnrrczuap1x3yS
	0He09ZBjSH74W4UmTs5QC7JDnE/RrtNj/V6J5j10D+tk052RHyjLhfa8ZQjYXidpydwHbC1uHZO
	j/5+jtYwfDa9hxpY0XRB89NNn4QFly7u9O3CEBBtXuZMzqbtIDpzTOwXsJQzwqaDh9mJtxVghtC
	z3dLtqbBUIJOD/nXD+AQGtloGjRc22qHCBGX8zbH+LyAtfetXbXrLr8YWYOSnzWie3qEmvqYhIF
	9s6yggSryDNlhAtZ6sdP9lhjOmVZhkMcsy7RPuzggU13MQ3UJBB+wKnOujeVV1sXoVUtLyGCgYI
	7/EfsYSJ0iHVrmGHBnAVWsGBmAmXKJj2yhjL4E92iG0L1kGVYACEFvoXKX3+zptqHSib/dJVB
X-Received: by 2002:a17:903:354b:b0:2d9:49b3:abac with SMTP id
 d9443c01a7336-2d949b3ac16mr127563105ad.18.1788266337449; Tue, 01 Sep 2026
 05:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787231825.git.ben.knoble@gmail.com> <cover.1788206466.git.ben.knoble@gmail.com>
 <0a611f614041b165140da7f2546c058178cdbfce.1788206466.git.ben.knoble@gmail.com>
 <xmqq4ig9vbb8.fsf@gitster.g>
In-Reply-To: <xmqq4ig9vbb8.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 1 Sep 2026 08:38:45 -0400
X-Gm-Features: AcwNN1WC0UhkWDg3Q8HEhZWZVRfisANouZJZJeiFfmm11T1EC9KgrFMMtu9F6GQ
Message-ID: <CALnO6CBKWpmTZW+Z74JsTQvr864vFsvwvRJeKAu3LfXZJK-1Yg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] core: convert build-time USE_NSEC into runtime core.useNanosec
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Todd Zullinger <tmz@pobox.com>, 
	Olamide Caleb Bello <belkid98@gmail.com>, Tian Yuchen <cat@malon.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 12:35=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> > +core.useNanosec::
> > +     If true, use nanosecond precision for ctime and mtime
> > +     comparisions between the index and the working tree (if Git
>
> comparisions?
>
> > +     was compiled to respect this option).
> > +     This is unsafe on some platforms;
> > +     see link:technical/racy-git.html[Racy Git]. False by default.

Ouch, good eyes. Obviously should be "comparisons"---I've amended
locally but will hold onto the new version for a bit.

As this topic is not in next yet, I presume that sending a new version
with the typofix is the correct thing to do. I'll wait a while today
to see if any other comments trickle in.

--=20
D. Ben Knoble
