Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652DE18646
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="0Clu+oIi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZV+0Bx4V"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5EDA1
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 02:46:09 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id BB3155C00EF
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 05:46:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 06 Nov 2023 05:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699267568; x=1699353968; bh=Np
	EUnNnW4GAub8iuIXJGCZ053jsV2le5JYtKjn2GF5I=; b=0Clu+oIin35NgUZMAS
	5bMpLqYUa2SGhMB8WlvbEMGJF4Lcb0OREwZpYgnoZkdphJEwn9B66kiwaBljf3ZP
	JWnZ6ySTQA5lMoIh7iq/8OsWCxC5rgv/KBzPCXyWAkZh7+w8fVkW20RyWlNaJREY
	WRZ0Fry2DiwTLK3ph43WTbTd+tOAxTxyi2UqXljrBtheJGhBXnhokVXdCAI7zj1D
	DahhuIs7JBVfFiJ7eqVKdObxIaV2wFvhydMmpnOy2fh7myLBDoiKqfP5/WSSsoUU
	vl3NVAOUUEaQHJttUqaZDtuSM8BXDCfKYqcEz/b5aKTo1oB+u9onCEJ82lPOzA/+
	ctJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699267568; x=1699353968; bh=NpEUnNnW4GAub
	8iuIXJGCZ053jsV2le5JYtKjn2GF5I=; b=ZV+0Bx4VzdjRnspV+mh/vCTGjEgHh
	HrMqZgJyQ4hjG2ZXLtDvFnHHKTQtsVJu+IgWNpPDoVx74ny1ZBNUOqHLgr2NBGYq
	0FX6zaqkvnVWxJ9V1ix7sr9H/XWxxMvqyKNaVhFRd/WjONQj4xKm6M4SxJgVja4z
	EjMtkUq/7X60QUatzTYGiHekEvNGlPRUg0Rs5yoRzQ1WsHzO7zAg4HzKwis2sjG1
	4LZWHeS9oTVhfjJnPdONMwIGc7ZyptrCtGYfYeWICEYEWjIu+Qoci0J50VfqkK4j
	TPXk9jaAupFwBtGBWPV0hCtaJzPalxZBeKFcQ6vhxoRXbxisd5cy0aXZA==
X-ME-Sender: <xms:8MNIZaD-kTRetWV9Q-1C_4_EYYjeiN2BJNWc-VGQ1-uz4s4gye9m-Q>
    <xme:8MNIZUhGY1CO46LTEGBcWO7nnMZHykL_mrSNInpCF9IAU-PbsXz86TDTZnkW1QyCu
    OEqFMAyDOZcFfZ-LQ>
X-ME-Received: <xmr:8MNIZdn0KZ1Wc_h_UxFvetBlrz4NB7rQo0JLtrfPrha_8RiWE_DmFmOA7sp6RdEhPBBgIhhU3Bv4k3oGrzJi614zL2MJtx5UULht0eS5W4oLwZ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddugedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:8MNIZYyix8eeg74xSk_gKz80W9WWfgCPFwOgFssSUnyn9cIgoK7CwQ>
    <xmx:8MNIZfTBXelmaeKYWmLmLEDpwcDKGmlxegOMn1Dp0IWY6IowIq2Obw>
    <xmx:8MNIZTZpA3-dbTHQ6cHOh-BLHYTcQeRgr1go2A3o70FncZvUXsuRUw>
    <xmx:8MNIZSP6nlVEIziUN-YIlTEdzfF25scw4UtiowR0x24Dd9ianW_lJA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 6 Nov 2023 05:46:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 37082847 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 6 Nov 2023 10:45:46 +0000 (UTC)
Date: Mon, 6 Nov 2023 11:46:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/4] setup: fix leaking repository format
Message-ID: <1bbddbcb0b0b91128b9ddec69d8374c92e9128d5.1699267422.git.ps@pks.im>
References: <cover.1699267422.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HYadpfKRLs8OJY3l"
Content-Disposition: inline
In-Reply-To: <cover.1699267422.git.ps@pks.im>


--HYadpfKRLs8OJY3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While populating the `repository_format` structure may cause us to
allocate memory, we do not call `clear_repository_format()` in some
places and thus potentially leak memory. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/setup.c b/setup.c
index b9474b163a0..fc592dc6dd5 100644
--- a/setup.c
+++ b/setup.c
@@ -722,6 +722,7 @@ int upgrade_repository_format(int target_version)
 	ret =3D 1;
=20
 out:
+	clear_repository_format(&repo_fmt);
 	strbuf_release(&repo_version);
 	strbuf_release(&err);
 	return ret;
@@ -2199,6 +2200,7 @@ int init_db(const char *git_dir, const char *real_git=
_dir,
 			       git_dir, len && git_dir[len-1] !=3D '/' ? "/" : "");
 	}
=20
+	clear_repository_format(&repo_fmt);
 	free(original_git_dir);
 	return 0;
 }
--=20
2.42.0


--HYadpfKRLs8OJY3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVIw+wACgkQVbJhu7ck
PpSqBA//TJvpMcz2zJOdeW3cUSzvaPPizEBV1+n9CrSddcqHcgCDnl9W75iFgFeq
5WCAA/5ckcOXuq4GcsQhWJiAr4+wcPCmI4pU/y7yLZvAviWUYRbSKbBJfq7SZgT1
tgPz1TcYNrYzf4eScM9dGvtj9GEnwqyVbwZdsw4vMFlpJ21eAJQ1RX4VZnGmX/ox
vbFctzEc6/4PWDr7q9feBmcLeL9zsNLNHg4xGDIirtxQTgoGjHxuSHU/O26QAE0h
NDismmnN6rX82zOgqskbT1Y0+DFs8kkrMuhWc0DKYGhrZk989hGztT7B55YwLhNU
4ogQma+x5EDw7878tw9qoR8sVsqkHblkR5HXHhL9Zu51v0rr4RZ0QROiBXloWQRF
8anIH/gFtH6zMKRueaiN48BrX39w9oIIgCYMaQpdUaLJXfmVbosY8iIJ3C7eKLI9
nZENpa8RoU+yFRTOmKoczBOeTGIO6rb+oE8dCros7LSpSSZDbApLG9Gt6KY6bpat
mKtQVNKL1PgXHuR1rpZrRA7wzidl5adE3D5dTf9MMfp+rmNDT2C3vE/fgFfBAGTS
SqBdqj0jeaMARjZxlMXfEwXRAXzh+eBY44GsuKJbX8zPlP7X9un6Q+LwNq+Xp68h
dpk1+IA7ze1PnCaYdVjes6OHqoJyoWktap0crgnZH+lobDI1h2o=
=4KQX
-----END PGP SIGNATURE-----

--HYadpfKRLs8OJY3l--
