Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8E513E02D
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751815682; cv=none; b=ptQY3HFA7ZjVncw3owpqHEzl+CmTxRRj+JLprDDanPar5ao/SsbclJdSQnDqLGdJAmFzgNQyJT55tPKKhZebqVrSqHDr32svs1vv3jMXJ3U7DkJBXj0jKFK1oslpPTX3+aUA3Gwv7hdNmaYZEdgjuUFzIlIBLTkDU4Y/2taQdcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751815682; c=relaxed/simple;
	bh=AG7io94O55u+26XUAJ3lBKN2OjSahYPPh2tmDe45X20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xa3PJV2etmwBKKBjHZNthxP/z6Dm7d1I4g4K11vToC01FmLlzFe8aCwcVfBxfqYYatGy3tRCc+HrXqAbzgPyMGCSny3hfwDXgoXbNrv46SfIFCMAXloLxBs1yYugWJh38otda7Q3wkaKCP88YEevRMlfixfGnk+Ds74AfJp0tqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=S1hxreYz; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="S1hxreYz"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:13:fc41:fd1a:ba1])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id A1696B0055E;
	Sun,  6 Jul 2025 17:27:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1751815678;
	bh=AG7io94O55u+26XUAJ3lBKN2OjSahYPPh2tmDe45X20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S1hxreYzQHg/rxZApqesl8HmjCr5b8bV1UEGkMAtvk6JC/XAf9SCqQ/YvKurXNWxP
	 JR1msvDX6yMk2A7ALtCEIW0uNUXjLhHswoDpK+HU0siQF8+/VVJc9f1Gawo6BKE/9h
	 wdeOT+f6z9U9g3xb3urZPNeYPuTGKePKPRIvljgOOXe+Moi2vh+Mu8wRrjwFyDPoQf
	 gEjN1muxuWoHwbUAaHQm2kQBfUw9Y9vf/6s5qGRG0zl4NwKN9RRz2w/lJ55PeDO9+Z
	 xNMuk/LyHjdz75MTI3iXEDccU5psu1ZrSKMx3zr0JKjUZK+9WEJcDWHoeCRB8FbMQ0
	 6mBDZNs+UPo9Q==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To:
 =?UTF-8?B?SmVhbi1Ob8OrbA==?= Avila via GitGitGadget <gitgitgadget@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/9] Doc git log
Date: Sun, 06 Jul 2025 17:27:56 +0200
Message-ID: <7824165.EvYhyI6sBW@cayenne>
In-Reply-To: <xmqq4iwcenrc.fsf@gitster.g>
References:
 <pull.1933.git.1749373787.gitgitgadget@gmail.com>
 <xmqq4iwcenrc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday, 18 June 2025 23:35:51 CEST Junio C Hamano wrote:
> "Jean-No=C3=ABl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > This series converts the man page of git log to the synopsis format sty=
le.
> > Git log is the second largest manpage after git config, which makes the
> > changes quite large.
>=20
> ;-)
>=20
> Other than the "add % to literal" in [5/9], which I couldn't figure
> out if it truly belongs to "doc: git-log: convert rev list options
> to new doc format", everything looked pretty reasonable.

TBH, I'm not entirely satisfied with this patch, because it reintroduces=20
complicated format marks everywhere instead of pushing this complexity into=
=20
the formatting logic.  The problem is coming again that we have some signs=
=20
which are used for the synopsis syntax but can appear as "keywords". First=
=20
there was the three dot notation, now it's the parenthesis. Coming up with=
=20
basic regexps that can handle the context difference to tell apart their=20
grammatical meaning is increasing difficult, if not impossible.

=46or git-scm.com, with asciidoctor, an extension managing the synopsis sty=
le=20
using a parser combinator was introduced to alleviate the difficulty of the=
=20
task.

The problem is that, as far as I can tell, asciidoc.py does not propose suc=
h=20
extensions in a programmable way. If anybody can direct me to an example of=
=20
using a parser combinator in asciidoc.py, that would be great. For the mome=
nt,=20
this patch is the best proposition.

Thanks

JN


