Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4542219ED
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mqvpdfhc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p73LA1JR"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9427210C3
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 06:11:05 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id C6A0C32009F6;
	Tue, 24 Oct 2023 09:11:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 24 Oct 2023 09:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698153064; x=1698239464; bh=hu
	yu/lIuKKxw+SdqzTc16OrSRgOkAN80be/vtGSWqVk=; b=MqvpdfhcClnUoxIkEm
	FSgh1p9tRmM3e2/rjPbcQWBgPEB3lu+sK/X2Hdph10f6NpEQaNPLn5XxFqwd09ld
	ZlO7L1mAWCjpdpL47nZrFobSacPMY1sBJ/JbEcaYiaz+82j4IRU0Pg5lqt96s0yL
	ZUm5tr9s6NEneuPB017zokurio+UKf2S9A+O4jcWUc1enn+LO2lA8RXVi1Ab6HBd
	mluX2kUTUy+CF9aKea/SZcW1fKzeKp9n9MZhMnJFZaGoVwCzOYA3ELHHD5Kx3P+C
	7UP+up5+nkl6YbHsW0PPEknaOb5dvxgdymcH/P9WTf3V7PKXCruot0LVHS1lDmBt
	KD3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698153064; x=1698239464; bh=huyu/lIuKKxw+
	SdqzTc16OrSRgOkAN80be/vtGSWqVk=; b=p73LA1JRmIAkD+x1NksZFnJgh1i41
	tca0X/iYqRtRhT9GQi79vivrEi3MpymXkBZEHkpNDop020P+u7l62b3JReWhxTPX
	o6zwl+Fx0M+SBwKS2cxizRsNyEOkl8f/r1bslqBwIKHu/49ADWgichFXLNOivF8l
	Blp2mFYWZ024guRVj/iPXk6wMnqZ6hyR6Lw94Mp1V9HAySd9mZ2BtT7VBscwPnjL
	sNWMcWl1TwTlfN4G31k6bgoTGhibzP5m0gPsBj1/f/SrnOCdQOvEErxae54qy3tw
	lQBEJBYLAUmCi0560ogzwCQqxkWtt3HfNWZ1zwJlWrrcyYcfDRhy2FOJQ==
X-ME-Sender: <xms:aMI3ZfDj-GUIUwOrZA-euAZk_-YH6KwewsKdxSUTIK_sWXzeB1qtHA>
    <xme:aMI3ZVjJ-JCSaVct7CyLJvNWx5qbwKN2cD1zoloivkVDss-eLkajbxJwrNKbfVmdt
    Lw7hbZvbFhXZe_Dmw>
X-ME-Received: <xmr:aMI3ZakiUyOYKD07KUcMlWAD__rU6GWhDrLm-s94RbeC6CayxQhM1DBWms5kBVDuo_FaHVfoiggVQTR6nEypVbfvKfLtO1Vd50POlIzmG-b5OlM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:aMI3ZRwEOYLqnk2gcMe8PmvC7s33F_xMgGb7Zky9LH_mtIKY1lZ9Bg>
    <xmx:aMI3ZUSsC_q9mIj9T1xj322V9AQ7eeRbn5VRlcA4WmzQvSOf6AZ9Hg>
    <xmx:aMI3ZUYNVDtlx7loVpl3Zja70lZXzq_cds0GoQy9l5PH_JgxOC9bcA>
    <xmx:aMI3Zfd9HlqHEDp00C8Cm8kMLBg3UqlBQSYCLN_iplVPOdXEmZnqJA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 09:11:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7d66287f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Oct 2023 13:10:58 +0000 (UTC)
Date: Tue, 24 Oct 2023 15:11:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 06/12] builtin/show-ref: stop using global variable to count
 matches
Message-ID: <6e0f3d4e104372157da1ebd4509a5a7b0ac47636.1698152926.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="odoJTXR5J/XjpkN0"
Content-Disposition: inline
In-Reply-To: <cover.1698152926.git.ps@pks.im>


--odoJTXR5J/XjpkN0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When passing patterns to git-show-ref(1) we're checking whether any
reference matches -- if none does, we indicate this condition via an
unsuccessful exit code.

We're using a global variable to count these matches, which is required
because the counter is getting incremented in a callback function. But
now that we have the `struct show_ref_data` in place, we can get rid of
the global variable and put the counter in there instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index e130b999c0b..4c039007dd1 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -18,7 +18,7 @@ static const char * const show_ref_usage[] =3D {
 	NULL
 };
=20
-static int deref_tags, show_head, tags_only, heads_only, found_match, veri=
fy,
+static int deref_tags, show_head, tags_only, heads_only, verify,
 	   quiet, hash_only, abbrev;
=20
 static void show_one(const char *refname, const struct object_id *oid)
@@ -50,6 +50,7 @@ static void show_one(const char *refname, const struct ob=
ject_id *oid)
=20
 struct show_ref_data {
 	const char **patterns;
+	int found_match;
 };
=20
 static int show_ref(const char *refname, const struct object_id *oid,
@@ -78,7 +79,7 @@ static int show_ref(const char *refname, const struct obj=
ect_id *oid,
 	}
=20
 match:
-	found_match++;
+	data->found_match++;
=20
 	show_one(refname, oid);
=20
@@ -186,7 +187,7 @@ static int cmd_show_ref__patterns(const char **patterns)
 	} else {
 		for_each_ref(show_ref, &show_ref_data);
 	}
-	if (!found_match)
+	if (!show_ref_data.found_match)
 		return 1;
=20
 	return 0;
--=20
2.42.0


--odoJTXR5J/XjpkN0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU3wmQACgkQVbJhu7ck
PpRBuRAAkiuLVlEGmACiKGFM+jg/AKcwnu7cmyUJFoQDyDpueg4UfiTj9kq47H9T
xrzzEimc3+VQdThHRn0+cLcK0Ne2ECFnBNGhp85KNGwofMf9pzO3LpSmezEChi/P
FgNA8afWKmnUYZ1VLvF/oC30WL3OK4ILz5/v9qENiHIQngPA/sZic1kg7MmRCetE
/zq0n5/8sD59MhPkG5ths7vd1yAxbA0SO7gl8vet9JjiREsR97uVlw5ujb1m0VjL
N294BCZANASnl4Q/jitWxycGf4qC47LAJ+//oiXkID00UfPcJaYwLhfG/eKTu3G0
f/nTcqFTiEH6u7fSofA7dy+6OYENfbvoqQoIwLbQ4zqTtzfvzcN6PbVTKIhi1GcG
uQb1nAq+mdNv7gvlajYsbHaehYzupQgCxcdbaysSYbEGHgF9wAayB66Pi5Sg5PsO
vnrQbaNSPdhM3XhFazmS6/VkadP/M45C/C8b97n5sJtucUgQXx84kiUAmF+FoUOD
S46hMmZijXiWH2GTUGwrYPs5xAgcM0JWK9XZYa9W+8Nu4Asgv+GyL1IXFxcGwZiq
zcsWXZSZVfFq3Ul/XK1Y2AyLeUpkVZKd5WqFmNVhu6TL8tfiNqIemVbOrqO1vCVF
Z0j4uAEU+eRRVAzJE8ayIBE5cO8+4CKOl1EsO98tgun9irVinmU=
=kLgk
-----END PGP SIGNATURE-----

--odoJTXR5J/XjpkN0--
