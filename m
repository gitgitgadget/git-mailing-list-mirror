Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D109060EC3;
	Thu, 21 Mar 2024 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035601; cv=none; b=tWD4sWg+FIvs0330oJmwCwNY0BlSwpLEBOY+w2CngXTDpKsB7p4h2aYt5FTqno1Wgw7G54G5LFa1yzz3JQr/aSo8jUWTRSt7o0o0ktaMJD9S1z1HMQT13vzfRkP+fzgVdXIZbhs8E6WNAeSAbpm2TRSG6LIamiX9e4kVrF+O//4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035601; c=relaxed/simple;
	bh=A4ECqnJaX1d/mbvUYPJdnHCmshCTa77C50e+NGCWEv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvFp9ndRE6luVYbYUEFRZkcgDssO/wMop1sIlGdXg+O2U6Zc1BVBM1LvAEpK/RXLS4ejhG9ka3HX3hIwnhhlyt7AdFSUzeEsW9FYu70mq+dbMUrsTeWqCHxxOpuzZzVE4ctXRe2coBXNGrgV9ehS7wwD+2gL07rsDUidbNmVUFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VM4Ko5ME; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nA5ndxZy; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VM4Ko5ME";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nA5ndxZy"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 9B4ED1C0009E;
	Thu, 21 Mar 2024 11:39:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 21 Mar 2024 11:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711035597; x=1711121997; bh=gMPZyuQ4CD
	Un5AATvp1w/LtorahYNfKg9poSOXtxTxQ=; b=VM4Ko5ME2cxuCI0KLRXKKg5N5p
	YRgE+pes2am6Ptvq8nPerDMhU513nxVdOoAdOjcBOJZwkssmVROqfmBiYDkGHclQ
	RrCv2s58r5HAEY7ioSeHKRN7IQn3nzbbBL55j3dSTn6cJOfghAwIuU9saXP1Kj6d
	3KCr7A65U+YJD5aGPYoF9m6leaHCs6dUsTn2r8HqLGIccR8Tgne/RUAoV9Xba9Px
	Zt49PMQXiaFXEepl53cB35dbtU1IEf6qiog3Z9J6lPEC6GKeIuxegJqkBtCWoQmE
	Icr21yrW27NW6uJuzekNhrY6QUl1v3WJ4A8myptYs80hamCg50OK7xolIh3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711035597; x=1711121997; bh=gMPZyuQ4CDUn5AATvp1w/LtorahY
	NfKg9poSOXtxTxQ=; b=nA5ndxZyV7KRXhmjDqO3yTy4KwuZm6A8wJ0sMoYW/FqU
	o2VMkZs/79BKjOwfJbBCTl7/csNyza++xw/gvQuYh2MqwKCEr+/LFDF7r2+hS1Iz
	pfX1gXwAMVyCEzL7TB8RvC1TfXXMrSj5v/l9YKg5CsAsyd8eflQXNomVn/z69x79
	6hhi8GoLv7pqH0ssD5ONOtpaWclDOfhgyW8VzJXnSCmB8gWb9ne7+PyxeITZNmDK
	wRAMu0zOKaL6AqUFIcFSHqPGPGQEm3OQsGEbaBcd24D9rET8uF+1QoEd8osoGjge
	FK2hZ5PyMc5BX4nz/eAp5gU7ou2/cDrYz/Qd31LKsg==
X-ME-Sender: <xms:zFT8ZdMWBCa96l6MZY-4qMjibsT7TMO_REIxQM_WuWhHLfAZAl1KwQ>
    <xme:zFT8Zf9luSiU-4cdgxO1rg3AZfKumsh8zJR-IhxH0GpbfHlBF4Ye0fjcE3ayDGHmG
    ohuLU7IHVe8Ir3JYw>
X-ME-Received: <xmr:zFT8ZcTfBwlL2yKLAs5ZAKzc5YdITcpSDo0LBjSroC4d4iOK-bkp41qOqWdT5nqHgeiYUN5CLrDNGlN2lERed7dUR0hncKjpxzAXWK_yR865vA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleejgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvvefukfhfgggtuggj
    sehgtderredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoe
    hpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehlefhvdevleeitddtjeetheei
    uedtkeduveeludffffffffdvhfetgeeuffelfeenucffohhmrghinhepshhouhhrtggvfh
    horhhgvgdrnhgvthenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:zFT8ZZvK93Dx9-ykLATzDwVznCf1mODVk89FV_V4t2RKyH067OwFIA>
    <xmx:zFT8ZVdKsCYxUnrykeI3XDTnad-cYxnv09GZ1lC_RV4CSOu7kSVKSg>
    <xmx:zFT8ZV1t9FbvNE8wLB-IBbvGtBt2JiVpNacLQt5Gk7Kof5TyqIUtRA>
    <xmx:zFT8ZR-wrYoW8906EiXl_jZVnOvlSsjgEAdecnPE0RoiM0hG2x9Njg>
    <xmx:zVT8ZdTWQNIdXCGlJSHVObwE-P5cl2B575SX4qnsLGR5OdL3_-PDyZwBfko>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 11:39:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 31d4cf10 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 15:39:50 +0000 (UTC)
Date: Thu, 21 Mar 2024 16:39:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, rsbecker@nexbridge.com,
	Jeff King <peff@peff.net>, linux-nfs@vger.kernel.org
Subject: [PATCH] reftable: fix tests being broken by NFS' delete-after-close
 semantics
Message-ID: <8ac5e94a3930cdd2aee9ea86acda3155674b635c.1711035529.git.ps@pks.im>
References: <ZfBwZTL9zqDsac5m@manet.1015granger.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lVOhhQ7Lw62NesZC"
Content-Disposition: inline
In-Reply-To: <ZfBwZTL9zqDsac5m@manet.1015granger.net>


