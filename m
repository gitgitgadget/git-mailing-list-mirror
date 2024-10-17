Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C066219340D
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 06:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148398; cv=none; b=f/5IGHQPJNr0wlXNy4PAFEpHTwoq4t+9LQZoiUXTzeAo+w5qfhHnkjT7be+lb6poHg4vR2bPPhdsp5cYMeihf03QR0d8/y6yo1iXwQcAZUOUF5N67o+NoCz72dW413gjpy4he63jzHUMQr5bRJBpbeHQny2qTEMHsTGhIvZer/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148398; c=relaxed/simple;
	bh=iFQ2x9iFvnWRxdoQXEV9WPTHv13+II2LVpKqlqv5Xr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTXjuj/zordCu0z8UampGf41RbRW6vtvUO5Tna5UjuMYKbj6H8SnevjMqkaUJM6ekX83PTNedq1gihCsFqIryt9EFkiSI7g9h23hwt+FTpgJBUOZICXj+cCm/7PDwtBm3QMW9F34Q2xb6k3is+eR7eJKrXL3IXYx2pv9xX5Nxmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=qkewzYCd; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="qkewzYCd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729148378; x=1729753178; i=tboegi@web.de;
	bh=o4ONWl920AJbkoSMBps6I1zKzon+Bb3fGc0ipOIPb4o=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qkewzYCdb8WTY9Lb0QuN+zLc290s1gS399bkY/elRoxW67WgbvjTFM9vEU/cdp7/
	 Gnjdlhh13uDzqrqb6LzNPDkfap8N9w/Kfi8gIZDbp0vADeTg3Na7t/tdYrRYzVfDZ
	 pAo80RRJ0u1DH3bgShzkH0XfOHUzCHulnnv1BeklHLaWI5h7AVGqwwQ5L+roz6sxR
	 Zn2HhZqhY+B+8+r2pfdG9i1QodQqzMRJ0Yzkmbc4ZOcmspdqNwXjK3sROZ6DgFI3/
	 2mDmTJbG1ZQ8LcnxA2Rsb3Y655QGwFmWlFtoT7CzpVDCUycjX/mzvJENWddTKoAXL
	 bWMlDgu8m705XHKGxw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MA4fW-1tCr4q0BSs-00Bby0; Thu, 17
 Oct 2024 08:59:38 +0200
Date: Thu, 17 Oct 2024 08:59:37 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Alejandro =?iso-8859-1?B?Ui4gU2VkZfFv?= <asedeno@mit.edu>,
	Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	sandals@crustytoothpaste.net, asedeno@google.com
Subject: Re: [PATCH 0/2] Restore support for older libcurl and fix some typos
Message-ID: <20241017065936.GA16141@tb-raspi4>
References: <20241014131346.3556163-1-asedeno@mit.edu>
 <Zw23K4zPN9e+JyNA@nand.local>
 <CAOO-Oz3eQ+fpWU3qLHtF5oCxj2ieoc6P4R+iKJTG3DoWrb6W3g@mail.gmail.com>
 <CAPig+cRENnd9cV5yFfVVwbuux84k10_vcht-TTtKGJmRNYEttA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPig+cRENnd9cV5yFfVVwbuux84k10_vcht-TTtKGJmRNYEttA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:/77yooN89IMk4sl77eN0LtvtMTiFgI73NkTN0fQShep/UFHSb9w
 iTgByK//ABeoVJtqJGC2akdHpfds7maSRgW6OpbYjr0HKKycmDCq3gU30mBBPdEVxuT9dUa
 ykhpYxl7NlXUjdxojb6mSE2AeHYY6JiCu5vGSDJjG5mnWUoXoUMWYA455FhP3cJgPbOIst1
 swJOXqBOihY9LW6f1IUfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:z6Ftom3bWhw=;s3O9q5WSqZostb9go3e0BE0ss3o
 EZeJnq+7aaOF6e5XjXXYMCJJjKpcc6Iiqf0Z2fmlhshZYeQ2Zrr+J800JdwJkCNs3NgGrPRfe
 ByPyUMrfnApoSQ9DUDM60SWT1RysXVCGqFJ4HfxDc+2jqAOkI25OnRMc8z5qhdgwBbOEDjgVF
 pOm0ccQRRNVToaOTtpspLyfNbVBQtgeh3S7ftc8OSwq5ExoaDLvm5aDCArBEnnrcquhAL0Oy/
 iw5RIWLAOMTWcZYDjKJvgDFzOR9B87TPi/pB7dwBROdAVUFCoUWgbk674Dd0mGtXlM/hvhXaa
 xIYZEg5QuH7hiE2te+SU4Ex1M7NXJbhcdJkw7+Ohg2r18OruMIxdFK4Ql+xu06rQf5FpVyc4M
 Ve11t350RWs3t42cDk1YU0YTvirW/h2dIxIQA3wq13LDSc0UYrK5evHin8U/FcAxDub7h5Tmw
 UzdEErF9gJ4VjcMLd+tlLyJQWjzdXxl0Jy9oxCD6s9d5wd5RIU8SIRK76BQ5DzSSY8GeZZV/C
 VZyOcST/8iPghMC6+O4bK9W6kyZxK6lRreEHDBg0xd83Ka3YFPfSq4MUtYLdK1HDvSMK6hf4h
 tnyixDSfddqB/DfBQYc4Xurci+lK50mwScuRxCawmzNiWGJW4cXGurJbsIHtA0Ogzg6h9R402
 rxRn4es4XitEKfYu1FEG4TdEIuhwLg/xtca+Z2IysxWppi/R/FVLpukVFnsFwgPwpbEyJcfbp
 SYy4LMFs9vde2zc15QqLaie6xD5LD/xbqSxTvTO4/+79dG9+loEanzX8A8e6Riy5b0oIS7X0N
 u5r6B+f75nha4OR4E8yQH6JQ==

