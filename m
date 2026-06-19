Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2EC3B27EF
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881031; cv=none; b=jvbd5H44reL0m1cVQCJ1GkJSMk5P3BwB68I0Ap3o0vFgaoJ5g2tYsUR15MXvM9Kr5j2hJ0KNIOAIVDVc43ZIqR/h98usMCW2ycc2v4hu2QjG6y0rYQwjKp0aI8HuS2gJhB4Jb9b0SUFLZ9sFtlzM7rP3kYCdjUJZMWZHzapC968=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881031; c=relaxed/simple;
	bh=esFMyGYKsX8FBiZ/3j8UjpMh9oqfJ52XK0OzaWvzeFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQQcIypuQnZ6C41O4WtwmNLF8gcZBz50GqcIOTljQs4G7A4gpAx978Fai+xKkQRo207MFNYpTBzIYu7fBfe688HvxdmLtSYT1QgnIp5aa0qzSiskGqooamabmNZFOe4+yJ/ODDiLF6lZb6+VSJrJbUA6WwxRT/lg9LsgSu18AiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjwChUkg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjwChUkg"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso14914185e9.3
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781881028; x=1782485828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfJa93JTVQCh1Q2m9LpFh9AjxY38mw79ryoEN6Y2Vuc=;
        b=AjwChUkg9bCNwLivtVcc46yZ6yYaZCAkumwJmhs307s7Dl79Dvp2nfFI09c/Ci5AiR
         zUoLVJNvsw4WvB0j9okzBBXALIvq0GrtfN2FI8oeuBaPr1C87vrOg80ZLwdzmVi83kt0
         d87y7yi6TzlDyd3Xa4Dr1sfDZKqVo0QuQ9SLbTbfDbWJZr1i7wChnF7kiuV2tmvQVbI+
         8ngrKQJalFRMhgIOoBtIyNerMhoOyIrZ0xw2a+D9VeWFhaQUKix1mMHRqNFCOKOZ0Jbz
         XuPDQwwzfnL4wzcb0mKyKwflbA8BxxYTCfn8xkdF3svE5tKOp8GnZFBeIN+nCCeAdYkB
         Mj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781881028; x=1782485828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PfJa93JTVQCh1Q2m9LpFh9AjxY38mw79ryoEN6Y2Vuc=;
        b=VsqAhWeDd4Bg21HNhdhO1Pa9NePeuTVcCUiy+YB89KV+W0+HgsMYwlaR7unEqPp250
         ZizU0rJaqbMkVe9MbqZBKQsQODPC/zS21yHoG01Wf4aPuyU0V8G5Vygbvkr2PV2iSSJs
         mvk0V5mpsi/2AogE6Wkc0Hg5KHkVLIkBrIqtAkHBRnnJfUuImDYqsp/r3t+E/JgrtpFh
         ozRaH4ZzT6I/O8WK4Uu484vZYGsh/nuYhqkcjF9EjoVCcUZrTfS2i8KkkwB8tdjPMVAP
         +U5BIylqYFuu6bOu0mWWs+udP98q1BwXT2I4K9fZlrfBT8RojFreyho3JX0Iq0BbZQuA
         wE+w==
X-Forwarded-Encrypted: i=1; AFNElJ/UvM6zSDbTWiDRLXSvEx3D1eZC9z2sxdvONRqhBC4vUL6B6dYi4g1UsOQaRPv2nyUzF2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwimorJnT4yu7Grm/ajTZs3O1l/oLL6TL610bQWwBz5XSuVLATd
	Bc+KCWYG4BjScQjXT6KUm2OzQpQfs0mUZ6f62P5PdMSu8kD+EdPtG7FB
