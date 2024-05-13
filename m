Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F731474CF
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588290; cv=none; b=DtvBKHJ2tmjBf0wu+JVAN69nl4e2GmmGW3smcEJI0OjyVylMgc0yJjeO//fXpbz2yBS0kl3+r4ug6/3lke3mpWaZgjEvqnThkIgVzFxfPNEktdV87uZf2M/HvDE3/6Pj6/zdAHt1EInbEgR68Ot/OcBM/Y0WVoBhW/wWjHExxWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588290; c=relaxed/simple;
	bh=5V5JSM8I51DRprmeCT0ZMwEouH53ApNc7C/gtHsypgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RO1tUEcQzg6NmTBEaLMw7zuq8jZWWn3md5+AgKSpBir4eO5HlC75mGOI4yMylS8uKCh/NY5CYZGapebA6jJbL2oPxGwCtxiuAFtyAxkVVjuWtZcHPOmtjcnVNMTVqiZ1RKRbt6QzUEAVan3G824NiUQOxVG0nJ5/pBgR4BJQnrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nlwatANk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MWWE/K93; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nlwatANk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MWWE/K93"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1D45F1800105;
	Mon, 13 May 2024 04:18:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 13 May 2024 04:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715588287; x=1715674687; bh=+4TcLo5b8F
	h9SOg0oXSjaFRgcLRtWd7Prtc2R4jJv7A=; b=nlwatANkz9DgH6Pz/iRy6jLcTk
	k6KCNI0B8AcseWe0AGSlIHubK+XQjkxps2BN0euP/PjhBrMCZVFpyOq70dROLDbp
	ykNRDOIzzjyjnuVSE0abfIsLtY2iTAMEzTfHOEUwaV6vlAuR9mq9UeOyuatfKwo+
	duMHaWfD7u98a+jkdwXCxnI0hbFuRUsEdSY0LEbIqhD8gZIg7G+gTxo31J6Ehw8I
	7dFwDUPXVASoNGr9vZdooPaa+wdRCVlf3x/4UVCjKPvR9NmX+WonYfDycyegXEHo
	zHuoqGujF3UQqYoUj51md+8oKraAGgUixVUDHpI25ci5GQt+IalCbrx2EY2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715588287; x=1715674687; bh=+4TcLo5b8Fh9SOg0oXSjaFRgcLRt
	Wd7Prtc2R4jJv7A=; b=MWWE/K93MClQ+X0y5IvxD/NNR7f+0F0tzj0WEp236q8b
	g1GyGKo49KGgdEC8QsD30Af/bPGnoDT0zF7W7/QDOyhOLP4/UVERvTP8I2vXBZXI
	EnIjb8nDBPNcLyH3L1hxV9C/v3MP/1xy84hFd9z9Hqn0n7Wb+Frt6qiVkUwwxp3S
	LptsbJrWuTiebH+z5pAk7Ba0AhQa82CfyhitYbR/MlU3UTwK3oScwOHK6Qr960R/
	wjiQTohWGF484AjuiQ9T8CzA/O8PpF/feHl2z+xaei7iLmwykQAZJ9GBY253jbDo
	SBeBahpg+6JsOqGRsk9Ob/d0JOC8dG9j7GTCIznbSw==
X-ME-Sender: <xms:v8xBZiHsZCAdw_dCk4sQl86OOhTl5ifYnSxjchyUZcEABtceAKUbkQ>
    <xme:v8xBZjVMgAtS4twZuhf6VqTW50hKLPUNTzbXACcXrIxb4N8M_JIRPrfWYVhyYYxhW
    YDi7Ae2aTPAJySoxg>
