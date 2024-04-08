Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A1A1802E
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 06:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558784; cv=none; b=GzH0bGC3lqz/UtHCaECx3IkDq2NA3tYA66DKJyIHUzeAvFCQwx+sDvm33G9l9BJbMN1yvXA7h8YDP8XwjVkQgETji+xwCWkMt/yynpWi3eyfdAMeKrxoyrSe+UycoDU4ZkDr6X8QAt+/O4OqDGW9/b3mqhBfpQtmEqGJwoiod5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558784; c=relaxed/simple;
	bh=V8ydzhaFIEaEeygCK/BqhMy+hHDRv/Hw9+uNBWqgeV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFDsbivgogDZG3YCHofrKafthgOWL0E9R4MDUneNyfzJuKtVDyvRoKjoUdIXVb33xFGqbcRxpJSBIGEHYTQHeCv4Sk9BCJ8+D84zWvTbZMiUBqELEHwiks18HqRKq+FqoF8Qw3bUI/hZvOJZYEvsLkhjq4Tfbr3VvC308z1c7/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qN7s/I4Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bg5+Q1ve; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qN7s/I4Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bg5+Q1ve"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2F542114008D;
	Mon,  8 Apr 2024 02:46:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 08 Apr 2024 02:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712558782; x=1712645182; bh=bfW94oVWwn
	X3K9tZMAG6dlEbKNApRIhQOYP3oR+UhaQ=; b=qN7s/I4ZI7oJUlZLfM1O2zMHkH
	1SE0GMHtgayUOxn3KqK2YRKt46+07RGjSgZ2bUdAfiEgF5nWlFenBZ++GaiyYFQb
	F2kAB1vA3fWxtgYImvypXR477u6XfVTrB2u+y3DArf5pVld6PrqHFvWe10iXAEVt
	fbwuJykpvDwv/HzemniTHY13Vdkg5mHvog+o8MtFFgVAQVmkcHHjGBUOyR0FRyn9
	WHryrN6z8OJnRWz3O5GX1JHMX1+pgX3U8jiODiY06y8SL+jIEtw8y4Bs/WCYRcBE
	OUMIW+L2YQiwMELrtU55CV/G6q5B2CdZYsgl7eT9XJWMRO7hGMulLMMh1+1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712558782; x=1712645182; bh=bfW94oVWwnX3K9tZMAG6dlEbKNAp
	RIhQOYP3oR+UhaQ=; b=bg5+Q1ve0LqkPr7Ty8mBdHDTmdjmYvk8vG65s4b6N4BL
	dAYwE58n+oJlcLlCKqJnCmlDitoCpcX4UcuP7Xd3C9pQksQ1tW5IrmVyT2J4JNgX
	G3NwHpZZ3kc+xJBVlvzVpfFdblZxdpG89lJB6n8cmhm1Gx4bRyivOUKQjpU47PNq
	kF3VhYh72aPhKiFWsO3GPsDYSZC4vmUl7y9sCSkAeLa5UpN9O53Dm/9meZ1ZMKRw
	WWa+w/rO+TQxXkdf4F7ItReY4+EvwG1dUX076g/A0Jeo9XwD+6f5rajr3AoROBZx
	8tkz/Qqfdk3kGEBh9ZItn/sod3sm+GZY3KFdFfhCsw==
X-ME-Sender: <xms:vZITZq3V-YRg4Tx2Ul6AYm73PkPBwYf0Quj1VvQXYgW9iU1MdGAwtg>
    <xme:vZITZtGEy12jARdUFFGvu8Blt0vI-7QOOgNU23mrLjy5CXGSh-zGe_OGHX82Z1Rg1
    yafRgQH5Lyt7GPFgA>
