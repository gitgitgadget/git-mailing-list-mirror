Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794985013;
	b=TJLvf+DBbhqYPlMRaxPP8Nt7q782RcUZym/iEpDhWqqjJuq5KALpRoo0F8CJDy3qRzGg
	 lQD10YBS2ZYewwp9wm/XGZH0XHTYF5JKQxFEbkKodKEQes/Rw0PH69C/Ji1Jko5lIs+RU
	 vEhc2h2MSkdjs49BSwGI7ZsKdZ5wmRWU0+fGYeDhtahY15SQ9uynlAmv/PsDsbw0VvvZK
	 ARhc7qxbX2ibJEqBRgzSvaIiL193rUNmao7IylFfg0gHqjls9f/Y0SViIkN2Acoknquiv
	 berBYY1xFiZGpm0RElEOA1YPow36UOD6A0qIugJQ/uvB/LL314fsXTZeUqT8nbwnAGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794985013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hmY1fbech5A7U0m4vw5C/3DGiyMfg8pnccZ+bvgK6gY=;
	b=rC5NWe/7nysMCET2eAH8U4N/XcMqURlVt/GiUydpxhIlVljN4MwU9TF8ALUCjtJisgjB
	 homhjr+H255hABTPdxVNVju5rAM/Z3aIY88zMYBYcoCyw0u8C/2XpuJ9wD+WuTITxfqYj
	 osGv8EGelMA/9jZiigZgLl0Wd4SNjvZR10FhevdEm4malD7PMtN63CMLumMqtLEq1B4sP
	 wuvG1rCBxDwaNtvQMC1x++AeCaE3v/Kj+GIaFZ8pUi0eccYp4xJS2XLQK1796dDVdOpPA
	 uVv6QZWBMrUea8eaqIlorLLaWt4BfHDGZThxvHsE2bNrJAxi6+v+petcD/Nive/HFLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="rBObu1i/";
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2942606A31C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 06:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2942606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rBObu1i/
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a210470b49so5030155e9.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 22:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794985011; x=1795589811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hmY1fbech5A7U0m4vw5C/3DGiyMfg8pnccZ+bvgK6gY=;
        b=rBObu1i/rpQarj0I8UpR5grTno7t2LHI+msoymgcp1Fv2IKetJH0dMS4L0GFzr+4bL
         IYafhxCkzagFyyL35+5kD9PlF7flIR37yZ1nJInS0kbwgBQYqgg/rzd/xkCd7iLtTzHE
         KPxiGhz0U84KaPqSdNTHrCQV3XJejfLIlYqMKNcpuTxgcvz+pofm8fQnYICNtvdD2Q17
         Jv1oj1T9C0ZpyANNaHhDlASNYOnDOYAcG84Ieh5e4LcCgRH3jRA2F1TKZTeTJyz1Lp0k
         qBtxR1rJfHKE747/FLR1q2wRGKKR7WwtzihKg7RkdRo0Xh/JNaD1/QCP74wrPxgclzaf
         L3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794985011; x=1795589811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hmY1fbech5A7U0m4vw5C/3DGiyMfg8pnccZ+bvgK6gY=;
        b=jhTan37LIrwbbhu7IV4cPs+WAJ4BzfY8YbWTZdbg86Lg1/txP7R1qmFl5Pqbs6e5V1
         jm07T7IuKpf+KQVZ6+VjI/ORPU5kN1W3uYgg74H4jIXx0dvAGTV6xd+NbcAZN995OAzb
         P4fCNXtY4BY/Lcilo1IiQxYOmMwZ+LvKtDC3cIUhRwK90fk7TOEtTgToqsl1zhCcxkow
         bi0bM3FNXlpxlOK/qbcOAdQWOEfm10CgPAJe5e7GxIPEC0OqlzQZ0BDpehWVP8zyOB+u
         0g9hhYNInjnguZ6NEuLY3R6T4wAJwAZxqtueP7/7Mgr3zBIhRx+bNVGheY/eVGkwNAEv
         8G0A==
X-Gm-Message-State: APuU4Z8+Ya7cpgfzBrrY3Mff15bfg2eyW2qErYuAYtslYJM/rE7vxJEF
	pLlb7KA9YxGfiEDgKuzIelycHLAOtpVgRXjt9TMsOqUD3ZHA/gvOHvFq+Ktr3Q==
