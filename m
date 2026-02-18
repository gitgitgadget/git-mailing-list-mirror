Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C76332ED58
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771423757; cv=none; b=CKZ/xEhLO1BQlpbh3UIFRi12D4AsjEg/HU0NZOog2gHbsQihsMFMW//mn9pU7Y9PIW5hugs2Bp7vaWPoQvNxvCUpe2CVgTfGQgSL8zZw/VO0ARLsSP2jW8hFzJSU58kFd7Ax+feOqfUMo6Tw08x7MCS2nRHWiZ4JeJeSMMfvNMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771423757; c=relaxed/simple;
	bh=Sxy2nVIlZZp91jUZHWrGuGmqqgzPvYqv7v1kcTT9N9M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CUwOxXfdqMEXLKB/COuA/OivlOs7b+zVs/qAnFDjN0ZBPkTC8UoskYuUtwtUCk6DwYZaS/QIcxW3MWF/E/QgfBC7/7w0hR5cjyWjuk3AbnWXwkyKeT/Jcq55XO7/4jierGhXkYX4lSUgr1UasDBq9twEOaHbUBTug1sCvEyYcro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVbXcnIf; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVbXcnIf"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-1270be4d125so607432c88.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 06:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771423755; x=1772028555; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpVSl0rwwidbQyKEm5Ba56mUHn6+FPBpNAwQCRGAsxk=;
        b=lVbXcnIfACEX3QnkplNJTb8dIFYTGiJEWm0amOXflxwiPkPkGVbNKd+Pzovrts/kcf
         3RVe6CFe9dzMIvRfs0b+yG4u+MrVxQgJ6ik8uX6AOgRqBfyDkn+hVhKMSjRClwDSR3FW
         OnUHQI4VNzjoEWQ56Hf5YMBYm1yRuNEptd1CUWEJB4SW/+20m5JmX8qivvmaah0wowI+
         kk2nuAYcFegIMGrTduiD1w+5Lu2Hawyn/FedMIX+xgycZlkHdQcvzJvQgRJEEnvHICH3
         r0TWda0wrzxnDJZONCKCRGkTBgyQg6oEg8W50B7jWdnWJeYEup+s0tMshLFfEWvo3nkN
         Dfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771423755; x=1772028555;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EpVSl0rwwidbQyKEm5Ba56mUHn6+FPBpNAwQCRGAsxk=;
        b=TYjNy/6xTZXF9NDwCvkigR3ZeBBFNgicp15LktfKXoraGdg2bN0O6GfEoK1MRPtjAW
         2XVU23PbcNiNcfAUAFj/AGCEy9kIiFZRmDELWH0zt8zyCt0c6eshtJndOVVobedxfyG4
         X1VfWy7xhexia51L9VCYnRqArO12OzUsSN+XRJvvyXoblM8WbgR4paISpqvdKwkfP8o4
         GCx3uGohbS4HxaR6kaUSpZq1BhxK2vD63HdwlKqagnCB5WxjaHvgYOb0lrSH8ThDY/4T
         U3Xb03t/ooXAJelskRMcNLb9UQmmEkEQmVN2HBIikhJVixebNth03fxNTv1BIQLEeH9o
         8Bug==
X-Gm-Message-State: AOJu0YxRPNPd32JRQu8dEOsPXfoGfGW5ib7mluCnc5dqzhztpkbsfrOT
	+Mf384YsK/g1shr//tvEf4rzoZoXB2AlpnQ3IcRZ26AIvzH8m6EXEUrBFDiR/Z6zo8g=
X-Gm-Gg: AZuq6aLvQ/9Odu3sMDA57kpNdL59/InA5Zk8gA8+RgPvStCslQ5bnUCB/ZN3l5962GL
	mxPhT6WxA87c+u8/4C+IkOZOM/mt9fq/gMtzjaSIUI87vmWyYrBw7eK7IfgvpBG8MXoqDsmphpw
	dZDBgLXCY1tcmw/ZwIprd6O9OiEyxegkcK7ayghjG7O+m1fPypRUGFdqqKX6BVv4A20eGKH5F/P
	DEsddTjXxHoPta/zeLkLsRotUMTSxN4y592pe0+cLq3lWNVKOwAZtOeyByA/Zz3YMhRSBq00aoT
	3fbACH7i0I3rvthfbbJ6KUiPWrEj0XM1iDAJNRuOgsN8Rwg93bTM3R4ir8y4OP4dmc4WiTshpSI
	dx+/CwVMO4Y6aqwZIPL0fWCjLhC9O9oDsjZF3ymOuYD5rbvmj2wVCIheO/PHWzRl4W0x/U6iPmr
	7s3TXiTbAM4dPeDzX6AXP66dDZ3Q==
X-Received: by 2002:a05:7022:2387:b0:11b:f056:a19b with SMTP id a92af1059eb24-12741b8155bmr8344263c88.18.1771423754954;
        Wed, 18 Feb 2026 06:09:14 -0800 (PST)
