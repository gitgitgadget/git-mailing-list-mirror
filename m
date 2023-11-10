Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59F214008
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dwjrY7Rl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pqrnqxBp"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A1826303
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 02:01:32 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 337EB3200A27;
	Fri, 10 Nov 2023 05:01:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 10 Nov 2023 05:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699610490; x=1699696890; bh=up
	6Da/zabzE2e/EuSTJSqZzLWQ/YQ+NinMw/cUt9XYY=; b=dwjrY7RlhUa05F3FKg
	bDOaLCDUv+CQqzJ99AC1hAuULmv8cFoscdSmuI+7snNJxJ7V7aYzvR0VC1X/j/4n
	Nlv5i9swPHM+4yt+3RzxawehEIws1T/BFcXSz+814YLBfSS5kdH7eSE8w46AmRoT
	rvaNGSdjIobYtVil/je+I1Q6YPSQDdaKSRveGMqWEqZ8I+MCCEZHaRDm7PoVQkUf
	Dv+yc/Os/J+atjT3p/1YLPidliF52KhFMWjjgVR/7XmWBnhEoedcX7LisRIrXzB5
	jk7L4/0oaRfwDM1s1QULOjIZ66HnnjvBQZ8z+EqjpBJfQSJBHQM4mDjUZHqEA2QU
	ZnLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699610490; x=1699696890; bh=up6Da/zabzE2e
	/EuSTJSqZzLWQ/YQ+NinMw/cUt9XYY=; b=pqrnqxBpqSXZ/mOII9OPFW2a+cN52
	DMNRpeSIQyEYbRENbd0YlxnY3pllnFZe4XeJdU7cmfX2yy9LeUSBUDIleKTKeFas
	OYSL8gwsmrxFTfRiPIo8pnCiljF0IU8+stlbmCt8dWnaRD0/9PbR7yQQ3jznlXkH
	33xbR+pHrPvD46kKZyQcg/J4DZXQbfRKVcxEGs4tytj+VOilCMfZwEVoNYf0GsDf
	4vZET+7xY2P/fP5FgPImNY4ZJM5EwUaMmzIPmQYRh3YZd7DLvdWzC7N1qSw3JhRY
	I+xBAnTl4eHqEIcYFWNvIbFljryTLMm0ZwWcZYRExdBnerJ6HLekLGh8w==
X-ME-Sender: <xms:ev9NZSdkPUCtGFh2ms_pDdNGDKpXXwE1pv2KhEG1glemIKIRyqNMag>
    <xme:ev9NZcPKCPBCXQUnhMA5cOiwMf8ZdR1TlWC9XRaGSbMYeGb9R93Hi-nDePIK8DcP9
    aNgZvDw_brVnzfsaQ>
X-ME-Received: <xmr:ev9NZTjfDRfs2fIijvwDoKNjVlWSpTonsLWoU0I3-vnL73Y4la7-rPeHN2L8CGw3I3OPPxqUl8M21-nDTeE5ex5SKfkz5NNykSr0Eef4WZGATeJd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvfedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:ev9NZf_G9-M3xtypqSAo1B8t9LInItq0MV5CIlZPcl7Cor2uMp_x0A>
    <xmx:ev9NZeuYoH44Fp1KOoOofmTkJMJ8M-MTi_DdsREMF4s1wF9XLtdV4g>
    <xmx:ev9NZWHaTnddsYfOczbWdGaNRbILh07PlPqnlXfjPo3iDtMyDNVq_Q>
    <xmx:ev9NZTUTu4bdumoOj7koAuPzkCwAXxpEqcuNAY-EI5e-Ox5lEusZgQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Nov 2023 05:01:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 111fff1b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Nov 2023 10:01:00 +0000 (UTC)
Date: Fri, 10 Nov 2023 11:01:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/4] Makefile: stop using `test -o` when unlinking
 duplicate executables
Message-ID: <5326d86888a46931e8893657bda9a2063a5cee3a.1699609940.git.ps@pks.im>
References: <cover.1699526999.git.ps@pks.im>
 <cover.1699609940.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VNNlGhOT7gEsglxP"
Content-Disposition: inline
In-Reply-To: <cover.1699609940.git.ps@pks.im>


--VNNlGhOT7gEsglxP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When building executables we may end up with both `foo` and `foo.exe` in
the project's root directory. This can cause issues on Cygwin, which is
why we unlink the `foo` binary (see 6fc301bbf68 (Makefile: remove $foo
when $foo.exe is built/installed., 2007-01-10)). This step is skipped if
either:

    - `foo` is a directory, which can happen when building Git on
      Windows via MSVC (see ade2ca0ca9f (Do not try to remove
      directories when removing old links, 2009-10-27)).

    - `foo` is a hardlink to `foo.exe`, which can happen on Cygwin (see
      0d768f7c8f1 (Makefile: building git in cygwin 1.7.0, 2008-08-15)).

These two conditions are currently chained together via `test -o`, which
is discouraged by our code style guide. Convert the recipe to instead
use an `if` statement with `&&`'d conditions, which both matches our
style guide and is easier to ready.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 03adcb5a480..1094a557711 100644
--- a/Makefile
+++ b/Makefile
@@ -2342,7 +2342,7 @@ profile-fast: profile-clean
=20
 all:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) GIT-BUILD=
-OPTIONS
 ifneq (,$X)
-	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_COMMANDS=
_TO_INSTALL) $(OTHER_PROGRAMS))), test -d '$p' -o '$p' -ef '$p$X' || $(RM) =
'$p';)
+	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_COMMANDS=
_TO_INSTALL) $(OTHER_PROGRAMS))), if test ! -d '$p' && test ! '$p' -ef '$p$=
X'; then $(RM) '$p'; fi;)
 endif
=20
 all::
--=20
2.42.0


--VNNlGhOT7gEsglxP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVN/3cACgkQVbJhu7ck
PpQjThAAhy2jsm0eFwy/BWU4fC2SzMBmdCFjvaYohsJ7rw+22+4aHgArTiK1euQm
24jNHYd0tcwhXlaNpWcHgRig36wHqJgWLWpcbM6pw716XhA9p/C7VCw1qczg/1b8
6IfIftgmWAnYgW73F21i2e+hifYubm2pSQ91TGK8m+cHd+3X4WF7K2pFEnnx20wC
PFORxrf+FKe7UIOH3P/D/YUrnZX/2DhAUktj/riAV/Bq8ntJpFkj0KZOmDYH5Uo4
gcHHaeNF68Pz3zLx3Dx4UcfufGqDS1OHBh/SwDj8HSh0vb2kevFC8but/ZH/6dnq
LV4i8nXAbKW93iHp7LqKCpcMum4SVMocvaXd85u+06WHXy+OnxalRv4OkeFunOqP
eOuMpKx9BLYzoPJQvbbLJ25RciGgQtVccjUVX2zrA+1ISFQzKblq2BSHfnmZhfLa
XjitNGq9qMd+t/iQN3SEKO/H69PB4kIF82EFG2IOf4FH8Cd+qeEGKR3y9ccDGbYj
EUPMPaLsBRcoDtgE+PflRdyqs7g5dPMCFMkEB7RpLXBIJz6ozUvL4rDt44gKyRj5
+9hsLm3warN2OYYBpb+KKRHuKs81A2RhlTeUnFVE90w/V4tMrCgBBr1Dn0oIp8M4
0s2VNfEvVUfAjzXoVY39yq4EkRgkuLokc6x066e84/pBoujA2I8=
=pPLu
-----END PGP SIGNATURE-----

--VNNlGhOT7gEsglxP--
