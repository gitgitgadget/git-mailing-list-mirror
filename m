Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A6B1FAC37
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736878779; cv=none; b=c5afafLMWIjDmCchDmsk0weM+LeP1eiBCTGZOAxYaGmTM3rcwGO1xRrodqdmbeocx2lhoa1hSkacvIcGN8lplerSZ+ZsqtKlCpi+nfPzm+LGs0is2qpMScSh7IiGsYT0eaBdrNE4TcME8TTmYhT6U6zYDmb56xgDVMQ8pFaI1Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736878779; c=relaxed/simple;
	bh=OoWst4EtBSa1w8feQjYS1bg6XelFyhlnuyMGB0HbrK4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=a6TfYBAXy7LPl8/qVJZc3C9XDG+xpGRp0kE3PDlJykHuclDYmtgyQ9ryUSEHj5vZVUPU1IfBor3b90jNVpWcub5gAxl6kI3DDnygYLO1Z5r84X2bW/2frZgZskHHU4lYH5d1YK0BOT/FDv1sXCmvV4IeBAfpGUNwR26433ATNVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkBKfUVD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkBKfUVD"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4363ae65100so61556105e9.0
        for <git@vger.kernel.org>; Tue, 14 Jan 2025 10:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736878775; x=1737483575; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/YVYhYE0Y4KXTRYiUFMYfpiGmLiSSFtMgp/J6dURuU=;
        b=FkBKfUVD1aTE5WpQbWiXIuKw7RGOXoFU3Ds5J2yZOUIKSuXr0Lak/MYMSlZLvqay9a
         fznv6huBtQ/4yYQ/Plbpp60699m2h8qzoclN10MnTf+pehmCFgbbTiIgySJDocDYTL6c
         7crALL0sCWFDg1eB5LIma5CmIg16QWPypwYVkho6smwsBCcdtx5jleC2jgGe+v/XTNLA
         ztzjXVNaRjboyf+wNeEwf2er7lsA2/yb1iyr+Lcy0GUW063QbLyNiRJtSA1Ike+QOoHD
         /fmL+mevXneNaNOqIRYDFaz0ThfM3pYlvyJg91dzfIt0JQmNdVwPQNaI47sMLUz32ADR
         OBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736878775; x=1737483575;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/YVYhYE0Y4KXTRYiUFMYfpiGmLiSSFtMgp/J6dURuU=;
        b=e1rmNqsMqL2dW0tXsMQgcyHweNeZrrwQKMVlBpjq/KyB2m87vRwf4Bq4QIVFoqscYX
         osiT6wbF6UlmYzGl+68xxJzOXl6E1r5vGF6h1U1q1S7XqCULA31Zw5XvpT3LJCQrpkaw
         u+GTwRL4EDaBglWwVYwDvSRiwDOzcEZWfcUiHXNXTH65lSo5GOd9oSxurGp2ECKd9P2V
         tiP1qdOkPlPQ/0bVWUi4NBU3fXO3Bh8uRdHjAun8Qa8/zKLwFEt8oS/Lz6I2YkVo9/W9
         ZRaXuQmejr+sPw4vpGGyhTXmGARvKZW4IzloHXSNSmi//Qiv05Mp4bKc0avUE5v4rHBv
         zY7g==
X-Gm-Message-State: AOJu0Yz2q9HCd/TuyGeRIGhkkbnZFP7WvGZ0J8tC92F5wGSd7qo5Ad2H
	qnnehZ3SYqyDMW4ySbrS0mMlda27S0Dlqs2V8VhyDIELW+VgtrPtxs7dmA==
X-Gm-Gg: ASbGncsPZEikk5wNJACUf7Q3mEv0zacV7txfYtNjSBFLQsZoe1jzEjPJXFGuO4uAReY
	90grmL8aBmspiWZAkI4gE60N2nyrcgooiMHVo/4ie0LvvvcJPVvMX6hKvIX6ZKxXdpBneo0QkPn
	L1UHoXvJvzXdZc0led+Hoq1HUA5NuTZXzzzzMVg55mImeLkyLUot1O9H+xnkkb13zaM7dTqR303
	o1j6eyQoGplJkbR3/Tmcg/J+uPCS3RY6vGBr8DVZR4F5hMBBUBc1p1PTg==
