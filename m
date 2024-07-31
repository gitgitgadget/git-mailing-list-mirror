Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D494E8801
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722421370; cv=none; b=arrNGPMXZ457FgOIgIS1FnHpWUUi5FyBHGfc6DcDdRRXP0zPwdPGkSE4xVp4GEiBcE0oPsDLfWG7An2xwMe5HYjION/lScVXRkHkID73CAD4jUeUGZLu9ViruXhgBxfqSMeLU+RHZT53xN1Ks+PXJzdT8bvWW8WUoaxgiaR79uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722421370; c=relaxed/simple;
	bh=uBL8SZhDDgovfn2oZG7nOTPnbeg29DeAuZgdpHWu/uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P3e5/fUjP85VOSwszB6hR+jVnkUlEe51vO/vb2PST8R8ylAy/lqdQXw195/zGUdGuQHlE7YcVyNGqT7PGtEOUknnymze1QHzozpJLkfcgady2HBQysvieAgEiMRF9ZhSSOkYGPvt/imIkY0FnXe/kw0+EK59pa+knxXKjJ0kfdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=octoEKaU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hKMDe6Z9; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="octoEKaU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hKMDe6Z9"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id ED50313820E3;
	Wed, 31 Jul 2024 06:22:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 31 Jul 2024 06:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1722421367; x=1722507767; bh=Lyua0xlf2sudqRBZ37Gl96G2AD9G71Ey
	/K0CmYuz6nk=; b=octoEKaUv0eRwhTA9sEXa6q+I2YeBws8QWLmaHK5px3jfifo
	EBpGMjpaeQvsM90MqBrtBvwXg2Yopb1VshEVFmaNfA236y3Ag1Taqbt37F37HK5F
	KCWrRJxVt7JCVVoVO96iqngbsAZidgEWx2CrxX80H/Jr5Tr4ZC6rpyBiYKgxegWD
	8lsP1G202OMdeGIOCQztwS2ZFZYNj238wj8I5vF7BYyDMJuNxvzn30Nq23SOtaWb
	FCsb2RjEzrTc/7d7+r7tyJNhMPk+iXj1IwYgNsbNtuoVh/mRfXm0Ydj5EL6gxI7h
	EILt93TGfGXOETMxF4sbc+gHTttm5CtTdicROA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1722421367; x=1722507767; bh=Lyua0xlf2sudqRBZ37Gl96G2AD9G71Ey/K0
	CmYuz6nk=; b=hKMDe6Z9JqcIljVZZd3GnKgPojrAMxH6c4vCDDggW21im06UeVU
	g6QDzIGQkkptTf9pvU8RnKQ64+5YjT2oeB27Axm2HbjWVnijTxco3AnDV+l3hV6w
	YxTaMHc5A0hR4dTGYPeh7TVxxZwbq85ivvQt+EtXD4Gt/emJ3S5lMNum3iffx3il
	UUQDBmsp648N8eoKHDSAoMGNgCXK0ZloUqVfSg9zwT4tIad3P7ULFasecoKEVywI
	pclMxEZ/puTFjxv+dXOFfPYXI+XxzH4+7lcjcpxU9uoKZhkA5d2n1iKbH4lTCNJr
	z5fXuvxqfzJtv/hDKrYkllCo1peTYtZaLJQ==
X-ME-Sender: <xms:dxCqZmcLWH4cMaVTg2EWVOI6VjCCupgMAkvLnaZjL-tKaCppSaHNVg>
    <xme:dxCqZgOBpQKqT77gOEQl4YzIjon3nbFRFmEB_C6e87JJwDfdhwEoH9x5N4AKmWNbG
    DJ5T0oVXyur0tVXMg>
