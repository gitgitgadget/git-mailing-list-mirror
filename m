Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE2F2036ED
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361490; cv=none; b=o8CBj0ozMB8m4EYqveyCMsdGJ7V6eNQiJ+SC3Q4KdJoDMdBoYgBa4GyDybUUCYQGJX9VxLJFk2KN0CLJ7dBbAwRPeG/EEVjPWygA41gGfuLq4JGwzZKpvF/0gNs7gDqMIMrINUTt6CowVcs72te/HKSevE0hI/NetKc7M2X9k+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361490; c=relaxed/simple;
	bh=IWyXelcEckC1DOmq0T819MfQ0FOT8ihTv77d7OjwHhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CM9bqgmVpM3tontEJD4uQvuORjT+O3OmQil4gBE/qdMU6hynnuDQ8/xkDNHGkDFbQnG358FVczO52MqisO8Pax07fwB95pZb9Xufcsg3xU8wD50uAH684fh9YLLmJILFi6RyGWd5fYy9mPZINy6x7M1Ln2BMGRpZlRWOvXpDdts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPBu1HJe; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPBu1HJe"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46785fbb949so86641cf.3
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 10:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736361486; x=1736966286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32o2mCpyTFJSE1jfDUNvvNp78Xy4w0ZNmCe+x0QzmzI=;
        b=XPBu1HJeZq7uJ8ZUI1FziTOIKrAoljCTJZWzML1aUP7eZUj552ZPRbzq/Nlo6DWIVf
         pOgPmxNvXeZXW5gkdud1ckB9kQr4+zQSZbaRn8wf4uK0yD9T1aBn7bzMr6fsf7NtUgfv
         ROK+bzoqX4UYeWaa9xjhmrSa1msHdhJA8wvwryLMiUQcxK/IUj+5Gx2ss3oT5dBHppuW
         j0lTcnL5aLWh7XxzKQqycZK+mSC6qkM5hQvyiZ5AowRQWBlnZNKscNHi7osoO5vGq9TR
         +uhtiKrnAlXDfPnV2O62C7BwCcgfs3/9vigy4ngK0upzpN7LJw2sUSDZUAyRhTHAVSiD
         IfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736361486; x=1736966286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32o2mCpyTFJSE1jfDUNvvNp78Xy4w0ZNmCe+x0QzmzI=;
        b=Bts8HtQAeA6UKNsdQo7XhX3i1AX1IYsqeaXu+RRABzC9+o1dGDcchPzkXg3aFF1Ud+
         fshhMQzpnflPYYNJyHrBfL/eCRJNi1btNn9Fw0Pg44vjvUDP7SUlh+U4Mbvxr+vimgof
         L678Xg4XauAfklnJzUxxGpQZgRqbQtBFFttOgaFLdx28cO7Ascx830rT5zpIY7cN3gZ1
         L9xyn7fxcuZE4BjlRJGMxuk8O0eRS0rFZYpbuQO2YaGbV2qGmjxzNLuiDquY1d2cQcvw
         H3kPpzOPYc6BrqlONGpS+8o9+p0tM8ch2qiO75dyXMrDn1J2vzuGIKdBIi3SjN64N3HV
         ms6Q==
X-Gm-Message-State: AOJu0YzngFEP17zp61zElzQwtjF1CPjVkEj//VD7qonIfvXW90V7C1LL
	MeWDTB0FijYrRXT6d/S7JW8hfe/SQh/dpbyfRq0xKfCnNr3vfW0oTJUcog5vIsU=
X-Gm-Gg: ASbGncspfqpVhlvgtXjZ91LEwM60Wbxn2BME0rbT74eytoRGRjwphwlF3rHpJcVkwzt
	nu8H5unSN88KZWjsQ2FiexgLObwOAWV5OMICd2dzP4kEAfPU5GwyjRMzewDDeZBOnEs5Z8IONrO
	eHwNxL1WUzdG+A6rOF6E3YicyxOAttEDadIEzc9hRLhNPDnHjr8ByM2MhYmCsaKCAdamlFspg/1
	rVdNd5Vk4c4m4LXVgAi/g2HyckITvZgnqwKtEaeaVAMIiQDs937vd0z+vJwhpzX5fRWsvl1mvMf
	D1iYFHPe3A==
X-Google-Smtp-Source: AGHT+IGxyaXkbUtqVY7nQ91ifyMFlaILm/0xSX08r/RdGnh3NrXl4qmeINeE8CNPIEp0ixsj/QtkVw==
X-Received: by 2002:a05:6214:495:b0:6d8:a76d:b66c with SMTP id 6a1803df08f44-6df9b2b33b0mr55480716d6.30.1736361485997;
        Wed, 08 Jan 2025 10:38:05 -0800 (PST)
