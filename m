Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793071020;
	b=T7o1SwYdi7IrOEtSSf9CFu63Aw5XVTu0JRJmNMYyjGjWf9a6AB+h4QKo3b+MEnVVytoW
	 yrmj0SZhoaG/AAzH52hFES1U8NLbrmwC+SwuRM9NOq40DCQ2+dwa7vZuuKtc6Ewioi8hL
	 3d2bFebdRt5qVKzXs+26XcaI46CwtfGkdqYJhqxZE28NrPbhGSC84f2LOD/pskumKzy5W
	 WWaXRLcH3UYIzTle4inZk/OUx4XgiU2jWArDbWX/wN05714Gi7s5glqewhr52oEkvRhH+
	 OZ3xO6QnKNLqWoLyq8rLwaUMk7OXZGw5ICpb1T7S/NC0VGH/urNDwWZNppuaUeUMHuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793071020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=JCyblyAbxzUb7k7kBCcjjSSGT59wbwuBADmN48CcUmo=;
	b=L68pfICWdHi7FzIt+LvRYq/5IZZUqihNKd2cJPy7sNi4Vd8K4ZE2UkbkByyBXIhLEdd5
	 dAKYTo80KSnD66iqzAvHUJdd+A+EaRJFZsSCvim+b4Y8PDaQQJsK4UIeEOv6plBcTrKml
	 lK/S0/XJVz8feZf8vAt05v0dZy+81bPr0D9I22oYwcG8qL7k8cxMbroY/BLI51IORDPIO
	 P39nsTXKT+CFjxkB6toeG/2N1MUd2KyCzDJ43/O3N6qVqBKMrW7BoqXyVmBEMgPLUlr/R
	 muLPZhGSM4AZ5limGOso01cWuFy05aeS9xbUJNs7fDAbdNWMLv+X7GyCBoyVMkUi/nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SOWinL31;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1C7606A321
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 03:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A1C7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SOWinL31
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e0d885929so2431592f8f.3
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 20:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793071019; x=1793675819; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JCyblyAbxzUb7k7kBCcjjSSGT59wbwuBADmN48CcUmo=;
        b=SOWinL31b9mHfpivSauve7V+y4s/JZ0U7RziPMsv8/Oh2bh8F5VLuDQqHDDJxfQSIb
         UDkFGgQW9WeKUo9CBNDMXxuD7KjPVegHP/EJDbPqtMtW7kG6YsGEu8grgjncbn5vDu+n
         9ACpU0DZ4+EAlLL18yBxK8C15yG3On+du2+QQlCAh1m8WtET1ZHvB9EwClmNLfGbjSxy
         niJPlFXqMUvmFsKl4d115Jd12vswLjB8e37rAdHTLEb+HrL5xwSSC/1iVG3sRjxU41ZW
         raVWuZKV1r7AG8RTZzmqzb3NzEWS/pJ5f7rNPG2zV5Rz/Nx7WB/0Tmsu6N3fl9RwVPVW
         0RfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793071019; x=1793675819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JCyblyAbxzUb7k7kBCcjjSSGT59wbwuBADmN48CcUmo=;
        b=do0C+mSWW17j/32RdtIsIXyS2GgCI3GhnIZf9zPTAUqz9D2ATpnkQD05j5WdGdzTwO
         DlaaF4ybyd2n+VsGVP7TaXC9dn1nf6eEowROf1xk//3Wph93G+eRPAGULiK1Cgrg/9NK
         ogSEa0ZgUIHv3TQ+SUxLEma69mNNCdBOpe1hEJR1p5xWI6nvqE/HgkIBtIjvnwVxzK84
         2UBgsCMPsVHbhAn88qkVy8riGl/93WwFrVEWh8uyIpbFDkIiJdV/Nek5atfCoEYch6ck
         kf8UTzqXK/GBZUCZMJ7AGRWECOiLZB8EA+nfmrJ64hVPEDCiDaB2iO0K4qAKrke7LWmP
         CgVw==
X-Gm-Message-State: AFq9FYJH6uQAVV+KloKkUX50phkM0mZfzTTCKDN3P0FrY9W5UbPAfZsY
	B6ech18/FNmPrZZwqbBa0owgq8+cQyrEJSSKzGO2r+imaHxVqltnwOIE/ORQpaSw
