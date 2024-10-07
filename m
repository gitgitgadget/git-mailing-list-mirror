Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B341D1E64
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728299484; cv=none; b=rKPUsCFL/aFmc/HuYkcet94qvpy/NQkkncHth6iSNwB+kInYdTsWJEknIV/9+hz1bwk1W13rucPbenkwNppWHEvLyV35U8MeDixz4SKhn2Kj+RqKP2JR2BQvwtKri5wEaDb3YbJ4tVF8djs0L1feEINy32QOT8suXQ/Wc7Ht5Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728299484; c=relaxed/simple;
	bh=z7T7xoWXq2M4qSiCE51WasDvfIciUzjY427JmmJx1bA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gtavw9HGNwIjrx6vsF0HhItGnslTIJRgKLNsRuyVYvdPsntwTsmM6HrQ9li/H+trlFQCwnr8CDV+2UFsI/U8PjGe7buFnHsZH6hYrCedkm9syw6DruHkct6X8HKv9e/aKfKuwBZ+SkEQ/2yUcwCm2xxIX9QDzzvdNT35rJ3Cgk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=QgfqgVnr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b1y3FPzU; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="QgfqgVnr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b1y3FPzU"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3CD2011401C1;
	Mon,  7 Oct 2024 07:11:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 07 Oct 2024 07:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1728299482; x=1728385882; bh=OJ/3R6yOzI9gSJOQV/NlBPq4TFV37j2e
	fSjD5hJhgc8=; b=QgfqgVnr3aczsYHny9TnDIWK/PVX+/R9bsSOBVathr37czGw
	sc1Kjvf9O1/05nyawpT7+BRdbbJRcVtPLLuuCEXWhIxK6wOS4l7ZPSHWHZAVlMF/
	KOt35HwOy30kSgn+PIz+hWIkS+xY/14RjJxp2OotKZVAyIt4sbGb0G2Uukud60Hf
	NfaKuFkft7Z47t+fvFSCwthTT/I64H2m2Cf26Tt8eDbptpUEksRQH5e3yWPpCXQX
	hC/yP+fljM4leGTcfw8zQhaQbPR+WgLOdp/R/3sKz5BqUrGl8JsUITGXAEKdPx6t
	hd4sDTx01mWi8M7eGlxJXiH6F7bYZ+8/XOSBJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728299482; x=
	1728385882; bh=OJ/3R6yOzI9gSJOQV/NlBPq4TFV37j2efSjD5hJhgc8=; b=b
	1y3FPzUQSnmhXab1PAV9aaO5+0TEBJqIahSmKCClEY9BZiFLMcUsTAn2ZXsnqzH3
	5gSxxpyWJR8KIKglIs4/UoTkS3dX2IANCb3roHX4ChE4ELNnCEAWdhkvoPk3NxPS
	yIZDprL4HnLk0Y8JT1hmvHqcyME4RZMigx8+0z7ElhhRJI0DW2a8tFPgtMUraz5q
	aDUA6cRIEsALs8Uwt6DpOLMPV0wPj7Nt8IN3sR6fOvKmAtNiwQmUCILDtyr3AgXd
	oG5Q+UsroOR73a0jKTF/fX0vtNSCnwhlfKnybmXXgYyWDx6D0JlwdvvyLjpXjjjJ
	pRb5EVkctSRACWd1ikaqw==
X-ME-Sender: <xms:2sEDZ_opFyuAj1yDWHToj93MwsDG3OwDEKwIoWg7BWP5ZAk3BjKwkwA>
    <xme:2sEDZ5qXAe9jpHMA5cOV8ZbtpIIYkvWs3OxNEiPy8KZrNLju5hn1HWNJrCp0-AOeM
    DtKGGgW1ah7oCgZkg>
X-ME-Received: <xmr:2sEDZ8NAOnc2bJsny27QIXU35VH0I4HoDErrPWQJeirVx1Tsjfig1I6eVYACaK1lYCSI8CQEYKjVwQwfJqlmeNtIJIgLHJN96tdXU6nQSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfj
    rghughhssggrkhhkuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeevgfelveeikeegjeeikeeuvefhleeiuddvleegfeekjedtkeevtdet
    gfffveettdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghrtghpthhtohepgedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghs
    thhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprh
    gtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:2sEDZy4xpCy_crDSL4JbPFnOT5qpBzZWXidWztALCPfkhheFmcalkg>
    <xmx:2sEDZ-4IxPxrT7iw3oP2dGtlXv1ZX0R0VjS26aDxbzeN4FTunoa_4g>
    <xmx:2sEDZ6g9zN_9wn2WKxk2aG2ssenSk-j-7KnJxNy46Q8V9nbdrAO2ag>
    <xmx:2sEDZw7C2MIRQeGO1TXZ23EbkEG6ADZEHw1Mfh0I62Dy0S8scXA6LQ>
    <xmx:2sEDZ51Eb9GniGfNytVuHSaZVf95uioWwyPFcQldrvyrRvHZOHWWnC_h>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 07:11:21 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	newren@gmail.com,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 1/3] doc: merge-tree: provide a commit message
Date: Mon,  7 Oct 2024 13:10:27 +0200
Message-ID: <fef203471f4492af1468a0c91088324c394effd5.1728298931.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1728298931.git.code@khaugsbakk.name>
References: <cover.1728298931.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Commit-Hash: fef203471f4492af1468a0c91088324c394effd5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Provide a commit message in the example command.

The command will hang since it is waiting for a commit message on
stdin.  Which is usable but not straightforward enough since this is
example code.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Unlike on some other manuals you probably won’t end up running these
    commands directly to test things out.  But you might end up copying and
    modifying it when playing around with the command.

 Documentation/git-merge-tree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 84cb2edf6d0..590cbf5df79 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -213,7 +213,7 @@ used as a part of a series of steps such as:
 
        NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
        test $? -eq 0 || die "There were conflicts..."
-       NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
+       NEWCOMMIT=$(git commit-tree $NEWTREE -mMerge -p $BRANCH1 -p $BRANCH2)
        git update-ref $BRANCH1 $NEWCOMMIT
 
 Note that when the exit status is non-zero, `NEWTREE` in this sequence
-- 
2.46.1.641.g54e7913fcb6

