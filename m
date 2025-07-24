Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935441362
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 02:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753323405; cv=none; b=YhL91vGrQNYXsQ5VkZJJ7cv3esRnGGFdBipsmkC+/TQ5o3ZwGJAzAelombG/1wz7EUhL45ppZ4gSdhOro8U0awqed+dt/VoYXh68nR36mYIpWBcY4kJUvMIzf1DEnL2urmzL4lSIXah9bTia3b3AFkyeeuWtQwHhzjEad0fHA2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753323405; c=relaxed/simple;
	bh=IyxuXmMBPdHAED6AbegajoebPXkid3rcxC0G1NIBwRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDpq8znL9rFb8kMBS7wx3W0+muV5+eM4NqNfr/3e130XrL2vOutVmJZGPqTkkrpJvPf4lw7QBcM62tKn+uols1/cSHVeWekt/QMqOilIyYdCHCkjMHTfkU5e3FdrnVsg7hnP43/Vct6Pqp8kWCC7vwxpKY2l8MIVXEHyvrfex5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-70707bafbe0so1129946d6.2
        for <git@vger.kernel.org>; Wed, 23 Jul 2025 19:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753323402; x=1753928202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyxuXmMBPdHAED6AbegajoebPXkid3rcxC0G1NIBwRI=;
        b=Qw6n7afXEng3nn8QsmJ4fHq4EI3gl+TL6QYvP7nbgN7razaP1PANHsDwridtKoyYOJ
         1bs7XtIwzGSzpp/pMoS157sFA1ZT7ymljtpFOA1tM4JU0myVVhbSz9+Y1e1mDWBUK2hC
         Kh7MgnsixfLhhMRf/QqPpAKmdKG3w9IQwwk18iEX8Z5r4SuN4JAjdY2Hij43sNdD/xgk
         Eb+01v9uUaQt/1ODqYGrcGUJYple4FctNIAG7zSW+gbwNrXOwGV7JNK3ZcIVxdmSnmmV
         TOQHl18nlFoPUxpR39hyx709MUgaTNk5QH+I1nda3kCtE/kAQWWBRAn+XpQtZ6ygoVNk
         4Vew==
X-Forwarded-Encrypted: i=1; AJvYcCV77jXKHvX7w388lCmqvSdBylg6Co1EjVfLoXglSbeW+FWkVFRXBjYtQfykAgh8NsjYg6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4AA4WLvFGfPuYgToEKiabwxpn18KsCq6r3S1j8rZ1FfL2IYX0
	hwtirp/VY3zjGXE6aIrg/myToFUSma2X4IHOoYFOjowq/yU/FbXqvCTfoTIXgKieES3M0q7wAzb
	+kt1Ir1ITIwZ2kJdUL0nh/sW9CcUWsbU=
X-Gm-Gg: ASbGncsvVBQtqNmbcqcwSoAazXecwDzxm6vs3IFmwsoRQXUBBmVl53fz2YetoDd+eka
	N0BMb+/tTd/JZ1sW0RiMhqOUh0xBbYQcXL+sWpaez/+jwrnUCme4T+AN4alsyvc0s9IQGG+rftU
	rGqj0AQetedbxjWN3kbTDTg5Dl6sEhq7teYHWT7Af2g6q8ELlOjIMM8Er5sIowaofCw8gjboUGp
	5/eUcBQtr8Uvxq1UxmndFKj1MRjoWLWhCV5Aa/m
X-Google-Smtp-Source: AGHT+IGZmMaGObUXf08DMCSDkHvtctFxdHMFZacJdvdiJCkdx08FOpTCYV1BZS7eCRvypmvhUFzWKCCcwINReF7yrB8=
X-Received: by 2002:a05:6214:4c44:b0:707:6f5:7f99 with SMTP id
 6a1803df08f44-70706f5837bmr17580166d6.6.1753323402429; Wed, 23 Jul 2025
 19:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87a54v8nmz.fsf@arnes.space> <12095AC3-BC38-48DB-95B4-394F9F7DE054@gmail.com>
 <xmqqqzy6omul.fsf@gitster.g> <23DF2497-D379-4EAD-9271-D01D7D8F3E8B@gmail.com>
In-Reply-To: <23DF2497-D379-4EAD-9271-D01D7D8F3E8B@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 23 Jul 2025 22:16:31 -0400
X-Gm-Features: Ac12FXxXrPPwP1IRTl_XE-7e-iu7K1WR-zuHR09LUHigftn2ZX8ybyx9Yz_O0lk
Message-ID: <CAPig+cR7M1VL=9PQ1+xsj58=EPi0jR8oTdTnkGmMAD4gXeOnKw@mail.gmail.com>
Subject: Re: git-diff: --ignore-matching-lines has no effect on the output
 when --name-only is used
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, hi@arnes.space, git@vger.kernel.org, 
	=?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 9:56=E2=80=AFPM Lidong Yan <yldhome2d2@gmail.com> w=
rote:
> Junio C Hamano <gitster@pobox.com> write:
> > Lidong Yan <yldhome2d2@gmail.com> writes:
> >> The `=E2=80=94ignore-matching-lines` options is introduced in 296d4a94=
e72
> >> (Micha=C5=82 K=C4=99pie=C5=84 2020-10-20 08:48:09 +0200 5803) Since th=
e Git documentation
> >
> > WTH is that reference format?
>
> Sorry. I should use `git log --format=3D"%h (%s, %ad)" --date=3Dshort -n =
1 296d4a`.

Simpler: git log --format=3Dreference -n1 296d4a
