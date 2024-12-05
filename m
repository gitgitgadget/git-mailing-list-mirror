Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61801D7E35
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391420; cv=none; b=d433q5p9zzf58G8n2JHe5xJHE92bcPnbuissZltzDNMNRnjJheK1PCtNS9ajgJTyl6HVvrlnUMFnezYfzlURCw1gl7IGOAFlC4Z1PybRM0KT6C2b7WYdheUDEBKLFlbD6bbbbk3xltKGjFUn3fdJdo07aZEeYbhrznpiFx1Xsdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391420; c=relaxed/simple;
	bh=N/kGI35uw2wReGQtRhDTg/oIyFx9rb9hd63XvAwvqEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hw5JUcspp48ZcDdXl9k0Qt0kxX6EgjCWu8JrOvHF6BCTQ9rV06I1TpxNHPHwUmQgNTR7ETUzJlu5UHPwit1jxQY6uLrLS7JFJsg23wLGDAeezX08Ny2u89jAwfS8rTWXwh+OCvav0kAX34ps6PeOpoH/UvCrc8Iy0gszZ/w7zAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qgcibevY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=36YOPcbP; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qgcibevY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="36YOPcbP"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id CC8031380B85;
	Thu,  5 Dec 2024 04:36:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 05 Dec 2024 04:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733391417;
	 x=1733477817; bh=Ossup2nZ6UWY2WKN4PsWIuN24Ki+kOfYdJwR1luyMmo=; b=
	qgcibevY+Q/t/fcDaPP1Du0Sg3Gti+nik4C34j7orkHcApMiJEIa4t4kr4lULWtm
	CQHGxovP+NNpSGdLiUNkTTS7vLfWRXh4fviuMIdo1idKMSguSsJFCunPklTnbFqj
	9RBzsycJCLaEqvV/QPUhGhOW+AAgriHpeepr9PWMo2TqKbjJuKpok61YC1d57VBN
	XoQjESbB97Gke/yG0+WebBdGI/9kLRLnbLv79g8jkMks+sv3j0rPuE++1BWY/lGY
	6YTwd8scrTdqpsteQjYzLszmTyvYCA6TkPE2MziN/46eI5vmYfppUMWOstY1b/jK
	DiWKDhgXxeVbP1IN8p+Lig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733391417; x=
	1733477817; bh=Ossup2nZ6UWY2WKN4PsWIuN24Ki+kOfYdJwR1luyMmo=; b=3
	6YOPcbP0zNrX1EdyoyXvscYDDMXoNdiQJZ5WSUF4mZq3X3NTpvBlXRrLYJrfDd6l
	+6bHv3SES6e5re9WFLKzahCYoYy/o/Mvh2gAAhsGUt7zEvwCJSOyQgsF/7D/vgvi
	jdanKQxuss4wnX2qgOaCuGbjsoit+lCyPui+Au0440z7zCmGG6KWC3eakbzXHTXb
	eNNvFdbBLa5qSjOvRTbnGRgtZnzaImVxoMv33elb3t93S4HH12IvN7rsc5LZ+ZNn
	Yi3wP0Xaifi1y/RmOh+arlNf5ApQPEDH/hIvLs9Vw7ZrPEFZdUWEUncQHToCrcBo
	yce981WRfN/WaA3hIKhyg==
X-ME-Sender: <xms:OXRRZxFdSGje6CLt6j3Ts3TURYxSvIuwGZzy_sgnZKOgw6r2HarNdw>
    <xme:OXRRZ2UCDzxzooe3t1psqfhymkYwPZd4xQ3xPqYS6cFgM2c156q-Pno_nl-zSDrIy
    sLcDgjZp1EuNWFQiQ>
