Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E/D+21J0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rH7R/yC4"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5810DB6
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 03:35:05 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 4F3BE3200DC4;
	Mon, 11 Dec 2023 06:35:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 11 Dec 2023 06:35:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702294502; x=1702380902; bh=dd
	CzOQrHoV/a1bTKCFiPDVB62zAOmDHki91UNm8mARY=; b=E/D+21J0Xm/X0hoHLt
	uZMGc4MJRelmFQIXN5zEmfvzUnCsF6UKWJOnDvKpxqO3j+bZ7PLpg+gqNojI9UEm
	SvPY7ir45up3bsija05K+iNVi1T+kQSTwXX8Fuxq/DT7ZhjV0AK5TC3RiHkiZwG+
	adGojwanbVkAdX5WulG7+iciMpzqS56MwwUnU6zRXnNmGu9PWIJULlJ+dZ6Xv/BB
	e12WbDXQmAR9Krv19BvjtDeQqnvA+frLOOHMczVeyA82KA8BqjpzlKO3U6gy3Y2y
	5umo+bQ9x7Cpq12nhB0UA0KduLyr/1FRUDZrRNUjeWNuzTZBRxFBSs5Zf1tUI5CF
	oGrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702294502; x=1702380902; bh=ddCzOQrHoV/a1
	bTKCFiPDVB62zAOmDHki91UNm8mARY=; b=rH7R/yC4hmcpf+tlKdHHPkrcQw2px
	o4gGswn6OPA1ZYbKpzaHKV9qTNtz5dWSMEznmckPYkQF4Qg9N2ag1iyE5DlVC4Ez
	aiDbf3eZ1+VG5EB//tPKRQJFStDY+Zl3KYzIevRDbdCDfXmNKw2Cg+VysnIR+YRy
	9GciwQfT6c7vIxxDRnrYpxkWv2AfsoCCWAKQZLVlOsu6/m//OQEr5U1tKDIb+one
	7A7TT9GWkZTQxLAUGRwVuELuMpXBLOZexRdYGuvz3D1VbnyUQaW9rXfRvtW5VuOZ
	4SWbsEAv7Gyc99Ejy6sZsa93GleQc/jdIxz4fIum7eOgvJQ9qp6uVoOlQ==
X-ME-Sender: <xms:5vN2ZYEQA7Lte_uXO4aDt-ZgecOq9VrapbQYuTZvU6WPX2_1IBMv8w>
    <xme:5vN2ZRUJBOn8GKdPAEMB77HT5K8Uwfe6l0jH5vkkgLXV03ibgFqoW0u5iMMWfnr3d
    9ITTHn0zx5XBEeWZg>
X-ME-Received: <xmr:5vN2ZSIUnWNeOddxQXij_k9KVCm-t7VxlwvlZnEvxJ6ddtj_P3kN_xN7_WWauPThHY6qr_eRhAooxmwYNmkAvfVnj2UhrEz_CObbIU3sTesN3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:5vN2ZaGKM9oeLpJrvoocPV2YIVDR9INw82gSR4qZ4m0JQIxAFwIdAA>
    <xmx:5vN2ZeVwLt1LJRJ33p9Qq37wJIs3C34LBPKvIJ0hzoORN3HVazN3Ng>
    <xmx:5vN2ZdNrNhBOw4Y7cYqoe3XNNELOdIYHLTYG5QfgwZwlaHw9mdOzWg>
    <xmx:5vN2ZXfT95UI2SzT_ql7tXq_WxjXDMwF_pJVumr7PC8xYH-Zn-hD-A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 06:35:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0d74108f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Dec 2023 11:33:25 +0000 (UTC)
Date: Mon, 11 Dec 2023 12:35:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/7] remote-curl: rediscover repository when fetching refs
Message-ID: <ZXbz5KbvgrL5u1yW@tanuki>
References: <cover.1701863960.git.ps@pks.im>
 <a1b86a0cbbedcc6610b2c563e9e38d439338869d.1701863960.git.ps@pks.im>
 <xmqqmsukz3yr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NMI8nzQJBUP1uANm"
