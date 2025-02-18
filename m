Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BBC21B9C4
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 19:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906949; cv=none; b=Q4/Mx9u+0oYxwGVWu56mClBT8Sok3qVlXJlSdRez4WFfwQVzaN96hooIa2GNOjDKYGfqpX8r1wlnnQu3K2Gt+a9Q6DQCn5B63aXS7uqxGsMR//A+HKHrcN0xwNdU6Ml3tdJ9bggKzzqUb/biwx+K159YVbAT4l7wYXduarwFQUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906949; c=relaxed/simple;
	bh=fQXIrveofinxT/3Gy3T6Umk6SCJUc51nShFpnO8JMR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsH9g4GQ9evApbJixezFuoj6QmP3/T5iiGkClXqEeI8MLoLGO/UXac5n1zuNQ5rZUYAMvI0LYcfn3ZGk23IfBW0h9w6Bv0nBQn10chKHm6wQ6cXorS1Bql+ZG5NA1E9VEoZI9PAZkoc65yWwHRT7EP/QfANXx77vh6XhetNno0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=s07y7Az+; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="s07y7Az+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1739906945;
	bh=fQXIrveofinxT/3Gy3T6Umk6SCJUc51nShFpnO8JMR0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=s07y7Az+T+j8oRJqVI2WZgjxX8pYEvOAIOQGSQ0B71ViPvbFSn4aVoKZwJ3bJNcng
	 PlV3plPF3LIebJzKLvRZ93jxy2t24BW2Zg11ilVSFFH+6maosCJjeaUONKrWDAD3IC
	 k4KAnNX7qSirLWBGWpmsqrwRn0fTMSbl0FqNx+g9ZZd9PRWQkySsJPMWJONZHA4IBX
	 c2TGtG9GMZdl37LUAdYHit4L6MhKvM5j7wEfHPW3kDNXi1qIpsev4RiHPROoSIHd4b
	 NmVZSWFp0KsUmrcuIzhNg7uFvDU0UmsS4R7BX65VsPIKhKTOuw3AG2ei0HEBh8Jmi1
	 P+S+cMPWCia7nxR5SLZt4Yk+6nD7nEiq0uHPCjuWkSMd5MRvQVtMHubJ2TkVWeSR9u
	 hZhqGUuw7y83qCSDx6jZlfIc+tltnUCCOXytl6Go2mG67LavQVUNifGwKnkyOn64jE
	 lh56CD3Dm0cyD8Tv5+YqwiBB4+VItRgc1KptFvzRpDmGN9hQSlL
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 77D342007A;
	Tue, 18 Feb 2025 19:29:05 +0000 (UTC)
Date: Tue, 18 Feb 2025 19:29:03 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jared Van Bortel <cebtenzzre@gmail.com>
Subject: Re: [PATCH] diff: don't crash with empty argument to -G or -S
Message-ID: <Z7TffynGALJM4KfH@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jared Van Bortel <cebtenzzre@gmail.com>
References: <Z7KX2y-dXaZuPrW4@tapette.crustytoothpaste.net>
 <20250217175759.1576684-1-sandals@crustytoothpaste.net>
 <xmqqbjuzxgn3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tY8VX8a1BMI1FYYo"
Content-Disposition: inline
In-Reply-To: <xmqqbjuzxgn3.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--tY8VX8a1BMI1FYYo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-18 at 18:16:32, Junio C Hamano wrote:
> I agree BUG is unwelcome.  I am not sure about the value of
> forbidding an empty string (I am sure about forbidding NULL,
> though). =20
>=20
> If an empty matches everything, "git log -S" would skip changes that
> would keep the number of lines, right?  For the history of a project
> that keeps track of source code, such a "feature" would not be
> useful, but I can see a complaint by somebody who may want to keep
> track of a "list of things" one-item-per-line, if we had been
> allowing an empty string.  It would be a regression for such a niche
> user.

I actually just ran a `git grep -e ''` to see what it does, and it
does indeed match every line, so presumably `git log -G` would do so as
well.

I do see your argument that this could be useful for a limited number of
use cases, but as someone who often keeps track of lists of things in
text files and therefore could be a target for that feature, I still
feel like this would be very much a corner case.

> Luckily, since we have stopped with a "BUG", we do not have to worry
> about backward compatibility in this case ;-)

I agree.  The good news is that we haven't broken anyone's workflow,
unless their workflow involves trying to trigger bugs.

> So I'd say that it may be a bit premature for us to declare
> "anything useful", I am perfectly fine with the patch given here.
> If somebody who wants to maintain a text file, one-item-per-line
> that keeps track of a list of things to omit commits that do not
> change the number of items, they can drop "&& !*arg" part, tweak the
> message and add their own tests, once this fix lands and the dust
> settles.

Exactly.  If there's one thing I've learned, it's that there are lots of
users who will try new things, and I'm sure we'll get a report here or
elsewhere that they'd like to add this feature if there's actually
interest.  Fortunately, I expect that it shouldn't be too hard to add
such a feature.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--tY8VX8a1BMI1FYYo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ7TffwAKCRB8DEliiIei
geZWAPsFVMPstiVHdv4jn5YsR5UnNHVyTeYnjJZnTm6PrU/gNQD7BC8I+KSbDKzB
C61q3JrdrQpInMj7MaX9pLcrjKmldAI=
=Cn6O
-----END PGP SIGNATURE-----

--tY8VX8a1BMI1FYYo--
