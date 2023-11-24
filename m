Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tq534QOR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VOYvGLPA"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36301D46
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:07:45 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 5DC5E3200A32;
	Fri, 24 Nov 2023 06:07:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 24 Nov 2023 06:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1700824063; x=1700910463; bh=8r
	x2bYY+WNmdbWWod7cv3n2agj0PDcw8guK8VJSK2nk=; b=tq534QORkYYejQIalO
	kIZdmoIkgBhsP4QH6K+vJ+6Ym0L9aueDMmMBz4KiNWxkoeN8r0TBQ0gol7BLJNRi
	Di5x+3P6+SZTTdsQBQqjHrD2SQXXzR2clE+f+eEpdR5w4tlmqo1KnAX7h1H2Z4kM
	YKgww3XmRpcwq8fO2sKgLJDZGqgEHtvtJeEZnSDQUd1dvVqlZi/OLb4gtfTPdFfB
	Qqgx5jieazRUslbfNdu68WEiGN9HNSZZ7++ARJNeFBHeHmQq7WqOk2vQiyxh09AK
	lJmDC+HlogSLXx6phYudBIthHsQ8xOlQXRDtohq9JevmUPHBTOX3F7PLh4tZVA9o
	d71Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700824063; x=1700910463; bh=8rx2bYY+WNmdb
	WWod7cv3n2agj0PDcw8guK8VJSK2nk=; b=VOYvGLPAyhvI4FJZwcfFyb8VeY/Kc
	iqiXT91w1muwOsmSWBORj7CwWRKM1bYgO0nQ6FqWAxPFYYjrHWUWw0JIuvU+fYbn
	696uMc78SvDTeoGvhwKdhEdCCMwcBlNZMGk1wOxHTq5OckjigO8Et5hjgWivlqDo
	fBKnU2cvzksiJtaY9DEyynOUegX9fnFcvx+bFdtk8AmUXHeiJRJxPkp0eSp/7Nfz
	L1YA/KevlJnxegI+OrFszhS2tONxq8iRtruEX7KjtP02b6MlR+ssxDwfPiR8DM8V
	5zA90ieW+Nd15t9jVPJ/8xKj2PyAO034GivIR+LnyHKZP+L6JFHVimsPA==
X-ME-Sender: <xms:_4NgZdtdA6PgqWZUia9N22iJmIW_carprAQa7lAQYmY8viG1WPCTDg>
    <xme:_4NgZWfUmyYP0vpiXiA5RDP9dCHgGcjlBBx6JWqPy1TGqEFb2UsEVohfyUWBMwDGx
    JgdxTblS5qKx-pBrg>
X-ME-Received: <xmr:_4NgZQxSgompoo80-SW0xDJyLiX3aYG82zy6FgXYa9N11IarrRf8lrDyRfzKIWs9EGyOuSxnJIMSDEu-0XODfemWgJe-kT9XaI9NfhsfqTxngc8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehhedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:_4NgZUMjJ_KxANlwgl2IL_vl15coccbonnQODqFVRhDQgwIMwWeNog>
    <xmx:_4NgZd_5XxydqE0u1bpgaoMr4D1puIfTXbUCiBGmXBJ2NASaR9drCw>
    <xmx:_4NgZUVa1os7XBQ_xP9e36-CieGxA_pqrYQ63abEkceD8_SfCIPqEQ>
    <xmx:_4NgZfLDlp8vgYQ8TCJQpTghChHLfrSQoxgPwrxgqwXJU-SzjDzzEQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Nov 2023 06:07:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a604adb9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 Nov 2023 11:06:41 +0000 (UTC)
Date: Fri, 24 Nov 2023 12:07:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] commit-graph: disable GIT_COMMIT_GRAPH_PARANOIA by
 default
Message-ID: <ZWCD-cDbhTCU0aU-@tanuki>
References: <7e2d300c4af9a7853201121d66f982afa421bbba.1699957350.git.ps@pks.im>
 <f1235741cea5866e67c83aca83a760e0cdde8730.1700478031.git.ps@pks.im>
 <xmqq7cm8bsny.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VOt+VerI+ors28F3"
Content-Disposition: inline
In-Reply-To: <xmqq7cm8bsny.fsf@gitster.g>


--VOt+VerI+ors28F3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 08:44:33PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Note that this requires us to amend some tests to manually turn on the
> > paranoid checks again. This is because we cause repository corruption by
> > manually deleting objects which are part of the commit graph already.
> > These circumstances shouldn't usually happen in repositories.
> > ...
> > diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
> > index 40265a4f66..1ca4eb5a36 100755
> > --- a/t/t6022-rev-list-missing.sh
> > +++ b/t/t6022-rev-list-missing.sh
> > @@ -13,6 +13,11 @@ test_expect_success 'create repository and alternate=
 directory' '
> >  	test_commit 3
> >  '
> > =20
> > +# We manually corrupt the repository, which means that the commit-grap=
h may
> > +# contain references to already-deleted objects. We thus need to enable
> > +# commit-graph paranoia to not returned these deleted commits from the=
 graph.
> > +export GIT_COMMIT_GRAPH_PARANOIA=3Dtrue
>=20
> test-lint-shell-syntax is a bit overly strict and complains against
> this line, so until it is loosened, I'd suggest to do
>=20
> 	GIT_COMMIT_GRAPH_PARANOIA=3Dtrue
> 	export GIT_COMMIT_GRAPH_PARANOIA
>=20
> instead here.

Fair. I was pondering whether to do this when writing this line, but
remembering the recent discussion about it being in POSIX [1] I didn't.
Didn't know though we had a linting rule for this, so I'll send a v3 to
split up the statement.

Patrick

[1]: <87430c6c-91c0-4be1-b89d-bf442b3f018b@gmail.com>

--VOt+VerI+ors28F3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVgg/gACgkQVbJhu7ck
PpThDw//RD/mur21EmZd6cgVSoRaMdAqqYeqpvSaPTdQVhTv2+svixxJvbsT427i
2nZ7L2Pep1EctFYOjzYQA8mT4E2WMxet8lMxXhj4NNoLKC9CUQ3A0CYjrEyVudj+
XUbA5+K7GaLHV6RS92CTl4U2Lx/oCeGqGKoFyA3jQEI7vx4Qhf1fcEvpG8nkzv6F
xev+Kan+ZV5Kc8oMucMj2deMYTeFzN8zWMzT+2Tg0D7XHwD22M1/5EmC2KCQw6jN
cTvLw+9G/240cqYoKNZfrgRqeQpfydvPN9RYXO4DP4+MlZcS/quPn/ZAq/ASOJgK
u3F5f9+fGSfdSEsie1EnRMlpixWE0WiSgzzrZ65dAQucONzXBsGrnI2pT1Xpnn4E
SwwZvJkYfvexyFdbQZUiNGvf9WcRVs16fRCcao3mYFhFxPYDyXOdK23DqCsxd7E+
mFgeH5MdoDzN6rfh8ntMsDFkrx3adqflOiu5D7GWnqfLiXPua8k7wmEDcm8Yrl8U
WoRRrdUIQ+sK8NMjJaRaAfHNB5WUfmcrIrk72o0dac79ug4vTSE4hBqkrX2/msE6
Gz4aVA+Dx+jB6cjgIO8LqbJwy6kEyKs6vZVwutBH5NFxg+pAjwu4SxCo1r4EuFn/
DKOIytBFxQP7eYbKmSd/Q5Xbm08yMUf2ZPIpZtfWdrUbTrYL5Fk=
=e0gk
-----END PGP SIGNATURE-----

--VOt+VerI+ors28F3--
