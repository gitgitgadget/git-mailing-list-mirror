Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gd3Wf6j9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nNQHRLdH"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C360AF4
	for <git@vger.kernel.org>; Mon, 20 Nov 2023 23:04:21 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 39DF25C1575;
	Tue, 21 Nov 2023 02:04:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 21 Nov 2023 02:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1700550261; x=1700636661; bh=rn
	INZel+ZAkidiH5ybksGw1A/zgbtkxUHLUMfClGedM=; b=gd3Wf6j9ppocwiudOz
	vpsBvHkX/2gOWa/cm8ZynPEmD2MNUnyc8ZmTEXfZtlAE+Dfl/9pssm6trB9+82OH
	NwdeSgZ189trE2Jg4nxf13UbiJ52I+HFZTc6hZdm4hBTNX0HYvFdswbFGxcRclHu
	/9LGptX0bYAiwkRxUlvuRKlWRWKIXZTgbUei1/avPI51QeCepzzrw1ymostFHq/x
	xYOyabbzCiYIzPU/WqGOX5tr9NPYwTz2l1v9v04NvElfWOV5FsQ0+j4W/fPDkmcY
	dj1oXVSI5vLWAIzhfBY8WtxPYv0k9HZSy4bT75h8NqTrmWjkGmbJHdAQHdSCJbVZ
	0aJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700550261; x=1700636661; bh=rnINZel+ZAkid
	iH5ybksGw1A/zgbtkxUHLUMfClGedM=; b=nNQHRLdHu9heU3mQB8uu5YSRZkv75
	ezqF3+CCAlPIETyYZCTCddkEwUJs5fZC5lfngtIw9u998YFggP0HXWIoavvRoBRr
	Pl2yaQBfsfJ7zA/na+omhk+iA/TALAn2S5zbNes5ZiFlAoREyM+Nr/SozdGVkMUY
	y8TN0BfEhThlVME3gaknr+bTm0iVzj0dZDjI6OK6Do5Q22YeuYckujVNWRXZOTUD
	lEha90s2DJ1QobLm6Mnja8fDtCKJIPnLJ46AOxnQ/3XuvGmSUtvdXvrRmm4kH+Bt
	jzQrhwT4370NIZU3xHW4S5Tzoj8T4ppa5SnEa+HUYfzyY+Y8Bq+Dv4JTw==
X-ME-Sender: <xms:dFZcZRAak4rqOLuk5sciNgOxsZUrUP29XC943GPaEFGCqQyTBMnzog>
    <xme:dFZcZfiUwlhd0T_h-c-BBt3F6X2XvJN1_Lw_ExOGtfmVrDoqO_rdcM1dq0tAvwISX
    1KXii7Lz_fkDcg6vw>
X-ME-Received: <xmr:dFZcZcmVsPjqN-o9XlHFv9H6pGnUZmO5d7yS2lQxOF2sdbsHonyx_TtjxGxHFBmtX7XnGoMf95OVohaedGfGYZkEBeq8Hd1id39ZSbbEOT2V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegkedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:dFZcZbzI8TEfSxNL2B7BNweb-g6BgbFvsZ7SoZRp7mTmn2RtFG-EeQ>
    <xmx:dFZcZWQk38-kQk5b_VFf7P44_JWXYd89YqAsUmcrRKcjXK0Tk7JvCA>
    <xmx:dFZcZebyysG_606mv1J1NAtFWtp4uyxpYoALcqT_-Yu9pLgAFOoojw>
    <xmx:dVZcZZKvWn7wdoEOyk4eagQjiTDNXGAvpu60yQYrD6V66FDVvGV7fw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Nov 2023 02:04:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4f90c186 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Nov 2023 07:03:28 +0000 (UTC)
Date: Tue, 21 Nov 2023 08:04:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/8] reftable: handle interrupted writes
Message-ID: <3c14f67c441251d7467757706715ca6d9a4be7c0.1700549493.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zg+Q78NAFD31jwH2"
Content-Disposition: inline
In-Reply-To: <cover.1700549493.git.ps@pks.im>