Content-Disposition: inline
In-Reply-To: <xmqqmsukz3yr.fsf@gitster.g>


--NMI8nzQJBUP1uANm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 09, 2023 at 08:09:32AM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > We're about to change git-clone(1) so that we set up the reference
> > database at a later point. This change will cause git-remote-curl(1) to
> > not detect the repository anymore due to "HEAD" not having been created
> > yet at the time it spawns, and thus causes it to error out once it is
> > asked to fetch the references.
> >
> > We can address this issue by trying to re-discover the Git repository in
> > case none was detected at startup time. With this change, the clone will
> > look as following:
> >
> >   1. git-clone(1) sets up the initial repository, excluding the
> >      reference database.
> >
> >   2. git-clone(1) spawns git-remote-curl(1), which will be unable to
> >      detect the repository due to a missing "HEAD".
> >
> >   3. git-clone(1) asks git-remote-curl(1) to list remote references.
> >      This works just fine as this step does not require a local
> >      repository
> >
> >   4. git-clone(1) creates the reference database as it has now learned
> >      about the object format.
>=20
> Sorry, but I am not sure I understand this step.  I assume you mean
> by "the object format" what hash function is used to index the
> objects (which can be learned from the remote "origin" in step 2 and
> we can choose to use the one they use), not what ref backend is used
> (which is purely a local matter and we do not need to know what is
> used at the "origin").

Yes, exactly. I'm never quite sure whether I should be saying "hash
function" or "object format". I'll convert the message to say "hash
function" instead to clarify.

> Why do we need to wait initializing ref backend until we learn what
> hash is being in use?

This is because of the reftable backend. With the files backend it never
mattered much, because we do not encode the object format anywhere. But
with the reftable backend we do indeed encode the object format in the
tables' header, so it's important to initialize it with the correct
format right from the start.

I'll amend the commit message.

Patrick

--NMI8nzQJBUP1uANm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV28+MACgkQVbJhu7ck
PpSvFQ//fH4IgKzQ4KXHzpaZ2UUScfSXo45di9oIwtGjYfhoElpDUyiLp0a9+qrL
yE6d22Odk4V3UnCqB2qtab95/yMqG/EICkbYGNYFMGi403y73JkjayPE0CyHSiAQ
mZnnQE3v6qAmJH7wGdosgSLIU/ncnVNCNYEqld6ab68jqI23gpgDW7a6EhmLazLN
q0Zclpf7/hb4rdmVXWI8jVBlkB4BBpHGBC0JmOn3w4x2ZRPJIqnmt1Vzmq6xgvFp
LwXeytSEVzKowG3RS9x2zhK526gPinAUeHEmCCzyNLSh89pUeZe+Lse8xtiRvvfM
s6NCR35j3hDicinTy8GAcac3AJ0v2T3MYCPA9ew7VxHTWqGC0lnBsPqkhIsmsdeJ
2HRH26HnuRVaFsrII9fy9x3xtu5dX4agEtJ/BlAmFMkqH1r0AYF+moX/JaewCVlr
AjlwPaKQVYt+bPis3fDnZoH5QmQlQAtQSahfoO/RdszdWXaRo+njSQLo31L5RHx3
5ZWyTRrCFGR1cvD0aTzfZrKLhOTWL3sdKpeh4uoyZZHa1zCDcGd3/b6RyS8rfWI9
eQ7ItzBqixU+J+VxkrZ1k3aLfDtR9e618ot8XiseaWxMCuAf9gZAgOpbpXdvmaoV
og/W2z1FOMazOAS8vSaEV7iwcpzTMRWgAp968e0pbtMCOKXjXs4=
=wUGD
-----END PGP SIGNATURE-----

--NMI8nzQJBUP1uANm--
