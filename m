Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BD6E55B
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754299390; cv=none; b=IoT1ctQT85bBW6vIdLITmEMB5QQry9zvPg+Y03fKzti/8z6VGI9T0Jha+yDfxWnhQnIAwCxvO2PAiPXBrHL1VXOLYApVt+hna8nIYNKJGJPOJIIBNp+8aqs39kWWLLx2vVGHG8rrM7pd3KLV1Dwd+vthda6fq+E8500rRLBkQ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754299390; c=relaxed/simple;
	bh=G31/ZiMin1weTE4bFUtvX162FUEp4rxiHl/9S5fpl0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hpZ66ils0Km5RU2YhSgM+zdeUuhDDfeeGQhWY7zjiVpSxp5ll7yQlqsdhIyAY177VqIGy/wAJp2CXoGQuJQI0fkyQfHb9GZK+4vPADS3trKRetEWSpeKGimmo4G+4JifT6wlkGwQdgqaoYD7XGIoRApFJCKHPMoBIsqDhJQSXK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7MWz4x8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7MWz4x8"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23ffa7b3b30so27857845ad.1
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 02:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754299388; x=1754904188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8F093nCyJn+sF6FeIQbNSbpTuhmCKBxQ7dTwq7w9II=;
        b=N7MWz4x8p2sq5w2PASIg+WA+vPYDQLyxJVCMFXr5AndD7ox27+085LucpcjW6vm/OY
         N4rUW0M9IoIt7gdqzBtMRgjKgJZleWjy3TbjDUeB1b6FHPhLTpiYs9izNvEJsQdpuWqj
         X9DmFp01HjXGEeVR65+2ZjWzqUnNJ6aqB6ryG/qdYJYRFhkP0sSDYn5+lf06O+I2WQlr
         vGkcucRWNneP3/xTR3/H8N9TPS/24vGEL5fvB0Kz5zbvx/zXM7JDMiDcCD5VL28nrKjv
         X0ACIoDlMraYQxaDsSbkETcPTBIt/PDYzr3JjBk0qmE+JrpSSD5jEyvTYAU1M+yK1Zsx
         Ll8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754299388; x=1754904188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8F093nCyJn+sF6FeIQbNSbpTuhmCKBxQ7dTwq7w9II=;
        b=gmbjFXDROOUBl3TX0AtACuNUYka0UmdWT0mfcUm7ii0JjwmvlWWXJ0D7EgUjVPAKkl
         oblc8s8Eov4sTtyoI/QA9ZgrOXvMLvhn/ePpdorpJjNND97vrz5tb7U+0zeu9EirKgOu
         xuo5yX0wmCe4u/QNvCUJCP8GeIRH8/Ok3x6ap4LbCP0z1fOHfSoUkQ/MQw1CJYiJrdBL
         QP8Rfdo88WW4PrRTcDifl+JPpYrq3jeLWVWKMs1kjEGEg9GM9eIa/YssRE98zwAV2mju
         snZmQZj6L4cWxyuEpiiEcfSQgYVHaIMwF7LT70p1GCk79qtInxx1QM91SAZ6kUQmv9yq
         lXTA==
X-Gm-Message-State: AOJu0YyDSbJQQzymPUq6K4iO52nmHr4Z+EQWkAkNjYpNFNlV2lxm3vMb
	/Y60Kz2t4IY3DUGpcC9CDQmcnWd1qHWFJWA7PQnfMo8zsHS0RPNyoM6a8ZSQPzV0zsY=
X-Gm-Gg: ASbGncsZu8JFixzUOn0svL5AK1H2sru9VBWKl5TyM3Z+oegd3AItq6pfdMtn/NkLF1L
	iwLhdSfTzCTojc1s8DNpnAx8UD6C4oym8bM2RcmUJz5FaXaclYevgzzh3E7xEKYcxsQaz2DO31b
	Ddlm8rZLMRV/BFvNZ8D1sRulJ+UA88rkX/XoTAnX4P3DhrYvXkU8261/xe9GEt2CWI9j54v2hU6
	f3EM8gtI3MWi4szg6sebwJvypmihEgSaBBBj4e96qA6OiVrIjR9QhIB4NIAp0v3O0pysq9O1T45
	7iKWcE/rjh6/cHtuoJ8gXNOW9mVRtuLywW9ySDzVMQtSn/QRv7ESro12BJ6Ixqa4TJB/Ou8T5vT
	R/b9s6QMl9k0b9cF80FU=
