Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088841;
	b=5CSHqL4b/uZ7U4e2n+ZwMmaLAGovl6NfyK8peGY1KwBM9giDdETNVhnachNk3l9BHfZE
	 PhQl3UqJKouiX4DfUeL/06kSk8nw/k8n2oUmCL4mBbdkt9dku6xVu1p4kVTklZcRj9wwm
	 eFMF3aImuBFymWsT12F4mfp8BvEQvqRLymc1EhO3X5xkreGONzpZNpGFf2qmXst6xK1yf
	 HSo27XMFe1f0S9sEZZoxWYyH8kjjKdcWKSNUW+G4clMru+YJfUM46vD7Ne+x5Sx2iBXuV
	 cO4jFLjOKEuxuFA5DB0oaq/vIkM66x2THokE/wH5TMBqTZQ7YSdePaaWEDGVkgsWjXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088841;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Pi2m+xkHBTUs6ngJtJpdvFo4xQSIXvKapRAH0DMHXCY=;
	b=WNght72dnyl/ZVUr5Pp186pg9iVY6/y4bbhrf8kI0YJ6XFjt++ODgqZq9bvFl3oY0io2
	 5epkDAmXMMrZtnrP7Ba00lPu/6eGVQDQee3df+Xz0gBLYRE1TZJTKuhBbbI4yv3GVgFow
	 7x/5yh00sHBc4WM4+fRUmjlKaxXCtzRS97ltzGEhgz3UdWqIuJ7OwWCCbFKr5QNkLWZCX
	 cK0zQfS1f9pqT5jf4ss+VCvr9kNMGL2d4CPd5YqiYrGKSFIvE4FcxtbvRPWcV50t5Bh3S
	 zsM/54mGejmoGDR83q881T+Gd9qvXlJz5Lga8PoL687vZK8Btn4Gxlth6scZBlBAekA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=vt3czogf;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=W7Y4mqBv;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62B9606A33A
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B62B9606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=vt3czogf;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=W7Y4mqBv
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 195D514001CC
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:47:20 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 19 Nov 2026 06:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795088840;
	 x=1795175240; bh=Pi2m+xkHBTUs6ngJtJpdvFo4xQSIXvKapRAH0DMHXCY=; b=
	vt3czogfYLTiTL7s261z9KVw2a6VPr3IMzE59APJg3RVftG4YwhULeWvN4OL6gr2
	3clMIiqOjnWBnk1EYTWIEp+coAGoqMj2I3zfFdws0tKhVCMpG8zyj89OXT8JRn7j
	+fNQyHHA1Tiy7gjrh9Q5FVwkvpGwkPf+8vO/zWsOl3xAtcwQ4w/AEpe3jiCLvs+q
	JWrGtOmAgYzA/m6hEfi7UzpuIB1td4o1mvxqZRuVjPJsKm2PPLfgOIUZ0QE5QECv
	djkSpbMFWZQjaI/zWfgV/Mdtq534AgKfUHRLqEGGWE7kVqUQqFH6kFN5IaYGbDRR
	yc5VtXDVwdyXIyI8ZQ0oKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795088840; x=
	1795175240; bh=Pi2m+xkHBTUs6ngJtJpdvFo4xQSIXvKapRAH0DMHXCY=; b=W
	7Y4mqBvQG6WCBOURukDQF2TzwGUbRykYXKN7wNlc392vZlx+VGa589R6gW+GAUIB
	q22xQVMa1nObQGpIJFJu8Zp0cgmoDqq2ffc7ITpm6FxV33vEpH6ftXZVKTcwMzrF
	4nu3H2HObsoCMjDL12q5avOfGwNRbD4vr4/ralj0soYo5/JLg3n9UGM3o3/TxG8L
	vLQUdVHkYTCKsqpmZ5FdPYElzPmj6KGyo2gWFJKQXxNA5QSh5XewNXJ7e5V0tUnS
	FhtPkeYhOZPMMm7Qc1h1Wyk/tG6OzjKPwkwhqeZYHG7EvwV84PyJ1f+xx6JCBlmb
	Bm0Vs8aQZOuZ1ZoseLaxA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795088840; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:QNr+dZZXuFFvRepnsKmL7QKBKV1F1mrqCAUPhcnJ5dHXq9r
	jMnvrD/U2bgmf8h2TF85BqixjHdGGQxLlgk9qInp6+H8VIJJh2gZ9FpDhrTojuZU
	GIvw/9Nc+cF1dVVNHy2bq1u3YyIl0+9nOGlrtQzxc74kKU8FrhgHKBIMTZdDy/YM
	cJEr7ZiT1Q0xryllUhuiX9vT7Ehb3GoA8YVWa7BFALZxj5IIDi+ONf6ACm824i+x
	WpckSHC0e+zEgOV+BIvYIPtPgIMiN5H76MYggb+KNEpzZxAwN8VSFmNoQTeyQp6/
	dHxFH/IqoMNRXvHigUaYRiD11E/QR4k2YC8KZ+g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:UugigbJD6z+PYokSKrsQc2c4UIdIREN2RQ6gW0Ls+vk=:ouWCfhEHhX62zBHHlzDFgBVRk5msLMLSmeSGYmt0RQI=;
