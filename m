Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358EF2135DE
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433487; cv=none; b=goVtIFGFX6iAbdxUpYORdQNbxPsBEYB5mq+E/OV+1J4++kWrqWxU7Bdz8E95CR1BKD4F8XPMnNZfwFdS3ujX518ysjIrVk43BLIAGYJZoZf6wWGbjnWfMG5zQ/s/kMo9jnK1LA95U3z/rlQbp15Bq9W8TzwsXJNIbDGFR1nvDFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433487; c=relaxed/simple;
	bh=8LXbHX3bVHOvWchrM3251FHID4hxhMB4nz5lBMhkRMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEPJZXk6ADkuuh47hXjc7wFmOq+tfPvv6/QkSHpUKLICjHj1JdUR6pAu1C9Fu+rR4YEw6MksR9v1k7WmpdZ1FCaBu9pFcHV6dKzxz5LrEdbMOy+FINmkXf0nWfJegVAT6xgh2K8kpIY6wyaS/rKbdI5enKRIhxR9Ims55qtNAb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VG4Z7WlR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VG4Z7WlR"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22548a28d0cso122864985ad.3
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743433485; x=1744038285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dp0niqhou3UlKZ0o3l3TF0MNXVCCFt+bSPa6mvHiNIc=;
        b=VG4Z7WlRwMxpCmwjHh8CEJ6DX7jc4eQJdscGaZvSqrPZE3fkSqqOAs8/N7bs3KlM4i
         k1bEdxEbMHrxJ0kUy2E+XTSO3gYqko+FPSABDBemSmzNtY81JgCBK3A58AqgXRz31ckl
         6ipqmK/1QWKHCWCi1Xjt4alJG4VaxmWlPSFc4nHaDTurTY1e4LPntML1tJ73uTRLFSkl
         I6aWbk9zklzn24a7JiYvqfcRsqQ1V5LodRSSyFtGJNsSimlU+4i9IRx/j7R3Ji3pSFTY
         xu/r5od0afIh/UGDyo0DFYTWwW9EybJM6Faph+fLW7dMz9Z7tKhrk0iMrePs+twzxcUN
         5k+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743433485; x=1744038285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dp0niqhou3UlKZ0o3l3TF0MNXVCCFt+bSPa6mvHiNIc=;
        b=wQklOVFq0c1uQP0Nv3Vhbga8Sz94Q7WTIuG/K+4lSIig37dT0KY+mAQZZAC0eTItwu
         VhjWuVb6SGpWa6dnJ3nYQzm8JZjux0/w25aOwhzcpQZM0K1fNjAHi/PBNb5p6jRu5Fb3
         rxyMbjTYGFW9Q9Lw1+XYShXtRJGYIHhM1pu8/YQB6riq6wdmVWRkSynipCtm3k6tzGNu
         7QnlgZ3wZj/eqX5GoufUuvmkvAd7tGX7kH51EyqI9V0D2qd6v8lUGiBdCtxRWoWUhsFd
         z0ApB5cvN3+NrVHWdLF58e+yX2DmGKMqlUuN+s1xfg5FBU04DZcNAkxnhg9DN1a5lYHl
         IJnw==
X-Gm-Message-State: AOJu0YzgWzS7w44dirLNhIDYjE0Ey9y07BZ4Mx+4mHul0LuzZOhn/qfv
	pDz5OixhGuOLdWosRngqOyn39V/HAhJu+KMKJ/DyQL7vrMbdjCSvEqJhc5fOrP2+hn/RQgtktFT
	5P14VwRMvSYtDX2zX+D9iA0W70AY=
X-Gm-Gg: ASbGncsX7rqIq7Ri/j1SdpHyZ33glq9oHTIW4hO4YniwAq/qq5EeiHPQuT3VMC9k9Na
	apwpyQpqeoWoJDREGlFDO1fJkKU60Mt3CTI+JTh8i/xNHY4nEWcqGarqdQ2o9m1g4zkvDhi4XFd
	xf1LMoQM85odGqeGvIlKtHfKBw+V0=
X-Google-Smtp-Source: AGHT+IEuW004IJ+QcD1LyoJksW/ypaMHcgTadiM/L284MJG1Z3rhjAOgl+y1l/L/t6PIKPl93FG2KSnsGbGzfjYgOeY=
X-Received: by 2002:a17:90b:4ed0:b0:2ee:edae:75e with SMTP id
 98e67ed59e1d1-30531fa2ce9mr15198486a91.13.1743433485217; Mon, 31 Mar 2025
 08:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326052602.265989-1-ayu.chandekar@gmail.com>
 <Z-ae2l6fkurPNuPe@ArchLinux> <CAE7as+b8qZFEcaH9eJcQnuhZOSW+hfAMiPUBXNPj9x1L7rcXVg@mail.gmail.com>
 <Z-qkFmc9xJXXTzut@ArchLinux>
In-Reply-To: <Z-qkFmc9xJXXTzut@ArchLinux>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Mon, 31 Mar 2025 20:34:33 +0530
X-Gm-Features: AQ5f1JrVgdb-MFHsBESGHv77ZTLTPklGhElTWRWBt_aZhzlHKX9R3ohXkBGZ1yk
Message-ID: <CAE7as+ZF6ARDQjGTyhjP7JZqhpbvZeouKGZA+tdZur_-8a5EXw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BGSOC=5D_=5BPROPOSAL_V1=5D=3A_Refactoring_in_order_to_re?=
	=?UTF-8?Q?duce_Git=E2=80=99s_global_state?=
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com, 
	christian.couder@gmail.com, shyamthakkar001@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > Yep, since I encountered this while working on the patch, it fits well
