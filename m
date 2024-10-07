Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A871DE4F8
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332181; cv=none; b=nCWc5Dy7Vn1edU8Eu6WDcpFj7x0q2o67zWZxaZV/Ag3algeAj+rc0bRCKT/kC1Cd9dwBg0+FQV5kpj3PzBC0Ku5ufuRPfyyYN3gxuMnRtv2GjuSieYsTArkoN1oxZIAUYtGC9+n2CeXW1AmzFLR5bP3cflfTypdBhJrHMxvQA4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332181; c=relaxed/simple;
	bh=KI+xg3cph88ddxeR5uF3sIsSTrJMXeQp8smjviiCGT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WT+9kyGsotVaf2RICJAS3Aac2sGqpMMDxpUFLgNqlUg2fCYSpfWWuR2qXmOXoLDHlk2ZoHubMnEbhZQdpMHc5hps797Sf608wZ24fa+l3o2IUKd3pE1tHiSB3J0Jlvcp9twIv+OAx2uicyMhQ3oP2uNXRpEKMobfCy0HHSnv8to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=ddyu96xx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mq+5vNpl; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="ddyu96xx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mq+5vNpl"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 425E511401CA;
	Mon,  7 Oct 2024 16:16:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 07 Oct 2024 16:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1728332178; x=1728418578; bh=MiICQqcYku+4NSVUlpEXFja699ppQ0pq
	K03b9ufm9CI=; b=ddyu96xxN4z0kir0KHxW+4rX2k9GKqlB+xRhd8qOaU2S13I3
	eF/+x5fvA8wkkFgWz5U1PsnKd4zEoxDWDbOCUzA8gl0tPAzmZYYlWVFh19WuJF85
	qmXEQ8f8VVsdhpT26MWPVBVuNXteB/DGaaZPTSMN2iFx/28imzItmft0aaDIytVH
	Y2QBoFwHAL2MvKmt4CSlJQt2B9kT853QG+b73P6ghuF+vlr3otQWdyYU+nrkmmDI
	YgmPX4fkidH/VdXAdEKC8s5B1PVHn8VnaWCmrdyrcA3vo14lzv788nfWGrsGpUhT
	Jp740FlDW+Gl07VnB0YZyd8lcrppZPC1DYyOfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728332178; x=
	1728418578; bh=MiICQqcYku+4NSVUlpEXFja699ppQ0pqK03b9ufm9CI=; b=m
	q+5vNplAuekSwjhe/FM3VHyyTozWKwMzGJXAzSLohVhLXurufcgpRqYn5iMmXQXE
	t+sHd+OnqZ+7Bax/ScpB20DTG2AIf3XDLu85Md/HIW6HUGoWVdeXAsoTnNuuhsoi
	old67bxuQ3hRfaCTRwSiroV/m54ssM+WHOrfJbzEXe6W50YAq5OneyVrOV/pPdX3
	zklLFf4V1rl352WU7L6u5t+8+U5QUcfH8Dw7tZo9X0XJxQ3Nf26julV9TYly2eX8
	89b0CMb34R8WSsV2FhFiAwGGeCcdsQUTVunyovkGoWLGnUjbhwZHLAeXAd/00aRa
	/4pxsQvFb26UwJkoGeZMQ==
X-ME-Sender: <xms:kkEEZ0exvfSgRcC1aKlinpU4j3CnMNuTs9fyzdt116GFud0l6CBExiQ>
    <xme:kkEEZ2NhdOkp8oMhoIib3Hk_FaJq-J_L-ug_kqR6oVHckof3r0Qzx0ib4jfSOkJ-L
    y5mD36PM1JiaGEzjQ>
X-ME-Received: <xmr:kkEEZ1jBsI7MHWD0Paa_wAyOF64Z1YluiwvO0vYxHDCn1K6ztd2cJTmMycR2szVpQVEGecnfYw_84bzHN221nlTp42rWzq0Bz0rt-ILLfs4RBCwOHOiQxTcc4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepvefgleevieekgeejieekueevhfelieduvdelgeefkeejtdekvedt
    tefgffevtedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:kkEEZ5_O-mCDXLTl9YfFejkm5LFyPUnYnON5tveEb86CjjRx04z8GA>
    <xmx:kkEEZwuYRDksqOdd0MAASiOaFfe-_iQvUMzw0Ua3BGfRo2IGQ3Og-g>
    <xmx:kkEEZwE72Te7SUGvlgiOSGxQc-my8fD8knV2Kr4pEXcEv71a2DejbA>
    <xmx:kkEEZ_OWCqic9iJ187C0g4SBdgWdtESTRhSQ3-mSj10s3fwj5kj28w>
    <xmx:kkEEZ8KfcyokchWGCKOF2TyA_i-EhYYBUZI2vmsWKM6r-W9MZCD5Tsqz>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 16:16:16 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	peff@peff.net
Subject: [PATCH 2/3] object-name: don't allow @ as a branch name
Date: Mon,  7 Oct 2024 22:15:18 +0200
Message-ID: <b88c2430f88b641d69e5f161d3a18cce113a81c9.1728331771.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1728331771.git.code@khaugsbakk.name>
References: <cover.1728331771.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: b88c2430f88b641d69e5f161d3a18cce113a81c9
Content-Transfer-Encoding: 8bit

`HEAD` is an invalid branch name.[1]  But the `@` synonym is allowed.
This is just as inconvenient since commands like `git checkout @` will,
quite sensibly, do `git checkout HEAD` instead of checking out that
branch; in turn there is no practical reason to use this as a branch
name since you cannot even check out the branch itself (only check out
the commit which `refs/heads/@` points to).

† 1: a625b092cc5 (branch: correctly reject refs/heads/{-dash,HEAD},
    2017-11-14)

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 object-name.c                         | 3 ++-
 t/t3204-branch-name-interpretation.sh | 9 ++-------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/object-name.c b/object-name.c
index 42e3ba4a77a..56b288ff4c3 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1763,7 +1763,8 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
 	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
 
 	if (*name == '-' ||
-	    !strcmp(sb->buf, "refs/heads/HEAD"))
+	    !strcmp(sb->buf, "refs/heads/HEAD") ||
+	    !strcmp(sb->buf, "refs/heads/@"))
 		return -1;
 
 	return check_refname_format(sb->buf, 0);
diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-interpretation.sh
index 594e3e43e12..7dcd1308f8c 100755
--- a/t/t3204-branch-name-interpretation.sh
+++ b/t/t3204-branch-name-interpretation.sh
@@ -119,13 +119,8 @@ test_expect_success 'disallow deleting remote branch via @{-1}' '
 	expect_branch refs/heads/origin/previous two
 '
 
-# The thing we are testing here is that "@" is the real branch refs/heads/@,
-# and not refs/heads/HEAD. These tests should not imply that refs/heads/@ is a
-# sane thing, but it _is_ technically allowed for now. If we disallow it, these
-# can be switched to test_must_fail.
-test_expect_success 'create branch named "@"' '
-	git branch -f @ one &&
-	expect_branch refs/heads/@ one
+test_expect_success 'disallow branch named "@"' '
+	test_must_fail git branch -f @ one
 '
 
 test_expect_success 'delete branch named "@"' '
-- 
2.46.1.641.g54e7913fcb6

