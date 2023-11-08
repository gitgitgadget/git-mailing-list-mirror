Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09422D266
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gMzX0WBe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S0g45EAt"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61142198
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 23:29:57 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id D29E832009F9
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 02:29:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 08 Nov 2023 02:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm3; t=1699428596; x=1699514996; bh=ONdv9R91TpQn02QQDUeFxPmLv
	5NXv6Xin+uq6ukVn2U=; b=gMzX0WBeQV0pqRHUPgAVCmeTP0xTxLl3/pVkXwrul
	QwrGBfExxUjmeZwzEjIEackkuZGHpThQZvVAUnX/rTe1Y83L8XNPfK6Vj8RErU/m
	tTDd5fnwbRYV0FPrR6xOhLOLz/NS/9W702JzHeeGUUPuM/F4r56I4mDBFj70Rf/p
	MYMA6kWqgER6VfVfkj/Wx20MuGEfXu0SVLijo35AUieQzCsPON74PSmd/MPaPGW5
	JrMcQma3saNDRG7wFzt2dZAkP7ucZFRowF4WJNlGszi0pTgl9IyJ1OpnfpmteDl+
	Sv5wfYsCU4M2bx474mH30oI/nnM5T8LqXkNCd7tsauDEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1699428596; x=1699514996; bh=ONdv9R91TpQn02QQDUeFxPmLv5NXv6Xin+u
	q6ukVn2U=; b=S0g45EAtTXTI93QSGptaRK9bYCTZ5SJV/MpJfbL678veoV9SZC8
	pdDLFC3W0BZdkNbaBe91mSToqkrAunOH0f5nUFjxRyS6PIgH4q/2I5hY7OPi1OBY
	sSRWkwNGPchAvl1DWSibUBJ5FOY/CJ3OxnxsROxInc2TGrhmLFEUJ+pmwvjvDcew
	ch83x/EdBOzkqKuY6p0G+ackXAy7u+k5VLWDIhHENm0LoaANBwxeu0JhEQ6YOuVT
	RrQQf3Y2TZbGCpVvxFQfWrEDQTEEL0bFqYMzLwPsMlWSDOoDCUNskhF2EQ4MU2Mj
	aG57xTf+yZaVxhq4Em6P/qepft5kILzfing==
X-ME-Sender: <xms:9DhLZUKtZ_gndxiV7YZNJfgNKQrUozw5Bk7I1coV7KezCYAu05ZN2g>
    <xme:9DhLZUItnCbcIT78FCz4RgIJuWZOdY_JtsXYXvu4-D9Jt8nlODr8GV_XgOQvm0kpo
    vRRla_KzpW8noKbhA>
X-ME-Received: <xmr:9DhLZUvpYK2_ojwrbDr0E2FZOtlcMCn6Cq_EUslJIjndrmFz7y3G4vVZpDprPsPgsgggiX26d_vU8BhHzGA3hLYQPM6pY53RlqdIpZ8v8vrS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddukedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeefhfejgffhtdejffekueetgeduuefhudevtd
    efudekudetudevjefhudetleelveenucffohhmrghinhephhhtthhpugdrshhhnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:9DhLZRYj5EPTGGdhp1DEqP86uUFBRkhllQTwgFHN7NU2RbYRJu6q3g>
    <xmx:9DhLZbZ4NIijAFUPpmWE4GJX2NQFw9KRVfgayTTxBDV7iaO8x9CWWQ>
    <xmx:9DhLZdCFeb-z6UKaGPChn9zGjzJkz97EM89F_pVSnCmil9WUZxR1ow>
    <xmx:9DhLZV0GjPKGsNhSEmjfyrGZQLDhjNBuqpYqIJQhjm0Ni0JyUSF5yw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 8 Nov 2023 02:29:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e691834a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 8 Nov 2023 07:29:29 +0000 (UTC)
Date: Wed, 8 Nov 2023 08:29:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/3] t: improve compatibility with NixOS
Message-ID: <cover.1699428122.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mfHgp3h/xIfVOMxK"
Content-Disposition: inline


--mfHgp3h/xIfVOMxK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series improves compatibility of our test suite with NixOS.

NixOS is somewhat special compared to more conventional Linux distros
because it doesn't follow the Filesystem Hierarchy Specification for
most of the part. Instead, packages are installed into the Nix store
in `/nix` with hashed paths that change frequently when upgrading the
system to a newer generation. Consequentially, paths cannot be hardcoded
and must instead be computed at runtime.

We have two such issues in our test harness right now:

    - t/lib-httpd searches Apache httpd and its modules directory in a
      list of hardcoded paths.

    - t9164 doesn't propagate PATH to a script and thus cannot find the
      basename(1) utility.

Both of these issues are fixed in this patch series. In addition, this
patch series fixes an upcoming issue in httpd's passwd files caused by
the deprecation of the crypt(3) function.

Patrick

Patrick Steinhardt (3):
  t/lib-httpd: dynamically detect httpd and modules path
  t/lib-httpd: stop using legacy crypt(3) for authentication
  t9164: fix inability to find basename(1) in hooks

 t/lib-httpd.sh                        | 51 ++++++++++++++++++---------
 t/lib-httpd/passwd                    |  2 +-
 t/lib-httpd/proxy-passwd              |  2 +-
 t/t9164-git-svn-dcommit-concurrent.sh | 12 +++++--
 4 files changed, 45 insertions(+), 22 deletions(-)

--=20
2.42.0


--mfHgp3h/xIfVOMxK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVLOO8ACgkQVbJhu7ck
PpTr6g//TS7pIPBtVlb7iJl01flTCHKO4QEtk6T06zj84PZK59lqW5VkC6vrw+bw
Ts6FvlfY3pb6xW4Oelm8GhlfAyyRga8azZ9dOr2Rgw5XOoXP0s/lSHQN2sGHiEol
NunSTwkNY4gVnmY7ZkngHUc/i69C3Xun7Ij37DO844ezFCL//mEZ+3VoAWs2CXGp
TCfgD9jZ/vzlDZV0oF/auBpCSqVcJG90l0JczZgYdLrI3SCK2chMBPCA2lzJtN00
mlSdKR7bBpFqlnNSKki+6hQgT6VW2PJywEG3J2GDlh5GJZ9tEbODCORsGgiHh4XA
0mlkYYPEMbo8j+X2ZHGfocq4+KTuLMZ4PZmEpDgJAN1H5m0PjuItRv1P0w0L8F+K
elYPjFaJvbEgumeA7Xyin/mpFklktwdi4fKWUBbDrXrqW9lo3HDpfb36dwTP35C6
pvoBYQkVhCD+4XXPaBhhiMWMmPbI0sOKzC9uHVZ7r2oND8Kwk2unxp9AbQxqqh6g
NPPOz/roGzOglwKE9paZTCyvcIJWt6weJwTqSyEevTDdSCdJHQjrwuaH7yjgecuc
Kncc4QAkYRXkqaFCrAXhArKyW8CmVSLlkTThoP93ccRJhjLVymXKzmTewV/m+oF1
cSfZbnMcVTPjqsQ/RvJyucMglZzo8d6/Dur0x2g/8TBOqYx2q0o=
=3Ip9
-----END PGP SIGNATURE-----

--mfHgp3h/xIfVOMxK--