X-ME-Received: <xmr:OXRRZzIbB9F_bd9JYbiKw03-HHMbY0shTnglhJW2hAFDwGwOfngZFUJ7_JKp4O7-pOC6QsSGaSUBa0aC_-zZvffUc6vROt7z7s2E2pqTzfxWYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:OXRRZ3HscBVmz6YuD30zst0Ts4a0KG2DyhtLaldz2TakDLAyQJFCiA>
    <xmx:OXRRZ3X28cd-3jkzlq8Lk_cAN-hBnraasgJHPOjIqWJZfa2zPcvt_Q>
    <xmx:OXRRZyOqNbAn2-2Tqn2gLAatWHTuY7jBNTLAmihgpwclDoFDZyypYQ>
    <xmx:OXRRZ210luIy7fkZZbplflQR1Hq48rVc8Hqvl7g1re5zoT2s6ns9rQ>
    <xmx:OXRRZ9xDZ4MXFw9MaMyA75slWOVLZD-lImuhEOkr4yE2RIKfrnR_LwiH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 04:36:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 697bddda (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Dec 2024 09:35:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Dec 2024 10:36:33 +0100
Subject: [PATCH v3 11/15] gpg-interface: address -Wsign-comparison warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-pks-sign-compare-v3-11-e211ee089717@pks.im>
References: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
In-Reply-To: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

There are a couple of -Wsign-comparison warnings in "gpg-interface.c".
Most of them are trivial and simply using signed integers to loop
towards an upper unsigned bound.

But in `parse_signed_buffer()` we have one case where the different
signedness of the two values of a ternary expression results in a
warning. Given that:

  - `size` will always be bigger than `len` due to the loop condition.

  - `eol` will always be after `buf + len` because it is found via
    memchr(3p) starting from `buf + len`.

We know that both values will always be natural integers.

Squelch the warning by casting the left-hand side to `size_t`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 gpg-interface.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index a67d80475bf9d8452de0c3ae9bb08ceeb4c11c4b..0896458de5a9889bf5951d9703c37a67e20d3e1a 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "commit.h"
@@ -128,9 +127,7 @@ static struct gpg_format *use_format = &gpg_format[0];
 
 static struct gpg_format *get_format_by_name(const char *str)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(gpg_format); i++)
+	for (size_t i = 0; i < ARRAY_SIZE(gpg_format); i++)
 		if (!strcmp(gpg_format[i].name, str))
 			return gpg_format + i;
 	return NULL;
@@ -138,9 +135,9 @@ static struct gpg_format *get_format_by_name(const char *str)
 
 static struct gpg_format *get_format_by_sig(const char *sig)
 {
-	int i, j;
+	int j;
 
-	for (i = 0; i < ARRAY_SIZE(gpg_format); i++)
+	for (size_t i = 0; i < ARRAY_SIZE(gpg_format); i++)
 		for (j = 0; gpg_format[i].sigs[j]; j++)
 			if (starts_with(sig, gpg_format[i].sigs[j]))
 				return gpg_format + i;
@@ -228,7 +225,7 @@ static void parse_gpg_output(struct signature_check *sigc)
 {
 	const char *buf = sigc->gpg_status;
 	const char *line, *next;
-	int i, j;
+	int j;
 	int seen_exclusive_status = 0;
 
 	/* Iterate over all lines */
@@ -243,7 +240,7 @@ static void parse_gpg_output(struct signature_check *sigc)
 			continue;
 
 		/* Iterate over all search strings */
-		for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
+		for (size_t i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
 			if (skip_prefix(line, sigcheck_gpg_status[i].check, &line)) {
 				/*
 				 * GOODSIG, BADSIG etc. can occur only once for
@@ -700,7 +697,7 @@ size_t parse_signed_buffer(const char *buf, size_t size)
 			match = len;
 
 		eol = memchr(buf + len, '\n', size - len);
-		len += eol ? eol - (buf + len) + 1 : size - len;
+		len += eol ? (size_t) (eol - (buf + len) + 1) : size - len;
 	}
 	return match;
 }

-- 
2.47.0.366.g5daf58cba8.dirty

