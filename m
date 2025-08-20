Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FFA266B6B
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755712195; cv=none; b=QAVX0YXyQr8EeceszEuhdCzUJJFNzxQR/rrNDvWr2Mv3yJLCV8UwBksEok+cxo9GuoXWMN4/ycTBm1qDD2uhLGCOzCoIW6AhpIQ0t0HjwKppu3uvfDTvzjWJo2WCUH9k1o2Lbmx7Zb3FJV8GB99XM6ifNWEnbLUzgvnOKXxX+RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755712195; c=relaxed/simple;
	bh=JZj38OKJGz5g63Dy7dIznOGdtdXn2ET2xp0XO3h8E3A=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=WghAqTBTaejS89yUkm6ItnBjpw6dtakHR1pa0VK3EIqFPWfKxSCM5WV78ssVQhdv7L05vSuxqDaD0pGO/+0G3hzeskszhigqqKiLa9xBZvd2zQN68rAyW1gqQfjIFZso7wfiyvhgY3huLSN1smX1mR0HC5NMHy2Mh3LEt9aZzxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7UhuDrp; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7UhuDrp"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d5fe46572so1942667b3.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 10:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755712193; x=1756316993; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfQnNbDQHkhUIqOCqbq+A97JuvHBHg3EJRCqqZGvH4g=;
        b=l7UhuDrpwtj1ipUeN7egFfV01pamXeGi7i4JfIpnk7BEitYW2AVVdFylk/RWu3xWEF
         KhV6N79tjG0BBd1Lgd6N3tb92Jz59REZjifCd0pYcYQz3RAXF2fIhZJLpOL+GYzF+mvc
         1Bfn/qAtPNUbkHhfGhdk9FpaWGiEY9ZQR/exf6HHrLTOibo1jdZWevHHEDzEZzIm/AYi
         fNQlXh84dA7g8hQXOGvwBc+74HXUmWNDDFI/TcytYlFaNScXcFjyAqbcaloeXcPwR0HH
         Tl+BF06KHNWYeupW30DEvjqwIEcQCDB1HZasXlbd4X0voHwdYtt2Fdyda+7sGLVsI3Ef
         HdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755712193; x=1756316993;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfQnNbDQHkhUIqOCqbq+A97JuvHBHg3EJRCqqZGvH4g=;
        b=k8/5b/RwzJPj4HYLf366VpLtc7k98n5cEMrJhIPy2O4WqnkE1jZ+CKY+lAsDfQfnYF
         crX0tIwAv2r48LBtJc9PvihPpY+e9UptgBdLI9RED9Brxi9ffvqowIn57+8M6zbNuHRx
         T0mXqIjtLZpsYVhyUIydTFjAnHGxB8OVfkiw40G3wdXRt1A4hTVLhQcKi7qwau3cxFAQ
         OJN9pAqaxin6BAQKb8JMJUIhkAqeU+SQmQoffgfp8+/JHTkbHHyP1Hrd5PBxNKjaxhuZ
         97YRrUKC5b/PwF7+zpvOaWEsT/Brr+zH61lu8aojcN53ekfEu0xnW8azTsX+f1udVy81
         HAXw==
X-Forwarded-Encrypted: i=1; AJvYcCURbxQHnG7GsDda3tR3JZt6KYwzBObP3bcR9VulZwHQ2OdDgUJw/5IqHJf3M9EMMsvLbPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj1pGO9/8UBD6B6egpkYTAU+bB0BYEjrECDFnjjTbVUg2/d59d
	QVKg4Wq+TksIpy0EXdh6GRXJ4m5OOYu/G/+XYwoXiOMUzmwNdgZdbtcAo/6VISSf
X-Gm-Gg: ASbGncsQkhuiwZAfnyDPxmQXWD6GGwCU3B51IjQD0EqLopOoGFX1Nb1beEvI9o29lsU
	4pYA2StkKoPJmPQy0SVdvBiDYB9zi8tuR1TXis+oF50k0IhAgG3My/LqeODqHNYkRu/mv7rplkx
	bGodF7bzuKxo3TRlflYhppR1twNN1rjk7iVsjKhHLhAtSyhlrVR+rifuyfH8K8V94lwrr0w1Ym8
	MvAkExmSQVPYmtW7/Ux20SDeCsI2+G6iIR+4R8Y/wBhXSuFPzRviqEbHCUon9ZsSeodZJmDNvxh
	gRaU3l5tQTEteEuwymUml0V/H/wZI1/xuOzV/GjseaqK4k7YINYO6EMPK95T8LPZO3oRaDc/rqX
	/MuM/l56iBmB8LHMJScr9bkDY4oSk9pLW1o/9v/VEMWd0lq6S+HU=
X-Google-Smtp-Source: AGHT+IHFFYQhqXsjLjWLMRGXMdIcpgxMNv/u9/8tixiKKYrgbpGHMw9k3Ff4gxSbMOfMdF2JIEXi8Q==
X-Received: by 2002:a05:690c:a0a5:10b0:71b:7126:65a with SMTP id 00721157ae682-71fc61cd1d3mr4654677b3.2.1755712192415;
        Wed, 20 Aug 2025 10:49:52 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:c001:1fba:b48d:e9d8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fab5bdc20sm10384377b3.8.2025.08.20.10.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 10:49:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy history editing
Date: Wed, 20 Aug 2025 13:49:40 -0400
Message-Id: <3600D877-4999-4EE3-8C1C-893E12D35B6A@gmail.com>
References: <xmqqms7tao9o.fsf@gitster.g>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
In-Reply-To: <xmqqms7tao9o.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


> Le 20 ao=C3=BBt 2025 =C3=A0 13:39, Junio C Hamano <gitster@pobox.com> a =C3=
=A9crit :
>=20
> =EF=BB=BFPatrick Steinhardt <ps@pks.im> writes:
>=20
>> In the end, I'd like us to learn from what people like about Jujutsu and
>> apply those learnings to Git. We won't be able to apply all learnings
>> from Jujutsu, as the workflow is quite different there due to the lack
>> of the index. But other things we certainly can apply to Git directly.
>>=20
>> Note: This patch series currently builds on the cherry-pick infra.
>> As such, when one hits a merge conflict one needs to `git cherry-pick
>> --continue`, which is quite suboptimal. I didn't want to overpolish this
>> series before getting some feedback, but it is something I'll fix in
>> subsequent versions. Furthermore, the command for now bails out in the
>> case where there's any merge commits in the history that is being
>> rewritten. This is another restriction that can be lifted in the future.
>=20
> Two comments.
>=20
> - You would want to honor notes.rewriteref yourself, as cherry-pick
>   does not and that is deliberate [*].

Seconded

> - It is a sensible design decision to limit it to linear single
>   strand of pearls history.  "history reword <commit>" when
>   <commit> can be reached from many branches along linear history
>   that rewrites all these commits on these branches would be handy.
>   There may need some way to say "these branches are protected, if
>   'history reword <commit>' needs to touch commits on any of these,
>   abort" and things like that.

This reminds me of looking at rebase=E2=80=99s update-refs through a mirror,=
 and I think is similar to what jj actually does. In particular, editing a c=
ommit that is reachable from multiple non-overlapping branches could update a=
ll of them.

A reasonable heuristic for safety is =E2=80=9Cpushed,=E2=80=9D but I would a=
lso want to be able to edit something in @{u}.. even if it=E2=80=99s in @{pu=
sh} so that I can force-push a new version. I suspect jj might also have heu=
ristics we can borrow.

PS thanks all for being willing to borrow improvements! Reminds me of Neovim=
 inspiring improvements in Vim, which I get to benefit from without switchin=
g :)=
