Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0191836C0C8
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785069277; cv=none; b=B1InWLpioSRHha4LUXnSVf3/S4TZsFTO0jPuYw5C1t+9aQwTlQZ5BpwSiG/yBSx7Ph69wK8Pr542LEtCWYSHGiw+Eq5mVDYsw5CstpijUPB3Z92hT7y/9WG1adQja4pJHAWQE5PpF/9HIKkgUAMDSgxNX1XniPXUDKCXG4NdA9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785069277; c=relaxed/simple;
	bh=j0n6jLJqf9npPFaRWFTQXhkrEPYROeAuD4LB2WwzFgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2HTfO2gvla3WtJ5DXeQP4p04IDzXKRTG91lucIbBob2+ASVLrey96QyEHmvikbIHjiBm+oL7JHOCobaeN0MVxNwJH+9ceZ2klO4WyWE6ghf2w6t+wOxDRRrTOQzd3ZgMHsgzOGHNY6NsScFDrOh7Cdfhzv+2sLfRrFZdFBAgEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivNW+iq+; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivNW+iq+"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e7109321dso954491a91.3
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 05:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785069275; x=1785674075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PELSgKaXgocqykVwe6nbzrUwtE12WVvEr1wci9jr0gw=;
        b=ivNW+iq+RBqdWn1UywWNzHeR78atbbdfuCxxQdFRQzloaIrg0IsqZNnGjFbzIIrrfP
         /ZNJIt53MfdWEtGXev8fgd7y+DFvqlXMliIe1mWmvhb4nlNIiTIFQNYE4g1JDUB4XNtx
         pBie1LPaKIo0VNFLIQF047ehBL8uvu6pUoQEiMSU5OTS1EFqWtHklsuLTTb4FzuEfd0D
         n7/64Hd2Iy+1Nr9geOx0lXCAC5J2BW7BtugWz4V83F44c2kla9t728Ui/7o8PNZGS6Ja
         v1AheNqIU9VFHijHkNm9CWIvCOohqn8Qh9wgpwTHt/TC6rufoVX86SK5LCIz7QJpbM0F
         5cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785069275; x=1785674075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PELSgKaXgocqykVwe6nbzrUwtE12WVvEr1wci9jr0gw=;
        b=biZx/e0nnkRilafu0VNHEj+lmvEgaH5zxSJF+F5E7rDUsoxhE3LLl561PMu5zoBPYU
         bDDv95E94/kn1UZEk2lI0FsboaR2/OGbetaa3xx9S9Gz5F7cdDFBx292SJ6FcdyZdy+f
         nOJmo/6YW9XdS1YSNu/CfhktPS9/PkKrp1k8oh8Jk82PXmDZfZourHBYtTWU5DVuTLxe
         yWCutQ5KjMgMxipt1GNPR5I7safP/ouKqJPh1mVqTu9qzmCKN6BuGft3qzuuxI3t9DDQ
         5+mRC/myOQaYHNrTdGzGvubaRNF82+mWY0SWDA4c4OADJZLL/k7HfiPL0bBwtvsqhO6o
         hAyQ==
X-Gm-Message-State: AOJu0YxyLtxJtqBbB2QqTluSQRGunvWwp3tMirxpLKzZZzn/1R5GXjH/
	nFRq6zO58ckxrSCVjUAQAUsxN5OHa9WGTUt74seVjmXvOXV7h0Xdx2Ea54ZKUg==
X-Gm-Gg: AR+sD118uqfTqg8zkD/lDJy8zJrNO4Qxm2yK/mifDW9K9StHMuQ7a1RQ39+ArCVKdKR
	Z9gGZlJutYhxYmURYyI2vKpOM2E+g1HNiM2qa7QToebYDb154u46Y1zGw5RcSj82WZrYSQFKxRf
	miEvmzvcFns16GcPjVjujvZiZimeNj2eJJKZl0Ygi7iyOFkDuxPHM83BhsIfXUFqiMAwDFmwf4V
	57d/ULzGEwMsasgQVclHPKaVFmmNHP7NUzrPJ/npYlbkfXtDH9k8+04PTol2zeL9SYUEkY8Up7Q
	6d8giaekxqWqG8Q1kCjxmRr3wMfB5bguvxjHkWSY4m69N3YFag3tQSJXUM0bgZbs8tMGyfT6Kng
	X0n1xHQrfDovPtrxwUrV3aoSBkJbUCxr0nYI2Kf85iJZnJLLz81HFfJCIy6mJgin5OKC8zC+Sml
	d6Fs+q8Ec26YLjBq+vRqg=
X-Received: by 2002:a17:90b:4a8e:b0:37f:df85:272f with SMTP id 98e67ed59e1d1-38f295273demr5192448a91.19.1785069275202;
        Sun, 26 Jul 2026 05:34:35 -0700 (PDT)
Received: from fedora.tail0f6912.ts.net ([112.133.220.140])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d2d1d0d1esm21639286c88.0.2026.07.26.05.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 05:34:34 -0700 (PDT)
From: Hardik Kumar <hardikxk@gmail.com>
To: git@vger.kernel.org
Cc: Hardik Kumar <hardikxk@gmail.com>
Subject: [PATCH] change utf8_strwidth() return type to size_t
Date: Sun, 26 Jul 2026 18:04:27 +0530
Message-ID: <20260726123427.173877-1-hardikxk@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch changes the return types of `utf8_strwidth()` and
`utf8_strnwidth()` to `size_t` (implementing a //TODO). Both functions
have been updated in the header file also.

Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
---
 utf8.c | 13 ++++---------
 utf8.h |  4 ++--
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/utf8.c b/utf8.c
index 96460cc..1081573 100644
--- a/utf8.c
+++ b/utf8.c
@@ -208,7 +208,7 @@ int utf8_width(const char **start, size_t *remainder_p)
  * string, assuming that the string is utf8.  Returns strlen() instead
  * if the string does not look like a valid utf8 string.
  */
-int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
+size_t utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 {
 	const char *orig = string;
 	size_t width = 0;
@@ -225,15 +225,10 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 		if (glyph_width > 0)
 			width += glyph_width;
 	}
-
-	/*
-	 * TODO: fix the interface of this function and `utf8_strwidth()` to
-	 * return `size_t` instead of `int`.
-	 */
-	return cast_size_t_to_int(string ? width : len);
+	return (string) ? width : len;
 }
 
-int utf8_strwidth(const char *string)
+size_t utf8_strwidth(const char *string)
 {
 	return utf8_strnwidth(string, strlen(string), 0);
 }
@@ -821,7 +816,7 @@ void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int wid
 		       const char *s)
 {
 	size_t slen = strlen(s);
-	int display_len = utf8_strnwidth(s, slen, 0);
+	size_t display_len = utf8_strnwidth(s, slen, 0);
 	int utf8_compensation = slen - display_len;
 
 	if (display_len >= width) {
diff --git a/utf8.h b/utf8.h
index cf8ecb0..531e968 100644
--- a/utf8.h
+++ b/utf8.h
@@ -7,8 +7,8 @@ typedef unsigned int ucs_char_t;  /* assuming 32bit int */
 
 size_t display_mode_esc_sequence_len(const char *s);
 int utf8_width(const char **start, size_t *remainder_p);
-int utf8_strnwidth(const char *string, size_t len, int skip_ansi);
-int utf8_strwidth(const char *string);
+size_t utf8_strnwidth(const char *string, size_t len, int skip_ansi);
+size_t utf8_strwidth(const char *string);
 int is_utf8(const char *text);
 int is_encoding_utf8(const char *name);
 int same_encoding(const char *, const char *);

base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca
-- 
2.55.0

