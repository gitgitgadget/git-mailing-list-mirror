Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A40175805
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 07:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711351679; cv=none; b=JzxVVikJ2N+uB4FXlIuxz8Wp0c4DJcHtTiO5PZJjxBs6TNjMohELn+J0TJAvrhK8gBztV1CVz4fKAbrhKVVGRKgF8L+H2pE+yJQLuMRoxOakODkEMvflETWJhDGYddivypZlvM5DNTdrd709ikRQSYTX5Y1rx3qay0KdywM4egU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711351679; c=relaxed/simple;
	bh=ZZCHq9w+IsggVD4wc0xxB2UPjtGfXg7oH0UK4PF0GFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwAy5K1i2UqgBVIL4D+tUieTNGlGWZqbwx/HlWBaoCSJznM0iodyE9pIs3hu6XOs/CEGpStRk010knKciNK7pQ5QF+aI6L1ntti0lgxicD8iW0WQLcbN1sCN9C7+Upb0v0h7dWeg50/EkSgVmPMZlqEQgpxYSV74oeZR1pxR87Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cb85H7rC; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cb85H7rC"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a5272035d3so1221534eaf.1
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 00:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711351676; x=1711956476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Tqe2uQqG2MIouSSJJ+8vd83uD9Pmi+y5CPySSpmUh0=;
        b=cb85H7rC9D8DntQJ96zxiCAkd+1E5GaQMw0VQhFBDIO080/CW3by07GhS16NjAr3yg
         mG5QPZ46naU+e/ytciFq66gesJURrhsx4fJqH8olHjbixd1kwEn8x3kcbkhIwydCKhn/
         loqjS0gkcLUYaJKEUSmUnhsrc2OxyDIs9UMbKMyeGZ6bFGaTXNni+hYHP5ZuETRDpVTm
         0cIXVQ4ME6Qvn/yxn3dD9rTfJeTvQLmc3l2cvDYYodjRkZHU8/l0QW/rCrKq3LcxKkJd
         pyk+dc3ZNjdebqF4uvjmLw7seGdIN2amRZV7GzUEdB2aY8/XfXE0GYqLwRiuXY+puikX
         RIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711351676; x=1711956476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Tqe2uQqG2MIouSSJJ+8vd83uD9Pmi+y5CPySSpmUh0=;
        b=N6t8a0IJj3gU7/PtRXzTow22wtveYQNta4LRast+1KHKqcXe8zNiXFoZI5yaUHD7d9
         r0q6E4KC3HrvBgMBHhAC39cee5JOJk/oxv/7uvXKaF3PVC8GWhAtV0P0qP1QIowlmio5
         kzewXWG2psb5uJ+PKb/bBrDQ8pjl5MpbuXESCQwaxWm62SDEdkvkvLP4bSz1jCziSy24
         j3cqthdiBS8GxbjgciiBwwbxz6cCyi0aZuQJN6204xZEPuMDz19QQN+Rg6LmG+LsdO6p
         5JaxJWjVF3ucN1bsNSNfO/OyrR1SNLs9Nx+07qieUEvUYtz+jI5ct4ggiH4nBmdfdM7q
         cCcQ==
X-Gm-Message-State: AOJu0YwyuE3BhS+WHFCnin/zBYZpzP5KALhPaNQtG6KBEdFQtdaM2SU3
	B1yh1vquEd65gj7X/32uiijnUofyzkZdG3H33bAjsYTB4sXCthnjAlEFhGh+
X-Google-Smtp-Source: AGHT+IETfhDqpgbN+zB3ZX18RLedNwkbBOQWIeioBnD+5xy+l7+/Is4Vxvk/cz/TVsYXqXwzN/8S4g==
X-Received: by 2002:a05:6820:990:b0:5a5:46e:d0f with SMTP id cg16-20020a056820099000b005a5046e0d0fmr7441920oob.1.1711351676031;
        Mon, 25 Mar 2024 00:27:56 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id bs27-20020a056820179b00b005a53376cf14sm918172oob.9.2024.03.25.00.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 00:27:55 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	peff@peff.net
Subject: [PATCH v2 2/2] pretty: find pretty formats case-insensitively
Date: Mon, 25 Mar 2024 02:25:13 -0500
Message-ID: <20240325072651.947505-2-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240324214316.917513-1-brianmlyles@gmail.com>
References: <20240324214316.917513-1-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

User-defined pretty formats are stored in config, which is meant to use
case-insensitive matching for names as noted in config.txt's 'Syntax'
section:

    All the other lines [...] are recognized as setting variables, in
    the form 'name = value' [...]. The variable names are
    case-insensitive, [...].

When a user specifies one of their format aliases with an uppercase in
it, however, it is not found.

    $ git config pretty.testAlias %h
    $ git config --list | grep pretty
    pretty.testalias=%h
    $ git log --format=testAlias -1
    fatal: invalid --pretty format: testAlias
    $ git log --format=testalias -1
    3c2a3fdc38

This is true whether the name in the config file uses any uppercase
characters or not.

Use case-insensitive comparisons when identifying format aliases.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---
 pretty.c                      | 2 +-
 t/t4205-log-pretty-formats.sh | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/pretty.c b/pretty.c
index cf964b060c..8c1092c790 100644
--- a/pretty.c
+++ b/pretty.c
@@ -147,7 +147,7 @@ static struct cmt_fmt_map *find_commit_format_recursive(const char *sought,
 	for (i = 0; i < commit_formats_len; i++) {
 		size_t match_len;
 
-		if (!starts_with(commit_formats[i].name, sought))
+		if (!istarts_with(commit_formats[i].name, sought))
 			continue;
 
 		match_len = strlen(commit_formats[i].name);
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 20bba76c43..749363ccb8 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -58,6 +58,14 @@ test_expect_success 'alias user-defined format' '
 	test_cmp expected actual
 '
 
+test_expect_success 'alias user-defined format is matched case-insensitively' '
+	git log --pretty="format:%h" >expected &&
+	test_config pretty.testone "format:%h" &&
+	test_config pretty.testtwo testOne &&
+	git log --pretty=testTwo >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'alias user-defined tformat with %s (ISO8859-1 encoding)' '
 	test_config i18n.logOutputEncoding $test_encoding &&
 	git log --oneline >expected-s &&
-- 
2.43.2

