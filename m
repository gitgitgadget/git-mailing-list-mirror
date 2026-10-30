Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793354346;
	b=P8aoW0WFMEOkqgu30HWKLp3ZaPbFjAjBA3mG2i1RVORywj/f3zMO+WAQV854NgFIjrn+
	 DMaxcsTCfk1ks4d2bUbUrmWbv4dHNm8G+AbN2n0W94fiqOhQrjsLWAxIWngwnf8YjATFj
	 N2jL4rcZ+Diq2y8eEKLI231nC0cejIUwbV894PCZbFZmuI/TtunAzUS/WvJkOMlDrDkVH
	 kGs0LLQTFIcnSsz+tvvEZjIr2s1mOLa7xoE38Es4fgF+An1b6U7sd/RrsmjyB5v96MnmH
	 /JZ2w+kMbvD0TUE7YuccaAua3opB0spftN8+/jDiQZwAoBWnSPYpgkMxK0bAPCX6j0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MmFIhUcBHULPETBfLMzLQBp2PaTNakx4eBj2zh7ZOlA=;
	b=2DiMVP5eNG6CHc3nQuKGAkklX7uVjaxWz4hDZl3/5o9H4wGLIJd2X8Lsnp82BCGK6zpq
	 +qv6hMKBl6+6LCyimN72rRMIKXYBuUalBXYw7gJC3ED3UKlD3M0a7NBFEapinjWsGwBOj
	 EsbZz4BhJKmHLwc4jZQ7q4MWIy3XLYPkADdLs0N9PAJ9XS9aAi3gFh0TZICqfw47VHvEo
	 Zhm+7Nxf0WIH5NYLmGmcmGtKO1Uf/CeHhPQM6W2bxO4TCtfabeZWWLNO2/1WXdBA2WzDO
	 lENk/MgEZoHWPeoAdsMNmzYsvZD9GWEfSMY5+0IYKlIzmi6+ZeRBvme0wWhKLiqgHHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m7kUQJyJ;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692DD606A336
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 09:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 692DD606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m7kUQJyJ
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e4831c028so511839f8f.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 02:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793354345; x=1793959145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MmFIhUcBHULPETBfLMzLQBp2PaTNakx4eBj2zh7ZOlA=;
        b=m7kUQJyJvpSQSQGZvVEb6eexC23AF1W/HGT2mBofAu1EvKRQhQM606xB0cSMgE3Kx0
         z++6t355xmADgqRa3l9LzMXaBzAvuSoLahJS3ZsF1gRvh5rn7Yhv+zlkAWGN+lW/WKSA
         xhMqvl8DCi5VaOkwkhgFCqOnpbhwW0XxER58q1rQWyiextmWA5qgE6b+9jb7oD0053JR
         cQ/r8dmBm7sK7Ht7CuVbd3L7e51XTsw7sB9cMY4Yzcyls1tEsK98EY+5TGsooGYSZWlS
         lbm/TWu8sasP96wCntfCdXeeexZE0VqrBEF218lUFDa69kWKiMOKbJcotQiLk19Kof2O
         XRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793354345; x=1793959145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MmFIhUcBHULPETBfLMzLQBp2PaTNakx4eBj2zh7ZOlA=;
        b=VA/BmCPE+EvORFm3271h7vW571g5pamMFu906KVELzrJXlmQEHDDP4R1qEAzm5m8Y+
         0bgb4s5NPpjxxh77KAoLRrEL1VB6Da/emSiCXKanzNvY7F9TQds9NYrKKQgEJj/qeWwe
         B+2pg1As5ALUqb5mkvZqACQ2rQincY2TGG0DsNnWYbbkQYs71eU2WE/3VuK+67nbOTxL
         1YI9LlJ1chyPN+xHVPssdMmStPYR53tKCoQGO1jSapgU1f2KWQkR+u4bc+BfwCY8oBna
         xAN93dUDA/bFfrslscb8KoV9Scwc80MfBb2tOh484lUpny4UKP7X0Q8QAOI4mIR+f6wE
         91YQ==
X-Gm-Message-State: AFq9FYJ6trDdiuBf7ktTQRKWhsoQsGNooXydNTbbr4Ki7zpqWf8V7dCR
	Z5rztNgKTcKTtarj4JG6DMYaogmY3IFLYTc7leQP/SEp0j2uWvgize1Mntq4clau