X-Gm-Gg: AfdE7ckX+9qJqFjjlWFMaqYXmXO7wO6wDeQ8ui+oOyn0PuKcmAsinSNrEaPEpy5DTu1
	0drsz9vvGIf/w7zZz4+a9l7r2KtYW1kHHzcp9ehIvK7019s+P5DeChjDtLOGvgGzQ7xL7nCs7rW
	uMKI7k3xv8a/h+jwwo/2PUPTmMidQgtnJg/nDCVXjrzmgyfQZqEhNFerWdXaWcKLkuTw2SZtOJ6
	TEZRo9dMWIpPzZ8b15Rvs/xDIVAVU1K7e1bPfnjp4wOEHv6AsbvfPxD1f7avQRN9jzaXbU/VNG0
	YoK7ebK+sQhplTvS62oC8w1TP3TgExi3tWYFTblIVP8SGcVeZMIGvY+PIkHvuncp4bQsRxP1L+U
	eARyLzMXtboKpcHxhu/9ldeumgHd0RNlU8RC/XrvarLEeaenJyz80kmRzhWvGNGP+/ElBYaAxi6
	pQ2/A5NolyNxtD68NIQEd6nyiw3R0j4u66jv11fsp+ZX0uHkr0h3hrmxixLquu5wHkaUeFd2KrI
	04eGlGQaPFlQqgAAXLM1JQjFL4rhtxdwp9Vp4FGOWijKMTdM2sufxXEisVyxy+c3Ff2o8mQkZGq
	lQenoDlb0Eq/c37aW209pOxk5H1XwgmezYIMg6/v0z0CMSwg9j8hVrCDTuJfdGmE5x+Vxm0mAce
	e1bvQJXeozpqaQw==
X-Received: by 2002:a05:600d:6451:20b0:492:25a0:1730 with SMTP id 5b1f17b1804b1-49240ea820bmr50783845e9.32.1781881027926;
        Fri, 19 Jun 2026 07:57:07 -0700 (PDT)
Received: from localhost.localdomain (static-204-100-6-89.ipcom.comunitel.net. [89.6.100.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc63fsm39430795e9.1.2026.06.19.07.57.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Jun 2026 07:57:07 -0700 (PDT)
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
Subject: [PATCH GSoC RFC v13 12/12] cat-file: make remote-object-info allow-list dynamic
Date: Fri, 19 Jun 2026 16:56:41 +0200
Message-ID: <20260619-ps-eric-work-rebase-v13-12-3d4c7315d2f8@gmail.com>
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

The static allow-list in expand_atom() is hardcoded to only allow
"objectname" and "objectsize" for remote queries. This works because
up to this point all servers will either support object-info with name
and size or they do not support them at all, but we cannot expect that
in a future different servers with different git versions to have the
same object-info capabilities. Therefore, the allow_list needs to be
dynamic depending on what does the server advertise.

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
 fetch-object-info.c | 16 +++++++++
 2 files changed, 80 insertions(+), 33 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 7ad6165032..4c7b2781da 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -341,13 +341,11 @@ struct expand_data {
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
@@ -359,17 +357,11 @@ static int expand_atom(struct strbuf *sb, const char *atom, int len,
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
 
@@ -685,12 +677,12 @@ static int get_remote_info(struct batch_options *opt,
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
 	static struct transport *gtransport;
 
 	/*
@@ -739,15 +731,12 @@ static int get_remote_info(struct batch_options *opt,
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
@@ -833,6 +822,21 @@ static void parse_cmd_mailmap(struct batch_options *opt UNUSED,
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
@@ -842,6 +846,7 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 	char *line_to_split;
 	static struct object_info *remote_object_info;
 	static struct oid_array object_info_oids = OID_ARRAY_INIT;
+	struct string_list object_info_options = STRING_LIST_INIT_NODUP;
 
 	if (strlen(line) >= MAX_REMOTE_OBJ_INFO_LINE)
 		die(_("remote-object-info command too long"));
@@ -854,32 +859,57 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
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
@@ -1194,6 +1224,7 @@ static int batch_objects(struct batch_options *opt)
  cleanup:
 	strbuf_release(&input);
 	strbuf_release(&output);
+	string_list_clear(&data.remote_allowed_atoms, 0);
 	cfg->warn_on_object_refname_ambiguity = save_warning;
 	return retval;
 }
diff --git a/fetch-object-info.c b/fetch-object-info.c
index ae035c9598..de927ecd48 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -39,6 +39,22 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 	case protocol_v2:
 		if (!server_supports_v2("object-info"))
 			die(_("object-info capability is not enabled on the server"));
+		/*
+		 * When removing an element from the list it gets swapped by the
+		 * last element, iterate backwards to prevent elements skipping
+		 * evaluation.
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
