Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F996A33F
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 21:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727991056; cv=none; b=VPp1YHt3xW05OT1m2aDQ6Gjvb/yd6yF1BiMeJSYdFrE/h9JefqnsE9RmM5Vbxjxo07D8VeJQUOsv+i35gdXiRugV2VsIFL2JIVbhxegbLzQijc+OaeHMWVQ1iGP6aX1mjjAlNUDS/G4Murud/yIrjZGhSTHhacmtI4R9qXXJu+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727991056; c=relaxed/simple;
	bh=iwyCkk6pBy45ek02pX4N71wtByX6/t0vPk+v/1YvDjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qak4U/tm80SXZFqlPLCjvKl2+Z+WRs0siYR4W4WcgOgKr0K3izKAGu9fJehKXVcawNEAqm/S/otQKJeDC1tNn4CXq6zbnaw4E3O5qgvHsiCvJAflLf6/HM3RMmMb3xt8wtYF4t2LRADDNX1uKKp3d+Gh3W+sABJWMKt5ArzZmmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ZtXT1dvw; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ZtXT1dvw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1727991052;
	bh=iwyCkk6pBy45ek02pX4N71wtByX6/t0vPk+v/1YvDjc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ZtXT1dvwA1Ld9KcqVnKXq/4VeU4npNUp0rTHhCoddDsYWGeqbjJuBxlp2GP8KCDra
	 62o2xa+SpBuw32wOTQ+Bvj/LcWEB+YU6fjdkqSo/Zy7LhPMyKl6ASpQgKDsRUCUKad
	 xTJaeUU18MdYr64OaozZvO7MZj0r8vMrYkFPntCyL97pBP0H47+vlATn6tNYZCHPbh
	 dUiUZoyEEKjhpJ84fqP/vP+F9hGWN1KHOkNxWRrW+7DyyHKAKfajN0/9IaYJSZpX2s
	 VlNHSqFf3lZGsti9RYQO/Cor7k4suq4W0XEwaYTw72/Wz95tw4AV48hQmKo0PXygp4
	 xq0pDu04a5IzB8HF5Xdg6grXl6uzobP80lWRkjqxBU51d62JfYmAf6eHQ+sZvzXCmb
	 gAueTdqduwWVBH0u89ZFfD8Po2yvlwyPybCzGUHSfyoJhazGM00nffJ1+D8gngvOSi
	 bEQTCQN8tc78l3PtycBefOyZZVh6a1EkWFKwn/8DejuxIymyehz
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 96BDD2007C;
	Thu,  3 Oct 2024 21:30:52 +0000 (UTC)
Date: Thu, 3 Oct 2024 21:30:51 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Alireza <rezaxm@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Request for adding a "one-shot" rebase strategy where conflicts
 are only resolved once
Message-ID: <Zv8NCxzrYJ6Gi6Yu@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Alireza <rezaxm@gmail.com>, git@vger.kernel.org
References: <CAD9n_qgBPDQKF=ZEQ6SWvDCmcUXZvz33zSoHFQSwHmQPWS4z_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oQ2TftnGNjZAeiSi"
Content-Disposition: inline
In-Reply-To: <CAD9n_qgBPDQKF=ZEQ6SWvDCmcUXZvz33zSoHFQSwHmQPWS4z_Q@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--oQ2TftnGNjZAeiSi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-03 at 19:06:28, Alireza wrote:
> Sometimes a clean merge is possible but with a rebase, in-between
> commits may raise conflicts in which case a conflict must be resolved
> for each commit individually, which is not quite productive and at the
> end wouldn't add so much in how the resulting history looks like.
>=20
> With a "one-shot" rebase, a conflict (if any) is made based on the
> latest revision, then in-between commits approximated based on that
> resolution. This way the history can be roughly preserved with the
> same amount of effort while still using a rebase rather than merge.

People actually use rebase in some cases because they want conflicts
that they won't get with a merge.  For example, for a merge between
`feature` and `main`, if `main` adds a change A, and `feature` adds a
change B that would conflict with A and and removes B, then with a
merge, the merge is clean and only A is included.  However, with a
rebase, there's a conflict, and for some people that is absolutely
desired.  We've gotten complaints on the list that merges don't have
that behaviour (merges consider only the two heads and the merge base).

I would also point out that your proposed one-shot rebase will make
reviewing commit by commit much harder since it won't contain the exact
changes that the author intended in each commit.  I frequently write
series at work and on the Git list that have multiple commits, each of
which is independent and logically bisectable, so that reviewers can
have more confidence in my changes and understand them better.  This
feature would be confusing to the reviewers, and it might break
bisectability since the code might not build and pass all the tests at
each point.

I am also somewhat doubtful that we can come up with a good
approximation algorithm for resolving conflicts in this way.  I'm
thinking of some rather tricky conflicts I've had to solve in the past
and how pretty much any approximation I can imagine would have ended up
making things worse.

Perhaps if you can propose an algorithm for doing this, people can
provide you more concrete feedback on your approach and its advantages
and disadvantages, outside of the more philosophical objections I've
mentioned above.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--oQ2TftnGNjZAeiSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZv8NCgAKCRB8DEliiIei
gemsAQCiI/e3UOJ1FEaKVWxKRn+zR2Ct8p+O7ckKvEpGVMhEBAD/S8ZSDQdBtxKH
+pU1LwDVsmtLD827u38X7f4U7eOiQgw=
=tbvQ
-----END PGP SIGNATURE-----

--oQ2TftnGNjZAeiSi--
