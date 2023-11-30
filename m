Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WGJNb4J+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ErDWb/wI"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EBB1A6
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 23:06:52 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 02B385C0159;
	Thu, 30 Nov 2023 02:06:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 30 Nov 2023 02:06:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701328008; x=1701414408; bh=T+
	AVLV8/HOJ3VNh7r6H4EFdaUq8no9X61E9ncgKEozk=; b=WGJNb4J+tQPJSqx187
	rXbcr9/P2nnlXH16T2x1EU0BSrAogKo6PqLR38mgRVIAYu/Xyq8UtZ8WCtkGYYfg
	UCAnVgrDMq6tJSDJ0n03uSHqDtTDdCsrpm79N4IJ6e/9R7IEx10Nd5Win2FrmtCp
	qYc8JtglsV36NnMd77KWY9m0ANvvzZl2zAgje/emEq7Y1SXNMQI46tAGDnK4+Nlt
	G8gXdsdn4EaSVvGywqDHwgC7p9R0n0vz0vPafudve1T+xjLWoSlK2FlGfOkAjkHh
	CeOZkuYnKDc5qx2PLH72HOAkzN6JHkBW0pUGL1xq3bc9sC6JEPQcLWoKF/ZgBkWZ
	R8eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701328008; x=1701414408; bh=T+AVLV8/HOJ3V
	Nh7r6H4EFdaUq8no9X61E9ncgKEozk=; b=ErDWb/wIQKoX0Q/w3G0vzZZR9ZcqG
	sUOLJRKF12GNkJ1uvOSku4CaaeND/mXLrxuVJzdOF45oBLKORTZyTupXLzQJYn3n
	r7lFZG/sRaDwJjS23Uc3uaGWw4Ea9w3OUuLYXEA+g9DdbHhLp0RyoFf02Tg872DY
	dqu02zZ1U+6k7EK+vnholuHMsmAfDAjibXvIQ/s5lzwzNsHXaJAwAUcpRe3Wlrsp
	6iDNJv2nEevZCN0iledL/tRqD2TtRlhCwTd4Iu1GRELGwCLSq3gqPJbaEeZieeKG
	CWni4F7ggBDL3sWToPdlPC29r+eMZtRF0Wu39ntLkRdCaD3rFYDBEHAbw==
X-ME-Sender: <xms:iDRoZVYhePbptm6zfFVf27uyuQFj3XO04WX1nzEIDflVWBnPwVtVlQ>
    <xme:iDRoZcaRV3Y6sr6U8NHSSOVMR76_j5bm0ICXAdX6AsGbQaDN19mMpRVc5vWL_74kC
    Jrp3ijBIXqLAqLwpw>
X-ME-Received: <xmr:iDRoZX9NKR7HuDn7_yzlpF-WJ6uTbu--09L8Gi0cN_APDeo5J38Xg1-X5Av43VO-4wTFy8mr87sDuVuTsRaxNUXupHlmC0M_FxzPb8TLu2fEYUqY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiiedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:iDRoZTqFLctqDnMIDogdXfJ1GO5rPPHrcG-rNgquvBQyT3PGxspW0Q>
    <xmx:iDRoZQqaz8G1pooba0h0iJ_UjG6QtCiEa6u2BJPH7Hj91Qz5KJ3Oiw>
    <xmx:iDRoZZQu6DdseN64dtcJncwAa9C-xAjoqEncdO5UjKxbOEH080wK4g>
    <xmx:iDRoZXT7HMd63RFabS6QuzRItmISY-pb881_vLzGy5HczsK_Y9briw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Nov 2023 02:06:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 520308fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Nov 2023 07:05:33 +0000 (UTC)
Date: Thu, 30 Nov 2023 08:06:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/10] t: more compatibility fixes with reftables
Message-ID: <ZWg0hJNsIR---SVI@tanuki>
References: <cover.1701242407.git.ps@pks.im>
 <ZWfJp80vzVhbdH89@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TqQsdnKqRlYZwU4s"
Content-Disposition: inline
In-Reply-To: <ZWfJp80vzVhbdH89@nand.local>


--TqQsdnKqRlYZwU4s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 06:30:47PM -0500, Taylor Blau wrote:
> On Wed, Nov 29, 2023 at 08:24:36AM +0100, Patrick Steinhardt wrote:
> > Hi,
> >
> > this is the second patch series that refactors tests to become
> > compatible with the upcoming reftables backend. It's in the same spirit
> > as the first round of patches [1], where most of the refactorings are to
> > use plumbing tools to access refs or the reflog instead of modifying
> > on-disk data structures directly.
>=20
> All looks good to me. Thanks for a pleasant read :-).
>=20
> Thanks,
> Taylor

If you don't mind, I'll refrain from sending a v2 only to start piping
output into git-update-ref(1) directly. I'll incorporate that feedback
though if there is a need for v2 due to other reasons.

Thanks for your review!

Patrick

--TqQsdnKqRlYZwU4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVoNH4ACgkQVbJhu7ck
PpTDUA//ZTws4LfLSYsUnZxYn0ZHCwmWMKJYO4D/H6E27uhHlZGJ9bfM69yO/G7w
oDyoOLgz6e5rzUofBSVDPIhmfPQj3HYRgohSRHfOIkDO+9xml3tg9zp/pyHnnUbs
lbgkHFkKSDR9+jLII1cyCNLWeUcQW85fAnA1idqQO65S9RyCquAAPuyYnvHjX2+M
oBEnZzHuM+rSWoTYtjLcg2FHVBVn5hENzHxRC9FvxiOESyibq59Z6vKLYzeh87UB
1Ga9ZvC4KHc/0MOdFtyqH5s0YjOk0B1X7eiEg3I4ZIy16TKjKyseXDnq2yX0lq9Q
uyILaiJl/3n9z9YMNDgrnzZEC3u5D+1NI3qsk+9mJGcZIC91zyKy85AhvdBTY6qR
AGXjZjoebz6PU+vNw1CNmHX1zdNnKSEhYUWi6FN5HHByXPm84K8KuHGokxfpctC3
QI/ml5YPIiZwWuVg+w0OVBazMaEoe2wcnLkjduSPfig4GEgLnsmxveJ1K6MFnebZ
N+lKnSCPr6/0GhMBMpL+R+DyeXunPJ9MzE2SsPnKWmhVE8di6gdbcDeYtnV4SoHr
+Zqa+y1aU032S++ap9bgthipY6cj48txFACx5rCXLDcrthWgLBlmeoTNQm0eGRU0
haNp86tYUz+1fYpuQExfQfaMUBQuq2KEKJ0ofk815mQS3FL6CM4=
=+uSy
-----END PGP SIGNATURE-----

--TqQsdnKqRlYZwU4s--
