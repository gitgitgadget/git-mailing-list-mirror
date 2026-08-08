Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA94126C02
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 00:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786147353; cv=none; b=GTPB/kTEN5RDUSSSpTXX859SpOlCUb4QX4jJODwpWSbvxxuz3qy5oHtdybjfr9Lc3bV+d1gHb98PsIDNVZzUBVteUNRRSmP347AIKDytSDDA82lPHBq0eh6j3XPSSPjkt58OI+1+2S99iV09JT6qpBMFhrb26TKKxTMvRXy52bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786147353; c=relaxed/simple;
	bh=H11R9dOIiKqwqOnqahfTNHLlHjfVxdqao519gU1UYJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DZo6AIn51NNPZZHRRTdGjrQJlCYqD8/72j8A/PAmZAKnoGxOnTILiAoEdYA76OwH4GLqwDYLdG4h8QQpu9z1zUJXnzTGE1txcG2dxIAXhh62tKPoZTYBdGEEjjtZLhRA/385BmcUDY0DAoEZTuIUtS3luL84AmpSdZ5nsQe/9F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggm6sj4b; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggm6sj4b"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4954aff6088so866445e9.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 17:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786147350; x=1786752150; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2vuppnk/+NdRn//P8EAC9sHE/WuzkzlP3wBP6246698=;
        b=ggm6sj4butyr/PoR8Zvr7jgqlC4PvFpEUwQo5wVEuLolc8vg3XtMfsiH1oYleE5yM1
         bj6J3sHJDRrsVpUukK4xa87KOhMdUh1M6RK+aQV8AiB16sS7yYZQKQ6QOr5qCi3W6LdM
         k3QaB11k/KAa0a/oxVRBHgJb4kJd1CAounGNtIGszqx2QF9D1PkEcTeWlVfy1UEb4Vmc
         gnAdESU+BlGQwV4dHaY+nuJB61f4EUyxy1A1SQ46PWvn2DVxFvhE2YOdFtjqw+kQarj7
         3YWWSHcbsiPLMo3Ad6KGrRuCuSV8QKZEAI5hi82AUAPUJU3azMHRTN9D0iqHzw0VzOvJ
         V9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786147350; x=1786752150;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2vuppnk/+NdRn//P8EAC9sHE/WuzkzlP3wBP6246698=;
        b=LTzJgSo+tOvFtG56POi2bkM3QYFUDTHJrlK6fo+d92mHT1eyHYK7He/nMPEAN6C9wj
         tzHMTQtNTN7r0kfV8rdJ50GZ3Nu3Y2UAMYRdj9z69T19n27CG1tCfAsLykfU9BK0wtiI
         0by6OIcowi/KhwMtrfoHczLxXo44U42dWbpcaZ9h2gb6minWWGYdo6OP3aLS7eUDpH4S
         vOGaxN23+4nfhxjAaYWO6kMPqDAV7otMepJnzwMhhhw5R5ZZAPHRvrL+IqnXKrGNrbKB
         nlSny7hwiYhxRekBOSVbV5zC3t5hhRntx9wIA7ifU/z4By7bCc35AJ3H8RLJoOkCn+gA
         jw6A==
X-Gm-Message-State: AOJu0Yx7a9vwJX8zRWM+qWzsXORE+Jo9fK5A9kR28jGng7Hapzlc8GJC
	OfW69W0EvSBYrzcVxS/rd1iPdgr/wU0UI+njwz4XuhqQLNUhSg9lDlS0
X-Gm-Gg: AR+sD1160eiOq5AQuXFDsX8Y+rMS8IUVTOC93t7Ie0xoTWoZXCmJomC71Ov2GITj2NJ
	kT7iXSOH4fJwkQVQ9Zi2Y62uw5JSypq8rfDfJVunmop04YJ5hQ4yLbEo/s4s+flmWWMRMC1AAbt
	OWYBfXxuEKVJ66KoZYGag6RPwdfInjWmzQ31oxXWuW48faNMbJDrJjP5Gwx5SGv5vMxqa4V8X3p
	atxP1+5l2GrEzndHRGJj5uWBr3yzHPmLzFcH6niEmD0IJ+OSNpIPnjAc7fHKOsTpDi5LgW1hLS0
	yhx1dcBSHB8hUJktRnBCGP8iwaRppFNOuIbPbJCU0Wpg9f9cUb4Rz90xR4CpYeBaRCtndql6VGf
	QnyipkgYbICQyj1DdQufrwJC2jB3w29nkHS+160kzBqDPpquYa8J8zsemiGZUq+yqgnsztsbJW2
	EaLOxYdSLoT4VvQbZNtE+BCc8C3hV5P/BdzlPov8cltgLam0oYszXD0v3lHAK3WIwS9ycgDf8Nb
	NWLV1kRllbA7950IwHohTG8zM/YnVVdvnR+GaLpD5qxLn21Hol7l3ST8Z2e4yNvM6jIwQ3yiyGM
	4RnMRXGVmpyi5lORgR1sDZIUaq7zVwyMCG2FnlRFKO/08QjgiI0rSbczR4iGul9iShFefTJH+WK
	IwQrI/gS14OUqJY5Zw4i7CApR/+AmHXr9jaO2QMHfd6Jh3zJaZ+UhvQcjBzbpfdChYORYNg==
