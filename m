Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC4C13AD38
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733193172; cv=none; b=Is7n17LbtbtjJkKI+/qoIzmDW16NzHVoqIXNM+gWbjI3BsrrGOxiiPu3v+fvS1AwTMth4grVhcXD0Hlg77AYE9ujAIjV052MWsAl11Ve6uluF+qFmFPFejMususPG1ccGWScdFryEd97Qj4OWIhjtCpDOS9jB7NDJMfXDHoE554=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733193172; c=relaxed/simple;
	bh=42cmiVmJ2K0d25nfhI17rrIc2Y6gJZfhv1IexHXJU7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jt91LEXqBLl1I9QZ6bveRKsYiRcIKLz8bNy6Vr1hAPjRa1Sj31ooZrv9cZ4pk8HdOWWcicnqHz1e+lgcUOwX/1orhkOqfHynLarmPA9wQsNqNypOFTP8TDbFplvmhD4OrsFRKKLZbPa5yNU3xD3oi7zSgcx79+OOIm8rmxNHp7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oYKKTdqe; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oYKKTdqe"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 12906254009E;
	Mon,  2 Dec 2024 21:32:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 02 Dec 2024 21:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733193169; x=
	1733279569; bh=xRav+J4gPScGmszLK3+FdfU3ZpAvkx90FoTezXTODfs=; b=o
	YKKTdqetjRWvqEH7dSMManoTsI8Ap0tIrOhl+rDO2ihpA7oiw6ThR5GxjUFmWh5W
	/TKEojX/Zq3lM9oI4qq9i/m7GnY7qxF/+OBLUnG6dD/32DssKPcCx56HM/ToD/lh
	qILq+sIqDWgAr9p7HlE4IxqOmzeeGXsW+WPoeljt8IsZITvcsmLJS1PCMj1tQW5q
	/vXWWta9tcw9WgKj78Mx82WdBmGE+ON8z+Z1uuqeqrkozk3SGzwopKF5y3UbAU5w
	wUnSVyk9AJ73IXsDOPymvMQK119fnsWohMVZCa8XP5BnxAzmpvxI65+Cps3RPJdo
	LNPLRtJKRE+sR4wEHL6wg==
X-ME-Sender: <xms:0W1OZ44VECrsqxDqjMRtmnY4qsuEsG_NM2W2UfYGv6P-9sCpKR0P-g>
    <xme:0W1OZ57dFKeymhfMdhmt48NzdAi6ONe_qtvCn0DI8Yi_XXL1NAhDivc3EQiYLCoia
    cAYIqzLr8J4MNfkYg>
X-ME-Received: <xmr:0W1OZ3eoBizklJ4K9e5H5lLRYeQVKIGxFLrM1eqBLqt-Rh-vKgym2Z7RQrKC_xQlbOqh9ZDB1ItmYpdcq19w-APv5RChI1ASlDyXJJ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedtgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepuefhleffueegueevjeevvdeuiedufefhkeet
    ffevuedvfffhheeuvdduheejleeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsehjohifihhlrdguvgdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprhhjuhhsthhosehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0W1OZ9IQyH68mjfGpVyBlRbyY2DbVUu76CCcDfgn_qiqWo2YOoNvWQ>
    <xmx:0W1OZ8KZJ5RVi3FM0Q_0CeE8834S1ptN3L7oSHyN6C4OkBcN7G6WeA>
    <xmx:0W1OZ-xfvySxMl2Rp6-PHjdFP3AHAkhgwy1NYGEi4Gby2_3dCoZn-Q>
    <xmx:0W1OZwJx1x2apxJKCAJkdD0s9881cjZgTBFW4Ovj69AnvKo3wpIfog>
    <xmx:0W1OZ2hJfWmyeasymcBMtPcVVIqEjX8rcS6Rf3_TbFnLYyp4vVVHiK9A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 21:32:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: git@jowil.de,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>
Subject: [PATCH v2 4/4] tag: "git tag" refuses to use HEAD as a tagname
Date: Tue,  3 Dec 2024 11:32:40 +0900
Message-ID: <20241203023240.3852850-5-gitster@pobox.com>
X-Mailer: git-send-email 2.47.1-515-g5132b7d2ef
In-Reply-To: <20241203023240.3852850-1-gitster@pobox.com>
References: <20241203023240.3852850-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Even though the plumbing level allows you to create refs/tags/HEAD
and refs/heads/HEAD, doing so makes it confusing within the context
of the UI Git Porcelain commands provides.  Just like we prevent a
branch from getting called "HEAD" at the Porcelain layer (i.e. "git
branch" command), teach "git tag" to refuse to create a tag "HEAD".

With a few new tests, we make sure that

 - "git tag HEAD" and "git tag -a HEAD" are rejected

 - "git update-ref refs/tags/HEAD" is still allowed (this is a
   deliberate design decision to allow others to create their own UI
   on top of Git infrastructure that may be different from our UI).

 - "git tag -d HEAD" can remove refs/tags/HEAD to recover from an
   mistake.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Rubén Justo <rjusto@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c         |  2 +-
 t/t7004-tag.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index a24bfe3845..01ef2a3093 100644
--- a/refs.c
+++ b/refs.c
@@ -735,7 +735,7 @@ int check_branch_ref(struct strbuf *sb, const char *name)
 
 int check_tag_ref(struct strbuf *sb, const char *name)
 {
-	if (name[0] == '-')
+	if (name[0] == '-' || !strcmp(name, "HEAD"))
 		return -1;
 
 	strbuf_reset(sb);
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index b1316e62f4..34d34b0dfb 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -91,6 +91,18 @@ test_expect_success 'creating a tag using default HEAD should succeed' '
 	test_must_fail git reflog exists refs/tags/mytag
 '
 
+test_expect_success 'HEAD is forbidden as a tagname' '
+	test_when_finished "git update-ref --no-deref -d refs/tags/HEAD || :" &&
+	test_must_fail git tag HEAD &&
+	test_must_fail git tag -a -m "useless" HEAD
+'
+
+test_expect_success '"git tag" can remove a tag named HEAD' '
+	test_when_finished "git update-ref --no-deref -d refs/tags/HEAD || :" &&
+	git update-ref refs/tags/HEAD HEAD &&
+	git tag -d HEAD
+'
+
 test_expect_success 'creating a tag with --create-reflog should create reflog' '
 	git log -1 \
 		--format="format:tag: tagging %h (%s, %cd)%n" \
-- 
2.47.1-515-g5132b7d2ef

