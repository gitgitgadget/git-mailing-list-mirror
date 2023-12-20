Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6965C20DCB
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bsUr5TD+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sVh1Kvzk"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 5F6205C01B1
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 05:55:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 20 Dec 2023 05:55:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703069704; x=1703156104; bh=APRgAj2W7W
	f2ZyMgr+34G/NqcSQ/zSESr12HipFDCGY=; b=bsUr5TD+bhVwhcT+wYiWb/rLVp
	oLU0Zi3TIJ6kOGNAiPl+u9fV+Cru3BDEwuNcbTYMPL/mf5A9O64jIOT1MMUKdoP3
	ygGIc+8MaDsrSsxnuYF21A7n3krjW1fKZDgtTKUF4hJgaNWOlQGN6z4Au8jJlHv/
	gCgw1OU8bqq//PUadiRu+8MBavFfUNPpHc2tyVkcYnkCNRMDFhMIzSZSvd6xPo95
	1lVPH2NSV8yoQuPhkiTr1KgZU1whvMVnOZ7IuqJKNYij7Aj0JUsgQ8NtLYb6piKP
	SSZFyMsw/9iGRKs00WBA0+1C76KY2eJGQq+Fd614TN0+U9HH1RVlkZTYDvig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703069704; x=1703156104; bh=APRgAj2W7Wf2ZyMgr+34G/NqcSQ/
	zSESr12HipFDCGY=; b=sVh1KvzkgJGHXx75mpEDuUJ5QXeGf3NTCE0QPnPauGyq
	sppoEXNQfCexkk+Dq52ajqMn93JUz+9rpUN9IWqtp4DyhcgKyCd+/RbBrwaHGz46
	jqN+XiMHQ0kSeASu8gLVbVyFvgLfjDz9x0cdzsaKIqYBK14v+Ioi3Xdi54/JefsW
	pvuE7gYB7eChlx0uVQg3XO8jix9ROXN0uaxlGBpt/fX//H9WrdZUrJ2u8Sg5xGf2
	ddmTEDowDBOA5mLlrONB5Qf0cGOXQ46ny96QgHn9PAf/+omSVBaXlrPo+LvnUWP7
	OPW7z4ztyXQSZSokjGcvAPVkRqDtZQLQjdY+zxOU8A==
X-ME-Sender: <xms:CMiCZR04DUGkO14s50CzgVDNZTbl7rTUgVKoIJ_p1jQEG0xdOi3lXw>
    <xme:CMiCZYEOvbt_cSi-Z1sUqXlCnPjnmzCYpJCQip3Za-Pu4430TCwECXpw6-8Nt_vuh
    vUzr-i5qhK_BMr_zQ>
X-ME-Received: <xmr:CMiCZR5r0_4suykTz5inXA9qP4pa3VkkoOKpDIXLw1ui5SWCqlAGsSAS_omFwvrOc1ZWo8RyrOdwAhcejIq-_sGSXAAD-MjsTaPTt-FZCf5L2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:CMiCZe37zHovdvXMMhXa0QCZdZbSbG5u1rtBiStXsrE2Xw-m6PSaFA>
    <xmx:CMiCZUH2XXSTtE19EzD43bdkGN-3p332b2JN3R7DT7IBD6qU3NTScw>
    <xmx:CMiCZf_bEtqDxLCmlkc6DxvS53HIIua8WP8mzZUO5Q-i6HCxJAI-Gg>
    <xmx:CMiCZXwwykaUWs8qzYINcMEx54Z-6Cloab06lvMItcZChntzflHYiA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 20 Dec 2023 05:55:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id acd6ae91 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 20 Dec 2023 10:53:01 +0000 (UTC)
Date: Wed, 20 Dec 2023 11:54:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 01/12] t: introduce DEFAULT_REPO_FORMAT prereq
Message-ID: <239ca38efdbe3195e6319be4423b17d2b42e0b9f.1703067989.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RMzl1cnsdodG7PBO"
Content-Disposition: inline
In-Reply-To: <cover.1703067989.git.ps@pks.im>


--RMzl1cnsdodG7PBO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A limited number of tests require repositories to have the default
repository format or otherwise they would fail to run, e.g. because they
fail to detect the correct hash function. While the hash function is the
only extension right now that creates problems like this, we are about
to add a second extensions for the ref format.

Introduce a new DEFAULT_REPO_FORMAT prereq that can easily be amended
whenever we add new format extensions. Next to making any such changes
easier on us, the prerequisite's name should also help to clarify the
intent better.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t3200-branch.sh | 2 +-
 t/test-lib.sh     | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 6a316f081e..de7d3014e4 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -519,7 +519,7 @@ EOF
=20
 mv .git/config .git/config-saved
=20
-test_expect_success SHA1 'git branch -m q q2 without config should succeed=
' '
+test_expect_success DEFAULT_REPO_FORMAT 'git branch -m q q2 without config=
 should succeed' '
 	git branch -m q q2 &&
 	git branch -m q2 q
 '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 876b99562a..dc03f06b8e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1936,6 +1936,10 @@ test_lazy_prereq SHA1 '
 	esac
 '
=20
+test_lazy_prereq DEFAULT_REPO_FORMAT '
+	test_have_prereq SHA1
+'
+
 # Ensure that no test accidentally triggers a Git command
 # that runs the actual maintenance scheduler, affecting a user's
 # system permanently.
--=20
2.43.GIT


--RMzl1cnsdodG7PBO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWCx/0ACgkQVbJhu7ck
PpTLWhAAmIAu85dTgy4vYlGMDCSsXv92Zn9brmRDGDinhpy1DBUExtTtUDEeDa1j
ZsteD/pz7rjae2ejLQu4t+YSMFpL7quoxyJuWvlvrlEwc/ayeAUagAZNml73GbKF
A/S1IxcgVTYWJWhx4W49Q2P2enCd/6DNqXWgmBGVmN8pXGJN3BteR2R58yhWvTVK
f9qY5s0eZlLkw+1VqOzVYJUoz+PQj53csOmeGAr2QiwBMtCpaXdPMaBXJjt7IyrJ
KmHLFrAdoEDgmYnvGFYy28rYQdshOXZQn/RYP6EKVoeCYCFl60Vlcv+aTf9fBpXT
uzgwEkSDCzwkOO5wH5LwQVa6g0pwQLX1uffDNzXAv6+1q0g2kd+aHdvjfGImgOyl
tE2ZmVhKjQyVaE8WIkKG9qrfLJSOvctliA7mcDjNPdTuH2apih8Idzjx6lMK/3b9
OIXCgzvfSAKrRHmwxcSv+Nwy9ZLrsNtu2QOlGRk71/uJddBQLau6FjF/9DRyLT+b
cvJB4y/HCVkw0Z8xmY1nw6kovnPtySmSsqb096z3QJeKh0MSokygYbseI0+DcUZG
ZwBAoxu857gGA5NPqFeuCMGT9R/KQaXbriwmpgNh9JDtgsr4ZlhKeYmUnu28NSyO
uCLcIAXR5eeoFOmhEmgqP6cKK7n2l8Qg22cC/Q3TFDyU5eImc+g=
=TCdO
-----END PGP SIGNATURE-----

--RMzl1cnsdodG7PBO--
