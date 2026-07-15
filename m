Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489AC42BE9D
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109165; cv=none; b=JyVV2/j5Q9TgDmT2B/KHnEC3tS2WuWvrt0H+D8eJ1laTntd7AeYhMQBd8+DMOrfG39FulXXjhEhnUEldZGXW0VsBnue1cWQL4Gk2ZLoLuh+xxpHVheZzA29ukphuNqhZ//bDDVNj920suO/4gkR7lG/nn5+HyQ+KZZ/nB+lzPzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109165; c=relaxed/simple;
	bh=QcOgyY4H6bldKVYsT1VJv9DlmAj5JgvpGs2D1+lwCzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jndA5ktYW+wF1w2TfWOIKlZfdnEqzDpYacJBWc7li3NTydqk1NINlH/e6jWEQeByZTImcPAMxzdmPQnj8XalUZid/rMWbuSj165h3WvN2qYvYa2EbbDXlJ3aBdf14I9jVNNY5av+PYHGsbmc45Y7xHIrT0/n+3aZ2qUGB83bPuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtNyor68; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtNyor68"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493f140ca8eso31444145e9.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 02:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784109162; x=1784713962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BGhD57xwUgjscRN8Qmzjbu6VVG0b3sQWcOgA13cfSso=;
        b=ZtNyor68wglQggSjgqZEO1XOgcyZhU8KTu9bvZ9cZ3Owjm8zzldK0agIoqyJAJVJTc
         tsk1lG99/m/8plO7Us5pRZSk3HxSyypHDMx7+cGiSLKX5Bvsl//TfcIepLp5rKgQToRA
         eTeDWbC4KMbLmtmVbtpNnpL2kllFTubxvmXZY88Q3FnNFo6vrkEU5zgekPFWaBou27fq
         otDvQW86ncKuqmfCYNLIl55e3y1pn8IA+TbWcX4+UsbqkcizWm/kCVZ80nqK4EV0scsZ
         7hmp6odBBWlPzHq9mL4OHfb6FZ/bzyNK0dGjuheHYcdE9I8YAB1wu4dwpQNy0ATuOr2M
         HISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784109162; x=1784713962;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BGhD57xwUgjscRN8Qmzjbu6VVG0b3sQWcOgA13cfSso=;
        b=O+YRgThqNS8p6sSxOqUbheaaTWcc4JXMOoLQJLfFIoyoWVavMTWvU0ph+7WAj5PqXy
         raZSNNzSex4z9g63cn2a24Ad3depkElzPoUejVzaGM+uqv/jtMzYNYCycwrJlQ2/Nbfd
         tn9tHWvv9qEWyZx48SZLmSVeeqSStJm+5A9YwtV9fr4h6H+VQZv63CAxWmiDb1iZkcAR
         T0nb7mu4f+xLjsOk9Ja1O9b7Fubj5sj9/Ku3FZzYrtVVkhRkKBj2pTYCbZpmuLQwFPZ0
         06AyXbz90ZlAKODzUYQI+5glqe5Bv4Ug3rI/NdNEwiqTzjp525ti/8ZC6J15iGdOE43U
         SdMA==
X-Gm-Message-State: AOJu0Yy7TpukMCvc280Ip5uWWg91FTgtzfkv5AgdC/RlS/BvCWl9jP8T
	uF5bgQ2cynw+hC3WnWFolduwIFU+2CjUSCS6DrmvWYrdh1gfs4XKeXkgPF6Dd8zi