X-Received: by 2002:a05:600c:8b17:b0:498:14d3:562f with SMTP id 5b1f17b1804b1-4994e7cb3efmr313094265e9.15.1786147349593;
        Fri, 07 Aug 2026 17:02:29 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa (183.red-79-149-223.dynamicip.rima-tde.net. [79.149.223.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c69c8ffsm72424525e9.2.2026.08.07.17.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:02:29 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 08 Aug 2026 02:02:19 +0200
Subject: [PATCH GSoC v6 04/10] fetch-object-info: use dedicated struct for
 the results
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-objecttype-support-v6-4-e5cdaf27a49c@gmail.com>
References: <20260808-objecttype-support-v6-0-e5cdaf27a49c@gmail.com>
In-Reply-To: <20260808-objecttype-support-v6-0-e5cdaf27a49c@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

fetch_object_info() collects information about N objects, but it stores
the results in an array of object_info. That struct holds the extended
parameters of read_object_info() (The optional outputs the caller wants
filled). Its pointers tell that function where to write the answers for
a single object. object_info is not meant to be the final storage, and
since fetch_object_info() does not call read_object_info(), there is no
reason to use it. Using it means allocating one scalar per object per
attribute just to have those pointers somewhere to point at.

Add struct fetch_object_info_results. The caller sets the wants_* flags
to say what it is interested in, and fetch_object_info() allocates one
array per attribute. A set wants_* flag means "asked for", while a
non-NULL array means "available". The caller releases the arrays with
free_fetch_object_info_results().

The object_info_options string list is no longer needed. Filtering
against the server's advertisement now sets local ask_* flags, and
send_object_info_request() turns those into the v2 protocol option
strings. remote_atom_map[] existed only to map those strings back into
atom names, so drop it and build remote_allowed_atoms from the result
arrays.

Currently for wants_* and ask_* there is only the 'size' variant but a
subsequent commit will add '*_type'.

free_object_info_contents() loses its only caller and is dropped.

Dropping the allow-list check makes the final else reachable from the
wire, so die() instead of BUG(): an unknown attribute is the server's
error, not ours.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 builtin/cat-file.c  | 59 +++++++++-----------------------------
 fetch-object-info.c | 81 ++++++++++++++++++++++++++---------------------------
 fetch-object-info.h | 27 +++++++++++++-----
 object-file.c       | 10 -------
 odb.h               |  3 --
 transport.c         |  3 +-
 transport.h         |  5 ++--
 7 files changed, 77 insertions(+), 111 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 884b6d5ad3..e1650b2921 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -31,6 +31,7 @@
 #include "alias.h"
 #include "remote.h"
 #include "transport.h"
+#include "fetch-object-info.h"
 
 /*
  * Maximum length for a remote URL. While no universal standard exists,
@@ -681,9 +682,8 @@ static void batch_one_object(const char *obj_name,
 
 static int get_remote_info(int argc,
 			   const char **argv,
-			   struct object_info **remote_object_info,
-			   struct oid_array *object_info_oids,
-			   struct string_list *object_info_options)
+			   struct fetch_object_info_results *results,
+			   struct oid_array *object_info_oids)
 {
 	int retval = 0;
 	struct remote *remote = NULL;
@@ -724,11 +724,9 @@ static int get_remote_info(int argc,
 		goto cleanup;
 	}
 
-	CALLOC_ARRAY(*remote_object_info, object_info_oids->nr);
 	gtransport->smart_options->object_info_oids = object_info_oids;
 
-	gtransport->smart_options->object_info_options = object_info_options;
-	gtransport->smart_options->object_info_data = *remote_object_info;
+	gtransport->smart_options->object_info_results = results;
 	retval = transport_fetch_object_info(gtransport);
 cleanup:
 	transport_disconnect(gtransport);
@@ -816,21 +814,6 @@ static void parse_cmd_mailmap(struct batch_options *opt UNUSED,
 		load_mailmap();
 }
 
-struct protocol_placeholder_entry {
-	const char *option;
-	const char *atom;
-};
-
-static const struct protocol_placeholder_entry remote_atom_map[] = {
-	{"size", "objectsize"},
-	{"type", "objecttype"},
-	/*
-	 * Add new protocol options here. Even if the server doesn't support
-	 * them the allow_list will drop them if the server doesn't advertise
-	 * them.
-	 */
-};
-
 static void parse_cmd_remote_object_info(struct batch_options *opt,
 					 const char *line, struct strbuf *output,
 					 struct expand_data *data)
@@ -838,9 +821,8 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 	int count;
 	const char **argv;
 	char *line_to_split;
-	struct object_info *remote_object_info = NULL;
+	struct fetch_object_info_results results = FETCH_OBJECT_INFO_RESULTS_INIT;
 	struct oid_array object_info_oids = OID_ARRAY_INIT;
-	struct string_list object_info_options = STRING_LIST_INIT_NODUP;
 	const char *saved_format = opt->format;
 
 	if (strlen(line) >= MAX_REMOTE_OBJ_INFO_LINE)
@@ -861,26 +843,21 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 		    MAX_ALLOWED_OBJ_LIMIT);
 
 	if (data->info.sizep)
