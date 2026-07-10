Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6276343B48F
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701700; cv=none; b=ttMJslVuh+ugdA0wdlUPRGLPvw979PaE1XzuSMb+/WYFyAnAUsFD7j9ve0ZFcJ6cyimfRS23J43uyuTu4KVymD5dIfJJrIdnSy3LEEm9FmUQQrTOhbdTVzaSFnJcGqPEQC3YsXGRqgLwDk5k4z4dG4m2RC/lh/CvFC/0LCjx6oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701700; c=relaxed/simple;
	bh=Efgcnlb6TVwCERuImF+vFw2z/Qcb1D1x5yA2xITFFw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKFQMnGkONXZ96J5bCUyE0j9y0IO2zhJB8DTNWrAQyULJvG/lDUOsW+e5A1UsBmdd4R5aYp+wObcjMpHdUwRuAhFWsQEiE1m9jo1/2loguiluaXZ7PrT9uOurQV/E+dFmvu8lh3Nuk9Z14eIG3zA6T7AZIjITm6RdwP7NPLPzQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZIZN7my; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZIZN7my"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso660095f8f.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783701696; x=1784306496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eK7b46A+xtIzWtUp9akRGXQtrLmsil6xgtRWcwa9WXo=;
        b=dZIZN7myIDKACTO9Tg0rmzfC0VFRGao/u6OFK63SU0xcFECGgO3R4a2bXMXCQXIuz5
         mTB05QDshiWbqxUgahkK6jhl9lYhR6q1jKyV4ucu//92FcA+Sv5T72yIkott6O/vmOss
         OkpZXvjX9d5qRNAftg/XAeNb+n04U/WnNbsxgPnpR+5zMbhgP1IH/vaoZKO6QfCg46Hc
         u0a6ZHIgUSnScC/JXNC68gjp8VkgWqDF9Mbi4ec6vyMq3rCkYZZ6kdNL/F/WxXpuIjum
         D+n/HMpJgbTRhhiy+D83Ds6vXNTipCJxvwmkBtXRlxtDQobDJjSsFZQdX+kLz9R1TAGo
         r+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701696; x=1784306496;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eK7b46A+xtIzWtUp9akRGXQtrLmsil6xgtRWcwa9WXo=;
        b=U2Chp4tS9Ih2l/3QA+Ntjoa/oZ11PJg8vZUxLTDk6tmoopVg+j/akiD1Uh3UhV/OJA
         5NU+oRjqNQWiQ3CurrqlfygP+6m16t0OjPbDGJMlTvs2aFB5ZQj6808dahvtg5sacD7s
         qymnfhhZFx685dRegI2m03BhsYnPeYKsypfs+2diOIVYYFlAGUX/sCJGDwrN0qJlceh0
         SckqyCXvl8ucCDyAjG/wAL+ywTL2XbfBQFMiMona7Msph+jiD5hmlekZ4ePOymKfNKl7
         Haa74r+yQz0Ltuog3FrDEbyoJJ7sHA6s85se59GFf6OPJmjIeKAnpAxeiW0Fi0bJp1gq
         CYFg==
X-Gm-Message-State: AOJu0YwRFchxiHr8kj6F0fZEwWMUz+iRawj0bE4rjnpgDTyISppjYFMO
	pi7Ny4QBdwOOVQbvyrL1GuSXoX0C0/DEFGQtu8lsgywBL35po3J2cki50hRK2UIY
