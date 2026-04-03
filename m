Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59603310651
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 10:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775212757; cv=pass; b=bjgnC/oMIw+0BwPCB4lB55ZUE85PUcGUfMDURAPzttbwSIj6CYJv5FV+SSKZiz9DadHTq3JsL0wpcfqWZ5BvJCm/SUNUPC7huhgTWfE0qTuxbL8lPZfPOjyLMPnu9NDGwx+5ebnlh8WgT3my1KLaApKLrfF1jQf1WKqaUWa9bWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775212757; c=relaxed/simple;
	bh=0Nqp1kGpDcHPliGT++8H1I4anAXHT+iYDZV9Fg8xckY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hr+IQjB3z+DOgDZJTuqM6c3/2FsyU3+4Zcxij5aEDsENvP14CqEyIGDmw+Czmos3CdRBZ1X6s2rKpyI7nmuurk3A5t8EYqhmkTy8427LcUhLM+i75VWtGqcgSysXBTdiCG9KLwbr6DmpzMxXp16diMSUye4TbiW9oG7LtLUN05s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwekg4wt; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwekg4wt"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50335b926c2so15020341cf.2
        for <git@vger.kernel.org>; Fri, 03 Apr 2026 03:39:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775212755; cv=none;
        d=google.com; s=arc-20240605;
        b=S+ZnPy6HoOB1UAzFS7tKee/XRL55ZvjVdkZsT3eJhHQN9qP6kykcOF1n7auEkFxqo2
         C9klazcAWaesKw5Lqj+PAY11LoM5gBnm+mEcuFxIpZPFB3caZjGEZqQ22nFAs7+2W3vx
         KT8+QZdEQC15hII+hpCIISQYUOAie04gpibjynaqbMPXlbs6Z6yUlL3UgNKGa9+qfyHY
         hyPcHvKRRT2MRSxdIy8B+QE6yQMdmOZ+Z9KcKLArMdczpu74H62WaTN6lrYxbwswv6rI
         WgRtH9eCYsXbTLk2zixjyqOJCIOoCl6aSHHisczeEIbP6J7DAwwy3PQWGb67vNh/oUuY
         jMyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0ph6hvBydX6q7VVyhG4/3xQHKXPQrilQEGJsJPH97Ns=;
        fh=cH0ddPfyM2iA0RtCDtDYDi/pZLxP1ojFPrUDEjSgDio=;
        b=E/xUvNn8sgW0rWnHfA7qcG+XaNnTdA6xg+WZPvkAg6QEJ05vvl2Pky63XFKI6wP+1y
         V5SM7w6XmLziP2fVGMr0ZrsXxVm++tQVqntgAbsBMl9ABFgIL6YUV+vgkzFAA7muB/cm
         JtbFd8hTQ018fh0jd0dffApbQY8wAiIzmUR17ZpodhJ/Qkrtu0SpoMcpAvi5uPoGSbZQ
         kfeQ7dC1TmewqpaGMC/D9zBSd4Cvxqh9Ie6h9W7c5pviiajN/891mDmh4VrZHCpnqv45
         f5KeLma3Dl0SqG6pA+iUgFiV/yTPEIp51T5sm5kes4e6BuBWjCTbaeOG9NM3bcRo+SpC
         +D7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775212755; x=1775817555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ph6hvBydX6q7VVyhG4/3xQHKXPQrilQEGJsJPH97Ns=;
        b=fwekg4wtPlzVVo5KLII+QP+VZ7Cb+OGqjnPYCb1xgMA4Up41/gAQ8CTMg9mIbnNnWP
         JHy35D7Q1X+wYXi+1yfVaSA/gFxFfFLIAdYkPtEgO2913OVh1Kbe3WShTYTPi8JcY9n+
         dkE9IsJs/VoUoMUFplLbZVcFSvOwY6YF+aIYlsm4gk+EZp20RtlYazgf3rPzGI8IPXCV
         GnNh29ClJs1B+Q5Ul1jyLQdCz7Gx+A1ajWGwMMgL9nwY7V5Vea+e65RTd/tXNk2arQ0D
         EJg8E4KMqYI5DpO0UNBmRWYcfmGQjyqPn/5UjJnGhPCD5wF+td4yDsqHbgqNtpbYQrAX
         RG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775212755; x=1775817555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0ph6hvBydX6q7VVyhG4/3xQHKXPQrilQEGJsJPH97Ns=;
        b=MIMxNIKwrVdQgIttrmSYqRKCs09mmARosqLOz7gsKdAxYNQoWPmDvYG6X+rycOwIEd
         4+VHnuKNGGu2Ha5oeHJ4JvSdSEzjB7dnUREoAd12vQd9m9YG/5LQpvxtQXMChBGvpqQ+
         CdouNwUupvF9i3MZ+yRTYzc68cd961T4VwVfHIzK2eHHkzrTHZ9pJOQ+8GENSdiRygr4
         Tga91bDjvUbIFo0aPSRWt2QSpxZtWenXhQwU6XeHxdFccHci/W2pO1hFneTnn9gQDl/r
         P9cOYef+O/cD4YMQt0TkZq9YrIRH1GO3gjxSf9hcuaBeC2X3VNgW04KF5ulSTNEFdPFv
         XsWg==
X-Forwarded-Encrypted: i=1; AJvYcCXkpKdhfeMAZyu0LrTfZ8HauN3+hVQJ00KtHuzqMgvCU4bnhqFtm5uyNqBL7ULrDTPm0M0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLqApaK4bX5iv7idq1i88+9mPHAUrgXyneMEoMrXqNGsv/7OT9
	bAmgHzGXRy9g+N6eu0UI8kcW0IaD1LD+yEHkQ7X0Xt8W5/5R+553YIr+n1+u0tjvpNc9SO/+fUU
	NZViZhKjgrIe4ipKq02i0R3GgkFCciKY=
