Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0E52940D
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 01:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768182319; cv=none; b=U+AIsY2ggIOqd2V9jySFeXV/4rgYI2/nrAHmN4z0UaJYcP8Vxtx2+yOjuu81PbLjY9iKV3lYbd0Ux90SSDjM9tpWxws/ZUxmuq8vMqOAZzilpUGWX5m4mAoPFa78WEsLWziMxpXREZ9Gkj5ahFrC4WPJ1vs9//bHj06rnmtpM4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768182319; c=relaxed/simple;
	bh=wSaPn1R4VrjQX7tMkkeN8O+FbrZ2tt3Q6hY1BVMbEr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPZ0nQhVa0Rfq2GLdaJHv96/sN8AKBfcPpxkaZioG0b5+gaekRAGaa/7DYPRNAmL0nTuwodO6P8PZds6YD4cWcU5C9OPYRL/ueKsPOu2D1qO4K4gclY3o9mYckpH8wdFNBD+ruLcqh9JCH9cZXU6jyKL+YMoiJ5Wv5SQ207+CnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kjtsanaktsidis.id.au; spf=pass smtp.mailfrom=kjtsanaktsidis.id.au; dkim=pass (2048-bit key) header.d=kjtsanaktsidis.id.au header.i=@kjtsanaktsidis.id.au header.b=jvDjhBlN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hvUasa2N; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kjtsanaktsidis.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kjtsanaktsidis.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kjtsanaktsidis.id.au header.i=@kjtsanaktsidis.id.au header.b="jvDjhBlN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hvUasa2N"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id CDC95EC00BA;
	Sun, 11 Jan 2026 20:45:14 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sun, 11 Jan 2026 20:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	kjtsanaktsidis.id.au; h=cc:cc:content-transfer-encoding
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1768182314; x=1768268714; bh=wUC+B0STCLK5J9DPdu9jT
	UOfJ1ElJbrhH6WOkJkBnNI=; b=jvDjhBlNP6/MNAqTRM9TrrzRLKQ3Z8iPjr11p
	Wszy9bekagxU2SNJaCfbEkFNQ7NJuksFRSXdVFwahKs6fKOYO8uM+UJMiEu+uMPr
	cLPOprKElRSwkCz2cZO+29dli4icelPG/ClV1ll/sVMQfZMk2CM0a/JXT1WLXacm
	LfutCcI50wJM0AgwdZ7luxRTVhjf2B3CYFNhacVQQLbJnPipf5Yf72Y8Ui83n0UA
	YfPm97f1/ZB4gLjIvkqmXCK3BPeRLPjJiRuGgjgXE75pzqTf6WKghIH725Z18E0v
	6lKVAwIPFlCqFG2y3gVN0xZywT/1WxNCzppfqw9g+NNWq5iGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1768182314; x=1768268714; bh=w
	UC+B0STCLK5J9DPdu9jTUOfJ1ElJbrhH6WOkJkBnNI=; b=hvUasa2NJfgFKrar7
	eiwrteoL0VeKH845dkGXGofWHppt2MEtSiK0ogbuzPsWTtUBQDUIPgkd7JxtZcSv
	qUAueKrBTznXKQOW+mpV9QfFqjecYQgu9f2X5CLWBLuRbFdc/IfvePTImAPqU8G/
	YmAGMB3rTbKm9hQyf7g58ZodJYuhIIpEJOt4q/5XGREaQSOXQTv4fvYMtieRlaup
	HWvu6WSe64knjIOmPxRSXwK5zztJkc2fbPVJWHoeo08ytWzX+qww+HiWT9KwJTLf
	x62fpPGMBxXlvlUU7WG+TOM+FMo7kg7yuNw2q9DQyU/N9jJ1uXHCKvf3C16e0DJq
	lez0w==
