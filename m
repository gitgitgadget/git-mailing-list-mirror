Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71614E576
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 06:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710570437; cv=none; b=ZUwiQHFvHdX3Og5oluQXNIc7aKDngCbP2sYfTY+YrTr5G+48A5MexuklXBt2JcJd0SqIHVkRbSPrxddjhjb3NywY6Gp90vRT3DkNNUwXEvN4BSUBv/yggcJT/pGkdv+NK1yrL6r5Gs/V4wRzfbOrZCNIMRiMTXYZNAaPUT73Uss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710570437; c=relaxed/simple;
	bh=es/8xvwikbdf4BTLJ8Qn7X1Yb95TjQhL82KXUPLxrrs=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iHxVn4Vi5WK6njlTwKpD5uTthrJxww3VSCPR0dJxswFSNjBbUkilcXlCFqOl9Aoyuu4b9k6h+qdky4ZGLQBUYqT27XrQt0ExnENKiNdH4HW+sNaAOkMz12q7toO9LZMpusEw/wevhyNxIWeuyC55t1QcESEIPxISAl3HeZoUDGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hu0CW+tn; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hu0CW+tn"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-414006a0115so13618205e9.3
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 23:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710570433; x=1711175233; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5jundgRnTRZ1UeFsaoiYa52OHNNlsJEIZK+0TSBpDI=;
        b=hu0CW+tnR0GwzlaFHQPwA2sWtUf9Id1E7r3nMhh6eKDbYTAt0pHNQ0bFpfwS6/GSOS
         DFJXBTtxDL81nndPDPoH/p3P8tAh1SRo2HaiKqOP659R2ENfUvggI0naX/LuYHb6IPWl
         CjBoLI5ROdUqp3uqvu4qYtvoV9Z5odq8JSxc57Xp3Ptht/KCkFNkPzjGVaIYzJl8jAJe
         DZWTDc9u4z90rlwlg9+jlZ6Fwv4kplSA45bk0EniqGYaDpe7c9t5Ko8iTyOlFV4LKjvy
         rbo/f70wWewZdfJhuPBKMWVBcKEhkT4Us5by1ho6xJ3M2SoIXZ/+ABHO8z2flVfCaxXW
         cLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710570433; x=1711175233;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5jundgRnTRZ1UeFsaoiYa52OHNNlsJEIZK+0TSBpDI=;
        b=vLJG9hPtxeLsW96CHzwubKc2yLfXAFtSzcquPlrocfNQnbSsWYYiMpF7Jm3Ay5wkNO
         mxWUUYD5joIfGbvHYtpTqN2JhsBE9FqLFEu0yWyGnFVaITgIRzFgZi4mU7/S9SzNCXQ2
         tUj09bu3BIfmTVrnyAFmgnB2rrgYTmbApEce3KBhflEO55om2D5U1ylTE9RoqabFQIqh
         6day6NEHRdttUww6LsKarD8EDZFouvrkguTZ5mnPNiEsdgb/gupHl6q6xnlnE27MIv4c
         peQGE4UFXmOi06Q7bzQD3JO0Xt6Kqdo0xrhdXYdSAgFxjKaA8lJjNUwG/g12HG9iwd7F
         7EUg==
X-Gm-Message-State: AOJu0YyVH6167qvhuXmIzkpgn8KPrdtBeUWGoX2ld6hR7xDZF+gwHYvg
	ANA9/UlWT4ZN1M3JibKDpat3pievGS3iyNLZCa3Kj1eb3VQZQ5Fgzy3GaIx1
X-Google-Smtp-Source: AGHT+IFyOYnFhPnRV4Tjb07+G+LH39lqa2WtAd3i2yQ2crb2SOUJryq6w5LUBU6t16x6hdST70YBsA==
X-Received: by 2002:a05:600c:364a:b0:413:3110:2d06 with SMTP id y10-20020a05600c364a00b0041331102d06mr852361wmq.16.1710570433118;
        Fri, 15 Mar 2024 23:27:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m36-20020a05600c3b2400b00412b6fbb9b5sm11158521wms.8.2024.03.15.23.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 23:27:12 -0700 (PDT)
Message-ID: <872e67286c8407da28ae704b9900ab63b7c407c1.1710570428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 16 Mar 2024 06:27:05 +0000
Subject: [PATCH 3/6] interpret-trailers: access trailer_info with new helpers
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

