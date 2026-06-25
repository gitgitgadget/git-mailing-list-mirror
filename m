Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BAC3E0081
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389638; cv=none; b=sel7/+LiJiQEJ9Or9F6Beyt/ExjYGV1mHl9/5BsUdGDGpUsa1e261w9dz/KQLWmonzJFIB5j+BPoKU21bNR5xC6JPFN9FPn6GsO1uYrK4F4xkw7TQru8+o5N0xw+3seW3O3K9p/0/8DwEkXWJKboAwWRihWfBB/4vrBM12+KGKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389638; c=relaxed/simple;
	bh=rtKh9Kv0qAp4TpIgKM1yzPwe44m8bpZCTM6366vRKs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNadJh2lERnkIS/hgg72usZ+izSgvfnop/8U7+dwtWMcTXha/xuBBDfqiI08D3o6L1NbPumWAh+ywYaxxQhOALibrK5BWHRgEyeOd8wktETdS6eCOmyqgWC6/FM6Y0kLTCns5ogMk5hbvNg5V1CNFJ5x/tCl47J7rEsBKlDUuVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiB0uV+s; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiB0uV+s"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49261a64cf4so11019115e9.2
        for <git@vger.kernel.org>; Thu, 25 Jun 2026 05:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782389635; x=1782994435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQZ1ersJXrW1P5dq87aLpyRVGJWzs+DX9/TkXvCK8Fk=;
        b=iiB0uV+sUdKQH1+JiAzabM9EYcKjqmX0DGY7NUg3jVTHLpTK89Pl6NT5yA159XrFji
         ci22V4J87tgA7WRfue9S8+1hzWfMXxv/C3qxoIeSdvX+GZm3PMbGDZI7FR5bVDwolPTb
         kKapDlOi84d9y6dgZ5QlJ0/ET7Ocsa2OGTjrivG8wqjlNnc5GoIv+imphceW2Ia8ODDk
         RaqlSXJ58ArbHRtb5xkQJE0u2hVY+SieCKIUDA4QrrHPtj7I7cY0Us3MlYs1MsGfeBfk
         NzLEbUR3cZNWcgH89Y5z4QgI/iIsJHmp2mJyr368BCK1wdIHgdoTb427tvfnzBO7tI/H
         xUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389635; x=1782994435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LQZ1ersJXrW1P5dq87aLpyRVGJWzs+DX9/TkXvCK8Fk=;
        b=iALRfFBvRJxvoYgbQDvjIVxUmhzeDv1qTT8559YS+RG9m3BEARYsXnsKT/CaTl7o+w
         6ZN/cAIX2Mswfi9IzxQIk8MGa3Avrn1FZJuBzNS6YaCb/8x1suzFTnxurmH+ShiRtYVm
         HZ0NdIzlQQFPkn4QwgfL2PLzOnODsEvFO60GAEwhC90Yuq2YUTFcOl+97IOJiMX/tLqK
         ctnZuEXrv9cvdcUBKzCDjboziEvemOaYQppQxtO7QJ7kv4li3WTVG/EPDXc/rWw+7/Ec
         m5XHULVAfMIMpsRrzzBxQIcNCQ7zQtXz+JplOb6bu9/bwl3hPLQ4yQadvJjcYec3GWgK
         I26g==
X-Gm-Message-State: AOJu0Yw8QafwsGCQ3WQII+HxMMdk0bDIMY76BVG5PRoEpLkY4WNdhhcy
	sd5WxDHn6q0nTqyVoP1UVvwHmX7HvatPe1GXO7znisCgsNrDuK57+v6yDNfv8LK1
