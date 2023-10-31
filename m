Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63C312B99
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h3HCobtY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dPA3/6JR"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992D6E8
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 01:16:37 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id D1AE332009FD;
	Tue, 31 Oct 2023 04:16:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 31 Oct 2023 04:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698740196; x=1698826596; bh=5A
	p7cqdDZw2sD3iP7Gg10qMzqT2dT1C+DxxFg/eguls=; b=h3HCobtY9siJMB/PkD
	U9UiErhG7xVTq4hBdsZk8oaXi8aMejlxQUoymHVFj4O+uTh77PmFNQ0G4PK1/Zm6
	jujgx2G+1nzi/8C41xoX0wcKJ5yse8MPo7iBcWUS8QmysMFytDiSD2dVOiXjRQtT
	KT+bDTe/gi5ZNy+Tqk9gBFT7lqI///YYlIi8PQAra1+kO9wetfg7dqljB1DKH4z+
	svakfZrFTbI6vHoehoc5Q+fA4IjlM/ajCrIu8zvjCfM4Je7opMZVL7ACVLkj+BE0
	bkh39egiJXF1EvOIMmvhXjHwCJSW4bYvttK9iNAMcx3a7SFJYX0jp6Rww18lfHvl
	pD4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698740196; x=1698826596; bh=5Ap7cqdDZw2sD
	3iP7Gg10qMzqT2dT1C+DxxFg/eguls=; b=dPA3/6JRZqcG/GB++Gae371ttvN4r
	73Yb9GiOttjhbDhGhqtQvQer44hfwuD9xWEp6Io6ySs/FqKjiABpe2pE3B//BUz7
	T7lV5D6MJ3LCAWmrIr0KSF4IbzyFF7XQ6jIhfXXfGp1txmxZbWjBhPpGHIjO9G7Q
	eHTkBoBsJu3xcZEB4mVfcf1vjf+yifbSVK1ZBZIAOEguxZZg3NkZ0CN10Al3MNb9
	tA3In2Via8KvlY70kwUM+ZqAxDe+O78kgUamum2Ywv7KGtifoPtRDpTgjCqkjfTi
	vVX9DvdQpZViIgJsd2+SjuKJBoRuXhGBN45eJCXLPgz5Ves+MkbFiYhbA==
X-ME-Sender: <xms:5LdAZXLBfoI_4cU10OudKKYtBJeh_DRTTXF8cub_E8kruisEThuQXg>
    <xme:5LdAZbLl0uqpvsKjvksy3vyVRABBGMFvUvA18O_ImvFmCeJuxxaRPfoxuAJrXfHuM
    51omzULWDow8fdEMA>
X-ME-Received: <xmr:5LdAZfsQook0Zgw7cknUZrOydAtDVaN-Vm_9deN112fEx-I-_tbdUNQdeLRc5dgBM6lYekFSORMrpSWsbpVwrqqCOTnpo1IrMRrlGkQWpItozw8V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:5LdAZQYpissTtpwarCgNOaCgEme3JNptDYxOXt1yQsGd3zeKXp5YrQ>
    <xmx:5LdAZeafegy8U-7kMP9TTqozkqFLo92T5qVvmXfi2xaVGs7EZX6GRw>
    <xmx:5LdAZUBVzdjNxfAnUjY5nGCvk_LN4y1Kmh6Q1Xyzq8tDsAwGrNTD7A>
    <xmx:5LdAZeEiU3IKQ0YZJ6i6KwVn6AhJc4p9_PxtcSdEP8dLULCghZJeiw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 04:16:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 81390ce0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 08:16:28 +0000 (UTC)
Date: Tue, 31 Oct 2023 09:16:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v3 06/12] builtin/show-ref: stop using global variable to
 count matches
Message-ID: <6172888e46514298ab8ca5a77346fee82c746c9c.1698739941.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698739941.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bR9hl9Tf7HaVT9kz"
Content-Disposition: inline
In-Reply-To: <cover.1698739941.git.ps@pks.im>


--bR9hl9Tf7HaVT9kz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When passing patterns to git-show-ref(1) we're checking whether any
reference matches -- if none do, we indicate this condition via an
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
index 5aa6016376a..d0de69e29dd 100644
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
@@ -191,7 +192,7 @@ static int cmd_show_ref__patterns(const char **patterns)
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


--bR9hl9Tf7HaVT9kz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAt+AACgkQVbJhu7ck
PpRu/BAAimsa0rnWAxeq2fKFNGPuccJ3N7EH7li/eiIciWrSnk91GKQKU+pv6iQL
ru/4pbZyW0EpgcmwukEhLtOq/9CsMc/2jx3kgNXPynQGzAKKBHAYJr/gz/f50Nx3
grJ4j5vdNHbgwLC8htV7x5Two9W3ld0MkZN75mJEAbrRXASJPhswyNnxY9nO0j2g
ZrVzcaWmnC07R8B1a/p6+RnQNyFnkYaqd5WA5xXvYztzZlrT2VQTjrCj/rzhK2/z
YxfQ2Dd2YbqlNtNB8hnkIoEEY3BT+2oPiuCFCCe2nBK4SFhdbt0KHeklnAOOfhZn
XoCF59iUvDZFjSdztKzABJVP3s7kvu/SAbzN2aNmQsX51TWtIeDJHS9dfOGHcdM7
l9i1ibwm+7wfoVFXwvgV+AazJQzBn8WiNB5YQ/slfi1WsOMVGoFj9ECB0w/vjfgj
8pBJIf/FQbAeBa6fxxSHYuh+uTifdU0nzGpaIlp3T9IEwRa4n9GMe2TiWpfI+wfs
G6tkynsN3FfwcChtLCy5m9BNl5BOiA7qTJbl33ca0B5YLPKCpMz1G5TPa/HvrJc5
kjU7DR7XFhTkJnOJy5h79Q8qRyLH6dkwPdwyheybW1EiXAFsN+sg8DLeVWFMiCRk
Ck+MxQcY6A4tBuhy7uWrCKhx+Xl6g0OXmcPFhBWEfz9PyScS4X0=
=Pbpj
-----END PGP SIGNATURE-----

--bR9hl9Tf7HaVT9kz--
