Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC1236AB6B
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785527406; cv=none; b=K+jZQ0FgwFq7Z/mc1Sg4qLLF3Yz7g6VZQI64pjDDGzDurgAIceq7CKRUJE1xrzEkK8ZyrFuf0rQ/YO5Yv/qO4Bi2G1P3IKCwPa8Krp4qkNPX9t5cdRHj4Bu8s8v6nLQJzu/2XL64iSYlQXsIPDFg3cJJKGhhMC+w5WFBs0L3F30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785527406; c=relaxed/simple;
	bh=3uhTQ+Zrt+cv6SY5qT6ZsxFHmOVk9pUtFADh+atuioU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LQhXC1pxV94YmgPhlKTrphgmATrYUR0aUyOitf9t5kI8UnML6AgWqJvHqh4GJW8dCL56/MRue/tE9I/ParTDjvqgMwXyIO1ihpc1sVF5bwJNJ5r1hrvdGIo39f3taf3kzuPdGdsAYlzl1awjUM76WBNv+EYLwFAjRW0CIbx04ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiCe0fR5; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiCe0fR5"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso722484f8f.0
        for <git@vger.kernel.org>; Fri, 31 Jul 2026 12:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785527403; x=1786132203; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3vcDQhNkW4LsFFYxeq66pCWedLQX1PRxovqQMXNfcjg=;
        b=BiCe0fR5A/VFk2L7D1rfcaY4N5SRlE1hmorl8JktwBXbgLQFCmaGW0v4accQlcVM84
         UJ1FzPEtIra3matyLTd3JNmTNJ+6Oqce7Ma249z7gu7LrW+WKH/m7JmH5IzYFrlPPYxT
         TJ77OTLOSVwFcbnuAAf88fn/W03bX80RfGNEuSZlwqNfI5WOjbJIylHYHzPF9nUUvjAS
         zHhk7Q/rjiKxiHjYw22qd+hiW/oU1MMldx+s8QVoVLbsMmQoDsNPh4vUlwTiyR8DDXDB
         JVKgh3f786AK712nn+2smUsXCph8zivQeJDQ4jAnqmrMiG2qeEuN/TGnft+TfmUV9w7e
         neog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785527403; x=1786132203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3vcDQhNkW4LsFFYxeq66pCWedLQX1PRxovqQMXNfcjg=;
        b=A2HZnD/kJLs3MfGov9dcTwf4BPLSefxTIcLFp0cfMznLwYjrg23xh6RyD/BormpaUS
         gZebdxey2meKqi+0PsQRbR8S48/xSjzNONBJxl4ywxn9YyrpfGOZZfzCyowJldGMoaYl
         pIzF0bpGqKUDGbPSY86AJogLlE5ZjvtpvGpZpBKX8wWJio8qMZ0Zt3HJouZY71TZyjf6
         Fs8Bb7nkdfS71tQPHzrRIVLmdMfEyhbZbwLrFdJhF8QJasWwVfON/0cjTuJr+PHkMt7t
         9VATmgacPa0eM8qrFuBPYywT+2tFceEQsZ2K7cr+yT7or0MiRfWLhwINPyr3YGICTPcc
         srtQ==
X-Gm-Message-State: AOJu0YwMbYehp08PqIjeCAPXqZNz53a5xEWiDjcEmjXQUsVj0Efr1mrC
	1lDA1UCFwqD6mYHQJprxso/zjlakwqTrobrnrjdnoIZ+ClGtQybA67jM