X-ME-Received: <xmr:v8xBZsJoVFiM_zr66YnomemvHFxzv5BXMT7PgnQYnd2VtDrpOMGPFY7fV9Q152UQimUoKr1RhVoOGatCuLdUAvTNoRuXZ8tp_R8Q8rQB9hnM9Ss>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:v8xBZsFSyoVCPCzRtFESrs0YGb1Up-BGO3hafhkxbXdqkOESwhCiTA>
    <xmx:v8xBZoVmrqE82XDaGUpcObm2c5pM5vcJ25rxy9zOxnE_qAK-LYm9SQ>
    <xmx:v8xBZvPA3-Deta20X3ZzHXO1YYek1m3LXKbyrm8PkgmitwHSq-Vt3w>
    <xmx:v8xBZv0KQdPniCUafNpAdrnAbhIe8m2bS1Wyhg604OARG0srEiOt5A>
    <xmx:v8xBZmwcuK_lcEsG8UUHsD-Mi0Nz2PV9e787PSQAwso5ol3t9urgn6rN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 04:18:06 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 846757ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 08:17:48 +0000 (UTC)
Date: Mon, 13 May 2024 10:18:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 03/11] reftable/writer: drop static variable used to
 initialize strbuf
Message-ID: <ef14bf7195a492872fa069254f9c029c203a85bd.1715587849.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715587849.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LLQmUrcuZE11tjXB"
Content-Disposition: inline
In-Reply-To: <cover.1715587849.git.ps@pks.im>


--LLQmUrcuZE11tjXB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have a static variable in the reftable writer code that is merely
used to initialize the `last_key` of the writer. Convert the code to
instead use `strbuf_init()` and drop the variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/writer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index 4cc6e2ebd8..a043025b01 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -117,8 +117,6 @@ static void writer_reinit_block_writer(struct reftable_=
writer *w, uint8_t typ)
 	w->block_writer->restart_interval =3D w->opts.restart_interval;
 }
=20
-static struct strbuf reftable_empty_strbuf =3D STRBUF_INIT;
-
 struct reftable_writer *
 reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
 		    int (*flush_func)(void *),
@@ -136,7 +134,7 @@ reftable_new_writer(ssize_t (*writer_func)(void *, cons=
t void *, size_t),
 	}
=20
 	strbuf_init(&wp->block_writer_data.last_key, 0);
-	wp->last_key =3D reftable_empty_strbuf;
+	strbuf_init(&wp->last_key, 0);
 	REFTABLE_CALLOC_ARRAY(wp->block, opts.block_size);
 	wp->write =3D writer_func;
 	wp->write_arg =3D writer_arg;
--=20
2.45.GIT


--LLQmUrcuZE11tjXB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZBzLsACgkQVbJhu7ck
PpRjlQ/+IzdQ6JhrsnIYoyRYR1Usbbj8vx8w8NI7cFyXaPWUHwiKtljboff25lyt
hM67Uck3HkEK98JepsMFbcVucWwIYEjrH/wlDQ6CkdnuRqCZA+eyaqg4fDfEAjuX
09tUDT5l+MsqFS7rISaiyZIeo+BTMOqXkiCl3IDIwmn6B17a7fPIFQSMUUb3w40/
EJu1MvYv95/dD+rp08E5lMDMDRVUcqsdMHhESVPIrQQXvsZ66pseyM1fLf21Ub8b
22XzKFkyYu5g2gXEwmFzDWeEkVH+H+Shf8RBkhVWJrezOrkXUEHUyqWOFbvKoARS
cjmUF+78MIQ60DF3HC7tcTpWJ9xrfTdPEib5VyUgLhdABfjDIqcik11IWjbfGiCY
HMl2TPwAu5JovoFZxyAc6wx3gsfGxGIfLCEHNtPQ7UpyNnhhKKRQeDDFtOV49pCk
jm3fzHncLWjr7hw8VQupUC3q22lbnSS27Kkh3slZD1BguzS0348cvdgdOO2UO13x
nVH3j78xLMaf6T4nK/OdyF3WXPzeshHOPcsTTwXjwHI8hM4IDVlmy8IyuZBXmqAf
cAzaZBU6LhS5NESPuJZZ3JhqnJlJOKXMfC5EMf86HHpn/Kz5pVJN9Zk4toKxzkt3
2e8rEo0HpE0JMQsqvi6pOH6481E038HKk8tv2FrFPodTZn07nCU=
=WsEU
-----END PGP SIGNATURE-----

--LLQmUrcuZE11tjXB--
