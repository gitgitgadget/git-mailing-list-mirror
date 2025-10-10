Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A1522157F
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118221; cv=none; b=CcoI9yLQqEbzbPuNPg9Yj2w4rGPrhq6SsOsUjYgTwAkI+gmAxwrw1A1gkPvW+MHo7TqDxtz0Z+sKUw+jcNpq7KCC5eMIrQAfToVchhSsaSboNBWTot7MFO5D1pRkjCu5WLf9qDHOxRT0/hxM8nSV5puoC+UjuBmudSXk6vH5XJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118221; c=relaxed/simple;
	bh=i13xQbI7wQhO3zwMIisTxoQjsWprRud+eK0A+foZUkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TN3vX/Low+o8j+66bjJ/+BcgssHNXa6BryAnBFphud6gkuiTMONRJYBnyh3Bw62M9Sp+i+yxFkHPJTvWeAzsFZbrzggPEJka1c3jKIjLgQ5goyCey+NLHcM5OcNDzXoEH8/Hl7Gh3UQSR+RNxmq2YyAvhw8JL+qVHF7OE6DfM+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=fb2TKyb6; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="fb2TKyb6"
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 69C7BDF9DF1
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 19:43:28 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:a06f:c648:8a43:5f2f])
	(Authenticated sender: jn.avila@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 4AEBB5FFB4;
	Fri, 10 Oct 2025 19:43:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1760118201;
	bh=i13xQbI7wQhO3zwMIisTxoQjsWprRud+eK0A+foZUkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fb2TKyb6c7Z4gedwChjSCH92rK3wzmXQPtLzkjrb8ZuubPj4mxkBuPlLOtg4bDffP
	 HuFz3leINQ+1KkOuF4zTe/WVb8HXTOeH+JezZP8L1z/czIi5CfjYaV5L809yQRaRyT
	 S2wnUb79dbLYXlyCxIe92QkD0O2fA9yr12fCmUWX9mSXTlHnq4ne6Mln9sLFS0RC10
	 oH+5pBpvP1ddZkivQyVlpqLvttaGcMyIx5yKwBQb8tgyMh1IcmjD0MXGwFHCoCuVjS
	 dTSszVr7jA1d5aG3i87yi60nIoaXOdf0ysSz7g9HEIyo9m3gRGv9yLT0bhJ8Rm3ER/
	 vqanJ2KGGlNLA==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] doc: convert git-stash.adoc to synopis style
Date: Fri, 10 Oct 2025 19:43:17 +0200
Message-ID: <5929880.DvuYhMxLoT@cayenne>
In-Reply-To: <xmqqsefqah44.fsf@gitster.g>
References:
 <pull.1969.git.1759698702.gitgitgadget@gmail.com>
 <bb0f530b-96f3-4655-8448-1d322413cd1f@free.fr> <xmqqsefqah44.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, 10 October 2025 17:52:59 CEST Junio C Hamano wrote:
> Jean-No=C3=ABl Avila <jn.avila@free.fr> writes:
> >>> diff --git a/Documentation/config/stash.adoc b/Documentation/config/
stash.adoc
> >>> index e556105a15..7fc32027f7 100644
> >>> --- a/Documentation/config/stash.adoc
> >>> +++ b/Documentation/config/stash.adoc
> >>> @@ -1,19 +1,28 @@
> >>> -stash.index::
> >>> +ifndef::git-stash[]
> >>> +:see-show: See the description of the 'show' command in linkgit:git-
stash[1].
> >>=20
> >> Okay, here you use 'show' and not `show` because this conditional
> >> attribute will pass on `show` and render it as such, not as
> >> inline-verbatim =E2=80=9Cshow=E2=80=9D. Bare 'show' is indeed better t=
han bare `show`.
> >=20
> > TBH I did not spot the issue when I did this. I wasn't aware that
> > Asciidoc does not automatically handle inline formatting in attributes.
> > But it seems we can force it. This "show" keyword should definitely be
> > inline verbatim.
> >=20
> > Wil try and reroll.
>=20
> This is already in 'next', isn't it, though?

That's fine. I couldn't come up with a substitution scheme that would work=
=20
correctly for both asciidoc.py and asciidoctor.

So let's just let this patch as it is and recall that attributes are not a=
=20
panacea.


