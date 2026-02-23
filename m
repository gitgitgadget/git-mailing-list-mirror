Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADECD37B41C
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 23:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889499; cv=none; b=hjC/J1L2mgl/ulw7jRWQLeEW1HbZJd7uL8D5997XXJgCPhS6kxbFPd0uyrkIaNx2H1g7R8jAuxfo3u7WZVXsX4R1gxtBHVVvbyzlSxIss0oehV2BUK+3JhLfEgr8fFhgChzNsNNHMn+C7GWg50wb/I4AFQd6ZSu9gqXxKcTw/z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889499; c=relaxed/simple;
	bh=5dbQTJed1bDpht5lf3d5Ihe7Ozgddi4e3hXCdIvrcwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WB+UQABc8wyDu/Yg78CR5PUB5dPRrpcc7Z7PkbasUWEsAXAftahOl/OPJ5HfvHg5O7QV/ym+V/y0sIqeocm0D6IIaaryaJvWo3UeNuLOVjFhzNMjRMOdEkSo6CFT9WLQXPzhKQ4zWM0HmN0VcgtMqmQLOQx4lsWc4qWuRZZdBvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=h26IeS/q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E1o1b88u; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="h26IeS/q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E1o1b88u"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 07DC6EC0476;
	Mon, 23 Feb 2026 18:31:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 23 Feb 2026 18:31:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771889498;
	 x=1771975898; bh=nlfuPTSni2Iz88tcVsArTwQPDL/YP/128rUnlC3oMts=; b=
	h26IeS/q78EKJ9Ia+l/LINNB9abUv58bG1jEdR29/azxQSi1xBEh2m90aGh9IcH4
	F3BtjaQdCJEvSVdYCAbpb47rXLYIXUQxOZSHRM4YA2SoZllNlX7uzcKWKWcn7Am3
	xyyXz29IXpKSp6nu+mwz1qCLFiE4mgMBKmtO8C+/DX/w3C+MZupI3dTudItwK7K7
	aZYMVvfnM/NaCzyXf3PKt5s/H7nlj+DB9s4oP1zYxqQtjyXopdqc5RrpnYA2tngl
	Bb62hu9RxcZuWsNVgmN4Afx7TFQpoayCkKgVKtTGJeywHVHy17z9Hv6C3ucP/086
	4vKWA7qsRKRO4IXnqwkTsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771889498; x=
	1771975898; bh=nlfuPTSni2Iz88tcVsArTwQPDL/YP/128rUnlC3oMts=; b=E
	1o1b88uld+9Jx1KEk071r+1kqPAyBPlLhAT2cxF86gJgT6qzxt9gBtZEmGv/Mvvz
	py0PRliaAGHZNp/PHuVvmw4ha1U9ko69bm7ebCpjUvUMrmTrn2GuKV81qt4e88AR
	BGaIhndcBI/FOFf/APxRUCCno2fKILDZncYJGvm16A48pEWDZKHf/2pij2y0+ang
	Inyx2l42dliMdfQsORGyu9Oux/rhsuIdwSyeuOGvIG/THVfc/oyr5I2+lBzlXTTA
	U5rzR+IZ43GuhxY1oSwSpWrGVEB8hzfvoUWwVke87iyTFy0b0WZftuAykFQ88SVi
	aHkU9g7YxvyQeBqisSnGg==
X-ME-Sender: <xms:WeOcaRxCVJgHLqngsNkmVeI6U_V7PwWRjI2mKvEs9cNITiewe5c2G-0>
    <xme:WeOcaYtF53owbZ1I-oSP23rsje2KZY3NqbaFVkZVstIeLL7VqxPD2WdbM3MjAgmjk
    gyca3j5lz2Qte4xSE8K2Sz2qug7ginj_7RDBSwrltnFcQTv56-qzw>
X-ME-Received: <xmr:WeOcaYuGlfdenudSz4rwIQPBCKOlmhH7K2ql8EvSjGCF4djOvxEneYpGzpHU3bTDUi3gc3F5BtmA7yqh-gpGEAAYWfQIqzxHGsFTzBQXNoGUT74IMjRg9UYUtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeekheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffgge
    elhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfeknecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:WeOcadOueTwLixxgTAUscUmgCXziHb_nfEm_FS18RyvwZ3ulxJ5OjQ>
    <xmx:WeOcaW19xqFr595DNaemDkRRQ9OE6ES7HCzGbVdlcwmEoB6qmsQ2gw>
    <xmx:WeOcaZPWQGfIQYuXBHDGy5IwbE11-MDLgeRtfBVsGAiINgDzCUZYuQ>
    <xmx:WeOcaW14uu5Uy9Ul-OJV38l8PATttmMsDYrv-Yz9EntnTKj3Tg3JVA>
    <xmx:WuOcabddsuabjCOEUlWGrcmLoisixpumCmaQOSMRuU-XA_hJHZ4-KrOa>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 18:31:36 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2 2/2] doc: diff-options.adoc: show format.noprefix for format-patch
Date: Tue, 24 Feb 2026 00:30:51 +0100
Message-ID: <V2_format.noprefix_and_--default-prefix.423@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
In-Reply-To: <V2_CV_format.noprefix_boolean.421@msgid.xyz>
References: <CV_format.noprefix_boolean.39c@msgid.xyz> <V2_CV_format.noprefix_boolean.421@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

git-format-patch(1) uses `format.noprefix` and ignores `diff.noprefix`.

The configuration variable `format.prefix` was added as an “escape
hatch”, and “it’s unlikely that anybody really wants format.
noprefix=true in the first place.”[1] Based on that there doesn’t
seem to be a need to widely advertise this configuration variable.

But in any case: the documentation for this option should not claim
that it overrides a config that is always ignored.

† 1: 8d5213de (format-patch: add format.noprefix option, 2023-03-09)

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    Change commit message. Don’t use “because”: the two quotes are not causally
    linked like that.
    
    v1:
    `--default-prefix` does override `format.noprefix`. See test `format-patch
    --default-prefix overrides format.noprefix`.

 Documentation/diff-options.adoc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
index 9cdad6f72a0..8f632d5fe1a 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -860,7 +860,9 @@ endif::git-format-patch[]
 
 `--default-prefix`::
 	Use the default source and destination prefixes ("a/" and "b/").
-	This overrides configuration variables such as `diff.noprefix`,
+	This overrides configuration variables such as
+ifndef::git-format-patch[`diff.noprefix`,]
+ifdef::git-format-patch[`format.noprefix`,]
 	`diff.srcPrefix`, `diff.dstPrefix`, and `diff.mnemonicPrefix`
 	(see linkgit:git-config[1]).
 
-- 
2.53.0.26.g2afa8602a26