X-Gm-Gg: AYBFou2Du8w4TdWs2e8YoQmzsYSw6IP7h9ESWieamiwQ021E+ssy4zFzPCLFo/2EElg
	AZqr32k69zqWOBQ1td9ivJW4m1/041jSp8ozaDNjUjqqJyJSoNXfsp76V78lSevDBdHfBvyDiWW
	LcyXNjMyfnW2SucmlhphVzmhoNxbRu/scB9+KRT5Dm8bXVzupLjOy8p1DGkewwzzGJBRXWda4uq
	4xEX6pp4LIWkynZSI4LM6z5CHoDQK/MMc1a3/8pdwxT8h4FlTZRuinmueqMktlTm2dSHD+O/89E
	xhZnWYuGfJUrLOnWEPgF4p1xdS9xCYdqO0Qema0wOFFdsKuhqmTw6/yvl4ls2AM3fquZlvCfyjc
	OoUIL2ejj6OfK1oMmiP2WHc/vXOOgs9S0z2/l1CLZ5qWOoEIHweUo9D3Is80PdqYARuZUeTiKgs
	QPktfeYtXypxE0SdVTLIGntyjC+Xi2+tv4y09avrrEg4V6NCKuvtx8/6XQ/jUJXnLaKh519o4Y4
	wlHMnFpNtBotyXuX239Dxd8IHsTFNSe5n11ymWFhO3yhN9a9FJuc5a1wVTQ8hTRUQu3Ch5+jTJU
	UfaE78Jb+auXvwyYZy6GMYVgW9wJAJOkAeDo1g6THejboLNy7MRS2+hbPSILT6s=
X-Received: by 2002:a05:600c:4504:b0:4ba:7e6:53d6 with SMTP id 5b1f17b1804b1-4bb7da52ad6mr25767235e9.33.1794985011318;
        Tue, 17 Nov 2026 22:56:51 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783f7eecsm222311235e9.3.2026.11.17.22.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:56:48 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Jonathan Tan <jonathantanmy@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 3/4] index-pack: use size_t for object sizes
Date: Wed, 18 Nov 2026 07:56:37 +0100
Message-ID: <e66860d27488d61e942dc5dc3fa2c7bffb50b2ca.1794984184.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794984184.git.gitter.spiros@gmail.com>
References: <cover.1793446357.git.gitter.spiros@gmail.com> <cover.1794984184.git.gitter.spiros@gmail.com>
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

Functions like sha1_object() and append_obj_to_pack() in
builtin/index-pack.c take object sizes as an "unsigned long", even
though struct object_entry already tracks them as size_t. On platforms
where "long" is 32 bits while size_t is 64, such as 64-bit Windows,
this truncates the size of objects of 4GiB or more.

When receiving, on those platforms, a large object that already exists
locally, sha1_object() compares the real size (size_t) against the
truncated size, resulting in a false "SHA1 COLLISION FOUND" error and
aborting index-pack.

Use size_t for the size parameter across these functions.

Triggering this requires processing 4GiB or more of input on a platform
where "long" is 32 bits while size_t is 64, so no test is added.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/index-pack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f65228468b..d4c073654d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -588,7 +588,7 @@ static void *unpack_raw_entry(struct object_entry *obj,
 }
 
 static void *unpack_data(struct object_entry *obj,
-			 int (*consume)(const unsigned char *, unsigned long, void *),
+			 int (*consume)(const unsigned char *, size_t, void *),
 			 void *cb_data)
 {
 	off_t from = obj[0].idx.offset + obj[0].hdr_size;
@@ -765,10 +765,10 @@ struct compare_data {
 	struct object_entry *entry;
 	struct odb_stream *st;
 	unsigned char *buf;
-	unsigned long buf_size;
+	size_t buf_size;
 };
 
-static int compare_objects(const unsigned char *buf, unsigned long size,
+static int compare_objects(const unsigned char *buf, size_t size,
 			   void *cb_data)
 {
 	struct compare_data *data = cb_data;
@@ -881,7 +881,7 @@ static void do_record_outgoing_links(struct object *obj)
 }
 
 static void sha1_object(const void *data, struct object_entry *obj_entry,
-			unsigned long size, enum object_type type,
+			size_t size, enum object_type type,
 			const struct object_id *oid)
 {
 	void *new_data = NULL;
@@ -1438,11 +1438,11 @@ static size_t write_compressed(struct hashfile *f, void *in, size_t size)
 
 static struct object_entry *append_obj_to_pack(struct hashfile *f,
 			       const unsigned char *sha1, void *buf,
-			       unsigned long size, enum object_type type)
+			       size_t size, enum object_type type)
 {
 	struct object_entry *obj = &objects[nr_objects++];
 	unsigned char header[10];
-	unsigned long s = size;
+	size_t s = size;
 	int n = 0;
 	unsigned char c = (type << 4) | (s & 15);
 	s >>= 4;
-- 
2.53.0

