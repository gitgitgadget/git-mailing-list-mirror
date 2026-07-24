Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9637429024
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890491; cv=none; b=kbm6BVhiV0uBeiP5XO+s+WWAorvBfCl+mOVQ2j/tgUUy6ECbTKAcY5eKYogiK2wRn/5Bp4nx1u1VxBYOHHWKQbJgmDUV6+uzVdDHUNnW1+8GFJfKuYkejxf8FXPi7qo7dgD5Z3kc6XnJDadYpiGLq3WfhP8SeKslR5vpZ75XUl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890491; c=relaxed/simple;
	bh=Pf38r+X4OBxeAHzi8lcKY4wGzD+A9EekY2FCnXRR9uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cSunh88XS/VE7rJjBCnsUJs6pZBL/9MNUeDNRkv+2DQ3aEBm3TlRMF8Agp91bpj6wEuB+qSSh9stR2i5xsktC9DxQrPmG4U5rLfpNlwktlYc1MQFd2jTAjtb0bcHlcRH3VZz+jJ04OG5qCQlhONImy8Y+M9Bwt2quDj/qQXBI54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhlMlTYc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhlMlTYc"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so3548445e9.0
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784890486; x=1785495286; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dANVpjrcCaZzJ6wU8ohR2KmOWfKdpqHleR7SbXd/4c8=;
        b=YhlMlTYcDGWAcEHeBhOYquuJZAGiO/7xpkrNMzpcc7viRI17gHojy6//Tq/BCzJG5S
         UH2wynnEKa33DrZRqf6e5eO8O0KjBCSSOIyAwytVOveDgaYoF72d5iNolhllBdCHqG6J
         tPFUO4KUEFq7l8JM3zRv+Il8d0IID8qurE8nBqOWnypmsF/VvanvAUpJu2+bo4L7FMHI
         uWfRf9Oq8lQnuOUIhsa3X85/dmkuagyNpStHRbj1jlUSyn+hAx2tSwvTr5Pjr5mJPnYK
         gXlOf/4mT/mwaRK5gxg907qK6VkXLtIPmwp+b2y2E0rb+i+CIc2AgbOh2CN9Wn8gnFwd
         0YYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784890486; x=1785495286;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dANVpjrcCaZzJ6wU8ohR2KmOWfKdpqHleR7SbXd/4c8=;
        b=Y3u78Vvw2zitxpoUJBW032zhsvaVYw2UHHEyDo7m7fCDkwlfNTm9pHpOJb/NZh7C7j
         WLS2bUzj1F7VXFO4q9wL1iDBVrcMRI7DAOQZfj0nqlnfkaS2wjHI4F/fN5W75yojBXht
         GRBkeOHOJAa8p3QCJJYw6oWZCOws69xlIqE+9KxU8YEx5sscS3tLb688tpumzCNDONQb
         pw81iQ0ZfT683KWYbe1vPDk+SqlctGkw7pm9SF1CVEysf+OmbWx0TalF382GYJzjnjn4
         He6y/n1M1BnIKYkIDJ3gXzMVF78jN9SWBI/mrmxTuu9c7inyLEAIyxoHymoP32fUp80S
         1erQ==
X-Gm-Message-State: AOJu0YxEtQ++DU4WewT5o73g/IkapcqaBqaWgBEL+9HUExHdnhlMTCMc
	UAhZrUpb5zfr7U7wDnT/MX/xNaCq92mjt50g5jQZhY7yx/fMrnTNzR8kyw4A5hsx
X-Gm-Gg: AR+sD10yLiSGVg0t5zTZpZbA79/V9LNf/E19ZGMRTjk2RUs4TKb1UohSE/1Df0mKdF/
	KHOxoXh3AN3UijUUyz+LyuAZG39FLBQ1ZDzgS6DK9iy1kY1JeF4pJzCVWoFbufrgjoiOwvV58Vi
	fVk7bUZJQeh5zUCvQqTWGJWVZ/wnVyhtNfBugfYG53W4/YqQSyDI6swjsvPJjeMuGpZ027/2Dra
	3vjff9DjNces7Dnm+sIVbatvlpM9Tl1IB3c1Zf19rKCYddRa5HkPBoeLR5FWWlx6ozcehRSxmiw
	6JDW8XGzjvynURzWcwK8BwVKdb8bxP4m3Crl+bFDvEdQMMQ0ep8fhj0WG9COZKvoUMouv8qio0D
	E3qpgU9/5uSKVav4n2FTJ5Q7h6KLU5xhoKOTPrdh7hMMfGhasjrPaGM3knLCrrsWFW15j3q2d84
	FsRQw7VtpLffCmQcsABIX5swpcRR38PGCUFDQqggabqGcfOQIlWb2853LwYCEnnn90uUhIdN5zx
	V+cNnNMUzSgPkY3O8L5KExzXwK+GeKl6xyVK/XQNBHvvGnnHdJ//46rVY/+TP/UfwPvhhW96eer
	CdtXui0yPN5U3ZzFRfbODkQoDqsC61EyPDtRJCLgC/OhVSI=
