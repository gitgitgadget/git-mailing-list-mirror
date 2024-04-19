Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352ACDDD5
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 05:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713504164; cv=none; b=nZp8UHT0mNWooz1mrRKVwr0SEIStl9ZYDa8BoGmtN/7Tm9ZEY723jdOua6VKZ3kw//wZvpog8207Rb8dW9Y8a7+bX+GgXR8BG0dosNOWAkpI4H7De/fU4SbRITeM+kHVQ/6do+fUFMHK23T0Yz87U/7Q3uiTC4g+GnIn5AJnAT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713504164; c=relaxed/simple;
	bh=es/8xvwikbdf4BTLJ8Qn7X1Yb95TjQhL82KXUPLxrrs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oOHZLUBZ94XuLxkQtL6erA5n1p+qHNIarkQXuU1KubkOUWoMW/C8sfMYPqlHaROBk1Mr3xBP8iRnZ79SKzMgSjwZfUa4xrAIgG3ia7qlCmU8qOlcVZY2HiSCmGMrax3w4F7yTd+dqmNRzT4HZUAOuWGK6FyApJYea08SO2I8z5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agEOBht9; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agEOBht9"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e78970853so4316135a12.0
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 22:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713504161; x=1714108961; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5jundgRnTRZ1UeFsaoiYa52OHNNlsJEIZK+0TSBpDI=;
        b=agEOBht90C4kSNZNcE8elB32Ztn0UzO2sMhwMhM3r+CdRFPxkyWZPR0gaMkQh/0/tE
         szhc79/ibBhN7NlBelrQ2sdPXW5HfZ1t8qrGRyuxWM+LJCCGtUu0bPuxwbMuMawNFHBG
         F9yvoDAwggxAopjs2ymEkC59v4PABGVFM2jPCs8xYO5GyOgSFwHu4xfwOej600WLM/bf
         EqAoPnOUDfcho/6KivNCtoLC0tB3mpQVaNdXB2Z7gLyxSR+oZLASk5oWVf5B4SvFnh7L
         GnNABjujA/jQM6aEVa/hyy+UuLCcDv8/a/L3vdCGL+vz9hHTJ4NbBXcXnLcdDqMyg87S
         eSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713504161; x=1714108961;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5jundgRnTRZ1UeFsaoiYa52OHNNlsJEIZK+0TSBpDI=;
        b=vnz+/dLrGxz+ftDyXKv3dg1pRXUTFuf4sryV7YZFi4Cn9q96V8MfdHviH/+Ircbbde
         z+25ABShqeQyB/BbjFEDsIuP2ZijbpBCZSzCD1W3vK2x8+4+/mQBPXLRtCD+9Uo2tnsa
         vRylpMwOxfKI3u49Xy4d5lyonz8afZxCUpDpnqbXB3ZGeb7p2D7Z0ov9pM4O2ERstvMl
         Nzz6/EEGo9iDNbIWXyoCgSjvzqM/uOig7q9pbAQNF2YnsWj4WIKFt4Bqyqct9MAZu2Xd
         5PSttc+P7mY9j6JKDCCoHk+bTkTNxm7OE78dtP38T57giZIsvzgkyGVS8cOZaSd+602E
         S9zg==
X-Gm-Message-State: AOJu0Yx1EdMWIUVjPyoN1ofHaJEheqy0u9YVRMJtc9LCkBkJE3Nunf+C
	FeOi0TvNXqxOyXXbQOCJ9HV2xFg90IEx8PcGTxBYRK+LwT0QnheQyLFJWg==
X-Google-Smtp-Source: AGHT+IFW5xWDm93nipAThpSUZk7CUh9J9hUqPuFSScF5sbjcDHP4YS1yRBWiD47eqkWeUo8rv4HnYA==
X-Received: by 2002:a17:906:c812:b0:a52:a25:2077 with SMTP id cx18-20020a170906c81200b00a520a252077mr3580599ejb.14.1713504161225;
        Thu, 18 Apr 2024 22:22:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k26-20020a1709063e1a00b00a4e533085aesm1699780eji.129.2024.04.18.22.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 22:22:40 -0700 (PDT)
