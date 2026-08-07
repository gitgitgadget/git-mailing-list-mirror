Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A2E45C6FA
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140454; cv=none; b=hii/kFr4mw4s6Q2cGyOTt/glBPiJhVOUYTMpdZjmQX6VkJBKK+dv/ujWtKyES8HOqj2hZA7C0qdHDeahX73OIEgarB8DUSo2oVDAiGX1/h9NvmKXEJwOKHcfbLHJKokkhjZZ/ST3k7JNuNQ2Nfi5saqC7cRJZAbRC5a/xbgXEPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140454; c=relaxed/simple;
	bh=agUH9gahwLhT+X/qaaWBe/LpHXY6/1oaSOQ7j8A3tyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p0yBhIRgHEgar0dymBx9cU5uc5soQmxnK/no/3aR9lne8ptpB0abh0JsZjgPb4+KvpFdVz6eLVGCzH5KDNSSo9V5tKbqaI58p4Qei6ctSq9EpwGbo0gFSXM+DDN6y+vo4vq5n+6TJLH9XIImnE+UF1nNCHXmVsshpL/F5naDKQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpH4xaoe; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpH4xaoe"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-495437bb891so234625e9.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 15:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786140451; x=1786745251; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D2dm1kfHdv+HjccmvDED6fAnJOsIiHpsJ5EF1M1dKew=;
        b=dpH4xaoeovHMDlALNCH0XldyZHrBPuD0YnjC4WZ6e2G4skC13OsBnl5xfJitZwnIdg
         tA9PKKxgejlJS2UWYlyAeN2JZgYER1YINFN+J6MbyvId05vFe72Ge6wioT8txyp1mlFU
         MOR4cjDDMQUON+COfI6le8HvNcdQ5269L1Us4JCE9ofmHFslFy5Xpf2PGq8U/pRTmwhC
         yR4NBe1Bt1QqpM9+Sf76dWucwjcax6JKgk8eBCyo44VTIjfIhLtvAPJuBJMY5oqER5wB
         ycVOGqFgDWKZGoEL7alls26S9/O5depUpE8TwQagze7UXx22fVprd5MpAIQ0ehlSSyMB
         d0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786140451; x=1786745251;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D2dm1kfHdv+HjccmvDED6fAnJOsIiHpsJ5EF1M1dKew=;
        b=VoVkcERmcfocCX9kJXkRBDhcwruVcde+Fiw6A4xJZiFD23nxkDiqKJbW5WacETbZ38
         UzO0xwU6n3S7twgw0JTDPy6c01MF4FlI2z24z/rYUNuTFbRgoydjPHsgzrxW2FRNd4w9
         c3oD2RfzD5kdrQSMJD8nRvQ8WPDgNbPNgbnX2J3V5+QNj7I2XwiEwveGi9qvFWZxH52L
         JaWahqZbC1ZWp3tt/WVzKnpy6wk8IFOkXEAT4poptp8Ieh4bqH6iKran2pAY6yqnx985
         61TYkTfsuBa8RNf2UVionJ8DvQfBba+yDtfDgClZ6k0oqplOZ5srDpP2PymOuj7/6ArK
         tvhQ==
X-Gm-Message-State: AOJu0YzqTsYUGGQjWhcFTnFDmx1d/6i11UlnaStAOXXO5MYCUBQ2zPLH
	bNPHhxcKkd8Clyty9+VBsa0Vh1nFmd7YoKTfGmYLAxUy6rpSTxYQajT7tuw/DD9r