X-Received: by 2002:a05:600c:a109:b0:493:f528:58ac with SMTP id 5b1f17b1804b1-49573cf6d3cmr73889305e9.21.1784890485468;
        Fri, 24 Jul 2026 03:54:45 -0700 (PDT)
Received: from localhost.localdomain ([148.56.122.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b5f35a1sm41797645e9.0.2026.07.24.03.54.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 03:54:45 -0700 (PDT)
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
	szeder.dev@gmail.com,
	toon@iotcl.com
Subject: [PATCH GSoC v21 13/13] cat-file: make remote-object-info allow-list adapt to the server
Date: Fri, 24 Jul 2026 12:54:24 +0200
Message-ID: <20260724-ps-eric-work-rebase-v21-13-ba67f024fdff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>
References: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
 <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The static allow-list in expand_atom() is hardcoded to allow only
"objectname" and "objectsize" for remote queries. This works because,
up to this point, servers will either support object-info with name
and size or they do not support them at all.

As object-info gains new capabilities, we cannot expect different
servers with different Git versions to have the same object-info
capabilities. Therefore, the client needs to adapt its allow-list to
what the server advertises.

The client now:

1. Requests the protocol option that the placeholder refers to (i.e.
   "size" for "%(objectsize)").

2. Drops any requested option that the server does not advertise in
   fetch_object_info().

3. Maps the remaining advertised options back to their placeholders and
   populates remote_allowed_atoms.

4. Uses remote_allowed_atoms in expand_atom(), preserving the previous
   behavior for supported placeholders.

For example, if the client requests "%(objectsize) %(objecttype)" and
the server only supports 'size', then the client only requests 'size'.
The server returns the size (i.e "42") "%(objectsize)" is expanded
normally while "%(objecttype)" expands to an empty string:

	"42 "

Note that the empty string expansion is only for known but unsupported
placeholders. "%(objectcolor)" which doesn't exist would die().

This honors what for-each-ref does for known but inapplicable atoms
(placeholders).

Move object_info_options out of get_remote_info() so the caller which
has data can select what options will be requested instead of requesting
always size.

Move batch_object_write() out so output is always produced.
If there are no supported attributes, the output is a blank line.

Include "type" in the object_info_options even though the client does
not yet know how to parse the server's "type" capability.

As a result, "type" is always filtered out, allowing the tests to verify
that known but unsupported placeholders expand to an empty string.

Since the filter removes options by swapping with the last element,
the list is no longer kept sorted. Drop the pre-sort in
fetch_object_info_via_pack() and use the unsorted string_list lookup
for the response header. This has no effect in performance as the list
can only be two entries long ('size' and 'type').

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 builtin/cat-file.c                     | 96 ++++++++++++++++++++++------------
 fetch-object-info.c                    | 20 ++++++-
 fetch-object-info.h                    |  3 ++
 t/t1017-cat-file-remote-object-info.sh | 28 ++++++++++
 transport.c                            |  1 -
 5 files changed, 113 insertions(+), 35 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b2a1ad6a0f..884b6d5ad3 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -337,15 +337,20 @@ struct expand_data {
 	 * Flags about when an object info is being fetched from remote.
 	 */
 	unsigned is_remote:1;
-};
-
-#define EXPAND_DATA_INIT  { .mode = S_IFINVALID, .type = OBJ_BAD }
 
-static const char *remote_object_info_atoms[] = {
-	"objectname",
-	"objectsize",
+	/*
+	 * List of atoms (i.e. "objectsize") that the server supports. Built
+	 * from the server's object-info advertised capabilities.
+	 */
+	struct string_list remote_allowed_atoms;
 };
 
+#define EXPAND_DATA_INIT  {  \
+	.mode = S_IFINVALID, \
+	.type = OBJ_BAD,     \
+	.remote_allowed_atoms = STRING_LIST_INIT_NODUP, \
+}
+
 static int is_atom(const char *atom, const char *s, int slen)
 {
 	int alen = strlen(atom);
@@ -356,17 +361,12 @@ static int expand_atom(struct strbuf *sb, const char *atom, int len,
 		       struct expand_data *data)
 {
 	if (data->is_remote) {
-		size_t i, allowed_nr = ARRAY_SIZE(remote_object_info_atoms);
-		for (i = 0; i < allowed_nr; i++)
-			if (is_atom(remote_object_info_atoms[i], atom, len))
+		size_t i;
+		for (i = 0; i < data->remote_allowed_atoms.nr; i++)
+			if (is_atom(data->remote_allowed_atoms.items[i].string,
+				    atom, len))
 				break;
-
-		/*
-		 * On remote, skip unsupported atoms returning an empty sb,
-		 * honoring how for-each-ref handles known but inapplicable
-		 * atoms (e.g. %(tagger)).
-		 */
-		if (i == allowed_nr)
+		if (i == data->remote_allowed_atoms.nr)
 			return 1;
 	}
 
@@ -682,12 +682,12 @@ static void batch_one_object(const char *obj_name,
 static int get_remote_info(int argc,
 			   const char **argv,
 			   struct object_info **remote_object_info,
-			   struct oid_array *object_info_oids)
+			   struct oid_array *object_info_oids,
+			   struct string_list *object_info_options)
 {
 	int retval = 0;
 	struct remote *remote = NULL;
 	struct object_id oid;
-	struct string_list object_info_options = STRING_LIST_INIT_NODUP;
 	struct transport *gtransport;
 
 	remote = remote_get(argv[0]);
@@ -727,13 +727,10 @@ static int get_remote_info(int argc,
 	CALLOC_ARRAY(*remote_object_info, object_info_oids->nr);
 	gtransport->smart_options->object_info_oids = object_info_oids;
 
-	string_list_append(&object_info_options, "size");
-
-	gtransport->smart_options->object_info_options = &object_info_options;
+	gtransport->smart_options->object_info_options = object_info_options;
 	gtransport->smart_options->object_info_data = *remote_object_info;
 	retval = transport_fetch_object_info(gtransport);
 cleanup:
-	string_list_clear(&object_info_options, 0);
 	transport_disconnect(gtransport);
 	return retval;
 }
@@ -819,6 +816,21 @@ static void parse_cmd_mailmap(struct batch_options *opt UNUSED,
 		load_mailmap();
 }
 
+struct protocol_placeholder_entry {
+	const char *option;
+	const char *atom;
+};
+
+static const struct protocol_placeholder_entry remote_atom_map[] = {
+	{"size", "objectsize"},
+	{"type", "objecttype"},
+	/*
+	 * Add new protocol options here. Even if the server doesn't support
+	 * them the allow_list will drop them if the server doesn't advertise
+	 * them.
+	 */
+};
+
 static void parse_cmd_remote_object_info(struct batch_options *opt,
 					 const char *line, struct strbuf *output,
 					 struct expand_data *data)
@@ -828,6 +840,7 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 	char *line_to_split;
 	struct object_info *remote_object_info = NULL;
 	struct oid_array object_info_oids = OID_ARRAY_INIT;
+	struct string_list object_info_options = STRING_LIST_INIT_NODUP;
 	const char *saved_format = opt->format;
 
 	if (strlen(line) >= MAX_REMOTE_OBJ_INFO_LINE)
@@ -847,10 +860,22 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 		die(_("remote-object-info supports at most %d objects"),
 		    MAX_ALLOWED_OBJ_LIMIT);
 
+	if (data->info.sizep)
+		string_list_append(&object_info_options, "size");
+	if (data->info.typep)
+		string_list_append(&object_info_options, "type");
+
 	if (get_remote_info(count, argv, &remote_object_info,
-			    &object_info_oids))
+			    &object_info_oids, &object_info_options))
 		die(_("failed to get object info from the remote: %s"), argv[0]);
 
+	string_list_clear(&data->remote_allowed_atoms, 0);
+	string_list_append(&data->remote_allowed_atoms, "objectname");
+	for (size_t i = 0; i < ARRAY_SIZE(remote_atom_map); i++)
+		if (unsorted_string_list_has_string(&object_info_options, remote_atom_map[i].option))
+			string_list_append(&data->remote_allowed_atoms,
+					   remote_atom_map[i].atom);
+
 	data->skip_object_info = 1;
 	for (size_t i = 0; i < object_info_oids.nr; i++) {
 		data->oid = object_info_oids.oid[i];
@@ -861,25 +886,29 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 			continue;
 		}
 
+		/*
+		 * When reaching here, it means remote-object-info can retrieve
+		 * information from server without downloading them.
+		 */
 		if (remote_object_info[i].sizep) {
-			/*
-			 * When reaching here, it means remote-object-info can retrieve
-			 * information from server without downloading them.
-			 */
 			data->size = *remote_object_info[i].sizep;
-			opt->batch_mode = BATCH_MODE_INFO;
-			data->is_remote = 1;
-			batch_object_write(argv[i + 1], output, opt, data, NULL, 0);
-			data->is_remote = 0;
-		} else {
-			report_object_status(opt, oid_to_hex(&data->oid), &data->oid, "missing");
 		}
+
+		if (remote_object_info[i].typep) {
+			data->type = *remote_object_info[i].typep;
+		}
+
+		opt->batch_mode = BATCH_MODE_INFO;
+		data->is_remote = 1;
+		batch_object_write(argv[i + 1], output, opt, data, NULL, 0);
+		data->is_remote = 0;
 	}
 	data->skip_object_info = 0;
 	opt->format = saved_format;
 
 	for (size_t i = 0; i < object_info_oids.nr; i++)
 		free_object_info_contents(&remote_object_info[i]);
+	string_list_clear(&object_info_options, 0);
 	free(line_to_split);
 	free(argv);
 	free(remote_object_info);
@@ -1138,6 +1167,7 @@ static int batch_objects(struct batch_options *opt)
  cleanup:
 	strbuf_release(&input);
 	strbuf_release(&output);
+	string_list_clear(&data.remote_allowed_atoms, 0);
 	cfg->warn_on_object_refname_ambiguity = save_warning;
 	return retval;
 }
