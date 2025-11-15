Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786372F39BE
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 13:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763213784; cv=none; b=LGZD7ZIdfXC59Czp5pKR+xEsZZA2PLLzg5ey7jB0PEjSfhlGCifONoOpjqiWVEb1xF9PfhcRPEVvc0ESdYRcWUGYT0Yn12VXyRuLVXXAyN4Sp0cBYx7WC6Alcip1NU651RDH8EhC8gbEq7pN7NR4qNepp8FxDwxV30jNQS2cVOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763213784; c=relaxed/simple;
	bh=Dz2qe7FhHJLISn8rJyiEUlRQzQVy9s1Y1+3bHE6vNmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLtCqz763QWt0e3+QTDDZPTtXyByqjbFtgrVB+YpIXoVgecFGgEklxAYXMKsEhaI3nGEfscRV2dx7e6DuNYRpPibZsQ6NuEWkjgtw9rMpuUjMG9fn/1uhfG4slrndVfc8dhQRl+p8l9x914ZqrffNM8PHGg2XBXWnCjWecASKqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIri3kiD; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIri3kiD"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78665368a5cso28336627b3.3
        for <git@vger.kernel.org>; Sat, 15 Nov 2025 05:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763213781; x=1763818581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdK2cL0GlFQHsyUuBTEHq5Nf9x5Y4OsOWkiLP0GjzvU=;
        b=jIri3kiDXC75DHP5CvEAYX3MOla0rGIaIRADNGmJosDeamhUa/+XW+GGFDw3j3couq
         3ZVr+0ile3G88XzeKfem+hCr7B9LeaxMwWxAWb4c53kylklizKGTPYVqIlDuGBbZdc+V
         IguCfkLgy1QzKJT1wxkvzSDFjVloqzIUcz4vLzsl00ZRwy7YnRB//7GgsrBA4FruDIpp
         DxfQaBC6MFXpvKvcCpssDzEtnKBW2yXUwj9TLa2ryDHbEehiD32rc19Wpm574qCFp3My
         RIYA+o6VFLEx0PlaWdb7k2qEPZjCufSgY02MZs8tvxnrHlSz9FbGgWluPnSBWrlamQhR
         LHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763213781; x=1763818581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VdK2cL0GlFQHsyUuBTEHq5Nf9x5Y4OsOWkiLP0GjzvU=;
        b=Tm19MkANtTXzH7r629Belu6TOplkTtdtmJKqwXMskAegeL55Dw6YucnD/U/VUkOied
         tT+Yf1HO/47KfvqddTvL4kJEh7YP3Ss1T0pGV9KqE4nvhD72RJX7EDwJsTk2TlCgXYVO
         cXqsOdGzgiBge/KLBj9lsLrTtwhgy4FH9QmkxVC4+Sfd+ExZnu2HjszwGy+GMfN7iRkt
         yzYLy1Ct4x882PSowIYZCidb63+x1dvKQM/KiaSnQxNkgJxhFCoseRsInE96nmm7TT6z
         /0la4vJjQPqcGkPO03ezLiBvG8oHf65x/T4S7MOtn6fx5AyAPeRN78YkBX43gwgIDvIW
         ePoA==
X-Forwarded-Encrypted: i=1; AJvYcCUPZ7s+OyPGSuqg1lWAixvKovbjM6dR59fjMLJLiKz8FC94vWIKZxbhwSQA6cDyPHaNP78=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc11LH+Q0p8Ok242RfUpcHAdowLHAXOCLa3XxRjEaCqb1RmGJx
	VGesuSvsVSrK2Xgcgja0QhkVrx3uvC0YiNoLJJnf9kqNq+pgKYuGjotN
X-Gm-Gg: ASbGncu9mV6rR3AFLIasw+O0XVqJ5Wuf8khIuCaJ/XpFkN5YK72P9G0WRQEApqGJoVY
	OSZ+nWZ6PwOtSQMkWtlwCpFPq31IBlgU2+DsOuxZ4/EeXILLhsb6zu0ArzelzqN8ja/nmYZ76ns
	aU5N9s2943X741RTKpVI/Nh39KNKFCnxlMzv4kV0DYaFX1chqKYVA9qE4V+Lr2me24mIOXC6roE
	vjCAeCb+Rt8Tln6CMov9O0HTd8zJIZrHky3TKpjTtAYpd1ADNEOLs5oQpp8HHAOJ2J3MwTx8Y/3
	+6pZDD+s674kFSWvMByWOkTPESKu+dgQcJzoy6Acu1D11DDYbUdLiZ1Vge9hvNggkToe8j9cBjv
	WVP40EuP9JwaAVzQ6cILEEDAiq/DqGOtLWdks+dQB/61164EPUXiTECxc5z90jR+IAdH6AZ46X/
	KVpMCAF4zZ+mdsiFIgIngMXdLwZGFmDffqeSVKn4eblt9YuD97FYVv/7l0ov2+WtQKDjsm6A5I
X-Google-Smtp-Source: AGHT+IFLBTjaP/1MkakYkvyqjFr2jXUA0Q8OyUw1K2gSxRezgyDZ7Fw7crgyOlNkiBi5LUZRqGar9A==
X-Received: by 2002:a05:690c:6c85:b0:786:522f:f5b2 with SMTP id 00721157ae682-78929f4237amr64533527b3.63.1763213781349;
        Sat, 15 Nov 2025 05:36:21 -0800 (PST)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-788221281e4sm24449897b3.39.2025.11.15.05.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 05:36:21 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Justin Tobler <jltobler@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 2/2] builtin/repo: fix table alignment for UTF-8 characters
