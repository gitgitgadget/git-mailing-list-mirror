Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6542042D774
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300748; cv=none; b=JIDRxHSM4O6qHnBbd5O1hUqXBLQqLMgXQt8wHvP4t6D4vDxqraqTB5krJr7yQGRZlxEhY1nFeGbBVXBzM60Us3uzplM9N/IgBH1WyFvdM4nfW8SEGavDLq66CWqXoq+MgajYN0eGq49IEijuZEKxMoiVyfOiEadqus7Ie50ua4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300748; c=relaxed/simple;
	bh=ie8OI9/ImUyeO7UmWLiuVaCPzV4pEWI5eX//32kb2+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJ8bhfstB0O3bn/xCmCUAWlQluQuheWi/NeHQWgaaS2iXRNDVFjzeOvIhwo3gPBwYw9alB1/tfK+wMy9Wox18dBeppWYWyGA4bvgKtugszbBr01MXH44H3DHtjTVmLdYyZC0aewAruqh8aPayrslV0FNSRyXhW2ej4H/IiRQu5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyG5FKKu; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyG5FKKu"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so407515e9.2
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 08:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784300742; x=1784905542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8GDzY+yFqDDJTp9OHqB+YX2oclmtMDJ4vvDvE2hDfio=;
        b=hyG5FKKu+IFUPjIBdKBfxQZQSChehqO0iMipuHm9AKnIcw/lh5gblq5Y4svJnpleNs
         ysrzt5wxmHeTYzp5y+r+83JCRjBIQLOsrQmyqSv5pq/rgGWIwBpcnOtAIjA5SteL53Ia
         TcLlJ140waYO4gf1mnpvPRHkcy8/hsfpxwhWzIVRK0rKR7aT9Yw8H9kMVPmpM9zeFoMU
         VuOdnk2LTaKpR47gjvNUMy04nrSSNuCihgurE4ylrhF7edrOPc4gKKyuQRZRwO2pmoIs
         Gi6MFbcdOhPYtA0Vcia6AP/iu4HFIH3kQG4VPJqOFnfFsT6TJjrD//kszTBMWijIaHv1
         x2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784300742; x=1784905542;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8GDzY+yFqDDJTp9OHqB+YX2oclmtMDJ4vvDvE2hDfio=;
        b=TeLrHparom3ES7klzLfXXbSI3zGLeWGvw9DNt97cMqERKWc4Lin8wfGkGZtMt7EQli
         UHfX29nEbus1vVVqVeO6p05f2mTwZr7h8e0KsdXxfUOQAfxf/mkhuA8apQBlpQhrQMcV
         79HWZmas/XGCk33exAVdZXNlveZnB2bTeSIMS9gCIERHxZCmMLU4Ww8UhuwWnYTePQ3/
         0fFxiYWVyqXl3duaSWzoZadVPggwnFUPQirz2eQd6rc+3ZIkY0dkNtt/3QV4eLaiR74Q
         SjJtedUGSq+mUMUbz7WPQj4RbwvOUqCDrnCSPNBnGRFdFdfNBqeNRZfn8BK25L8GySpo
         2Ngg==
X-Gm-Message-State: AOJu0YzfWcWcqlSqbFUSHQi6lLrD6VnrtNJb8xTdUOM3/w/ZMdQ3Wr/o
	Ix084XDNhacqavgytR5vEUBoKlShzRvH2bblXapyMA/U1HRJO7RqTYk1ZSLWb+pX
X-Gm-Gg: AfdE7cmbg+kBKogZrhgxkfEbN1wRlOem2WLIcDv6XCPjZ2UeygCTFDvgauqOcFi9EC1
	VnXxkvNE2SQbxJlQKTkC+b9s7ZnVNQrQvmZmu+AAPFw0nzl/A8Z0kJ6ts9FeOMivNSQqStpI+Kb
	Xwoqq/26XF+onukoZ+BC8HlmxnL3OjhZxPX1NXxTTIFQvuZDzOJK/kVSBCyAtKXFpg7im3wz4Hl
	7nl2GeaW4Y+XRmecRUEEWzszO6lTPWkSz1K9eBsd6ZHAWP9KCpTjBsWdDArgP1OnzhzhLdqSltk
	ty7NVjZHu7R+Rtg77F0cUzj8fOQs2CnSAw0O1vL3qlgkaHS1yiQMfpzo2lymC1EO596EimBT4qc
	Sr/+mhCiOZBGKsVF9sfNhUV2zz1jiu1KDrF014uVNJEQFWJ60f0n1UT1T/tieK77luLIxchS3+W
	L86oNQ2gHylO2ZS67IE21osI476DSIEQbQ+OzkK9ttKQUIymU4UwSqVe8oLCv+EF6jjWKTIzbqx
	XWEFW3Z4xN58sXHz1CYPbqwYrc6iM2sImxPahYa9YERoCBo+ByrKFi8+CVOgKqaq1IKfi2xuHo3
	SfWfzdD49UlC82XUVZ0YwS2nWjC1I4mialCW6zhrDhM=
