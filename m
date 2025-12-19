Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C321F8723
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766150942; cv=none; b=lVi2woyxCobEmgQG2mKIHr+m2Nq0XhNi3O4qapax1/k1Y2CnxUYP0J3DQ0IWcKqk8WHNazdl4wH157Mm/I4pHM2f1mlM6z9453NC0/X0qBA90yQNkh83lqird3CEAvyY0X2wnKKXIFbs5ZGg9K8ptCXP6LV+U8W7cNUDRxMF64E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766150942; c=relaxed/simple;
	bh=0++T/z1HHPCl680zp54Q6b5x8icvDJO8yDRHPckU00s=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=rOtadL1jS2BdEDVr8TVvC5WqOqhJKue3pXOGegYWQGg+HezrUC78WrNxSiTn7HhhfERCSUwGqH9Jlnm9wh4D3WbUm5RH7jds4uIGEvYtdzQDGORMvKJKzDunLF8sNZDOqcbwnzoXZUWVdAVs0czdvlGOMrayD/dhBCtnUG8ghko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elcVVVzR; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elcVVVzR"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78a6a7654a4so15391917b3.0
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 05:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766150939; x=1766755739; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0++T/z1HHPCl680zp54Q6b5x8icvDJO8yDRHPckU00s=;
        b=elcVVVzRgpT5arKklPFNhBadcHzfVXK3Fvn1ZakW/0VIwDGTmRVdRplzsdeFDP0wO8
         ZXWD1tYK0JYh4D0WRbU+wOMr23wr1fjDmlyXNy16TA/3SlUhH+W7g8G4Sv6lxmiEJHzG
         SCBcCO9OkkpMHWxy/g/iAYkeFYFgWfrztcNAZ7KzIIHGRm5HtIe2iH74AtnS+BT30OAT
         BaET3tjUK5PQL2nafyLFjBgfcTsJ482eXBrydU7PIoPiER0R/cBLYMggwOGrJSdeR5af
         Hy7p0vnmC1OT/TfZE0k8xZ196hhYOGlGodASIRQmC4HAaDCKYP9B4sA3nhHjB4wZzMEY
         GG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766150939; x=1766755739;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0++T/z1HHPCl680zp54Q6b5x8icvDJO8yDRHPckU00s=;
        b=UYqZbKtUkpeuU4IEp1QmomtgonXs9DqPl6dFYYgf7rMYcg1e9fFgTxyAyA34zfxH12
         9zaDM6j9v4fONIuLXvUx8XznNsSvkVdbg8m9e5TF4aPvbyWDqDAPFYHpHjqJ/nKz75h1
         hcEgmEs+JpfQRtgPNNik/1TlBYCJBzBy/AJODurD58k5Ra6MEcQPtpB4HaSHQnkYt9Du
         du6D4EqK+nA4uEmi7b2x5Iao1LLzHAZ/dweLIFUHbC1rScwpR6r83/Oz1SusNn5kFtuS
         H2ji/bbOejrZPaFaWwLohcs9Yqsxq1KLXrth16z8X2okWqTWLM3vR7PmBDIkGjeKwiU9
         KlVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiYG8wgmQIlWV0DgyWdfxKAgXyJ7uDIhIk85ta9ueU4MvymQnQvF5hLIunPPbjOT0qeGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6nPW7BpKx1zS4gO2qForFGSu5W3HrFM8ttH5dEkR87gbayDeO
	BmF1v0xpTeEHagbANkLfqPxofegI/Y/J7oYNyYjTHY8h4VAmJUjKvt6s/fF0sQ==
X-Gm-Gg: AY/fxX69yRrVWxQBD3CXH5ljxRLdCTc/wOAR0387HvBCnAGH4PT1V0Hk8XVIyHu4NMT
	GA+hghqi+zlRvdwaiwEkyUGOJYWnuWGk0ouziZZK4zf1Coe04B1lOctEfppqUlxv9+APKt4BbDs
	RuYV4mBbMidtD4qHA/e8qgiGNq2AjtHtRW7k+dbOoWBkun+n8jsVv4eajDkPzk8dQp6tJ0mxRrV
	bPzGtG01br4nvMa8dP4e+50ZOLufxGOZF08e+bj7kxwJP2A8zdTwZtVhUB+W0rrvl4nl+KVTUAx
	9xuj6DO5v4U6vYzKAfJEGteLXy2OPy/VeVjX5KVvtksdIAtKh1J+XsFTl2UmNbKsnS7Lze+zPt0
	WgMjwV2TYE6RapKsHcz9XCBDQMisOpL5HO6RX7bUQeNY6smvvk68Hc5G9f7DvgIi6rlTcsQ3jyh
	SukH0Vpl5W4CM5mXHTg3aE+pyYqYdpDix3raQOXo715dMy
X-Google-Smtp-Source: AGHT+IG8FzkFrlMNo1nyaJeHE9D7ajtzdtJNxTIp157O8FdKQqQ+PuZS6v7m9eh7elQA38OeFZWjag==
X-Received: by 2002:a05:690c:9687:b0:78f:a544:c45d with SMTP id 00721157ae682-78fb3f28cf5mr23152737b3.20.1766150939306;
        Fri, 19 Dec 2025 05:28:59 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:5982:24ab:62e1:eea6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4376656sm9830007b3.9.2025.12.19.05.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 05:28:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] diff: add --no-indicators option
Date: Fri, 19 Dec 2025 08:28:48 -0500
Message-Id: <7B631B32-22B7-443C-8D1A-D05FF93F55C2@gmail.com>
References: <20251219114814.98846-1-haraldnordgren@gmail.com>
Cc: collin.funk1@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com
In-Reply-To: <20251219114814.98846-1-haraldnordgren@gmail.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 19 d=C3=A9c. 2025 =C3=A0 07:27, Harald Nordgren <haraldnordgren@gmail.c=
om> a =C3=A9crit :
>=20
> =EF=BB=BFHi Collin!
>=20
> Surely, "git diff --output-indicator-old=3D' ' --output-indicator-new=3D' '=
"
> exists for a reason, to allow users to customize the workflow for
> themselves. So this is adding a better short-hand instead of that, which
> feels a bit clunky. Sed workaround would likely work, but nicer to have it=

> native inside git instead?
>=20
> I use Git from the CLI 99.99% of the time, and find myself often copy-
> pasting to recover some code from and old commit, so then this helps to
> save me pasting in and the manually removing the +/- signs. Not a huge
> deal, but makes the awesome Git CLI even better.
>=20
> Harald

I wondered why you=E2=80=99d be copying diffs without leading indicators; wi=
th that answered, perhaps you should try =E2=80=9Cgit restore=E2=80=9D? One b=
enefit of version control is easily restoring other versions.=20=
