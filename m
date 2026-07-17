Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5730042DA48
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300749; cv=none; b=Yq8CS2HzPEcLaRGDm9rJeOEOipti4LLKB4Lj+mWm9zuMuyKlXZh18+W2acLyIpnqOijvHQcmxKLRaWw4c+FJO1+pA8ew1dbws68MktvIXzXwTDnYCR08AuEMbvJRRTn0s0oZsYeTFC7KNIvT4u5SFH/QCSXpNWLaLONmciYGyQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300749; c=relaxed/simple;
	bh=rFaNAkmg0ZHYRbJ0CI1MEfGgIJU04egqIOPAgxI39m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFN2rJgKezh40GN7COfPs3kn60/saNUfRuftxgrz8NgDgcsLr0J+2NbBT8rdBv3bq1vjl4mZ8jilCC+xiXg7RFZSM/OxF3IampBVwkvNYErMkirv/Zld/OCSXgM6p0YwqDPVGEqS2PQgDq8OBbjAd2z+AKQvzoYop4rMisq138k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAd7EyjQ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAd7EyjQ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47122683cf3so4628029f8f.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 08:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784300745; x=1784905545; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w1F6dROrbhGbMlEapSyP0AA1QZ1cp5yPiTHNN3Od3mc=;
        b=MAd7EyjQ5ldrAv4owmZCZvcNXIjIgAYk+jGiZEq3JLq4AtGfK1umGcJm+catcyvmGs
         ZIFat4YenKMVCNo6/C8VvbNAm4sH5Rnc7tVIb9RdfusDdbOYWaCo6Ck51tJXCpdDi3V1
         2UbUliMinaKVXO6RgVwAFeMQpUmwSu9g9NzQmhUqned5q46+IKUAoEa/1rDpIJG0Nk/v
         jS90KV5i09fdTOUocVcAYvokxPMf13HDpiKD1vD8W7nOZdCzTseXIFtIMfKsgEeCd3hU
         n7TKF/EIgzWT/JgTY+iirk+00haB6AJyuqtEJs+MtS6lFg4ifxoCVZJpUMEr0t+y2oK2
         ixEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784300745; x=1784905545;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w1F6dROrbhGbMlEapSyP0AA1QZ1cp5yPiTHNN3Od3mc=;
        b=oN4rQMz3y9QqYzQNTGIBsDZdydUf39yzLmALyM7DHaR1aoO9J3/2K/SBpbP0IEIunw
         fo4hE7gaH9T/5/W3qpNzrZHAYHZzhDdzcPUJ9hTjEFmheczqiaXHBWcihgdCDWmiZBR/
         TFucR8nUvkto85FPa50Gq9gSvqJTjsTPMui6wGlvdPaB41B8uEKVQHGDpkWx5raBI2so
         3qhlhQmkpZKIQ6Z6E8NTr0OJVdw+UFevRaOsHdxbT1RvppRkI6XA2I5eb/TwvZtCMiqF
         WdiBy+Ng6JkQDXLof/DP8PZiFF2yazRS55S18PQ81eJUwwzzy/J1D2J62GO31nnRJq2K
         WQ0g==
X-Gm-Message-State: AOJu0YxLrThWrqJRxmDV8u9YgVs62E+9Og89bx/bzxdywT4UgvraHCem
	BuvrJFOiPVUehEn6P3Mx75lZletGOHMZRLI73vbEsefr6S1G18mJWMHZf1Z6LyqR