Date: Sat, 15 Nov 2025 08:36:11 -0500
Message-ID: <d0975427c9002ed28e6bbf18403034709f286a2c.1763213290.git.worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
In-Reply-To: <cover.1763213290.git.worldhello.net@gmail.com>
References: <cover.1763098804.git.worldhello.net@gmail.com> <cover.1763213290.git.worldhello.net@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The output table from "git repo structure" is misaligned when displaying
UTF-8 characters (e.g., non-ASCII glyphs). E.g.:

    | 仓库结构   | 值  |
    | -------------- | ---- |
    | * 引用       |      |
    |   * 计数     |   67 |

The previous implementation used simple width formatting with printf()
which didn't properly handle multi-byte UTF-8 characters, causing
misaligned table columns when displaying repository structure
information.

This change modifies the stats_table_print_structure function to use
strbuf_utf8_align() instead of basic printf width specifiers. This
ensures proper column alignment regardless of the character encoding of
the content being displayed.

Also add test cases for strbuf_utf8_align(), a function newly introduced
in "builtin/repo.c".

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/repo.c              | 21 +++++++++++++++++----
 t/unit-tests/u-utf8-width.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 9d4749f79b..e3adb353a2 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -292,14 +292,20 @@ static void stats_table_print_structure(const struct stats_table *table)
 	int name_col_width = utf8_strwidth(name_col_title);
 	int value_col_width = utf8_strwidth(value_col_title);
 	struct string_list_item *item;
+	struct strbuf buf = STRBUF_INIT;
 
 	if (table->name_col_width > name_col_width)
 		name_col_width = table->name_col_width;
 	if (table->value_col_width > value_col_width)
 		value_col_width = table->value_col_width;
 
-	printf("| %-*s | %-*s |\n", name_col_width, name_col_title,
-	       value_col_width, value_col_title);
+	strbuf_addstr(&buf, "| ");
+	strbuf_utf8_align(&buf, ALIGN_LEFT, name_col_width, name_col_title);
+	strbuf_addstr(&buf, " | ");
+	strbuf_utf8_align(&buf, ALIGN_LEFT, value_col_width, value_col_title);
+	strbuf_addstr(&buf, " |");
+	printf("%s\n", buf.buf);
+
 	printf("| ");
 	for (int i = 0; i < name_col_width; i++)
 		putchar('-');
@@ -317,9 +323,16 @@ static void stats_table_print_structure(const struct stats_table *table)
 			value = entry->value;
 		}
 
-		printf("| %-*s | %*s |\n", name_col_width, item->string,
-		       value_col_width, value);
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, "| ");
+		strbuf_utf8_align(&buf, ALIGN_LEFT, name_col_width, item->string);
+		strbuf_addstr(&buf, " | ");
+		strbuf_utf8_align(&buf, ALIGN_RIGHT, value_col_width, value);
+		strbuf_addstr(&buf, " |");
+		printf("%s\n", buf.buf);
 	}
+
+	strbuf_release(&buf);
 }
 
 static void stats_table_clear(struct stats_table *table)
diff --git a/t/unit-tests/u-utf8-width.c b/t/unit-tests/u-utf8-width.c
index 3766f19726..86e09c3574 100644
--- a/t/unit-tests/u-utf8-width.c
+++ b/t/unit-tests/u-utf8-width.c
@@ -95,3 +95,40 @@ void test_utf8_width__strnwidth_cjk_with_ansi(void)
 	/* "Hello"(5) + "世界"(4) + "!"(1) = 10 */
 	cl_assert_equal_i(10, width);
 }
+
+/*
+ * Test the strbuf_utf8_align function with CJK characters
+ */
+void test_utf8_width__strbuf_utf8_align(void)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	/* Test left alignment with CJK */
+	strbuf_utf8_align(&buf, ALIGN_LEFT, 10, "你好");
+	/* Since "你好" is 4 display columns, we need 6 more spaces to reach 10 */
+	cl_assert_equal_s("你好      ", buf.buf);
+	strbuf_reset(&buf);
+
+	/* Test right alignment with CJK */
+	strbuf_utf8_align(&buf, ALIGN_RIGHT, 8, "世界");
+	/* "世界" is 4 display columns, so we need 4 leading spaces */
+	cl_assert_equal_s("    世界", buf.buf);
+	strbuf_reset(&buf);
+
+	/* Test center alignment with CJK */
+	strbuf_utf8_align(&buf, ALIGN_MIDDLE, 10, "中");
+	/* "中" is 2 display columns, so (10-2)/2 = 4 spaces on left, 4 on right */
+	cl_assert_equal_s("    中    ", buf.buf);
+	strbuf_reset(&buf);
+
+	strbuf_utf8_align(&buf, ALIGN_MIDDLE, 5, "中");
+	/* "中" is 2 display columns, so (5-2)/2 = 1 spaces on left, 2 on right */
+	cl_assert_equal_s(" 中  ", buf.buf);
+	strbuf_reset(&buf);
+
+	/* Test alignment that is smaller than string width */
+	strbuf_utf8_align(&buf, ALIGN_LEFT, 2, "你好");
+	/* Since "你好" is 4 display columns, it should not be truncated */
+	cl_assert_equal_s("你好", buf.buf);
+	strbuf_release(&buf);
+}
-- 
2.52.0.rc2.5.g4c20a63325.dirty

