Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA4A3C6A56
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752445; cv=none; b=TZXfIZRLtInk9LX6qaUZmBqi2hl9xeXYNyI/cwYzcw33PNpMwFPJpwwzGZJTF1or4qoCe2aoCukgMWZmJ3kfJMHJ4ewTWIT+ouCP4SWqCr6o84wQHe6T0cNXPC0BJmVPKebGSQNSA2zNWzJQo24gBa73/G0Hh6jFo2Mxxohbcfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752445; c=relaxed/simple;
	bh=UTxbFG9fEb4pNZvIq9z2hRzMSeiXjxVSwgsfLd47FDw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JaTAOpajMe5ihfzvvtk4GRRSwyYE3ohE7T9IFUxNfqC78dZHFOmix57OedoYN3E2R9InZ2I3modESYzOShv+1m8VujCgh3WkReZ0vRsK+aN0QTKYf+xOOC6lpiT4seUd5ATp7AK8nVG4gAQpwm/p3SJWjmZ4KQu6y5DdSZMqxcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiNvsFA6; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiNvsFA6"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cb4136d865so761013885a.1
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 06:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773752442; x=1774357242; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjFbBgwpLJMiwLxAbbBG/03oOCxVHaH/lIxk1pFLfMA=;
        b=UiNvsFA6vkucaAsV26NzSbUtyK1WnZfGaZh6Nm70+sdeAbXHIyCEdTLzPSIePLRh6F
         /e0Sxg8U2zrFk3cviLKjK+CLRdWo7NIy203nrBetSlKm0YblA4J9DymJF7vdvk+IgdN1
         Bx2WnitiXrpwvhJRapFFrj914pBHUvv0zJ9TNYQNSrIZjK+ZDbD/oQgtMb6cw9j0gHBc
         9bQ5SRbYrLhx8pb4LpHnoa4p6b1/tHKf+o/tNdS5C9gTzmQOaWnsL3dGvEIY1iDBm0CO
         IpCrU4KgPVIMkUYK0W8XUBZMONWRcGILfwF26fqFDIVsg9LZXuLgzEnB6E3u545vUTln
         xSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773752442; x=1774357242;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VjFbBgwpLJMiwLxAbbBG/03oOCxVHaH/lIxk1pFLfMA=;
        b=h0kT/XwHhYIUNyLOYxn1qI9w0HgIer/lCpm6wv1FXXguYwLOuAtLq5588wUY9l+Cia
         DPTswUUs/8ycKOJt2KHoZKWr7732AyWpykEDXYf+dW/FfoYPdPWN9y8cYbXivYdnSAsm
         iCripo96vyMBGU6l9ur3htHZCTBLSn6S59q6yszRdq6+gW7jy4KN1jPqPkMiVc+j/OsW
         ZlHZM4tTR6nQv8HaleThmW0JwKj3NXLD90TQIJ54RCSGaL/f6C6RM6ePY8KDl1/LdzNj
         0gmdEBU/NfJY4ky/tKVZZM7Le0Lmw+rjPABigX87WomRCSyQX01FFNkQot+dZNkNTnxw
         cz+Q==
X-Gm-Message-State: AOJu0Yz7QNJ60KidWceRqhHBW1xTx91n3DzhMimM0TuZoSuzFS9XivHZ
	DHb0JLvBwuJObfLoy8C4qsKiDudUU4+b4RQp+ZFczH2Wp94e9K9r9NCDUmF93w==
X-Gm-Gg: ATEYQzyEy2KsLITUtRh7UW/RjoLoS/uIupFeN5hCZdrHS0O8/roK/PZUC+Ku9PeB+kt
	bDseTTM1ckb9IUCBlk1cAUtajgyaTVY6RDaKl6OxcUGU8na3UL9kwXO+kwwtfGeA3bLlI56Xa1F
	Rj6bJMk/ouZYV/OMuRwrqSklLSrVV1qRVwLXJLWD3OnnLit9UUyCGWxz937BIVD8SNxBolSRYQG
	iPMdeoeRhjNWpMBFCMDjaK+Ghopt0ezbfNhpf7oGb8I5h59Q2pw5GBh+VyWWqJJcmaTE2G5nzUE
	UGCVGq8BrPiRSJJ1C8kyTGHOhkkh0YC/CglIxgvkaPT91Z6XXdjnkaxDI+TRMvzuKw7i/nxKjBf
	v/3RRn8UvvQXAvSTE7Ju3fNCDWpRmbi3D+l9/tEk49o2eqlrxQPTj96NBWsJJt5dagLo+7rxbCI
	F2GSug+oZX90acEaZ2EdjcNJA=
X-Received: by 2002:a05:620a:40c7:b0:8c7:1986:6b3e with SMTP id af79cd13be357-8cdb5a9e986mr2258205285a.32.1773752442321;
        Tue, 17 Mar 2026 06:00:42 -0700 (PDT)
Received: from [127.0.0.1] ([20.98.23.161])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda210da83sm1648653085a.30.2026.03.17.06.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 06:00:41 -0700 (PDT)
Message-Id: <0dc214d3c2f185398b2ddb1816ea87d0d53474c7.1773752435.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2008.v6.git.1773752435.gitgitgadget@gmail.com>
References: <pull.2008.v5.git.1771856405.gitgitgadget@gmail.com>
	<pull.2008.v6.git.1773752435.gitgitgadget@gmail.com>
From: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 13:00:34 +0000
Subject: [PATCH v6 2/3] strbuf_attach: fix call sites to pass correct alloc
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
index a41f95191e..6593a71379 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3250,7 +3250,7 @@ static void cat_blob(struct object_entry *oe, struct object_id *oid)
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
index 7ce0d57478..0537a72b2a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1813,7 +1813,7 @@ static int commit_ref(struct ref_lock *lock)
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