Received: from localhost.localdomain ([184.148.194.219])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180ea74bsm193228036d6.25.2025.01.08.10.38.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jan 2025 10:38:05 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v9 7/8] transport: add client support for object-info
Date: Wed,  8 Jan 2025 13:37:38 -0500
Message-ID: <20250108183740.67022-8-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250108183740.67022-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250108183740.67022-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

Sometimes, it is beneficial to retrieve information about an object
without downloading it entirely. The server-side logic for this
functionality was implemented in commit "a2ba162cda (object-info:
support for retrieving object info, 2021-04-20)." And the wire
format is documented at
https://git-scm.com/docs/protocol-v2#_object_info.

This commit introduces client functions to interact with the server.

Currently, the client supports requesting a list of object IDs with
the 'size' feature from a v2 server. If the server does not advertise
this feature (i.e., transfer.advertiseobjectinfo is set to false),
the client will return an error and exit.

Notice that the entire request is written into req_buf before being
sent to the remote. This approach follows the pattern used in the
`send_fetch_request()` logic within fetch-pack.c.
Streaming the request is not addressed in this patch.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
---
 Makefile            |  1 +
 fetch-object-info.c | 85 +++++++++++++++++++++++++++++++++++++++++++++
 fetch-object-info.h | 22 ++++++++++++
 fetch-pack.c        |  3 ++
 fetch-pack.h        |  2 ++
 transport-helper.c  | 11 ++++--
 transport.c         | 28 ++++++++++++++-
 transport.h         | 11 ++++++
 8 files changed, 160 insertions(+), 3 deletions(-)
 create mode 100644 fetch-object-info.c
 create mode 100644 fetch-object-info.h

diff --git a/Makefile b/Makefile
index 97e8385b66..e8c6702b32 100644
--- a/Makefile
+++ b/Makefile
@@ -1020,6 +1020,7 @@ LIB_OBJS += ewah/ewah_rlw.o
 LIB_OBJS += exec-cmd.o
 LIB_OBJS += fetch-negotiator.o
 LIB_OBJS += fetch-pack.o
+LIB_OBJS += fetch-object-info.o
 LIB_OBJS += fmt-merge-msg.o
 LIB_OBJS += fsck.o
 LIB_OBJS += fsmonitor.o