Message-Id: <e961d49cd40f54f63df64ab0e42b9632d35d7a20.1713504153.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
	<pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Apr 2024 05:22:30 +0000
Subject: [PATCH v2 5/8] interpret-trailers: access trailer_info with new
 helpers
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
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Christian Couder <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Instead of directly accessing trailer_info members, access them
indirectly through new helper functions exposed by the trailer API.

This is the first of two preparatory commits which will allow us to
use the so-called "pimpl" (pointer to implementation) idiom for the
trailer API, by making the trailer_info struct private to the trailer
implementation (and thus hidden from the API).

Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c | 12 ++++++------
 trailer.c                    | 21 +++++++++++++++++++++
 trailer.h                    |  4 ++++
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 11f4ce9e4a2..f3240682e35 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -141,7 +141,7 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	LIST_HEAD(head);
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf trailer_block = STRBUF_INIT;
-	struct trailer_info info;
+	struct trailer_info *info = trailer_info_new();
 	FILE *outfile = stdout;
 
 	trailer_config_init();
@@ -151,13 +151,13 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	if (opts->in_place)
 		outfile = create_in_place_tempfile(file);
 
-	parse_trailers(opts, &info, sb.buf, &head);
+	parse_trailers(opts, info, sb.buf, &head);
 
 	/* Print the lines before the trailers */
 	if (!opts->only_trailers)
-		fwrite(sb.buf, 1, info.trailer_block_start, outfile);
+		fwrite(sb.buf, 1, trailer_block_start(info), outfile);
 
-	if (!opts->only_trailers && !info.blank_line_before_trailer)
+	if (!opts->only_trailers && !blank_line_before_trailer_block(info))
 		fprintf(outfile, "\n");
 
 
@@ -178,8 +178,8 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 
 	/* Print the lines after the trailers as is */
 	if (!opts->only_trailers)
-		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
-	trailer_info_release(&info);
+		fwrite(sb.buf + trailer_block_end(info), 1, sb.len - trailer_block_end(info), outfile);
+	trailer_info_release(info);
 
 	if (opts->in_place)
 		if (rename_tempfile(&trailers_tempfile, file))
diff --git a/trailer.c b/trailer.c
index 4700c441442..95b4c9b8f19 100644
--- a/trailer.c
+++ b/trailer.c
@@ -952,6 +952,12 @@ static void unfold_value(struct strbuf *val)
 	strbuf_release(&out);
 }
 
+struct trailer_info *trailer_info_new(void)
+{
+	struct trailer_info *info = xcalloc(1, sizeof(*info));
+	return info;
+}
+
 /*
  * Parse trailers in "str", populating the trailer info and "head"
  * linked list structure.
@@ -1000,6 +1006,21 @@ void free_trailers(struct list_head *trailers)
 	}
 }
 
+size_t trailer_block_start(struct trailer_info *info)
+{
+	return info->trailer_block_start;
+}
+
+size_t trailer_block_end(struct trailer_info *info)
+{
+	return info->trailer_block_end;
+}
+
+int blank_line_before_trailer_block(struct trailer_info *info)
+{
+	return info->blank_line_before_trailer;
+}
+
 void trailer_info_get(const struct process_trailer_options *opts,
 		      const char *str,
 		      struct trailer_info *info)
diff --git a/trailer.h b/trailer.h
index ebafa3657e4..9ac4be853c5 100644
--- a/trailer.h
+++ b/trailer.h
@@ -97,6 +97,10 @@ void parse_trailers(const struct process_trailer_options *,
 void trailer_info_get(const struct process_trailer_options *,
 		      const char *str,
 		      struct trailer_info *);
+size_t trailer_block_start(struct trailer_info *);
+size_t trailer_block_end(struct trailer_info *);
+int blank_line_before_trailer_block(struct trailer_info *);
+struct trailer_info *trailer_info_new(void);
 
 void trailer_info_release(struct trailer_info *info);
 
-- 
gitgitgadget