X-Gm-Gg: AfdE7ckmDETHRNYDgqzWZVjcC3qhuo1k3MO7wkLHDn9pofzdkIJsf7h+seK9roWC2Az
	XQloI3M9SeByI+fS5Q4vDtCJUkxK1jwX+0YbqvE4JQni5HaSZ2xMNRmjYV4gO7TPlCi3fJ1oG9I
	LKU+TmRqUF5gnnI1Dfvl462CN6Ba80EfF1WAL4lM4S08PMOrRYSVUvV/lQsIc1s+yTvo1YCFMsv
	Wt5mR0zvAijpi818smu0uT9m8ICIFvlHClqVu7zhGG3NnDaU4+mAANV+axahXkiGhHXPBHGYPQn
	YGBUdyGJyfoZhyXYevCki57kHUiHz3D/e6H5II52YvIw9f4k5yHEf9zKANeius4Xf++lR1y70o0
	eT7l00mmJeBTondpFuE1YFi2JKS3c7keuPqeTFBbvfOiyQEEj65PvlSAMZq0VzxKDdDLOXcjQ0y
	pjrwC/ietENSPPxkhRUi9ZZmzZJ4VEC0nyJjmAmaLOMaq51XEw+2NbzuUh2cXRX4Qanqz8zdw4E
	X7E7dEuk6u0/+d5h35VnXdO/Y1eAlyIVVFCyB88km5eG3eEMWrqssLoImAsh3gtJGQxNPvsZoQP
	QUovnvlifbe7j/VI7WqBhDx9IwqvZZWRwZuWjtsNX8BkInR/6xFYWhrgPjwH1YtchBku91PsgLs
	tEj0bmll04A==
X-Received: by 2002:a05:6000:4b1d:b0:47d:ee7a:9306 with SMTP id ffacd0b85a97d-47df08251f6mr13674756f8f.61.1783701694930;
        Fri, 10 Jul 2026 09:41:34 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm63643639f8f.2.2026.07.10.09.41.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 09:41:34 -0700 (PDT)
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
	toon@iotcl.com,
	Calvin Wan <calvinwan@google.com>
Subject: [PATCH GSoC v16 10/13] transport: add client support for object-info
Date: Fri, 10 Jul 2026 18:41:16 +0200
Message-ID: <20260710-ps-eric-work-rebase-v16-10-66e07b58a8fe@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
References: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
 <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

Sometimes, it is beneficial to retrieve information about an object
without downloading it entirely. The server-side logic for this
functionality was implemented in commit "a2ba162cda (object-info:
support for retrieving object info, 2021-04-20)." And the wire
format is documented at
https://git-scm.com/docs/protocol-v2#_object_info.

Introduce client-side support for the object-info capability.

Add its own function for object-info separate from existing fetch
infrastructure.

Currently, the client supports requesting a list of object IDs with
the size feature from a v2 server. If the server does not advertise
this feature (i.e., transfer.advertiseobjectinfo is set to false),
the client returns an error and exit.

Note that:

1. the entire request is written into req_buf before being sent to the
   remote. This approach follows the pattern used in the
   send_fetch_request() logic within 'fetch-pack.c'. Streaming the
   request is not addressed in this patch.

2. When the server does not recognize an OID, following the v2 protocol,
   the server returns "<OID> SP", when this happens,
   fetch_object_info() sets the corresponding size pointer to NULL so
   that callers can detect and handle it.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Makefile             |   1 +
 fetch-object-info.c  | 109 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fetch-object-info.h  |  22 +++++++++++
 fetch-pack.h         |   1 +
 meson.build          |   1 +
 transport-helper.c   |  13 +++++-
 transport-internal.h |   8 ++++
 transport.c          |  46 ++++++++++++++++++++++
 transport.h          |  10 +++++
 9 files changed, 209 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 1f3f099f5c..cdabdb3771 100644
--- a/Makefile
+++ b/Makefile
@@ -1159,6 +1159,7 @@ LIB_OBJS += ewah/ewah_rlw.o
 LIB_OBJS += exec-cmd.o
 LIB_OBJS += fetch-negotiator.o
 LIB_OBJS += fetch-pack.o
+LIB_OBJS += fetch-object-info.o
 LIB_OBJS += fmt-merge-msg.o
 LIB_OBJS += fsck.o
 LIB_OBJS += fsmonitor.o
