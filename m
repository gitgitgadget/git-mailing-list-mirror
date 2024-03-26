Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FD812AAF8
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 20:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486171; cv=none; b=Wm7rPpBkpt6JXGfdl7oaJbhcReM0X1WMEMZ9VQi6gSmXqcHlPowbauvm3ktEg+T5/hiOAq0n7rcN5HO8RlJRxXJQ7xWAonZWRP+Zs/KPR1oSn3cnRfGIKkersjjW5//p0mvrMO/UkZA/cscT4SJwg6xDJci5o015bPEnfQWHu4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486171; c=relaxed/simple;
	bh=OOi64MjkAf6EuDphZRF81r+qJVohjDS3GfaO4pe3r2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tK72E3gMoqKn1PknohegV5ncikzzLnGDuEFLMjrS7JALwjVDIgF5V8MjhWbFGfvpyr35LFufqPZfVdnpSY1+H96FBR5CYFAWSfqwpgpdkkK5HYH0dPO1Jtjt+UPO/rjQhUZEDI2GLEzLXCdnN805XADPf/bMaJJGkccmGjMflb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=ZvuH5Oeu; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="ZvuH5Oeu"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:19bc:db3e:217f:a8f])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 58C10B0051B;
	Tue, 26 Mar 2024 21:49:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1711486161;
	bh=OOi64MjkAf6EuDphZRF81r+qJVohjDS3GfaO4pe3r2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZvuH5Oeuuv9hcf+M2wOLE3S2JlmDGnq0b3YN9OS4jERv7ikAo7YVwcE7c7TtYGgIW
	 4DRHQVLE1JPEV5wSVyUK+TMlRzWRfOaDWqcePoG9dMWiJk6sMs9JgXY8dadZAeriHn
	 vdQP4BjHq7VPzfjuCvlBRJPO0JRYCNpIpGUjGGP6hDbY3qnn4eljRIARYjIrqmzkUr
	 BiMvNL/K0hhfimOEs4/AG7u/+t01pOODSikLrYHFmFUYoI/gcDaVpYo3QhbBgdLuom
	 1uSk/JGn0u3zI8qy2BAZS6OEPEW0hDwbm1VJuF9x/nbu1RLhJB6hPU/7IYDkVSmUid
	 k+Tf69P9Ds4JQ==
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To: Martin =?ISO-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc:
 =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/4] doc: git-clone: apply new documentation guidelines
Date: Tue, 26 Mar 2024 21:49:17 +0100
Message-ID: <3285532.aeNJFYEL58@cayenne>
In-Reply-To: <xmqq8r24agov.fsf@gitster.g>
References:
 <pull.1702.git.1711318739.gitgitgadget@gmail.com>
 <CAN0heSoSNxuoObvO_xtu1fXb+XYH+gBvVOWfJVBkpXouR0cmWQ@mail.gmail.com>
 <xmqq8r24agov.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, 26 March 2024 21:20:16 CET Junio C Hamano wrote:
> Martin =C5gren <martin.agren@gmail.com> writes:
>=20
> >> +`git clone` [`--template=3D`{empty}__<template-directory>__]
> >> +         [`-l`] [`-s`] [`--no-hardlinks`] [`-q`] [`-n`] [`--bare`] [`=
=2D-
mirror`]
> >> +         [`-o` _<name>_] [`-b` _<name>_] [`-u` _<upload-pack>_] [`--
reference` _<repository>_]
> >> +         [`--dissociate`] [`--separate-git-dir` _<git-dir>_]
> >> +         [`--depth` _<depth>_] [`--`[`no-`]`single-branch`] [`--no-
tags`]
> >> +         [`--recurse-submodules`[`=3D`{empty}__<pathspec>__]] [`--`[`=
no-
`]`shallow-submodules`]
> >> +         [`--`[`no-`]`remote-submodules`] [`--jobs` _<n>_] [`--sparse=
`]=20
[`--`[`no-`]`reject-shallow`]
> >> +         [`--filter=3D`{empty}__<filter-spec>__] [`--also-filter-
submodules`]] [`--`] _<repository>_
> >> +         [_<directory>_]
> >
> > Don't ask me why, but I need this on top (whitespace-damaged)
> >
> > -         [`--depth` _<depth>_] [`--`[`no-`]`single-branch`] [`--no-tag=
s`]
> > -         [`--recurse-submodules`[`=3D`{empty}__<pathspec>__]]
> > [`--`[`no-`]`shallow-submodules`]
> > -         [`--`[`no-`]`remote-submodules`] [`--jobs` _<n>_]
> > [`--sparse`] [`--`[`no-`]`reject-shallow`]
> > +         [`--depth` _<depth>_] [`--`[`no-`]{empty}`single-branch`]
> > [`--no-tags`]
> > +         [`--recurse-submodules`[`=3D`{empty}__<pathspec>__]]
> > [`--`[`no-`]{empty}`shallow-submodules`]
> > +         [`--`[`no-`]{empty}`remote-submodules`] [`--jobs` _<n>_]
> > [`--sparse`] [`--`[`no-`]{empty}`reject-shallow`]
> >
> > i.e., some sprinkling of "{empty}", to keep each of these "[--[no-]"
> > from simply disappearing. This is with Asciidoctor 1.5.5, which is
> > admittedly starting to get old, but still ok as per our INSTALL
> > document.
>=20
> The original from Jean-No=EBl was already bad enough with all these
> {empty}, but now this is even worse.

I must concede this does not help make these parts readable in the source.
The point that Martin raised is the worst for me: if the processing of this=
=20
workaround is depend on the version of Asciidoc[tor], the way of writing th=
is=20
formatting for stuck parts in a compatible way must be clearly defined (and=
=20
made understandable).


>=20
> >> ---bare::
> >> +`--bare`::
> >>         Make a 'bare' Git repository.  That is, instead of
> >>         creating _<directory>_ and placing the administrative
> >> -       files in `<directory>/.git`, make the _<directory>_
> >> +       files in _<directory>_`/.git`, make the _<directory>_
> >
> > This should be __<directory>__{empty}`/.git`
>=20
> The worst part is that I am not sure if there is a pattern easily
> understandable by document writers to help them decide where to
> sprinkle these {empty} mark-ups.  Of course, they are visually very
> distracting and made our documentation that used to be perfectly
> readable in the source form to something much less pleasant to read.
>=20
> Can we make both the rendered output nicer while keeping the source
> still readable and easy to maintain?
>=20
> Thanks.
>=20

I came up with this trickery because of the use of "legacy" Asciidoc format=
,=20
which does not understand unconstrained formatting (doubling the signs, so=
=20
that they don't care about word boundary). With the new format, we would=20
simply write:

__<directory>__``/.git``
``--filter=3D``__<filter-spec>__

Without having to pay attention to the surrounding characters.

=46or now, we are stuck with the compatibility with the existing tools. I w=
ill=20
try an propose something else. Would preprocessing be accepted?