Received: from [127.0.0.1] ([52.159.225.192])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cad9desm18468372c88.11.2026.02.18.06.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 06:09:14 -0800 (PST)
Message-Id: <f48b1f07c45f6237f91fa6f746c58b791edef5bd.1771423748.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2008.v4.git.1771423748.gitgitgadget@gmail.com>
References: <pull.2008.v3.git.1771326521.gitgitgadget@gmail.com>
	<pull.2008.v4.git.1771423748.gitgitgadget@gmail.com>
From: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Feb 2026 14:09:05 +0000
Subject: [PATCH v4 2/5] strbuf_attach: fix all call sites to pass correct
 alloc
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>,
    Jeff King <peff@peff.net>,
    Junio C Hamano <gitster@pobox.com>,
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

From: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

strbuf_attach(sb, buf, len, alloc) requires alloc > len (the buffer
must have at least len+1 bytes to hold the NUL). Several call sites
passed alloc == len, relying on strbuf_grow(sb, 0) inside strbuf_attach
to reallocate. Prepare for changing that by fixing call sites to pass
the correct alloc.

- mailinfo, am, refs/files-backend, fast-import, trailer: pass len+1
  when the buffer is a NUL-terminated string (or from strbuf_detach).
- rerere, apply: ll_merge returns a buffer with exactly result.size
  bytes (no extra NUL). Use strbuf_add() to copy and NUL-terminate
  into the strbuf, then free the merge result, so alloc is correct.

Signed-off-by: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
---
 apply.c               | 3 ++-
 builtin/am.c          | 2 +-
 builtin/fast-import.c | 2 +-
 mailinfo.c            | 2 +-
 refs/files-backend.c  | 2 +-
 rerere.c              | 3 ++-
 trailer.c             | 2 +-
 7 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/apply.c b/apply.c
index e4c4bf7af9..d67d86bce4 100644
--- a/apply.c
+++ b/apply.c
@@ -3589,7 +3589,8 @@ static int three_way_merge(struct apply_state *state,
 		return -1;
 	}
 	image_clear(image);
-	strbuf_attach(&image->buf, result.ptr, result.size, result.size);
+	strbuf_add(&image->buf, result.ptr, result.size);
+	free(result.ptr);
 
 	return status;
 }
diff --git a/builtin/am.c b/builtin/am.c
index e0c767e223..c439f868dc 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1188,7 +1188,7 @@ static void am_append_signoff(struct am_state *state)
 {
 	struct strbuf sb = STRBUF_INIT;
 
-	strbuf_attach(&sb, state->msg, state->msg_len, state->msg_len);
+	strbuf_attach(&sb, state->msg, state->msg_len, state->msg_len + 1);
 	append_signoff(&sb, 0, 0);
 	state->msg = strbuf_detach(&sb, &state->msg_len);
 }
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index b8a7757cfd..164d8a6198 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3246,7 +3246,7 @@ static void cat_blob(struct object_entry *oe, struct object_id *oid)
 	cat_blob_write("\n", 1);
 	if (oe && oe->pack_id == pack_id) {
 		last_blob.offset = oe->idx.offset;
-		strbuf_attach(&last_blob.data, buf, size, size);
+		strbuf_attach(&last_blob.data, buf, size, size + 1);
 		last_blob.depth = oe->depth;
 	} else
 		free(buf);
diff --git a/mailinfo.c b/mailinfo.c
index a2f06dbd96..13949ff31e 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -470,7 +470,7 @@ static int convert_to_utf8(struct mailinfo *mi,
 		return error("cannot convert from %s to %s",
 			     charset, mi->metainfo_charset);
 	}
-	strbuf_attach(line, out, out_len, out_len);
+	strbuf_attach(line, out, out_len, out_len + 1);
 	return 0;
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b1b13b41f6..6baba11f96 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1806,7 +1806,7 @@ static int commit_ref(struct ref_lock *lock)
 		size_t len = strlen(path);
 		struct strbuf sb_path = STRBUF_INIT;
 
-		strbuf_attach(&sb_path, path, len, len);
+		strbuf_attach(&sb_path, path, len, len + 1);
 
 		/*
 		 * If this fails, commit_lock_file() will also fail
diff --git a/rerere.c b/rerere.c
index 6ec55964e2..2f4809a310 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1031,7 +1031,8 @@ static int handle_cache(struct index_state *istate,
 	else
 		io.io.output = NULL;
 	strbuf_init(&io.input, 0);
-	strbuf_attach(&io.input, result.ptr, result.size, result.size);
+	strbuf_add(&io.input, result.ptr, result.size);
+	free(result.ptr);
 
 	/*
 	 * Grab the conflict ID and optionally write the original
diff --git a/trailer.c b/trailer.c
index 911a81ed99..3afe368db0 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1009,7 +1009,7 @@ static struct trailer_block *trailer_block_get(const struct process_trailer_opti
 	for (ptr = trailer_lines; *ptr; ptr++) {
 		if (last && isspace((*ptr)->buf[0])) {
 			struct strbuf sb = STRBUF_INIT;
-			strbuf_attach(&sb, *last, strlen(*last), strlen(*last));
+			strbuf_attach(&sb, *last, strlen(*last), strlen(*last) + 1);
 			strbuf_addbuf(&sb, *ptr);
 			*last = strbuf_detach(&sb, NULL);
 			continue;
-- 
gitgitgadget

