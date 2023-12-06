Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oXcoq62n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3fTq4D4B"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F85AC
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 05:08:03 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 6A6AF5C0288;
	Wed,  6 Dec 2023 08:08:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 06 Dec 2023 08:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701868082; x=1701954482; bh=4k
	WYBn2X1PdrJN/8R2mxd8gIIdtBs1KSm4wrQof3iOk=; b=oXcoq62nUpQvqkpYKi
	FVIY5WcLoMj5Q3/WuwYW70QWfBz/NVIN8D2KG6EfzJfibQTqmEX1JLn3D3THAdjW
	/EqmlpYInlxBgwo9J/JD4lMG/h962/OIsj4RcAUy2pqJf6MJk5Br9fspg93CZp3E
	N2VZxGAY7W6Mb6E2xZmU3yNvSY05lY7d2jXSAvmyYrsqnh9W0VHHNEBpoqsDuH7r
	qyvHF3plVI34jZ9B90lkR6xJvi7/ZXKn00hvkJxn1iCYoR/ZPysIyIyaQ0bbDd11
	1cR5GMH8nSKf2ra+Sv8zhu11CFJp5oXi639TyOp3A6kTBjNPNqhtrb4MgNXTlhkm
	SmFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701868082; x=1701954482; bh=4kWYBn2X1PdrJ
	N/8R2mxd8gIIdtBs1KSm4wrQof3iOk=; b=3fTq4D4BLnMydWJasOC6AB2/5+LFo
	OiDFO+P5EH2lFiRnQ8F6qfEwsHFkHv15tkwZ3+cCqLLD7DpWXa7EqmpNN57E0C3l
	a+5DN9o2lEsH7LX56MWX/Phlry3VaQ2tC436c/Gl79OsnOrCRQeJUASYGQEpO17d
	dwot7mk7ompndONSKVf929sLcMre1wXxPdCprKrMl1I9Xw6erc1njgE8VawH3jLY
	NpN+0QI+wmQ2KbM2kje+N8eC6Mmfw4S+phVTmHFxmAhTN9Fxmmzc5iQQbj/9ILpH
	NO49z6EYbxM65ZGO08ZsluwfHgW9joPooV4eG+VSWqsqVUKSq2X2xNNNg==
X-ME-Sender: <xms:MnJwZQPE4-A2PQzAJaLgn_RFoJwLtPkeLW0Usw24F0iwGbHK1wdegA>
    <xme:MnJwZW9Dz_d-1Mqhn4hhKiyTp0LqIi0pO-lMf-16vQt879MrA5gsT_dBudrF9K5r3
    F1YzzOjzEGL_09IHw>
X-ME-Received: <xmr:MnJwZXTIiR1ECLO9gPdccjr6VTakLa_4EH_v7pp9l97F0Qz1runDTxLslO2f8qr5hPBPYOpoEFsl5kjzT1FS_Vflt7zP9BaDpsUUOPWtYsG0SHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudektddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddunecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeefvdelfeeuteegiedtkeehleffkeekgf
    ffudfhuddvfefftdehkeeihfekjeekheenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:MnJwZYv9lQUXPQT_1N0ukSF8LQHqvuZUBRCoRr4eLeUw-e07d1ADtA>
    <xmx:MnJwZYeaD6WcPX5MGpNlM7cDFtdionvl8A9AHTS-nKFPZfnUoldUEQ>
    <xmx:MnJwZc2x1FNGjrG-uYIEgaq7dQsJ-NHv9TgaJjQTyjst7d8zCiEjww>
    <xmx:MnJwZQkAVI8LNQjwtqBUOqCKh8qrtvQusw7xYFFyf1xmtsz_sFFp5g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Dec 2023 08:08:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6934543d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Dec 2023 13:06:33 +0000 (UTC)
Date: Wed, 6 Dec 2023 14:07:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/7] standardize incompatibility messages
Message-ID: <ZXByLkAtp_J0nGa0@tanuki>
References: <20231206115215.94467-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4sEXzf4E0+H8K8uo"
Content-Disposition: inline
In-Reply-To: <20231206115215.94467-1-l.s.r@web.de>


--4sEXzf4E0+H8K8uo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 12:51:54PM +0100, Ren=E9 Scharfe wrote:
> More of what a699367bb8 (i18n: factorize more 'incompatible options'
> messages, 2022-01-31) did: Simplify checks for multiple mutually
> exclusive options, reduce the number of strings to translate, improve UI
> consistency a bit.

Thanks for working on this! The patch series looks mostly good to me,
I've only got two questions.

Patrick

>   push: use die_for_incompatible_opt4() for --delete/--tags/--all/--mirror
>   repack: use die_for_incompatible_opt3() for -A/-k/--cruft
>   revision: use die_for_incompatible_opt3() for --graph/--reverse/--walk-=
reflogs
>   revision, rev-parse: factorize incompatibility messages about --exclude=
-hidden
>   clean: factorize incompatibility message
>   worktree: standardize incompatibility messages
>   worktree: simplify incompatibility message for --orphan and commit-ish
>=20
>  builtin/clean.c                    |  2 +-
>  builtin/push.c                     | 12 ++++--------
>  builtin/repack.c                   | 14 ++++----------
>  builtin/rev-parse.c                |  9 ++++++---
>  builtin/worktree.c                 | 21 +++++++++++----------
>  revision.c                         | 27 +++++++++++++++------------
>  t/t2400-worktree-add.sh            |  2 +-
>  t/t6018-rev-list-glob.sh           |  6 ++----
>  t/t6021-rev-list-exclude-hidden.sh |  4 ++--
>  9 files changed, 46 insertions(+), 51 deletions(-)
>=20
> --
> 2.43.0
>=20
>=20

--4sEXzf4E0+H8K8uo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVwci0ACgkQVbJhu7ck
PpTCvA//YdICCXgz0blnja+7vnAVCIN/TuzcNQG8/YT70f+91DwiH3yLVAIuBV8V
VdfQWbV6HJeLFx15oBQLJT3Um/QS2Ds5nL4Ifo8BHsT6yBjvc0sjoQi1fhjGU/2p
d0leumHvqD1UMrO2hjsX7A7AcALedviGawnC4cUv7aNWmSbAq2lTxwmD1/KUfdlK
Tu8dNV7NKW2cIhKtfj2+AYKnPo3qOyS+ZmHJA43OHIDt6tuJ7QCbk9ciNmOzgD8R
8ALUNyt0ekLqHxVPdHwqlZWrxBCCkkJuAGFwzmtO1RoBQEZ8ha576HxmECVTsQZN
7Zlkv9S+SYKbiwb+Ur3arkz36qljArPbZTBNlu6NkS1y/Beco+Bge1DlIU2YmC6G
sHxMhUYZmQVBhEWD6v4zzQlBM5FcJXf4Fb+LvmDzmhONyW57P/p9CFqYRkl+jpif
Mn8MpofMlLgMAzVGwkGHwykAeesDKjIgq731cPX4tluGllPoOJr4d8Pqei/v9uLl
YJDvggEUdyZvPzOOdur36aZc9H93P6M5BQXwShS5M2f6cCZIB3BpziLQXGx6Y1G6
WVYj2e2c7OO5A+CLFkNytfNd8w6L8yAU4jMUeMMSYo8pFLfvqO7Q7EZBOobXQhRp
IR8yu8RlpEX/XOnK2xF3tx9FQri4ChvDQFShWq8XRz+FavMl2A4=
=06au
-----END PGP SIGNATURE-----

--4sEXzf4E0+H8K8uo--
