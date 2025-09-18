Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E852F49F8
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 22:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758234148; cv=none; b=uz0fygsw9c8Fu+KDtp7kcTCTpZaf7CUX6NuZ4XJlyq+jn2VsX8RwlDdijS/6zhowk8ztPpYM1RbgQJuj5mCZc+XR0oWLNOq4YlKnQUFjsfi3WD1W4Bu5Hb/XC468Y0rn3LCdce3N3N4epYMQvXiJ0Sla2CPNIWnA03V4bdHwiIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758234148; c=relaxed/simple;
	bh=Cn+KaZ6oHrbXuBMN4aWl81N9fxqzYGsKhjM1jmS2bJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mz7S9S4aPscNOnjCX4lSecZzRY3P+O/MQqj4JQCZWtDH8zrKiexJ8x6akfbRbi3kOcs2LE1Nqmn7wgY/quqkKl2aZpa3rkZ8d4mU3HWLAg+YMnT/OQJEIMTFByfCYmu1w+/6bgxeTme13wzpfQAZdnFt2vhh0q5ofUNzNZV866o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=d+KG8te2; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="d+KG8te2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1758234144;
	bh=Cn+KaZ6oHrbXuBMN4aWl81N9fxqzYGsKhjM1jmS2bJw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=d+KG8te2Hp6ksM3CXmB1x1puQdLOByw3xmUtj63TT8y2Ah2huJ1ddqB2EvLp47VXh
	 guR9liNEY5t0dLDLqoxADG1vXUGue87wEWa1e6mdznUeyLxrQSVutznZth/jgZjxsu
	 hOMe6cAijN18F6SaMpH8qPXwl1v5HqQ/L1y4iDkyYcHbVXsy6l8nRMp2nXQ8sq59q8
	 hzDi9J8XNQ77dAS7KPjOogB14jbjHKP8Ws0XgmoX/QhLBvIoiOwjiXnS9aeVlG8U1b
	 2qVObE9h3uO31zPig0GLziFTbuCIVi1vaw68ygZf1rdzX6q3dfIXOJksuKpCs2c5i1
	 V6upX1FOObbaSbaULki+DGIiYx76aXn/4TL5JUJnbExMbUcZ2aRwWkcWM/gK78uQyK
	 9mI5j9U0pWT4QQE4hOSKyGZe0FzDZ3wRfihj9/k8GjCzGBfBwFlHxacqOPvTxijwT9
	 vb8uTVw5fYXdDWs0GBkUelyEuAzE274YWOXfQbno57S54DQCOwc
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ada0:faf8:3cb8:a81f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 107D420105;
	Thu, 18 Sep 2025 22:22:24 +0000 (UTC)
Date: Thu, 18 Sep 2025 22:22:22 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Antonio Mennillo <antoniomennillo87@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC] git-rebase-clean: =?utf-8?Q?miti?=
 =?utf-8?Q?gating_a_=E2=80=9Csemantic_conflict_cascade?= =?utf-8?B?4oCd?=
 during rebase
Message-ID: <aMyGHriNpmekoqD5@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Antonio Mennillo <antoniomennillo87@gmail.com>, git@vger.kernel.org
References: <CACEPZDXGGn0S_8PpEc=BVHhvyuZhWfiDmbxNOK7iPWJOj1jrXg@mail.gmail.com>
 <aMnhSm5QSdRwiJds@fruit.crustytoothpaste.net>
 <CACEPZDU2Bu2c9RFBwD499-UUNyQGuRRXNbMx0aBrqwGoc=4EhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Vrq1YX6MFOaW1ZbH"
Content-Disposition: inline
In-Reply-To: <CACEPZDU2Bu2c9RFBwD499-UUNyQGuRRXNbMx0aBrqwGoc=4EhQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Vrq1YX6MFOaW1ZbH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-18 at 17:02:59, Antonio Mennillo wrote:
> Hi Brian,
>=20
> Thank you for the thoughtful response, and please excuse me if I am a
> bit clumsy =E2=80=94
> this is my first interaction with the Git community.
>=20
> > Usually we would recommend that each commit be atomic...
>=20
> I perfectly understand this best practice. In my context, working with
> many junior developers,
> it is not always possible to enforce atomic commits. In some
> =E2=80=9Cemergency=E2=80=9D situations we
> squashed just to make progress, even if that meant losing granularity.