diff --git a/fetch-object-info.c b/fetch-object-info.c
new file mode 100644
index 0000000000..91685cb355
--- /dev/null
+++ b/fetch-object-info.c
@@ -0,0 +1,109 @@
+#include "git-compat-util.h"
+#include "gettext.h"
+#include "hex.h"
+#include "pkt-line.h"
+#include "connect.h"
+#include "oid-array.h"
+#include "odb.h"
+#include "fetch-object-info.h"
+#include "string-list.h"
+
+/* Sends object-info command and its arguments into the request buffer. */
+static void send_object_info_request(const int fd_out, struct object_info_args *args)
+{
+	struct strbuf req_buf = STRBUF_INIT;
+
+	write_command_and_capabilities(&req_buf, "object-info", args->server_options);
+
+	if (unsorted_string_list_has_string(args->object_info_options, "size"))
+		packet_buf_write(&req_buf, "size");
+	else
+		BUG("only size should be in object_info_options");
+
+	if (args->oids)
+		for (size_t i = 0; i < args->oids->nr; i++)
+			packet_buf_write(&req_buf, "oid %s", oid_to_hex(&args->oids->oid[i]));
+
+	packet_buf_flush(&req_buf);
+	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
+		die_errno(_("unable to write request to remote"));
+
+	strbuf_release(&req_buf);
+}
+
+static size_t parse_object_size(const char *s, size_t *res)
+{
+	uintmax_t uim;
+
+	if (!s[0] || s[strspn(s, "0123456789")])
+		return -1;
+	errno = 0;
+	uim = strtoumax(s, NULL, 10);
+	if (errno || uim > SIZE_MAX)
+		return -1;
+	*res = uim;
+	return 0;
+}
+
+int fetch_object_info(const enum protocol_version version, struct object_info_args *args,
+		      struct packet_reader *reader, struct object_info *object_info_data,
+		      const int stateless_rpc, const int fd_out)
+{
+	int size_index = -1;
+
+	switch (version) {
+	case protocol_v2:
+		if (!server_supports_v2("object-info"))
+			die(_("object-info capability is not enabled on the server"));
+		send_object_info_request(fd_out, args);
+		break;
+	case protocol_v1:
+	case protocol_v0:
+		die(_("unsupported protocol version. expected v2"));
+	case protocol_unknown_version:
+		BUG("unknown protocol version");
+	}
+
+	for (size_t i = 0; i < args->object_info_options->nr; i++) {
+		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
+			check_stateless_delimiter(stateless_rpc, reader,
+						  "stateless delimiter expected");
+			return -1;
+		}
+
+		if (!string_list_has_string(args->object_info_options, reader->line))
+			return -1;
+
+		if (!strcmp(reader->line, "size")) {
+			size_index = i;
+			for (size_t j = 0; j < args->oids->nr; j++)
+				object_info_data[j].sizep = xcalloc(1, sizeof(*object_info_data[j].sizep));
+		} else {
+			BUG("only size is supported");
+		}
+	}
+
+	for (size_t i = 0; packet_reader_read(reader) == PACKET_READ_NORMAL && i < args->oids->nr; i++) {
+		struct string_list object_info_values = STRING_LIST_INIT_DUP;
+
+		string_list_split(&object_info_values, reader->line, " ", -1);
+		if (size_index >= 0) {
+			if (!strcmp(object_info_values.items[1 + size_index].string, "")) {
+				FREE_AND_NULL(object_info_data[i].sizep);
+				string_list_clear(&object_info_values, 0);
+				continue;
+			}
+
+			if (parse_object_size(object_info_values.items[1 + size_index].string,
+					      object_info_data[i].sizep))
+				die("object-info: ref %s has invalid size %s",
+				    object_info_values.items[0].string,
+				    object_info_values.items[1 + size_index].string);
+		}
+
+		string_list_clear(&object_info_values, 0);
+	}
+	check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");
+
+	return 0;
+}
diff --git a/fetch-object-info.h b/fetch-object-info.h
new file mode 100644
index 0000000000..d35284bd6b
--- /dev/null
+++ b/fetch-object-info.h
@@ -0,0 +1,22 @@
+#ifndef FETCH_OBJECT_INFO_H
+#define FETCH_OBJECT_INFO_H
+
+#include "pkt-line.h"
+#include "protocol.h"
+#include "odb.h"
+
+struct object_info_args {
+	struct string_list *object_info_options;
+	const struct string_list *server_options;
+	struct oid_array *oids;
+};
+
+/*
+ * Sends git-cat-file object-info command into the request buf and read the
+ * results from packets.
+ */
+int fetch_object_info(enum protocol_version version, struct object_info_args *args,
+		      struct packet_reader *reader, struct object_info *object_info_data,
+		      int stateless_rpc, int fd_out);
+
+#endif /* FETCH_OBJECT_INFO_H */
diff --git a/fetch-pack.h b/fetch-pack.h
index 6d0dec7f41..0fba340a84 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -16,6 +16,7 @@ struct fetch_pack_args {
 	const struct string_list *deepen_not;
 	struct list_objects_filter_options filter_options;
 	const struct string_list *server_options;
+	struct object_info *object_info_data;
 
 	/*
 	 * If not NULL, during packfile negotiation, fetch-pack will send "have"
diff --git a/meson.build b/meson.build
index ca235801cf..19fad57da9 100644
--- a/meson.build
+++ b/meson.build
@@ -347,6 +347,7 @@ libgit_sources = [
   'exec-cmd.c',
   'fetch-negotiator.c',
   'fetch-pack.c',
+  'fetch-object-info.c',
   'fmt-merge-msg.c',
   'fsck.c',
   'fsmonitor.c',
diff --git a/transport-helper.c b/transport-helper.c
index f195070788..f97e6d7b29 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -727,8 +727,7 @@ static int fetch_refs(struct transport *transport,
 
 	/*
 	 * If we reach here, then the server, the client, and/or the transport
-	 * helper does not support protocol v2. --negotiate-only requires
-	 * protocol v2.
+	 * helper does not support protocol v2. --negotiate-only.
 	 */
 	if (data->transport_options.acked_commits) {
 		warning(_("--negotiate-only requires protocol v2"));
@@ -784,6 +783,15 @@ static int fetch_refs(struct transport *transport,
 	return -1;
 }
 
+static int fetch_object_info_helper(struct transport *transport)
+{
+	get_helper(transport);
+	if (process_connect(transport, 0))
+		return transport->vtable->fetch_object_info(transport);
+
+	die(_("object-info requires protocol v2"));
+}
+
 struct push_update_ref_state {
 	struct ref *hint;
 	struct ref_push_report *report;
@@ -1330,6 +1338,7 @@ static struct transport_vtable vtable = {
 	.get_refs_list	= get_refs_list,
 	.get_bundle_uri = get_bundle_uri,
 	.fetch_refs	= fetch_refs,
+	.fetch_object_info = fetch_object_info_helper,
 	.push_refs	= push_refs,
 	.connect	= connect_helper,
 	.disconnect	= release_helper
diff --git a/transport-internal.h b/transport-internal.h
index 051f3ab0dc..60db0bedcd 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -45,6 +45,14 @@ struct transport_vtable {
 	 **/
 	int (*fetch_refs)(struct transport *transport, int refs_nr, struct ref **refs);
 
+	/*
+	 * Fetch object info (only size currently) from remote without
+	 * downloading the objects.
+	 *
+	 * Uses object-info capability of v2 protocol.
+	 */
+	int (*fetch_object_info)(struct transport *transport);
+
 	/**
 	 * Push the objects and refs. Send the necessary objects, and
 	 * then, for any refs where peer_ref is set and
diff --git a/transport.c b/transport.c
index fc144f0aed..3e0a6558b7 100644
--- a/transport.c
+++ b/transport.c
@@ -1,3 +1,4 @@
+#include "compat/posix.h"
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
@@ -9,6 +10,7 @@
 #include "hook.h"
 #include "pkt-line.h"
 #include "fetch-pack.h"
+#include "fetch-object-info.h"
 #include "remote.h"
 #include "connect.h"
 #include "send-pack.h"
@@ -432,6 +434,48 @@ static int get_bundle_uri(struct transport *transport)
 				     transport->bundles, stateless_rpc);
 }
 
+static int fetch_object_info_via_pack(struct transport *transport)
+{
+	int ret = 0;
+	struct git_transport_data *data = transport->data;
+	struct packet_reader reader;
+	struct object_info_args args = { 0 };
+
+	args.server_options = transport->server_options;
+	args.oids = transport->smart_options->object_info_oids;
+	args.object_info_options = transport->smart_options->object_info_options;
+	string_list_sort(args.object_info_options);
+
+	connect_setup(transport, 0);
+	packet_reader_init(&reader, data->fd[0], NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_GENTLE_ON_EOF |
+			   PACKET_READ_DIE_ON_ERR_PACKET);
+
+	data->version = discover_version(&reader);
+	transport->hash_algo = reader.hash_algo;
+
+	ret = fetch_object_info(data->version, &args, &reader,
+				data->options.object_info_data,
+				transport->stateless_rpc, data->fd[1]);
+
+	close(data->fd[0]);
+	if (data->fd[1] >= 0)
+		close(data->fd[1]);
+	if (finish_connect(data->conn))
+		ret = -1;
+	data->conn = NULL;
+
+	return ret;
+}
+
+int transport_fetch_object_info(struct transport *transport)
+{
+	if (!transport->vtable->fetch_object_info)
+		die(_("remote does not support object-info"));
+	return transport->vtable->fetch_object_info(transport);
+}
+
 static int fetch_refs_via_pack(struct transport *transport,
 			       int nr_heads, struct ref **to_fetch)
 {
@@ -1004,6 +1048,7 @@ static struct transport_vtable taken_over_vtable = {
 	.get_refs_list	= get_refs_via_connect,
 	.get_bundle_uri = get_bundle_uri,
 	.fetch_refs	= fetch_refs_via_pack,
+	.fetch_object_info = fetch_object_info_via_pack,
 	.push_refs	= git_transport_push,
 	.disconnect	= disconnect_git
 };
@@ -1169,6 +1214,7 @@ static struct transport_vtable builtin_smart_vtable = {
 	.get_refs_list	= get_refs_via_connect,
 	.get_bundle_uri = get_bundle_uri,
 	.fetch_refs	= fetch_refs_via_pack,
+	.fetch_object_info = fetch_object_info_via_pack,
 	.push_refs	= git_transport_push,
 	.connect	= connect_git,
 	.disconnect	= disconnect_git
diff --git a/transport.h b/transport.h
index 7e5867cffa..9e85a4cd35 100644
--- a/transport.h
+++ b/transport.h
@@ -6,6 +6,7 @@
 #include "list-objects-filter-options.h"
 #include "string-list.h"
 #include "connect.h"
+#include "odb.h"
 
 struct git_transport_options {
 	unsigned thin : 1;
@@ -55,6 +56,10 @@ struct git_transport_options {
 	 * common commits to this oidset instead of fetching any packfiles.
 	 */
 	struct oidset *acked_commits;
+
+	struct oid_array *object_info_oids;
+	struct object_info *object_info_data;
+	struct string_list *object_info_options;
 };
 
 enum transport_family {
@@ -309,6 +314,11 @@ int transport_get_remote_bundle_uri(struct transport *transport);
 const struct git_hash_algo *transport_get_hash_algo(struct transport *transport);
 int transport_fetch_refs(struct transport *transport, struct ref *refs);
 
+/*
+ * Fetch the object info from remote
+ */
+int transport_fetch_object_info(struct transport *transport);
+
 /*
  * If this flag is set, unlocking will avoid to call non-async-signal-safe
  * functions. This will necessarily leave behind some data structures which

-- 
2.54.0
