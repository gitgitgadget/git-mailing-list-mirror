Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gqqv6qB+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EQ99qc+D"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39CA170B
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 23:49:18 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 5A9A13200A8A;
	Fri,  1 Dec 2023 02:49:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 01 Dec 2023 02:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701416955; x=1701503355; bh=lN
	wqB1QiuhC2gxC99WLLe7bexRBaujd/ZdpsP11o1oU=; b=Gqqv6qB+WT2FVeUBA8
	Aqm0Ae3pg0oxl+mjSoa2cWR7DzkZBFrqcm64bVLvaojyvnRexIg6rPtd0HtmujKB
	pI1Yg7qM11dhKcmpTz5zd/NC7+pvbsJTchU23IOQL5Y4DfED8eYw64w/Qv4S+z85
	IFaXkIS5L5eh40OMJhv/sMTHLMKpQ5TAkCII3dtpZ4UPaW/kyVAkpkm50Uns/8NY
	B+1U/RxRnjrWDaCo5pXHyKDHbEAtSAdE6S77U3laUod5YXPZKguVx1tPa/23Muof
	L5ebW/+jaX1mzn99XG1Eoi6QTMRdw4DXbzcraxSxUg8tExpOFCityK0yd1PhnXwk
	jfNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701416955; x=1701503355; bh=lNwqB1QiuhC2g
	xC99WLLe7bexRBaujd/ZdpsP11o1oU=; b=EQ99qc+DbLbhxy/f0qmS5M96ug4f6
	MXvMKqumn2fLI087vF0RDvOwD4Bk4A0X46K1cjmznSgb5YgWQMZ46GBDuQtxzjQc
	xkKFvcvkHaf2WLRLu15W9JOYKwMTbExDrWmmEuIGLeVbhGq9MqzHAJuVncqNeNKy
	QxGxdtbuydXuThBjBNdLCn5WOGo7eYxd5k6rjzwjfEHGG8kOzpNXQfv7v8knvLeq
	n0NNDMUZhDMYnQ+qSaPb3/qVq9rBZqJ8x+OkuhchOuAkAE5C61v5Zgm6EbzILihD
	hJyHvkoEEDBRz2UHgb1WDHdIFtjPDPQ6RIUXDbZyDLivpY3ApDYK7Q41A==
X-ME-Sender: <xms:-49pZe3mWXmIleNARC7Mi5jMWjne-3mTmMXuRfX2EjMA42GTF4Kxsg>
    <xme:-49pZRFdMiFkvrNErTIfZ6mxoBsP-H8yY86NsCapgGwEwYmwR2NfB8-eo72SGgqWm
    GwLnlA9D2z0nvdEyg>
X-ME-Received: <xmr:-49pZW4-G-MJZ1tWAO5V_2jihCsB8__znLb2RvFntWaXgVB4E1KBVR7vtvBe4DCHJo12cHUsXnF5m1gkCwK1w-GRjzbI5PJhX84zuoy_uPvd5Ro>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeikedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:-49pZf3U-2KzCM1B7tfWGo4CwXOsMLMP2lZ5bjmgpUt9Z0Bj25Cqmg>
    <xmx:-49pZRHCFGJBHs_6G5XSS13NwdF8kVFrmNTpXDHMpEtH-xTBQ6V-JA>
    <xmx:-49pZY-DxI9xPh5ySVnQHVSLZfQzWDTltFgfco6VdiUkZrr1Y22Bmw>
    <xmx:-49pZWSgdeE-0dnUvz411Y9xpRMcbJtiBVeVLh4fi1hq4li2r1JFaQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 02:49:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 00b6d8bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 1 Dec 2023 07:47:56 +0000 (UTC)
Date: Fri, 1 Dec 2023 08:49:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Stan Hu <stanhu@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] completion: refactor and support reftables backend
Message-ID: <ZWmP9WmdaHp2Z6hh@tanuki>
References: <20231130202404.89791-1-stanhu@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Oi7wquCNRe9+Y3Aq"
Content-Disposition: inline
In-Reply-To: <20231130202404.89791-1-stanhu@gmail.com>


--Oi7wquCNRe9+Y3Aq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 12:24:02PM -0800, Stan Hu wrote:
> Hi,
>=20
> This patch series refactors and updates git-completion.bash to become
> compatible with the upcoming reftables backend.

Hi Stan!

Disclaimer up front: I've already reviewed these patches internally at
GitLab.

Regarding the format of this patch submission: in the Git project we
typically use "shallow" threads, where every mail is a reply to the head
of the series (in this case the cover letter). You can configure these
by setting "format.thread=3Dshallow" in your Git configuration.

That's an easy thing to miss though, as MyFirstContribution.txt doesn't
point this out at all. I wonder whether we want to amend it to say so?

Patrick

> Stan Hu (2):
>   completion: refactor existence checks for special refs
>   completion: stop checking for reference existence via `test -f`
>=20
>  contrib/completion/git-completion.bash | 43 +++++++++++++++++++++++---
>  1 file changed, 38 insertions(+), 5 deletions(-)
>=20
> --=20
> 2.42.0
>=20

--Oi7wquCNRe9+Y3Aq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVpj/UACgkQVbJhu7ck
PpQKThAArnOUqGVSnZVGz9yMEhwLwo8pKLeaZMT5ADM8rI6eyAPTIZ90wRHjrcvz
eRAlJP6tXx039hwgkmkhYL/9wAnBn3bfGwQ+lGkKZXop76jK0xdFy+bA5QqO7+U6
G6G1R6mnZTR/w6mdjMTxoNeZmPkS0UBo1vx2EO2HuiAuXS1LBvPE0UaJidHNcMFy
pBwJna0kfyS599WKxpr02bGmBDvTDFwS20HClIlb6lKQIHq2FBLxQVXTwOrgswJJ
StrOulvtKZl6ySPPXCPWoRLS5GBdxut6ECr9IrpYBm9J2pXfkep2OaFZPp5TbU61
RT6qNvpqqzQmKY5TutQFRiqtGFlujBumt/p8w2kSHW++v/OytDmPb0XkoeX9pRoB
wburTBSvUdrzSPw0lmGBU7ncZ3kqIUaUzrlGcw7xryh0TQonRgtPQYWr4awQjkRe
6AuFXvl7fS0NV2aexxawLmTA3NuEZ6aPPTrWCDpBNN4ba9H4kpRx/2O9VROHqJaz
K9NXZ30Fr4iLrdPoDiWsl8Jk7KRrnWb8c8XIChIE72p1x56A46MxrpjouCGSA8z6
91P80q+v1WtU9oeEM+5GhIiVA971QFXsCqoBzwOD5NxBvzNzbq5N5aK/NOgHqA9T
28K72Rzhr2hmoVgSp8vuIZpvBbV11+Mjt1sp72e1+ji7kNgm+xs=
=rG2y
-----END PGP SIGNATURE-----

--Oi7wquCNRe9+Y3Aq--