X-Gm-Gg: AYBFou0rHMAu7pzlDo7iS+l1zJVParyfo0unv/juNk65BAjfX5Ha+hGVzOAXIbfMFjO
	UzzmHny2UTjNYTatgrcMmj5M3B0QEUP7Ug7WffU3xQnRM8TBw9/uXfVFYMl1UFaoJlbeJG/6o4w
	N0sxukfso2Hdcuzy7uHAa/9Ul0/4LNsqD43+wYnFBZDPMYjASpBf5XqnlwDNZdyBIUUPHtQ80Er
	xJInx9tptQ5mdbnUHzh/g2EP/GD+pKSz29sT8v95R4L7iSbgWj9nk50Z2E/yRvZxctzj7763P6S
	5Jfxak36R8kog08QtWWeKdjjrP151ONZqRyCgyFYfYk9Duoaay0+BoQ5kNvhcQbxe4UEE9KreM1
	6HhXK4vcM0kQaXT+wZWg53jhhlLMM+bHGP9Nz7cF0eLx+Xd1TDkc+VuvetqoiL4ogLPmU71CKik
	0vErv9+jfbXugR2GF8w1ORhmSRbrLvjmROjj9ssU0EsZPEFJvoGdpCX6AJYMuXZaFpcCOvv/cV0
	Bk8wvHBNzNT4ps2/hsc/DhN+hVN8AOT2ANomhXjw0NhDqtOptPvW89TNsczoX8S3zqqEO04YtdT
	Iyu9VJ7bm4r23XRvo85N8+loWMmde87at+bnhEMCz2uBY3V2mg==
X-Received: by 2002:a05:6000:1866:b0:48d:fdc0:65be with SMTP id ffacd0b85a97d-48e6e4ff7b1mr4998422f8f.38.1793354344547;
        Fri, 30 Oct 2026 02:59:04 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([205.147.30.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b9b54dsm2359421f8f.47.2026.10.30.02.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:59:04 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v2 4/4] convert: use size_t for text statistics and ident counts
Date: Fri, 30 Oct 2026 10:58:53 +0100
Message-ID: <84e9e38a3e63a2b135847471a13ea36d37bd64d4.1793352943.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793352943.git.gitter.spiros@gmail.com>
References: <20261021101640.329990-1-gitter.spiros@gmail.com> <cover.1793352943.git.gitter.spiros@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gather_stats() counts NULs, CRs, LFs, CRLFs and (non)printable
characters in "unsigned" fields of struct text_stat, and
count_ident() counts "$Id$" markers in an "int". Now that the buffer
sizes they work on are size_t, a large enough buffer overflows them.
Unlike the previous patches, this is not specific to LLP64: "unsigned"
is 32 bits wide on all the platforms we care about.

The counters only drive decisions, but a wrapped counter makes the
wrong one. For example, a file with exactly 2^32 lone LFs gets
lonelf == 0, so will_convert_lf_to_crlf() decides there is nothing
to convert, and a wrapped "printable" or "nonprintable" can fool the
heuristic in convert_is_binary(). In count_ident(), going past
INT_MAX is undefined behaviour.

This is not a memory safety problem: the counts are only used as
hints to strbuf_grow() in crlf_to_worktree() and ident_to_worktree(),
and the buffers are then filled with strbuf_add(), which grows them
as needed.

Use size_t for all of them, and compute the size hint in
ident_to_worktree() with st_add() and st_mult(), so that it dies
instead of wrapping around.

Triggering any of this needs more than 4GiB of input, so no test is
added.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 convert.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/convert.c b/convert.c
index ca5594cab0..34fb4ce685 100644
--- a/convert.c
+++ b/convert.c
@@ -36,10 +36,10 @@
 
 struct text_stat {
 	/* NUL, CR, LF and CRLF counts */
-	unsigned nul, lonecr, lonelf, crlf;
+	size_t nul, lonecr, lonelf, crlf;
 
 	/* These are just approximations! */
-	unsigned printable, nonprintable;
+	size_t printable, nonprintable;
 };
 
 static void gather_stats(const char *buf, size_t size, struct text_stat *stats)
@@ -1077,12 +1077,12 @@ static int read_convert_config(const char *var, const char *value,
 	return 0;
 }
 
-static int count_ident(const char *cp, size_t size)
+static size_t count_ident(const char *cp, size_t size)
 {
 	/*
 	 * "$Id: 0000000000000000000000000000000000000000 $" <=> "$Id$"
 	 */
-	int cnt = 0;
+	size_t cnt = 0;
 	char ch;
 
 	while (size) {
@@ -1170,7 +1170,7 @@ static int ident_to_worktree(const char *src, size_t len,
 	struct object_id oid;
 	char *to_free = NULL;
 	const char *dollar, *spc;
-	int cnt;
+	size_t cnt;
 
 	if (!ident)
 		return 0;
@@ -1184,7 +1184,7 @@ static int ident_to_worktree(const char *src, size_t len,
 		to_free = strbuf_detach(buf, NULL);
 	hash_object_file(the_hash_algo, src, len, OBJ_BLOB, &oid);
 
-	strbuf_grow(buf, len + cnt * (the_hash_algo->hexsz + 3));
+	strbuf_grow(buf, st_add(len, st_mult(cnt, the_hash_algo->hexsz + 3)));
 	for (;;) {
 		/* step 1: run to the next '$' */
 		dollar = memchr(src, '$', len);
-- 
2.53.0