X-Gm-Gg: ATEYQzzISm1Tn2cjLf9HOITCicVd5ccWh6AxI9TdTFdA4MEJXy79FLStNHMkqKG8cm1
	FG1yeDNNK0sfGt2PAKwUXA28VzsFdXQUNdl//dfemuFYKEli+dTvGu2GmCJuzD6rLSnTD9UJ60A
	5Yhb3lr6cNyQqrFItkjaa6JajhWw9Ilzfyfd8VbHvmekoEsie1GN1n63ZFzMeLLVcrAD/YspJB1
	XxVxldPAIZUl2x9hP+pCOsl1szpLNWkr5lVsPXZ6U41qkMnQfm3x6TXbUuWNMks1O/Va+EWvcXF
	qStvkLFFLXqRE0C0Wnvj9smuo3dV+BkPpPuFtTkIWA==
X-Received: by 2002:ac8:578c:0:b0:50d:6ab3:1acb with SMTP id
 d75a77b69052e-50d6ab31ba5mr11404011cf.41.1775212755202; Fri, 03 Apr 2026
 03:39:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260329101725.1092900-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260329101725.1092900-2-shreyanshpaliwalcmsmn@gmail.com>
 <ac4aZRveWXjOtxgB@pks.im> <ac6K5UnVdw67Rfpy@gmail.com> <ac68ME2j5CXzVgxF@pks.im>
In-Reply-To: <ac68ME2j5CXzVgxF@pks.im>
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Date: Fri, 3 Apr 2026 16:09:02 +0530
X-Gm-Features: AQROBzCSNKPX50YP5fTpC342KCAKOuhqPDPmB9i5-vRVg26s27uFBMjhRxQDQ_c
Message-ID: <CAPYXD646gcj-fmy0fqZUrKsSt1=+ZW4iRsVuJoLf0yUyUddigQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] refs: add struct repository parameter to
 branchname helpers
To: Patrick Steinhardt <ps@pks.im>
Cc: =?UTF-8?Q?Burak_Kaan_Kara=C3=A7ay?= <bkkaracay@gmail.com>, 
	git@vger.kernel.org, Jeff King <peff@peff.net>, Tian Yuchen <a3205153416@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 12:28=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Thu, Apr 02, 2026 at 08:03:45PM +0300, Burak Kaan Kara=C3=A7ay wrote:
> > Hi,
> >
> > On Thu, Apr 02, 2026 at 09:27:33AM +0200, Patrick Steinhardt wrote:
> > > On Sun, Mar 29, 2026 at 03:46:39PM +0530, Shreyansh Paliwal wrote:
> > > > diff --git a/refs.c b/refs.c
> > > > index 685a0c247b..5cdc8858c5 100644
> > > > --- a/refs.c
> > > > +++ b/refs.c
> > > > @@ -758,10 +758,10 @@ void copy_branchname(struct strbuf *sb, const=
 char *name,
> > > >   strbuf_add(sb, name + used, len - used);
> > > >  }
> > > >
> > > > -int check_branch_ref(struct strbuf *sb, const char *name)
> > > > +int check_branch_ref(struct repository *repo, struct strbuf *sb, c=
onst char *name)
> > > >  {
> > > >   if (startup_info->have_repository)
> > > > -         copy_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
> > > > +         copy_branchname(repo, sb, name, INTERPRET_BRANCH_LOCAL);
> > > >   else
> > > >           strbuf_addstr(sb, name);
> > > >
> > >
> > > I have to agree with Tian's comment on v2, this part here looks wrong=
. I
> > > don't think we should depend on `startup_info` here, but we should
> > > exclusively rely on whether or not the caller has passed in a
> > > repository. And that will likely require a bit more scrutiny to figur=
e
> > > out whether there are any callers that shouldn't pass in a repository
> > > because it's not initialized.
> > >
> > > Alternatively, we could go with Tian's suggestion of checking for `re=
po
> > > && repo->gitdir`.
> > >
> > > Patrick
> >
> > This approach actually leads to a bug and segfault in a specific edge
> > case when running 'git check-ref-format'. The current tests don't cover
> > this scenario, but they can be extended to catch it.
>
> > If GIT_DIR is set to a non-existent path,
> > 'startup_info->have_repository' becomes '0' but 'repo->gitdir' still
> > holds the invalid path. As a result, the code enters the first conditio=
n
> > and crashes. The case can be tested with this command:
> >
> > $ git --git-dir=3D'non-existing' check-ref-format --branch @{-1}
> >
> > Modifying the behavior of 'repo->gitdir' might solve the issue, but I
> > belive that falls outside the scope of this patch. After a quick search=
,
> > I found a prophecy from Peff about the 'startup_info->have_repository':
> >
> > [1] https://lore.kernel.org/git/20190806124954.GA13649@sigill.intra.pef=
f.net/
>
> If we cannot make it work in this patch series, the next question is
> whether we actually want to give the false sense of `check_branch_ref()`
> being independent of global state, or whether we want to leave it as-is
> for now and then do a follow-up patch series where we fix the issue and
> adapt the interface.

I think it makes sense to drop patch 1/5 from this series for now, which
introduces changes to the branch name helper functions.
It would be much better to address this separately after replacing
startup_info->have_repository.
For now, I'll reroll the series with the remaining patches and send this
part later as an rfc.

Thanks everyone,
Shreyansh
