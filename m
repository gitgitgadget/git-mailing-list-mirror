Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB2D11198
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eh8I9BTx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sQrZ6FKA"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id EDD8F5C014B;
	Mon, 18 Dec 2023 03:56:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 18 Dec 2023 03:56:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1702889774; x=1702976174; bh=Z7ub5CUMsa
	jZmRxgU/EUVuI+fnI5wiIc/fvJ/hBudXA=; b=eh8I9BTxou3cFtqCXx0vAlIy4P
	Ogc8LR2XTzW75JLTQ3a1uRLsvN3L8j87kkSLnnMoGzzIRm2Zb1k4honLXT4bon9r
	MGLJ5V87RFJHoAeNNY9c0B0CbpBax7W4Mj6P7uSIjEponppozrridA2lLrPUqK/K
	fPSLcbDTsjkAZ6FfvdhXmaoDWY8Psq7aq9E8QFuvKxNPwHvJpwWcP5d/edyGqN6J
	odEm43BB7guR0ipW5gWSqt3+Dp6Ed5ozrVcqYpJaUEpP5JgJENCUdb24yDwx0BSr
	mNbv7NorDixYkDqNacfu+c8VGxYq0K1sN6Yp1YOSi3Z9oEj+cshJt6Xkd3PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702889774; x=1702976174; bh=Z7ub5CUMsajZmRxgU/EUVuI+fnI5
	wiIc/fvJ/hBudXA=; b=sQrZ6FKANY2PSyHSxQV7Pqyje3VEBZbZLYb+9Jz7MWL9
	cFpYvddTOb1we9k0Cl+H7AV77uiwNYjhZzPhBOm6zWouHqUDO6I0b2XgFhazS4EL
	HkAAt6aqAFTlPdaJjeFZ4K9XTtBc1/nqQxl31zTNZkQ8c0i8WNDm2Awka4GmwaSe
	rHamUoD4ACywyp4MnWPtnTvEMk70eIdR0vWtUCArCdfKpchAWP2gK0W31jlTCY9t
	ZKnlSfCQL/xkvBG3teCpTA3cV8X1fio3TY4YnzidHcgcGR4YNZaXERiuXBErkUcc
	f8tfNwwoSKTitCY4JcSscBemQnNsf4YzF1Aut21dew==
X-ME-Sender: <xms:LgmAZa_Xwr2XglxqeYvYQ15llq-PH3AGvJHg7cKPC6PnHq4Q98J2zA>
    <xme:LgmAZasrB7nXZCdeB3c0-A_G1cpjcfvDj7uv8asrVWMs_9h2ZA1rmZlSwxn8c8GR5
    -umy1QIePWj77M-nw>
X-ME-Received: <xmr:LgmAZQCSTbzTfd34xKu_i3VJAMa2WdVobBJZ_sOxIpIwO7udUARcGuMQ9og__F4toNpf-UREFlp1DIglGGTqn65Xz3XKZPPISfFgioFcr0N32c4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtjedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtroertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheefhfeutdevtdefieetueeggfefle
    egleevheffueekleefhfeikeetveduhfffnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:LgmAZSeWFrtvRyOYRvqwZOso6yUshK4n60lnKaCal7QjjEiXPFUjSA>
    <xmx:LgmAZfO8vG045T09mU4mdZgTZNRSWGnztj981PjekVmwBazlMzqySw>
    <xmx:LgmAZclhCbZc5sGjpUaG1HWbYXggr4mBlTQ7FNmfGmemCvwdyCrN6A>
    <xmx:LgmAZRXv-rUnIIYHg4Sjl56tZphgj5zaBraolcEdlAXgJspKH4YGbg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Dec 2023 03:56:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0604a604 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Dec 2023 08:54:21 +0000 (UTC)
Date: Mon, 18 Dec 2023 09:56:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/5] make room for "special ref"
Message-ID: <ZYAJJzUtpBkhVEbG@tanuki>
References: <20231215203245.3622299-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QnKqQEPBEYoP5aYM"
Content-Disposition: inline
In-Reply-To: <20231215203245.3622299-1-gitster@pobox.com>


