Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0EF7F
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 00:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721693148; cv=none; b=QbKb5UgcNkZ4lGdzGUU3aXafrmrimBy+CXEfrHqhkp58hcv23Ojg9TkhLGqP7cuUpL6VtlvSk/avl3j4tYeTOr+CnCzIBXL5D/DOo0i+KrEtzD/+P4aWIig2kjRON8hrHxDGrfFN7WJmQn0j5Cf/gjvvAtD0ibMteKYELSRYEu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721693148; c=relaxed/simple;
	bh=msDgkrgzNpI1ITRIQGSqFwk3tzB1yPQ4n7g9spzV6vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8N1cDk8lrKdzPUXc6+SEePvYvwJFhXBpHmpCdHH3g2raa8k7AJSSV7oc5gPvO/kXmL3Tx/inNoMISesJovxILSaa8nHLs1XBO6OaITh3w5ens78+xvQ4Zz831gMlDl5XG6ytNyApJfhiwOsANvmUW+5sZl6X4JloYdKF44MnHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=iOSEhGDU; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="iOSEhGDU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1721693144;
	bh=msDgkrgzNpI1ITRIQGSqFwk3tzB1yPQ4n7g9spzV6vw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=iOSEhGDUvxRLt8WKlQyKtVAKHxgCmmuCUmNPh7/29/aUT+JsQ82g/hgaCi9Q4CfXe
	 CvKnJRNGQCjIhAmY6TbWiDu3n7oH0qEhX8FYUx8pZMhwvylb6Fg4fjniyILga85IRb
	 5iBUj28EC71O7hh7JO3yqsA12U15V5JE8wQuuyZe9IAyoFo63JcAJ2SQqK7iHd0hzJ
	 KYkkHaDPQKPDQ3hpOkfTQjQCJ9bdPWunlqu+0KwkxZTAxOJk13QRn5hRk6tB5cOq4D
	 BVvGMMZSc3IwDCv8g+77xiv3wQcwSpcfpe3q90YknLTXiOuTRWAjTzI9ZgVAcWK217
	 VZXZdVepCL6edAPkNXdTZR+xCad1UU+hbQoeVmgGD/wbfQko/lE1tYplcUqySsTnnT
	 +zUbByYOTmLDxBb6aBa7KQlhAyd8NolZJVYe6qkYy3oJmfMuIcRB7gsOczd1fOcXnH
	 tsVMs1IdsrWdAnmuxElJUyC/PwYEN4Evsrx6o/XxNSROe0sX5zJ
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4B829209B3;
	Tue, 23 Jul 2024 00:05:44 +0000 (UTC)
Date: Tue, 23 Jul 2024 00:05:41 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: rsbecker@nexbridge.com
Cc: 'Thaina Yu' <thainayu@gmail.com>, git@vger.kernel.org
Subject: Re: [feature request] Is it possible to have git tag can be sorted
 and filtered by semver?
Message-ID: <Zp7z1eY6GcGzrZaJ@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	rsbecker@nexbridge.com, 'Thaina Yu' <thainayu@gmail.com>,
	git@vger.kernel.org
References: <CADeMgjBeyWkE3mp+-x57NSsyNLQf3cTta+Xm5uyVOQE-rpT6yg@mail.gmail.com>
 <Zp7Pg7ZOlBZcfJei@tapette.crustytoothpaste.net>
 <031701dadc8c$db6d3370$92479a50$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8D/XV49przLNfUzC"
Content-Disposition: inline
In-Reply-To: <031701dadc8c$db6d3370$92479a50$@nexbridge.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--8D/XV49przLNfUzC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-22 at 23:14:03, rsbecker@nexbridge.com wrote:
> On Monday, July 22, 2024 5:31 PM, brian m. carlson wrote:
> >Assuming we add such a feature, how does sorting by SemVer differ from t=
he
> >current version sorting?  That is, where is the current version sorting =
deficient for
> >SemVer?  Also, what do you want to happen when a tag doesn't meet SemVer
> >requirements (note that the "v" prefix is not allowed in SemVer, althoug=
h it's
> >customary in tags)?
>=20
> Currently, tags would be sorted as follows (simple example):
> 1.10.0
> 1.2.0
> 1.9.1

I agree that this happens without any --sort option.