diff --git a/fetch-object-info.c b/fetch-object-info.c
new file mode 100644
index 0000000000..b279e06dc8
--- /dev/null
+++ b/fetch-object-info.c
@@ -0,0 +1,85 @@
+#include "git-compat-util.h"
+#include "gettext.h"
+#include "hex.h"
+#include "pkt-line.h"
+#include "connect.h"
+#include "oid-array.h"
+#include "object-store-ll.h"
+#include "fetch-object-info.h"
+#include "string-list.h"
+
+/* Sends git-cat-file object-info command and its arguments into the request buffer. */
+static void send_object_info_request(const int fd_out, struct object_info_args *args)
+{
+	struct strbuf req_buf = STRBUF_INIT;
+
+	write_command_and_capabilities(&req_buf, "object-info", args->server_options);
+
+	if (unsorted_string_list_has_string(args->object_info_options, "size"))
+		packet_buf_write(&req_buf, "size");
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
+			check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");
+			return -1;
+		}
+		if (!string_list_has_string(args->object_info_options, reader->line))
+			return -1;
+		if (!strcmp(reader->line, "size")) {
+			size_index = i;
+			for (size_t j = 0; j < args->oids->nr; j++)
+				object_info_data[j].sizep = xcalloc(1, sizeof(*object_info_data[j].sizep));
+		}
+	}
+
+	for (size_t i = 0; packet_reader_read(reader) == PACKET_READ_NORMAL && i < args->oids->nr; i++){
+		struct string_list object_info_values = STRING_LIST_INIT_DUP;
+
+		string_list_split(&object_info_values, reader->line, ' ', -1);
+		if (0 <= size_index) {
+			if (!strcmp(object_info_values.items[1 + size_index].string, ""))
+				die("object-info: not our ref %s",
+					object_info_values.items[0].string);
+
+			if (strtoul_ul(object_info_values.items[1 + size_index].string, 10, object_info_data[i].sizep))
+				die("object-info: ref %s has invalid size %s",
+					object_info_values.items[0].string,
+					object_info_values.items[1 + size_index].string);
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
index 0000000000..6184d04d72
--- /dev/null
+++ b/fetch-object-info.h
@@ -0,0 +1,22 @@
+#ifndef FETCH_OBJECT_INFO_H
+#define FETCH_OBJECT_INFO_H
+
+#include "pkt-line.h"
+#include "protocol.h"
+#include "object-store-ll.h"
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
diff --git a/fetch-pack.c b/fetch-pack.c
index 51de82e414..704bc21b47 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1654,6 +1654,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	if (args->depth > 0 || args->deepen_since || args->deepen_not)
 		args->deepen = 1;
 
+	if (args->object_info)
+		state = FETCH_SEND_REQUEST;
+
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_CHECK_LOCAL:
diff --git a/fetch-pack.h b/fetch-pack.h
index 9d3470366f..119d3369f1 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -16,6 +16,7 @@ struct fetch_pack_args {
 	const struct string_list *deepen_not;
 	struct list_objects_filter_options filter_options;
 	const struct string_list *server_options;
+	struct object_info *object_info_data;
 
 	/*
 	 * If not NULL, during packfile negotiation, fetch-pack will send "have"
@@ -42,6 +43,7 @@ struct fetch_pack_args {
 	unsigned reject_shallow_remote:1;
 	unsigned deepen:1;
 	unsigned refetch:1;
+	unsigned object_info:1;
 
 	/*
 	 * Indicate that the remote of this request is a promisor remote. The
diff --git a/transport-helper.c b/transport-helper.c
index d457b42550..9da1547b2c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -710,8 +710,8 @@ static int fetch_refs(struct transport *transport,
 
 	/*
 	 * If we reach here, then the server, the client, and/or the transport
-	 * helper does not support protocol v2. --negotiate-only requires
-	 * protocol v2.
+	 * helper does not support protocol v2. --negotiate-only and cat-file
+	 * remote-object-info require protocol v2.
 	 */
 	if (data->transport_options.acked_commits) {
 		warning(_("--negotiate-only requires protocol v2"));
@@ -727,6 +727,13 @@ static int fetch_refs(struct transport *transport,
 		free_refs(dummy);
 	}
 
+	/* fail the command explicitly to avoid further commands input. */
+	if (transport->smart_options->object_info)
+		die(_("remote-object-info requires protocol v2"));
+
+	if (!data->get_refs_list_called)
+		get_refs_list_using_list(transport, 0);
+
 	count = 0;
 	for (i = 0; i < nr_heads; i++)
 		if (!(to_fetch[i]->status & REF_STATUS_UPTODATE))
diff --git a/transport.c b/transport.c
index 10d820c333..b6a2052908 100644
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
@@ -464,8 +465,33 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.server_options = transport->server_options;
 	args.negotiation_tips = data->options.negotiation_tips;
 	args.reject_shallow_remote = transport->smart_options->reject_shallow;
+	args.object_info = transport->smart_options->object_info;
+
+	if (transport->smart_options && transport->smart_options->object_info
+	    && transport->smart_options->object_info_oids->nr > 0) {
+		struct packet_reader reader;
+		struct object_info_args obj_info_args = { 0 };
+
+		obj_info_args.server_options = transport->server_options;
+		obj_info_args.oids = transport->smart_options->object_info_oids;
+		obj_info_args.object_info_options = transport->smart_options->object_info_options;
+		string_list_sort(obj_info_args.object_info_options);
+
+		connect_setup(transport, 0);
+		packet_reader_init(&reader, data->fd[0], NULL, 0,
+				PACKET_READ_CHOMP_NEWLINE |
+				PACKET_READ_GENTLE_ON_EOF |
+				PACKET_READ_DIE_ON_ERR_PACKET);
+
+		data->version = discover_version(&reader);
+		transport->hash_algo = reader.hash_algo;
+
+		ret = fetch_object_info(data->version, &obj_info_args, &reader,
+					data->options.object_info_data, transport->stateless_rpc,
+					data->fd[1]);
+		goto cleanup;
 
-	if (!data->finished_handshake) {
+	} else if (!data->finished_handshake) {
 		int i;
 		int must_list_refs = 0;
 		for (i = 0; i < nr_heads; i++) {
diff --git a/transport.h b/transport.h
index 44100fa9b7..e61e931863 100644
--- a/transport.h
+++ b/transport.h
@@ -5,6 +5,7 @@
 #include "remote.h"
 #include "list-objects-filter-options.h"
 #include "string-list.h"
+#include "object-store.h"
 
 struct git_transport_options {
 	unsigned thin : 1;
@@ -30,6 +31,12 @@ struct git_transport_options {
 	 */
 	unsigned connectivity_checked:1;
 
+	/*
+	 * Transport will attempt to retrieve only object-info.
+	 * If object-info is not supported, the operation will error and exit.
+	 */
+	unsigned object_info : 1;
+
 	int depth;
 	const char *deepen_since;
 	const struct string_list *deepen_not;
@@ -53,6 +60,10 @@ struct git_transport_options {
 	 * common commits to this oidset instead of fetching any packfiles.
 	 */
 	struct oidset *acked_commits;
+
+	struct oid_array *object_info_oids;
+	struct object_info *object_info_data;
+	struct string_list *object_info_options;
 };
 
 enum transport_family {
-- 
2.47.0

