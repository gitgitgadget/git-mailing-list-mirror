Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9037138E8A7
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532640; cv=pass; b=RekfVg7EQeg3IJSRJbdtqVQhg0N9tUMNWEe8X/TWmrQ4xhLGmvJE7OAqaqgMGP6iCxr6z2oipKwdOoOT27Is4uPZIggoKkdohRWRxuWl1MEiXLH5Dy9hQDp6LzjQEWUx4KJTHhaLQut9xCfw1qRoRddxn5tJJbExGkZkuuj0sAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532640; c=relaxed/simple;
	bh=oa+CNZKhNFcw51wrr/WVtxxkv2PAqjCRPMxXzR+43mM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKFUesLFg4H+e6a/THgeVbo1Sn7E2vaQbbJ6YnvtLrgJV6KGrfgdvLW8grQpzcsu+o+KFVm2DGhs+ct/xCHuvjRlmUv+a77B4a3emcyTNx2ZezLGTW6oArpNdbiH9E3hnc9qD67f0iSngrjObV2Dx79G3egN7KGyyDvL3+rjb88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ym4j67hW; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ym4j67hW"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4a45b3f0becso869682b6e.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 07:37:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788532637; cv=none;
        d=google.com; s=arc-20260327;
        b=TT8Sp0rqdz0lL2tSFW2OYwDpo9Cc0DdA+M90t24n4fO42ccNd60Wlko5ypdkWHM4OY
         iYL8BQFEH/wiUpe55bWWk5ZIHJm9boXeH8abE/U6bEVWlACj8fedKo31K2Ux6KofPXXJ
         xGpdKPx2Hsd4rk0Lu24QszfsRCrW0v9RI86ZJfDONrEbdW1D+B96HxdzGgZSFEZZNzE5
         s61Edp1rENM6qw0/Q+/YUu1JkaJl18JaUima31ONllzBNQQwDWROgXk3fZodFTBeqBCx
         PBwLeKTsRngloRpEzBwgovRrruOGUHpG9AOK1plTyMKBIUaArhldeJYktqoG8NNmiHyg
         h1jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7q3g4dNFmALa31N0fF/hbLEXsEhW/8QTaQTsCan/dWQ=;
        fh=rfLjIwn2a57wX7vvUPf5sv7xoXYLkb1by0ZOpcDOxJM=;
        b=KZkFgcJ96Co/knSriZY7WG511Bcrjxfpj9GubtQIjs1Vicb8270zn9lJAZtsP5n90M
         B0znTHmtsUIHYmZqBeIBy/shoCvIuTdAkaHu1954kNtbuDiMK7eASuZVCioo3o7r3lIy
         0GDqYs9fIpB1xmW+PmzSYX3A7eUuCGf1se7KP9rylff4dcAoh1mS3UA0VZ61e01zPhOW
         mY/BB8YWltRyw2RKeKMzb0uSifh4Nj0w7hmkM0RC86SwouUa5jjq7J1nhxB32qQatvcl
         k+7bNXmWXmsqCFm+2p7ZwAPiZevk8zpl7AiPajE+BNciEbSvR467/xd2tc5/vFoY6//6
         D/xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788532637; x=1789137437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7q3g4dNFmALa31N0fF/hbLEXsEhW/8QTaQTsCan/dWQ=;
        b=Ym4j67hWtXne12J2gX2zEAVVsGTzkijgQCsHPTKjSzjnglOYB5w1XpBWtZtKUQMMaN
         gYQxf0LrUosemx+07KrMtDrAolOE1IZymM+rp8VstXKjREXC2hLa28zSpWoHTqUQRX9R
         hVywEHyWl3xuyiipXGmDqavqti+4oWgvOiq2TuxcLrU9h/bdQr14+VEU6WdGp9LmawO0
         nc27yKLi6md5u+QGaPI2z7nRArTIcA5agdBA7ccmWwjT5S0WLdG3mqPoRUdoYrhdQS6X
         +3ETqbQ1LYEeg7gmnLMmVd+St8Fwv0XdFLgcsG+pAzRxKUJiDZJymdfKiIw+WYdL6APj
         IlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788532637; x=1789137437;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7q3g4dNFmALa31N0fF/hbLEXsEhW/8QTaQTsCan/dWQ=;
        b=EXEogXUllPTsCYFoRwuDsEKZF349T0UWyYniU9fIbr4vC/wLhiHeU8I+qW8SsdG7+j
         6rE2EC9CLSfd20rP0uDYR0n08MIyVay+DnaK+TvTZ//PM+9lsoMnb8IYxwjSC5Ffbmce
         VCJvzh485UMkwQXym2F8P13zqOhVEl4Me7vdGsWFjGC8KEtg17s5INr3HM2WGIV0+v/P
         syfdp7Yf3+Hf32zXwws+Ps8iQZLGfAXarZuxtMP1h29qsnMbYoAy3Ir7CVktfx/x2VMu
         2/R+WFM67ReAgSzOEnfqOBzH9vuGLp4hi5IeghDOxqD65+cZELGO31v2EpcMmqUFXVYn
         dZeg==
