Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976692F532B
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755012315; cv=none; b=eqyku9rNWY1jtU5dEncgfYN/3qPRNnyDbcCtZUYk7OQZl3UnkSfbRxRkQ7frBFQsal/iV5jRymwHLfCifqkSae0otVPAATuDnoc94nZPShvKD+Bd+/johGkvjrCYvkJRecXKK068jfIBZuMl+DeG2J1aKRy9hu3VEMe4zSFHCPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755012315; c=relaxed/simple;
	bh=RTbm6jLpYRq/3Mi4wauUHSva5mztUUNnh5YLuXqSywc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From; b=PsQpM7fmCbZlWD9P+jMqgio+tTJHKT2/3O9N/UynIWSJ1qP8rpp46sqYkr0tr+IUL8es3+rpYIyeWPPOw0LaNp52jmMn0nsyAOMJAT2sAD1hTsUlXFH8ByQnQ0oWy0/SIA1UbzSphEKZib3VmnDH5GSpiFZjExZXgPcs7YRrIao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=kKSKcwrw; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="kKSKcwrw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:From:Subject:To:Message-Id:Date:
	Content-Type:Mime-Version:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=RTbm6jLpYRq/3Mi4wauUHSva5mztUUNnh5YLuXqSywc=; b=kKSKcwrwUxXuft8xWvuu5hheE5
	OE0XqXJly3yzFEFn95rkvXQ4cW0fH74BXccF0hy/ngmLkzXU4ClByR2Lc6ubw7Emg5RpV0qxpGD6O
	krOPvlEdUOpoNWNIcGWuNmgNLD/aMKIauBFOT+VxjTA4QC9yrDOkFkfjBjwFSkS87xTnEyttAB6Py
	E6+l/Te7aICV1UfS8skE3Uh9Dx1FIuzud/dl8mpZDag6ZHKg1Vg2Ke8skjH0owCSTcY1Ua/GKu1dc
	YPztKUBH8R4NTzwfwHEBgQHa/AwzQAFQA3sXJJl5AiK4rVf7iC1Oy8qo/+sLJpkTZuL6G9LxqjwRB
	sx5oA7xg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	(Exim 4.94.2)
	(envelope-from <tachi@debian.org>)
	id 1ulqlh-002Isb-N9
	for git@vger.kernel.org; Tue, 12 Aug 2025 15:18:31 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=6e200f4a421b4ce4637e0d7f385ff265428406fea0ec7001ebc4020fbe02;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 12 Aug 2025 17:18:19 +0200
Message-Id: <DC0JSOC14W8U.3UCX8TG6X7W5O@debian.org>
To: <git@vger.kernel.org>
Subject: Signing commits and tags differently
From: "Andrea Pappacoda" <tachi@debian.org>
X-Mailer: aerc 0.20.0
X-Debian-User: tachi

--6e200f4a421b4ce4637e0d7f385ff265428406fea0ec7001ebc4020fbe02
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed

Hi all!

I would like to configure Git to automatically sign commits using SSH=20
keys, while using OpenPGP when creating signed tags. As far as I can=20
tell, this isn't currently possible.

What I was thinking about were a couple of options like=20
commit.gpg.format and tag.gpg.format, as we already have commit.gpgSign=20
and tag.gpgSign. Of course, differently namespaced options like=20
gpg.tag.format would work too.

What do you think? Does this make any sense to you? Let me know!

Bye :)

P.S. please keep me CC'd; I'm not subscribed

--6e200f4a421b4ce4637e0d7f385ff265428406fea0ec7001ebc4020fbe02
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQS6VuNIvZRFHt7JcAdKkgiiRVB3pwUCaJtbRBEcdGFjaGlAZGVi
aWFuLm9yZwAKCRBKkgiiRVB3pyQmAP9U/+yVVk7PjWYqVKxmA7XWU5+0L8D419ax
YnvFp5XA5gEAqotIQ5PdU1htM5nMgVdRTGauVZOW8rNolrILd1VEqQE=
=eor9
-----END PGP SIGNATURE-----

--6e200f4a421b4ce4637e0d7f385ff265428406fea0ec7001ebc4020fbe02--
