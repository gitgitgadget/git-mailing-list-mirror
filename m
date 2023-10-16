Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77006381A9
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="l5OEAnZa"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39DA93
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 14:26:01 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 123385B07F;
	Mon, 16 Oct 2023 21:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1697491561;
	bh=0emRAKvAHVOcKvLfHN83+ZZrdE1xjKv12UakbMzPX6k=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=l5OEAnZavG1mm1Si7c4pprhgqmyv1O9YC5Kai6JvdQfjcKeNx8rFDWmifEnq33amJ
	 Pqj44SGbKtTWx8U0BEfYfJLkkTVdWSz6vTUhvwh0X9jxwStbDDoLF67f82AnvvakL+
	 TzZfkxNE/fMZCQrUNBv874lYsxh98JEMuqBz4UvJSulkZMsSJ62P7V+Guuwy/Uwan6
	 bNRqDOv+jgpHedSwOkwDnAUpMHK6v/VFBEqgXEIwQXs/8IZ49D+WPwii74TltwDO6L
	 vKCMDffYC6XOkgogefeqY3nGFKJCw3prQIHmA8j6aXfqwZqKmk2Ob0TVMsQQkAzs2v
	 HqIoY0PUMLR+XBqe8lvY9EozwfGaH4CAb51wijBy2ML0F44ieoJ6vKhLrOw1KRFF+9
	 sTjpr19AYQm3NX8MR/ceYhlyzMbBdK+Vy8HUOI97shXYnv9BXYZa0SjRRurV3ikr9V
	 1xmV5xOii5iZ7rsRJEOzSG0AtiP9qbWGoI5qlgEkvAEBR9CaYP+
Date: Mon, 16 Oct 2023 21:25:58 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Hongyi Zhao <hongyi.zhao@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: Method for Calculating Statistics of Developer Contribution to a
 Specified Branch.
Message-ID: <ZS2qZtYDvItovjqg@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Hongyi Zhao <hongyi.zhao@gmail.com>, Git List <git@vger.kernel.org>
References: <CAGP6POKg4mSFv-Z+dD1aXDFDbxH9Xu1WCdCA5TGfCAM3NUUQLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r5SW3bEp5JfqY9jc"
Content-Disposition: inline
In-Reply-To: <CAGP6POKg4mSFv-Z+dD1aXDFDbxH9Xu1WCdCA5TGfCAM3NUUQLw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--r5SW3bEp5JfqY9jc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-10-16 at 14:10:01, Hongyi Zhao wrote:
> Dear Git Mailing List,
>=20
> I am a developer currently working on a project and I wanted to
> establish statistics for each team member's contribution to a specific
> branch.
>=20
> Say, for a user "JianboLin", I am currently using the following method:
>=20
> $ git clone https://github.com/OrderN/CONQUEST-release.git
> $ cd CONQUEST-release
> $ git log --author=3D"JianboLin" --stat --summary origin/f-mlff | awk
> 'NF =3D=3D4 && $2 =3D=3D"|" && $3 ~/[0-9]+/ && $4 ~/[+-]+|[+]+|[-]+/ {s+=
=3D$3}
> END {print s}'
>=20
> Using the above command, I am able to calculate the number of lines
> contributed by a specific author on a specific branch, which allows me
> to quantify the contribution to a branch by each team member.
>=20
> However, I would like to know if a more efficient or accurate method
> exists to carry out this task. Are there any other parameters,
> commands, or aspects I need to consider to get a more comprehensive
> measure of contribution?

Can you maybe explain what you want to measure and what your goal is in
doing so?

The problem is that lines of code isn't really that useful as a measure
of contribution value or developer productivity, which are the reasons
people typically measure that metric.  For example, with three lines, a
colleague fixed a persistently difficult-to-reproduce problem which had
been affecting many of our largest customers.  That was a very valuable
contribution, but not very large.  I've made similar kinds of changes
myself, both at work and in open source projects.

Certainly you can compute the number of lines of code changed by a
developer, but that is not typically a very useful metric, since it
doesn't lead you to any interesting conclusions about the benefits or
value of the contributions or developer in question.  However, perhaps
you have a different goal in mind, and if you can explain what that is,
we may be able to help you find a better way of doing it.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--r5SW3bEp5JfqY9jc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZS2qZQAKCRB8DEliiIei
gbdeAQDOj4HAvhN4VqFBuGKq8ZGkDds9i3sIDJ7759/cIYOkHwEAz+TbiNzAdT4f
SxuzUkUPKNBG5TkLDw5jR30/KwBAKwg=
=S90Q
-----END PGP SIGNATURE-----

--r5SW3bEp5JfqY9jc--