--zg+Q78NAFD31jwH2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are calls to write(3P) where we don't properly handle interrupts.
Convert them to use `write_in_full()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c      | 6 +++---
 reftable/stack_test.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index ed108a929b..f0cadad490 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -42,7 +42,7 @@ static void stack_filename(struct strbuf *dest, struct re=
ftable_stack *st,
 static ssize_t reftable_fd_write(void *arg, const void *data, size_t sz)
 {
 	int *fdp =3D (int *)arg;
-	return write(*fdp, data, sz);
+	return write_in_full(*fdp, data, sz);
 }
=20
 int reftable_new_stack(struct reftable_stack **dest, const char *dir,
@@ -554,7 +554,7 @@ int reftable_addition_commit(struct reftable_addition *=
add)
 		strbuf_addstr(&table_list, "\n");
 	}
=20
-	err =3D write(add->lock_file_fd, table_list.buf, table_list.len);
+	err =3D write_in_full(add->lock_file_fd, table_list.buf, table_list.len);
 	strbuf_release(&table_list);
 	if (err < 0) {
 		err =3D REFTABLE_IO_ERROR;
@@ -1024,7 +1024,7 @@ static int stack_compact_range(struct reftable_stack =
*st, int first, int last,
 		strbuf_addstr(&ref_list_contents, "\n");
 	}
=20
-	err =3D write(lock_file_fd, ref_list_contents.buf, ref_list_contents.len);
+	err =3D write_in_full(lock_file_fd, ref_list_contents.buf, ref_list_conte=
nts.len);
 	if (err < 0) {
 		err =3D REFTABLE_IO_ERROR;
 		unlink(new_table_path.buf);
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index d0b717510f..0644c8ad2e 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -78,7 +78,7 @@ static void test_read_file(void)
 	int i =3D 0;
=20
 	EXPECT(fd > 0);
-	n =3D write(fd, out, strlen(out));
+	n =3D write_in_full(fd, out, strlen(out));
 	EXPECT(n =3D=3D strlen(out));
 	err =3D close(fd);
 	EXPECT(err >=3D 0);
--=20
2.42.0


--zg+Q78NAFD31jwH2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVcVnEACgkQVbJhu7ck
PpTmnRAAiHpjxlScs/NWmVdIioirXzLf4kHEeJJCLJm2VRTxV5h6ROLqEMdueBCc
EveRiHR2AMyuNzG0ML9UrETCpSUQ/AmYiwedHbd6WpQypE6o3hcpBWfwffypaJ+M
vaI3dcaSrJBjPfCGTIuUuH/OsJelbNkWFvcbN4amUtJ+smyeM+wI2EKVi+6kwsdj
jW9GXstYjVrZtw0/invLSwL4QMSITRoCZ/qqgbi5e3r+SQYa7offT5ni+6EYuvJV
Xc1bGHJJIMHb4zLudwP+9bxGx/cgPBoQAhwQh6p4GaKjdb0UnwBPNlNNMQOt0L77
7RUjJb8XkUt0rpH9B+WAzXF73DbwiPWGERm88crEBHXh3jw1inowBOiE/A1X0q8Y
ydDE+8LTw+zp42v43cjKallCWMPHvGr4QaZoV4XDTVkp7wL8+P2mXaB33xvKFLSe
x6ffNBDv1R/7S0A1udB0IemuhA+1EUSeLlNJ9gG4oVeXoeX5KCzM1Ktn0+ShQSm3
mAY+C9y6m5XmTsRDIATuHf75v//4hKKLKqqWbfvNinJVXGePr6/LQd8tQ3H6W8w9
GiQb4rp9iuK8zmBwLoCMhG8jdhRYOZ7Q90GMF5m0kTPa6wddqsaUx+Uhn6K3DhmO
a5i0ADQBGT2fK2fsnJ2Ew70HUyqVwXciBz3yTZ5tNe+F9AvJF7g=
=685O
-----END PGP SIGNATURE-----

--zg+Q78NAFD31jwH2--
