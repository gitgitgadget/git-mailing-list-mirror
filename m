Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBA3C8E2
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 08:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T5tdtjtZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pdmdzhBN"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE4912C
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 01:47:15 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 59C823200922;
	Thu,  2 Nov 2023 04:47:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 02 Nov 2023 04:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698914833; x=1699001233; bh=Lv
	+b4gwcs+7Egy9+cK+AzLn1JEHpq4fP2tMN9UqksM8=; b=T5tdtjtZ79tBCJm4h5
	6oGWK2QC7JYSUlQFr8wvrcCt0lVLZydj7FXzlBPegXMID4jdliZk7LUyVMuYsZOB
	faCK+MH96bg34171H5L2jdIpbMLQ4DlTgoDK/Qb62L2w50bk1pEBAw7V82IOmEGS
	XxmSJ4TRYkuZvu8NUEuEm46kcjNPoo+kQLQipnpIcex1u9LRTIKoqjRBoXXzTSIT
	WSZLyUxU5BbiA+iDqeu5ox0TQH30Zk91p1GnciTDNMKBB86KYMWr9qqB8S2GKK9I
	HEfGDCI2M/fMULWPeChGmy7eVsP0nvHyYGLsjtiLby9JOeMhTmJFT+QW7r4yZBNN
	M9nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698914833; x=1699001233; bh=Lv+b4gwcs+7Eg
	y9+cK+AzLn1JEHpq4fP2tMN9UqksM8=; b=pdmdzhBNOiWBHCjXMbFOY9WKPfSFN
	3bBONAZYCp0qutmUvtytGEVzv6faHYW/U8ozfOkW4tHLcuEhWxH6Nkf2sM7lzRy5
	zt49o04lVZJLqpd7iS7MHjKB3f4ushzLWu/gLViu6HesrsjjZTsEzTtD/ctWlsvk
	Jw0bYQZBpxwPBFYl81XkFItoDlDKz5XUUPzn60EktpZBpSMicKRlvRa2MuebX2oy
	02p0tQYqy88KyPMgLluY2xfUdxytc7q2abkDYOj5cjHekIpxVECJ7a2YS+9Iqitz
	MdeugtqZV6akXoxxfuMf3MSaVSAWgJemowpeCKaqVXJ2yfF9WR/z2YXKQ==
X-ME-Sender: <xms:EWJDZTaZTNJ74GdH4gtOHGbt-ASmRQ_RuktmCKuNDdne0ANwu0JVPg>
    <xme:EWJDZSbcAbbTgvuawZQ01dDzGYUF3Nkz12nJCuIiAf7k8KoJgmuC_-1Y19SiImNtR
    MedxOAP3CSVSi6bHg>
X-ME-Received: <xmr:EWJDZV84_QgagUiceyWwdgBsZ96EibSaWzsU5nN4iQUXmuZHTKriRSHzPxER2jkP_cu861CMCELakxzpfyH_rY5qhZioFqc97pbU70wdmPyyC80>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddthedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:EWJDZZrG7fKxXGOX7jqwhPHC2yvPTrm8G68gf6tORyxCXIR8iLekIw>
    <xmx:EWJDZeqv5-115eBv0xwsHDwe8UckdTB7UW7l74SxPBjCc0SyOPkFUQ>
    <xmx:EWJDZfS-UAztGugwxG1-ZbJBH7vjW3J2Up8HGml7vn-Cke9PNLkI1Q>
    <xmx:EWJDZRWP7scAaXzZP-sJPGJHJfW9xaakKd-k5jicyt36-CIBlhPwAg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Nov 2023 04:47:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 51d93556 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Nov 2023 08:47:00 +0000 (UTC)
Date: Thu, 2 Nov 2023 09:47:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 8/9] t7900: assert the absence of refs via
 git-for-each-ref(1)
Message-ID: <4af0dc00165b092a54ee54e90d340e61f3bd84fd.1698914571.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
 <cover.1698914571.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tBt7aPCKnuyVwZcr"
Content-Disposition: inline
In-Reply-To: <cover.1698914571.git.ps@pks.im>


--tBt7aPCKnuyVwZcr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're asserting that a prefetch of remotes via git-maintenance(1)
doesn't write any references in refs/remotes by validating that the
directory ".git/refs/remotes" is missing. This is quite roundabout: we
don't care about the directory existing, we care about the references
not existing, and the way these are stored is on the behest of the
reference database.

Convert the test to instead check via git-for-each-ref(1) whether any
remote reference exist.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7900-maintenance.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index e56f5980dc4..cefecee732f 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -157,7 +157,8 @@ test_expect_success 'prefetch multiple remotes' '
 	fetchargs=3D"--prefetch --prune --no-tags --no-write-fetch-head --recurse=
-submodules=3Dno --quiet" &&
 	test_subcommand git fetch remote1 $fetchargs <run-prefetch.txt &&
 	test_subcommand git fetch remote2 $fetchargs <run-prefetch.txt &&
-	test_path_is_missing .git/refs/remotes &&
+	git for-each-ref refs/remotes >actual &&
+	test_must_be_empty actual &&
 	git log prefetch/remotes/remote1/one &&
 	git log prefetch/remotes/remote2/two &&
 	git fetch --all &&
--=20
2.42.0


--tBt7aPCKnuyVwZcr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVDYg0ACgkQVbJhu7ck
PpQUgw//ciwEn5onRmzryVAZ80Dgf/0QbFzmmfStA2u2t9GMQoI8P8bqMGuLc++G
pvMnPrerwScOPWHHgGSrzTVC+SHvAE7IsGZQNr/tDhPRjU0//R+ButBw/ju0Jmd6
/dVpF4F8JrjUx1bog63gQNNdXda9+MTDxoJuCIu7AahuSs0CcNW3+q0k7ufw9B8D
v4KAWMMatB/0NCtYIOByMu+ZfYdwUWwJqoTDBG9tGoAHCIgLJjazmKBc/PPauDHW
zaqz8Srlok0tjHD8SvS3w6oeGbtCk/mmgXeXSAXFEUaG5rRkUm5WaNomFFac4VTj
1iHKqC3z/EntEY8d7/iAGZsjo2B7sSR19MDdeZcUIMqtkTVitSey0PqoOV6/EoJa
D/XOREMP2tTCWtAmWkS2OGgmLQGNkZyJym3WQTboCESxj7hlksHTHuhJAFPiUO/U
zyADCJi2ZBR61FrHiHjxUgG8eZb+W+TZi7FnzBr5BHjRGyNOatYWhYl9m2jgnErB
daYoi65JyqAFrLnS8gTUT4H2IKXR+W6hzAuMSuzF+zOD0aeUDVQkkWyrKusrcJm7
zGHhSu6Wg64xonzRiok2fFFyr9Rokz0OGsQmXK9tKur1cv0wxpQBWZH7bHuk6pAS
DAFSrRpSOLbAVdRawBjRLmWaGgAqZzCg8N1vTFCIfttirK4E7lU=
=Teat
-----END PGP SIGNATURE-----

--tBt7aPCKnuyVwZcr--
