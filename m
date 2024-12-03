Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C06154444
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 02:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733193171; cv=none; b=Ve5nupTJpAdZ3oLtkMV6qTv3os3WDEfxVaHk+dybprrkz09CvOQYD7Nv0n1rT+YBkLFCU7cv317Rjd7sB3aZkGTyzTW9iShyEj1ujN+jajf/qUVkUzjIjDTTt9w6HNNu7xvDUhCdA3Y+lnsNBAMlL+b40IkOoMnX0wOKNPFOcYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733193171; c=relaxed/simple;
	bh=VQ5RoY9Tdq2R16HzRx5gYOGXkanr0cABUGJZfuNr+9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imGj7h6vfMcQtNqE73nUzNqrQs3iq7C7w/rBjbRKE5zJc9wJ0TWCz428Rdzxs2ylAunuP6ILv9WeFckR9O1EnmOd+4QJ8zbeN62jAvdaC/KppakfcCV9LcxtcnJlO5kLXFNWLG2EZR7YBWV/SvyoNM0SVcczkO9m6dg8u8qG+/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TU6o8Wja; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TU6o8Wja"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 0CED91140203;
	Mon,  2 Dec 2024 21:32:48 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 02 Dec 2024 21:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1733193167; x=1733279567; bh=D
	nId2RPYPPPf01k7SSAJVayma3t3yxbZc6rM85LAEKU=; b=TU6o8WjakaJRUnoP1
	iIwjJPxA2nW3oMt6y3dsoMXeplwhoupr+vrIv2+anyu6syRfMlac6+VyqdH4Ozww
	S9/QNYHW0PhuouENMZ1NOEBlqS5tZTBKmH/K5H6+yFrYtR2FGNxAoarj6D/S8cMe
	mVvkHh0CmlW9gJf3DjoApHAJsgfywsToOsvdhO0M25h7NKxYNJHnhxmGHPe5JqXA
	qcreWvliuDbwjIRbfVGLyMqgF4jUtgMMYZ215DKwW8ZCfxzOB6F+4sL+z0FVJih1
	xZNX+qhrgRBXXMTSG4JVWy34YswqJfptMy5cVUMsjSiYH3LbMxwJ7Nf3GtTpJ7Z7
	Ld50g==
X-ME-Sender: <xms:z21OZ0dDBZgRZ83hJmjNJbU2edh4vJzcl22j0wYxbcfFgp6TFvrRGg>
    <xme:z21OZ2OLGVS2daLn8o1z2oec9GQbbKABQJix6I5RwiBmhJlhY2arwUA16iE-mh3d9
    zH_JYVqShSsVAmazQ>
X-ME-Received: <xmr:z21OZ1ijvxLSne2yraHDLsjFxm66MESnHwg713VO_7nYYRfJrhSkNusANv6uqkjjUfeXWTDNnExtZ3Cb4PujfH8jJdKxRd6-4pZH2tc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedtgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpedvffelhfeutefgkeettdfhudelffduteelfeei
    ueelhfdvudeiueekhfdtvddukeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithesjhhofihilhdruggvpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehrjhhushhtohesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:z21OZ58IXVL0XoXtgFH1ld6munfaahX0dBisVDn7T-1949L2SRI_cA>
    <xmx:z21OZwtKM7jFVHzz2LYfPZtYWnfaYaorjCRdlaoDkPgmFBBPSqsbQg>
    <xmx:z21OZwEFZ8-pkYtnsH2VLuwQXs8E17Qu7cma_5ktWgLFyAJZZ_g4Yg>
    <xmx:z21OZ_OY5cpLbFjQoZG1kXfsOHQFewq-jnoHV14kb-FXe9yRpql0iQ>
    <xmx:z21OZ6VHL_8O2ePsX4qwnVWz_T-iXIgkLO8KefH16_jIwlsP-9MhkUws>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 21:32:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: git@jowil.de,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>
Subject: [PATCH v2 3/4] t5604: do not expect that HEAD can be a valid tagname
Date: Tue,  3 Dec 2024 11:32:39 +0900
Message-ID: <20241203023240.3852850-4-gitster@pobox.com>
X-Mailer: git-send-email 2.47.1-515-g5132b7d2ef
In-Reply-To: <20241203023240.3852850-1-gitster@pobox.com>
References: <20241203023240.3852850-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

09116a1c (refs: loosen over-strict "format" check, 2011-11-16)
introduced a test piece (originally in t5700) that expects to be
able to create a tag named "HEAD" and then a local clone using the
repository as its own reference works correctly.  Later, another
test piece started using this tag starting at acede2eb (t5700:
document a failure of alternates to affect fetch, 2012-02-11).

But the breakage 09116a1c fixed was not specific to the tagname
HEAD.  It would have failed exactly the same way if the tag used
were foo instead of HEAD.

Before forbidding "git tag" from creating "refs/tags/HEAD", update
these tests to use 'foo', not 'HEAD', as the name of the test tag.

Note that the test piece that uses the tag learned the value of the
tag in unnecessarily inefficient and convoluted way with for-each-ref.
Just use "rev-parse" instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5604-clone-reference.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 9b32db8478..5f5c650ff8 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -131,7 +131,7 @@ test_expect_success 'cloning with multiple references drops duplicates' '
 
 test_expect_success 'clone with reference from a tagged repository' '
 	(
-		cd A && git tag -a -m tagged HEAD
+		cd A && git tag -a -m tagged foo
 	) &&
 	git clone --reference=A A I
 '
@@ -156,10 +156,10 @@ test_expect_success 'fetch with incomplete alternates' '
 		git remote add J "file://$base_dir/J" &&
 		GIT_TRACE_PACKET=$U.K git fetch J
 	) &&
-	main_object=$(cd A && git for-each-ref --format="%(objectname)" refs/heads/main) &&
+	main_object=$(git -C A rev-parse --verify refs/heads/main) &&
 	test -s "$U.K" &&
 	! grep " want $main_object" "$U.K" &&
-	tag_object=$(cd A && git for-each-ref --format="%(objectname)" refs/tags/HEAD) &&
+	tag_object=$(git -C A rev-parse --verify refs/tags/foo) &&
 	! grep " want $tag_object" "$U.K"
 '
 
-- 
2.47.1-515-g5132b7d2ef