--lVOhhQ7Lw62NesZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It was reported that the reftable unit tests in t0032 fail with the
following assertion when running on top of NFS:

    running test_reftable_stack_compaction_concurrent_clean
    reftable/stack_test.c: 1063: failed assertion count_dir_entries(dir) =
=3D=3D 2
    Aborted

Setting a breakpoint immediately before the assertion in fact shows the
following list of files:

    ./stack_test-1027.QJBpnd
    ./stack_test-1027.QJBpnd/0x000000000001-0x000000000003-dad7ac80.ref
    ./stack_test-1027.QJBpnd/.nfs000000000001729f00001e11
    ./stack_test-1027.QJBpnd/tables.list

Note the weird ".nfs*" file? This file is maintained by NFS clients in
order to emulate delete-after-last-close semantics that we rely on in
the reftable code [1]. Instead of unlinking the file right away and
keeping it open in the client, the NFS client will rename it to ".nfs*"
and then delete that temporary file when the last reference to it gets
dropped. Quoting the NFS FAQ:

    > D2. What is a "silly rename"? Why do these .nfsXXXXX files keep
    > showing up?
    >
    > A. Unix applications often open a scratch file and then unlink it.
    > They do this so that the file is not visible in the file system name
    > space to any other applications, and so that the system will
    > automatically clean up (delete) the file when the application exits.
    > This is known as "delete on last close", and is a tradition among
    > Unix applications.
    >
    > Because of the design of the NFS protocol, there is no way for a
    > file to be deleted from the name space but still remain in use by an
    > application. Thus NFS clients have to emulate this using what
    > already exists in the protocol. If an open file is unlinked, an NFS
    > client renames it to a special name that looks like ".nfsXXXXX".
    > This "hides" the file while it remains in use. This is known as a
    > "silly rename." Note that NFS servers have nothing to do with this
    > behavior.

This of course throws off the assertion that we got exactly two files in
that directory.

The test in question triggers this behaviour by holding two open file
descriptors to the "tables.list" file. One of the references is because
we are about to append to the stack, whereas the other reference is
because we want to compact it. As the compaction has just finished we
already rewrote "tables.list" to point to the new contents, but the
other file descriptor pointing to the old version is still open. Thus we
trigger the delete-after-last-close emulation.

Furthermore, it was reported that this behaviour only triggers with
4f36b8597c (reftable/stack: fix race in up-to-date check, 2024-01-18).
This is expected as well because it is the first point in time where we
actually keep the "tables.list" file descriptor open for the stat cache.

Fix this bug by skipping over any files that start with a leading dot
when counting files. While we could explicitly check for a prefix of
".nfs", other network file systems like SMB for example do the same
trickery but with a ".smb" prefix. In any case though, this loosening of
the assertion should be fine given that the reftable library would never
write files with leading dots by itself.

[1]: https://nfs.sourceforge.net/#faq_d2

Reported-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack_test.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 509f486623..621578fda8 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -38,7 +38,17 @@ static int count_dir_entries(const char *dirname)
 		return 0;
=20
 	while ((d =3D readdir(dir))) {
-		if (!strcmp(d->d_name, "..") || !strcmp(d->d_name, "."))
+		/*
+		 * Besides skipping over "." and "..", we also need to
+		 * skip over other files that have a leading ".". This
+		 * is due to behaviour of NFS, which will rename files
+		 * to ".nfs*" to emulate delete-on-last-close.
+		 *
+		 * In any case this should be fine as the reftable
+		 * library will never write files with leading dots
+		 * anyway.
+		 */
+		if (starts_with(d->d_name, "."))
 			continue;
 		len++;
 	}
--=20
2.44.0


--lVOhhQ7Lw62NesZC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8VMcACgkQVbJhu7ck
PpRMFw/7B0htFVMcP+vZWDRgVtOoXcKAqy2Isx94z0l3SdMn6HfdrtgCaueivM2Z
pWNFxszPx8B22ogv2I+b6dIKHOslNMlyT0Zu3HHMmcoFwuOLlyg13eWvMSy65sGz
HJqqvYBqTnTK40HiK16rM2uxMvgR2LMb4JJKrIFzhwp1Eb1wfYmJYASvbxsuF3Kv
DvI56h+tv718WbIVrLGH8kILAOMohWSt7H2uHkXtpcHvqnDvRA6GZPmrPyWi+B2r
IrWEGG46GpPvn+lR33FHGNYGh16gNlNDACAINVXctSss3pf6IIcd2AfJqXj9jcaT
ZgmwrQx+1u0YNqM7+sf3X8du3fvVhQs+pxRuKzfPGBlfn2HfLryAC/dUOCC2sHPI
3+QDiA50pbl58iSNBkQduShucD1lqTj9Mj+YD4/YysJaf7RLiHV/uWiZ+erDMsUT
WQBcFPH5nF6Z06YTltfyj1subpjXJTQ1cydNcR0ikOCKS43WY9i66IbhgAXoRM4S
u9FrgYg1LQDgUnqBtglU5/v1ZlCWGH2Ys3LCmi/PN3PvMvUbMHnpExGxNx/2fVSN
mz/pRu5iE10l9TuM2jRSnjQdrCCvSCX3G7nAZeb/LbQxxiYT79k1ReT/CeoiXUZ6
4MCX44j5Tcdlhci5zJmH59dqDm/ERqwb3E0vV5yhtAUpATEmYcM=
=Wqvx
-----END PGP SIGNATURE-----

--lVOhhQ7Lw62NesZC--