X-ME-Received: <xmr:dxCqZnj4hFJNPrT0_fCTYJYZVkPbvBpY-lSOZUduj8BmHj-9qzR6D1udn7Son4OVZF3FCELDJJ_6zbdRu6KQVJsjjpBMSQ7QtMRN40Kc4jTo2Ik->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfggtggusehgtderredttdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    efieffheeglefhtdethfeikeefkedvffevgfefteevuddtgeejieetjeevjeetvdenucff
    ohhmrghinhepmhgvvghtuhhprdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:dxCqZj8HXf2rqRsyu8aruGa524exz6vcYea_VLEB00tGCKIZSalDCg>
    <xmx:dxCqZit0dgG3U5dC2lDZzU_zoyvz1MPadkuA4MjByUr-1WXZgJaOCA>
    <xmx:dxCqZqG0WO738vG-W0KytThKzZTB4NmQnLG2lFWu7jmZpSylbwtwbg>
    <xmx:dxCqZhMgF8NnFzJwwQ4v5fsgCC8QIWL7-v7WADOCFDbLXOizxh2SGQ>
    <xmx:dxCqZkUEEWzrEFmSWOa3KYDctE4Dkg_7mGPCifapUJqTkN_WYnjYwKtR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jul 2024 06:22:46 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0edf36cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 31 Jul 2024 10:21:15 +0000 (UTC)
Date: Wed, 31 Jul 2024 12:22:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Sebastian Schuberth <sschuberth@gmail.com>, kiril@videlov.com,
	sebastian.thiel@icloud.com,
	Megan Ponce de Leon <megan@gitbutler.com>
Subject: [ANNOUNCE] Berlin Git Meetup on August 14th, 6pm CEST
Message-ID: <ZqoQcuKz_ynYaBNM@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KtOC8FogXaqFcNGS"
Content-Disposition: inline


--KtOC8FogXaqFcNGS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

at THE MERGE, a couple of developers from the Git ecosystem discussed
the possibility of reviving the Git user group in Berlin. The intent of
this user group is to sit together, hack and/or discuss all things Git
and its ecosystem without too much of a tight structure.

I'm happy to announce that we're finally going to host the first session
on August 14th together with GitButler. If you are interested, please
sign up via the Meetup link below [1].

    When?
        August 14th, 6pm CEST

    Where?
        GitButler office
        Sch=C3=B6nhauser Alle 43a/44
        10435 Berlin

    Who?
        People who work on Git or build tooling around the Git
        ecosystem.

There will likely be some lightning talks by Scott Chacon, Sebastian
Thiel and myself. Pizza and drinks will be provided for.

[1]: https://www.meetup.com/berlin-git-meetup/events/302548084

Patrick

--KtOC8FogXaqFcNGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaqEHEACgkQVbJhu7ck
PpTGXQ/+K65j8P3yxEOoYz3MMbDBe8uYN171+9Bl2xEXiOTDYuIvJ40Y11TLyZQM
gInkJQS53TZKRgtkIwoVoyrJ9BtKQfxC6xbvsDEkJO6MqdL9tfkbSOH3L1gR/6RG
WEEan+aKI/3uxhHNNYkXvHeGb0ZGEBht6Dfzm+t6Bo6mSMdD2hbHKDDDE5VnxTPz
MEhHzE+d9ArJMXYNImoCyvf2n2xDCg/Ea06tkNYx4a1lLcO7bR4j3EFXJiFDAaQO
4avFB3TVwU7YEeb0Exsj63xXZqpl+psGRkeJvPDlijpw8s0vMv9Op8Eopcp6fEnW
pOxRxWLhLT/HKFYX9rjZz5cBYr9RaBxlfjWjfSIevaPgvJOE5bKtT3/RyL8UwVxb
FFei9hzgT0T2hXeZwz8yHYMmZbdw20Kf4Y3XuF2dSC3gSi9dcCgiOzTiG26Ewlzg
61rAFcTBDOLNXytpp7iQMnzy0wBsT91dA71+WQviYkkVEk+EaENepy5P3M8cqYbD
YoAORMvWrjMcVeP7WjtlNPKBm9W5c4za/1TD+R/Faa42TDLyDMUqBarW7pLDZlDi
HCOMYKPXtd/Wgfyt839YuXYTtKfGj9qf2JVg31D1kM5cr89hdgCjjy27h52SWZqL
8tOFNt0+sjmhXqWwjgLPFv4e7LGNS+M4/b3TlPzceBa6C0iaYH4=
=uri2
-----END PGP SIGNATURE-----

--KtOC8FogXaqFcNGS--