X-Google-Smtp-Source: AGHT+IEX5KyiCgk6nM5MNilCCfVCFMf3IEHJRU5tG5lINg9N69iSs8YvDLujCG9SxdNnpM7HWJfIvQ==
X-Received: by 2002:a17:902:e294:b0:240:7725:18de with SMTP id d9443c01a7336-2424704097emr88424365ad.37.1754299387945;
        Mon, 04 Aug 2025 02:23:07 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6c62sm106205565ad.4.2025.08.04.02.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 02:23:07 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	karthik.188@gmail.com,
	gitster@pobox.com,
	sunshine@sunshineco.com,
	phillip.wood123@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>,
	=?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
	Aaron Lipman <alipman88@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Jeff King <peff@peff.net>,
	Derrick Stolee <stolee@gmail.com>,
	Victoria Dye <vdye@github.com>
Subject: [GSoC][RFC PATCH v5 1/6] doc: factor out common option
Date: Mon,  4 Aug 2025 14:52:50 +0530
Message-Id: <20250804092255.1092973-2-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804092255.1092973-1-meetsoni3017@gmail.com>
References: <20250731090040.1625303-1-meetsoni3017@gmail.com>
 <20250804092255.1092973-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding documentation for `git refs list`, factor out
the common options from the `git-for-each-ref` man page into a
shareable file `for-each-ref-options.adoc` and update
`git-for-each-ref.adoc` to use an `include::` macro.

This change is a pure refactoring and results in no change to the
final rendered documentation for `for-each-ref`.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 Documentation/for-each-ref-options.adoc | 79 ++++++++++++++++++++++++
 Documentation/git-for-each-ref.adoc     | 80 +------------------------
 2 files changed, 80 insertions(+), 79 deletions(-)
 create mode 100644 Documentation/for-each-ref-options.adoc

diff --git a/Documentation/for-each-ref-options.adoc b/Documentation/for-each-ref-options.adoc
new file mode 100644
index 0000000000..5f3a85bf64
--- /dev/null
+++ b/Documentation/for-each-ref-options.adoc
@@ -0,0 +1,79 @@
+<pattern>...::
+	If one or more patterns are given, only refs are shown that
+	match against at least one pattern, either using fnmatch(3) or
+	literally, in the latter case matching completely or from the
+	beginning up to a slash.
+
+--stdin::
+	If `--stdin` is supplied, then the list of patterns is read from
+	standard input instead of from the argument list.
+
+--count=<count>::
+	By default the command shows all refs that match
+	`<pattern>`.  This option makes it stop after showing
+	that many refs.
+
+--sort=<key>::
+	A field name to sort on.  Prefix `-` to sort in
+	descending order of the value.  When unspecified,
+	`refname` is used.  You may use the --sort=<key> option
+	multiple times, in which case the last key becomes the primary
+	key.
+
+--format=<format>::
+	A string that interpolates `%(fieldname)` from a ref being shown and
+	the object it points at. In addition, the string literal `%%`
+	renders as `%` and `%xx` - where `xx` are hex digits - renders as
+	the character with hex code `xx`. For example, `%00` interpolates to
+	`\0` (NUL), `%09` to `\t` (TAB), and `%0a` to `\n` (LF).
++
+When unspecified, `<format>` defaults to `%(objectname) SPC %(objecttype)
+TAB %(refname)`.
+
+--color[=<when>]::
+	Respect any colors specified in the `--format` option. The
+	`<when>` field must be one of `always`, `never`, or `auto` (if
+	`<when>` is absent, behave as if `always` was given).
+
+--shell::
+--perl::
+--python::
+--tcl::
+	If given, strings that substitute `%(fieldname)`
+	placeholders are quoted as string literals suitable for
+	the specified host language.  This is meant to produce
+	a scriptlet that can directly be `eval`ed.
+
+--points-at=<object>::
+	Only list refs which points at the given object.
+
+--merged[=<object>]::
+	Only list refs whose tips are reachable from the
+	specified commit (HEAD if not specified).
+
+--no-merged[=<object>]::
+	Only list refs whose tips are not reachable from the
+	specified commit (HEAD if not specified).
+
+--contains[=<object>]::
+	Only list refs which contain the specified commit (HEAD if not
+	specified).
+
+--no-contains[=<object>]::
+	Only list refs which don't contain the specified commit (HEAD
+	if not specified).
+
+--ignore-case::
+	Sorting and filtering refs are case insensitive.
+
+--omit-empty::
+	Do not print a newline after formatted refs where the format expands
+	to the empty string.
+
+--exclude=<pattern>::
+	If one or more patterns are given, only refs which do not match
+	any excluded pattern(s) are shown. Matching is done using the
+	same rules as `<pattern>` above.
+
+--include-root-refs::
+	List root refs (HEAD and pseudorefs) apart from regular refs.
diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
index 5ef89fc0fe..c3cf1752e3 100644
--- a/Documentation/git-for-each-ref.adoc
+++ b/Documentation/git-for-each-ref.adoc
@@ -28,85 +28,7 @@ host language allowing their direct evaluation in that language.
 
 OPTIONS
 -------
