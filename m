Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928D7768FC
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 22:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731882213; cv=none; b=Knx/B0U1PXrlmXr95hBsgVXxHW0dqVvGPyi2iyoAWFvKsIBz4ZEkhdL7z6SFbo4yutF4KQ5OJIBvq5So0+mVhnP0x7dNBZ3wwTgSaExUS845wK+eKB2jerQmcGAdQA3R1WhzbZqk24DOE39eo8v6ooujaFIMknxdyw8n/nCSvPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731882213; c=relaxed/simple;
	bh=E1yKxvs7sxoNv5LyV8/yv6mAky67kRVvvmeZSvj+SI4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KxS1sNCzBz0JOBrY9xTvvWEraZXWmG+NK87vnARyjHAsabA0JbcLJ3rN+j1IuZYE0uZa6rZKZtsTIXGVoKb1iZs5rYKbstkDtaFrTbcEtMMnVZoOPQbZsGKeF2gJkEJcrsT1qWgoAmiXkQmVcirdsq04LsGEU70iXjS56MNdO9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bfmwZLPo; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bfmwZLPo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1731882196; x=1732141396;
	bh=E1yKxvs7sxoNv5LyV8/yv6mAky67kRVvvmeZSvj+SI4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=bfmwZLPoM488e2bldgcmLYEnQTblG4JtKMiOORAjIK6FRBQcjhzEqtdwJahvvGYyk
	 Kb1tPAaBEbywIMFq6YbxUUfpP2+65yUbU7QibS+TvscYdoVEerK9jdASRgpdWLblrj
	 M5EfBimagxijlomPG28h5VlLp3fOugXtsoOMH0Onuk1TlH3H7Oph+Snx9y+SzESziA
	 7wxBvFx6xOCvwnIBlbaMjtPeFr3PKNmqI7W1R/2SOUxBEPoXYm72Gteha/M1mTxE2w
	 beuICIob0nQoyiyLUXA8SXH5Mv6kMrNfdPOcY6RAw/yuTLu/uVMGGb/f3ny+Ttpd7X
	 CxyZ/XVF22Msg==
Date: Sun, 17 Nov 2024 22:23:12 +0000
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
From: A bughunter <A_bughunter@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What is the diff between a --soft and a blank reset
Message-ID: <ueX70oc22vpdQxOCTXLLLRrsXFzeV5fHRPJ3upJiRrB3qcYY6BeKpUkzlod0cVvh1bMZUbhtyW6nthHVBsVBR2J_6jlWjQtIoGq_bGwUTwc=@proton.me>
In-Reply-To: <cb5090a3-59a8-44eb-ba68-3a8fac58c45e@app.fastmail.com>
References: <myxdTw4K7jcrlKX-HC0edNKB3mgkjGJPAejkxWTcab03uT9uROZlO28zjhmnogOvGCJkag5q_Zvbok0VUyVjlkw5Goz3Gwe3l636lCYnGic=@proton.me> <CAPx1GvfT1iNnpJ0Jv0vhdHrwD-pDOK81MnUW2-Fk_zcJkW9PUQ@mail.gmail.com> <82f3cj_ASv_HNkdAe-1doxp6Vii0saBTB2wYbcwCEC3vDJpiwXvN6a6Agw7qNhKsGpBD8EbDC2u4VipTDJNr19nYcVV4BqV4GgNG9ysr5y4=@proton.me> <cb5090a3-59a8-44eb-ba68-3a8fac58c45e@app.fastmail.com>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: 3b3156874065450c2d4ee8213633218e6cc4de9f
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_CWUUWRpGWqrAq0bPlf45xBngepiNF8p3fj8YIPhcY"

--b1=_CWUUWRpGWqrAq0bPlf45xBngepiNF8p3fj8YIPhcY
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hapse not... Kristoffer, Hapse not.=20
> Do you happen to use a translation program to write these emails?
>=20
> --
> Kristoffer Haugsbakk
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmc6bM0JkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAAD0kAQCv7OoWzB10BoXhMGu/mnwI4uq6FUALZX5AHC1eazm/XgD+IO8T
sHHN0Og2R5fHrryn7g1tjyRgRU8BVXMlja2kwgU=3D
=3D00gR
-----END PGP SIGNATURE-----

--b1=_CWUUWRpGWqrAq0bPlf45xBngepiNF8p3fj8YIPhcY
Content-Type: application/pgp-keys; name="publickey - A_bughunter@proton.me - 0x66540805.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWnUwWDF4WUpLd1lCQkFI
YVJ3OEJBUWRBSDBJNDdqRHNQWjZndmIrWVVHQm5BeDdKeWYxNEFWT0gKeGE4eTArZG1ONWJOTFVG
ZlluVm5hSFZ1ZEdWeVFIQnliM1J2Ymk1dFpTQThRVjlpZFdkb2RXNTBaWEpBCmNISnZkRzl1TG0x
bFBzS01CQkFXQ2dBK0JZSm03UmZYQkFzSkJ3Z0prS2tXWlRsUXJ2S1pBeFVJQ2dRVwpBQUlCQWhr
QkFwc0RBaDRCRmlFRVpsUUlCY0F5Y1oybE85ejJxUlpsT1ZDdThwa0FBRDlGQVA5L2RkVDYKNTZH
a2E5TnRNdm1kb1k1a3ROZ3FiWTVYYmQ5Zng2a1BFNS80dFFEL1hpaWFsS1FIam13QXRiY1NlMVEr
CjNjeFlMeE5oalU3bXluUXNwdjlkeEFET09BUm03UmZYRWdvckJnRUVBWmRWQVFVQkFRZEFuZnAv
ejJGdwpSa3B2VWdmN21xWUk5UktuVFZhZHdHZmdhUUxobXdnM0x4TURBUWdId25nRUdCWUtBQ29G
Z21idEY5Y0oKa0trV1pUbFFydktaQXBzTUZpRUVabFFJQmNBeWNaMmxPOXoycVJabE9WQ3U4cGtB
QUppOEFRQytmbk9tCjRWajlRbUg0SDBHVnQ3UnVPUUsrd09RMVBSdnB5bVNqZXlCSk93RDlHWXV2
eE9BVks4aUF1cEorcHB3TQpyMzZWdWtJZTFwWHVIbzlSaGp2ZUF3MD0KPUZRRncKLS0tLS1FTkQg
UEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=

--b1=_CWUUWRpGWqrAq0bPlf45xBngepiNF8p3fj8YIPhcY
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmc6bM0JkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAADUvAQDlxBny
xBwDlzzYaLl3NFo4lXHB37yMdwrFrWTBebhN+gEAm+SAmZfHl+CPf2SbWPW1ORlvvG99JI43AKiA
y0U0TQM=

--b1=_CWUUWRpGWqrAq0bPlf45xBngepiNF8p3fj8YIPhcY--

