Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D353B47C9
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283568; cv=none; b=XJeyGSHILZWUROMx4TZT1HU74QjMxc+ygRFH/04A5vGjJfiGrbVf8m5zwgTvkNXIad8zpBFsBGBL3GeqQm0LZwh+QzJx3pVEAv9aWIaDuBXBkVBNs8xcdlvbPp83Zw12HOL+hmjZLgTq7jr9RiW1tF9WucgLJ39a78FiZBnaQ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283568; c=relaxed/simple;
	bh=WncCQ3w0/gwe4WYFLCgvo8Trb+Fs5DipFz8Yf1PH36Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Mr0FRltv5urUL5Vkp688Mx6KJSGqmnobZzjcmw7OR6esdCkKHxzZTi3xl/p1zgaZJHWVOie0hgPuMqUa+2xeLpClpQeU00HjCgJW3KE4Z/P9bQ/4k15gdJBtYfAglWxFUjuOn2WFg2m1oMreL/D1uGM39CUu/jwhkpxFmDWArmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=llx6WknN; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="llx6WknN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774283563; x=1774888363;
	i=johannes.schindelin@gmx.de;
	bh=Xec++i+2XYLuU3NkeFFPsU54D1kU02kQyLq9w62KUlc=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=llx6WknNzjKaOQqqxH7OCyrNbf+FBaCmgijfFegLebWTS+spGD7Iu5tIDq4IdVnd
	 lyn92qKMQaXVzArZgPYVLckQme6TqH38BQZrJ6C+zao0oEEXQP8Ob4lCwAzcWpUgq
	 OPc5lOyDNR6eBq/z/ZJRz/PFCDPubev5joMF1T323Id0JzathcTWZ0EjW6cpzpvzu
	 P/sP6PH+xKLjeOxKyG2jfbgS1c7GVCN9ACB99DoKLzTi/9XVYwseSMrv+DY5th8nD
	 VOrdQhV/Wh6exQJxHsMitwnzt06lWjF4Kffnq6Dw5qyr2Vy9Ar7FESGvTpVUmccP1
	 3BTE3Ze2ozGGX7BxfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsUv-1wLSeS17Xj-008imk; Mon, 23
 Mar 2026 17:32:43 +0100
Date: Mon, 23 Mar 2026 17:32:41 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2026, #08)
In-Reply-To: <xmqqwlz392k0.fsf@gitster.g>
Message-ID: <458ad3c1-96df-4575-ee42-e6eb754f25f6@gmx.de>
References: <xmqq1phc9x98.fsf@gitster.g> <6c108696-2d41-4fa1-9662-fbf6db97f767@web.de> <xmqqwlz392k0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-206823970-1774283563=:32601"
X-Provags-ID: V03:K1:snlLTT6YF3tUI1o4JCCCB/jXnK6VO/w4PZRB0Lt9gsfrYLBU7Hx
 lsxQrhthT61lEXSwIgZY2nD8hHZyOtPKzrjZlCVgJNctfGtY7G6YSzwuqWNj+B+Uh2AM4yr
 f7aRS7IOZTFU5rv0rh3Yd6gCGba1owFCrgplnlL3NXdv2C2uh9zsGbq0ANZR0DWGEezhwUq
 LiCfVVrr109d90CserAQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9NhKGFpOCRo=;QOXKapqSDG6oK4D8EtTbVig0TUO
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-206823970-1774283563=:32601
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio & Ren=C3=A9,

On Mon, 23 Mar 2026, Junio C Hamano wrote:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
> > On 3/22/26 7:46 AM, Junio C Hamano wrote:
> >> * js/macos-homebrew-forgets-reg-enhanced (2026-03-20) 1 commit
> >>  - osx-clang: work around Homebrew's clang lacking REG_ENHANCED
> >>=20
> >>  The build on macOS with Clang is fixed to work around a Homebrew cha=
nge
> >>  that exposed an issue with missing REG_ENHANCED.
> >>=20
> >>  Will merge to 'next'?
> >>  source: <d340af9e-334c-4e81-e58a-fc3dea73ebdd@gmx.de>

Sorry, I missed this side conversation as it happened out-of-thread.

> > This seems to no longer be necessary -- the latest workflow run on
> > master succeeded (https://github.com/git/git/actions/runs/23392330338)=
.
>=20
> Yeah, I saw that too and was wondering if the glitch was reverted or
> something at the platform side.

It was reverted at the platform side. The runner-images team rolled back
the broken image. Georgy Puzakov (runner-images team member) wrote on
2026-03-20 in
https://github.com/actions/runner-images/issues/13827#issuecomment-4096949=
778:

  "We have some issues with new image version(macOS 15). We made a
   rollback version yesterday, can you check if the issue still
   exists?"

And indeed, the broken `macos-14-arm64/20260317.0174` release has been
deleted from https://github.com/actions/runner-images/releases -- the
latest published `macos-14-arm64` release as of time of writing is once
again (the last known good one):
https://github.com/actions/runner-images/releases/tag/macos-14-arm64%2F202=
60302.0147

> > Did some kind soul fix the runners?
>=20
> If so, thanks.  It certainly was not me ;-)

Not me either, but I guess nobody earnestly thought that either of us to
fix GitHub's Action runners =F0=9F=98=81 But I did dig into the root cause=
, so here
is a summary for the record.

The culprit is Homebrew 5.1.0 (released 2026-03-10, announced at
https://brew.sh/2026/03/10/homebrew-5.1.0/), which introduced automatic
linking for versioned keg-only formulae when the unversioned sibling is
absent (https://github.com/Homebrew/brew/pull/21676). The runner image
installs `llvm@15` (keg-only) but not unversioned `llvm`. Under Homebrew
5.1.0, `llvm@15` got auto-linked into `/opt/homebrew/bin/`, and `CC=3Dclan=
g`
silently resolved to Homebrew's LLVM clang instead of Apple's
`/usr/bin/clang`. That LLVM clang does not see the macOS SDK headers, so
`REG_ENHANCED` is undefined and the build fails.

Interestingly, this auto-linking feature was actually reverted within
Homebrew itself (https://github.com/Homebrew/brew/pull/21682) and then
re-landed with fixes (https://github.com/Homebrew/brew/pull/21684), all
before the runner image was even built. So the re-landed version is what
shipped in the image.

Which means that the image rollback fixes things for now, but the
underlying Homebrew behavior _still_ exists. The next runner image rebuild
that picks up Homebrew 5.1.0+ could reintroduce the problem unless the
runner-images team pins `llvm@15` as keg-only or explicitly unlinks it.

In light of that, the workaround in
`js/macos-homebrew-forgets-reg-enhanced` may still be worth keeping as
insurance, even though the immediate breakage has been mitigated by the
image rollback. We would be one image refresh away from the same failure
otherwise.

Ciao,
Johannes

--8323328-206823970-1774283563=:32601--
