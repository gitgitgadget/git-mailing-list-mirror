Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n82uo+gJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hKv0vf2a"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42660C3
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 01:08:31 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 73B433202794;
	Mon, 11 Dec 2023 04:08:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 11 Dec 2023 04:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702285709; x=1702372109; bh=Eh
	OykKP2yWsoWFemO4cGCYzaBBpnGrBaTp8hnj2mMTQ=; b=n82uo+gJnh7a9Jv9rd
	uqOErRHuvD2GZamPGKftedaftkx4cu9nffp8a172Xo1VELY4xxCmw/VZs9/u8ZVL
	fudM2n2WYSmApVySQ/AWhCmx5skAdUG6noiIhhiJP9CBdZ+Pa7CQI2DEgH9XVVR2
	mUHzrLMZfX9Xb2FD7Fk11kH74XPsH4pNxH9n6ama0JetJZ4HLUXCajsbNHJ4+SCs
	3RM83do0/0s2v5JcOhmNX8jiXCjvX4Bej5MezzW3UYDnxoVzNj1ytlD4PeK4uAXH
	S6my8FgVdfR82T8rItDh0JgvJFXputuMkapW2fQ3eSSs2ot2HTaXYa+dDriY/w0c
	CvtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702285709; x=1702372109; bh=EhOykKP2yWsoW
	FemO4cGCYzaBBpnGrBaTp8hnj2mMTQ=; b=hKv0vf2aTZ59Mzel9oJOXGmvwqZUF
	+3jNYMIIW8vvqMli9ZWMhNKyRTs6f9/vm6ugqkqwM7dkqQfPcWh//F6WQ2Sja42U
	gZZieK7FV3AhkEpbcC1fjojxF7N6/ONk5LrRU03uvBM5TPyGuuG6uTEZCVFsUoCl
	6Jt3XBRVKtn7UMD0iyZJQ1Iv1YI2H9dZB3FGQQpBiyZmTaL1yAHhvkADsinZSgsp
	Rueoxo7maInH11UsNkUYCl/bXFKjiTY/Z7L0EqRY0d95YtffW6JtvPObNsn+rfzD
	aLeIOyatk0hbpoVD0k+1YE+uygz2g7vVBFIQgDy8PLkHSN9iV0NLeAIlA==
X-ME-Sender: <xms:jdF2ZR0nGJlTlCBmHBrc6xigMsNnBSOpIOmtdgarRZsOE8ImugUakw>
    <xme:jdF2ZYHRHl-5WIOONyaERagmpf4H0OGqK0qQxORHPp8w40H1uRf8woQBdOYX150S0
    iVfecf1WaW-6s5Ttw>
X-ME-Received: <xmr:jdF2ZR5ypSjCGuW6Rk-g7CG6HKBCmOqLC40G9rV9Fk89TSHmow3yexrCRYD9EhPZaPbGc-INPmb4orRyF3Zhqw1uVZGlf8QsfyjKwhOwIDTRvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeluddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:jdF2Ze32g2-H3Uwx1P7N6v_4hE-UZ5mMBdkuFY5fpUR6Xy20a9hYGQ>
    <xmx:jdF2ZUHVyG8_RMnz72SOylnxUKpBIKxI-vXwIZxkdsDKWQM3ibk3SA>
    <xmx:jdF2Zf_O7X4R6BjS2b7DtM3MgPJLX1X09B9SetBjSiaME5OwfuuzpA>
    <xmx:jdF2ZZTphhO17HQ8WFhzyTyWNKbkHDudDWtqVGrazR9JoS5sqQ13hw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 04:08:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bde00bc5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Dec 2023 09:06:51 +0000 (UTC)
Date: Mon, 11 Dec 2023 10:08:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 02/11] reftable: handle interrupted reads
Message-ID: <ZXbRir8Nnc3mMIoF@tanuki>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702047081.git.ps@pks.im>
 <b404fdf066e802328bcbcefeb9da7c996738f840.1702047081.git.ps@pks.im>
 <ZXOK2o0jTgLmxPWZ@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="35OcFhbq6CarUUna"
Content-Disposition: inline
In-Reply-To: <ZXOK2o0jTgLmxPWZ@nand.local>


--35OcFhbq6CarUUna
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 04:30:02PM -0500, Taylor Blau wrote:
> On Fri, Dec 08, 2023 at 03:53:02PM +0100, Patrick Steinhardt wrote:
> > There are calls to pread(3P) and read(3P) where we don't properly handle
> > interrupts. Convert them to use `pread_in_full()` and `read_in_full()`,
>=20
> Just checking... do you mean "interrupt" in the kernel sense? Or are you
> referring to the possibility of short reads/writes (in later patches)?

Both. The callsites I'm converting are explicitly checking that they get
the exact number of requested bytes. That means that we'll have to loop
both around EINTR/EAGAIN, but also around short reads.

Patrick

--35OcFhbq6CarUUna
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV20YkACgkQVbJhu7ck
PpRTeA//T+3ztJ6kqnJOY72+baGyYbLn15nSkXQLjugkHO6KDa3TBn8JGldRBjaa
VU1sbFPvN+qL8BYnQil1fk12faRq5A2N4X1J+ERCCmNcfhKzxAV674ThY+tCsoFV
6he2D09yfBxluGHbXLuPXwty6weoxJQjj5U72TTMP17jGntlvxDDhtye9PuavUQ1
SsOL/iWRZvzkfQGKJchT4pmvW1yDPjNHvweVGSB/fSLlxDMmtavv8ooJxZMs/YOI
NR0nixSH7b0ZY+2s4XQBcdG7J4ztlF1bt/+WTRntxEzc7eLL8qj5jMiQvGBpIQ7o
RNijiEd+XUmtwK3dHZFMJQbiy9FeStjng4rGJ1nB0oIWdbbtZlejP+vPdFF6Tftz
o48nybWBn3MQC/bxTnmrn0AXpjHRXD3vW8EI6xBnJ84Wk6fyR3GfbboWL0WtNLnF
x+M44Qg8UbVYbavZB5DzMLBVj2z5twHsBI998tOTuRkHJf25etV9zlKu+lJcxm41
PnolP/f+Z2/e2E5Y3hptze9E819JsxNAtrUC1ZxmQz86Yskvj6IkUeW/UJldanY2
DSXm1M5fkG1MtwsAJdjGHnqQTegdGBeZMOkEVw5OpjUfcEooLcL9htAOPhB0U2xd
lsI77U+pWOvTxXKmT7ll/7ChJH3N+4yUth4+UEVN3Svjaixr9xA=
=Ad+y
-----END PGP SIGNATURE-----

--35OcFhbq6CarUUna--
