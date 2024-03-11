Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122C55467F
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 18:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710183369; cv=none; b=YowSBrUHIFg1kQhFfxX3Y5dKQJ4u5Q7CKlEu36HsqCb69BqcZeHc6FfASw6q61yyl+ywgXv6mr3RejKg/Uvr+eigRa0OICv+xO8Q8783OI+Se/OuOsITBdz1W6Y8DxFGG5UoakPaEnC+Kbjwra1nmssBuAC91rBVZ3yKDePfebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710183369; c=relaxed/simple;
	bh=EHNLXjZ6w5iAQ44bkpBjN7PUZM4qCN//PuNIpDa8DQQ=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oWEMacwtCfR3gUzQ1KLRpQ77haFTEEfog54llMNJND/Y9L3P4BfKWIMyRNY4Bp8eZ6YO5LFppQ6LtZqYVPow6G0cnW2xluiXPE+RdCEl0arJMZ7kBdWAtxaMnkvTOu8t6TDriN93tyWUu0lD+Ufs6LwvK43z3NXR1EdEd1+RPUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7N5zKms; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7N5zKms"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-413328344acso313065e9.3
        for <git@vger.kernel.org>; Mon, 11 Mar 2024 11:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710183366; x=1710788166; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJYITVq5DxLpd/LY3SAUdz00h5C/RPNtpMlH5+xQBys=;
        b=f7N5zKmsM7suTI7nMf8Iah8W8zv4UHlwe+DsZAy/qfOddNCXQnnebpYcV1rbMuLJjM
         9Hme4L/enAbciDaNYo8hkwClk/X8lKr9cYROZDyV5cMLJfpzqic7E4jQEHnpT+lZu750
         DBuuoGftOgjrBiiXVX9jywVKdWicHmjPiKmJDP3BFeCwMzSt2uvnKhcsdUT1FkUFWDc/
         hfqonoahPd9xsYXQbV93g6E96AbzEXXnWe+SG8ItFdHuwb//n8zvaLdLPvNElUudImqJ
         2A6FUkKN4/ryRzG3xYCGlWsmbWpGnddqA5YamfTqsXX18ZSP/V8wguGhsJcwWPIGOTkj
         5wMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710183366; x=1710788166;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJYITVq5DxLpd/LY3SAUdz00h5C/RPNtpMlH5+xQBys=;
        b=m64zQ+w2LxqRFhMOSWsBEU4YftjuEkHe9vr/ZIoqPAyxryRR0qnxIFFJShuU2Mcd93
         zMhLYu6NnAXu3/ZS0FnBQeh8TU14CKR2nXqqkZNnFKpwioHtfdEgefVKwjE9EPMKzLCY
         F/gz2zy1UNgXTMa210/tIIucRUt2QBr+J85wDvWbzeP32N1oeHmVEsIV7qj9MRNawHk7
         1oo+GgV9dGpnKE7up/SvZLZ9xoM39COlXf/R2IanrbB+NOXt1oyruUGK4TCizOHec0VH
         YRBUWn/cNyJ49vCqBNpcHKWQZGEvMtEBQi7fVhe8w0wZppLlKQ8fBCWFKe1gPc1BIbMU
         uvaA==
X-Gm-Message-State: AOJu0YzajQe0euG1k7MgLHizePABYK4E1vMkCW8/4lWz+AOh84rlOx/q
	WcN5QS16wV6ep/JtL5BxoWb+ViOuqfkfi/5PSt1sU2BPX4I45dE4CPHmuju7
X-Google-Smtp-Source: AGHT+IHqHT9Ll/RzwyDQXAfo1gzqE2n1Kn4xOnhr1u4Rg/WBsbbDSVXT+QDNR74H74NJnML8fUPE8g==
X-Received: by 2002:a05:600c:35d4:b0:413:7f3:8d5 with SMTP id r20-20020a05600c35d400b0041307f308d5mr5096677wmq.0.1710183365614;
        Mon, 11 Mar 2024 11:56:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bo5-20020a056000068500b0033e7e9c8657sm7065667wrb.45.2024.03.11.11.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 11:56:04 -0700 (PDT)
Message-ID: <b836bc64ddc06069d1722ae89ca049e9dfce7eec.1710183362.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1689.git.1710183362.gitgitgadget@gmail.com>
References: <pull.1689.git.1710183362.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Mar 2024 18:56:01 +0000
Subject: [PATCH 2/3] cat-file: add %(objectmode) atom
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
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Add a formatting atom, used with the --batch-check/--batch-command options,
that prints the octal representation of the object mode if a given revision
includes that information, e.g. one that follows the format
<tree-ish>:<path>. If the mode information does not exist, an empty string
is printed instead.

Signed-off-by: Victoria Dye <vdye@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-cat-file.txt |  5 +++++
 builtin/cat-file.c             |  9 +++++++--
 t/t1006-cat-file.sh            | 23 +++++++++++++++--------
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index bd95a6c10a7..de29e6d79d9 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -292,6 +292,11 @@ newline. The available atoms are:
 `objecttype`::
 	The type of the object (the same as `cat-file -t` reports).
 
