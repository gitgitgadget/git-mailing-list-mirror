Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FC41EE01A
	for <git@vger.kernel.org>; Thu, 21 May 2026 01:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779326293; cv=none; b=QKXAgDb3QnzXBXrfq1ksfMFARkehTbiilP7bKE9DKB1IkeGKobADJpfdb+HM6EcnfiJ+8eoqZlrHtipBh2sNjj50bmkGslrMAlB7QhG6OkxYxRLaowzP7oEnYbOTdQ7YM7BwqVG6eMEzQ2ypbnTxUoNvGT72BCjyopOIa4WmMYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779326293; c=relaxed/simple;
	bh=gMFIiINaYnmvBMaVr5bukh3TJYR7PYKdQIFTUabdLR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJrp5Nlc6CW7Qw1cUbjHn0neUEqXa8YGV93viDM/PZns6YqFUPVXLvHzph36zOJh4CEi9t69JIh+Vx2BS5Js3klMbnOPjdwISKZcP5aMnaKx4BDgk7o0f0Juqke/4UiUOUp1N6vWdDa0goPq+4xpxzsMNCKtURroMpPMTunyAvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=KITEMPlb; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="KITEMPlb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1779325922;
	bh=gMFIiINaYnmvBMaVr5bukh3TJYR7PYKdQIFTUabdLR8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=KITEMPlbA7xRcHNKnIYQgMDgocQQAdSH8PmwwJO5CQwSz1qMIb6cruzlGCy4ZmH4A
	 ZXagbohw52Da+wLeYJZNQ0wNXfcNNTZ6YBVtQxdmouF8uHk4tGFqmIvl4ZkjZ2jTVz
	 fLfesP3OkHyPXfrdlQ9ih5cpKXiQMqBh96t1rQKt+dYc8Rf5rsiZyGgQea2nHWGljK
	 yUTqNEH35Sw9hih64sFHgDvIZydrGs8IXFIrz+Jm3qY/nBubFQr2FbSY7jNJgKz7ac
	 Z0Jl11O3igfaI8woH599hwu8p7Tx6E2bePX/5FAdHVZ9o0VpDeOKAccxxpWVEX9OrD
	 gcoLndXqPcn7ctEslWHFzIlOgqFyiGRAbIseTpqQhYWHqZnr8kWxiRLLxk/XHelhbs
	 Fstf4nZDbQgg5PqvXKQ6BUdR/FaD3Vgb4nsf4YJsYxbiaOyQyRH6HzElZ9c8hpCMsU
	 DB9MzBZ4TEvWuE9IRzeV0exZYveGXe4c6O0M34nQ/BNk8fQ/imc
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:2fe1:115c:dc1d:4e8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3B9BF20082;
	Thu, 21 May 2026 01:12:02 +0000 (UTC)
Date: Thu, 21 May 2026 01:12:00 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
	Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/9] notes: support an external command to display notes
Message-ID: <ag5b4O7-k-3QBR4W@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Siddh Raman Pant <siddh.raman.pant@oracle.com>, git@vger.kernel.org,
	Calvin Wan <calvinwan@google.com>, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Junio C Hamano <gitster@pobox.com>
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
 <9619077369f1a567bd505b1de1e4f672a5cd1950.1779207350.git.siddh.raman.pant@oracle.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h83axuEG8BXlljaN"
Content-Disposition: inline
In-Reply-To: <9619077369f1a567bd505b1de1e4f672a5cd1950.1779207350.git.siddh.raman.pant@oracle.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--h83axuEG8BXlljaN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-05-19 at 16:30:36, Siddh Raman Pant wrote:
> git notes is a very very helpful feature to show user-supplied
> information about a commit alongside its message transparently.
>=20
> For distributed teams working on large git repos (huge number of
> branches/refs, files, etc.) and using the notes feature to mark
> information on git commits, a TOCTOU race can happen due to very
> large size of the repo and notes ref:
> 	- Person A updates a note for commit X.
> 	- Person A pushes the notes but it takes some time.
> 	- Person B fetches notes and doesn't find the updated note.
> 	- Person B can come to know of it only when he overwrites it
> 	  and encounters a push failure.
>=20
> This problem excaberates on scale.
>=20
> One solution to this is a realtime fetch or faster updation via
> external means, but unfortunately we lose the coherence in the
> display of information, and the user would end up reinventing
> git log.
>=20
> So let's add support for an external command to display the notes.
>=20
> We split the addition of documentation and tests from this commit for
> easier review. The new help text added in Documentation/ in the next
> commit should make the usage clear.
>=20
> Assisted-by: Codex:gpt-5.5-xhigh-fast

Just a question here: was this written in whole or in part by Codex, or
was it just used as a reference to ask questions?  I ask because the
style of notes-external.c differs quite a bit from the style we use (for
one, the horizontal rule comments) and we have this in
SubmittingPatches:

    The Developer's Certificate of Origin requires contributors to certify
    that they know the origin of their contributions to the project and
    that they have the right to submit it under the project's license.
    It's not yet clear that this can be legally satisfied when submitting
    significant amount of content that has been generated by AI tools.

    [...]

    To avoid these issues, we will reject anything that looks AI
    generated, that sounds overly formal or bloated, that looks like AI
    slop, that looks good on the surface but makes no sense, or that
    senders don=E2=80=99t understand or cannot explain.

I'll note that it also has a lot of global variables, which are common
in the codebase but we're trying to move away from, and it's more
verbose in commenting than we'd normally see elsewhere in the codebase.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--h83axuEG8BXlljaN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmoOW+AJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ2+cAE4hYUT5+nZJQxytY0xPZk7sbwoj3wE4N4qF/f99
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAF2yAQCNusjyQo2rIg3X5Q1QKOSbzOxl
gsUGgxptuPvEfTZRgQEA26puW6VT3yKRnxA+PfHsJ17ORrb0pOdPjU0EZ9fNHwU=
=F4l8
-----END PGP SIGNATURE-----

--h83axuEG8BXlljaN--