X-ME-Sender: <xms:yOH-ahjuoUbodWYYWxkhRk6rAD6pzkXq4--5td4hpxhPK1LNn0WhYw>
    <xme:yOH-atCwKkAA3HU1XzXw-nOxoR8TNWpYyp4evlRVnOfnxJownNL_o77rN_UVNNehw
    06fVT7kVzn9D8NuuOmQ_Z8YeJYzKN8vhWXhnoy2yCu3hSVX5roLaXU>
X-ME-Received: <xmr:yOH-amE2snrlc57tPymQRFpsLyGB2oN2bXoamiKUZnUTVT2q0SiPygnoZzDpJTqmYZ2O3kg>
X-ME-Proxy-Cause: dmFkZTEXZEOjEM71ry1bXEPUyrZqX+lj5LhX/Ly29UsKVTRe21Y2eyCJWlEh2udTa5KEnz
    eoYFQvG6xuLPKNhARxbzj1z6+z2YrzJTj986YPy3tkngcgZgyh68VJu3U+YO+6PVTUMcr5
    QrGQnWpmNB7xda1uSgfFh/KJf5SXDY6GlebuSQ92BiRMVpqzNBycNApFQ/CVd94QPxkbTY
    oT7JtdpLBwothcIX9cCJMncyBzKol0AVwv35ZuDgRg8O7e+Z46ZE2TEt5Unuz+pSoLCA80
    zjaGnGvt9lT1UHSuOmdpS63tiMV7a+SeTYrp7EU4JoyaBnbYKfZ1JZKJ30mydOX4feVhgj
    RcvDXmWTwStHzMU/ffZv5NrYX8rhe8QbLQJDN8ThDrerMuw442715oDdZ6oHmjqRfAySKB
    prc8brxohhrKYIGdXmK3chDKC8MpCvXWwc/E5v7m7M5RUbw1bKXF24cGAUT7foj3RvHs8m
    QHKf2If5XhGJkdcdJOWWylU5SM+XipFVJKsStV1Zd4p1ygcQ8QjGyOGUCUydIuaGgX4oiN
    +qH0f2T03S/ntUXM8QC6KwoGdoOMFoN3CRiW1L5xhGq+O6GhxdNMXZfcpf76bzVmL7qDY3
    5sX+zAljBQ5OuhrzmY1UoB7Xt7FYtKwKppY0nqYIHH5pj2KRMr3AW2va/IgQ
X-ME-Proxy: <xmx:yOH-alJbSHPZci5ByE7rT2uEx8aUpBvIm8w-HrWCJPXSdFHOGomH7g>
    <xmx:yOH-aqnDsxCCqUDrKJsvh03C3XdOCBHEQcZMUOH5JOWAvQ9rE0Lvdg>
    <xmx:yOH-atRyttpAYmIkw3IwlTRZiEbWBzqldLBdabf0mqyjVg5sDzX7GQ>
    <xmx:yOH-asJvNEajy6dIAaiD3vzvdom8hygPVoRnAhC3gyrFFNYL7qFZXA>
    <xmx:yOH-atm_0wBkPjkVWr-wTR9X1t22InAw0WgrvWo6oxDZyQl1WLujePWn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 06:47:19 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 78ee0989 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 11:47:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Nov 2026 12:47:03 +0100
Subject: [PATCH v5 02/13] rerere: convert flags into an enum
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-pks-rerere-subcommands-v5-2-0c1092b88958@pks.im>
References: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
In-Reply-To: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Our modern coding guidelines say that flags should typically be passed
around as enums so that it becomes trivial to see what kind of flags are
expected. Adapt the rerere flags accordingly and document them.