X-Gm-Message-State: AFuF++lejQ/VZr5pYqpciO+Zrl4XtKp0EdAoDXhABlc7H1gc1qZb6EvY
	zo5qRfjyLrmKrS3HFmAWMDkoiUASTJtM7hMx7UwSBUVDMHrGYEYeh++IwZ3Y4H60XDu0Q/5gqgc
	cK5B21bhZzzC1ng1vmV28QUmuc8zA/ME=
X-Gm-Gg: AYBFou1koaZh4xgcYdOQKJFsVcEH2D1HlfJN3jABhqIOuiaISrOGHjk0LjFjfImoHtd
	Jruw2lP+NwURdcAY+GbSkI9UUoiRTlPZDxNFFVaLJGRNFTUKSriKhCt7zoqwlb716p5z6TjWCaI
	AlsRTOHxNVM7w/zhxwm52Sr9xHcD7mvTejJcgnPfBQ/3bzb6bLcLErsgN9dEhejN+WuvUYMybtL
	9GeobJZSKNojn5iYP1lT8T4c8yFyCCh6nGf6Ic4Ua/kH8KRidNsHmaNYMYRdkSTTPWtQb3bC+Cc
	ool1KXKqU8kRUNULn9QVH7K9Zj0/SDiqLMj5x0h4qFCq6GXsmtuBLWyTabc+LMiOvp4fq4cC2jR
	57z0mz/JFItDu6LtldC3vDLpoYPJ3H7jIGrcwCN+C0c5L/S0S6xMOdEiTorEi7Vw=
X-Received: by 2002:a05:6808:c2bd:b0:4b9:a8ac:482 with SMTP id
 5614622812f47-4b9a8bb6aa4mr2655387b6e.32.1788532637258; Fri, 04 Sep 2026
 07:37:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260825175818.645579-1-jayatheerthkulkarni2005@gmail.com>
 <20260825175818.645579-8-jayatheerthkulkarni2005@gmail.com> <xmqq7blem1y6.fsf@gitster.g>
In-Reply-To: <xmqq7blem1y6.fsf@gitster.g>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Fri, 4 Sep 2026 20:07:06 +0530
X-Gm-Features: AcwNN1Ug5oogv7LJBVGIrXHNVU_Tkz6FUfB0uw3JY9_HMMyjq2OBCCyu5tAiIr8
Message-ID: <CA+rGoLcZ6u+Rbz2PNGiaPbeHB=LSAqxi0r6jYZL3RjG6wimJ3Q@mail.gmail.com>
Subject: Re: [GSoC Patch v5 7/7] repo: add path.cdup
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, lucasseikioshiro@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Junio,

On Wed, Aug 26, 2026 at 1:01=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
>
> > +static int get_path_cdup(struct repository *repo, struct strbuf *buf)
> > +{
> > +     const char *pfx =3D repo->prefix;
> > +
> > +     while (pfx) {
> > +             pfx =3D strchr(pfx, '/');
> > +             if (pfx) {
> > +                     pfx++;
> > +                     strbuf_addstr(buf, "../");
> > +             }
> > +     }
> > +     return 0;
> > +}
>
> Can we have a small common helper library (e.g., repo-info.c at the
> top level) shared between this code and builtin/rev-parse.c so
> that we have only a single implementation of 'cdup'?
>
> The same comment applies to all the other features that duplicate
> implementations from rev-parse and elsewhere in the repo-info file.

Apologies for the late response, I had a hectic exam week : )

I started working on this, but I wanted to check how to
structure the commits cleanly.

Would it be okay to queue this `path.*` series as-is first, and
then address the deduplication in a follow-up refactoring series
right after (provided there are no other concerns)?

Grouping the new `git repo info` keys with the cleanup of
`git rev-parse` in a single series would mix feature additions with
legacy refactoring. Additionally, since earlier path keys are
already merged, moving the shared library to a follow-up series
keeps both topics clear.

In that follow-up set, I can introduce the library alongside porting
the first command to use it, and then port the remaining overlapping
commands one by one in subsequent commits so each patch remains a
self-contained, bisectable change.

Please let me know if this works for you!

Regards,
- K Jayatheerth