X-Gm-Gg: AYBFou0kYpPI7I3Jm5RP9j6RNjRjZuomKvfehnLS1EIBJFOSmYfGO0QQ3qQUTzNNUO+
	cQyhCqNPVN9VTyLlce/D6wA9HbJVC8o54/yrlAGR7ydOxhAc7LEbY4pI4ypzSKCobCWzgfwNFTX
	SvDmQ/pGKh8yPSgH6x7kvT4LywVnUNX4j6zwENfdUyq3lkvsqHykMpUXseBgu+MK7AkKt4K/hHs
	3P6NglfwVRNtlTiMv+8ANiZGLU533lL8oOaHWOInsKo1UUtUTyhCXmrAShC9IoZVM2dH6Z7Bruq
	pISZCrSG57NetOiuFDGs4+4zVaLJePXaNuTIguXqt+Alt5VAox4WNFkxTJgzrpgfOzYUZ++P/n1
	BrCU0vAu0xpKvek1DP6Uhv2S2rFkh8jUgUqiRyvz715OqM/jGzpcgwD5mC60x4tIsjw716vxY3b
	JrjDN4haghdK+cKAjTZSAe226DaN+QILWCWgaPyLgfisUlv99YdUSqwSTtuPRMOw7ZDF/ExFisf
	Z4J6k739Iz13Pt5w+pzAA3TSJ/ayb6xXV2fLIE3H3f46uFIB5vf74F3Pb2oejMGSqNSTwjZFezP
	xAGKoBemG6q8cwghuGanp5i5qfVZQYPvjfu0/QnptQPzsDdQQbKHk/q8K+fr2ibtE92n5p09bfJ
	F4W7RyQ56S7KUMzTxpFYC7a01OBais/2DpfSdcvv80RBG6Ncz7h5I4l1oecHK3kwPn35NWoLLiJ
	yCIg==
X-Received: by 2002:a5d:5f4b:0:b0:488:8525:4979 with SMTP id ffacd0b85a97d-48e3ebb1affmr15429581f8f.45.1793071018382;
        Mon, 26 Oct 2026 20:16:58 -0700 (PDT)
