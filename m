Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LUZw1bew";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N/Pf12Ay"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568CB1712
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 23:49:20 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 93E163200A3E;
	Fri,  1 Dec 2023 02:49:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 01 Dec 2023 02:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701416959; x=1701503359; bh=O+
	n2wG75567lZlRxKbQ8lhiGHodia6ttiZe0klvf60A=; b=LUZw1bew2MmCkNwSDY
	AtYk8nDra2iPkUwDKXr1CRXqh+UxbYesPYYi6VPibJ/MkLxWI0PrDSvbFEFw+O9e
	0hq2rATyxgWS/jUnEhAXtU6tuwFsq/qxcUV4HuBqQxDgyaC/XyMAffIs/cCYGkwr
	/pl1nFSGtcJ15y2ZAs2meh7+lFg4DmLjmEFO/X0d7HgUoKRX3+MHyBWnsert39VO
	h23mXoiFdw2nxUMKnHuelZpfwjdXg0I8Wg0TzujyYRbzF9DbKkHeA02cVZXhNf63
	iRM2H+rTMsOtYfV/N/nO/oh6Y8uZWp6EJSYHo74CYVIVVrb+7ahryal1xZeRJiAd
	KtGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701416959; x=1701503359; bh=O+n2wG75567lZ
	lRxKbQ8lhiGHodia6ttiZe0klvf60A=; b=N/Pf12AyIjVc8Bfq95qeXtcPi4gUh
	Me+990Txm+TpK9ikJbVtcDdJhFmyMnuWTq8kLAt4oLsjazRd7vf+KuuHce+Z2m6O
	VlQm7HsRX59fH1qpbYOc5NzUJ+aKIYkPa58wxQUqpJ6YF38N4wtdGKZmkKzMOL+p
	Uz1jayzVZa5yeMMGAlyr2XYEoxHZs8NRS5ExIndyDY3gFFXSN7IHVOMSlwvJyKHt
	ZXY8V5ACYIP1a7eVpgBh2aCb0G9B9h9SNxl6fbMt6xo3MyDPAZgebEcOIOq1RABe
	GLR0NeacLL+PHw04EQkDYd0Yb71U0bpRcxxfGVlZxZQ89RRH5YRP/F3JA==
X-ME-Sender: <xms:_o9pZThYGso8CXyXXuLi9BKJBz14pWY4Vk6iFHUG3DKp4kyi5d9yYA>
    <xme:_o9pZQD8D-S9IFQ3xBWh0bqJFmw3nt-OVMNycRNYFsSb8Dvd9xNBCxgymS04nZ5LM
    fQjJ8aBjnUI8muhqg>
X-ME-Received: <xmr:_o9pZTGklr75VsGbU70_7rnCNrtKl5m-8bnzGth5TgjQpzDZsfbTLe9UfuSR-DpUSmIlf70ITRzjgEK451jr72Jd5C8m2JtX7YtBmzdS7-fCc4M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeikedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:_49pZQRbt51C_-e37oBCv18qDGg8XXecrMpt03VeK14Az_AFRhrf5w>
    <xmx:_49pZQwdy37P-8rDfJTEBAMNuYH9GqnBudpZDp_wzf5Lo13Y-q3MEQ>
    <xmx:_49pZW7CiiiojSEsnBF5Saw8PEkYlX6Bis85mAjEuPhRaWf2pkfBqg>
    <xmx:_49pZdpCFfUjGLMSC7QyHUPdNH_PiKY7QbgABH3fTM15AenvJV8YbA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 02:49:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a3530db1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 1 Dec 2023 07:48:02 +0000 (UTC)
Date: Fri, 1 Dec 2023 08:49:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Stan Hu <stanhu@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 2/2] completion: stop checking for reference existence
 via `test -f`
Message-ID: <ZWmP-5rgGntYQYMt@tanuki>
References: <20231130202404.89791-1-stanhu@gmail.com>
 <20231130202404.89791-2-stanhu@gmail.com>
 <20231130202404.89791-3-stanhu@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Jy5CgQR9JMtDQDu0"
Content-Disposition: inline
In-Reply-To: <20231130202404.89791-3-stanhu@gmail.com>


--Jy5CgQR9JMtDQDu0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 12:24:04PM -0800, Stan Hu wrote:
> In contrib/completion/git-completion.bash, there are a bunch of
> instances where we read special refs like HEAD, MERGE_HEAD,
> REVERT_HEAD, and others via the filesystem. However, the upcoming
> reftable refs backend won't use '.git/HEAD' at all but instead will
> write an invalid refname as placeholder for backwards compatibility,
> which will break the git-completion script.
>=20
> Update the '__git_ref_exists' function to:
>=20
> 1. Recognize the placeholder '.git/HEAD' written by the reftable
>    backend (its content is specified in the reftable specs).
> 2. If reftable is in use, use 'git rev-parse' to determine whether the
>     given ref exists.
> 3. Otherwise, continue to use 'test -f' to check for the ref's filename.

Nit, not worth a reroll: you already document this in the code, but I
think it could help to also briefly explain why we're going through all
of these hoops here instead of just using git-rev-parse(1) everywhere in
the commit message.

Patrick

--Jy5CgQR9JMtDQDu0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVpj/oACgkQVbJhu7ck
PpS2hA//eMrPS3FKs20fdUgRy1JzFgClyoYgHjUjfZOXeksB6AsINza/+PYvD3Ps
Olkp5rYK53D3oynG7BSbifpPyWZcfj5NKShLVzf964j1/+vZRNwVdN7FLwK+kT/9
Yqm8OuAKZSik13bgXjwHcw4Ulgi0+dEgo/jIeU2+JituZGtFXpbiGKegRvzNIhfw
3u9kb5mrotErRxLh3AxdfhHOHAVfiyAoSTV29k5NsAjMyaqWvSrRhmMeqsK9DZa3
HgDnm39I6t+xOlpFwvOnfS6MX3UeXX948tehWMJly4ztdlzjGB6KIsjxqBIicSj2
FPkDWAXcqavO7Rv54tfToEewOnM1SbDpxQ65faxzeaBbkXoiEo08aZaDIEyCc6Id
5lOVzk/OrGvmpGUb3f8Xd6dF/ny+hwO8BU5lOUL4JYfxDIo6WnluwekGvsRCD6pg
FHZLOBj+wwJT9ChbeZgNRZmESNGcNkJ/DL4j9DII/GRpqXbHIIV2AbBOAzEJi665
KQenJFFIeg6/K2tbTRkYpnHYtAn02yPgt/4b31Rlim8bins1yFs1LOOauYdYCKnq
Q63v5YvICt2gYQc5dgJvZfzUIjB2FSPwKuQLbLevTg9JUgSgKCXJqDI/bxao7l8S
hMgOw2L+atjRh8ljXkBeuYq0QjB7qm3iChMQhDa3bWJfHX1jCxI=
=75nW
-----END PGP SIGNATURE-----

--Jy5CgQR9JMtDQDu0--
