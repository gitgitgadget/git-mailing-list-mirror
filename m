Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D757C088
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196361; cv=none; b=uwqq+aQlo2CUKhBGniUNvOAqrwJPBNgC01vFzVZgL0atJpOoS5SvtDaWfVSXSQCR3fTTvt2zMJz/4C/y/qR3ZVo9BtVFtvIUnQ4bT0X4Mxe+pMtTRoJC5WdBCN0iz9fbT7m7m2PeI1b2izjC+EbEcF2iZajk/oQv+LnFJL4Tozw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196361; c=relaxed/simple;
	bh=ttUB/lGc31VezpwkxCUqYNd8Tz9/24eZbrL+BweDCnY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=X+/nD+BR+P2xvYmiJsvP5XUcsZrg43a+sQHAzPaOa3cxWbJzAVcc4VX8DL4PE900O2GbCaviB0IFqjtAFEvy555Vn06WISHMLrJ//u5c/zW3MmQLl/9zc1ja+fz8zxOYfkywyOVYh+yq893KuFvvtOSpLYlbMP2Ni82mKpKwu/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFd0FZCI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFd0FZCI"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fc6343bd2so34058145e9.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196357; x=1707801157; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2ChbUKr39IIl/empUwfg3AmHJCZvdutzce068y7PcQ=;
        b=VFd0FZCIEV1vRxXhO+EL1RQP2yl+PiQuI9GMRcmVZ2+DsAJUOxA0ne0LqDZXih06s/
         Im13Fad2we5hhqAUnCdM/+i2oIeanW8U9oWpeFQ7BPHcK8BlC7x7+hwJcGwr/CttWgQm
         LMWC1mQe6wIFbLP2zxutr7yzsdRG2HpQnX973P3hb+TemItJIe+50bWYj5MWr133C4FM
         +Wcj3hXqCX2Yxbodx6lj7hKtmcFBivUrMhl8V0TQzDklOofPq8KY60rSnBCp9SCld6Sj
         7sbUPpHm0nur+gOJUDCbeRoik3Go8D8+yWx2u+6M4Zt/l+vpB8chn2BXfsmsnWxpd9bz
         me+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196357; x=1707801157;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2ChbUKr39IIl/empUwfg3AmHJCZvdutzce068y7PcQ=;
        b=wvqqXLWqdu7exUCGPDyCx2e8tknt7wk0iTwtiSeZs+zycJcX9Wdgltbv2fG0dRkyJ3
         XN8zE9EGdefxsZ58ETNtcwiWOTYNvNMqPd8DwbMlBvWT4daFnQ6HXEQQMRgB1WrTfmnF
         enGiJ2Ipwf5wP1HPv+Ql5gYlBpikCusAPgEXrxWKGI9y8fxqIZXplajen4eAciKYUcFq
         tJBYJ1szhe54+A6DOz4jTvvGIECgqtOZPGZFOHpxcZTnGoUOCjvvUkxIzORDwhYnQ7MC
         HbMM+hwAkCaIgXOAIQI1fg97Cl/3gjoWfmJiLQ3kjvWytHDnMa0zrAzCXitYGe2xqA0s
         YrCA==
X-Gm-Message-State: AOJu0YzkgEFp3CAy0YPoluGpFhfp+T11JbZZq35P1139YwSeGeR446I8
	c5ltdKd/RYusf6v/tCEC6SA9xtNCvA15Rb9HVJYeBIBSoAW+VyoWW6g7G4xL
X-Google-Smtp-Source: AGHT+IEIqAQZOXUSPOhwTacddVPVpn8MRdrpnheX/fhLegU+NYz0eevVyEzVx9+LMW8T8MOUsvJHGQ==
X-Received: by 2002:a5d:4704:0:b0:33b:3b88:e357 with SMTP id y4-20020a5d4704000000b0033b3b88e357mr344203wrq.35.1707196357074;
        Mon, 05 Feb 2024 21:12:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWd+RvLS//n1xE4zigFL34V3SVvBX8oYN1D8Zz1BSNiaR4t1V6uUfMHsSIwUD3sy6cOVTSuVvWH5e1jX2UUpa8YENGD4ZAbEck+JsZi1Fb5n4+qicwvP0kqOP+VI/8wcTYlyCfcbKE0KSxnAhX8geHjJDHlyRaoo6gad7zXcb3ioVOIcHvQftRhHfPYU/kY39wtSXjkXb3w0g==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id jq16-20020a05600c55d000b0040fb0bf6abesm639803wmb.29.2024.02.05.21.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:36 -0800 (PST)
