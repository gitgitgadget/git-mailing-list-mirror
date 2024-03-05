Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EFE12AAE7
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 20:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670671; cv=none; b=p1s3n01Jf+cr4j/xs3PqxUg/nGdSYtidRQJCkMShm8QEhtEWPWZtiLq1XFkUooLB6ojibOn5MExh/eXS/nTk2rK796SeXbUdGcVFINFotoEU7rYT6fDhoCjtEp9ppqW+teRLDqYRa8le0BAP/Fv88RQV5d0rGWCtuztrzTp77n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670671; c=relaxed/simple;
	bh=OPuHY3s8S3g7HkDyC8ZNshvcrAeKJBfiuK1kJ4+7vSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0yotBUi6H//EdmHQdqqgc/vecq73nELW6hU8mJG3ntLpVtvxY/Yps24IzB5HQMIzWASP6Qm45kxhwFo7j/pKqcNnugUzmbvnn2rUQ5TWBCCYhI4xXLCd4CF4Ke/YBUxxgGbFv8oba8ZvBeRWWZhQveCPaSSPu1Zn2peuxaqFOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=Sr47Re5r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZQqwjA+J; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="Sr47Re5r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZQqwjA+J"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B629811401BA;
	Tue,  5 Mar 2024 15:31:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 05 Mar 2024 15:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709670668; x=1709757068; bh=1M6zcF2NpvZ2AC1gD4/ZT/EA5A/b/k9S
	IfK3liD0N+4=; b=Sr47Re5rsURbWJrkBjdCOmv/ugLwzJB3uB4HahsBNWEV34G6
	63yD3zNdQSHBI6ULgPLqSgxOLdaEzzlrnwayvk26lCgfi9ZgTLbDYpQWHRfsDYv0
	LFUNWNVhAUFLAQlVysCvO8lrN9KN7gj8/ArXPbBF84ct7oGigZt1Rt/376ljzDEz
	E9yZXIr0SEbL7uz++aKMamwK+bm/N2bv9tmzZzqw4UK/NshrlZWKXkb1ZrQd53o8
	x8l8EtoD4m42llcOOpIH/QV+IiIL92QmlfJoh8eJu7fTanN28r/XnEdg92bPDhyd
	GfUfFXPtm6QiszWknESGp8KeHdOle8JABMlamw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709670668; x=
	1709757068; bh=1M6zcF2NpvZ2AC1gD4/ZT/EA5A/b/k9SIfK3liD0N+4=; b=Z
	QqwjA+J23s2rrSkqXehh7WWFzgapTCrmsVm6ugA1TG2vCs6bFSVP0HTDRoVQl9jn
	XIxR6jvXG7XhxVRnXjyOc0GrSwwgvGCvtQz0cks0rW1LvVbPXwI/BZP90CmxWyiK
	EXu/SZ1F4WsmjmR/rUS1Zoh6rTcWmMkLMSpvkl7Rpzjd1rSuivbzdCWtvrF4iDIb
	8wSDJdmOzGfER/m8lI9SWAHOjK1LzYPKdu/cUvtnsQatSe29p9TV7J0m+Tf12MzW
	jz5s8e6rPo7eFqYQWtgXjtWMiAIjNlb6DFTL8Gan84/d+uNInE/XGf5TD70QjXM3
	Xc7fZoC/HiBCQNsL7YT5g==
X-ME-Sender: <xms:DIHnZeW1qBaqEeTGGnLDSbRiFYmZn_-j0gmJ1kWFWCG6lu4n86vcRI0>
    <xme:DIHnZalMU8Y4wfml9O0XffrgyMg3gsiaJTmrgcicbeRM3S_mnaf2H-m6OtGpr3G6H
    5emYtRMrOH6j5IZiQ>
X-ME-Received: <xmr:DIHnZSbSg3lw0lH1esXbnBtIYJy4zoiRowEkN_Lw54l3qjMK8ocnDwnGo1z8e6O81PvGRcw96XzwG4rO1bpcW0PWu7mdBwgtFjnSZxk9dQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgf
    elveeikeegjeeikeeuvefhleeiuddvleegfeekjedtkeevtdetgfffveettdenucevlhhu
    shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:DIHnZVUK2h_j6HR3Ioxe7nE3Wf7NtSfhHwuC2wyn42wj8kqOCur6ag>
    <xmx:DIHnZYmIvu1b-1ay3JlBUtGK01b0UAPrYzYIJ__qlLa2UAA8v-9XDw>
    <xmx:DIHnZafU_ZW8FGbnJ4Bng1g9TraVSXsHFg6Z9FoC0i-TrosiKE5BSw>
    <xmx:DIHnZdy99Iv_5YWPQRzTM2CBT62VTZBUyyBaq25Tgq2ouqUxdiq5MA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Mar 2024 15:31:07 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v4 4/5] advice: use double quotes for regular quoting
Date: Tue,  5 Mar 2024 21:29:42 +0100
Message-ID: <15594b2a3a89203461c3791fdbe8816945f86740.1709670287.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.64.g52b67adbeb2
In-Reply-To: <cover.1709670287.git.code@khaugsbakk.name>
References: <cover.1709590037.git.code@khaugsbakk.name> <cover.1709670287.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: 15594b2a3a89203461c3791fdbe8816945f86740
X-Previous-Commits: 3028713357ff77f33c1f96b05b566279683808ac
Content-Transfer-Encoding: 8bit

Use double quotes like we use for “die” in this document.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/config/advice.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index c8d6c625f2a..dd52041bc94 100644
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