> > in the Pre-GSoC section.
> > Moving it there would better show how I learned more about the
> > project's scope through
> > community feedback.
> >
>
> Yes, this is my intention. This represents your ability where you
> interact with the community and get feedback. And this is what we want
> to see.
>

Got it!

> > So, I should remove all the categorization stuff and just say that I
> > would focus on
> > each variable, discuss in the community whether it should belong in the=
 struct
> > repo_settings/repo or not while sending patches?
>
> I think you should put the categorization stuff into after-GSoC part.
> Well, I don't think you could focus on _each_ variable. This is
> impossible for you to talk about the way for _each_ variable. I somehow
> think that you could just write the proposal about how to handle one or
> two global variables.
>

Right, I can do that.

> You already touch one setting "core.attributesfile" right? You may just
> elaborate more in the proposal.
>

Yep!

> > I felt that keeping it general might seem vague, but that's the nature
> > of the project. Every variable
> > is unique and would need a different approach and outlining the
> > approach of each variable
> > in the proposal is not very feasible, as these decisions need to
> > happen collaboratively through
> > discussions in the community.
> >
>
> Yes, so you could firstly give how you want to handle the global
> variables from top. And give some concrete examples to demonstrate your
> idea.
>

Alright, will do.

I'll send a new iteration of the proposal soon.

Thank you so much for your inputs:)
Ayush

On Mon, Mar 31, 2025 at 7:47=E2=80=AFPM shejialuo <shejialuo@gmail.com> wro=
te:
>
> On Sat, Mar 29, 2025 at 03:24:05PM +0530, Ayush Chandekar wrote:
>
> [snip]
>
> > > > One key challenge is determining which variables should be part of
> > > > `repo_settings` and which should remain separate. While working on =
the patch to
> > > > refactor access to `core.attributesfile`, I received feedback from =
Junio that not
> > > > all global variables should be blindly moved into the `repo_setting=
s` struct.
> > > > This reinforced the need to carefully assess which variables belong=
 in `repo_settings`
> > > > and which should be handled differently.
> > > >
> > >
> > > Yes, this is correct. I somehow think whether we should put this
> > > paragraph into Pre-GSoC part? I think that you have found this when
> > > adding a patch to remove one global variable. And thus by communicati=
ng
> > > with the community, you have further understood that the requirement =
and
> > > the detail of this project.
> >
> > Yep, since I encountered this while working on the patch, it fits well
> > in the Pre-GSoC section.
> > Moving it there would better show how I learned more about the
> > project's scope through
> > community feedback.
> >
>
> Yes, this is my intention. This represents your ability where you
> interact with the community and get feedback. And this is what we want
> to see.
>
> > >
> > > And in your plan, you should just say that we need to do this. Would
> > > this be better?
> > >
> > So, I should remove all the categorization stuff and just say that I
> > would focus on
> > each variable, discuss in the community whether it should belong in the=
 struct
> > repo_settings/repo or not while sending patches?
>
> I think you should put the categorization stuff into after-GSoC part.
> Well, I don't think you could focus on _each_ variable. This is
> impossible for you to talk about the way for _each_ variable. I somehow
> think that you could just write the proposal about how to handle one or
> two global variables.
>
> You already touch one setting "core.attributesfile" right? You may just
> elaborate more in the proposal.
>
> > I felt that keeping it general might seem vague, but that's the nature
> > of the project. Every variable
> > is unique and would need a different approach and outlining the
> > approach of each variable
> > in the proposal is not very feasible, as these decisions need to
> > happen collaboratively through
> > discussions in the community.
> >
>
> Yes, so you could firstly give how you want to handle the global
> variables from top. And give some concrete examples to demonstrate your
> idea.
>
> > Should I still mention that once the project is complete, we could
> > consider structuring related
> > stuff if the community sees value in it.
> >
>
> You could, mention this in after GSoC part.
>
> > > > This plan is flexible and may be refined through multiple iteration=
s as I receive
> > > > feedback from the community and reviewers.
> > > >
> > > > Timeline:
> > > > ---------
> > > >
> > > > Pre-GSOC:
> > > > (Until 8 May)
> > > > -     Explore the codebase more, focusing on environment-related co=
de paths.
> > > > -     Document how each global variable is used and how it can be m=
oved to
> > > >       repository settings.
> > > > -     Study Git=E2=80=99s Coding Guidelines and the Pro Git Book to=
 align with best practices.
> > > >
> > > > ----------
> > > >
> > > > Community Bonding:
> > > > (May 8 - June 1)
> > > > -     Engage with mentors to discuss different environment variable=
s, their
> > > >       dependencies, and the best approach for refactoring.
> > > > -     Finalize an implementation plan based on discussions.
> > > > -     Since I will be on summer vacation, I can start coding early =
and make progress
> > > >       on the project.
> > > >
> > > > ----------
> > > >
> > > > Coding Period:
> > > > (June 2 - August 25)
> > > > -     Refactor global variables, replacing them with repository-sco=
ped
> > > >       configurations.
> > > > -     Modify function signatures to pass `struct repository` explic=
itly instead
> > > >       of relying on `the_repository`.
> > > > -     Categorize variables into specialized structs to improve modu=
larity and
> > > >       maintainability.
> > >
> > > As I have said, this is a high-risk task. Categorization needs many
> > > iterations. And we may do this after GSoC.
> >
> > Yep, will update that.
> >
> > Thanks for your review, again:)
> >
> > Ayush
>
> Thanks,
> Jialuo
