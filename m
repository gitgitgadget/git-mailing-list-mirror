Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D423207A32
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769699720; cv=none; b=HUQE1OjiPj5uGkNuiz5gUhJ7hyk3JvHYBpZseXel04Oz2m1JaJFCmP0qbvkbDJUHdgBfL69ECjJUvkz5jt47tHHYUwjaIj4do2kDEiMTPglJOAO6WNg++gztz4gohw2Zo1PZZnY7R+9BAzbxl/50vGeQHAl5gogRAeYUpwZaBho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769699720; c=relaxed/simple;
	bh=VpPhZh5KexCBw8qVsyNLx/GvirxCRq847LAAlqDoGdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AVDZW1QsEYj2HiwzpiNx2JLuD+sAQI6gIPin3Lh69BXd8glYgZafijCHkRxR0WlzgWdg0A0t+gMaiDtrbOPBwSygJl1o5SEdwzdF3FNILCcqcIjAJg9sOuQGdOE57DQxnA0BG8ohWGTHewQ1o12q7Jdd3nizMBQi+r+PdangxJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gY0+1uzq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gY0+1uzq"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a8a7269547so10398645ad.0
        for <git@vger.kernel.org>; Thu, 29 Jan 2026 07:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769699718; x=1770304518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F660/1esfhIfPHQgb5Y6SyZLbdDKJvUy/eAUpPQz8yI=;
        b=gY0+1uzqltI5SShM50WytwRL6DiMbXU65TuqLif/FTLQ7XO1t09EIIJW/qKgHXXicw
         KVyyUf4GDfuQvmpHOkDSQ5xvklscsm2niTSkXSNVlWTRS1ZlQsVgFdMBo+Lmcw/eQojC
         ipWGpH9X8whdIydhhKpCNZgVCReZLw233zhbF3k2/v+amBqYDn2WZZeux8uYmia21aEL
         vE4VobCXRWEd9GmjfRp/kff4Pv6WmNb94AkQZa3z0A3c/O+mlE7EB8Gw1E2DXTnHhA+s
         vJpW5bs1upS3tw3Waxnla4DWKv0RBJZJ+jfMfgjZ1MxprJ5XPQw9UQV/htbNcV9eUI1v
         qrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769699718; x=1770304518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F660/1esfhIfPHQgb5Y6SyZLbdDKJvUy/eAUpPQz8yI=;
        b=woiv4FjSvCXE1k+9LqGjdhuiEjviXGCctBKDK5pj8RLxAiJmC2s5IzIxadJec7REn8
         9WqpcvkuNcfxqR/mvZKRpQEnJWU+wEymDu8IqM846N4IjiY8ld76oaVg9jB6HVGtsAy4
         7Vfh4Xk6A+ei1tUWgygZULKSli357E5NfSr5Mdku7ZGjMyssG14Uv5Zn+RE0BBSLHvUj
         +hNP/NLDTmVfupHRqrPafaDllBelLn3gM/BL1xxaQ2/yZ7knESd/Ku9vwxdTGZdk7MSQ
         4QsxmVATKw7CwFbEcYXm+O6Ie6DhDgT2b3Kuse6+FWiRjrTY24zIMgAZE52TZiNe6oO/
         QGDQ==
X-Gm-Message-State: AOJu0YwWKHCV1Ivswb6BmC6V1MK6GjExyrti3vWaxeAl6hWE4Yr4Vz1Q
	6AwVs0CC0LfjohFWw/CvmY30VQ+HJBDlzXdiC0ZZQ+eGn1Bf1UK+iRwJlysYdE/f
X-Gm-Gg: AZuq6aJxsqzJ09Gg423K4LyhW+LWTejTO3NPW6KnEg+ZGGwqKZ8l0deuvH//0INQSCg
	+E1lR+TFEBIb7AeKdvYRHXPW4En049TrGhGB9QhgyBCKmV8c065YShV+DxMO5J2sVLvoPBYRFpZ
	nGW6cm+IN7i3sQUH1lFJvJY+C4+yLRUKUIHc7HpY+DkQDbLCl8H06tEztz142V3wT/HJgWyXYI2
	gIgTtv/JLSie1LKwuaUTagmi9UkT9TTe79mfYWVUo72t4lS9/uuTVoWGL2Tj6HfKEAW5Kc21dFA
	DKho5kjCUsNEQYIkmKWfoZ36JVUpNnRLrcZC8D9wWsXwRWyOYfMEqNAH8CixngEzTkkveyqW6qC
	Uwc2ew2J2p0Wnc0j05j2eGRMtM+ISJI3EbavFIBim5c/UbRNaQR8pVBHTpR1vTtVyL4WyYXdK5S
	aQn2OwJwsCdc67PjXGcZATdGxwmfWZMrExG9MM3CKlrcU=