> With semver, the tags would be:
> 1.2.0
> 1.9.1
> 1.10.0
>=20
> My take is that this, if implemented, would need to be more general, and =
include prefix and suffix handling, so:
> v1.2.0
> v1.9.0
> v1.10.0
>=20
> should sort as appropriate. We might need something like v({semver}), or =
a more general regex-like (prefix){0,1}(semver){1}(suffix){0,1}.

However, this is the behaviour I see with --sort=3Dversion:refname (or
v:refname).  For example, the command I provided below running in the
Git repository sorts v2.9.5 before v2.10.0, which I believe is how this
was supposed to work.  Of course, I could be totally off base, which is
why I'm asking for clarification so I can understand better.

I think it's also worth asking what happens for tags that don't match
that still.  For example, let's assume for the moment that Git used
SemVer.  I have added tags in my Git repo for when I send a series, like
so:

  7a9ba024ccdc440095537cf53ce69a5749798165 commit refs/tags/sent/credential=
-alwaysauth/v1
  a74efc1699038e898960c2c55185f32aade6a88a commit refs/tags/sent/credential=
-alwaysauth/v2
  ac45947b34d003f827d15a8623c0125fb12ec261 commit refs/tags/sent/credential=
-alwaysauth/v3

Those clearly don't meet SemVer and will need to be sorted _somehow_
(before or after SemVer tags?), and users will want to know how.

> While at it, having a reverse sort would also be useful. For platforms th=
at have semver-util, this can be trivially scripted. For exotics, no such l=
uck, as semver-util is not especially portable, not for lack of trying.

I think we have this by using the `-` prefix, such as
`--sort=3D-version:refname`.  I agree this is very useful, though, since
it's an O(n) operation to reverse the list, which, as you mention below,
might be large.  If we add SemVer sorting, we'll definitely want it to
work nicely with reverse sorting.

> >As for the special range syntax, I think the typical suggestion is to fi=
lter the output of
> >ls-remote or for-each-ref by piping it to a suitable program.  Perl or R=
uby are
> >common choices here, and both could easily parse SemVer tags.  For examp=
le:
> >
> >  git for-each-ref --sort=3Dv:refname refs/tags/ |
> >  ruby -ne 'if %r[\trefs/tags/v(\d+)\.(\d+)\.(\d+)$]; ver =3D
> >Regexp.last_match[1..3].map(&:to_i); puts $_ if [[2, 6, 3], ver, [2, 15,=
 2]].sort[1] =3D=3D
> >ver; end'
> >
> >Git is intentionally designed to support this kind of shell scripting.
>=20
> I think implementing both wrapped semver and reverse sort in git tag migh=
t be useful for large projects, like git and OpenSSL where the number of ta=
gs is large. It would make finding time-ordered releases somewhat easier.

My worry is that a special range syntax isn't going to cover all the
possible needs.  For example, I might know that [v2.5.1, v4.0.0) will
work (despite the incompatible version at v3, my code isn't affected),
but it's very difficult to express that via a range, since what I want
is basically a tuple sort on [2, 5, 1] <=3D ver < [4, 0, 0].  That's easy
in Ruby (well, it's not pretty[0], but I did it above), but you can't
simply specify a range in any one field, because v2.6.0 and v3.0.5 would
both match the pattern.

This kind of thing is very common with lots of Ruby gems, which, while
they have a backwards incompatible change, don't change all that much,
so several major versions might be acceptable.  In that context, it's
likely that some sort of external filtering might be more general and
robust and meet people's needs better.

However, I'm open to being convinced otherwise if some compelling syntax
comes up.  I'm just asking questions here because I'm not super sure
what the use cases are and I think more information about the proposal
might help people decide better.

[0] That's because Ruby supports comparisons on Array via <=3D> (and thus
sorting), but it doesn't implement < and > themselves (although =3D=3D is
implemented).  Therefore, I had to sort the three versions, and if the
given version was still in the middle afterwards, then it was in range.

Another, less pretty (in my view) option is to call <=3D> directly and
compare against -1 or 1.  If there are any Rubyists on the list with
better ideas, I'm open to hear them.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--8D/XV49przLNfUzC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZp7z1QAKCRB8DEliiIei
gV9qAQDkXfU/s4pdscWag8EbtN8ZiKcERNxksZpLMip92RRPRwD+LGumGvCigp50
VwxO5SlQfARwA/iX2NQdz+7otV7ikQk=
=zfU0
-----END PGP SIGNATURE-----

--8D/XV49przLNfUzC--
