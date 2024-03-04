Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B9E7D40B
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 22:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590116; cv=none; b=c2jTK42FmHCR6Mm1S/uTbzKf5r0Z2EkKMZB/E33FgeVH5+PEp18k9VRGo7WfOaGgRP5WOggU0Uz4pMpkvigcp2r5pp6QzX96hzN0qHvreKB4X/wJocfEIboaWHHcjg8pSoAhogxP+iZmg6lb6sL8F//VvDBxmnLcnaT5cPnwipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590116; c=relaxed/simple;
	bh=2gPOh2QvE5IUf1qUFFwPGhCA+cP4UYNeqNuhREF6ryA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZcK42mdtQJmdSrvnfyfMyvr3JA27gZhna9ObVH348fUEvAQcRLE05eS/3eO4JEsh7djP8kDpu47FuNQP/AYahD2l+fwqs4Nn+Ag3Tk4IiP6tv3gYEOxwr1ASg+DvixU9ta1t2SVD2CNQU8M9Wj/qBa5HmQRVwyOXUyFsv3Id1jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=mwKheV6d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NAJDMymo; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="mwKheV6d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NAJDMymo"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 95431138011E;
	Mon,  4 Mar 2024 17:08:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 04 Mar 2024 17:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709590113; x=1709676513; bh=vw92IaMYn2wXd7hk3Gx+nyuNAmRZc01E
	5u+E9eaL9P0=; b=mwKheV6dl8wkSN4IhB23UPLdl2/HAhrIrgSfqD7N7aRP7xVs
	xF4a+jaJF1UX7cxaVzKyLRrQosWrPbZ4W59rZXcr/nvuIG7jY+G82+P7OLrsEDbU
	UBfBC3Ev5eeyrNK7hCLqb8pSH5KuRdWlkCreEkUwZNwMrf+lo7k9Oh2PyKydAcEz
	b0QwALhTFb/50BOM0j8s8rp8vs4KYm6OnePBaaKysJfeYP1GF+AGheEa84LkuFza
	Jeai7Wj/rhRN5k4ZO7ZpdiNSPgoXOSGVZa+UM/tehjwg4RDUHtTbuxpwZlC2NrZM
	AOg96H8kfZWw1bLDJE/NCbng0QXAJmNH0XC/LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709590113; x=
	1709676513; bh=vw92IaMYn2wXd7hk3Gx+nyuNAmRZc01E5u+E9eaL9P0=; b=N
	AJDMymo9GBMzzSWxrwDCxdWq7dTX5gYGekJfwJugzlmEt93axOxRusRd0Ew7pGIK
	iFvAiHNfI7TKZB5GX2c949UXNr53Mcz1KHSz2YZsMd992AVNn1Jham1SAMHYJ7O6
	mA1GouMFfRtb+gq8zOE1G1/SlgZJUerFh6dAbvXWgSSuba1bHvz+IjtRklxg70ph
	O0VwJcDOvh4YBN/nIIYytTqnF9wyJfzVSNJZcrMW5QCJVy9F4TdCjww+0GYhM5QE
	K9nvtfHS30o2w5Yl9YVuHXv4k3CLjUBXPtQp8vtTQxR/H7DFiv/6myivmBI9xtni
	BZQ+qdON1im9PXG+mv2og==
X-ME-Sender: <xms:YUbmZYokEn41cAa4yl12vrhQj84uk_BI0H1AofYARKpmMCEbLnIzAWk>
    <xme:YUbmZeqmu514rCyax5fJ6ApZkcJUWN-JEPj8j79egbCVvACBs_4Lmy1ODTDV83PeU
    fmQ7JTaEMeo-ZzfCg>
X-ME-Received: <xmr:YUbmZdOl9IN23wUGmN77lJxN_jx8hO56WAUZc6pg5jJNzwptWKM_ZkXKKnMSRlCSREOGSBYKN32Nn-aZk87UohHT2fVWAIOyozZ7-dUBYfvFlDXWOQ2MPyunPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgf
    elveeikeegjeeikeeuvefhleeiuddvleegfeekjedtkeevtdetgfffveettdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:YUbmZf6YjRlACO72pfCGLdUkPI9ucZJFJUeUpkmhxMVcp3HDvTeEKw>
    <xmx:YUbmZX4cKqOLOJnLfyvvKIc0-PhaLabHHNjdGsWd93mkbo3kRjzZEg>
    <xmx:YUbmZfjxlVc4jYPUuXl6qu9rZV7_r5fa2pSBUYNeuK5qox1BbWpXCg>
    <xmx:YUbmZXH7IE33fLhnwqRvMrmT7kBfJr_OuiXQ4eVA_zieBqXUuch51w>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 17:08:32 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v3 4/5] advice: use double quotes for regular quoting
Date: Mon,  4 Mar 2024 23:07:29 +0100
Message-ID: <3028713357ff77f33c1f96b05b566279683808ac.1709590037.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.64.g52b67adbeb2
In-Reply-To: <cover.1709590037.git.code@khaugsbakk.name>
References: <4ad5d4190649dcb5f26c73a6f15ab731891b9dfd.1709491818.git.code@khaugsbakk.name> <cover.1709590037.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: 3028713357ff77f33c1f96b05b566279683808ac
Content-Transfer-Encoding: 8bit

Use double quotes like we use for “die” in this document.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/config/advice.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index df447dd5d14..c5d3d6790a5 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -75,7 +75,7 @@ advice.*::
 		non-fast-forward update to the current branch.
 	pushNonFFMatching::
 		Shown when the user ran linkgit:git-push[1] and pushed
-		'matching refs' explicitly (i.e. used `:`, or
+		"matching refs" explicitly (i.e. used `:`, or
 		specified a refspec that isn't the current branch) and
 		it resulted in a non-fast-forward error.
 	pushRefNeedsUpdate::
-- 
2.44.0.64.g52b67adbeb2