On Tue, Oct 15, 2024 at 02:29:33AM -0400, Eric Sunshine wrote:
> On Mon, Oct 14, 2024 at 8:51=E2=80=AFPM Alejandro R. Sede=C3=B1o <aseden=
o@mit.edu> wrote:
> > On Mon, Oct 14, 2024 at 8:28=E2=80=AFPM Taylor Blau <me@ttaylorr.com> =
wrote:
> > > On Mon, Oct 14, 2024 at 09:13:44AM -0400, Alejandro R. Sede=C3=B1o w=
rote:
> > > > This is presented as an alternative to the patch series from
> > > > brian m. carlson that bumps the minimum version of libcurl
> > > > to 7.61.0 [3].
> > >
> > > This conflicts with brian's series as you mention, so I haven't pick=
ed
> > > this one up in 'seen' yet.
> > >
> > > Could you summarize why you think this series is a better approach t=
han
> > > what brian has posted? On its own, I do not understand the motivatio=
n.
> >
> > It's a question of preserving compatibility vs ratcheting up minimum
> > requirements. Both have their merits. I sent in this patch set after
> > seeing some mild pushback to brian's series, just to present an
> > alternative. Maintaining compatibility with older versions can be a
> > burden to the project, though I think given this patch series, it's
> > not a very big one. Ratcheting up the minimum requirements can be a
> > burden to users stuck on (or choosing to try and support) older
> > platforms. At some point the burden on the project outweighs the
> > desire to support those older platforms. Where that tipping point is
> > is for the community to decide.
>
> For reference, I'm the one who pushed back on brian's series. The
> "push-back" subthread starts at [1].
>
> [1]: https://lore.kernel.org/git/20241014132856.3558224-1-asedeno@mit.ed=
u/T/#mc1180f00cf52de4e9bae334c2cd5abd9a160dbbe
>


Being one of the people who has to work with older distributions,
I think that I would support the pushback.

There are many machines out there,
which are still running in production with old installations.
In my case it is a Centos 7 machine, coming with Git 1.8.3.1

Out of my head, git submodules didn't work (as good as today),
and even things like git -P didn't exist then.

I may be worth to mention that this machines are protected by double
or triple firewalls, routing tables, and whatever is needed to protect
them.
Maintaining production software and hardware, systems using specialized ha=
rdware
with Linux drivers dependend on the Linux kernel is daily work.

And here tools like Git are needed (and appreciated).

My view is that the new developments can focus on the "latest" distributio=
ns,
and if some comes along and has a patch that make Git
compile and work under an older system, and that patch does not break
newer systems, it would be a good thing to accept.

The seen branch from October 11 does not compile (any more) under Centos 7=
.
One problem is the curl stuff.
And then some warning, missing a prototype for lstat() in  clar.c/fs_copy(=
).
And warnings about missing braces around initializers, nothing
to worry about.

Lets try a summarize:
I can volunteer to compile Git from seen on this Centos box,
lets say once a week, and report breakages.

Other toughts ?
