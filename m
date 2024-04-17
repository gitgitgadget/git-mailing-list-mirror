Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8EF53387
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 06:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713334597; cv=none; b=bBe5XPTUW7tRWjHCmtuTdVUXMjMfCfmAPHE0RMwiQ+OTypTChktfdZ4DH/3SaTEVBGvv30tFm/8nvTiZC77mpE1tB1v863lYr66ERfIY/AGfKBJG27CEUw9R1jF3NHIhw0091VIvDPOjhpB/NEqi//OKEO+xS4hkfOucxJ06cDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713334597; c=relaxed/simple;
	bh=8qbRhm/YgHegivVhWvxm5q49nv5h9eAPrcoJ5eClUig=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cYmypBna47MX848DChHunoz63e8EQkL5I78nYaQoSkUO8D9HyixJY+2qkvX94sU66x+Co7BLPtNZq+CEaYXW4ModQfKdAqSE9ltup3W1XEKHU0kwVpdxpRJ5U68oeMGECdDWtUWJOiTy0FYvhJYHD85sdTTn3GTcWhwIHij0sI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S9DE5ifQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MNXpbvTL; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S9DE5ifQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MNXpbvTL"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 80EAC18000F4;
	Wed, 17 Apr 2024 02:16:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 17 Apr 2024 02:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1713334592; x=1713420992; bh=7htdZ8zlljkDQQ8Y4v+OjMhyzOwWbi6b
	Xoeb6CNxNVM=; b=S9DE5ifQZQMEfJg4Uauc0j5HlJEBMSUoW15wCvkGtlvBCCBD
	JEtUJWPUiXcD6Ro7fKUBufnlnnfx/Db9ta0IFsnQvVnJMWF+m7zLPzblcH9KFNQo
	QZqljurZi8PiLSPZJM5wSJOkLV/7dqZFki4GNh5DyOr4LNR6J4KLmpxpGl+yPHWZ
	Rvc2gF559VjxkMsJPZWtwqqaX2swBPHnA9wOKW5nlS8QglDxYsuAw/cKpCszySiA
	Hq+ujis3nUWp7zHmpAVRIcs9Wx5uORIA4M+pSvV6Lia3WYqSTjlWA7QMZZxI+1lB
	fPzOek/I3PiPKCyEn4LFGJ1SXYr9OXMLtt6AIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1713334592; x=1713420992; bh=7htdZ8zlljkDQQ8Y4v+OjMhyzOwWbi6bXoe
	b6CNxNVM=; b=MNXpbvTLK3f/dWYsM2sdXhCb3NnsaaQij7mo9My1Dio/BiI43NR
	5yZTfEYSqI7t6F1w9f4hSpd0RsnD4QeR0cgf06QLBrk3csExNIRbTxIqGjudEmzy
	OIN5pEU8qFY9UZYQfp7PyXQFdxqn5Ombh/Txju3PZR8/iy8gmOTJx+u8/JXhr/JV
	xemr/2Mz6cg+XI/Q0ccBD5ugurDV558PU41zre8SOHevqeku2TgUlsKYqcmAuLe9
	2cuSpaM0no/lGgmCNZpqzX8SWFtVkdWiNMiPggPvmPThFfxUw8Wb3R0E9gSnx2Gb
	PsMGL+U8N7yoaSjyctGSsHouWbXVRapEIhg==
X-ME-Sender: <xms:P2kfZurkYJ4U5jR8lTJBGUA3eH7Ahw5pfC9oZT5bEgCPESNSZLA9Tg>
    <xme:P2kfZsrPmbip9KgxRr3hDSV_GB4CXZx0k4fTvM2oHE8BZpsssnWI3sGUTwcYIDWpl
    00ahvnvMkeKdE0oYQ>
