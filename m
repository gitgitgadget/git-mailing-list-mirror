Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96290182DA
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 08:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fe+uHG8+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MMBhqBvj"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B384F4
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 01:16:55 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 4A00A3200905;
	Tue, 31 Oct 2023 04:16:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 31 Oct 2023 04:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698740213; x=1698826613; bh=Yl
	Io8NqJ2GV6Qr28151Tcn2tl7FxYN/gIzz41Y4k0r8=; b=Fe+uHG8+3YI+BgJcvq
	uv0OS0Aqw0XSIWVMDqvF/qUN6cS6uRDkH8XZYckhTlpCDdC3nfyM71RCRDShfldz
	uxLc+1oVIMvE0wbGNBXr0gH9EwG3WQGpeQI/ByPka5olyqIqxV7Xm86t2xtLYcLz
	J7k2gbMdaElIGeLJV78mJ7zKpcVtYnepvwRoKkTBgHTJPUO8vyMDQAoUUP/pvFrr
	1p3GIjETSmSriWAU8FRm+aXqh12gcH152Wssq8G3fiMGn/VWLd9qivU3LhLIVbh6
	8rrbRZFC5yMPou9J1Di5UZmi9/UCbE7jmWzJx6RXglGKTGwuiUr2lY35FP6h5KBR
	O/eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698740213; x=1698826613; bh=YlIo8NqJ2GV6Q
	r28151Tcn2tl7FxYN/gIzz41Y4k0r8=; b=MMBhqBvjhT9YMzwM5+4CAYyTA6aQE
	YS5HveP0crjie6aEe8WV1pBxhJYrJP/hr2ln2RGjjEonEwqw2VEhg55WnMqo6HHR
	HUozo2EklU6iuhrv0MsPvkPqaAWwVsQlfeNTapKa6B70d8KgNwqXvoMsbJzcg+U3
	cq//CK+5KnDJRTJxTLR+9IDNLauo2TizUhAKvxBqMDuk00hh/j1UzKLJ1T87nCJL
	p6hxxpkeDs0jyC30BdhDXhrPHJ4q6iF+F9W+WZ0VapJ9ZvenTdRgs8CCVtsOF0D+
	0NvFioWj9ZvzkISX5wutP5mlnmc9V5B5ruETa2QiFq4Muqo/+T/1V65ag==
X-ME-Sender: <xms:9bdAZWOJt5J_DlhbKTykOKzuE9I_p0n6bpZx8xmAB3pFlUIR62tbeg>
    <xme:9bdAZU-Nzib4FqKVBjYFBOYLj805I21PJ1DaTlmP8mgHGSLy0JuCa68QH2Ci9uxqr
    FUK2vrShjY2lF_qpA>
X-ME-Received: <xmr:9bdAZdR8G9fmHF5U9yz3zszyD-3v8kpjxMG06eVRZkNBOvL-uL1J4FevER8Vf8kkvKMzWNYmt525SfZohTJWgaZM0xt_92yhEwaMlVGrt5y3TENf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:9bdAZWsKLnlq0DdoYaCDi9EhwgTgtla_xWPTVB-3aVuns9DINK-7Wg>
    <xmx:9bdAZedV3papzluhDLP6xq2GuCJAquhS0FsxRZzEZOe4NFpS-FsgNw>
    <xmx:9bdAZa25sgHfCxkUpLSpVAsnvqHvNjcp5CyNqknui-s4oxfpE46EPQ>
    <xmx:9bdAZe7HBWj5AGZAj2lrA7-ClpuBx36xXPb0QhyrnmjgDDsQOYEmSg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 04:16:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0dfd7c31 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 08:16:44 +0000 (UTC)
Date: Tue, 31 Oct 2023 09:16:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v3 10/12] builtin/show-ref: explicitly spell out different
 modes in synopsis
Message-ID: <087384fd2fd984974344c58f981b837381291d5e.1698739941.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698739941.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="va0tBcd8gjVQJ9eH"
Content-Disposition: inline
In-Reply-To: <cover.1698739941.git.ps@pks.im>