diff --git a/fetch-object-info.c b/fetch-object-info.c
index 30475a1e87..ba7e179c44 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -55,6 +55,24 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 	case protocol_v2:
 		if (!server_supports_v2("object-info"))
 			die(_("object-info capability is not enabled on the server"));
+		/*
+		 * When removing an element from the list it gets swapped by the
+		 * last element, iterate backwards to prevent elements skipping
+		 * evaluation.
+		 *
+		 * object_info_options->nr can be safely casted without overflow
+		 * because the number of options is a small known number (the
+		 * supported placeholders which currently are size and type).
+		 */
+		for (int i = (int)args->object_info_options->nr - 1; i >= 0; i--)
+			if (!server_supports_feature("object-info",
+						     args->object_info_options->items[i].string, 0))
+				unsorted_string_list_delete_item(args->object_info_options, i, 0);
+
+		/*
+		 * Even if no options are left, we still send the oid so we get
+		 * at least an existence check.
+		 */
 		send_object_info_request(fd_out, args);
 		break;
 	case protocol_v1:
@@ -71,7 +89,7 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 			return -1;
 		}
 
-		if (!string_list_has_string(args->object_info_options, reader->line))
+		if (!unsorted_string_list_has_string(args->object_info_options, reader->line))
 			return -1;
 
 		if (!strcmp(reader->line, "size")) {
diff --git a/fetch-object-info.h b/fetch-object-info.h
index 31aad98408..269cebb3f7 100644
--- a/fetch-object-info.h
+++ b/fetch-object-info.h
@@ -14,6 +14,9 @@ struct object_info;
 /*
  * Sends git-cat-file object-info command into the request buf and read the
  * results from packets.
+ *
+ * Modifies args->object_info_options, on return it contains only the supported
+ * options by the server.
  */
 int fetch_object_info(enum protocol_version version, struct object_info_args *args,
 		      struct packet_reader *reader, struct object_info *object_info_data,
diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-remote-object-info.sh
index edc20394d8..116862f9d0 100755
--- a/t/t1017-cat-file-remote-object-info.sh
+++ b/t/t1017-cat-file-remote-object-info.sh
@@ -271,6 +271,34 @@ test_expect_success 'unsupported placeholder on remote returns empty string' '
 	)
 '
 
+test_expect_success 'requesting only objectname echoes back' '
+	(
+		set_transport_variables "$daemon_parent" &&
+		cd "$daemon_parent/daemon_client_empty" &&
+
+		echo $hello_oid >expect &&
+		git cat-file --batch-command="%(objectname)" >actual <<-EOF &&
+		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'objectname goes through existence check' '
+	(
+		set_transport_variables "$daemon_parent" &&
+		cd "$daemon_parent/daemon_client_empty" &&
+
+		echo "$unstored_oid missing" >expect &&
+
+		git cat-file --batch-command="%(objectname)" >actual <<-EOF &&
+		remote-object-info "$GIT_DAEMON_URL/parent" $unstored_oid
+		EOF
+
+		test_cmp expect actual
+	)
+'
+
 # Test --batch-command remote-object-info with 'git://' and
 # transfer.advertiseobjectinfo set to false, i.e. server does not have object-info capability
 test_expect_success 'batch-command remote-object-info git:// fails when transfer.advertiseobjectinfo=false' '
diff --git a/transport.c b/transport.c
index 9342680531..f0a6a45547 100644
--- a/transport.c
+++ b/transport.c
@@ -443,7 +443,6 @@ static int fetch_object_info_via_pack(struct transport *transport)
 	args.server_options = transport->server_options;
 	args.oids = transport->smart_options->object_info_oids;
 	args.object_info_options = transport->smart_options->object_info_options;
-	string_list_sort(args.object_info_options);
 
 	connect_setup(transport, 0);
 	packet_reader_init(&reader, data->fd[0], NULL, 0,

-- 
2.54.0