While at it, detect the case where both `RERERE_AUTOUPDATE` and
`RERERE_NOAUTOUPDATE` are passed. This combination does not make a lot
of sense, and it's not obvious which of those flags takes precedence
(it's `RERERE_AUTOUPDATE`). All current callers know to only pass one of
those flags, but let's be safe rather than sorry and `BUG()` in case
both are passed.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 rerere.c |  9 ++++++---
 rerere.h | 36 +++++++++++++++++++++++++++---------
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/rerere.c b/rerere.c
index 47a4a325bf5..47d9077eeca 100644
--- a/rerere.c
+++ b/rerere.c
@@ -908,7 +908,7 @@ static int is_rerere_enabled(struct repository *r)
 int rerere_cache_setup(struct rerere_cache *cache,
 		       struct repository *r,
 		       struct string_list *merge_rr,
-		       int flags)
+		       enum rerere_flags flags)
 {
 	int lock_timeout_ms = 1000;
 	int fd;
@@ -922,6 +922,8 @@ int rerere_cache_setup(struct rerere_cache *cache,
 	repo_config_get_bool(r, "rerere.autoupdate", &cache->autoupdate);
 	repo_config_get_int(r, "rerere.locktimeout", &lock_timeout_ms);
 
+	if ((flags & RERERE_AUTOUPDATE) && (flags & RERERE_NOAUTOUPDATE))
+		BUG("RERERE_AUTOUPDATE cannot be used with RERERE_NOAUTOUPDATE");
 	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
 		cache->autoupdate = !!(flags & RERERE_AUTOUPDATE);
 	if ((flags & RERERE_READONLY) && (flags & RERERE_NOWAIT))
@@ -951,7 +953,7 @@ int rerere_cache_setup(struct rerere_cache *cache,
 	return fd;
 }
 
-int rerere(struct repository *r, int flags)
+int rerere(struct repository *r, enum rerere_flags flags)
 {
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 	struct rerere_cache cache;
@@ -1336,7 +1338,8 @@ bool rerere_gc_needed(struct repository *r, size_t limit)
 	return needed;
 }
 
-void rerere_gc(struct repository *r, struct string_list *rr, int flags)
+void rerere_gc(struct repository *r, struct string_list *rr,
+	       enum rerere_flags flags)
 {
 	struct rerere_cache cache;
 	struct string_list to_remove = STRING_LIST_INIT_DUP;
diff --git a/rerere.h b/rerere.h
index dd9da03d6db..239172e969a 100644
--- a/rerere.h
+++ b/rerere.h
@@ -9,12 +9,6 @@
 struct pathspec;
 struct repository;
 
-#define RERERE_AUTOUPDATE   01
-#define RERERE_NOAUTOUPDATE 02
-#define RERERE_READONLY     04
-/* If MERGE_RR.lock is taken, return -1 as if rerere were disabled */
-#define RERERE_NOWAIT       010
-
 /*
  * Marks paths that have been hand-resolved and added to the
  * index. Set in the util field of such paths after calling
@@ -39,10 +33,33 @@ struct rerere_id {
 	int variant;
 };
 
+enum rerere_flags {
+	/*
+	 * Auto-update the index with previously recorded resolutions. This can
+	 * be used to explicitly override "rerere.autoUpdate".
+	 */
+	RERERE_AUTOUPDATE = (1 << 0),
+
+	/*
+	 * Update the file in the working tree but don't touch the index. This
+	 * can be used to explicitly override "rerere.autoUpdate".
+	 *
+	 * This flag is essentially the reverse of `RERERE_AUTOUPDATE`. It is
+	 * invalid to pass both flags at the same time.
+	 */
+	RERERE_NOAUTOUPDATE = (1 << 1),
+
+	/* Skip acquiring the MERGE_RR.lock for a read-only operation. */
+	RERERE_READONLY = (1 << 2),
+
+	/* If MERGE_RR.lock is taken, return -1 as if rerere were disabled. */
+	RERERE_NOWAIT = (1 << 3),
+};
+
 int rerere_cache_setup(struct rerere_cache *cache,
 		       struct repository *r,
 		       struct string_list *merge_rr,
-		       int flags);
+		       enum rerere_flags flags);
 void rerere_cache_release(struct rerere_cache *cache);
 
 /*
@@ -51,7 +68,7 @@ void rerere_cache_release(struct rerere_cache *cache);
  * and working tree files. It records (and optionally updates) resolved
  * conflicts and reuses recorded resolutions for unresolved conflicts.
  */
-int rerere(struct repository *r, int flags);
+int rerere(struct repository *r, enum rerere_flags flags);
 
 /*
  * Given the conflict ID and the name of a "file" used for replaying
@@ -65,7 +82,8 @@ const char *rerere_path(struct repository *,
 int rerere_forget(struct repository *, struct pathspec *);
 int rerere_remaining(struct repository *, struct string_list *);
 void rerere_clear(struct repository *, struct string_list *);
-void rerere_gc(struct repository *, struct string_list *, int);
+void rerere_gc(struct repository *, struct string_list *,
+	       enum rerere_flags flags);
 
 /*
  * Check whether garbage collection for rerere entries is needed, which is

-- 
2.56.1.831.g720f3f5937.dirty

