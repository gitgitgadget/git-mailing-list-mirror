Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ED65F846
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840128; cv=none; b=Dh6OU2/81RqsjBoZ4u+IcD2qftiH50VXPyrIFlDz+PAIlEatU9JP93le3mVKBHbwShu8TScnArweE3D9A5ej4xn+F/qFPGlYOt1xOC96vLQ5DhO5BL9AWc8n5GkvPGCEKzhdiaMnB6CugaBYjJEtB8KLQLVEpE/g2fB1NSlfsDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840128; c=relaxed/simple;
	bh=xoRQkpZn9O489wtevK19oNVKz26qmpPVkFyXnZ3ysNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VIWw5MtTJX9coPmd7l+8W7el8Ut4BgBx6xB/8QeLzja/2gBM0Mp06b/lfw+XtyGl41uJj8gDbp26Yk9wQy0n9lIRc28aubfnlaibxl/ouEVh06fqxF+FlcAWpQfJTuOPb3ALlpUQs0s9EKhEA32GN9fXXlyHSxy0rsnf1/6aEXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=cgcp2kkD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gvjA/CLq; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="cgcp2kkD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gvjA/CLq"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7FB2813800B5;
	Tue, 13 Feb 2024 11:02:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 13 Feb 2024 11:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707840125; x=1707926525; bh=N0d6g8aUFNm5pSLiq5R14Kb1uGfl4akU
	uhzG9KEOM24=; b=cgcp2kkD2vmP5OZz2JgTNmo/WDXzpMERMSE7uvZ7nFRT9+m0
	K3TcpRRTFIsKg9O5/W7MDcjVZLNFOW/FVp3Ht4MM9oPZsQgCCJQv51dYMuuCOVyQ
	6LF6VXFwrFO3T0lZdvjVgvIIz7f4L8PnjCTJ5+MhezPS47bjLT7YtwCOjUySFDwY
	LNID0asjki3SON7T2l8TzaalxXY417vQr+krW6sugdjMG7IEML2ufUk/1nG/O7Og
	sOEMEaZal9BCbPuuNrc5m1t0UxF6ilO/bYwbnl5CPyYXF5ERn9ryNmYnSTXN/pPq
	avh/8/KJNuGwXeWdtgCeYgvFg9josIp3cOmupw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707840125; x=
	1707926525; bh=N0d6g8aUFNm5pSLiq5R14Kb1uGfl4akUuhzG9KEOM24=; b=g
	vjA/CLq4J4fCPkbjygnPF7xvuvXJuR79+VlvHpYPh1FhZaJkQ2xa22FaYY64mNUk
	58O3wphK7wgDIU2r1BSsqMUR8Lmu/Xz3LfxwqUG+/eIlUBWyU7uE1+D2L468IY5m
	fUk+V8VlU1+pkiPpTnLtk0zr65lF6ZkhwUIb10YeCuIwCTTQPtMws0CCDZVCnffP
	m3yksbdqM6ZUIHNjmaZsWOUPvsoSzRxhNrgQp6/jwWj+EyufUkETkpk0pCdFeLwA
	Xb2R/nra+9M7SL9TnzLVx92XsklvUivgQCV05W8CMxqEaahAOReCEFG7DdqQShpa
	5ocYxPzJUr2fE7ckp8yTA==
X-ME-Sender: <xms:fZLLZTOsSPxmCA7f58s07sVRYf6tkPAztuHRWV00mMDreXzTU3FsgIc>
    <xme:fZLLZd8_ofbVEcH9wndjz-LNKvvOJvsErFZ7ToBv7weRPQORqFmWvpWIkpo8sE8lS
    XiP6H4DJqwp6hZUKA>
X-ME-Received: <xmr:fZLLZSTk_hziE5tPxDn7HsLazjqVrV_tb4egQURdtyB2oSApH9ze_sKY6YeHiRf9yoXaTr2mlaqTpujeKhI9TTjWJTy0ciCaX5OQCygmwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeevgfelveeikeegjeeikeeuvefhleeiuddvleeg
    feekjedtkeevtdetgfffveettdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:fZLLZXvnkiclHj5HOIlxC9AKgxoIik8bxFYdfvFlIwIy5GzpzDJU0A>
    <xmx:fZLLZbfVLCFk0kY60_WXZcjgYIrhYmIXkspoyntoN8z83VMLZIwttw>
    <xmx:fZLLZT0FtJ-veb9BaU6BXYKZf3HjCmzQh0E0tSFzAYe5MH1YurVbng>
    <xmx:fZLLZX717u_kl0vFnUMuSzn3EiusvRTlnldq8pvvGeFScEUNh17oYA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 11:02:04 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>
Subject: [PATCH v3 2/2] column: guard against negative padding
Date: Tue, 13 Feb 2024 17:01:21 +0100
Message-ID: <9355fc98e3dac5768ecaf9e179be2f7a0e74d633.1707839454.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707839454.git.code@khaugsbakk.name>
References: <1c959378cf495d7a3d70d0c7bdf08cc501ed6e5d.1707679627.git.code@khaugsbakk.name> <cover.1707839454.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make sure that client code can’t pass in a negative padding by accident.

Suggested-by: Rubén Justo <rjusto@gmail.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Apparently these are the only publicly-visible functions that use this
    struct according to `column.h`.

 column.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/column.c b/column.c
index ff2f0abf399..50bbccc92ee 100644
--- a/column.c
+++ b/column.c
@@ -182,6 +182,8 @@ void print_columns(const struct string_list *list, unsigned int colopts,
 {
 	struct column_options nopts;
 
+	if (opts && (0 > opts->padding))
+		BUG("padding must be non-negative");
 	if (!list->nr)
 		return;
 	assert((colopts & COL_ENABLE_MASK) != COL_AUTO);
@@ -361,6 +363,8 @@ int run_column_filter(int colopts, const struct column_options *opts)
 {
 	struct strvec *argv;
 
+	if (opts && (0 > opts->padding))
+		BUG("padding must be non-negative");
 	if (fd_out != -1)
 		return -1;
 
-- 
2.43.0

