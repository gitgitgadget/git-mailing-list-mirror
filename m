Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24AA2C695
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="elFfxDwO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ygLN1t0Z"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 9BBAE5C0163
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 06:45:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 15 Jan 2024 06:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705319103; x=1705405503; bh=/ior2w79dq
	HYSgt9h5+1mjcLCOA2/RfB5jq6Dn2oDQY=; b=elFfxDwOZw1y+7B6g4Raq8awKM
	i0OBZ5LeiT7uEKi7PgGCgWjnbNCu6aVMPc3YysJYaxIcalQsbWzOJzkK7CkcO1sm
	GXPtX9lFzVXXxs/jdaKuH0R9XPzTJ63Q1iuwfe8XlwUh7F0uL5mvQkbwh/EzIcBh
	ZO/xK6lRGYshiPb8ZGOPeIsBt/s4g2MfEzxn3b3D1KB39fGyYk/Xxe8t+yOPchRU
	NvvXV/1yix/eK8T/Ng0dlU9Kc/tIY932K4BmWZfrQ+L4NTSqNpTUUwxckYLqSnf+
	QoE8gFXwW4qolX5idoPSCkFXbQIDLWIu34LJ69x7LmN1AyeSWtuYXihpdKoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705319103; x=1705405503; bh=/ior2w79dqHYSgt9h5+1mjcLCOA2
	/RfB5jq6Dn2oDQY=; b=ygLN1t0ZDBKhezyaYh0IHaJ3QxD6yB4HGAKHwVMzN225
	pPPQ03DLXBtucGDDdiCN/GNU9MAdFzgoSj9x0IeqpztJ3gbF8oWoxt4r0M9tT51F
	vJYtCM0jvpfS4+5MuJokaN04SggWIKdkO5Zn5QsGfxcv/msjXKX7yplOZUgAyZhU
	uwEB15GkQH3DeEIQXSGoQuAwMGToXt+kR+CkrT6aXMe6ue5WxQnHFLVHbOwmwxa5
	9xACYr7DQFX5plp/wDHdiHQNXD8lrg3EHaZieJ5etPNFQbE5OgASocotQ8gvc0Zk
	uOuGh/GeZK9JqtFI/e4T6QN+3uZd2xGETdSJU3ZhxA==
X-ME-Sender: <xms:vxqlZTolILZrJD2UU8xqpskeE8w1Zl2nTnnJBP_ePJ3VEQAmlAhXvw>
    <xme:vxqlZdoRkFJ4zdh2Uye6JKyP_9gK-rFV3YrG21RsOufXh9PtRkS59nWOzr7OJaEPz
    XeA-EcO1bBXvNPWOA>
X-ME-Received: <xmr:vxqlZQPOuQ_Td8ccwmXuGqSUXQEL268GDOk3G2k2Cz_jfrMvrLNigc52y9CpAPz3EmVSIme3-cH7JkF9eHOlJwTf0VWzxFHk4j8u_vqFmZF9fQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejuddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:vxqlZW7V2mppKbv5Jt1tyRKlHN66VtpcgPIceaxOFThXJdU9Cm_zlg>
    <xmx:vxqlZS54mXwKSqEiI-XRif8f9cqDJj7USdaXuiOSTzRiirBD4h3PPQ>
    <xmx:vxqlZegboB5EDQo-jNG1-61XZHDOjEWYwy48Nn1G25_W5zqSPhEZHQ>
    <xmx:vxqlZfXl7okVGEB8h-Nw4WeRRV7c0sYr4J2UgytdlpKXTQjC1tiXaQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 15 Jan 2024 06:45:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 075793df (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 15 Jan 2024 11:42:12 +0000 (UTC)
Date: Mon, 15 Jan 2024 12:45:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/3] Makefile: detect new Homebrew location for ARM-based Macs
Message-ID: <3adb0b7ae888db40949f788f9582569617c20c2b.1705318985.git.ps@pks.im>
References: <cover.1705318985.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YnOwBsomyHgbfryQ"
Content-Disposition: inline
In-Reply-To: <cover.1705318985.git.ps@pks.im>


--YnOwBsomyHgbfryQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With the introduction of the ARM-based Macs the default location for
Homebrew has changed from "/usr/local" to "/opt/homebrew". We only
handle the former location though, which means that unless the user has
manually configured required search paths we won't be able to locate it.

Improve upon this by adding relevant paths to our CFLAGS and LDFLAGS as
well as detecting the location of msgfmt(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.mak.uname | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 3bb03f423a..dacc95172d 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -158,6 +158,19 @@ ifeq ($(uname_S),Darwin)
 		ifeq ($(shell test -x /usr/local/opt/gettext/bin/msgfmt && echo y),y)
 			MSGFMT =3D /usr/local/opt/gettext/bin/msgfmt
 		endif
+	# On newer ARM-based machines the default installation path has changed to
+	# /opt/homebrew. Include it in our search paths so that the user does not
+	# have to configure this manually.
+	#
+	# Note that we do not employ the same workaround as above where we manual=
ly
+	# add gettext. The issue was fixed more than three years ago by now, and =
at
+	# that point there haven't been any ARM-based Macs yet.
+	else ifeq ($(shell test -d /opt/homebrew/ && echo y),y)
+		BASIC_CFLAGS +=3D -I/opt/homebrew/include
+		BASIC_LDFLAGS +=3D -L/opt/homebrew/lib
+		ifeq ($(shell test -x /opt/homebrew/bin/msgfmt && echo y),y)
+			MSGFMT =3D /opt/homebrew/bin/msgfmt
+		endif
 	endif
=20
 	# The builtin FSMonitor on MacOS builds upon Simple-IPC.  Both require
--=20
2.43.GIT


--YnOwBsomyHgbfryQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWlGrwACgkQVbJhu7ck
PpTgsw/+J1Sh694iTaaRqqgBvbC/kGpcgVqfepHWJLyTjzKCTtWjeFbut9/+w7IR
ZU/VWZLHFTJ0HKnMuyHfQ12riE3ejws3m/9XhIW5NOHr9xecUFwT9s7uEVk1GZzP
uu+xRym+cnkB+POfjVJh159XLez+R20u3DMeNchI9YjmXC1pI8PTmQc8UbZXXqaa
MaJRVYv3KDO6Q6og3yXppzzWvA6YyuT6ai4TLm62ZqTAvaiFvg6w0S5NiBYc7Jig
r0jo4QHmx0jqxVjL1F7EPXqfUAI8GOL4qJU973QTkhYQSopNkAiXsoKL23/jOtNl
g6ROk2qCLrwhGzZetdD6VXKkCrpiZVjBzyQAsmFQRux2f8SiuFC8QXz210GCTbzS
Pg6YIPmcCalmCMu+3gHfuEWxTyyknxYU48UsL8z6xWEm83cUsTouiF+LsBBPZanK
RexMBM3ORtsYjE6Bw5aSDYVWUuGHM4V/11ZqEWzkl5EsRyZAkHc0ti/2azvwuRlT
FKobxQFwhvrIGbY3PsXrChpqqGsMil46nCtjJgo3nTCLTStoNYyCrgn9z4h6MaZW
rsYrhy+zbK1gHLkQEVP7bo8jfrv/XjlgDEHvDPW1EZZvKEstY7pCl6YNU0RZPFnL
VK2W9yh3qGxhRn/4LiHtfACmdFUC/5/likALAZywQ6sHqf60NZg=
=PX/C
-----END PGP SIGNATURE-----

--YnOwBsomyHgbfryQ--
