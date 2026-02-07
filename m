Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890D2352F8C
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770476837; cv=none; b=IPktTNpnmQi+o+hfl2HjOm2MuCZsF3b6PsyR+xAzKQANX4PIg8F0qfXaB3HDXP0qaIDU3/64wskmIa/fkMdpX1t9iEQC17Jw09IVHqp4Jf5yROd0CtIrmE7sPciyOeCc7d4aQIslnMgZPZ+fCRFIRRu43LK2wOU2m8JISFpWFAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770476837; c=relaxed/simple;
	bh=a7mwJYVq9bZeW9gnEoGOwytnJAJMLG2+SajreQZc2mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HGxEX4h3F+bnMqpM9x4hfpBO+NPRk/imeZVDnI6g6a+X7pdvX7U+ilfiJLk+xVCUMvNFnCbljXrSUUOH1TGMG8/aqj07dyuaN3W2Pxe/ZhGadd5Zfe3lGIsut9UCzrw8Ewll9CpD9YcaleDOy6/LuxmbTY7nqm2VQgx6qBwnKHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=mUFu1u5n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MXIWMCxk; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="mUFu1u5n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MXIWMCxk"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D7F29140017E;
	Sat,  7 Feb 2026 10:07:16 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 07 Feb 2026 10:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770476836;
	 x=1770563236; bh=Tq7b2IeU6z3eGR7oqiH+vAT+Uljr3ctDD1qh/LUAyAs=; b=
	mUFu1u5n1b2UtYY8JJqIOxwR9u7zg3BektqCzy4BxXVozrLELt+t2OOaaCkhBRJM
	XJqZFPcVXN3t3jP03RCBKe98twiahLNsaRCs34Qd7K5xwD56U5jCIM5kzA35i4r7
	mLXdK+xhcD1bSKl616rVLIbCz433keFphBpPUE/+w/sy0KtmpZuQJ9C7ru4zNywC
	QS2PaPB3gp676ME6z2y+ssJeyW3WXsBsYPjzQLthann4azpKKPKli7ZjHO1rCNGR
	XGKSnd9FGpJ0UaGfF8q/jwG6jqvahjY1Z/ImX6eCSP/ycRRC/X6902stGR4Zv7n9
	QxFgoUYU65qr2wKI7+vxvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770476836; x=
	1770563236; bh=Tq7b2IeU6z3eGR7oqiH+vAT+Uljr3ctDD1qh/LUAyAs=; b=M
	XIWMCxkb8P4xcjwk6hVuH7Ag/XqqQsYv2wOHcqON6Y44P/1SujycOqBOUqQrsRev
	Kf2Vy2Dis4lxRBDTIFyJHIWh8a+4RLfCe1y+DMPiuIGD0wb6ixPQ5DlBAcEW7K60
	f4aRr0f+bUdLnBle8MKF1gT2iWhX5jy+YzjpDcw3MRuPR3/DIxEW/lVPDyS7G5GE
	+RX6K1xgoWc4MsoDNO3rW6AF6JT8pp2xr3j+b9IGNSAAo69fjI5MGaMt70dA9N63
	VQ72bXLApuKghFIUyfZ8k8Wd8TUbGuvZYdXl2aPPOVS1ZM+tBB646o/ryRaaLETr
	DryGMl9tmRsXva+w7H+uQ==
X-ME-Sender: <xms:JFWHaeYjZCojri-Az20EW7D1i6GnLAzG6il0rrDxy8g4SDigXdrhvcY>
    <xme:JFWHaY3kvUKBLGAa8Kj9-SRsO-G8OG9Oo5rGph4WzRKBORsHLTaSjRrKMBQ4gkWrq
    82LGwDANdngrrHMa4D84aGiV1wI9Na9mbnaSb9AVS0H6KPYqPahNA>
X-ME-Received: <xmr:JFWHaWUGqzIo5wue-MJ1VBgLcRcbOM0TTpFnx7RGNj65mnqEYoZH2c0P4LUFSiM8y8henYuevye0bTpxNY6KKuyVy1IjbmdnpGr4EcPyrVM6b8jyg70hqcGKFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledufeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfejkefgteelteejhfetieehgeef
    tdduudffgeejhfektedugefghfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepthhorhhvrghlughsse
    hlihhnuhigqdhfohhunhgurghtihhonhdrohhrgh
X-ME-Proxy: <xmx:JFWHaaX6dp6pnxqTsXEr5HVVGko5Q9MFZmF_1eE31_5p6XH73pCo7g>
    <xmx:JFWHaddxVu4m0kRQD6iRlzmIsFFZYA_H3l7WXnF808UazPtEg7EAxQ>
    <xmx:JFWHabUj25M7Y2PjqfapDgz1RrwmN2ck7G20Rod0_jY5z4PGHZVhGQ>
    <xmx:JFWHaefbESVUkG8FFm04l7DdCl_brN7IvfCSUY3Ba_Y4Go6zMSf8WQ>
    <xmx:JFWHaQ3h1AAllQ-WxBXPfA5Q7emfyED_M_aiW5Le3YLMX-L7c4duWT4Z>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Feb 2026 10:07:15 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/3] doc: patch-id: see also git-cherry(1)
Date: Sat,  7 Feb 2026 16:05:28 +0100
Message-ID: <link_git-cherry.278@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
In-Reply-To: <CV_doc_patch-id_4.275@msgid.xyz>
References: <CV_doc_patch-id_4.275@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

git-cherry(1) links to this command. These two commands are similar and
we also mention it in the “Examples” section now. Let’s link to it.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-patch-id.adoc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id.adoc
index 19780f86425..fb9ec211bb6 100644
--- a/Documentation/git-patch-id.adoc
+++ b/Documentation/git-patch-id.adoc
@@ -106,6 +106,10 @@ join -a1 "$for_branch" "$for_upstream" | cut -d' ' -f2,3
 Now the first column shows the commit from your branch and the second
 column shows the patch ID equivalent commit, if it exists.
 
+SEE ALSO
+--------
+linkgit:git-cherry[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.53.0.26.g2afa8602a26