X-ME-Received: <xmr:vZITZi6rB29hzxubyELqjh_AoQu0zK7WGfIEOClXvzIJ3c1fdww4s1vjl7z6UTCtofaWR7zX0s1dhzQiz7AGQjx-DijN238FiZw4-aOqdRoKWUm30g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeghedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:vZITZr2iWiGF97Vzy_RcVOqHrR0b_DXcnDkeXIMU4eoqDQXpzqKUwA>
    <xmx:vZITZtHcTMrRxwPXKGjAcX_39kZp8qSJl_m9afrmmD-hwUfYzBDPjw>
    <xmx:vZITZk9nsIDy2ua5iYAvTkEQgmfKhgiEf1sdbSgunE9uPg82X9f4_Q>
    <xmx:vZITZimIXnluXEEaKHwg8htAUliQwYrS_DpDVVLa01N0Fr_byN1uFg>
    <xmx:vpITZmMngvEP3E96jZwDgU885NYu_pfKPvlfSdwEwShPDNIwDOLMzV2G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 02:46:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f401fedd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 06:46:14 +0000 (UTC)
Date: Mon, 8 Apr 2024 08:46:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 02/12] ci: expose distro name in dockerized GitHub jobs
Message-ID: <e60a40bd6507b6ce146866941fea4d6952a53285.1712555682.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712555682.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KGzAfqXEs+8SCaat"
Content-Disposition: inline
In-Reply-To: <cover.1712555682.git.ps@pks.im>


--KGzAfqXEs+8SCaat
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Expose a distro name in dockerized jobs. This will be used in a
subsequent commit where we merge the installation scripts for dockerized
and non-dockerized jobs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 684ef5c00d..71cd4e5486 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -342,12 +342,16 @@ jobs:
         vector:
         - jobname: linux-musl
           image: alpine
+          distro: alpine-latest
         - jobname: linux32
           image: daald/ubuntu32:xenial
+          distro: ubuntu32-16.04
         - jobname: pedantic
           image: fedora
+          distro: fedora-latest
     env:
       jobname: ${{matrix.vector.jobname}}
+      distro: ${{matrix.vector.distro}}
     runs-on: ubuntu-latest
     container: ${{matrix.vector.image}}
     steps:
--=20
2.44.GIT


--KGzAfqXEs+8SCaat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYTkrgACgkQVbJhu7ck
PpR1UQ/8CJNMFuYmIvGbdIX4xwXI516KyrH7szKUx/S3W4hhRZbY65ISwlzRU/tj
pO3h44xZJ2o2yP9RwmzqGlNSDp8HoQIffY4qeQN3K71QTK9cnKQVmP6z3/dDKId8
cGYNYCnFJHT75/Ejut9Mq0K6x6MQnK3KWE0x/CmEyKP+pSaLlNWWLzSTjMQn8UPL
H2dheGtiAP+mEO9Uas1WIU5uBuyX1XIJf1j2Ca3dmAkaFjIILeGqNI5+a0KyTIcM
nJDFdbVto11yKErAp1VOBOgT5b2Y6xjmId7lhT4so4nRAgdC4nNeMPsNtQ25M8JD
WE+clkFrIZ7SIJQhm8yaATyM9ey/sRidfYPufnWYnVkXm6zPtnabqSExFROqfGCJ
1HgBt+P2DKCtU2+7Z4Vk3yL7yNvwLX2W2LToffowhLekvqpc59oKsngqhMV1Sg65
pQDegsWOu4EcKifhPzBjLz4PfI9KffG9InRQjulr898hB+KJRwsDCK0pXGeot4ex
DhPTerrrO1bUzZltnKrQUR+NNljSVw6UdxHp8g9ZF1o9mLI3L3ufk2WDVHqvFrsU
TzmL/qndwiDuJhJjOXHOPgde5j27ODtwkKKDFMKo/9EeTn9WfaTAMoIDvpm6Au14
Kcwt86Wh1DpDn9kNuvAWBM4918WHkfOhdcnnDYBv1l8WtqMGXxE=
=+Pfe
-----END PGP SIGNATURE-----

--KGzAfqXEs+8SCaat--
