Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3442AB42
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E8DgpqeP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HHQTN/Do"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFAB1719
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 06:10:57 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 4D79032009B9;
	Tue, 24 Oct 2023 09:10:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 24 Oct 2023 09:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698153055; x=1698239455; bh=Un
	EnMwirdwxAAIS/g0oVhOAzzsu8M6Daabj+bdockBI=; b=E8DgpqePzvWla5A50s
	vUGbQlhkbkFW3cBCEXek4I0I3Vu617688Idu6IPKn6MDEezGghOly7dBs8YDccI8
	LfMs//MmjYZfBxZ1ST2du5ZM9ILLD+ClYwp4LVKTo+bxnWtV12EZE/8qiBs2pt/N
	QYCJn5iyhXDaxVUcFZ0opo98+UYJIi8reChOnPSwWtUUVW7uB6qqanPZK0oQFFTp
	2JwYW7MZ1f41f/zKKCb8aDPWlNbriZaVBMIC2aleKxVLak4VZgHjEeeWsGKu8Mlz
	NeQ3Dgo7xcoG5+iFl6ZvgLvuthrzvAOBHmtr5GOdzu3u0gGEwL9t92945ednYgW9
	sXlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698153055; x=1698239455; bh=UnEnMwirdwxAA
	IS/g0oVhOAzzsu8M6Daabj+bdockBI=; b=HHQTN/DoOi+6HWgffYqRojuQlBCRi
	IYwikS3U4a57MIDFVLNj9TimEGBwdQ9STLggSNfrkiBMdb05A6BY/vEx2RyomNPC
	yUyoB772bajLbwQ2IXIJAxw7wVNSrQxItj5psPciRPdHpBb+PTte3reFIaUQXIht
	K64D2DkKMTPu/xFeOSjyxVPB9gGY0sjzDSpmGAuh8O79Y38+BgIwgAuPDUUKLFpj
	PTM8gV7L7PcaTODil3vn4CzgROyHG+5UujJf60WmHXJmYnxVHv2OZS+mIYsnByxS
	qPgXQhEL+lkJu6EYI4O59wTtG6bH7nxKZwyBFQeafHe92VFlUXfZvYQyQ==
X-ME-Sender: <xms:X8I3ZdhARG0oMg5nNgQZg9QtXHHP5kgxutx6xP5E2DMndcCRj9dYfw>
    <xme:X8I3ZSDIZzfy5RYna5OkdHuZPpMMULJXLrx4KVakH4EqWfI9Q5XEsLgFfOoMVOk4f
    G0q8Lmvgw0Fx_aVVQ>
X-ME-Received: <xmr:X8I3ZdFN3Ql-lfzuqvVR89G6rF923-jbfofMNQx4GEX_AWhx8LW0CFO0HJebzuVTm05wf08XT3N2n5u5Pk8-fWKaTeUxyny1rGCe6xIMe0NEC_8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:X8I3ZSRUs0ZijPcWQIJ9rxsjWL7BxNxFNCZ36Gq8l2FPuyZldWzcTQ>
    <xmx:X8I3ZazvZj3NcJ5DIAMetdYlV9O96O-99ujC2SF5dyZF0y7UQYWyJQ>
    <xmx:X8I3ZY4wnzt4rgdMrKGqjMpRdBjsAWS4y7cgI1tFo1Pe1Q35W-SnGQ>
    <xmx:X8I3ZV_Gxw2kLqRuGWwkjSUNlTrGDBQEqHwzqCQT6apSqosL7OkkoA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 09:10:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 786e3b97 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Oct 2023 13:10:50 +0000 (UTC)
Date: Tue, 24 Oct 2023 15:10:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 04/12] builtin/show-ref: fix dead code when passing patterns
Message-ID: <29c0c0c6c9728f286efd0b78996f9a1394957862.1698152926.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8gm8JLQIplNDaFK0"
Content-Disposition: inline
In-Reply-To: <cover.1698152926.git.ps@pks.im>


--8gm8JLQIplNDaFK0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When passing patterns to `git show-ref` we have some code that will
cause us to die of `verify && !quiet` is true. But because `verify`
indicates a different subcommand of git-show-ref(1) that causes us to
execute `cmd_show_ref__verify()` and not `cmd_show_ref__patterns()`, the
condition cannot ever be true.

Let's remove this dead code.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 761669d28de..eb60f940a3c 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -182,11 +182,8 @@ static int cmd_show_ref__patterns(const char **pattern=
s)
 	} else {
 		for_each_ref(show_ref, &show_ref_data);
 	}
-	if (!found_match) {
-		if (verify && !quiet)
-			die("No match");
+	if (!found_match)
 		return 1;
-	}
=20
 	return 0;
 }
--=20
2.42.0


--8gm8JLQIplNDaFK0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU3wlwACgkQVbJhu7ck
PpQfbA//ZAb6n8yX4V0waaXnFbxKoxrgpahMrxBhq6b6Li9Y1BfnjiYNLqGcLd0R
Wl0KIoYlRxl8Y7s0pX9svvIrF0WdkfNKUCuu3tKK6dcnFFA41yI+631HlwUJ9c+s
4coNUVof9vM1JLGVgOynYtFEEzvwPRBur+QppRwr7SM2nhA/c/B7yZKlWLyn9fE/
MdCxZyjJytDzp7rPaWiO8kImoPp6PANkYQHHMYLEdFYjztbmtPs4PYf8BVRQyvwp
dBuFLr4KIx/uup4KdxH9VGwYrA75ivifCIZKSXiBggGUmc9TLi+MtG4e0+whOJ4z
KWYhI3LgYS0y1Mn1idp+CIGGyLdiePBWV66FRHfXqjxD46hZhgXp2Hcv3lNH42r/
g12He75VeHJc+w+ue2J+7Xql7bph5xbiwv29WHYQ4XmbDSEk8VKNlcfyIJ+/83+2
hhGe5Ppg7y2oJny2PiNDGaDYBr8+SyVQnNJzXesAwZ1mnuKYLzcmupcJZL2o7qrX
30tCbaZZuWLLhN7XMqVPTLKSYkZBo312+T35kz0rCdHlP1RVk2eKyzuTl8LzpFeL
io+xE/JZY4TOeT9zE26MISTGrMLeWJ3uCkGAtKOCl9B2iGRR717sIfquOsuViyMM
by78Lf0soPp8zNoOff42QTscvPBABE9bOEw+Nlc6sjlklLYdhaY=
=o6I3
-----END PGP SIGNATURE-----

--8gm8JLQIplNDaFK0--
