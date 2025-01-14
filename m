Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D558A13D891
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 18:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736878778; cv=none; b=BWfGd1lbNW8GWzi8ZGoHwfBZ5OUfLp2byZm8OJWRJ+juSytqBBX5AZCPkY7eG7uohRJ4TbMvIvTsWxvckZIKb9Wu6VeGBKeTtrle/t4yfk8JEcM0nBNscXPrdRaJKhXgRcinHIBL8P22Av4RbZxu8zh2h3kpS7pNH86/2AkcbT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736878778; c=relaxed/simple;
	bh=e/sbBXTK2Soi4us/1L7Lcep7vxeolVsSSVWCc7zuXZc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GmYVJaXECUp3OFgnIxfK1JB8si1Gy31/C4Z4sLtbAsCPN0MyD6r+aSRI6FCPOXD1mUBarBst+6DIgONzCmIbTvwCiNNt9PSY//GiHb7ZSHOc1sdCtOfxG+nNjnFM85FYAXGqvPPev8jzCKI40vhYfc3S0Cuq3a/FKJ65RN7yYbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsNOTHJs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsNOTHJs"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436a03197b2so41511975e9.2
        for <git@vger.kernel.org>; Tue, 14 Jan 2025 10:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736878775; x=1737483575; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1SJgO2yO5DX9Rl11NrFY5MrMas2q13KFwy/axSs6sk=;
        b=fsNOTHJsf6+WpAKYuuKN2RdZBpi0fe/gX+8sOXC2rJIMT8Ja+90euBTeam8Uh3MjKW
         zdsBnu/FItgWNnszcV9n60GGL+HEwlqQCaZPj/ti0h60axIHkpKlPyGpMAXj8rIn9snV
         zDnGM4hEPKddrDm6ILFDeI5lzwnfy1dR+V1rGp2QeQpxSqC9YP9SRRizAiw47frlmHc4
         EKqZWB4zXcFCtu4DxD1/PjbNRES0T2qERddUbiIMutbYyrvBaDBtcnx3RO1ebthFcgt5
         m9SwMmOAHCT/GP1xAHcqiDl6kchz476pW1me9903BEUEYRuGV9TAzDfpOH+ZeLmsobtm
         QAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736878775; x=1737483575;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1SJgO2yO5DX9Rl11NrFY5MrMas2q13KFwy/axSs6sk=;
        b=fqxDSVbxfO/ufEhwRS8kwPnrgwRFZj7DL9cYMF/GQfE2dHSylrcuG6uBL96KZnj5xT
         ywKrbVIV0RLsYVSYa3jnfvuiX9Cq8Kx0kDH5Y/BiMw4A+Kva6FNmCf7LZe0hBJE7Lfww
         n3wr/fAoaUpOkK6pgjYrKUx6lFR7V1Sj2JDD4dMCtCTaUe2+4NAwhTc5EZoI/IYotgdL
         aK1YpAu/AX7cIxiiGZ4IPmrWhM8yWe9CZkeNPRnu8E9ckNIbQ7Mn7nk/PRpjAcGCRe27
         Er6ok0RJNp0HnwCGwtIH5OdAeJjfprDgqvIb2T20zZkEyztav1WLuiQs58qQSaeP+X/h
         10Ow==
X-Gm-Message-State: AOJu0Yw2XqXjnNm6mlYdYiKDrjnOeoYGSENuzlwTzwdUCJBa9hRYd0eX
	JvoKCjhXw3Qh9ilQNNBbPps9H9u9sLGyBBbwU4w8e45Kl91OY9tmfESHew==
X-Gm-Gg: ASbGncuh6oEiajAGvMi9kVO95nd9z3G5t1rQbLCAWHBFS6U5pS9kyRZf18ZUzbOf4ri
	/rOpjrRchhe1zQ3f0hNQgMxR9OzEEs+is9i8+HVkDw15rVTuIGSUrgEVQ1lZcA02ZbFZnHuAlOD
	CN5Dj6G9i9i/hS2sxmZVBqqNH/pPusyUcNBc2KkpnwrXeFJetfzYVviD31ciTJ4Py49e1pUiz1c
	Kqm+ffqBbeDbG4NWQcyHzsySK5Z4tx/X+oE1ToD10sxymUmE1DUot4QBA==
