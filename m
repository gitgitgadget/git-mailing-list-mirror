Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34573FE46
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rcd1gTWC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F69JQisd"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id DDB3C320127D;
	Mon,  8 Jan 2024 07:18:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 08 Jan 2024 07:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1704716311; x=1704802711; bh=umSW/jVVflTGHgoNqk7OykcQBX5QLmZE
	MOTBtlY4OdM=; b=rcd1gTWCHUvph1ue0k/t6Fd+kJpZH4mstmKZCOJbKjgA+O1l
	Hc4iVnpg9pHHCMTdl02SQuzKe3xk2oexk9AJ1uxi9Mhb+0hmHBVt+WN1ONKt0AIy
	En5+kiz0cIkHUuOGZ1I2wm5XSLbnSNqfCCj4IZeZwJ8mkUtjro0XW1pbjzMlMxD/
	G4EeBpAeHbYQ0yBhUlDOAME/DAFjDt1/Lrta5knRh+KU+WlI6MP3stF+KBo1pBfV
	FDEnNlj43YK9T00NYwNcDmL5XEdjz0KNmiu7xwbr7CT+pqjJi0Wo8OmXjRrN8m+y
	o7U7g6TYa2pdwQoOrGH1P9Bkj2psxUiYJV9G8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1704716311; x=1704802711; bh=umSW/jVVflTGHgoNqk7OykcQBX5QLmZEMOT
	BtlY4OdM=; b=F69JQisdPKmaWsgI2tJwrNKpW1orbD3FIH95mNavW6AF2hRB8v4
	8Dj81Uqhp88L2qvOvFAK/XDx0mZ0msgVdapsGPe0lpIeiqLQhqbewmtgn37hHPJl
	1lysCiGSsICp2k0tZ39undZVlnjJFf1xKcypfIagkSVicKxZmXq3BYTaUgVHJvJM
	XYcXAooxPzU7wWRUex04i3cdidgpchYSIao1y0GutT1CqZfUOhzPjogpO5qU3oCo
	NJZJNEzHVoeOwu+KOuDqybDgiIUNjycmmhDK7omOTH5IbWio1avQn+odTSMkCJiV
	fCg/hPaENmaFHFlbPCrSM++oDHl3NOXzYlA==
X-ME-Sender: <xms:F-ibZWlNv8yp93aNKRX_rDllFSwnn1NA6dbzqCf0PJ5m2aJ7ZB_UKQ>
    <xme:F-ibZd1nwr-8LqXwcDkoYlUhSlMRwkaNxtoe0yKVFpz-K2cd9eHfIB5IRWXS4eYka
    s0WN10zMyGVajWXhA>
X-ME-Received: <xmr:F-ibZUofM6xEOPTSw-qWvfVOsWloN2hQtqMvV_sRWU1FiEUD4MmvdUYF-UlkpNVbOsqBQO7KrlKWcrM8jBrHdxjruyJ7qzeOnJFoKae7SzuSkHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehjedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeeugfeutdeuieehteelveegudejkeejheelje
    ejhffhgffhvefgkeeukeejtdeijeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:F-ibZak6_Igrryf9ncCNis1rppWYRxz-eSdNHJ4-AAy_08O_8LqREA>
    <xmx:F-ibZU2UKM4ZmhaMgvea4u4st9JHng3U9YL2rGQ4xAxBB5BybwqEXg>
    <xmx:F-ibZRvvZjoWrMOBz7HgiB68ZTGjSTrWqVBpAXifIpsMIVkDiymRcQ>
    <xmx:F-ibZZ8bBZeKmTxTdNhxt_hD1j8dgOMdaXzPubQV3RCE9hgraecmKw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jan 2024 07:18:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 27d4c332 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jan 2024 12:15:52 +0000 (UTC)
Date: Mon, 8 Jan 2024 13:18:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH 0/4] reftable: optimize I/O patterns
Message-ID: <cover.1704714575.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gS0XG+PRSex4P5wg"
Content-Disposition: inline


--gS0XG+PRSex4P5wg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series optimizes some I/O patterns that the reftable library
uses:

  - Establish a stat(3P)-based caching mechanism to avoid re-reading
    "tables.list" all the time.

  - Convert the block source to use mmap(3P) instead of read(3P) to read
    data.

Combined these lead to a ~2.7x speedup when writing many refs.

Patrick

Patrick Steinhardt (4):
  reftable/stack: refactor stack reloading to have common exit path
  reftable/stack: refactor reloading to use file descriptor
  reftable/stack: use stat info to avoid re-reading stack list
  reftable/blocksource: use mmap to read tables

 reftable/blocksource.c |  48 +++++++++++++-----
 reftable/stack.c       | 111 ++++++++++++++++++++++++-----------------
 reftable/stack.h       |   1 +
 reftable/system.h      |   1 +
 4 files changed, 103 insertions(+), 58 deletions(-)

--=20
2.43.GIT


--gS0XG+PRSex4P5wg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWb6BIACgkQVbJhu7ck
PpSJTA//Q8VdIYCzK/TZfccbqZozH1wmilvFitTxXMuEhBcubGv9rvsRUGL6zbqR
jr3eQXq50W4KJymFLy0L1AWepJ1QUiUorvfO13W1ue62T4M7QCYw0vuGVDNFJGbJ
VsONSLhq+kpPKardrUCVC63TpcfGxVbMtIZybZheMKDV/KbFGuMyDdAXdjyh/gzN
dbuUBZ24g8U1s3spcw9uyju7WdSHVffekTcu/hYr+KOUEvCVLGrXU0qR/AF5J+9f
vXFH/s3U0MVlXYQEaTQ7bkIS/M4ugpzuoY9mpRtf+UsvHiX+X1sF7Yh+/0RHc3Gz
UgEHIseq+BoaRsa6j4jBaNU7SKNQvLKCk+rHn044VR/j/sfdYo81DpLhYNI8LZPh
TiON/o2SOdFW5WIaF6+i3Xpm/ENfzRz+6fNBwvNRiIG2fLKLCViacnwxw4xa27OY
qIKDgctntFUd+Rn4UgnPfdcPhgu6nteIgBmW28IXrbAhk+R66orFTvUVkSk6SCLq
juyQvDDdgRnTNKL/XC+E8AJWN6A+oXG80Vvxnf6sFpOkA3SxVv4tWz9wnZCG67Zu
9F1/fNCngwo7080ij32yECfsmyyC7ytrpVV1D083ED1KK5o9I+ywBA/xG3hFiZo+
zSkSuYw2JmJ+MLy4y6xXv6XnUG/KaLnTKyA6JyUxKJG8LgVZ2GY=
=CN8E
-----END PGP SIGNATURE-----

--gS0XG+PRSex4P5wg--