X-Received: by 2002:a7b:ce8c:0:b0:493:df5d:6ca6 with SMTP id 5b1f17b1804b1-4954a402f1emr30317455e9.25.1784300742085;
        Fri, 17 Jul 2026 08:05:42 -0700 (PDT)
Received: from localhost.localdomain ([47.58.6.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2692a3sm50226025e9.0.2026.07.17.08.05.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Jul 2026 08:05:41 -0700 (PDT)
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
Subject: [PATCH GSoC v19 11/13] transport: add client support for object-info
Date: Fri, 17 Jul 2026 17:05:21 +0200
Message-ID: <20260717-ps-eric-work-rebase-v19-11-d4faee35764b@gmail.com>
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

Currently, the client supports requesting a list of OIDs with the size
attribute from a v2 server. If the server does not advertise this
feature (i.e., transfer.advertiseobjectinfo is set to false), the client
returns an error and exits.

Note that:

1. The entire request is written into req_buf before being sent to the
   remote. This approach follows the pattern used in the
   send_fetch_request() logic within 'fetch-pack.c'. Streaming the
   request is not addressed in this patch.

2. A new field 'unrecognized' has been added to object_info. This new
   field is set at fetch_object_info() when the object is unrecognized
   by the server.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Makefile             |   1 +
 fetch-object-info.c  | 138 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fetch-object-info.h  |  22 ++++++++
 meson.build          |   1 +
 odb.h                |   6 +++
 transport-helper.c   |  10 ++++
 transport-internal.h |   8 +++
 transport.c          |  45 +++++++++++++++++
 transport.h          |   9 ++++
 9 files changed, 240 insertions(+)

diff --git a/Makefile b/Makefile
index 1f3f099f5c..d450e0277e 100644
--- a/Makefile
+++ b/Makefile
@@ -1158,6 +1158,7 @@ LIB_OBJS += ewah/ewah_io.o
 LIB_OBJS += ewah/ewah_rlw.o
 LIB_OBJS += exec-cmd.o
 LIB_OBJS += fetch-negotiator.o
+LIB_OBJS += fetch-object-info.o
 LIB_OBJS += fetch-pack.o
 LIB_OBJS += fmt-merge-msg.o
 LIB_OBJS += fsck.o
diff --git a/fetch-object-info.c b/fetch-object-info.c
new file mode 100644
index 0000000000..30475a1e87
--- /dev/null
+++ b/fetch-object-info.c
@@ -0,0 +1,138 @@
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
+	else if (args->object_info_options->nr)
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
+static int parse_object_size(const char *s, size_t *res)
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
+		die(_("object-info requires protocol v2"));
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
+			/*
+			 * i is the number of supported options which currently
+			 * is only size. No risk of overflow.
+			 */
+			size_index = (int)i;
+			for (size_t j = 0; j < args->oids->nr; j++)
+				object_info_data[j].sizep =
+					xcalloc(1, sizeof(*object_info_data[j].sizep));
+		} else {
+			BUG("only size is supported");
+		}
+	}
+
+	for (size_t i = 0;
+	     packet_reader_read(reader) == PACKET_READ_NORMAL &&
+	     i < args->oids->nr;
+	     i++) {
+		struct string_list object_info_values = STRING_LIST_INIT_DUP;
+
+		string_list_split(&object_info_values, reader->line, " ", -1);
+
+		if (strcmp(object_info_values.items[0].string,
+			   oid_to_hex(&args->oids->oid[i])))
+			die(_("object-info: expected OID: %s, got %s"),
+			    oid_to_hex(&args->oids->oid[i]),
+			    object_info_values.items[0].string);
+
+		/*
+		 * If the response is two elements but the second one is an
+		 * empty string, that means that the OID is unrecognized by the
+		 * server.
+		 */
+		if (object_info_values.nr >= 2 &&
+		    !strcmp(object_info_values.items[1].string, "")) {
+			object_info_data[i].unrecognized = 1;
+			string_list_clear(&object_info_values, 0);
+			continue;
+		}
+
+		/*
+		 * Because we filter the options to be only the supported by
+		 * the server we expect the server to answer with the same
+		 * number of attributes requested.
+		 */
+		if (args->object_info_options->nr + 1 != object_info_values.nr)
+			die("object-info: unexpected number of attributes: %s",
+			    reader->line);
+
+		if (size_index >= 0 &&
+		    parse_object_size(object_info_values.items[size_index + 1].string,
+				      object_info_data[i].sizep))
+			die("object-info: ref %s has invalid size %s",
+			    object_info_values.items[0].string,
+			    object_info_values.items[size_index + 1].string);
+
+		string_list_clear(&object_info_values, 0);
+	}
+	check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");
+
+	return 0;
+}
diff --git a/fetch-object-info.h b/fetch-object-info.h
new file mode 100644
index 0000000000..31aad98408
--- /dev/null
+++ b/fetch-object-info.h
@@ -0,0 +1,22 @@
+#ifndef FETCH_OBJECT_INFO_H
+#define FETCH_OBJECT_INFO_H
+
+#include "pkt-line.h"
+#include "protocol.h"
+
+struct object_info_args {
+	struct string_list *object_info_options;
+	const struct string_list *server_options;
+	struct oid_array *oids;
+};
+
+struct object_info;
+/*
+ * Sends git-cat-file object-info command into the request buf and read the
+ * results from packets.
+ */
+int fetch_object_info(enum protocol_version version, struct object_info_args *args,
+		      struct packet_reader *reader, struct object_info *object_info_data,
+		      int stateless_rpc, int fd_out);
+
+#endif /* FETCH_OBJECT_INFO_H */
diff --git a/meson.build b/meson.build
index 9434b56960..dfefcd3475 100644
--- a/meson.build
+++ b/meson.build
@@ -359,6 +359,7 @@ libgit_sources = [
   'ewah/ewah_rlw.c',
   'exec-cmd.c',
   'fetch-negotiator.c',
+  'fetch-object-info.c',
   'fetch-pack.c',
   'fmt-merge-msg.c',
   'fsck.c',
diff --git a/odb.h b/odb.h
index 94754643d2..88a37febbf 100644
--- a/odb.h
+++ b/odb.h
@@ -339,6 +339,12 @@ struct object_info {
 	 * or multiple times in the same source.
 	 */
 	struct odb_source_info *source_infop;
+
+	/*
+	 * object-info protocol specific. Set by the protocol when the remote
+	 * does not recognize the requested object.
+	 */
+	unsigned int unrecognized:1;
 };
 
 /*
diff --git a/transport-helper.c b/transport-helper.c
index f195070788..623463dcea 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -784,6 +784,15 @@ static int fetch_refs(struct transport *transport,
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
@@ -1330,6 +1339,7 @@ static struct transport_vtable vtable = {
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
index fc144f0aed..9342680531 100644
--- a/transport.c
+++ b/transport.c
@@ -9,6 +9,7 @@
 #include "hook.h"
 #include "pkt-line.h"
 #include "fetch-pack.h"
+#include "fetch-object-info.h"
 #include "remote.h"
 #include "connect.h"
 #include "send-pack.h"
@@ -432,6 +433,48 @@ static int get_bundle_uri(struct transport *transport)
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
@@ -1004,6 +1047,7 @@ static struct transport_vtable taken_over_vtable = {
 	.get_refs_list	= get_refs_via_connect,
 	.get_bundle_uri = get_bundle_uri,
 	.fetch_refs	= fetch_refs_via_pack,
+	.fetch_object_info = fetch_object_info_via_pack,
 	.push_refs	= git_transport_push,
 	.disconnect	= disconnect_git
 };
@@ -1169,6 +1213,7 @@ static struct transport_vtable builtin_smart_vtable = {
 	.get_refs_list	= get_refs_via_connect,
 	.get_bundle_uri = get_bundle_uri,
 	.fetch_refs	= fetch_refs_via_pack,
+	.fetch_object_info = fetch_object_info_via_pack,
 	.push_refs	= git_transport_push,
 	.connect	= connect_git,
 	.disconnect	= disconnect_git
diff --git a/transport.h b/transport.h
index 7e5867cffa..a7869d18e0 100644
--- a/transport.h
+++ b/transport.h
@@ -55,6 +55,10 @@ struct git_transport_options {
 	 * common commits to this oidset instead of fetching any packfiles.
 	 */
 	struct oidset *acked_commits;
+
+	struct oid_array *object_info_oids;
+	struct object_info *object_info_data;
+	struct string_list *object_info_options;
 };
 
 enum transport_family {
@@ -309,6 +313,11 @@ int transport_get_remote_bundle_uri(struct transport *transport);
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
