Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD3A3B1ECC
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881029; cv=none; b=DklMSF3YnKFZX/838omZHlnQZN5eApp6Om63XZuvob2EBRkUl349cX0xEXS6NZnTMrN6JSr7DyJ1jlqjhlLuijEc/mOOmfj9sg0od5G/KMWstcJMS6Y6Okk/T9Q3dWf03fNqtxxjcKomcuX9yfz4Fsip6vfAlOzkVBT7bbIdHsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881029; c=relaxed/simple;
	bh=qxWia6P8Fe23p28Ar+Q0VqnLST9Dsa8UhPxw0Lv6RxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RwRrB6uuBteU1GTWKtZ2ZBpgnr/QJIuuHOuVptItRHhlajXD4nCzGnUxCqOztFGlgXy2nxI1CU5YTlZB/SB38/EwPqCnaxU+CLCqi7zI72JeE3ik96vyhOC2VYwm5Zw+qp2DpfDYwf0HD0FAY1Q5rE8UnRALdpLZijVPx/gSRVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGgt2Suu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGgt2Suu"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4908b92904fso28169295e9.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781881026; x=1782485826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXiJ0nUEI5N4CmeP8j/Zk0iA1znATUQ8IF+uv6Ehzes=;
        b=BGgt2SuuPDk7893ydwWd+VKHeMEWR6n9xVcMwoBCYbbWVSsaRRMh31O4Sk1LSPk+Cf
         o8JlW8p6en1iPiaNeE0sYWn64X8jxYi3ni6CEV6inAPBhYOEgN+HYamMEt1RTFlun++y
         qx/94D10TbWK0EnufFlyoO6nV7oUlHGppH71SzshcowFF0pjCdDoIfS3RG4ANEOtpyfp
         uUsO/HkTXQ+L9aDZFpyFr7FcRt0/ocv2A/U5xOfl1Re8QfCm7aVmCVcztc6YwPhwYudp
         xSEBA5UYBUTypCTXRQrnEZFs1d0HgZ3fKF7kqzpwdTrTVUz3ec4JNxEwB5IlwCnkvSaY
         mwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781881026; x=1782485826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LXiJ0nUEI5N4CmeP8j/Zk0iA1znATUQ8IF+uv6Ehzes=;
        b=V9BAb7xNRqn9x77mfbPrHGSiR7gdTD7qVPVRO82X2qLOwV4G6X8Zm2LpGT4otJCj0Z
         zEJ6u6FjnMroIkSwlfcofzR1MZXcsr8r/2BCLfihfSI/t7xYyMnSpF2HOkInI3YQuYwz
         gXtAF4syOYXygDyB3hh1kuhUsyHNiV4/tCHzVmwtcgEPuXiF1zL/WYe4Uow8IMcbd7f7
         WhMNRMc+tuOilsObsGU7k3a8swWFkSdu3KVGUYz/DAqea3/jLY/hU5qnt8sB/O8GKlbP
         oRkL/xOXzW/9uFzl9+N2//QkXMMFVFm8YcH4PuV0ueXlBaIW4uQSeWYaGEffmGtQ5jDs
         gW3Q==
X-Forwarded-Encrypted: i=1; AFNElJ/AGk6p3V/ne1vzgXRos61uy89qhBhxSdjWK9uC/Mqvw2PhKcu6J4L2tkUJH/6QfW4eTsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0AeE9YS6j/8yJyDBDTIRoHAYkbIMWQAPBJRN5Cwkz5yr5dwrF
	Vtx8fyQLxPMC74edYr9PzDFSftaCtlRM41rkuNeLKxMVZJwF6+rg9Bzv