X-Gm-Gg: AfdE7ckVQO/jWM7nIhphZpecAEr87SHSbM57GCsOYqdmPPjL+EMIO0p2FUBLAG+sOba
	cbR6JTPqW0TN4WlWkz6GoECPPJg0ZbE2+rJkwHdPFN2UJ56YI39lfheoGMIltDMudtDRv1fZGlo
	2NHzsGPyN/RpW+eP6FcoVg2WghyEt+sCL18NrEjAQ0+8OsOA7tvg9jr6Q9o290PJvbhatPy7YKt
	LNLVfoQwgLm/m/Lt2/Nio2RAbAyP8mfbwHEXhOeXo0/2KRJ6PhGb35legccecCCuRAatZWUdbgZ
	ERTwOvC20VlWvw0tzvqGZMOZ2tZlalLL8on7ly5/pIdKJ4kD6YHCdnqxJSleAndLx3Otg8SbuT7
	CRsp59PPh9ozizOybMPkB4+kBPhTma9ZAaSo3XJ8AVKkJ8zUjkr/INTMJw7agAciLy7E9NHP+WL
	XKJLXCVX7FQZJg3YlANfZuKm4/rC5XQ+YW+dCYEX42MRFJgiOHcn7D0AUlAHoFZadFuQCLXcer4
	i8d+JBIf15copkLJqp8QVUvzkTbZTzNUH47CwNDEV1R61QFttDez1WJUfu4AVnhbUVyfne+ZJrI
	wdoIcrSm6efLSGh9SxB9gafyCfJFhGsOURLqypmIt+hTe2qZ5X0RMMmSrIzX5ADEfDTUaPszEkT
	nq09DEnLh/Q==
X-Received: by 2002:a05:600c:4754:b0:494:ca0e:880a with SMTP id 5b1f17b1804b1-495389d2ba4mr61544575e9.12.1784109162328;
        Wed, 15 Jul 2026 02:52:42 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c9cc3sm15630419f8f.35.2026.07.15.02.52.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 02:52:41 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com
Subject: [PATCH GSoC v18 12/13] cat-file: validate remote atoms with an allow-list
Date: Wed, 15 Jul 2026 11:52:20 +0200
Message-ID: <20260715-ps-eric-work-rebase-v18-12-34d7adb051bb@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
 <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
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

1. Atoms recognized by expand_atom() but the remote doesn't returns 1,
   but data->type contains garbage causing segfault.

2. expand_atom() returns 0 for unknown atoms, calling
   strbuf_expand_bad_format() which ends up dying, blocking local
   queries if the same format is shared.

Add an allow-list with the supported atoms at the top of expand_atom().
In remote mode, unsupported atoms return 1 leaving the buffer empty,
honoring how for-each-ref handles known but inapplicable atoms.

As extra safety, initialize data->type to OBJ_BAD and add a NULL check
for type_name() so uninitialized data doesn't cause segfault.

Update tests that expect previous die() behavior to expect an empty
string and add an explicit test for empty string return on unknown
placeholder.

Update cat-file command documentation regarding remote-object-info.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/git-cat-file.adoc        |  2 +-
 builtin/cat-file.c                     | 41 +++++++++++++++++++++++++++-------
 t/t1017-cat-file-remote-object-info.sh | 27 ++++++++++++++++++----
 3 files changed, 57 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index a7fa6674c3..643eac9245 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -451,7 +451,7 @@ CAVEATS
 
 Note that since only `%(objectname)` and `%(objectsize)` are currently
 supported by the `remote-object-info` command. Using any other placeholder in
-the format string will raise an error.
+the format string will return an empty string in its position.
 
 Note that the sizes of objects on disk are reported accurately, but care
 should be taken in drawing conclusions about which refs or objects are
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 77ecccdda3..af388b6238 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -333,8 +333,18 @@ struct expand_data {
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
@@ -345,14 +355,31 @@ static int is_atom(const char *atom, const char *s, int slen)
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
@@ -709,10 +736,6 @@ static int get_remote_info(struct batch_options *opt,
 	CALLOC_ARRAY(*remote_object_info, object_info_oids->nr);
 	gtransport->smart_options->object_info_oids = object_info_oids;
 
-	/* 'objectsize' is the only option currently supported */
-	if (!strstr(opt->format, "%(objectsize)"))
-		die(_("%s is currently not supported with remote-object-info"), opt->format);
-
 	string_list_append(&object_info_options, "size");
 
 	if (object_info_options.nr > 0) {
@@ -842,7 +865,9 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
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
index 49b6660934..6bc863c391 100755
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