Message-ID: <9dc912b5bc5ff07fedc0dd217b5ecb8a1eb10cc3.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:07 +0000
Subject: [PATCH v4 07/28] format_trailers(): use strbuf instead of FILE
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
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

This is another preparatory refactor to unify the trailer formatters.

Make format_trailers() also write to a strbuf, to align with
format_trailers_from_commit() which also does the same. Doing this makes
format_trailers() behave similar to format_trailer_info() (which will
soon help us replace one with the other).

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c |  6 +++++-
 trailer.c                    | 13 +++++++------
 trailer.h                    |  3 ++-
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index d1cf0aa33a2..11f4ce9e4a2 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -140,6 +140,7 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 {
 	LIST_HEAD(head);
 	struct strbuf sb = STRBUF_INIT;
+	struct strbuf trailer_block = STRBUF_INIT;
 	struct trailer_info info;
 	FILE *outfile = stdout;
 
@@ -169,8 +170,11 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 		process_trailers_lists(&head, &arg_head);
 	}
 
-	format_trailers(opts, &head, outfile);
+	/* Print trailer block. */
+	format_trailers(opts, &head, &trailer_block);
 	free_trailers(&head);
+	fwrite(trailer_block.buf, 1, trailer_block.len, outfile);
+	strbuf_release(&trailer_block);
 
 	/* Print the lines after the trailers as is */
 	if (!opts->only_trailers)
diff --git a/trailer.c b/trailer.c
index f92d844361a..cbd643cd1fe 100644
--- a/trailer.c
+++ b/trailer.c
@@ -144,12 +144,12 @@ static char last_non_space_char(const char *s)
 	return '\0';
 }
 
-static void print_tok_val(FILE *outfile, const char *tok, const char *val)
+static void print_tok_val(struct strbuf *out, const char *tok, const char *val)
 {
 	char c;
 
 	if (!tok) {
-		fprintf(outfile, "%s\n", val);
+		strbuf_addf(out, "%s\n", val);
 		return;
 	}
 
@@ -157,13 +157,14 @@ static void print_tok_val(FILE *outfile, const char *tok, const char *val)
 	if (!c)
 		return;
 	if (strchr(separators, c))
-		fprintf(outfile, "%s%s\n", tok, val);
+		strbuf_addf(out, "%s%s\n", tok, val);
 	else
-		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
+		strbuf_addf(out, "%s%c %s\n", tok, separators[0], val);
 }
 
 void format_trailers(const struct process_trailer_options *opts,
-		     struct list_head *trailers, FILE *outfile)
+		     struct list_head *trailers,
+		     struct strbuf *out)
 {
 	struct list_head *pos;
 	struct trailer_item *item;
@@ -171,7 +172,7 @@ void format_trailers(const struct process_trailer_options *opts,
 		item = list_entry(pos, struct trailer_item, list);
 		if ((!opts->trim_empty || strlen(item->value) > 0) &&
 		    (!opts->only_trailers || item->token))
-			print_tok_val(outfile, item->token, item->value);
+			print_tok_val(out, item->token, item->value);
 	}
 }
 
diff --git a/trailer.h b/trailer.h
index 410c61b62be..1d106b6dd40 100644
--- a/trailer.h
+++ b/trailer.h
@@ -102,7 +102,8 @@ void trailer_info_release(struct trailer_info *info);
 
 void trailer_config_init(void);
 void format_trailers(const struct process_trailer_options *,
-		     struct list_head *trailers, FILE *outfile);
+		     struct list_head *trailers,
+		     struct strbuf *out);
 void free_trailers(struct list_head *);
 
 /*
-- 
gitgitgadget