--va0tBcd8gjVQJ9eH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The synopsis treats the `--verify` and the implicit mode the same. They
are slightly different though:

    - They accept different sets of flags.

    - The implicit mode accepts patterns while the `--verify` mode
      accepts references.

Split up the synopsis for these two modes such that we can disambiguate
those differences.

While at it, drop "--quiet" from the pattern mode's synopsis. It does
not make a lot of sense to list patterns, but squelch the listing output
itself. The description for "--quiet" is adapted accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-show-ref.txt | 9 ++++++---
 builtin/show-ref.c             | 5 ++++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 2fe274b8faa..22f5ebc6a92 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -8,9 +8,12 @@ git-show-ref - List references in a local repository
 SYNOPSIS
 --------
 [verse]
-'git show-ref' [-q | --quiet] [--verify] [--head] [-d | --dereference]
+'git show-ref' [--head] [-d | --dereference]
 	     [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags]
 	     [--heads] [--] [<pattern>...]
+'git show-ref' --verify [-q | --quiet] [-d | --dereference]
+	     [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]]
+	     [--] [<ref>...]
 'git show-ref' --exclude-existing[=3D<pattern>]
=20
 DESCRIPTION
@@ -70,8 +73,8 @@ OPTIONS
 -q::
 --quiet::
=20
-	Do not print any results to stdout. When combined with `--verify`, this
-	can be used to silently check if a reference exists.
+	Do not print any results to stdout. Can be used with `--verify` to
+	silently check if a reference exists.
=20
 --exclude-existing[=3D<pattern>]::
=20
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 6685495dd2c..460f238a62d 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -11,9 +11,12 @@
 #include "parse-options.h"
=20
 static const char * const show_ref_usage[] =3D {
-	N_("git show-ref [-q | --quiet] [--verify] [--head] [-d | --dereference]\=
n"
+	N_("git show-ref [--head] [-d | --dereference]\n"
 	   "             [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags]\n"
 	   "             [--heads] [--] [<pattern>...]"),
+	N_("git show-ref --verify [-q | --quiet] [-d | --dereference]\n"
+	   "             [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]]\n"
+	   "             [--] [<ref>...]"),
 	N_("git show-ref --exclude-existing[=3D<pattern>]"),
 	NULL
 };
--=20
2.42.0


--va0tBcd8gjVQJ9eH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAt/EACgkQVbJhu7ck
PpSw2w/9Fzub0G9wjVATBi7pOcxzsIYZ93Gyn3KJS1PLvfdosxR2ovvh43eFvOUC
Upzy/PSTXRvkYL+DYvMoh0nP69FL3m70W1s6kzqqMpd1JWyrSzLBcJYH+7rPmoRt
a5sNz4NHjfaqq4mL463mxe0BdKU5UnpbdSHCDPe4t2MjEqOD/L7Ez33tXlMDsV1l
+1HdfbZzQry0tt/amugSF2WIEI6VTSbrIwJyDld6/plXYBjLZwNTIvLJ5zyV6k4p
CpIrUO+jm9qinadGBYXWeGv23K+6nK/YCc1G5/UipzfFgX8UiSbJ2piVha1FZT1w
O1+uZupDrcrCwq1oWNxExWqzGwbKI917dkVRCkTTRdeHDoteKowDXqyvxIT7TNV1
f0zhfa+lt7DV3KnrKCalAuOh0vkd3ehCMzv0ZDvKWplDN7rE/EVZr7QUul52zeC0
D3UXOLk7wPQY6hoOFSU1HCa0NuRZNSbWf8rkCBK3MRpBWQ6L/wjbuCS6mpbflXNn
QpvezmLVQ/riHRQ4WJ2I1mIL9mQCTuQl35+DtMSpo6mFk+41A9YxqlKMTNLx+OFQ
+XngrviUYkywxHpT2xvU3R4BZq77dsXHyCHH6+UwK9EiBgES+PnMOn20W2ZBGy7Z
EKd1CRi77e9UdP71spyv1ku00PWaZfAxDK0gD9dlKlijBPnnQXs=
=t8X9
-----END PGP SIGNATURE-----

--va0tBcd8gjVQJ9eH--
