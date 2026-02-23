Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AB7155757
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856411; cv=none; b=JbYLv/Q0GksaDW7VGIKq7vP2k6gK3EADfkv9VfQty4hYUe0LEih16zwgqakidReKy/LtVurEK3mDY6G2RiVgPo/fAPJ522nHXBon9raJWXjThEXpCpjjzFzOyQm/Oim7snedi8UXYoEZQ2kG4X3Aib98f+LB7EnXEezQbX2YRes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856411; c=relaxed/simple;
	bh=YARETGIXSptObP0ca0avtPSsnBqJ3qv90GtM9RzEwC4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dgfWgv1hXP76Yr7ZB1DabpKLRgOYQC8G12oxpWtIMdV6L7kt2WnGCbBQdDm1p8ZKfMLoTxYRbixCPBiUZTNzwAKGVL3UeHJ9Hg8lHHIUrJpSYE9kPItyT1CUuFQfezRTGcGbAPcQlMm2+QtjVxX5/r6Da/mBNDSpUNgNWFdzeqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVvY7SkE; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVvY7SkE"
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-896f632d206so52828336d6.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 06:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771856408; x=1772461208; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lWaHip46eCbIcbjhus4Q4+AnvoEqW0AMUhLNlu1roE=;
        b=ZVvY7SkEiskbWzfVgaRPBu+WxYAZOKz74t89a89EehyPdcJ58fdJYavVzLDwf0h8tn
         exf5d6YL4sFDNvSduKtjFM7V2MrndXA7EkLJBQpolJBbcEQxyyK5ApQ9ePcKIjceTzos
         iljUdhHx/61zp4RsfZPdpuQrpq+xx4Gok2UnUfRyI3hFQ8kiuvPCUaEel6KH5WQWz3l9
         rQpeBuom9tV7Ygm/uTuBArt1QFSFSir9e9HpIr6k4eNCjWPWUHNiQ7/rybLstkgnZasx
         qtm6uch6POu4ESpOOKL/Un3IazopLPXvhggTVYLc+8MDdqqEouiSCJ0mtdC8QjmSQEG7
         AaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771856408; x=1772461208;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0lWaHip46eCbIcbjhus4Q4+AnvoEqW0AMUhLNlu1roE=;
        b=mmPIIZeZ3orMKDk3aYQC5S51naizwqcEacCznplvOmcmoFoUXmWWBsnRQ7GVHnlin1
         PLqvlyyBNflrQAdWqo0pzBSJeeAPhuRSsEy2gnk+v851UYFOZGguvx6nmmYaIHLzoj53
         oe6jR7XPQSLS/x9eEhNqssME7NdMNl9mlnNHojg1PQYXdOCDLtkXcEO1OXSyAFGQwejg
         alzVJ7ynyKd1SAW2X/ARrPTJOF0RJEW9IR48F9qO2LZleJLHVrav3XEZvkMLbg92xWrU
         Rkwo9OvfH1h9mlLT3aNCnuYsYMi9NE4la78DxENv4s8HkL6PoMly0Fwag6XDgPsLE/XC
         +0cg==
X-Gm-Message-State: AOJu0YxvpbQx31waPANZlPpX+N96xcqQDaLs5/lo4mMF4cZmNnnknTxv
	zVupmPNOqhp4aOJbb60A865MDqciOYl0ZcE5mB3UrvbzxjGv9Glrpa/vaArKAmoS
X-Gm-Gg: ATEYQzzYn3aSuqtDPQmn7jYoThD/j2H1/hBWXWmj7MlXAFgtrmhUdGuPPRqJpxDFpVh
	IgsaD4fuNdLonevIrRkmYfxkK+TFd3pJv55e9UP+Z+CF2Xz40P8kdx34s+x3LoQdTFSbPwCvpmP
	m0HywHG2ZfuuItXw4UuSsCU/QwT8mWkkdTR7gOG/a2dNdzac6p5FISnz8ruOTza4/Dar+XrN4Ia
	UZaOm0OiI3fsDnJa5/b5JPGEyf/SMis6BlN/RbTt+83yvtlnEz7qdVa9Qgl8MGokuv6JgBDAzHy
	fDJIADK+2GWj4Tg8R+fKeXAXoxUK5lTi2Fq/F1mexIr1WKbUVcM0R5apUEYCwDOAE9/QtK1v1H4
	DA4dmvypAfXgcqPZXfWd+jN0Sveq4HBs1IwlE+IOJ6XcyOGti5Mp2P0X5lKO0UJsCiOXFz8k7gA
	LxkY5+ZKxopBSs6l/qG735JD74bdpScxH7AWg3
X-Received: by 2002:a05:6214:2585:b0:88a:2b3d:31f with SMTP id 6a1803df08f44-89965c7bdb8mr197458946d6.31.1771856408533;
        Mon, 23 Feb 2026 06:20:08 -0800 (PST)
Received: from [127.0.0.1] ([135.119.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997c6bba49sm77660816d6.15.2026.02.23.06.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:20:07 -0800 (PST)
Message-Id: <3e0b78cfb66d7b903363e8e5e18720ed4894fbf5.1771856405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2008.v5.git.1771856405.gitgitgadget@gmail.com>
References: <pull.2008.v4.git.1771423748.gitgitgadget@gmail.com>
	<pull.2008.v5.git.1771856405.gitgitgadget@gmail.com>
From: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 14:20:03 +0000
Subject: [PATCH v5 2/4] strbuf_attach: fix call sites to pass correct alloc
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
to reallocate. Fix these in mailinfo, am, refs/files-backend,
fast-import, and trailer by passing len+1 when the buffer is a
NUL-terminated string (or from strbuf_detach).

Signed-off-by: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
---
 builtin/am.c          | 2 +-
 builtin/fast-import.c | 2 +-
 mailinfo.c            | 2 +-
 refs/files-backend.c  | 2 +-
 trailer.c             | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

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

