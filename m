Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6091607B9
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553353; cv=none; b=TO3X24kWRveOpnup0xMnOPxjJjp62jHqYj20kCMvL1dJm/Y3+OruBMZoR+oa0k8gZ+nLUeBrfDlMZD0HEJC4NDzZ/mFDPdrUaOrTOqjzMIXwNHPD8v3rZUICJ9Qe37J/C8uOjaunTpoo3BNuAp5eqoZiqtSyYSbvzH1M/z63nAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553353; c=relaxed/simple;
	bh=ieFEAguVGZNsOEJvp4Bt/6hEunHYAq/vxDx/aja8Bc8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=M1sWCzi2cAa12dQ/Sgdxgutx2i2+4uYLzp6JvcECzJvonS5pi/0svjGmwsMGHs8wdNinP3fN/7Ao76/MukfNIzu+0AK2TdQId59i63ew56fCgSPP9t01Xrisbyv7TYxTrIkpHT++DhfBXiMglIuuI1TAi2ZowHADrGrhRUJ4uWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=h5R5rWsW; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="h5R5rWsW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1723553329; x=1724158129;
	i=johannes.schindelin@gmx.de;
	bh=Rq/vMmh1jmYTpCPGSLBYYPj4DxIFjPPx0Wb0JjCJdjM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=h5R5rWsWCKNdov7FSATb2a4EDYny/RlMPBgiZE3hbZZy38Jqf5LZVSrqxpjS3+5M
	 1Afr86yBTJuHotwtpd96fNcmDeDvXi5fYpZYJz4kYuG+WnV2Zfw22ciB7Qp9GD2X1
	 OsuocZtSXIDwALNFe77+Ka9TT6Zi4n3Htwrm2UyG1kA4NKglcEiKnmTH0HkeHiDn9
	 9gQbylbghnP/kKEl9DNNWru6nYt99N7a1D58bahoG2Ky218RD5KZFxDGwpz8IzdqV
	 PEAZ2YoZ25LHSY6pmgZ6nrFFge3dR1PLJTQy3eiOavFfQlYhCqW9V2o4F2k7BP90D
	 oGLiYDHlVV1lgEm9JQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.208.78]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McY8d-1s3QLM2h3t-00cmRL; Tue, 13
 Aug 2024 14:48:49 +0200
Date: Tue, 13 Aug 2024 14:48:47 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Phil Sainty <phil@catalyst.net.nz>, pclouds@gmail.com, git@vger.kernel.org, 
    hvoigt@hvoigt.net, me@ikke.info, rafa.almas@gmail.com
Subject: Re: Adding nested repository with slash adds files instead of
 gitlink
In-Reply-To: <xmqqed6zht04.fsf@gitster.g>
Message-ID: <8436c2bf-45cf-8009-14cd-c5ca708ece08@gmx.de>
References: <s5wr0azfeh9.fsf@catalyst.net.nz> <xmqqed6zht04.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1532055212-1723553329=:117"
X-Provags-ID: V03:K1:jL3Zu0x1qOqE50LkB3Rya8j8lHHof4X4L7NIACK/hyNbGUyFMbS
 ukXe3Tj344W7N91/8Jc4Uipip6MR+BkUi+Z5PIFQa5Cdvyg27lsbAVq1BL4H8W5kRAL71Bt
 SE0/hQwuhQWJi7A9WYaoqlNs3wQTwasXCS3VUWqYilOuwhTLN4yVu2ihaFaqudoO7Ve8gf2
 drcPM0satJjV0vPwkUVLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4qbd22uAyq8=;nIDhwp7muwIEYgnXaYs3RWlmEwq
 TEVGUYJ2gDqeb+3ELERFSDjVyyC74S82aja1Ppk1bEGBIBEpgaIfEJa5NjNYA3BnJBfRLttHC
 ftBSSze5iinFTAxEV3fzXCdGCx5vt54ba3rHHY55Y01cneKBKRyBQmXIIg2KjyGBZ6yrN6aVm
 kRR0FFMco8yH59A0fcX0B6fEdG+HxjTU0wezAvY6HawSCmKmY/fvnQbOcQOz5mmTQvrsJI1NT
 Ut0yLVyzPsRmEM4X6ZcbijOSt2HGV2SzTcsp4zOQ51mha/aTY2fOrdkNAAS/mAONF0RwYQ7V2
 z9kOg66Lh8jFc30L0a9f1VK54XSGY320LX7Em9W90N4RS0HDTvVi7AjaUkckgmPDp++E2UNKc
 JSXmSPIezy2yNtWeEINfRFmKzhgGkr0rFW2ffxawuWWiOUaENit/rMy4YMi19ILxCOUqgnsAs
 n6Nu/60iK6N5Y15TKGRlHip447rOASPJUhQ1nL4nIw/O1wvcG8NWZgXbjPjAiKx52yq7q+LOA
 viPFT8JIuMubwPoAP/2/7LIQn9eh7YR2ifwgthNvh139o28Xz66K1u5rruTTatUNo6URqxyol
 L7+sgcRRu+0YBi7Lvl8k8ddY5JiAluRiIphLTR8A9TeKK+BlK8s7+LPyV+hL45saGNEYQA97Y
 WZP/l4XSWYe6Mhn7340hLJxAMte7JVnPpz+pMJ2434PKHaW5Y8dDHPHA0qLr29cbR+G2McT2t
 BNRlkAIaAxM2QntVc8AGrOsVfc5SwXiB1Nl9p6BGuDHkS7+8J3SW8wy1S8zOYCYKONcXHzOIy
 cKQd3YTLgMCQmrfmtNFolY/w==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1532055212-1723553329=:117
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 8 Aug 2024, Junio C Hamano wrote:

> Phil Sainty <phil@catalyst.net.nz> writes:
>
> >> On Wed, Jun 20, 2018 at 1:55 PM Rafael Ascens=C3=A3o <rafa.almas@gmai=
l.com> wrote:
> >> > On Wed, Jun 20, 2018 at 5:39 AM Kevin Daudt <me@ikke.info> wrote:
> >> > > What this is about that when doing `git add path/` (with trailing=
 /),
> >> >
> >> > This is what I was referring to. If you search for 'Fake Submodules=
',
> >> > you'll see that some people were/are intentionally using this inste=
ad of
> >> > subtrees or submodules. Unfortunately the original article [1] seem=
s to
> >> > be dead, but searching url in the mailing list archives leads to so=
me
> >> > additional discussion on the subject [2,3].
> >>
> >> Abusing a long standing bug does not make it a feature. I'm not
> >> opposed to having a new option to keep that behavior, but it should
> >> not be the default. If you use it that way, you're on your own.
> >
> > Was such an option ever worked on?
>
> No.
>
> I do not recall hearing anybody who have been active in the
> development community saying anything good about such an option.
> For the past 6 or so years, nobody who actively works on git thought
> it was an interesting and/or useful thing to work on.
>
> I cannot quite say that they thought that it is actively a bad idea
> to offer such an option, though.

I have encountered the wish quite frequently to be able to make changes in
a subdirectory and have them reflected as a commit that is both part of
that subdirectory's revision history as well as part of the containing
project's.

The benefits for monorepos, and for reproducible builds, are probably
obvious.

Sadly, I cannot think of an elegant technical design, and this is not for
lack of trying.

There are lots of projects I worked on that would have benefitted from
being able to track a subdirectory both independently as well as within
the context of a containing project, i.e. offering to view (and
fetch/push) the changesets in both contexts as equal first citizens.

Even the Git and libxdiff projects, as a concrete example, could
potentially have benefitted from such a feature: Ideally, it should be
possible to push commits made in the `xdiff/` directory not only to the
git/git repository but also separately from the rest of Git, say, to
xdiff/libxdiff. This way, the `libxdiff` project would still be able today
to thrive as an independent project.

The only way to implement a feature like this that I _can_ think of is to
generate duplicate commit objects, though, with a reference to the "inner"
commit stored in the "outer" commit object. And that strategy breaks down
really quickly, no matter whether I think about deep dependency trees or
about integrating commit histories that have been made in the "inner"
project separately and now need to be merged into the "outer" project, and
there are many more processes for which this strategy strikes me as
inadequate.

So yes, I think that the idea per se has a lot of merit in the real world
out there. It's the implementation details that are an obstacle.

Ciao,
Johannes

--8323328-1532055212-1723553329=:117--