--QnKqQEPBEYoP5aYM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 12:32:40PM -0800, Junio C Hamano wrote:
> Patrick's reftable work is progressing nicely and wants to establish
> "special ref" as a phrase with some defined meaning that is somewhat
> different from a mere "pseudo ref".
>=20
> A pseudo ref is merely a normal ref with a funny naming convention,
> i.e., being outside the refs/ hierarchy and has names with all
> uppercase letters (or an underscore).  But there truly are refs that
> are more than that.  For example, FETCH_HEAD currently stores not
> just a single object name, but can and is used to store multiple
> object names, each with annotations to record where they came from.
> There indeed may be a need to introduce a new term to refer to such
> "special refs".
>=20
> Existing documentation, however, uses "special ref" to refer to
> pseudo refs without any "special" property, like FETCH_HEAD does.
>=20
> This series merely corrects such existing uses of the word, to make
> room for Patrick's series to introduce (and formally define in the
> glossary) "special refs".

Thanks for helping out with this effort and kicking off the discussion,
I highly appreciate it!

Patrick

> Junio C Hamano (5):
>   git.txt: HEAD is not that special
>   git-bisect.txt: BISECT_HEAD is not that special
>   refs.h: HEAD is not that special
>   docs: AUTO_MERGE is not that special
>   docs: MERGE_AUTOSTASH is not that special
>=20
>  Documentation/git-bisect.txt    | 2 +-
>  Documentation/git-diff.txt      | 2 +-
>  Documentation/git-merge.txt     | 2 +-
>  Documentation/git.txt           | 7 ++++---
>  Documentation/merge-options.txt | 2 +-
>  Documentation/user-manual.txt   | 2 +-
>  refs.h                          | 2 +-
>  7 files changed, 10 insertions(+), 9 deletions(-)
>=20
> --=20
> 2.43.0-76-g1a87c842ec
>=20

--QnKqQEPBEYoP5aYM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWACSYACgkQVbJhu7ck
PpQ05Q/9HMk75qP+6RJHh37Nzzb0wE7bB1uwZu/5Z6XA7BkCzxodo0EGum8Zf9wJ
hml1NbcgbucDZ9Pbp+nr5nuW8ubt3Xgxn27MwuluhHnU82b3opo/KltpT8syx3A0
dyF268lx8vIx3+nX0eJs+qxcW0iX7Eqn3yB479z8Q2uH9PIv/komabaa8xA3ISdr
19jpfPF78A3XSThoWb5d8ztHuqS+hNCzZXqABLVLKS5FurZ/W10u3uS7sCncFmLz
88akFJAz9P9UT9ibFsHWRSpNkz/Vf2jWG/Mgcuv5PsOaub4zGvs5y/DSAePXXSCG
6d+bcLgNez3kQ8imWCL/VSIub2EOAO/xrs2/5MaatGRvGYf1mxuAqPXm1wm/p6jv
tZXcS2CgA7a3uMFH8FzacNfkDvIuW2z2/C+TRu69VrVQCSEmDT5hoQ/quh364tEV
Jjj+yiDx/DQ1T/ZgyOLpgwPjPx5KibVOTVBNbWgfr82qx6A7TDQuom0RWBr6xNxx
ZnCq1mMlyJLWTrcBwTlw+Wh3WQEzZ0O0hN8qSN58ss35hg6/cvBtpWesDK5xQ7Mz
6RbwIzcYWHgxZXKJQDg5GmiLYkA+ZpzqtRp8GSIpeobFPTvPFMKVid9LOQxO7c3J
Qf0x25RWqxv6VAyYrRmLFDvGXBGLEcm37A5vUc5kCIZBoXyw/mE=
=rTnv
-----END PGP SIGNATURE-----

--QnKqQEPBEYoP5aYM--