X-Gm-Gg: AR+sD107gjcQxTEk3saG+L1dnBPB9mfirh4UbdzVxIjg8uzPAlvN1QYGMvyw2sHHprO
	g7P9vHVTfP7huqmkipSiWtxo+cKmmRU1jZQZUw7zOc9faLf377/A6sGGTDSsa/zbGA5rQx47xDo
	ykd7dMcZKQpbtE/gqrLyIXDoY/Ixvw8F0loxSWRFhjn+ApnHsWQSZqkBdBQ1hvZH/dbvgbHm9lH
	Xg6r0AQCPWQiqJ2v9FQ/WOklE4aW41gBrWxeKnGaG1AgCVhrJcrg0A41kdIISR+WWvozMCUio1o
	lokEhc63NjTBLKcWgKdEhXJoAnbYcUZBhFzfJ7NB5PD22EIuYS5LvO4Id93+XN6wzIYOyIDR9f0
	Fx76FZ6qFWjC58YMYrMwXWziI84LN5fb1dTrcsvvyE47WhbX8EAFSX0OF3jsQpzdIMxnAs11/xp
	l0IQixE8fvwNsVm/WhDSg13geA0b9qpeKm7I1WUiJ1wfDfp6WjZLQcw1zs/HAILdl0KcISHwy2+
	r5bEfYVA17G9f4QHXh66NjxfvRx88dXixraR2Mk8LdCO9FVTbm3ZxG3NSHpl/wQstp+L00Qyuv3
	sJkp58VGNziYtMJxW0OZFM9XRP0t8baO2IloZ4+GD2nWHjjkJt1zDjVBZRECYpg0ZUAGPrS3QOL
	ELAch73moeq1p4uBHvVz0dzpInF+rguiinsOfg/pEAu90jxqtBLSrc9cLcZHhM5nRO6p7B0Ghv2
	/ppq/CKi0=
X-Received: by 2002:a5d:4d09:0:b0:47f:8ce3:d8f2 with SMTP id ffacd0b85a97d-47fd731132cmr1679749f8f.56.1785527402537;
        Fri, 31 Jul 2026 12:50:02 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e2cf1sm8248568f8f.10.2026.07.31.12.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 12:50:01 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Fri, 31 Jul 2026 21:49:39 +0200
Subject: [PATCH GSoC v2 6/6] cat-file: unify default format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-objecttype-support-v2-6-af577461ed57@gmail.com>
References: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
In-Reply-To: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

%(objecttype) is supported both by the client and by the server.
Change the temporary default format to the unified version that the
other commands use.

Update documentation to remove %(objecttype) from the caveats of
remote-object-info and show %(objecttype) support.

Now that type is supported and the default format unified, update the
tests to expect the new default format.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/git-cat-file.adoc        | 17 +++++------
 Documentation/gitprotocol-v2.adoc      | 15 +++++++---
 builtin/cat-file.c                     |  7 -----
 t/t1017-cat-file-remote-object-info.sh | 52 +++++++++++++++++-----------------
 4 files changed, 44 insertions(+), 47 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index ac3b528c6f..514bfc0032 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -348,15 +348,12 @@ newline. The available atoms are:
 	after that first run of whitespace (i.e., the "rest" of the
 	line) are output in place of the `%(rest)` atom.
 
