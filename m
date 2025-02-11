Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43172638B6
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 19:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302198; cv=none; b=uN3582hGyhuM4cjoqGWEyQxZBaN7fYwzbNh07nS0qFY5xA0YY001B+TkRlXPs3eubboIYfxNIST0ocerIo45qZul4BuWk+DSBlX8V8iF4J46Y7Kpoq81xHbCrIdqh+enOT7c4sm0fHAyyoZbmXx+fMVoS2uM3jHR/2akvYO/9KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302198; c=relaxed/simple;
	bh=7abzP03C37PVk0gcsGNto/CbkRJCeXSBdzbW6hWYY9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iU0y7i7+dZ1L6kK1GklamCxFET5+XFDTdbD0Cy/75tSu4VR5neOU9RdDxgQbAKT2ozg8N8dY/kcd9/aBu6Lo6n333YZAcO+zINfEngxEj+u2VrSJmdVy42mjOUT18LgKE7q2mx+kuvLNi4gJqvw5+uPLtwsRZvLXLlIgd6H286M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVUGcwMr; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVUGcwMr"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab7b80cc3d2so381110366b.3
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 11:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739302195; x=1739906995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7abzP03C37PVk0gcsGNto/CbkRJCeXSBdzbW6hWYY9w=;
        b=SVUGcwMrX7BPsKgq34wIVPjkOLuyUKX7MibtP1XXGuVgWemxRw5ghkLkpVkf0Wj8ER
         0K39MyjI7Up7fQUYcXRpyBaRh6/5X89KfDIqO6UPKx2Xe9CUMMNwzw7+nPrXgfB0Y1IT
         KZwgMWKowneYsuAjsG1xgeozuwzse58ztu0Zp6Hb79CfXwY65pC05HB5LH/pCoFQR2wC
         n3N2G6o0l0WKy+FirTTVNMugbKGi6oJRWu3Ojrghb3391P9+wCBBGvNuC6xxFtHa8/CE
         9CdwkEBzotuAC1ZV1dD6EzELZtCEPCD5wagbKzm8U8p9+4UHGMCQv51Q7DIPyjOHsogp
         x5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739302195; x=1739906995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7abzP03C37PVk0gcsGNto/CbkRJCeXSBdzbW6hWYY9w=;
        b=STfFQna+/BWX+q30iC084dNQGZQi1B68yyLEbB+rJdM2x6WAgwIt4iyZcVDzOK7k0b
         LgloemWgX1BE0kvF349op/BIp1Dup0V0yfs9qqSUouXSEamfMV5wyQNmWzdvB4g4ieJH
         6wBAJMt/WZ9SRT+7uwHonW7J1ZPTfUILGpk3CTE/tkMfacXjGRlUGNH6FJVMdqMwhRf2
         z+Z68Dxq91VFo2a0xVSEsibOW1h97MOp2l8mwnxumYN2O4mmVHxXzObA4graNjVoIXkz
         C5rT23arwSf2Po1rPG7IVhLeWi+tziJh/aW56SN+tn1kkKemhaJxnZs2RUpgWxRBP8gV
         7gUw==
X-Gm-Message-State: AOJu0Yzhz5MhdHDQ26j11NGAfGhSmfnZIkcONPA6ukbksSmqS04vQilq
	0dn+DVHp3KaFeRosz6lwLmn3m4nS8P971gzFSzfrVmYVuLg33Mu3db9gVVoyptZkWnlCoCAZFRZ
	WYM++E20qqOZVSNxrvyeGs5R2yRA=
X-Gm-Gg: ASbGncufSqnVkbzTEiehuR1qmN34UN9WcogQp2gIA4iel/5Z5dhyvWwaLinXrNyYmi2
	GKXGzWMHXtGrPiUg8C3SMjzmGJgqcHOZWjXqchsZbTOJEHptro1Vxmtor6GKsNHaYp+GclEKVHF
	HElP4vWU9msyGfXZBaHvUSzxT3E0rv
X-Google-Smtp-Source: AGHT+IF6UcXdZSigN9vVJQnpjaw41lVT5CRGRgTbiCHbIOm8oA7F+/uj3JAYixFks+drP1ikrTluV6mBCrloEaTYg4s=
X-Received: by 2002:a05:6402:3510:b0:5dc:7374:261d with SMTP id
 4fb4d7f45d1cf-5deadd71ae6mr1053466a12.7.1739302194898; Tue, 11 Feb 2025
 11:29:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210191650.316329-1-intelfx@intelfx.name> <CALnO6CAM7WCOJV8s8ZARi3BAFwkh0TNTCod_YH9s+EpO7t-Qtg@mail.gmail.com>
 <bc0de52b59f289e1388f1581fcfa49453365e21a.camel@intelfx.name> <CALnO6CDN627+SUC6BWBvVjFnU5qKsBrfLkmX2okv8J8+wgDDRA@mail.gmail.com>
In-Reply-To: <CALnO6CDN627+SUC6BWBvVjFnU5qKsBrfLkmX2okv8J8+wgDDRA@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 11 Feb 2025 14:29:43 -0500
X-Gm-Features: AWEUYZnK0frWHzFeJZcF5oGO_6R_4Qz1qYOsIV2xDx-QYNS3HjqhwzVSzZDp3k8
Message-ID: <CALnO6CCNWz2o+qa+oMNFAAvkGY8n9tBMPkgdz8wah5eHo1hoTQ@mail.gmail.com>
Subject: Re: [PATCH] rebase: add `--update-refs=interactive`
To: Ivan Shapovalov <intelfx@intelfx.name>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
	Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Alex Henrie <alexhenrie24@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 2:28=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> On Tue, Feb 11, 2025 at 6:33=E2=80=AFAM Ivan Shapovalov <intelfx@intelfx.=
name> wrote:
> >
> > On 2025-02-10 at 15:22 -0500, D. Ben Knoble wrote:
> > > Should we add a test for this?
> > >
> >
> > Any suggestions what exactly I should test here? I don't have much
> > experience testing interactive CLI tools, so I'd appreciate some hints.
> >
> > --
> > Ivan Shapovalov / intelfx /
>
> Give t/README a glance; t3404 is probably a good place to start given
> "git grep update-refs t."

But I really meant to write=E2=80=94let's hash out the other details before
worrying about a test ;)

--=20
D. Ben Knoble