X-Gm-Gg: AfdE7cntX5OiWH20SuXW7VZfzrQjaE8Vb3qT+QM1zBkxXntE1K56TifR2ejoJnUcWS3
	ylUCgLA12ziFU9ZzMf7Y28AShfPtF9Nk5o9lyFgavc8jQof4KnOGbanG3qsSTshXj0YgRCZ1Hx2
	NNjmbXeb7SgAy2wDtN0dGBKcwdUKQ7kcpaN/Ajg0Rk9V5iH5k3haUnfJXOevf9msYgm2OzD+p9J
	L5bN72jnK87SZoz47PQfNdRPp5N1zKndTND06blbD/HrdZLpm0vwJ82f7UTiS+1ty4aWZfnhPjX
	3xpWWwvTZP4hpPRoXgl5gmqPjqHd4TnEaiXTX6NI4yhSkrbOwKUf/3mXYAayq5p1YbFt9G0P/yB
	7tq/JKsBSfjJqDqGx/b1pb3K2G22awTo5bAmaZHrLmqewVVc+AZ8RVLenRePiJb4lqWsdCUVYXC
	3Zwj9QNmaLsZQyblDgzjqPPRtV2J+4s9QE9mQACWyjON24Q/oYOlBFY1YNCZUswql6TCngI6GNU
	oaNxk6UFepSr2whmRxNGOV6Sk2XI19udU3g1vaQGeg2ZHYgl4B+cVrmcR0a4M7wlu9jihhqdZLk
	7F4o4cWYBQWBoF0oDNoQR9mt16imZoPcSjbkPIIPpEXnXJ7sWT9c1XhepiPaP6npz61EHfJd+ja
	zlSpdxuTUDHNfDg==
X-Received: by 2002:a05:600c:1c06:b0:492:3346:e2c with SMTP id 5b1f17b1804b1-49242570793mr58291195e9.23.1781881026353;
        Fri, 19 Jun 2026 07:57:06 -0700 (PDT)
