Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B21E2C15AE
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761647211; cv=pass; b=G0nfhCy/TQBxJ3T5JWncAmltwQZBdYPwwaR9OU3SBvZaO0PZTX66Iw/ddWYLOt7EenR4xMd+bdh2LKaj1IYNyG5ZMRoEh0pK4OR0mvzBJK95wsETbvcztnDEPPEqM8A0GeYz0iTJi0ze+uEjz8zBpaAA7bmo9GbFOHyGUpZSfPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761647211; c=relaxed/simple;
	bh=thZIWe/51oitWCZOe0rbZ/c3cgwZBydI2b7DzdOf/8c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=t9TMgix6tf5Xlx8T0WWNi8YgIcLdydY0Bl3iQYxeh3pRbaYAkk7SbF/N6uqmfdcHZsadwJoh8nfyWqXjq0h9k8M2jmpYGJQrMSnBu2JFp6gPOGE/dypkxLbzwfvYO3yxj6cim1N6yPS0+5VNDx8xFkQ0uh8E7X5hX/rS1Cl5/Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=ta1L57aR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="ta1L57aR"
ARC-Seal: i=1; a=rsa-sha256; t=1761647195; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ig3ft7ocMg1QswRUufe6PrH+Rggb4CpBHb6vJYJITzTwpmI2jRcnKIlS7SLpLpFqoRvkuMOSMUHDQY6PMeqmmLEAEULHBLKwNlffXTZCwtQrquc+c9ml8OYByg/FjTJnlJrDd1oMzUxvhNaYwYvkGx+w1G/j/0yrhcIXpzDQpgA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761647195; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bGl6GIWCIAgHEcgjS1m8GxLV16JdsyeJlpXWZ1jGIq8=; 
	b=maHjq5oct7i397TanB2oLgTdbIizSBRYz6wYQhwTmmgghINetS0CML7QmiVCrkA7cNvOefhp5LM4nR84s76nSpZXFYGjBuCkiKuX8kXVGcBZmDNoP4gEpUd2ww6/It6P0DS2flHv2x3hyL8B2ve1eIw1m+HyXjGxsm9vCw/V2TQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761647195;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=bGl6GIWCIAgHEcgjS1m8GxLV16JdsyeJlpXWZ1jGIq8=;
	b=ta1L57aRBPmMVrcSh/TponmiRjfzrqWymLcdPFyaD6kXTcN5uD9oJRGHCcQ2LabJ
	NxdcyUj93OS6PPu50B4vpsGgvbT5uSwn+KwJSRUdeaQDLV3HThXX3t4jwj0/xPDKLUQ
	tZ2fpwTKxy2W/br5kgdkRLAPpqrK/+WWpnNI+feM=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1761647192637785.9147966684131; Tue, 28 Oct 2025 03:26:32 -0700 (PDT)
Date: Tue, 28 Oct 2025 18:26:32 +0800
From: Li Chen <me@linux.beauty>
To: "Phillip Wood" <phillip.wood123@gmail.com>
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
	"Phillip Wood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
Message-ID: <19a2a5aea22.54000694646975.5864990720344586426@linux.beauty>
In-Reply-To: <bdba181a-915b-48d7-8e24-84fd08436576@gmail.com>
References: <20251014122452.1851103-1-me@linux.beauty>
 <20251014122452.1851103-18-me@linux.beauty>
 <4eb06e60-e088-462b-9f1b-ca800af39b94@app.fastmail.com>
 <199e82ac06b.22809060320824.5985600477588171363@linux.beauty> <bdba181a-915b-48d7-8e24-84fd08436576@gmail.com>
Subject: Re: [PATCH v4 17/29] tests: t3440: create expect files at point of
 use
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Phillip,

 ---- On Thu, 23 Oct 2025 17:04:34 +0800  Phillip Wood <phillip.wood123@gma=
il.com> wrote ---=20
 > On 15/10/2025 14:58, Li Chen wrote:
 > > Hi Kristoffer,
 > >=20
 > > Thanks for the review suggestions! I'll address them in the next versi=
on.
 > >=20
 > >   ---- On Wed, 15 Oct 2025 04:41:33 +0800  Kristoffer Haugsbakk <krist=
offerhaugsbakk@fastmail.com> wrote ---
 > >   > Now you start to change the test suite/file that you created for t=
his
 > >   > series.  There shouldn=E2=80=99t be a need to do a test file-only =
patch/commit
 > >   > for a fresh series.
 > >   >
 > >   > I saw in one of your patches that you removed `--keep-empty` from =
a test
 > >   > because =E2=80=9Cthat is the default=E2=80=9D.  I also saw Phillip=
=E2=80=99s comment somewhere
 > >   > that said the same thing.
 > >   >
 > >   > The goal with maturing series is not to add patches on top in each=
 round
 > >   > (if that=E2=80=99s what you are doing).  It is to recreate them as=
 if the series
 > >   > was perfectly written to begin with; if one patch introduces
 > >   > `--trailers` and a test file, then there should be no need with
 > >   > follow-up patches that improve the test file style, refactors it, =
and
 > >   > so on.
 > >=20
 > > Thanks for the tip. I split the changes into separate commits to ease =
review,
 > >   as Phillip suggested in https://lore.kernel.org/git/d4c9f082-52be-48=
d9-b817-fcb8a72e1bd7@gmail.com/.
 > >=20
 > > It seems I may have overdone it? If so, I'll try for a better balance =
in the next version.
 > I asked that you did not refactor code at the same time as you moved it.=
=20
 > I was expecting a handful of patches, not twenty-nine. The point that=20
 > Kristoffer makes about this patch is perfectly valid - you add a new=20
 > test and then correct it in a later patch. Instead you should correct=20
 > the test where it is introduced as Kirstoffer suggested. Looking at the=
=20
 > first patch in this series there seems to have been some=20
 > miscommunication because it has exactly the same problem as V3. The code=
=20
 > that is moved from builtin/interpret-trailers.c to trailer.c is heavily=
=20
 > refactored at the same time. Variable names are changed and the code is=
=20
 > rearranged so that "git diff --color-moved=20
 > --color-moved-ws=3Dignore-indentation-change" detects barely any moved=
=20
 > lines. I'll try and leave some more detailed feedback on the first few=
=20
 > patches of V5 in the next few days.

I mistakenly misunderstood that you meant changes between each patchset ver=
sion should be reflected by adding new patches.=20
Now I understand that you mean refactoring the original code needs to be re=
flected in new patches for review. Thank you very=20
Thank you for telling me about --color-moved, and I found that git log also=
 has this parameter. This option is very amazing.
 I will do as you requested in the next version.=20

I sincerely apologize for the misunderstanding and wasted time.

Regards,
Li=E2=80=8B