-		string_list_append(&object_info_options, "size");
-	if (data->info.typep)
-		string_list_append(&object_info_options, "type");
+		results.wants_size = 1;
 
-	if (get_remote_info(count, argv, &remote_object_info,
-			    &object_info_oids, &object_info_options))
+	if (get_remote_info(count, argv, &results, &object_info_oids))
 		die(_("failed to get object info from the remote: %s"), argv[0]);
 
 	string_list_clear(&data->remote_allowed_atoms, 0);
 	string_list_append(&data->remote_allowed_atoms, "objectname");
-	for (size_t i = 0; i < ARRAY_SIZE(remote_atom_map); i++)
-		if (unsorted_string_list_has_string(&object_info_options, remote_atom_map[i].option))
-			string_list_append(&data->remote_allowed_atoms,
-					   remote_atom_map[i].atom);
+	if (results.sizes)
+		string_list_append(&data->remote_allowed_atoms, "objectsize");
 
 	data->skip_object_info = 1;
-	for (size_t i = 0; i < object_info_oids.nr; i++) {
+	for (size_t i = 0; i < results.nr; i++) {
 		data->oid = object_info_oids.oid[i];
 
-		if (remote_object_info[i].unrecognized) {
+		if (results.unrecognized[i]) {
 			report_object_status(opt, oid_to_hex(&data->oid),
 					     &data->oid, "missing");
 			continue;
@@ -890,13 +867,8 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 		 * When reaching here, it means remote-object-info can retrieve
 		 * information from server without downloading them.
 		 */
-		if (remote_object_info[i].sizep) {
-			data->size = *remote_object_info[i].sizep;
-		}
-
-		if (remote_object_info[i].typep) {
-			data->type = *remote_object_info[i].typep;
-		}
+		if (results.sizes)
+			data->size = results.sizes[i];
 
 		opt->batch_mode = BATCH_MODE_INFO;
 		data->is_remote = 1;
@@ -906,12 +878,9 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 	data->skip_object_info = 0;
 	opt->format = saved_format;
 
-	for (size_t i = 0; i < object_info_oids.nr; i++)
-		free_object_info_contents(&remote_object_info[i]);
-	string_list_clear(&object_info_options, 0);
+	free_fetch_object_info_results(&results);
 	free(line_to_split);
 	free(argv);
-	free(remote_object_info);
 	oid_array_clear(&object_info_oids);
 }
 
diff --git a/fetch-object-info.c b/fetch-object-info.c
index 53eec88cf0..5f53dbd6b9 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -12,16 +12,14 @@
 static void send_object_info_request(const int fd_out,
 				     const struct string_list *server_options,
 				     struct oid_array *oids,
-				     struct string_list *object_info_options)
+				     unsigned ask_size)
 {
 	struct strbuf req_buf = STRBUF_INIT;
 
 	write_command_and_capabilities(&req_buf, "object-info", server_options);
 
-	if (unsorted_string_list_has_string(object_info_options, "size"))
+	if (ask_size)
 		packet_buf_write(&req_buf, "size");
-	else if (object_info_options->nr)
-		BUG("only size should be in object_info_options");
 
 	if (oids)
 		for (size_t i = 0; i < oids->nr; i++)
@@ -52,37 +50,32 @@ static int parse_object_size(const char *s, size_t *res)
 int fetch_object_info(const enum protocol_version version,
 		      const struct string_list *server_options,
 		      struct oid_array *oids,
-		      struct string_list *object_info_options,
 		      struct packet_reader *reader,
-		      struct object_info *object_info_data,
-		      const int stateless_rpc, const int fd_out)
+		      struct fetch_object_info_results *results,
+		      const int stateless_rpc,
+		      const int fd_out)
 {
+	unsigned ask_size = 0;
 	int size_index = -1;
+	size_t wanted;
+
+	results->nr = oids->nr;
+	CALLOC_ARRAY(results->unrecognized, results->nr);
 
 	switch (version) {
 	case protocol_v2:
 		if (!server_supports_v2("object-info"))
 			die(_("object-info capability is not enabled on the server"));
-		/*
-		 * When removing an element from the list it gets swapped by the
-		 * last element, iterate backwards to prevent elements skipping
-		 * evaluation.
-		 *
-		 * object_info_options->nr can be safely casted without overflow
-		 * because the number of options is a small known number (the
-		 * supported placeholders which currently are size and type).
-		 */
-		for (int i = (int)object_info_options->nr - 1; i >= 0; i--)
-			if (!server_supports_feature("object-info",
-						     object_info_options->items[i].string, 0))
-				unsorted_string_list_delete_item(object_info_options, i, 0);
+
+		if (results->wants_size &&
+		    server_supports_feature("object-info", "size", 0))
+			ask_size = 1;
 
 		/*
 		 * Even if no options are left, we still send the oid so we get
 		 * at least an existence check.
 		 */
-		send_object_info_request(fd_out, server_options, oids,
-					 object_info_options);
+		send_object_info_request(fd_out, server_options, oids, ask_size);
 		break;
 	case protocol_v1:
 	case protocol_v0:
@@ -90,28 +83,25 @@ int fetch_object_info(const enum protocol_version version,
 	case protocol_unknown_version:
 		BUG("unknown protocol version");
 	}
+	wanted = ask_size;
 
-	for (size_t i = 0; i < object_info_options->nr; i++) {
+	for (size_t i = 0; i < wanted; i++) {
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
 			check_stateless_delimiter(stateless_rpc, reader,
 						  "stateless delimiter expected");
 			return -1;
 		}
 
-		if (!unsorted_string_list_has_string(object_info_options, reader->line))
-			return -1;
-
 		if (!strcmp(reader->line, "size")) {
-			/*
-			 * i is the number of supported options which currently
-			 * is only size. No risk of overflow.
-			 */
+			if (!ask_size)
+				die(_("object-info: unrequested 'size' attribute"));
+			if (results->sizes)
+				die(_("object-info: duplicate 'size' attribute"));
 			size_index = (int)i;
-			for (size_t j = 0; j < oids->nr; j++)
-				object_info_data[j].sizep =
-					xcalloc(1, sizeof(*object_info_data[j].sizep));
+			CALLOC_ARRAY(results->sizes, results->nr);
 		} else {
-			BUG("only size is supported");
+			die(_("object-info: unknown attribute '%s'"),
+			    reader->line);
 		}
 	}
 
@@ -137,24 +127,24 @@ int fetch_object_info(const enum protocol_version version,
 		 */
 		if (object_info_values.nr >= 2 &&
 		    !strcmp(object_info_values.items[1].string, "")) {
-			object_info_data[i].unrecognized = 1;
+			results->unrecognized[i] = 1;
 			string_list_clear(&object_info_values, 0);
 			continue;
 		}
 
 		/*
-		 * Because we filter the options to be only the supported by
-		 * the server we expect the server to answer with the same
-		 * number of attributes requested.
+		 * Because we only ask for attributes the server said it
+		 * supports, we expect the answer to have one value per
+		 * requested attribute, plus the OID.
 		 */
-		if (object_info_options->nr + 1 != object_info_values.nr)
+		if (wanted + 1 != object_info_values.nr)
 			die("object-info: unexpected number of attributes: %s",
 			    reader->line);
 
-		if (size_index >= 0 &&
+		if (results->sizes &&
 		    parse_object_size(object_info_values.items[size_index + 1].string,
-				      object_info_data[i].sizep))
-			die("object-info: ref %s has invalid size %s",
+				      &results->sizes[i]))
+			die("object-info: object %s has invalid size %s",
 			    object_info_values.items[0].string,
 			    object_info_values.items[size_index + 1].string);
 
@@ -169,3 +159,10 @@ int fetch_object_info(const enum protocol_version version,
 
 	return 0;
 }
+
+void free_fetch_object_info_results(struct fetch_object_info_results *results)
+{
+	free(results->sizes);
+	free(results->unrecognized);
+	memset(results, 0, sizeof(*results));
+}
diff --git a/fetch-object-info.h b/fetch-object-info.h
index 316bf917ce..9f72e91155 100644
--- a/fetch-object-info.h
+++ b/fetch-object-info.h
@@ -4,21 +4,34 @@
 #include "pkt-line.h"
 #include "protocol.h"
 
-struct object_info;
+struct fetch_object_info_results {
+	size_t *sizes;
+	uint8_t *unrecognized;
+	size_t nr;
+	unsigned wants_size:1;
+};
+
+#define FETCH_OBJECT_INFO_RESULTS_INIT { 0 }
+
 struct oid_array;
 /*
- * Sends git-cat-file object-info command into the request buf and read the
+ * Sends git-cat-file object-info command into the request buf and reads the
  * results from packets.
  *
- * Modifies object_info_options, on return it contains only the supported
- * options by the server.
+ * The caller sets the wants_* flags in "results" to indicate which attributes
+ * it is interested in. On return, "results" holds one array per attribute that
+ * the server both advertised and answered with. An array left NULL means the
+ * attribute is not available.
+ * Release them with free_fetch_object_info_results().
  */
 int fetch_object_info(enum protocol_version version,
 		      const struct string_list *server_options,
 		      struct oid_array *oids,
-		      struct string_list *object_info_options,
 		      struct packet_reader *reader,
-		      struct object_info *object_info_data,
-		      int stateless_rpc, int fd_out);
+		      struct fetch_object_info_results *results,
+		      int stateless_rpc,
+		      int fd_out);
+
+void free_fetch_object_info_results(struct fetch_object_info_results *results);
 
 #endif /* FETCH_OBJECT_INFO_H */
diff --git a/object-file.c b/object-file.c
index ec35c318bc..66f6c81373 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1340,13 +1340,3 @@ int odb_transaction_files_begin(struct odb_source *source,
 
 	return 0;
 }
-
-void free_object_info_contents(struct object_info *object_info)
-{
-	if (!object_info)
-		return;
-	free(object_info->typep);
-	free(object_info->sizep);
-	free(object_info->disk_sizep);
-	free(object_info->delta_base_oid);
-}
diff --git a/odb.h b/odb.h
index cbc2f9ced4..f4e6c26a0e 100644
--- a/odb.h
+++ b/odb.h
@@ -637,7 +637,4 @@ void parse_alternates(const char *string,
 		      const char *relative_base,
 		      struct strvec *out);
 
-/* Free pointers inside of object_info, but not object_info itself */
-void free_object_info_contents(struct object_info *object_info);
-
 #endif /* ODB_H */
diff --git a/transport.c b/transport.c
index 2bb5eedc32..b0e29124d1 100644
--- a/transport.c
+++ b/transport.c
@@ -451,9 +451,8 @@ static int fetch_object_info_via_pack(struct transport *transport)
 	ret = fetch_object_info(data->version,
 				transport->server_options,
 				transport->smart_options->object_info_oids,
-				transport->smart_options->object_info_options,
 				&reader,
-				data->options.object_info_data,
+				data->options.object_info_results,
 				transport->stateless_rpc, data->fd[1]);
 
 	close(data->fd[0]);
diff --git a/transport.h b/transport.h
index a7869d18e0..6948b65db9 100644
--- a/transport.h
+++ b/transport.h
@@ -7,6 +7,8 @@
 #include "string-list.h"
 #include "connect.h"
 
+struct fetch_object_info_results;
+
 struct git_transport_options {
 	unsigned thin : 1;
 	unsigned keep : 1;
@@ -57,8 +59,7 @@ struct git_transport_options {
 	struct oidset *acked_commits;
 
 	struct oid_array *object_info_oids;
-	struct object_info *object_info_data;
-	struct string_list *object_info_options;
+	struct fetch_object_info_results *object_info_results;
 };
 
 enum transport_family {

-- 
2.54.0

