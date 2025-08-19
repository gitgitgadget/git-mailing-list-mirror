Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A26D515
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 00:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755564351; cv=none; b=DTrQX4HhW4KK5OjLDdrafCnGDBtzxk7Nd5MK9/CCyNddAfLZH+4F/vdw/RYmNhjpkABL1xZ5zwC/WwMF2Yn1sVjvYGYzv0WZlkG/JACah/JzusKsc8UDVh9tunBTwsV0v0MBGI/R3QHndAeggKbOt0WQ2xOJ20LOaly8RvILyEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755564351; c=relaxed/simple;
	bh=6TmEFNSf9GJv48zGPSjnEDtyiFhTq4uUOFOwq+Tg3cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzppJmybU3awVWJHoLZ1P3ucT8vZ4HZtiIhQHufnp3NS9clN8UwkS70ooRi9aYFKmZrEZTHIHG50YGVrookULkKD5ExWs8xPIq8eATxUjqBjqbwj7qbTqlyo+XmGItS5ryPwyvqIfhdyxwAZa7tHvXX2uveyiG3e39JZktuNdXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=SDo5wdxd; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="SDo5wdxd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1755564341;
	bh=6TmEFNSf9GJv48zGPSjnEDtyiFhTq4uUOFOwq+Tg3cU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=SDo5wdxdUOG97BxvdrPIsCA9LSBX3/WyuZHDxuj+CwFhKJpYIGjIeM6ufnAfT0Cq7
	 XIhiI7WEV0t96lRf3l3/oy/R92cz2BcelDQwq0ZovkdKy7rwgk9jKZJLtuCidkmdD7
	 jK+smJ14/fK1rer7PnbfvNVQdHHyOhV1Kt+MNUDqHhkbCuA1m0SRdhS0WC3cQj60oy
	 BkrGC7gcsZh56dNERkYT8nBAOQOtbDgP3Clf5eLCG8SEd49Q2X5f/Y8T39LUrlybOa
	 aEwwrhZsiZh2nJP2+2P4z3fjmODFQ7Eyg8oDFqhPI0GcY+u9xg6Quhpve63ZzLHvCp
	 pRecIvELXD+pznoNAAMhth/pTnjjrKGrCf5eBh3DnxMf1e+5C8aH3Hu65oeL1nygEB
	 oy/Cxh9mUjjSBIe1vplsNkYXJnUTY1d0MlFDnAO0nqjmGt24E7oyWJJHuZUrRTzcuL
	 5fbynVg7RZPz8H1Aeqk652ULDwcE9T5aIAWmfRRBKNXxPCVTWPX
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5aed:d873:1a82:271e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B0915200B4;
	Tue, 19 Aug 2025 00:45:41 +0000 (UTC)
Date: Tue, 19 Aug 2025 00:45:40 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Michael Schroeder <mls@suse.de>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] submodule: truncate the oid when fetchig commits
Message-ID: <aKPJNNWMW9gtueEK@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Schroeder <mls@suse.de>, git@vger.kernel.org,
	gitster@pobox.com
References: <aJ37eHEGMw6RgmZC@suse.de>
 <aJ5gOPQ9oologqj-@fruit.crustytoothpaste.net>
 <aKLyy8nwGQCT-jvB@suse.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JOAs1rdkt8oSoIB1"
Content-Disposition: inline
In-Reply-To: <aKLyy8nwGQCT-jvB@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)


--JOAs1rdkt8oSoIB1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-08-18 at 09:30:51, Michael Schroeder wrote:
> On Thu, Aug 14, 2025 at 10:16:24PM +0000, brian m. carlson wrote:
> > On 2025-08-14 at 15:06:32, Michael Schroeder wrote:
> > > If a submodule uses a different hash algorithm than used in
> > > the main repository, the recorded submodule commit is padded
> > > with zeros. This is usually not a problem as the default is to
> > > do submodule clones non-shallow and the commit can be found
> > > in the local objects.
> >=20
> > This should not even work at all.  It may currently behave as you
> > suggest when the main repository is SHA-256 and the submodule is SHA-1,
> > but it will corrupt the data if the submodule is SHA-256 and the main
> > repository is SHA-1, since then the data will be truncated.
>=20
> But it works, and I'm pretty sure people already use it. If you
> have a sha1 main repo and a sha256 submodule, git will truncate
> the commit when recording the gitlink. The checkout done by
> git submodule update will work as it does the normal prefix matching.

Unfortunately, that will break with the interoperability work.  The
protocol will learn to convert the object ID on the server side by
announcing the mapping and when the object ID doesn't exist, the client
will die because it can't remap the object and the process will fail.
By doing that, you'll end up with a repository that you can never use
interoperability code on, ever, without rewriting history.  There's no
way around this problem because we don't keep the object format in
trees, so we can't distinguish between a SHA-256 submodule that happens
to end in 24 zeros and a SHA-1 submodule.

The entire hash function transition has mandated exactly one object
format on disk and in data structures from the very beginning:

    This affects both object names and object content -- both the names
    of objects and all references to other objects within an object are
    switched to the new hash function.

I apologize that I didn't think about this problem and make the code die
on this case earlier, but it's not a supported configuration and it will
absolutely break in the future.  Sorry to be the bearer of bad news.

> > The proper way for this to work is that the SHA-1 version of the
> > repository stores submodules in their SHA-1 states and the SHA-256
> > version of the repository stores submodules in their SHA-256 states.
>=20
> You mean by using "compatObjectFormat"? I couldn't make that work,
> but maybe I missed something. Anyway, I think this also will not
> work for shallow clones.

There is interoperability code only for loose objects now.  The code
that handles packs and interoperability between repositories is in a
branch on my remote.  It's work that I'm doing for a talk at Git Merge
and I will send it upstream when it's ready.

Right now, I'm working on shallow clones at the moment and then
submodules are next.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--JOAs1rdkt8oSoIB1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaKPJMwAKCRB8DEliiIei
gZtEAP0S2mZTaTmGD7DAtubZEPrvItSCfivrQmfQK8CegHmkuQD/behpBCeXN8HU
N9r52AiC9nKJY2RZDZCTl47EtU9LEQc=
=SjR7
-----END PGP SIGNATURE-----

--JOAs1rdkt8oSoIB1--
