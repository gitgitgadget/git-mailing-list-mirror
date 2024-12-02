Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1301F9431
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 07:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733123244; cv=none; b=F8a+TV0dJNieXxRyeV/TddLspvAsCmU52H7tuoh/0ZWDMIKCMDNocFZMTJSNV6yGA/AlZZvFUrlxUHWqul1WliFp41xUhZk3OUXr9H3VbAE8LpxFLTjMgVQDvE+fHx0FziBteYG0w4ZYmH7toIdPeBJyL8kR4AJz61oJQ9llyfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733123244; c=relaxed/simple;
	bh=v0G/ZNJSG7exPXBSjunJUykDTcAZaGfHF4aSEqhA4Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHX2Bw0mVTpswtu2Y1ZlvqzgyL45yAxbXHoFRplmIlNWybWuSeCCTL4VE9vIsrlXFQ7zyPJUEUjdRHnbD8cASrLY+Hpn6zeLjOQ/1382kp3DBoyvGQ9tZuOWbpG/Xpwt0j4fEqjcwmPBPTwgl1I7nspLLSgVA40W36TaepZU/t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ELIn6Th8; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ELIn6Th8"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 36CF91140149;
	Mon,  2 Dec 2024 02:07:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 02 Dec 2024 02:07:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1733123242; x=1733209642; bh=H
	7cc+31ra9zvmy7NVHSoKU9QbVjDUHk81ZcfbJaGRtg=; b=ELIn6Th8gI5NXLcas
	CwlwSVNCgrx0BSFNhO9byR/AURHMBHpqcQdtA04bh48UZte7ifQArwLE91aJznQ9
	Sl623p933Si1hsqC6HqbL6MTBPg54miOO+m2LpLo6I8iEhNzfmxtdo5NtBkk89ue
	9wfDdkgOOwWcP1pKOQINy2/n/VK6/C0mupMsBwBXnXuPi4ET1jCogl4UAvhhInWM
	0/zNRWLz6zuTomLfBqM91W9cCuGrblS0+ZUl3ib3kgJ6V/wwyAiQI79yOE9Lsylx
	1LF2p/vcflBDkP0j57IUG7GJ2gzFuG8hGEM+YGPPjYb3nAjS27CGKlg3kF/48dr7
	5t3Kg==
X-ME-Sender: <xms:qVxNZySvehqhsI5YjLvnIukGPA7yA__xwq593pmbIlEViriN_SH7Ww>
    <xme:qVxNZ3wGvXTGfzULWp7jHLzDMHEy_az_zRIuRZvhbBx1Crpt4gUzZg_V7SUQCtjKA
    h9Vm57ng-r7VuE-aQ>
X-ME-Received: <xmr:qVxNZ_2C_wFX9PNaNPWDGpOOWZqB1ZDWaC186f-T-mibPX2TPJwCCuhLUY-OpN6OogVP2zrJdWPFWJw5I_cbkYCxLUwo7JLS6hZ4PRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheekgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedvff
    elhfeutefgkeettdfhudelffduteelfeeiueelhfdvudeiueekhfdtvddukeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithesjhhofihilhdruggvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qVxNZ-B_mdWi8bUPAgFr0p0kKZpO0tXFoPdHKbuTp0rs0yQMC71A8w>
    <xmx:qVxNZ7h2AjpNlB4Eqrc7AeWwj1MNOtdZkDrB_Z0XkF1gYABdL4Au5g>
    <xmx:qVxNZ6p4PGzQXhG-1wSCHwAilhvQBYmpXl03uC3UAK0zuxTUGIQG-A>
    <xmx:qVxNZ-itfYXUyJIrKTJq34cOkvtUDBZsLKH2sYQhY_ZlFynJ8lkifg>
    <xmx:qlxNZ7cRsNO8WIGJuy8bRYMX9HzX0bJHfVjYfTqyJKUfbI30EFgtHp4M>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 02:07:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: git@jowil.de,
	Jeff King <peff@peff.net>
Subject: [PATCH 3/4] t5604: do not expect that HEAD is a valid tagname
Date: Mon,  2 Dec 2024 16:07:13 +0900
Message-ID: <20241202070714.3028549-4-gitster@pobox.com>
X-Mailer: git-send-email 2.47.1-514-g9b43e7ecc4
In-Reply-To: <20241202070714.3028549-1-gitster@pobox.com>
References: <20241202070714.3028549-1-gitster@pobox.com>
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
2.47.1-514-g9b43e7ecc4

