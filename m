Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C48121A457
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769608948; cv=none; b=CCanOzy4ewkuekHE5YQCibcZMDI9ihN79xzbRHaVX2G/nfAvRwIToT5FSVPqoCRub1Fkz5K2oLOsMGHM3IaGW4JYhpRnWRmWdbqWWO/J4nO6pgsc3oiMvhB0sNiY9gJvLCIo14MV2GsDWtX7S0sY4lZFFpePOxaqpO/tyOhoC5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769608948; c=relaxed/simple;
	bh=duTeb4QRP81G/1yfYLmNBMj749tEDV4uu4H5Y90HKnY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUcoq4eDeTlIvG85WFyzmKiZ2FHbzEE1HfON3kFGgSS3tPYOsKx3ZvkpnXaWncA8gFOI13zA3GoPHTMfd9xv4XZjY7VR2A/po8BRmBRbg3wx1WzKokAbeOCl+lcNSXv7m7PT6kAO3h179Q+Ug22k/tb5wBh+zNHMB8fjyKZswDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Awo8Bl9X; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Awo8Bl9X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1769608937; x=1769868137;
	bh=duTeb4QRP81G/1yfYLmNBMj749tEDV4uu4H5Y90HKnY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Awo8Bl9XTKU0SlK1/kgRfZSWig04dCedaxeCXA3POtRq3nFhiV2QDLV3ea2qdIbZO
	 ouI717AgTR6iVL02b25lFWCgCvEzsv2GYqmW3SiGZClLZgFz5kQEm0cUr+G6+KkBrG
	 xCz5qn4UkMiz45GZ4B9iQLKcJV9lyRNwqxr2WTEPglPoHmiLFIUliwWSO/ZVrECItw
	 hG03YckCCBVpxn6agrPcIk8QY25JVaxNsNyMuORw+yUocC3PalRzA5e70sIHYj1Z86
	 ttUx2LCfQrIrqHFRGHJQUgbVoTIHtUiUnIxq2oOLMNPWodM8hT/3OWyiV56yY9kunh
	 Z+O3xzdTmy95Q==
Date: Wed, 28 Jan 2026 14:02:13 +0000
To: Johannes Sixt <j6t@kdbg.org>
From: GitHub Chris Idema <github_chris_idema@proton.me>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Michael Lutz <michi@icosahedron.de>, Pat Thoyts <patthoyts@users.sourceforge.net>, Chris Idema via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH/RFC v2 2/2] diff.tcl: call "apply_tab_size 1" to fix alignment instead of spaces.
Message-ID: <Rrnh0ugGQ5ef_s-3W0Tive8HA9R0_9Cq6yK7K6SS6Jr3kPigHai3jzxvphTRNXXNhCnor2TMV8UjKEi5U27VOLBf-R4g6VbJBLq8PQH9kCI=@proton.me>
In-Reply-To: <71494127-c17d-4fd9-a69d-1f547205ac8f@kdbg.org>
References: <pull.2179.git.git.1769424301394.gitgitgadget@gmail.com> <pull.2179.v2.git.git.1769545996.gitgitgadget@gmail.com> <e11aa6d811dcf868fd0f91b74cdceb8bc3f4229e.1769545996.git.gitgitgadget@gmail.com> <xmqqsebqem1n.fsf@gitster.g> <xmqqfr7qeixq.fsf@gitster.g> <71494127-c17d-4fd9-a69d-1f547205ac8f@kdbg.org>
Feedback-ID: 177675452:user:proton
X-Pm-Message-ID: 0edef27b91ec2e14b2ea2af4b1fbf31d4f576a7d
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>I concur. Also, "apply_tab_size 0" is needed when the contents of an
unstaged file are shown instead of patch text.

Can you explain why it's needed?
The file in my example is unstaged and it's a patch text.
So these are not mutually exclusive.
Even for a staged file the context lines are indented by 1 space=20
instead of a + or - character. So tab stop width is also incorrect=20
for context lines.
Can you show me how to get content without patch text in the window?

> +=09if {$have_tk85 && $firsttab !=3D 0} {

Gives me the error "can't read "have_tk85": no such variable"
If I substitute 1 or 0 for have_tk85 it doesn't fix the alignment.

I'm open for suggestions. My 1 line code change fixes the problem,
but if it is not the official way to do it or if it introduces other
problems feel free to suggest another fix.

For reference here are the screenshots of the problem:
https://github.com/git/git/pull/2179#issuecomment-3799576864

For us this bug is a show stopper that makes the diff in the
git-gui window by default unreadable.

-- Chris

On Wednesday, January 28th, 2026 at 14:40, Johannes Sixt <j6t@kdbg.org> wro=
te:

> Am 28.01.26 um 00:26 schrieb Junio C Hamano:
>=20
> > It is clear that "apply_tab_size 0" is designed for a single-parent
> > diff, while "apply_tab_size 1" is designed for two parents diff. If
> > this new series to make sense, I think it should argue why that
> > setting that users are already familiar with for the past 14 years
> > is wrong, and "apply_tab_size 1" is more appropriate for a single
> > parent diff (and presumably "apply_tab_size 2" is better for two
> > aprent diff), I think.
>=20
>=20
> I concur. Also, "apply_tab_size 0" is needed when the contents of an
> unstaged file are shown instead of patch text.
>=20
> > +proc apply_tab_size {{firsttab {}}} {
> > + global have_tk85 repo_config ui_diff
> > +
> > + set w [font measure font_diff "0"]
> > + if {$have_tk85 && $firsttab !=3D 0} {
> > + $ui_diff configure -tabs [list [expr {$firsttab * $w}] [expr {($first=
tab + $repo_config(gui.tabsize)) * $w}]]
>=20
>=20
> I think that these values for tabstops aren't optimal. It does not make
> sense to have tabstop at column 1 for diff output, because there is
> always at least one character ('+', '-', or SP), so that the first tab
> would jump right to the second stop. In Gitk, the initial version looked
> like this as well, but it this was changed soon after.
>=20
> > + } elseif {$have_tk85 || $repo_config(gui.tabsize) !=3D 8} {
> > + $ui_diff configure -tabs [expr {$repo_config(gui.tabsize) * $w}]
> > + } else {
> > + $ui_diff configure -tabs {}
> > + }
> > +}
>=20
> -- Hannes
