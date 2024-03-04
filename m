Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9383C7D09D
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 22:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590115; cv=none; b=EAlJeZa9w0CwWWNY0Jsamu5CFElk46V8lxmB8PBQ61O4bfFxHZjyAo7kgGn9n7g7R82LMF11Tf/TdQOoYEDAhTrgS33ZwqT+44RGenXWecjnYkLNB29i2hcO8jOEq47eX8pXeU+6aS9sVKOfZazF/Fp8eZIAwMfqvA7OFwu6Edw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590115; c=relaxed/simple;
	bh=aEGRJDsDr/QvOgPnMYYoUbwUkEVdUgVmUPbtIGsDsBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1hLBiLNbxpJ+Ki0IXCf6JL2IBNM5xh6KJHBhBxV0TTf0YWDUYBSaCmeu2NvOQz9HZ1mjR1sUupct2pPwd1U/zdqZu5rIwe5+91cXo88ihJlOS72sayXXj/YZ3BPID2ZvXQEsc0gIOsNwymb9VE+llps+PQjS7kUUCLb3m/cfns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=VHn8zOjz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AWMKXuUU; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="VHn8zOjz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AWMKXuUU"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 53DE85C008E;
	Mon,  4 Mar 2024 17:08:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 04 Mar 2024 17:08:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709590112; x=1709676512; bh=UFvKzgrv2Po1QFhJzcdWMT/lVoDh/GHS
	XH49+jaOxw4=; b=VHn8zOjzqX3uBNhplHY4z3HohB1zeh1weBptR1yMHoBr/RLy
	cvIU00zAAzshWMOaBGAEzY/Xo16gDhmyjj7IOzJnZXL6UYdJqhSHoylN7n4fADXL
	qeodHuIGU7PaPjL4p/qpzVQFfFQahl3rxM082KukKxq1dwZB2x43X+NKt9+vUDBj
	A7h6G4sMvv+mrBcrdvyHqHaT767F74G4gB9/uvaYKPZSvIeBf74UO7Ayt4exeUqs
	8uoyFISrZiS7TibloJ3iN5jE9is8wMjIqueo1vNzm8Nb8gwF2gyCjNLS7FDx/V9V
	z+zQ9gO14pTDbPyB7lWjux1YDutLwwTaltZk1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709590112; x=
	1709676512; bh=UFvKzgrv2Po1QFhJzcdWMT/lVoDh/GHSXH49+jaOxw4=; b=A
	WMKXuUUDZS8mFAcpDd4WGEe9XTz9DTrhBdNtRJglZTiBkt/yk+lWpPigGXqH/OpM
	y5lERNNNhj1dOBfTryA7scIZIJKtBu7shCwIQTR1gfEDM95MCUHZGsN3K444RuJZ
	ViTi3GYYSuK/CyDwJU8mYGKZOI01bA4iglvUiLHYpKBYVFsjnN44GW2qlVCaPkMu
	D6/857R/N/mxjhcI70nWsZgsLRneI6J/d1QTc+R4bS9TlGbZ0uZ54MOdtG8CYP82
	or0FNxVxVlIaAXItxPVh8PsMIlVlFJW1JLX/IevpFr43jhXPiO4YleuBAx46j8lR
	mD4KiwNBaNFET358RZ76A==
X-ME-Sender: <xms:YEbmZYJKY7JreKsUCMRxCAYA6jJJyYIVQq_omnPY2-XHKUjZbHwgvsY>
    <xme:YEbmZYKhBd2uwHC0bsoJzRwXJ5fzUYxrMPF8pQdo4EDO-VuEMPv2-p6uGmdxHasf4
    3Zn7rDy5hBn_Ri4AA>
X-ME-Received: <xmr:YEbmZYvouMEGtVkX8g9tP1PFG9fy_RCJ7cfagRJWw2-mppujz81PYcs4n5Y2guichodGEbu-ROJ6RHVkGYsHuHghLUbRdjQngPicbg3-6Ex8vE5PTeRy0UaPgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgf
    elveeikeegjeeikeeuvefhleeiuddvleegfeekjedtkeevtdetgfffveettdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:YEbmZVZRr8t67lyw9PlinNfjAIz9bVn7XYAvWWztX2-WoSb5DDrBmQ>
    <xmx:YEbmZfapRAjmfUHsI85ZtOYm_KIOBqiaz5hLgV0LwLVT-v_72BSXCA>
    <xmx:YEbmZRD-nblCS6MioUJ9Boa0wmTG8xtkr9sPtfIItScN_SJ4ZRIVPw>
    <xmx:YEbmZWzx4mtAww2y0EN-7tgswPxFNrvGkaELi7UucF7cBIsXlxUdlQ>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 17:08:31 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v3 3/5] advice: use backticks for code
Date: Mon,  4 Mar 2024 23:07:28 +0100
Message-ID: <30d662a04c75b80166db9ef94f95e8a841994fb5.1709590037.git.code@khaugsbakk.name>
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
X-Commit-Hash: 30d662a04c75b80166db9ef94f95e8a841994fb5
Content-Transfer-Encoding: 8bit

Use backticks for quoting code rather than single quotes.

Also replace “the add command” with “`git add`”.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/config/advice.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index cfca87a6aa2..df447dd5d14 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -2,14 +2,14 @@ advice.*::
 	These variables control various optional help messages designed to
 	aid new users.  When left unconfigured, Git will give the message
 	alongside instructions on how to squelch it.  You can tell Git
-	that you do not need the help message by setting these to 'false':
+	that you do not need the help message by setting these to `false`:
 +
 --
 	addEmbeddedRepo::
 		Shown when the user accidentally adds one
 		git repo inside of another.
 	addEmptyPathspec::
-		Shown when the user runs the add command without providing
+		Shown when the user runs `git add` without providing
 		the pathspec parameter.
 	addIgnoredFile::
 		Shown when the user attempts to add an ignored file to
@@ -75,7 +75,7 @@ advice.*::
 		non-fast-forward update to the current branch.
 	pushNonFFMatching::
 		Shown when the user ran linkgit:git-push[1] and pushed
-		'matching refs' explicitly (i.e. used ':', or
+		'matching refs' explicitly (i.e. used `:`, or
 		specified a refspec that isn't the current branch) and
 		it resulted in a non-fast-forward error.
 	pushRefNeedsUpdate::
@@ -90,9 +90,9 @@ advice.*::
 		refs/heads/* or refs/tags/* based on the type of the
 		source object.
 	pushUpdateRejected::
-		Set this variable to 'false' if you want to disable
-		'pushNonFFCurrent', 'pushNonFFMatching', 'pushAlreadyExists',
-		'pushFetchFirst', 'pushNeedsForce', and 'pushRefNeedsUpdate'
+		Set this variable to `false` if you want to disable
+		`pushNonFFCurrent`, `pushNonFFMatching`, `pushAlreadyExists`,
+		`pushFetchFirst`, `pushNeedsForce`, and `pushRefNeedsUpdate`
 		simultaneously.
 	resetNoRefresh::
 		Shown when linkgit:git-reset[1] takes more than 2
-- 
2.44.0.64.g52b67adbeb2