X-Google-Smtp-Source: AGHT+IF/j3d1XHwYdAGVD1ixvhtdrUyBAT+I6mRg01ZTeK/MBVg/klygzDwSmTl6q4hkoO9uLndeLA==
X-Received: by 2002:a05:600c:5129:b0:434:ff45:cbbe with SMTP id 5b1f17b1804b1-436e26aaaa5mr278173805e9.18.1736878775251;
        Tue, 14 Jan 2025 10:19:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9df958dsm182711935e9.17.2025.01.14.10.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 10:19:34 -0800 (PST)
Message-Id: <14c612c69ab8a2ffe73793ad80a5a1378d5e0d12.1736878772.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Jan 2025 18:19:31 +0000
Subject: [PATCH 2/3] sideband: introduce an "escape hatch" to allow control
 characters
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The preceding commit fixed the vulnerability whereas sideband messages
(that are under the control of the remote server) could contain ANSI
escape sequences that would be sent to the terminal verbatim.

However, this fix may not be desirable under all circumstances, e.g.
when remote servers deliberately add coloring to their messages to
increase their urgency.

To help with those use cases, give users a way to opt-out of the
protections: `sideband.allowControlCharacters`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt            |  2 ++
 Documentation/config/sideband.txt   |  5 +++++
 sideband.c                          | 10 ++++++++++
 t/t5409-colorize-remote-messages.sh |  8 +++++++-
 4 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/config/sideband.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8c0b3ed8075..48870bb588e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -522,6 +522,8 @@ include::config/sequencer.txt[]
 
 include::config/showbranch.txt[]
 
+include::config/sideband.txt[]
+
 include::config/sparse.txt[]
 
 include::config/splitindex.txt[]
diff --git a/Documentation/config/sideband.txt b/Documentation/config/sideband.txt
new file mode 100644
index 00000000000..3fb5045cd79
--- /dev/null
+++ b/Documentation/config/sideband.txt
@@ -0,0 +1,5 @@
+sideband.allowControlCharacters::
+	By default, control characters that are delivered via the sideband
+	are masked, to prevent potentially unwanted ANSI escape sequences
+	from being sent to the terminal. Use this config setting to override
+	this behavior.
diff --git a/sideband.c b/sideband.c
index c0b1cb044a3..b38a869c7b5 100644
--- a/sideband.c
+++ b/sideband.c
@@ -25,6 +25,8 @@ static struct keyword_entry keywords[] = {
 	{ "error",	GIT_COLOR_BOLD_RED },
 };
 
+static int allow_control_characters;
+
 /* Returns a color setting (GIT_COLOR_NEVER, etc). */
 static int use_sideband_colors(void)
 {
@@ -38,6 +40,9 @@ static int use_sideband_colors(void)
 	if (use_sideband_colors_cached >= 0)
 		return use_sideband_colors_cached;
 
+	git_config_get_bool("sideband.allowcontrolcharacters",
+			    &allow_control_characters);
+
 	if (!git_config_get_string_tmp(key, &value))
 		use_sideband_colors_cached = git_config_colorbool(key, value);
 	else if (!git_config_get_string_tmp("color.ui", &value))
@@ -67,6 +72,11 @@ void list_config_color_sideband_slots(struct string_list *list, const char *pref
 
 static void strbuf_add_sanitized(struct strbuf *dest, const char *src, int n)
 {
+	if (allow_control_characters) {
+		strbuf_add(dest, src, n);
+		return;
+	}
+
 	strbuf_grow(dest, n);
 	for (; n && *src; src++, n--) {
 		if (!iscntrl(*src) || *src == '\t' || *src == '\n')
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index 61126e2b167..5806e5a67b3 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -106,9 +106,15 @@ test_expect_success 'disallow (color) control sequences in sideband' '
 	EOF
 	test_config_global uploadPack.packObjectshook ./color-me-surprised &&
 	test_commit need-at-least-one-commit &&
+
 	git clone --no-local . throw-away 2>stderr &&
 	test_decode_color <stderr >decoded &&
-	test_grep ! RED decoded
+	test_grep ! RED decoded &&
+
+	rm -rf throw-away &&
+	git -c sideband.allowControlCharacters clone --no-local . throw-away 2>stderr &&
+	test_decode_color <stderr >decoded &&
+	test_grep RED decoded
 '
 
 test_done
-- 
gitgitgadget

