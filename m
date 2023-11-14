Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E976C125DA
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JrPVoORc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bp9giYb2"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70301AC
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 00:58:39 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 41D715C029D;
	Tue, 14 Nov 2023 03:58:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 14 Nov 2023 03:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm1; t=1699952319; x=1700038719; bh=efY8GQtlBOa7xRStw4apSt7XO
	vxZTUQyVrjFk7/CGeQ=; b=JrPVoORcmWJxeG8LOj+itzOiJe16qjJ0xNpGgv96B
	5MT9/ybJ/Z0iYdAMd0WNEx9lLV/OVJPKOulXaNXpRz2Tqvok4fmEwiPKo2AvwrsV
	in68K1+ydv4dp0nv6rvRd4+zolcU9JuNrnzPYmc/bvyc7w6huPaVE9Qd5Yt7Y9Fq
	eRmC+ErAMjAAvsr8hobzkJY77XyMOZx6sFFAAFBQyB8wD6C43HQ1QiYTF1k6OVvr
	olY59BSscx1PFttY39aXQOzgHqu2Bt1qSJeAWtIyi0QB3puK9DDqXxmZQHk5bbbD
	/hNeQqv8NRtf3d7YUuFvzE35UpwSvuouAYBCVQlYnbNyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1699952319; x=1700038719; bh=efY8GQtlBOa7xRStw4apSt7XOvxZTUQyVrj
	Fk7/CGeQ=; b=bp9giYb22DUQTwctJKrPd5i4wWOcSPUaLvWtA9GXeu/fuVOaQCY
	Qp9LLZbnaFFwKQpWYfK89ju1seahvWmNtVtM0ROSQ1dhox3nq8GYJBdNf4jD8UfU
	yMX86edbm2TNyBT8ETNHPQmshtAsdVQY9NC2c7ivX+O4M0KjFTbyWE1ZinF/ZOYp
	yGQJBf5dT8Ccrf7+v5+7atvZNqghItVgaOlNUk/tLzYGRqwQiPnTtO1OPuhKcpbJ
	/hMxQjTQoytc7NB/39tFK/JDYoonx2lxRVItpfsEKH2zmDtcfKlE+W06mipnpKwM
	cUk82GzB8Nvm66tAQu9doPx2om9bhPccDIg==
X-ME-Sender: <xms:vzZTZR-rNGj8Ic1yIAFZ3X9uKupKANNN4czoV859LX1EeuTday-yaA>
    <xme:vzZTZVvStJoh5OxkPNjuAYUzxbb78v1bijM5ZE7sNjGfSdyxUig65YWtrc1TCGqdh
    WTpwrWlXi-MVNYu-w>
X-ME-Received: <xmr:vzZTZfCqPyEMpzpyTsljhVzVGEDPe64RzFFgSQo7l09GO2GwYyX1VIQ4nOzpeeJPYl2Ageg0mXM7WcEVfvUMQR9ZsLlTaJLh9oC2VEGNSlBn4Xc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefuddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfggtggusehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeugfeutdeuieehteelveegudejkeejheeljeejhffhgffhvefgkeeukeejtdeijeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:vzZTZVfU0lW3w4qtLgnRcrrWcLNpRKEiz5VEAtB_n0CyHzVc3GXdtA>
    <xmx:vzZTZWNXAmRcMyewk9-1MgX0YMfvT-yCHtTFA_z-dMaAZJelYuazVg>
    <xmx:vzZTZXnDrJnM7bKEPiwynAdSYj5hE1Naju-fJIMyjUCHPGCJey-DUQ>
    <xmx:vzZTZY1z-dYmO3J8TvJGxK07AiyDOLJrvJhqcXytgRzbGC5v1h_4dQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Nov 2023 03:58:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 84e5d7e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Nov 2023 08:57:58 +0000 (UTC)
Date: Tue, 14 Nov 2023 09:58:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: David Turner <novalis@novalis.org>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 0/4] refs: remove virtual `delete_refs()` function
Message-ID: <cover.1699951815.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R0q51+ONooOM+2XN"
Content-Disposition: inline


--R0q51+ONooOM+2XN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series refactors the virtual `delete_refs()` function to
instead be implemented generically via a single reference transaction.

The main intent of this patch series is to reduce complexity that we
have in the reference backends so that it becomes easier to implement
new backends that have the same semantics as others. But at the same
time, benchmarks show that the new generic code is even faster than the
old backend-specific code. This is mostly because we avoid the overhead
of per-reference transactions when deleting many references, but also
because the transactional code in the files backend knows to avoid
rewriting the packed-refs file in case it contains none of the refs that
are to be deleted.

So in the end we have less duplicate code in the files backend, make it
easier to implement new backends, and have faster deletion of many refs
in the files backend.

Patrick

Patrick Steinhardt (4):
  t5510: ensure that the packed-refs file needs locking
  refs/files: use transactions to delete references
  refs: deduplicate code to delete references
  refs: remove `delete_refs` callback from backends

 refs.c                | 48 ++++++++++++++++++++++++++++++++++++++---
 refs/debug.c          | 15 -------------
 refs/files-backend.c  | 49 ------------------------------------------
 refs/packed-backend.c | 50 -------------------------------------------
 refs/refs-internal.h  |  3 ---
 t/t5510-fetch.sh      |  1 +
 6 files changed, 46 insertions(+), 120 deletions(-)


base-commit: e0939bec273052b1a8d69db4a3f7c87aaf83e220
--=20
2.42.0


--R0q51+ONooOM+2XN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVTNrkACgkQVbJhu7ck
PpTWvg/7BwWVaGqKOkriYw7ROIrDUt35EZbSnsJGp6BSsJ1Bf44CdzhX6tDjgE04
Zs41Y/uVxAqaesFhsgH4n8cWd2xUdZNt2ytfRsZeftJllareiYS9Uty/BC3h337k
WuUGurZAz17axcKzegFjSuBlYkYjveCQIJLyDZXyP/Zzwie92SRyfN4yD0XKfdR7
2RIMBkmP3U/onVwGM5SuEkHk36z9o5MXtajITQX6Rvnd6OyVegsWbd/gZobVLgbt
HC3XRjgbGz9Z16tZESzS5KKiyz/pQSAnygqmTJn0rnOEmyLGCuoV4VhwmPdNuS96
IcWJdvzY8eeVkU8dGO5CyhK4gk/oqtf5ht4p+aI4koVYaGyrEu/3rnBzPILIKzaR
o2cArgiYX/uJowhYUIXRGL9TmbkI7v62A9NqO0h4PSk33aeIPiP0VIZtwVxdXnkC
f3a5pk2soNDHrNRbhT7kkpiQfq7WCB5vk1whO2XrrV1Iscc3zW4UTTlK1Lf56EiU
zatFxSoGXh5+TJAeOv1n/uaTRXWXm4bVkpftSjrc9X5fj45qqHuY3X8l3xnzKmit
jMgqiEUE85HK1kHD/ws0FuctA6KGi7jThbES77tMLuPGfOrVgYOGzfKU38xj6lt7
JEtR5GlVcsJUTvzomeCNFnWermBc3mLzZy32SdomiJX+cUl7x5Y=
=48/X
-----END PGP SIGNATURE-----

--R0q51+ONooOM+2XN--
