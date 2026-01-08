Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320D327CB35
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767853739; cv=none; b=fcYhBsSs6ReVA1QfC9yln/EtC8DycYnz5efxWOzOf9KUeTE3QPBrrwGb+HLZRZ7Pi3nScI9skFFP8n5vNal160ftgPyBxiZRSLqKCeaZ5fAcMnBnBZvSzDQMlCAybCCadwO/ne6tQQhk+krO+p5lIPocha80WIFSGXqWmJovNZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767853739; c=relaxed/simple;
	bh=3SyhoR5/HtFqRJQkmAdGY1ECog+m2jzgPDFralcKdcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0/SzS1r1P19q1doFANZXhApasgheigZhNUQtXlVYDsNfvvO6lLoKufevLdERhwOhAfr7vN1JMh+0JidkNY/X40i3Dg87TCd+KpYoSUM03l8YuX9pruIzb7Vs+DyJrVNcq8I7AHtpPvWQv2FYyQsB4h+YhEPIY7ooGL0Xh7Psg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=idhART/a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aAMmFW2J; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="idhART/a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aAMmFW2J"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 652557A008F;
	Thu,  8 Jan 2026 01:28:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 08 Jan 2026 01:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767853736;
	 x=1767940136; bh=ncdUfCjMGgpbw2QdPsaMg5X6QguiH0f4B7JzGwotpSY=; b=
	idhART/aDovV915ct9HItilzvOFzbCCIYQ3ENyn5rIs4tquN8yxYRNDNQObQz/96
	BP1Ol+ySbZ5sX980ffwgPREERRA46zOCn2a+j30ANP+Dp49fIme69iiGLottt59k
	iGU4B0/MuPVSe02fNZrdLelky2PBzHKMhxpgypchm0BxosIjSE9T3Mnl8girtpkm
	kMyE39So5IztJS1MbVJH0bSZ9OSxS8aogG1TOgP7P6qU4ZCdUV2KHvVRQWjJ0Yxd
	rC1b4txVUxmUyFK8DFwtM0qrvmRymN80PUKL7mdk3XSgqn9A4czbmfandrnfNEj1
	gco2m9Q7SZS8+5ou+/M4yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767853736; x=
	1767940136; bh=ncdUfCjMGgpbw2QdPsaMg5X6QguiH0f4B7JzGwotpSY=; b=a
	AMmFW2JfQ9Ej6AzRu0bdzZyuUFEIr+w37INe8CR3wOxKmSa130Cd1qbVS39KU6BJ
	uj86YhpyRhxlySo946HWJPuX4tfLe2l7nIXOCO+Ym/KZokT6b9bVjThEi+6Clmz2
	VN2s1mdDE2D23LJtRJBccqPhcouRrAUBuWe/9MSgp/26jwEu4CgjMQnbI4XOwlOa
	HreZ/gBvsPXNSpVMgMGKu0i6HtHffPRArzdRphXQho5QPDfqOSD2SKXEvHP+9Cdy
	t774mCyRY6feZ/CoydWp3ya9XXv+XPR8DEUuk+97/bLlVHQyS2n2nIbzP8e8/WIG
	MqhsyptlbD9NSUHlQRiDw==
X-ME-Sender: <xms:qE5faRXATx957rGmFIJa2kLRIa7bqvASWPH0a3guK1gKM_JdOdyHkr0>
    <xme:qE5faXlGdx0TggDtGvSum9rZoMB5gneTjRLtAfHV5DKCBv9z13J5hI-x5d1V8a8zG
    OsxF_L6g9ktsDomMHmYR8wkvvPHfE94GVfva7QUtxpnjjL1veDUxQ>
X-ME-Received: <xmr:qE5fabCt7s7n0Lw0bCdfdy5n0Zes2cQXCwfqaP_gf-MjMq65vLzEiUG3hg0oaeQHeeJhsw74vSn7WyMTRLkg-IHpH6Qvc-JsTlO7JpeYnfZ2nIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdehvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffgge
    elhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfeknecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:qE5fafdcxnH5fVzsj326aYK483JRvFNohfp9RkjDiiuqWOrBI7Qvig>
    <xmx:qE5faeL8dXjG_81emUHwJ5IIuN2LYaXT13DqBqaUtJorg0W-_s4czA>
    <xmx:qE5faaejXwVavOv20f_1yhvP0cZ2Z5Y4l9en7DLoI11DeCUSPlEFag>
    <xmx:qE5fad1qScJ94kAuI-4CpcCk2cLEyZeh2G5S_lUtABiwqW4f3jWR4A>
    <xmx:qE5fact89w13TstxASN5utXvd9pq2qbJLbkQJGRKlmKOuiS2OUATq8KF>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 01:28:54 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 1/6] =?UTF-8?q?doc:=20patch-id:=20don=E2=80=99t=20use=20se?= =?UTF-8?q?micolon=20between=20bullet=20points?=
Date: Thu,  8 Jan 2026 07:28:15 +0100
Message-ID: <no_semicolon.1ac@msgid.xyz>
X-Mailer: git-send-email 2.52.0.421.gc32ead4fc78
In-Reply-To: <CV_doc_patch-id_3.1ab@msgid.xyz>
References: <CV_doc_patch-id_3.1ab@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

These bullet points are full-fledged paragraphs with sentences.  It’s
best to restrict semicolon-termination to the case when the bullet list
amounts to a list of items.[1]

† 1: Like “List: ... • first; ... • second; and ... • third.”

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-patch-id.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id.adoc
index 92a1af36a27..bac37db09d4 100644
--- a/Documentation/git-patch-id.adoc
+++ b/Documentation/git-patch-id.adoc
@@ -45,7 +45,7 @@ This is the default if `patchid.verbatim` is `true`.
   with two different settings for `-O<orderfile>` result in the same
   patch ID signature, thereby allowing the computed result to be used
   as a key to index some meta-information about the change between
-  the two trees;
+  the two trees.
 
 - Result is different from the value produced by git 1.9 and older
   or produced when an "unstable" hash (see `--unstable` below) is
-- 
2.52.0.421.gc32ead4fc78