+`objectmode`::
+	If the specified object has mode information (such as a tree or
+	index entry), the mode expressed as an octal integer. Otherwise,
+	empty string.
+
 `objectsize`::
 	The size, in bytes, of the object (the same as `cat-file -s`
 	reports).
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index bbf851138ec..73bd78c0b63 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -272,6 +272,7 @@ struct expand_data {
 	struct object_id oid;
 	enum object_type type;
 	unsigned long size;
+	unsigned short mode;
 	off_t disk_size;
 	const char *rest;
 	struct object_id delta_base_oid;
@@ -303,6 +304,7 @@ struct expand_data {
 	 */
 	unsigned skip_object_info : 1;
 };
+#define EXPAND_DATA_INIT  { .mode = S_IFINVALID }
 
 static int is_atom(const char *atom, const char *s, int slen)
 {
@@ -342,6 +344,9 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 		else
 			strbuf_addstr(sb,
 				      oid_to_hex(&data->delta_base_oid));
+	} else if (is_atom("objectmode", atom, len)) {
+		if (!data->mark_query && !(S_IFINVALID == data->mode))
+			strbuf_addf(sb, "%06o", data->mode);
 	} else
 		die("unknown format element: %.*s", len, atom);
 }
@@ -562,6 +567,7 @@ static void batch_one_object(const char *obj_name,
 		return;
 	}
 
+	data->mode = ctx.mode;
 	batch_object_write(obj_name, scratch, opt, data, NULL, 0);
 }
 
@@ -766,7 +772,7 @@ static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf input = STRBUF_INIT;
 	struct strbuf output = STRBUF_INIT;
-	struct expand_data data;
+	struct expand_data data = EXPAND_DATA_INIT;
 	int save_warning;
 	int retval = 0;
 
@@ -775,7 +781,6 @@ static int batch_objects(struct batch_options *opt)
 	 * object_info to be handed to oid_object_info_extended for each
 	 * object.
 	 */
-	memset(&data, 0, sizeof(data));
 	data.mark_query = 1;
 	expand_format(&output,
 		      opt->format ? opt->format : DEFAULT_FORMAT,
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index ac1f754ee32..6f25cc20ec6 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -114,9 +114,10 @@ run_tests () {
     type=$1
     object_name=$2
     oid=$(git rev-parse --verify $object_name)
-    size=$3
-    content=$4
-    pretty_content=$5
+    mode=$3
+    size=$4
+    content=$5
+    pretty_content=$6
 
     batch_output="$oid $type $size
 $content"
@@ -211,6 +212,12 @@ $content"
 	test_cmp expect actual
     '
 
+    test_expect_success '--batch-check with %(objectmode)' '
+	echo "$mode $oid" >expect &&
+	echo $object_name | git cat-file --batch-check="%(objectmode) %(objectname)" >actual &&
+	test_cmp expect actual
+    '
+
     test -z "$content" ||
     test_expect_success "--batch without type ($type)" '
 	{
@@ -241,7 +248,7 @@ test_expect_success "setup" '
 	git update-index --add hello
 '
 
-run_tests 'blob' $hello_sha1 $hello_size "$hello_content" "$hello_content"
+run_tests 'blob' $hello_sha1 "" $hello_size "$hello_content" "$hello_content"
 
 test_expect_success '--batch-command --buffer with flush for blob info' '
 	echo "$hello_sha1 blob $hello_size" >expect &&
@@ -271,8 +278,8 @@ tree_sha1=$(git write-tree)
 tree_size=$(($(test_oid rawsz) + 13))
 tree_pretty_content="100644 blob $hello_sha1	hello${LF}"
 
-run_tests 'tree' $tree_sha1 $tree_size "" "$tree_pretty_content"
-run_tests 'blob' "$tree_sha1:hello" $hello_size "" "$hello_content"
+run_tests 'tree' $tree_sha1 "" $tree_size "" "$tree_pretty_content"
+run_tests 'blob' "$tree_sha1:hello" "100644" $hello_size "" "$hello_content"
 
 commit_message="Initial commit"
 commit_sha1=$(echo_without_newline "$commit_message" | git commit-tree $tree_sha1)
@@ -283,7 +290,7 @@ committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 $commit_message"
 
-run_tests 'commit' $commit_sha1 $commit_size "$commit_content" "$commit_content"
+run_tests 'commit' $commit_sha1 "" $commit_size "$commit_content" "$commit_content"
 
 tag_header_without_timestamp="object $hello_sha1
 type blob
@@ -297,7 +304,7 @@ $tag_description"
 tag_sha1=$(echo_without_newline "$tag_content" | git hash-object -t tag --stdin -w)
 tag_size=$(strlen "$tag_content")
 
-run_tests 'tag' $tag_sha1 $tag_size "$tag_content" "$tag_content"
+run_tests 'tag' $tag_sha1 "" $tag_size "$tag_content" "$tag_content"
 
 test_expect_success "Reach a blob from a tag pointing to it" '
 	echo_without_newline "$hello_content" >expect &&
-- 
gitgitgadget