X-ME-Sender: <xms:KlJkaRapW3vTiAJX9tFfPED1yCZWHfPUMHtMEgPlxbEZrtX-0E-tuQ>
    <xme:KlJkaQJGA70qTGfrodX94yS9LAICMQTGDsQMRzQXjJKiGK_sIeueLWE0V3UGISH3c
    S_OFo0ykkNxhMOREbNFUipVIeevZlPkuRGD9MNl1cIUx7gGcIw->
X-ME-Received: <xmr:KlJkaXAWhBszdBIl58YW03d5ci9MpbefSaC5-BZMnJ7llXIAPv4TXr5iAaKC5zWyzt4k8WGt4qOWhS3VSjPLKJ1mtH02jK9OxbLf_4rMqwN3m58>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeiudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefmlfcuvfhsrghnrghkthhsihguihhsuceokhhjsehkjhhtshgr
    nhgrkhhtshhiughishdrihgurdgruheqnecuggftrfgrthhtvghrnhepieeivdeuvedugf
    elkeethfegleegfedvleefleduveevjeeffeeugedvffegffelnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhjsehkjhhtshgrnhgrkhhtsh
    hiughishdrihgurdgruhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hkjheskhhjthhsrghnrghkthhsihguihhsrdhiugdrrghupdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KlJkadquNz3-uBLChc5lB69ZoHdbpLDH10nlcG37AC4O6U5CDvuGng>
    <xmx:KlJkaahYmMIiZcWiEo5cNPIiHM5aufvyYrQ5_emrzgNbbnKpjSq0Rw>
    <xmx:KlJkaSBwk4g-UKeXK4wFdcduPx8YdL1WIt7G0RgfSRBDlPB0a55xnQ>
    <xmx:KlJkaXGL7SifX9GreRBCWD6u9u4c_nAsgBFN7UWKE-JaDeLI8dsqZA>
    <xmx:KlJkaUtp2X7MGOMu5owZJlwgs6TBDsSSs6hmWQM4p83h8tD0F4mU82kb>
Feedback-ID: ibd1946f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Jan 2026 20:45:13 -0500 (EST)
From: KJ Tsanaktsidis <kj@kjtsanaktsidis.id.au>
To: git@vger.kernel.org
Cc: kj@kjtsanaktsidis.id.au,
	gitster@pobox.com
Subject: [PATCH v2] http-backend: write newlines to stderr when responding with errors
Date: Mon, 12 Jan 2026 01:44:39 +0000
Message-ID: <20260112014508.17248-1-kj@kjtsanaktsidis.id.au>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <xmqqpl7govl8.fsf@gitster.g>
References: <xmqqpl7govl8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The not_found and forbidden methods currently do not write a newline to
stderr after the error message. This means that if git-http-backend is
invoked through something like fcgiwrap, and the stderr of that fcgiwrap
process is sent to a logging daemon (e.g. journald), the error messages
of several git-http-backend invocations will just get strung together,
e.g.

> Not a git repository: '/var/lib/git/foo.git'Not a git repository: '/var/lib/git/foo.git'Not a git repository: '/var/lib/git/foo.git'

I think it's git-http-backend's responsibility to format these messages
properly, rather than it being fcgiwrap's job to notice that the script
didn't terminate stderr with a newline and do so itself.

Signed-off-by: KJ Tsanaktsidis <kj@kjtsanaktsidis.id.au>
---
 http-backend.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 52f0483dd3..8c810cfcbd 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -143,8 +143,10 @@ static NORETURN void not_found(struct strbuf *hdr, const char *err, ...)
 	end_headers(hdr);
 
 	va_start(params, err);
-	if (err && *err)
+	if (err && *err) {
 		vfprintf(stderr, err, params);
+		putc('\n', stderr);
+	}
 	va_end(params);
 	exit(0);
 }
@@ -159,8 +161,10 @@ static NORETURN void forbidden(struct strbuf *hdr, const char *err, ...)
 	end_headers(hdr);
 
 	va_start(params, err);
-	if (err && *err)
+	if (err && *err) {
 		vfprintf(stderr, err, params);
+		putc('\n', stderr);
+	}
 	va_end(params);
 	exit(0);
 }
-- 
2.51.2