-<pattern>...::
-	If one or more patterns are given, only refs are shown that
-	match against at least one pattern, either using fnmatch(3) or
-	literally, in the latter case matching completely or from the
-	beginning up to a slash.
-
---stdin::
-	If `--stdin` is supplied, then the list of patterns is read from
-	standard input instead of from the argument list.
-
---count=<count>::
-	By default the command shows all refs that match
-	`<pattern>`.  This option makes it stop after showing
-	that many refs.
-
---sort=<key>::
-	A field name to sort on.  Prefix `-` to sort in
-	descending order of the value.  When unspecified,
-	`refname` is used.  You may use the --sort=<key> option
-	multiple times, in which case the last key becomes the primary
-	key.
-
---format=<format>::
-	A string that interpolates `%(fieldname)` from a ref being shown and
-	the object it points at. In addition, the string literal `%%`
-	renders as `%` and `%xx` - where `xx` are hex digits - renders as
-	the character with hex code `xx`. For example, `%00` interpolates to
-	`\0` (NUL), `%09` to `\t` (TAB), and `%0a` to `\n` (LF).
-+
-When unspecified, `<format>` defaults to `%(objectname) SPC %(objecttype)
-TAB %(refname)`.
-
---color[=<when>]::
-	Respect any colors specified in the `--format` option. The
-	`<when>` field must be one of `always`, `never`, or `auto` (if
-	`<when>` is absent, behave as if `always` was given).
-
---shell::
---perl::
---python::
---tcl::
-	If given, strings that substitute `%(fieldname)`
-	placeholders are quoted as string literals suitable for
-	the specified host language.  This is meant to produce
-	a scriptlet that can directly be `eval`ed.
-
---points-at=<object>::
-	Only list refs which points at the given object.
-
---merged[=<object>]::
-	Only list refs whose tips are reachable from the
-	specified commit (HEAD if not specified).
-
---no-merged[=<object>]::
-	Only list refs whose tips are not reachable from the
-	specified commit (HEAD if not specified).
-
---contains[=<object>]::
-	Only list refs which contain the specified commit (HEAD if not
-	specified).
-
---no-contains[=<object>]::
-	Only list refs which don't contain the specified commit (HEAD
-	if not specified).
-
---ignore-case::
-	Sorting and filtering refs are case insensitive.
-
---omit-empty::
-	Do not print a newline after formatted refs where the format expands
-	to the empty string.
-
---exclude=<pattern>::
-	If one or more patterns are given, only refs which do not match
-	any excluded pattern(s) are shown. Matching is done using the
-	same rules as `<pattern>` above.
-
---include-root-refs::
-	List root refs (HEAD and pseudorefs) apart from regular refs.
+include::for-each-ref-options.adoc[]
 
 FIELD NAMES
 -----------
-- 
2.34.1