X-Gm-Gg: AfdE7cmNTAghJyTWVWRh9r0DcvjuCWX751+khMJw8+WPh5AmryUI1aw1uoVhOxMAtEl
	bctpk+ofL+IhRo9EXbJWslMjTZpJe0bvG3joAJyX6JPMW8acwkV/rE8BYi4eJ2olu37cYIwCQ2A
	rx71T8BZVQaaYbHnfiTbLCX984AMw/tQZmm3XZgLAzzmhM/5VnBwhwqsHGCcM9fPW+kyb4YucQz
	eoVYJ53xmbaJw1SYnkunmYyTsvkeI7dKzel3aQXXadNuqkAnbwCXRaKilizXv/DeDKFs5Aq19/Q
	CDaXUK3kQNcKQ5WsoIMRpGoqyTklQ32f4qd0UZhgJgE0MoOgM8w15JvdpTakYAfaJb1lVh2mu/B
	22xn8oLJb3fkSxiVa5cNEESb2iutka0+E5SW4YAYjFfL3vhVOLOHSAqD5sU1Vgr8BGohFIHOAi1
	oj6BAyQdsZNC2wRyqfxwLAfS4WpXkDpsWg4NiN9MBv4Ea8R1gBYCCtJMGGay6CwK7srUOAOjVZD
	hNS4Y2A+ZIBVy0pv4izww1Gd1WPd9coUjL16vkDAXrKmgRCTmWmOEpH0tppJko4uoBeY9GcqO/+
	4wS1utfPiZznuMScgkDR1j+3RwhmUceV
X-Received: by 2002:a05:600c:1c20:b0:495:4b24:1b6a with SMTP id 5b1f17b1804b1-4954b241d78mr30238815e9.11.1784300744641;
        Fri, 17 Jul 2026 08:05:44 -0700 (PDT)
Received: from localhost.localdomain ([47.58.6.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2692a3sm50226025e9.0.2026.07.17.08.05.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Jul 2026 08:05:44 -0700 (PDT)
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
Subject: [PATCH GSoC v19 13/13] cat-file: make remote-object-info allow-list adapt to the server
Date: Fri, 17 Jul 2026 17:05:23 +0200
Message-ID: <20260717-ps-eric-work-rebase-v19-13-d4faee35764b@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
References: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
 <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
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
 builtin/cat-file.c                     | 86 +++++++++++++++++++++-------------
 fetch-object-info.c                    | 20 +++++++-
 fetch-object-info.h                    |  3 ++
 t/t1017-cat-file-remote-object-info.sh | 28 +++++++++++
 transport.c                            |  1 -
 5 files changed, 104 insertions(+), 34 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index f5e5528a21..7a0431bf2b 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -338,13 +338,11 @@ struct expand_data {
 	 * Flags about when an object info is being fetched from remote.
 	 */
 	unsigned is_remote:1;
-};
-#define EXPAND_DATA_INIT  { .mode = S_IFINVALID, .type = OBJ_BAD }
 
-static const char *remote_object_info_atoms[] = {
-	"objectname",
-	"objectsize",
+	struct string_list remote_allowed_atoms;
 };
+#define EXPAND_DATA_INIT  { .mode = S_IFINVALID, .type = OBJ_BAD, \
+			    .remote_allowed_atoms = STRING_LIST_INIT_NODUP }
 
 static int is_atom(const char *atom, const char *s, int slen)
 {
@@ -356,17 +354,11 @@ static int expand_atom(struct strbuf *sb, const char *atom, int len,
 		       struct expand_data *data)
 {
 	if (data->is_remote) {
-		size_t i, allowed_nr = ARRAY_SIZE(remote_object_info_atoms);
-		for (i = 0; i < allowed_nr; i++)
-			if (is_atom(remote_object_info_atoms[i], atom, len))
+		size_t i;
+		for (i = 0; i < data->remote_allowed_atoms.nr; i++)
+			if (is_atom(data->remote_allowed_atoms.items[i].string, atom, len))
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
 
@@ -682,12 +674,12 @@ static void batch_one_object(const char *obj_name,
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
@@ -727,13 +719,10 @@ static int get_remote_info(int argc,
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
@@ -819,6 +808,21 @@ static void parse_cmd_mailmap(struct batch_options *opt UNUSED,
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
@@ -828,6 +832,7 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 	char *line_to_split;
 	struct object_info *remote_object_info = NULL;
 	struct oid_array object_info_oids = OID_ARRAY_INIT;
+	struct string_list object_info_options = STRING_LIST_INIT_NODUP;
 	const char *saved_format = opt->format;
 
 	if (strlen(line) >= MAX_REMOTE_OBJ_INFO_LINE)
@@ -846,10 +851,22 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
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
@@ -860,25 +877,29 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
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
@@ -1198,6 +1219,7 @@ static int batch_objects(struct batch_options *opt)
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