Received: from localhost.localdomain (static-204-100-6-89.ipcom.comunitel.net. [89.6.100.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc63fsm39430795e9.1.2026.06.19.07.57.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Jun 2026 07:57:05 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: gitster@pobox.com
Cc: peff@peff.net,
	eric.peijian@gmail.com,
	chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH GSoC RFC v13 11/12] cat-file: validate remote atoms with allow_list
Date: Fri, 19 Jun 2026 16:56:40 +0200
Message-ID: <20260619-ps-eric-work-rebase-v13-11-3d4c7315d2f8@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

strstr() is not enough to validate the format placeholders in
remote-object-info causing two errors:

- Atoms recognized by expand_atom() but the remote doesn't returns 1, but
  data->type contains garbage causing segfault.
- expand_atom() returns 0 for unknown atoms, calling
  strbuf_expand_bad_format() which ends in die() blocking local queries
  if the same format is shared.

Add an allow_list with the supported atoms at the top of expand_atom().
In remote mode, unsupported atoms return 1 leaving the sb empty,
honoring how for-each-ref handles known but inapplicable atoms.

As extra safety, initialize data->type to OBJ_BAD and add a NULL check
for type_name() so uninitialized data doesn't cause segfault.

Update tests that expect previous die() behaviour to expect an empty
string and add an explicit test for empty string return on unknown
placeholder.

Update caveat behaviour documentation.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/git-cat-file.adoc        |  5 +++--
 builtin/cat-file.c                     | 41 +++++++++++++++++++++++++++-------
 t/t1017-cat-file-remote-object-info.sh | 27 ++++++++++++++++++----
 3 files changed, 59 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index aba20eb770..3b7a85b383 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -451,8 +451,9 @@ CAVEATS
 -------
 
 Note that since %(objecttype), %(objectsize:disk) and %(deltabase) are
-currently not supported by the `remote-object-info` command, we will raise
-an error and exit when they appear in the format string.
+currently not supported by the `remote-object-info` command, they will
+return an empty string for remote queries, matching how `for-each-ref`
+behaves for known but inapplicable placeholders.
 
 Note that the sizes of objects on disk are reported accurately, but care
 should be taken in drawing conclusions about which refs or objects are
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 402b2c31a1..7ad6165032 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -336,8 +336,18 @@ struct expand_data {
 	 * optimized out.
 	 */
 	unsigned skip_object_info : 1;
+
+	/*
+	 * Flags about when an object info is being fetched from remote.
+	 */
+	unsigned is_remote:1;
+};
+#define EXPAND_DATA_INIT  { .mode = S_IFINVALID, .type = OBJ_BAD }
+
+static const char *remote_object_info_atoms[] = {
+	"objectname",
+	"objectsize",
 };
-#define EXPAND_DATA_INIT  { .mode = S_IFINVALID }
 
 static int is_atom(const char *atom, const char *s, int slen)
 {
@@ -348,14 +358,31 @@ static int is_atom(const char *atom, const char *s, int slen)
 static int expand_atom(struct strbuf *sb, const char *atom, int len,
 		       struct expand_data *data)
 {
+	if (data->is_remote) {
+		size_t i, allowed_nr = ARRAY_SIZE(remote_object_info_atoms);
+		for (i = 0; i < allowed_nr; i++)
+			if (is_atom(remote_object_info_atoms[i], atom, len))
+				break;
+
+		/*
+		 * On remote, skip unsupported atoms returning an empty sb,
+		 * honoring how for-each-ref handles known but inapplicable
+		 * atoms (e.g. %(tagger)).
+		 */
+		if (i == allowed_nr)
+			return 1;
+	}
+
 	if (is_atom("objectname", atom, len)) {
 		if (!data->mark_query)
 			strbuf_add_oid_hex(sb, &data->oid);
 	} else if (is_atom("objecttype", atom, len)) {
-		if (data->mark_query)
+		if (data->mark_query) {
 			data->info.typep = &data->type;
-		else
-			strbuf_addstr(sb, type_name(data->type));
+		} else {
+			const char *t = type_name(data->type);
+			strbuf_addstr(sb, t ? t : "");
+		}
 	} else if (is_atom("objectsize", atom, len)) {
 		if (data->mark_query)
 			data->info.sizep = &data->size;
@@ -712,10 +739,6 @@ static int get_remote_info(struct batch_options *opt,
 	gtransport->smart_options->object_info = 1;
 	gtransport->smart_options->object_info_oids = object_info_oids;
 
-	/* 'objectsize' is the only option currently supported */
-	if (!strstr(opt->format, "%(objectsize)"))
-		die(_("%s is currently not supported with remote-object-info"), opt->format);
-
 	string_list_append(&object_info_options, "size");
 
 	if (object_info_options.nr > 0) {
@@ -845,7 +868,9 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 			 */
 			data->size = *remote_object_info[i].sizep;
 			opt->batch_mode = BATCH_MODE_INFO;
+			data->is_remote = 1;
 			batch_object_write(argv[i + 1], output, opt, data, NULL, 0);
+			data->is_remote = 0;
 		} else {
 			report_object_status(opt, oid_to_hex(&data->oid), &data->oid, "missing");
 		}
diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-remote-object-info.sh
index b744e81701..9d8f114b72 100755
--- a/t/t1017-cat-file-remote-object-info.sh
+++ b/t/t1017-cat-file-remote-object-info.sh
@@ -236,6 +236,21 @@ test_expect_success 'remote-object-info does not die on missing oid like info' '
 	)
 '
 
+# This tests depends on %(objecttype) not being supported yet, once supported
+# it needs to be updated.
+test_expect_success 'unsupported placeholder on remote returns empty string' '
+	(
+		set_transport_variables "$daemon_parent" &&
+		cd "$daemon_parent/daemon_client_empty" &&
+
+		echo "" >expect &&
+		git cat-file --batch-command="%(objecttype)" >actual <<-EOF &&
+		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
+		EOF
+		test_cmp expect actual
+	)
+'
+
 # Test --batch-command remote-object-info with 'git://' and
 # transfer.advertiseobjectinfo set to false, i.e. server does not have object-info capability
 test_expect_success 'batch-command remote-object-info git:// fails when transfer.advertiseobjectinfo=false' '
@@ -575,10 +590,12 @@ test_expect_success 'remote-object-info fails on unsupported filter option (obje
 		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 
-		test_must_fail git cat-file --batch-command="%(objectsize:disk)" 2>err <<-EOF &&
+		echo "$hello_oid " >expect &&
+
+		git cat-file --batch-command="%(objectname) %(objectsize:disk)" >actual <<-EOF &&
 		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid
 		EOF
-		test_grep "%(objectsize:disk) is currently not supported with remote-object-info" err
+		test_cmp expect actual
 	)
 '
 
@@ -587,10 +604,12 @@ test_expect_success 'remote-object-info fails on unsupported filter option (delt
 		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 
-		test_must_fail git cat-file --batch-command="%(deltabase)" 2>err <<-EOF &&
+		echo "" >expect &&
+
+		git cat-file --batch-command="%(deltabase)" >actual <<-EOF &&
 		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid
 		EOF
-		test_grep "%(deltabase) is currently not supported with remote-object-info" err
+		test_cmp expect actual
 	)
 '
 

-- 
2.54.0