X-Gm-Gg: AR+sD13bxnkGmjd+uOESyyGdt08d0x3qGKYbnhcG+xrO+lA7VqnX0HUWp2MWRS81wT/
	LpmmUrSk1Ql4CpHbc9FYDP9/KZb2BaqvyugPsElhuAudjvDsbFXwV3KEWKMfTAzFTE9AufLfQST
	pNB63x43ClxG9UCmRkXapW7ht+uQpX0NnNvkD1ytTmlT6p/WIDmwY3ZJ9U2L5jA/Nc1u92H1Vpi
	4heFUEVqDuFLB/04J1YAltUNKyX52NdidS7JpeYPqVF+DxUpXc6g2prElIfq3SvHd9jTG9zsKDc
	QvJeuRK2RW6im9tIBwQzSFvviRawezt7MMX+y3v5QdX1uRVzXgZnz0x9lpUU4k8tvonYtWG5hJI
	lQJrXR035xII9JvDJ9prTWt+pKX2VFOdWjD0/A7gtYlkY5OzI2cg3xlbQTd4iiaGZnekm4S0ny1
	5rNDQiMHj0T9L5XimUwRSLeQ4OOxDOJ8tosa+GBzVb3biXk5+NNqISsTs0IU2r8CDPJU2LnrX9+
	BQuIXODyIZeV7tZFRvtF2y1mwTMiCD6tYT0pt2Ccj+buQAhwgS6Cj9wZGFTdfiqSuciNmGOJdvU
	MhurF9VCQoir0Q9/h4PsJv6p9J4Vf7v4TVA7siNGU4kdM4KV13z85IHmNbSGJwVd0W4o2BEIHFB
	cJvZljEbLmBlFyKObsHLs+b70QinRMG58V3l3wzmZcDUidSFH0qtTIj2SXmZ8G+6fjaPp
X-Received: by 2002:a05:600c:3154:b0:495:3bc6:d381 with SMTP id 5b1f17b1804b1-49962453c45mr15693685e9.2.1786140450572;
        Fri, 07 Aug 2026 15:07:30 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa (183.red-79-149-223.dynamicip.rima-tde.net. [79.149.223.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c7b4499sm69478545e9.3.2026.08.07.15.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 15:07:30 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 08 Aug 2026 00:07:05 +0200
Subject: [PATCH GSoC v5 10/10] cat-file: unify default format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-objecttype-support-v5-10-86f22bec04b2@gmail.com>
References: <20260808-objecttype-support-v5-0-86f22bec04b2@gmail.com>
In-Reply-To: <20260808-objecttype-support-v5-0-86f22bec04b2@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
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
 Documentation/gitprotocol-v2.adoc      | 18 +++++++++---
 builtin/cat-file.c                     |  7 -----
 t/t1017-cat-file-remote-object-info.sh | 52 +++++++++++++++++-----------------
 4 files changed, 47 insertions(+), 47 deletions(-)

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
index 7bf62014c3..dd52fd8110 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -558,14 +558,17 @@ object-info
 
 `object-info` is the command to retrieve information about one or more objects.
 Its main purpose is to allow a client to make decisions based on this
-information without having to fully fetch objects. Object size is the only
-information that is currently supported.
+information without having to fully fetch objects. Currently only object size
+and type are supported.
 
 An `object-info` request takes the following arguments:
 
 	size
 	Requests size information to be returned for each listed object id.
 
+	type
+	Requests type information to be returned for each listed object id.
+
 	oid <oid>
 	Indicates to the server an object which the client wants to obtain
 	information for. They must be full OIDs.
@@ -580,11 +583,18 @@ space.
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
+
+The values in `obj-info` appear in the same order as the corresponding `attr`
+lines, with exactly one value per requested attribute.
 
 If the server does not recognize the OID, the response will be `<oid> SP`
 regardless of the number of attributes requested.
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8502020083..011acdec09 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -821,15 +821,9 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 	char *line_to_split;
 	struct fetch_object_info_results results = FETCH_OBJECT_INFO_RESULTS_INIT;
 	struct oid_array object_info_oids = OID_ARRAY_INIT;
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
@@ -881,7 +875,6 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 		data->is_remote = 0;
 	}
 	data->skip_object_info = 0;
-	opt->format = saved_format;
 
 	free_fetch_object_info_results(&results);
 	free(line_to_split);
diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-remote-object-info.sh
index 190c45eefc..e2919aa061 100755
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

