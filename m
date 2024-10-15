Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB69178368
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 06:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728972840; cv=none; b=BzKgNHaJk++b1EB2JaJub0j8nnhJEZq8zB6HRscw+TNQUq4eqlcPpjnStyzS3WIF86OWO03TL461VFPdE54hd8lFvfmlCRxEm0LTmri2HElDeFRwoUboR7UTZvUeFh7Bkq3YcduiSbYGWPWK54vvkFXdENQzfWeCdo+s6mrtLq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728972840; c=relaxed/simple;
	bh=J+G2rnZFz7OFBjm9oVY4mIrZJdQCYuYNo+ieC4qH1hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=WCor/3nRH8NXK/1LL+zXxXwubrBY8UmAf23CMVCGARzjDPlVpXXVHKu8YWsvZ+UkcYJlmD6APU2pWqXbTidk2r83lcQ/OTQIdgehLvH/yxWV0B+USRh6aHvZYJp2SG+TXaW6Ic+dwk8bC6s7pS/CyCfZxFYM4YfotFgeCNhWUSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cbf3f7272eso7281206d6.3
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 23:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728972837; x=1729577637;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQAGXMuhRCK7E1d6L5d+BAu1+Z37/txbDS+BwKoBep4=;
        b=Pqpikh4xbZGyprem4+e+XtN9hyJxckQ7Mh1QSTI6qsa4KdIhRUMfqTzJpoWqBz3N1N
         Xpk8esSIEGDVMPQL+yTjLFa1rAbU4kg4fBlnC50RDwnHsG2QSiBOPCU/B7MFlSZkoSjT
         GClXY/CnNcQ8MkzOWfo3295v+tji8ifeb5fafEt4zTV0jb5gWcdhkcYmLzuQrfq3eB5e
         bBGldjLYSd+JeMoL1QOQAkLBQwMnV4xa0subkDIr4Q8YBShaRe8i+EOTzqQyCRlcwVk+
         nWkYcs9xaNYHsTYzoaABEAwuALidbAfm2+ugYWo9RxtMz2jsh3Ihxpa0LIhjlVg/cV+M
         jM9g==
X-Forwarded-Encrypted: i=1; AJvYcCWe9iMUMI7snh2yctuUqvyxtjQevj3b18s/bloHbgfnhZYq4Io/mN99bYyDkgaH3CQqmJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/0vLAJ15h9jaNdpScHK4c+lKkUuhQ4NO2ZRJb7ZmgI+i8yhxE
	a57vw1ZThG4jM9eQCHf1KD2CcClGH5ZWmI18hCuXU2z9XOXCTIFjKjfuqbv1uYDKSSJFGjLdMk8
	jO2UAv0m4LLItpcgEygc96R6ms7s=
X-Google-Smtp-Source: AGHT+IF8e8I3Qwe3LsDOLJvJGRO9HzFfmU27oUVs0YkGCzZQDKHtFF6aVu0wryuZ6AYhWrCRgAB2+8xI1j8HhTKhAl8=
X-Received: by 2002:ad4:5966:0:b0:6cb:e610:f8 with SMTP id 6a1803df08f44-6cbf00445fdmr83489136d6.12.1728972836719;
 Mon, 14 Oct 2024 23:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
 <20241011074022.GC18010@coredump.intra.peff.net> <CAPig+cRmyZhq1qtomTFP7p7XMqrCP8-u7ah8D2+yUtrL880y7g@mail.gmail.com>
 <ZwmEDt7ftJabvMUH@tapette.crustytoothpaste.net>
In-Reply-To: <ZwmEDt7ftJabvMUH@tapette.crustytoothpaste.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 15 Oct 2024 02:13:45 -0400
Message-ID: <CAPig+cS0vkTXeZX7qt6oOq3QpkWovfJnXuH7c3JtyAKOfnq1Ww@mail.gmail.com>
Subject: Re: [PATCH 00/13] Update versions of libcurl and Perl
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Eric Sunshine <sunshine@sunshineco.com>, 
	Jeff King <peff@peff.net>, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	=?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 4:01=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On 2024-10-11 at 18:09:14, Eric Sunshine wrote:
> > I may be in the minority here, but I'm fairly negative on this entire
> > patch series. As you say, supporting these old versions is effectively
> > zero-cost, so how does this project benefit from these changes which
> > potentially "break" Git for users on older platforms? I see no upside
> > here. The cover letter provides no strong justification for
> > (potentially) inconveniencing people; the argument about being able to
> > utilize more modern Perl features is weak[1] at best and is not
> > convincing.
>
> It is not effectively zero cost.  When I want to write a patch, I must
> make sure that it works on all the platforms we support, or my patch
> will get reverted or not picked up.  That means I have to expend
> additional effort when adding features to look through the supported
> versions of our dependencies and either conditionally check them or skip
> the feature.  Sometimes I have to rewrite that feature in a different
> way, or ship a compatibility stub for a system that doesn't support it.
>
> I have actually spent a decent amount of work getting things to work
> across older versions of software, both in Git and elsewhere.  The more
> we honour the policy we have already made and agreed upon, the less work
> Git developers have to do to support adding and maintaining these
> features.

This attitude feels backward to me. It says that simplifying life for
Git developers ("the few") is of paramount importance and that Git
developers shouldn't care about inflicting pain/difficulty upon Git
users ("the many"). This is especially disturbing considering the size
of the Git user base.

Instead, for every proposed change to Git, we should be asking
ourselves what possible positive and negative impacts the change will
have on *users*, and if the negatives outweigh the positives, then the
change should be considered with a very wary eye indeed.

> > Although brian is (quite rightly) concerned about security (or lack
> > thereof with older installations), it is not this project's
> > responsibility to "force" people to upgrade their insecure
> > installations. And it is not at all uncommon in the "Real World" for
> > decade-or-more old installations to be running in production
> > environments, and programmers need to work within those environments,
> > however, those installations are, for various business reasons (such
> > as cost-effectiveness and known stability), unlikely to (ever) be
> > upgraded to more modern versions. I, personally, deal with such
> > installations on a very regular basis, and in my experience, the only
> > time upgrades are undertaken (in production settings) is when the
> > systems break completely and there is no choice but to replace them.
>
> It isn't acceptable to run systems that don't have security updates
> applied that are connected to the Internet, period.  In this day and
> age, it's very easy to have bugs in things like TLS or HTTP libraries
> that are written in C and have security-sensitive implications and that
> are exploitable remotely.

I don't disagree with your opinions about security and that, in an
ideal world, businesses should take these concerns seriously and
should upgrade. However...

> No matter how stable your systems may be, it's very easy for unpatched
> systems to quickly become part of a botnet, which is a problem for
> everyone else.  Typically most businesses that sell to other businesses
> have to be in compliance with certain security policies, especially if
> they have user or corporate data.  My employer simply cannot refuse to
> upgrade because we risk major legal problems (e.g., GDPR or PIPEDA
> problems) or loss of most of our corporate customers because they won't
> or can't (due to regulatory requirements) do business with people who
> have lax security.  So I very much doubt that there is, in the general
> case, any compelling business reason not to upgrade to a patched OS.

In my experience, it is very rare for the non-technical people
responsible for allocating funds to be convinced that money/time
should be spent on upgrading *working* systems. There are always more
urgent tasks (in their minds) which take priority. So, while there may
not be a compelling reason in the ideal world to forego upgrading, the
real world works differently.

> Certainly we cannot force people to upgrade, but we also don't have to
> support those people.  Git is an open-source project, and people are
> welcome to make changes that they want to it without our approval, as
> long as they comply with the license.

Ditto what I said above about this attitude feeling backward.

Moreover, as mentioned previously, it is not *this* project's
responsibility to be forcing people to upgrade their insecure systems.

> There's also discussion about adding Rust to Git.  Assuming we do that,
> we're going to have to work with Rust's requirements for OSes, which
> usually follow major supported distros (for Linux) or upstream's policy
> (for the BSDs).  So we're going to have the same problem in that people
> are actually going to have to upgrade to a supported OS, except it's
> really not going to be optional because the code simply won't compile.
> We might as well get used to doing that now.

"Assuming we do that" is the key phrase. There have been proponents
and opponents, but almost nothing convincing written in favor of
adopting Rust according to a (mostly) outsider's summary of the
discussion[1]. The only properly compelling point in favor of Rust
came from Elijah; all other arguments for Rust had the flavor of
someone evangelizing for his or her latest favorite language. We've
seen such evangelizing before: numerous times with people insisting
that Git needed to be rewritten in C++, and (somewhat) more recently
when Felipe insisted, not only that Ruby be accepted into the project,
but that parts of the project should be rewritten in Ruby. But mere
evangelizing is not convincing. (Elijah's support for Rust was more
compelling, not only because he was not evangelizing, but because, as
usual with him, he backed up his position with solid, well-reasoned
statements of experience directly applicable to the Git project.)

[1]: https://lore.kernel.org/git/CAPig+cQtxx=3DfQM2xHSt8AsxyWgjSiS9Kd5PtjA+=
jDoK5s9xh4A@mail.gmail.com/
