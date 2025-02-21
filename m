Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB8E253329
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 19:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740164725; cv=none; b=JfTvw5XeLfl3L2pBQjXWP+z+2YE1vVSm1rdoUM+h5/Op3BQjOoQ9J3G4vmv7QXeIv3oCOgoya4uOUNh+R9O9hjB9Vn5+/fA8BKLLJmscTUKSEGG7RQyPV3Kt9aRjbYs5IQKvi5J0H7tuIUvmfJUizH9nxU+pkhwpOyVUbh8Fdw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740164725; c=relaxed/simple;
	bh=SwsftzIhiciWw3ez4v10ICADfvPQ7+dPInPep0VoXbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXtr//Eab0IVwDcIxwRs2rJRYiRX3iBebAhdrh9T7oAY66s6cAlzrweK0yMI1sqLfXe4DpGMxwVcVvG0Q/bUUyMFzVhagocJbpjxVsTYANQNAORq+nqRomhCJNw+fJcadj9oUOUqaKdmUH34FT6GIj1xwtfwRHzIoVUSsYlPv38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7G8ps5j; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7G8ps5j"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-471fe5e0a80so19875741cf.1
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 11:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740164722; x=1740769522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUhTvUDG58ep2PEayM+cGe88Wm965aD9NV7xDFJdAQ4=;
        b=b7G8ps5jXFu5J1EeiGzbqUll/ETnd0aKXwBweTtFcu14araMgQf7yh6OvoidmsFo3C
         0I2KGf5rwSbNFhp1LOaSigMfkXBdOaa5V89/UDzZbybXHXlyQlfrQh2ag5D0qK0OxJej
         5evYi9HsrQaHcIByA30fmQT+rGId7B1F9w/dYUPfioApL4tBqdULT51HuVFXRJ9Oj1eP
         fzEA/kzbyvnDsVxRNcO/9k+YXzkoSeqpLTUxVcGhhUI85bopLJVd57lH5g09vKrXArh2
         vViDr9eheMAk6N4OKA5YLg6ivgg/xPKNFvpUSjl/LP4Rhr+J8u+Jyfp5RHuha/IFjnYa
         zIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740164722; x=1740769522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUhTvUDG58ep2PEayM+cGe88Wm965aD9NV7xDFJdAQ4=;
        b=Z/aN5BKma+GA5bnffZDPubU49LKV2R6w8ZutUVWRg9uIHwHTRrp3kUDFqp+sBIH27Z
         J5GiugoCjuiogKwHvqOKUcv3Qv7GC/QcNFTIejPemwKzXaLVxT0M5dh5+YPzumGh012o
         oJog2rjYCMDQMnm3oDQOyz60uf6S71F64/RFZNAMBGm0uCgRzV1uLPydYHA3K26geuf9
         mkLEF+eqI8nYFi+aOOalxe4xDLJgHELwfv63sU+I+HEIb550QCmfodSR3EXdpnh60T+U
         Zzne3s7GV2FGgDIdlVNzpkvw7wpGKOANiC9NKAjUTrkccNVmXO09ChOi63f4TC3n1j3l
         7MVg==
X-Gm-Message-State: AOJu0YxbgUDO7rLosK+NMJ2co61g/lPyCgadJVvbbvzEjpMA/vYJ2F59
	wobHQmp7k0pHIySf+fo5Ez3aTyrtVwdycknGLzPyYew/74Ew2lHmybvSjUs/mnY=
X-Gm-Gg: ASbGncvVFRLbt9jFjH+M9RZGZK50r2rlHU1cY28y8NZLZTFX179B6pbXtira+JCJxMX
	h4pMK7DXLxZJDEk8h+SpvGfs67Y1a6+dENp3mJu+K3nnVGkiz+Wh6nUWkzaSUP5a00qE/Pwzynf
	hJnXfLzQp20Bm9DncHN/whgj96XIAgB8ddLwjF3mKhffqMePxU36MI3hc0wNB+aGHo/ZdhtvDOf
	kV3KoVFGbGVK2Yu5MbJ7MJIJwTr3RCvX39O7h4O2xpp9Q40azs5BCYo/Ij6evBw+ySAEQ2G8tOT
	k+mSEDgkbTdfKVgAAGgLXmyxLgCw9emnZ1igb6Ex9e45VdArxFBm
X-Google-Smtp-Source: AGHT+IEZvU3OhGKRLL8F26jGuj7IMiBQObsT5LC1F47mUPU6CtRCOSkUYpQS0xstsm6R9Eji3D3EhA==
X-Received: by 2002:a05:622a:118e:b0:472:697:9ab4 with SMTP id d75a77b69052e-472248f50c0mr50682941cf.38.1740164721074;
        Fri, 21 Feb 2025 11:05:21 -0800 (PST)
Received: from localhost.localdomain ([70.49.151.101])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4720b1fe010sm32945661cf.60.2025.02.21.11.05.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Feb 2025 11:05:20 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v11 7/8] transport: add client support for object-info
Date: Fri, 21 Feb 2025 14:04:48 -0500
Message-ID: <20250221190451.12536-8-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221190451.12536-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250221190451.12536-1-eric.peijian@gmail.com>
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
index bcf5ed3f85..bd6786a3d9 100644
--- a/Makefile
+++ b/Makefile
@@ -1030,6 +1030,7 @@ LIB_OBJS += ewah/ewah_rlw.o
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
index 35dccea073..92e8a7291c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1656,6 +1656,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
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
index 6c2801bcbd..95be3771a6 100644
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
@@ -465,8 +466,33 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.server_options = transport->server_options;
 	args.negotiation_tips = data->options.negotiation_tips;
 	args.reject_shallow_remote = transport->smart_options->reject_shallow;
+	args.object_info = transport->smart_options->object_info;
+
+	if (transport->smart_options->object_info
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
2.48.1