-The command `remote-object-info` only supports the `%(objectname)` and
-`%(objectsize)` placeholders. See `CAVEATS` below for more information.
+The command `remote-object-info` only supports the `%(objectname)`,
+`%(objectsize)` and `%(objecttype)` placeholders. See `CAVEATS` below for more
+information.
 
 If no format is specified, the default format is `%(objectname)
-%(objecttype) %(objectsize)`, except for `remote-object-info` commands which
-use `%(objectname) %(objectsize)` because `%(objecttype)` is not supported yet.
-
-WARNING: When "%(objecttype)" is supported, the default format WILL be unified,
-so DO NOT RELY on the current default format to stay the same!!!
+%(objecttype) %(objectsize)`.
 
 If `--batch` is specified, or if `--batch-command` is used with the `contents`
 command, the object information is followed by the object contents (consisting
@@ -453,9 +450,9 @@ scripting purposes.
 CAVEATS
 -------
 
-Note that only `%(objectname)` and `%(objectsize)` are currently
-supported by the `remote-object-info` command. Using any other placeholder in
-the format string will return an empty string in its position.
+Note that only `%(objectname)`, `%(objectsize)` and `%(objecttype)` are
+currently supported by the `remote-object-info` command. Using any other
+placeholder in the format string will return an empty string in its position.
 
 Note that the sizes of objects on disk are reported accurately, but care
 should be taken in drawing conclusions about which refs or objects are
diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
index 7bf62014c3..f0a0573e17 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -558,14 +558,17 @@ object-info
 
 `object-info` is the command to retrieve information about one or more objects.
 Its main purpose is to allow a client to make decisions based on this
-information without having to fully fetch objects. Object size is the only
-information that is currently supported.
+information without having to fully fetch objects. Object size and type are the
+only information currently supported.
 
 An `object-info` request takes the following arguments:
 
 	size
 	Requests size information to be returned for each listed object id.
 
+	type
+	Requests type information to be returned for each listed object id.
+
 	oid <oid>
 	Indicates to the server an object which the client wants to obtain
 	information for. They must be full OIDs.
@@ -580,11 +583,15 @@ space.
 	info = *PKT-LINE(attr LF)
 	       *PKT-LINE(obj-info LF)
 
-	attr = "size"
+	attr = "size" | "type"
 
 	obj-size = 1*DIGIT
 
-	obj-info = obj-id [SP [obj-size]]
+	obj-type = "blob" | "tree" | "commit" | "tag"
+
+	obj-val = obj-size | obj-type
+
+	obj-info = obj-id [SP [obj-val *(SP obj-val)]]
 
 If the server does not recognize the OID, the response will be `<oid> SP`
 regardless of the number of attributes requested.
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 884b6d5ad3..8288511b19 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -841,15 +841,9 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 	struct object_info *remote_object_info = NULL;
 	struct oid_array object_info_oids = OID_ARRAY_INIT;
 	struct string_list object_info_options = STRING_LIST_INIT_NODUP;
-	const char *saved_format = opt->format;
 
 	if (strlen(line) >= MAX_REMOTE_OBJ_INFO_LINE)
 		die(_("remote-object-info command too long"));
-	/*
-	 * TODO: Use the default format once %(objecttype) is supported.
-	 */
-	if (!opt->format)
-		opt->format = "%(objectname) %(objectsize)";
 
 	line_to_split = xstrdup(line);
 	count = split_cmdline(line_to_split, &argv);
@@ -904,7 +898,6 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 		data->is_remote = 0;
 	}
 	data->skip_object_info = 0;
-	opt->format = saved_format;
 
 	for (size_t i = 0; i < object_info_oids.nr; i++)
 		free_object_info_contents(&remote_object_info[i]);
diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-remote-object-info.sh
index 93a70f65b7..20a3e99355 100755
--- a/t/t1017-cat-file-remote-object-info.sh
+++ b/t/t1017-cat-file-remote-object-info.sh
@@ -139,10 +139,10 @@ test_expect_success 'batch-command remote-object-info git:// default filter' '
 		set_transport_variables "$daemon_parent" &&
 		cd "$daemon_parent/daemon_client_empty" &&
 
-		echo "$hello_oid $hello_size" >expect &&
-		echo "$tree_oid $tree_size" >>expect &&
-		echo "$commit_oid $commit_size" >>expect &&
-		echo "$tag_oid $tag_size" >>expect &&
+		echo "$hello_oid $hello_type $hello_size" >expect &&
+		echo "$tree_oid $tree_type $tree_size" >>expect &&
+		echo "$commit_oid $commit_type $commit_size" >>expect &&
+		echo "$tag_oid $tag_type $tag_size" >>expect &&
 
 		git cat-file --batch-command >actual <<-EOF &&
 		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid $tree_oid
@@ -152,7 +152,7 @@ test_expect_success 'batch-command remote-object-info git:// default filter' '
 	)
 '
 
-test_expect_success 'remote-object-info does not change the default format of info' '
+test_expect_success 'remote-object-info and info can be mixed using the unified default format' '
 	(
 		set_transport_variables "$daemon_parent" &&
 		cd "$daemon_parent/daemon_client_empty" &&
@@ -162,7 +162,7 @@ test_expect_success 'remote-object-info does not change the default format of in
 		local_size=$(strlen "$local_content") &&
 
 		echo "$local_oid blob $local_size" >expect &&
-		echo "$hello_oid $hello_size" >>expect &&
+		echo "$hello_oid blob $hello_size" >>expect &&
 		echo "$local_oid blob $local_size" >>expect &&
 
 		git cat-file --batch-command >actual <<-EOF &&
@@ -209,10 +209,10 @@ test_expect_success 'batch-command -Z remote-object-info git:// default filter'
 		set_transport_variables "$daemon_parent" &&
 		cd "$daemon_parent/daemon_client_empty" &&
 
-		printf "%s\0" "$hello_oid $hello_size" >expect &&
-		printf "%s\0" "$tree_oid $tree_size" >>expect &&
-		printf "%s\0" "$commit_oid $commit_size" >>expect &&
-		printf "%s\0" "$tag_oid $tag_size" >>expect &&
+		printf "%s\0" "$hello_oid $hello_type $hello_size" >expect &&
+		printf "%s\0" "$tree_oid $tree_type $tree_size" >>expect &&
+		printf "%s\0" "$commit_oid $commit_type $commit_size" >>expect &&
+		printf "%s\0" "$tag_oid $tag_type $tag_size" >>expect &&
 
 		printf "%s\0" "$hello_oid missing" >>expect &&
 		printf "%s\0" "$tree_oid missing" >>expect &&
@@ -448,10 +448,10 @@ test_expect_success 'batch-command remote-object-info file:// default filter' '
 		server_path="$(pwd)/server" &&
 		cd file_client_empty &&
 
-		echo "$hello_oid $hello_size" >expect &&
-		echo "$tree_oid $tree_size" >>expect &&
-		echo "$commit_oid $commit_size" >>expect &&
-		echo "$tag_oid $tag_size" >>expect &&
+		echo "$hello_oid $hello_type $hello_size" >expect &&
+		echo "$tree_oid $tree_type $tree_size" >>expect &&
+		echo "$commit_oid $commit_type $commit_size" >>expect &&
+		echo "$tag_oid $tag_type $tag_size" >>expect &&
 
 		git cat-file --batch-command >actual <<-EOF &&
 		remote-object-info "file://${server_path}" $hello_oid $tree_oid
@@ -467,10 +467,10 @@ test_expect_success 'batch-command -Z remote-object-info file:// default filter'
 		server_path="$(pwd)/server" &&
 		cd file_client_empty &&
 
-		printf "%s\0" "$hello_oid $hello_size" >expect &&
-		printf "%s\0" "$tree_oid $tree_size" >>expect &&
-		printf "%s\0" "$commit_oid $commit_size" >>expect &&
-		printf "%s\0" "$tag_oid $tag_size" >>expect &&
+		printf "%s\0" "$hello_oid $hello_type $hello_size" >expect &&
+		printf "%s\0" "$tree_oid $tree_type $tree_size" >>expect &&
+		printf "%s\0" "$commit_oid $commit_type $commit_size" >>expect &&
+		printf "%s\0" "$tag_oid $tag_type $tag_size" >>expect &&
 
 		printf "%s\0" "$hello_oid missing" >>expect &&
 		printf "%s\0" "$tree_oid missing" >>expect &&
@@ -618,10 +618,10 @@ test_expect_success 'batch-command remote-object-info http:// default filter' '
 		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_client_empty" &&
 
-		echo "$hello_oid $hello_size" >expect &&
-		echo "$tree_oid $tree_size" >>expect &&
-		echo "$commit_oid $commit_size" >>expect &&
-		echo "$tag_oid $tag_size" >>expect &&
+		echo "$hello_oid $hello_type $hello_size" >expect &&
+		echo "$tree_oid $tree_type $tree_size" >>expect &&
+		echo "$commit_oid $commit_type $commit_size" >>expect &&
+		echo "$tag_oid $tag_type $tag_size" >>expect &&
 
 		git cat-file --batch-command >actual <<-EOF &&
 		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid $tree_oid
@@ -636,10 +636,10 @@ test_expect_success 'batch-command -Z remote-object-info http:// default filter'
 		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_client_empty" &&
 
-		printf "%s\0" "$hello_oid $hello_size" >expect &&
-		printf "%s\0" "$tree_oid $tree_size" >>expect &&
-		printf "%s\0" "$commit_oid $commit_size" >>expect &&
-		printf "%s\0" "$tag_oid $tag_size" >>expect &&
+		printf "%s\0" "$hello_oid $hello_type $hello_size" >expect &&
+		printf "%s\0" "$tree_oid $tree_type $tree_size" >>expect &&
+		printf "%s\0" "$commit_oid $commit_type $commit_size" >>expect &&
+		printf "%s\0" "$tag_oid $tag_type $tag_size" >>expect &&
 
 		batch_input="remote-object-info $HTTPD_URL/smart/http_parent $hello_oid $tree_oid
 remote-object-info $HTTPD_URL/smart/http_parent $commit_oid $tag_oid

-- 
2.54.0