X-Gm-Gg: AfdE7cnLj4h8lBUMdVlaaEDQUWzqf5lHnSNple5p//PhgvCCYXN1OfX6oqLWuV9cwQZ
	oC/rRk0Ij4nd9bH2L2/4S9pg7On9XivtZNgftvJcbufvJOetCeAi8/4HnHYnitmX5O9XLR8zI4+
	eQh8X+RI337+YPqL8kLD3w3mhRMEmj3ZQc6elLwTee3rltfGc+OuOmXn86O+RPkmq4oG9fcx0/m
	eWssyi6nIz2RAen5u2anYsXCKNr0HRFBudhwLvVXb5cYON7QupnlQ+TnZ+/jJd/yozrRaICoGr9
	dN4TE28CGwY0sh0npB56gVjj4fz1PHMPo5D1R/GIsfF//tlzVQDzzxVxAF3cudAFxn/SbmIfXM2
	Rx9dUPxtkPsB8cV5EcQTnzzmHjeu1m9VOLgAzM6wAPdEN+pWZBGstED2/QkGLqo/JAc3Ac9yEal
	mnGXiQ1hpKaNy4s7reUTJYioDoJ48SIXd2hdqwepLLSe+juaNCa/oZbd2Wfb8o91/v04EDuHoQs
	MZgYcXioTsG4Oj6V/AW450dS9cNVBLmeZjzJnbbt79IOfXhRfOkEiAi1KzWmI8R+tDPl2bPcZr6
	UmUV5jIGaflkhkXhZRR7Pm5Rmm7oPSX2BSRvoWrTO0I/5zK7jkDfdNV9Rnzb9po0hIb/YFCnAqt
	ZuHpiQh74tFVrKDrIGmWV
X-Received: by 2002:a05:600c:8b4b:b0:490:ba0a:1178 with SMTP id 5b1f17b1804b1-4926688974amr28667355e9.28.1782389635092;
        Thu, 25 Jun 2026 05:13:55 -0700 (PDT)