Received: from mac.lan ([2001:818:c665:a700:9b4:dea8:96dd:9a68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd47basm21777960f8f.32.2026.10.26.20.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:16:58 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 27 Oct 2026 03:16:53 +0000
Subject: [PATCH RFC 3/3] cat-file: add --remote-max-batch option
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-remote-object-info-batch-v1-3-ea7a1f0b1df1@gmail.com>
References: <20261027-remote-object-info-batch-v1-0-ea7a1f0b1df1@gmail.com>
In-Reply-To: <20261027-remote-object-info-batch-v1-0-ea7a1f0b1df1@gmail.com>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

Now that remote-object-info works by requesting in batches, a user might
not want to use the default of 50k OIDs per batch.

Add a new --remote-max-batch option that changes the size of the
batches.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/git-cat-file.adoc        | 16 ++++++--
 builtin/cat-file.c                     | 46 ++++++++++++++++++++---
 t/t1017-cat-file-remote-object-info.sh | 68 ++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index c4ea2524cf..a21a4d7fd4 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -14,7 +14,7 @@ SYNOPSIS
 	     [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]
 'git cat-file' (--batch | --batch-check | --batch-command) [--batch-all-objects]
 	     [--buffer] [--follow-symlinks] [--unordered]
-	     [--textconv | --filters] [-Z]
+	     [--textconv | --filters] [-Z] [--remote-max-batch=<n>]
 
 DESCRIPTION
 -----------
@@ -143,8 +143,8 @@ are not of the requested type.
 --batch-command::
 --batch-command=<format>::
 	Enter a command mode that reads commands and arguments from stdin. May
-	only be combined with `--buffer`, `--textconv`, `--use-mailmap` or
-	`--filters`.
+	only be combined with `--buffer`, `--textconv`, `--use-mailmap`,
+	`--filters` or `--remote-max-batch`.
 +
 --
 	* When used with `--textconv` or `--filters`, the input lines must
@@ -174,6 +174,9 @@ remote-object-info <remote> <object>...::
 	`<remote>` without downloading objects from the remote.
 	Raise an error when the `object-info` capability is not supported by the remote.
 	Raise an error when no object references are provided.
+	There is no limit on the number of objects; they are requested from
+	the remote in batches over a single connection, see
+	`--remote-max-batch`.
 	This command may be combined with `--buffer`.
 
 flush::
@@ -215,6 +218,13 @@ flush::
 	only once, even if it is stored multiple times in the
 	repository.
 
+--remote-max-batch=<n>::
+	Maximum number of objects that `remote-object-info` asks for in a
+	single `object-info` request. If a `remote-object-info` command is
+	given more objects, the rest are requested in further batches over
+	the same connection. `<n>` must be a positive integer. Defaults
+	to 50000. Requires `--batch-command`.
+
 --follow-symlinks::
 	With `--batch` or `--batch-check`, follow symlinks inside the
 	repository when requesting objects with extended SHA-1
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 4f78194bbd..ca2122c67b 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -59,6 +59,8 @@ struct batch_options {
 	char input_delim;
 	char output_delim;
 	const char *format;
+	size_t remote_max_batch;
+	unsigned custom_object_info_batch;
 };
 
 static const char *force_path;
@@ -799,9 +801,9 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 	char *line_to_split;
 	struct fetch_object_info_results results = FETCH_OBJECT_INFO_RESULTS_INIT;
 	struct oid_array object_info_oids = OID_ARRAY_INIT;
-	size_t batch_size = DEFAULT_REMOTE_BATCH_SIZE;
 	struct transport *transport;
 	struct remote *remote;
+	size_t object_nr;
 
 	line_to_split = xstrdup(line);
 	count = split_cmdline(line_to_split, &argv);
@@ -811,6 +813,7 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 
 	if (count < 2)
 		die(_("remote-object-info requires objects"));
+	object_nr = (size_t)count - 1;
 
 	if (data->info.sizep)
 		results.wants_size = 1;
@@ -826,12 +829,16 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 	if (!transport->smart_options)
 		die(_("smart options required"));
 
-	for (size_t j = 0; j < count - 1; j += batch_size) {
+	for (size_t j = 0; j < object_nr; j += opt->remote_max_batch) {
 		const char **objects = argv + 1 + j;
-		size_t remaining = count - 1 - j;
-		size_t objects_nr = batch_size < remaining ? batch_size : remaining;
+		size_t objects_in_batch_nr;
 
-		get_remote_info(transport, objects, objects_nr, &results, &object_info_oids);
+		if (opt->remote_max_batch < object_nr - j)
+			objects_in_batch_nr = opt->remote_max_batch;
+		else
+			objects_in_batch_nr = object_nr - j;
+
+		get_remote_info(transport, objects, objects_in_batch_nr, &results, &object_info_oids);
 
 		string_list_clear(&data->remote_allowed_atoms, 0);
 		string_list_append(&data->remote_allowed_atoms, "objectname");
@@ -1145,6 +1152,24 @@ static int git_cat_file_config(const char *var, const char *value,
 	return git_default_config(var, value, ctx, cb);
 }
 
+static int set_remote_batch_size(const struct option *opt,
+				 const char *arg,
+				 int unset)
+{
+	struct batch_options *bo = opt->value;
+	size_t n;
+
+	BUG_ON_OPT_NEG(unset);
+
+	if (!git_parse_size_t(arg, &n) || !n)
+		return error(_("%s expects a positive number"), opt->long_name);
+
+	bo->remote_max_batch = n;
+	bo->custom_object_info_batch = 1;
+
+	return 0;
+}
+
 static int batch_option_callback(const struct option *opt,
 				 const char *arg,
 				 int unset)
@@ -1184,6 +1209,7 @@ int cmd_cat_file(int argc,
 	const char *exp_type = NULL, *obj_name = NULL;
 	struct batch_options batch = {
 		.objects_filter = LIST_OBJECTS_FILTER_INIT,
+		.remote_max_batch = DEFAULT_REMOTE_BATCH_SIZE,
 	};
 	int unknown_type = 0;
 	int input_nul_terminated = 0;
@@ -1197,7 +1223,7 @@ int cmd_cat_file(int argc,
 		   "             [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]"),
 		N_("git cat-file (--batch | --batch-check | --batch-command) [--batch-all-objects]\n"
 		   "             [--buffer] [--follow-symlinks] [--unordered]\n"
-		   "             [--textconv | --filters] [-Z]"),
+		   "             [--textconv | --filters] [-Z] [--remote-max-batch=<n>]"),
 		NULL
 	};
 	const struct option options[] = {
@@ -1240,6 +1266,9 @@ int cmd_cat_file(int argc,
 			 N_("follow in-tree symlinks")),
 		OPT_BOOL(0, "unordered", &batch.unordered,
 			 N_("do not order objects before emitting them")),
+		OPT_CALLBACK_F(0, "remote-max-batch", &batch, N_("n"),
+			       N_("set a custom object-info batch size"),
+			       PARSE_OPT_NONEG, set_remote_batch_size),
 		/* Textconv options, stand-ole*/
 		OPT_GROUP(N_("Emit object (blob or tree) with conversion or filter (stand-alone, or with batch)")),
 		OPT_CMDMODE(0, "textconv", &opt,
@@ -1307,6 +1336,11 @@ int cmd_cat_file(int argc,
 		usage_msg_optf(_("'%s' requires a batch mode"), builtin_catfile_usage,
 			       options, "-Z");
 
+	if (batch.custom_object_info_batch &&
+	    batch.batch_mode != BATCH_MODE_QUEUE_AND_DISPATCH)
+		usage_msg_optf(_("'%s' requires '%s'"), builtin_catfile_usage,
+			       options, "--remote-max-batch", "--batch-command");
+
 	batch.input_delim = batch.output_delim = '\n';
 	if (input_nul_terminated)
 		batch.input_delim = '\0';
diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-remote-object-info.sh
index e2919aa061..75624a9498 100755
--- a/t/t1017-cat-file-remote-object-info.sh
+++ b/t/t1017-cat-file-remote-object-info.sh
@@ -61,6 +61,18 @@ set_transport_variables () {
 # Since "%(objecttype)" is currently not supported by the command remote-object-info ,
 # the filters are set to "%(objectname) %(objectsize)" in some test cases.
 
+test_expect_success '--remote-max-batch rejects zero and non-numbers' '
+	test_must_fail git cat-file --batch-command --remote-max-batch=0 </dev/null 2>err &&
+	test_grep "remote-max-batch expects a positive number" err &&
+	test_must_fail git cat-file --batch-command --remote-max-batch=foo </dev/null 2>err &&
+	test_grep "remote-max-batch expects a positive number" err
+'
+
+test_expect_success '--remote-max-batch requires --batch-command' '
+	test_must_fail git cat-file --batch-check --remote-max-batch=2 </dev/null 2>err &&
+	test_grep "requires .--batch-command." err
+'
+
 # Test --batch-command remote-object-info with 'git://' transport with
 # transfer.advertiseobjectinfo set to true, i.e. server has object-info capability
 . "$TEST_DIRECTORY"/lib-git-daemon.sh
@@ -134,6 +146,25 @@ test_expect_success 'batch-command remote-object-info git:// multiple sha1 per l
 	)
 '
 
+test_expect_success 'remote-object-info git:// across batch boundaries' '
+	(
+		set_transport_variables "$daemon_parent" &&
+		cd "$daemon_parent/daemon_client_empty" &&
+
+		echo "$hello_oid $hello_size" >expect &&
+		echo "$tree_oid $tree_size" >>expect &&
+		echo "$unstored_oid missing" >>expect &&
+		echo "$commit_oid $commit_size" >>expect &&
+		echo "$tag_oid $tag_size" >>expect &&
+
+		git cat-file --batch-command="%(objectname) %(objectsize)" \
+			--remote-max-batch=2 >actual <<-EOF &&
+		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid $tree_oid $unstored_oid $commit_oid $tag_oid
+		EOF
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'batch-command remote-object-info git:// default filter' '
 	(
 		set_transport_variables "$daemon_parent" &&
@@ -461,6 +492,25 @@ test_expect_success 'batch-command remote-object-info file:// default filter' '
 	)
 '
 
+test_expect_success 'remote-object-info file:// with objects a multiple of the batch size' '
+	(
+		set_transport_variables "server" &&
+		server_path="$(pwd)/server" &&
+		cd file_client_empty &&
+
+		echo "$hello_oid $hello_size" >expect &&
+		echo "$tree_oid $tree_size" >>expect &&
+		echo "$commit_oid $commit_size" >>expect &&
+		echo "$tag_oid $tag_size" >>expect &&
+
+		git cat-file --batch-command="%(objectname) %(objectsize)" \
+			--remote-max-batch=2 >actual <<-EOF &&
+		remote-object-info "file://${server_path}" $hello_oid $tree_oid $commit_oid $tag_oid
+		EOF
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'batch-command -Z remote-object-info file:// default filter' '
 	(
 		set_transport_variables "server" &&
@@ -741,6 +791,24 @@ test_expect_success 'remote-object-info fails on not providing OID' '
 	)
 '
 
+test_expect_success 'remote-object-info http:// across batch boundaries' '
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_client_empty" &&
+
+		echo "$hello_oid $hello_size" >expect &&
+		echo "$tree_oid $tree_size" >>expect &&
+		echo "$unstored_oid missing" >>expect &&
+		echo "$commit_oid $commit_size" >>expect &&
+		echo "$tag_oid $tag_size" >>expect &&
+
+		git cat-file --batch-command="%(objectname) %(objectsize)" \
+			--remote-max-batch=2 >actual <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid $tree_oid $unstored_oid $commit_oid $tag_oid
+		EOF
+		test_cmp expect actual
+	)
+'
 
 # Test --batch-command remote-object-info with 'http://' transport and
 # transfer.advertiseobjectinfo set to false, i.e. server does not have object-info capability

-- 
2.56.0