Yeah, I've seen that at previous employers.  Even where I work now, I
definitely see differing levels of interest in atomic commits with nice
commit messages.

> Your explanation really helped me see things more clearly, and I apprecia=
ted
> the constructive (non-toxic) way you put it.

Well, thank you.

> Yes, rerere helps with repeated textual conflicts, but the scenario I
> worry about
> is semantic: if commit M changes an interface and commit N implements it,=
 then
> changing M during rebase can make N semantically invalid. rerere
> cannot solve that
> =E2=80=94 it remembers markers, but cannot understand that =E2=80=9Cthis
> implementation no longer
> matches the interface.=E2=80=9D

Yes, this is effectively unavoidable because Git doesn't know the
structure of your code or data.  For instance, in Rust, I could add a
new mandatory-to-implement method to a trait and then all
implementations would need an update.

> That feedback inspired me to improve the tool. Version 2.0.0
> (literally born today,
> thanks to your comment) now works differently:
>=20
> 1. Temporarily squash the feature branch (so the rebase is effectively `1=
/1`)
> 2. Resolve conflicts once, with the full final context
> 3. Automatically re-expand the squash by replaying saved diffs, restoring
>    the original commits (with new hashes, as expected in any rebase)

You haven't described exactly how this works, but it looks like it
performs a fixed set of transforms (e.g., symbol renames).  That can be
useful, but it isn't sufficient in a lot of cases.

For instance, in some work on Git I'm doing, I need to include a header
file for a function.  It was previously included in another header, but
my rebase onto the main branch had it removed, so I need to add it into
the C file I'm working on.  The only way I can 100% know which commit
needs that change programmatically is to try to compile on each commit
until it fails, and insert it there.  This, of course, requires atomic
commits.

In a lot of cases, I use git-autofixup[0], which looks at changed lines
in the diff to determine which commit to squash the changes into. It's a
great idea, but it has limitations, since sometimes a change logically
attaches to a commit but isn't close to it in the context of the diff
(such as my header inclusion change above), and sometimes I've changed
similar lines in an earlier commit A (where my change should be
squashed) as well as in later commit B, yet it gets attributed to B
accidentally.  It's convenient and generally works well, but I have to
be careful not to trust it entirely.

> I would be very interested in whether the community sees this worth explo=
ring
> as an **experimental rebase strategy** (something like `git rebase
> --squash-restore`),
> or if it overlaps with existing mechanisms I am not aware of.

I think the fact that it adds a dependency on tree-sitter is kind of a
non-starter for us.  We're currently having a mildly contentious
discussion over the use of Rust in Git and it won't be mandatory until
Git 3.0.

It certainly covers some use cases, but it looks like it only handles
deletions, file renames, and symbol renames, and the latter only for a
small set of file types.  There's a lot of cases that it doesn't handle,
and I'm afraid that people will end up disappointed by expecting it to
magically handle a lot more than it does.  That doesn't mean it isn't a
useful and valuable tool for many use cases, but users may have much
higher expectations that it will magically solve their problems when
that isn't the case.  I have some tools that I've written myself that
are like that, for instance.

I'll also point out that we try to avoid hard-coding known languages.
People use lots of languages with Git, some of which are not even known
to Vim, which has an exceptionally complete list of file types and
syntax highlighting.  People also do non-code things with Git; for
instance, I store my creative writing in a repository, and other people
use Git for working on documentation or technical books.  As much as
possible, we want tooling that works for at least generic text files and
ideally, all files.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--Vrq1YX6MFOaW1ZbH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaMyGHgAKCRB8DEliiIei
gZQDAQDkmS4pKvvslwylBzAN6bvtXswIw8bCYV0hotf7pEVSaAD9GOVVQd33NaXA
yPij/McQu+zT/CKP3EHM9Wut207eeg4=
=2yRy
-----END PGP SIGNATURE-----

--Vrq1YX6MFOaW1ZbH--