X-ME-Received: <xmr:P2kfZjNNxXvbCaeoKf7nYDZbQMYt28lP1HRvlvYaK8vXD6XoDMv4dz2HE3uO9B9ooWTCLph9Bkrsd1UsgcE4hTAY8U_KtGeS6XkIpAAyhoULjMBZlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejjedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkgggtugesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epuefguedtueeiheetleevgedujeekjeehleejjefhhffghfevgfekueekjedtieejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:P2kfZt4cRaBFWXT_icbwYhIvN5xZTklBEfIwZPybkaoijA_ydEVntA>
    <xmx:P2kfZt6CSLJOfbEVWC6JPL3AG8_xUBlTYtus3p3VZjMWu2yEbKTftQ>
    <xmx:P2kfZtjIAbiM5r--r3GmQ8yVNVKLXtLALQSUplU4nKQe8l6n-mospA>
    <xmx:P2kfZn4l8twzdLUa1Zqnt3XEeO1h9umtQ6C3w8_U0u9F2oEiSmKBEw>
    <xmx:QGkfZnlx2ejPmbj8cDoi-bfPdbTvZlwIaEhM8FoDFvEQI-7KCEioY7jW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Apr 2024 02:16:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 40764339 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Apr 2024 06:16:04 +0000 (UTC)
Date: Wed, 17 Apr 2024 08:16:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] builtin/receive-pack: convert to use git-maintenance(1)
Message-ID: <cover.1713334241.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SDHjxSQgzO1F5KP3"
Content-Disposition: inline


--SDHjxSQgzO1F5KP3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this small patch series adapts git-receive-pack(1) to spawn `git
maintenance run --auto` instead of `git gc --auto` like all the other
parts of our codebase do nowadays. This removes the last internal user
of `git gc --auto`.

Patrick

Patrick Steinhardt (2):
  run-command: introduce function to prepare auto-maintenance process
  builtin/receive-pack: convert to use git-maintenance(1)

 Documentation/config/receive.txt |  2 +-
 builtin/receive-pack.c           | 21 ++++++++++-----------
 run-command.c                    | 19 +++++++++++++------
 run-command.h                    |  7 +++++++
 4 files changed, 31 insertions(+), 18 deletions(-)

--=20
2.44.GIT


--SDHjxSQgzO1F5KP3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYfaTQACgkQVbJhu7ck
PpStbw//bTESHteHP4oAU2uhP6wFErIfQPqf3+w+aYPNUBvS/2m3kmEWsNffqTT5
WLX1UzeaCEJooMEvO3w4HABvPvQQVw2DmynUByWQqgyZgiXMy+OMR94V0rGjrIc1
qRziiObnOe7fzlsdYZvCjhWjxNJGnvZrrTQVy4ecnmhcKfNqFSA4A5V6cAkosZvY
SdV0mLr7NWa+komFhSs0zGEkqb8zL+LGsIF3j4QVUkAcAf3X4ym+vQAns8Sv99T2
h6c9sZpbbsZf5U85aZ7x1mZmdZo6hZ9JGhY429eHnqUC6d5aBMOFrLXs/IrD8ZTO
rWlfnf2Dag7HME9K+3/1eJTiZSyxvVBJmbLcc+mI3LmgwkM3cq79L1BQWEd/QS+4
tEpGx0foa+4jRdDE1dcXWOxUPRLL+TNXE3EJbJUSju1mZCmYb4LaiwhxCwmE3KXa
jiuGkZdqnTgmjk2QXlNFqglcw/ySW3rT+kGsYqO6dkRAcKCIDy3JqjhSmk0Fl4em
x4eH0p4Y4NR+YkIE7ORuCRuDAj4brmOD2Ae54uW8RlypdRD/vIpKwEUY6NgrhvW3
GDCy6/vi2O2N39JYVeO3yb1BlaQpChT93urzvrVlkCfQ2QKoZDAXAyTKkT28gBUJ
MZ2/jLRVflxoTNRDTFCvwz0CTlJr+fm4TvNrR4PXCpPAjqvEFJU=
=oCsh
-----END PGP SIGNATURE-----

--SDHjxSQgzO1F5KP3--