Received: from localhost.localdomain (62.174.236.137.static.user.ono.com. [62.174.236.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492660adaecsm62207245e9.5.2026.06.25.05.13.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Jun 2026 05:13:54 -0700 (PDT)
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
Subject: [PATCH GSoC v14 13/13] cat-file: make remote-object-info allow-list dynamic
Date: Thu, 25 Jun 2026 14:13:35 +0200
Message-ID: <20260625-ps-eric-work-rebase-v14-13-09f7ffe21a53@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The static allow-list in expand_atom() is hardcoded to only allow
"objectname" and "objectsize" for remote queries. This works because
up to this point all servers will either support object-info with name
and size or they do not support them at all, but we cannot expect that
in a future different servers with different git versions to have the
same object-info capabilities. Therefore, the allow_list needs to be
dynamic depending on what the server advertises.

The client will now:

1. Request the protocol option that the placeholder refers to (i.e.
   "size" when "%(objectsize)").

2. Filters the request in fetch_object_info() dropping any option that
   the server does not advertise.

3. After the fetching, the options that haven't been dropped are the ones
   fetched and supported by the server, these supported options are
   mapped and remote_allowed_atoms is populated with the placeholders.

4. expand_atom() checks remote_allowed_atoms with the same behaviour as
   the static allow_list had.

Move object_info_options out of get_remote_info so the caller which has
data can select what options will be requested instead of requesting
always size.
Move batch_object_write() out so there will always be an output even if
all the placeholders are not supported by the server (returns an empty
line).

Include "type" in the object_info_options so once the server supports
it, the clients know already how to request it.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 builtin/cat-file.c  | 97 +++++++++++++++++++++++++++++++++++------------------
 fetch-object-info.c | 20 +++++++++++
 2 files changed, 84 insertions(+), 33 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index ea3869f3ed..86e4f78eb6 100644
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
 
@@ -680,12 +672,12 @@ static int get_remote_info(struct batch_options *opt,
 			   int argc,
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
 
 	/*
@@ -734,15 +726,12 @@ static int get_remote_info(struct batch_options *opt,
 	gtransport->smart_options->object_info = 1;
 	gtransport->smart_options->object_info_oids = object_info_oids;
 
-	string_list_append(&object_info_options, "size");
-
-	if (object_info_options.nr > 0) {
-		gtransport->smart_options->object_info_options = &object_info_options;
+	if (object_info_options->nr > 0) {
+		gtransport->smart_options->object_info_options = object_info_options;
 		gtransport->smart_options->object_info_data = *remote_object_info;
 		retval = transport_fetch_refs(gtransport, NULL);
 	}
 cleanup:
-	string_list_clear(&object_info_options, 0);
 	transport_disconnect(gtransport);
 	return retval;
 }
@@ -828,6 +817,21 @@ static void parse_cmd_mailmap(struct batch_options *opt UNUSED,
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
@@ -837,6 +841,7 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 	char *line_to_split;
 	struct object_info *remote_object_info = NULL;
 	struct oid_array object_info_oids = OID_ARRAY_INIT;
+	struct string_list object_info_options = STRING_LIST_INIT_NODUP;
 
 	if (strlen(line) >= MAX_REMOTE_OBJ_INFO_LINE)
 		die(_("remote-object-info command too long"));
@@ -849,32 +854,57 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 		die(_("remote-object-info supports at most %d objects"),
 		    MAX_ALLOWED_OBJ_LIMIT);
 
+	if (data->info.sizep)
+		string_list_append(&object_info_options, "size");
+	if (data->info.typep)
+		string_list_append(&object_info_options, "type");
+
 	if (get_remote_info(opt, count, argv, &remote_object_info,
-			    &object_info_oids))
+			    &object_info_oids, &object_info_options))
 		goto cleanup;
 
+	string_list_clear(&data->remote_allowed_atoms, 0);
+	string_list_append(&data->remote_allowed_atoms, "objectname");
+	for (size_t i = 0; i < ARRAY_SIZE(remote_atom_map); i++)
+		if (unsorted_string_list_has_string(&object_info_options, remote_atom_map[i].option))
+			string_list_append(&data->remote_allowed_atoms,
+					   remote_atom_map[i].atom);
+
 	data->skip_object_info = 1;
 	for (size_t i = 0; i < object_info_oids.nr; i++) {
+		int found = 0;
 		data->oid = object_info_oids.oid[i];
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
+			found = 1;
 		}
+
+		if (remote_object_info[i].typep) {
+			data->type = *remote_object_info[i].typep;
+			found = 1;
+		}
+
+		if (!found && object_info_options.nr > 0) {
+			report_object_status(opt, oid_to_hex(&data->oid),
+					     &data->oid, "missing");
+			continue;
+		}
+
+		opt->batch_mode = BATCH_MODE_INFO;
+		data->is_remote = 1;
+		batch_object_write(argv[i + 1], output, opt, data, NULL, 0);
+		data->is_remote = 0;
 	}
 	data->skip_object_info = 0;
 
 cleanup:
 	for (size_t i = 0; i < object_info_oids.nr; i++)
 		free_object_info_contents(&remote_object_info[i]);
+	string_list_clear(&object_info_options, 0);
 	free(line_to_split);
 	free(argv);
 	free(remote_object_info);
@@ -1190,6 +1220,7 @@ static int batch_objects(struct batch_options *opt)
  cleanup:
 	strbuf_release(&input);
 	strbuf_release(&output);
+	string_list_clear(&data.remote_allowed_atoms, 0);
 	cfg->warn_on_object_refname_ambiguity = save_warning;
 	return retval;
 }
diff --git a/fetch-object-info.c b/fetch-object-info.c
index 9c4ae9bd11..c6954bde5d 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -39,6 +39,26 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 	case protocol_v2:
 		if (!server_supports_v2("object-info"))
 			die(_("object-info capability is not enabled on the server"));
+		/*
+		 * When removing an element from the list it gets swapped by the
+		 * last element, iterate backwards to prevent elements skipping
+		 * evaluation.
+		 *
+		 * object_info_options->nr can be safely casted without overflow
+		 * beacuse the number of options is a small known number (the
+		 * supported placeholders which currently are size and type).
+		 */
+		for (int i = (int)args->object_info_options->nr - 1; i >= 0; i--)
+			if (!server_supports_feature("object-info",
+						     args->object_info_options->items[i].string, 0))
+				unsorted_string_list_delete_item(args->object_info_options, i, 0);
+		/*
+		 * If no options are left after the filtering, avoid unnecessary
+		 * request to the server.
+		 */
+		if (!args->object_info_options->nr)
+			return 0;
+
 		send_object_info_request(fd_out, args);
 		break;
 	case protocol_v1:

-- 
2.54.0