X-Google-Smtp-Source: AGHT+IEnc1gtoPhfdyBmO0mmlM/NP66y5IjyfhN8uR4Mic4hq4xmSqpxPn0CVH2jPenjCfxvO8+sDw==
X-Received: by 2002:a05:600c:3b86:b0:434:fe4b:be18 with SMTP id 5b1f17b1804b1-436e26bde73mr262522305e9.18.1736878774529;
        Tue, 14 Jan 2025 10:19:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e89dfesm220157565e9.32.2025.01.14.10.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 10:19:34 -0800 (PST)
Message-Id: <f7fb7a38333cf6527345e3dbefaeb2cd8ade6429.1736878772.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Jan 2025 18:19:30 +0000
Subject: [PATCH 1/3] sideband: mask control characters
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

The output of `git clone` is a vital component for understanding what
has happened when things go wrong. However, these logs are partially
under the control of the remote server (via the "sideband", which
typically contains what the remote `git pack-objects` process sends to
`stderr`), and is currently not sanitized by Git.

This makes Git susceptible to ANSI escape sequence injection (see
CWE-150, https://cwe.mitre.org/data/definitions/150.html), which allows
attackers to corrupt terminal state, to hide information, and even to
insert characters into the input buffer (i.e. as if the user had typed
those characters).

To plug this vulnerability, disallow any control character in the
sideband, replacing them instead with the common `^<letter/symbol>`
(e.g. `^[` for `\x1b`, `^A` for `\x01`).

There is likely a need for more fine-grained controls instead of using a
"heavy hammer" like this, which will be introduced subsequently.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sideband.c                          | 17 +++++++++++++++--
 t/t5409-colorize-remote-messages.sh | 12 ++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/sideband.c b/sideband.c
index 02805573fab..c0b1cb044a3 100644
--- a/sideband.c
+++ b/sideband.c
@@ -65,6 +65,19 @@ void list_config_color_sideband_slots(struct string_list *list, const char *pref
 		list_config_item(list, prefix, keywords[i].keyword);
 }
 
+static void strbuf_add_sanitized(struct strbuf *dest, const char *src, int n)
+{
+	strbuf_grow(dest, n);
+	for (; n && *src; src++, n--) {
+		if (!iscntrl(*src) || *src == '\t' || *src == '\n')
+			strbuf_addch(dest, *src);
+		else {
+			strbuf_addch(dest, '^');
+			strbuf_addch(dest, 0x40 + *src);
+		}
+	}
+}
+
 /*
  * Optionally highlight one keyword in remote output if it appears at the start
  * of the line. This should be called for a single line only, which is
@@ -80,7 +93,7 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 	int i;
 
 	if (!want_color_stderr(use_sideband_colors())) {
-		strbuf_add(dest, src, n);
+		strbuf_add_sanitized(dest, src, n);
 		return;
 	}
 
@@ -113,7 +126,7 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 		}
 	}
 
-	strbuf_add(dest, src, n);
+	strbuf_add_sanitized(dest, src, n);
 }
 
 
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index 516b22fd963..61126e2b167 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -99,4 +99,16 @@ test_expect_success 'fallback to color.ui' '
 	grep "<BOLD;RED>error<RESET>: error" decoded
 '
 
+test_expect_success 'disallow (color) control sequences in sideband' '
+	write_script .git/color-me-surprised <<-\EOF &&
+	printf "error: Have you \\033[31mread\\033[m this?\\n" >&2
+	exec "$@"
+	EOF
+	test_config_global uploadPack.packObjectshook ./color-me-surprised &&
+	test_commit need-at-least-one-commit &&
+	git clone --no-local . throw-away 2>stderr &&
+	test_decode_color <stderr >decoded &&
+	test_grep ! RED decoded
+'
+
 test_done
-- 
gitgitgadget