X-Received: by 2002:a17:903:41cf:b0:2a0:d403:a2e3 with SMTP id d9443c01a7336-2a870dbeacbmr87126245ad.37.1769699718325;
        Thu, 29 Jan 2026 07:15:18 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c40e1sm53945635ad.55.2026.01.29.07.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 07:15:17 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH] path: refactor normalize_path_copy_len()
Date: Thu, 29 Jan 2026 14:54:35 +0000
Message-ID: <20260129145434.29123-2-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor normalize_path_copy_len() by extracting helpers for skipping
slashes, handling dot components, and stripping the previous path
component, making the control flow easier to follow.

This is a mechanical refactor only; there are no functional changes.
Behavior is unchanged, as verified by t0060-path-utils.sh.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
 path.c | 105 ++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 67 insertions(+), 38 deletions(-)

diff --git a/path.c b/path.c
index d726537622..00845cc03f 100644
--- a/path.c
+++ b/path.c
@@ -1112,6 +1112,63 @@ const char *remove_leading_path(const char *in, const char *prefix)
  * end with a '/', then the callers need to be fixed up accordingly.
  *
  */
+
+static const char *skip_slashes(const char *p)
+{
+	while (is_dir_sep(*p))
+		p++;
+	return p;
+}
+
+static int handle_dot_component(const char **src)
+{
+	const char *s = *src;
+
+	if (*s != '.')
+		return 0;
+
+	if (!s[1]) {
+		*src = s + 1;
+		return 1;
+	}
+
+	if (is_dir_sep(s[1])) {
+		*src = skip_slashes(s + 2);
+		return 1;
+	}
+
+	if (s[1] == '.') {
+		if (!s[2]) {
+			*src = s + 2;
+			return 2;
+		}
+		if (is_dir_sep(s[2])) {
+			*src = skip_slashes(s + 3);
+			return 2;
+		}
+	}
+
+	return 0;
+}
+
+static int strip_last_component(char **dst, char *dst0, int *prefix_len)
+{
+	char *d = *dst;
+
+	d--;
+	if (d <= dst0)
+		return -1;
+
+	while (dst0 < d && d[-1] != '/')
+		d--;
+
+	if (prefix_len && *prefix_len > d - dst0)
+		*prefix_len = d - dst0;
+
+	*dst = d;
+	return 0;
+}
+
 int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)
 {
 	char *dst0;
@@ -1129,8 +1186,7 @@ int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)
 	}
 	dst0 = dst;
 
-	while (is_dir_sep(*src))
-		src++;
+	src = skip_slashes(src);
 
 	for (;;) {
 		char c = *src;
@@ -1143,29 +1199,14 @@ int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)
 		 * (3) ".." and ends  -- strip one and terminate.
 		 * (4) "../"          -- strip one, eat slash and continue.
 		 */
-		if (c == '.') {
-			if (!src[1]) {
-				/* (1) */
-				src++;
-			} else if (is_dir_sep(src[1])) {
-				/* (2) */
-				src += 2;
-				while (is_dir_sep(*src))
-					src++;
-				continue;
-			} else if (src[1] == '.') {
-				if (!src[2]) {
-					/* (3) */
-					src += 2;
-					goto up_one;
-				} else if (is_dir_sep(src[2])) {
-					/* (4) */
-					src += 3;
-					while (is_dir_sep(*src))
-						src++;
-					goto up_one;
-				}
-			}
+		int dot = handle_dot_component(&src);
+
+		if (dot == 1)
+			continue;
+		if (dot == 2) {
+			if (strip_last_component(&dst, dst0, prefix_len))
+				return -1;
+			continue;
 		}
 
 		/* copy up to the next '/', and eat all '/' */
@@ -1180,20 +1221,8 @@ int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)
 			break;
 		continue;
 
-	up_one:
-		/*
-		 * dst0..dst is prefix portion, and dst[-1] is '/';
-		 * go up one level.
-		 */
-		dst--;	/* go to trailing '/' */
-		if (dst <= dst0)
-			return -1;
-		/* Windows: dst[-1] cannot be backslash anymore */
-		while (dst0 < dst && dst[-1] != '/')
-			dst--;
-		if (prefix_len && *prefix_len > dst - dst0)
-			*prefix_len = dst - dst0;
 	}
+
 	*dst = '\0';
 	return 0;
 }
-- 
2.43.0

