Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCC256446
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 21:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736286507; cv=none; b=AXoVxS3KPdAc5COCdvKo1lAjtRU0TW3cZeAhJbHBY8Cvg03+1hLHkT2aFG4KRJcCrhm4Bp5E0X36hMPLFNVeOlFebK7i2YL0uqH3tqBqR9DLBNZduLqW1qicLI/u84AAB29LydsAIgUS4vorPLzyOJ6M1O/MuX78nr+ioG8z/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736286507; c=relaxed/simple;
	bh=zpzHb1UhmTL1cy5hc4iUKwE23VYpLDHt1f7yb660J4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D0RUsMbhJ4khJ1s41caAiHn92iN7P5QAVH2YisPK6yBscNWy3W/lq003ZYC8xpnC4Hq6OoUTaGHLEnePCraTy5Hw2iSU9AguKXJVKxT5dWqJv1hwIPMIY25ehQEHZUOUyPJ8bJgO9Rg9lXWU9fI8Vva1b1uv+tgMGVkChuMnDNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=VScasSFA; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="VScasSFA"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:420b:f4aa:dd4f:83c9])
	(Authenticated sender: jn.avila@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id A7F5E5FFB1;
	Tue,  7 Jan 2025 22:48:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1736286503;
	bh=zpzHb1UhmTL1cy5hc4iUKwE23VYpLDHt1f7yb660J4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VScasSFAZ11DcBBE+7ZHAF30EFnuE8CYPjgE2tkktVa5GHa8jMCCM+vbuq9hJIPOk
	 kwBa3hv31CvhtfrWwXkluV5bG/IZgCKxVqR5m1JDwpC7qU0pQeQPL15zwi3+ll+J9y
	 Iub8KCpqHkhvEAqT77QKZ2TRgH61IM1aikMLBiX/yJB6sdoz5Y6M6uW6LT0gsybRme
	 cr+sirPSm4va62EqZOfhjt6PB7z4JaUjWLrM017MW5t9Ik6LG8qY3gCskkY267vYuC
	 kDu/Esm8c4KJ2F3RPQCM99Y8WrYgqWBb6gHP1am/et0YPjw+o9qusM62zVEPuw0bbq
	 Gf9o+s0orsFQA==
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:
 =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: git-restore: migrate to new style format
Date: Tue, 07 Jan 2025 22:48:21 +0100
Message-ID: <6011894.MhkbZ0Pkbq@cayenne>
In-Reply-To: <Z3t8sjsCeiPmHffA@pks.im>
References:
 <pull.1847.git.1735996601092.gitgitgadget@gmail.com>
 <Z3t8sjsCeiPmHffA@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, 6 January 2025 07:48:27 CET Patrick Steinhardt wrote:
> On Sat, Jan 04, 2025 at 01:16:40PM +0000, Jean-No=EBl Avila via GitGitGad=
get=20
wrote:
> > From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
> >=20
> > The git-restore manpage was converted to the new documentation
> > format:
>=20
> Commit messages should typically use imperative style, as if asking the
> code to change. For example:
>=20
>   Convert the git-restore(1) man page to our new documentation format.
>   This includes the following conversions:
>=20
>     - Switch the synopsis to a 'synopsis' block, which will
>       automatically format placeholders in italics and keywords in
>       monospace.
>=20
>     - Use `_<placeholder>_` instead of `<placeholder>` in the
>       description.
>=20
>     - Use backticks for keywords and more complex option descriptions.
>       The new rendering engine will apply synopsis rules to these spans.
>=20

Will do.

> > diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.=
txt
> > index 975825b44aa..541a39b5d28 100644
> > --- a/Documentation/git-restore.txt
> > +++ b/Documentation/git-restore.txt
> > @@ -41,79 +41,79 @@ OPTIONS
> >  If not specified, the contents are restored from `HEAD` if `--staged` =
is
> >  given, otherwise from the index.
> >  +
> > -As a special case, you may use `"A...B"` as a shortcut for the
> > -merge base of `A` and `B` if there is exactly one merge base. You can
> > -leave out at most one of `A` and `B`, in which case it defaults to=20
`HEAD`.
> > +As a special case, you may use `"<refA>...<refB>"` as a shortcut for t=
he
> > +merge base of _<refA>_ and _<refB>_ if there is exactly one merge base=
=2E=20
You can
> > +leave out at most one of _<refA>__ and _<refB>_, in which case it=20
defaults to `HEAD`.
>=20
> This change is a bit surprising to me though. Why was this renamed from
> A and B to refA and refB, respectively? It should be possible for these
> to be object IDs and not refs.

Sorry for mixing things up revs with refs. The "A" and "B" are just=20
placeholders for revisions, and their names need to be more informative.=20

So, it should be <rev-A> and <rev-B> all along.

>=20
> > @@ -122,30 +122,29 @@ in linkgit:git-checkout[1] for details.
> >  	not be updated. Just like linkgit:git-checkout[1], this will=20
detach
> >  	`HEAD` of the submodule.
> > =20
> > ---overlay::
> > ---no-overlay::
> > -	In overlay mode, the command never removes files when
> > -	restoring. In no-overlay mode, tracked files that do not
> > -	appear in the `--source` tree are removed, to make them match
> > -	`<tree>` exactly. The default is no-overlay mode.
> > -
> > ---pathspec-from-file=3D<file>::
> > -	Pathspec is passed in `<file>` instead of commandline args. If
> > -	`<file>` is exactly `-` then standard input is used. Pathspec
> > -	elements are separated by LF or CR/LF. Pathspec elements can be
> > +`--overlay`::
> > +`--no-overlay`::
> > +	In overlay mode, never remove files when restoring. In no-overlay=20
mode,
> > +	remove tracked files that do not appear in the `--source` tree, to=20
make
> > +	them match _<tree>_ exactly. The default is no-overlay mode.
> > +
> > +`--pathspec-from-file=3D<file>`::
> > +	Pathspec is passed in _<file>_ instead of commandline args. If
> > +	_<file>_ is exactly `-` then standard input is used. Pathspec
> > +	elements are separated by _LF_ or _CR_/_LF_. Pathspec elements can=20
be
>=20
> The reflowing of these paragraphs makes it a bit hard to see what
> exactly is changing.
>=20

=46or the first set of options, there is a conversion to imperative mood, a=
nd I=20
triggered a reflow.
 For the second one, it just appears that all lines are slightly changed by=
=20
the new formatting.

More generally, I kept reflowing the paragraphs to maintain the width, beca=
use=20
this was done everywhere before, but I would strongly prefer having each=20
sentence on separate line, regardless of its length. For asciidoc texts, th=
is=20
policy has some advantages:
 * keep a lexical entity as a single line, and get rid messed up diffs due =
to=20
reflowing.
 * unfortunate automatic reflows can create errors, for instance when a par=
t of=20
text is sent to the beginning of line and is interpreted as a list item.

JN



