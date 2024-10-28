Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039061E25F8
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147721; cv=none; b=Chraoxi8ho0CiySytNycCE+UPEHgcZidFn2X9BQeBrWMP60AfpEeFo/MMrGAeuwklZQFyUvGMTTwc4psZnLbtpUp1kdqBLOcZapB/FylaobqGN+ycySVvy4y0DfkFaFGwPQ5X2fFVYjo/tf2hVcPfZqTxx0QEBGHtCeb3VOsoYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147721; c=relaxed/simple;
	bh=1gDL9JB0OT2IrYSJE+9pqpUicUuFH6b8WakilDN01EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLKTPJqIBV9cV/lNZPNAHCsI0VTh2hJpXvoH945O1e43zdRsQ182tA87dtT/Wn+HZzjR6IS6bpqS9pfUjaZO139vOebr0ChvjVTwE2fGjbzEO/Pa2kDTytOTKbrR993jJ8NlFu6qi4m5rC0/ID3C+4zSnqo4M+4Ks7nYypwnl+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWSjU21Q; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWSjU21Q"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-460c1ba306bso33725041cf.2
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 13:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730147717; x=1730752517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdMHgBAHHz/JsQ7QRBqmTzxvxXRCqQQA1//u8IAS450=;
        b=JWSjU21Qip35yQ19GIw2XAv4l2emmqgpu3KUSFX9xPKEZ+RS4FWL6yzb47rExgLTNA
         VEjsQCkiVDpIxP1OQjAMjdtirg4pFhdqx9WA/I8pKad+98YtZjKiXk0WDgjSo4sEbraF
         84uE1W/zeENhVuXTZwHnertVtjEOskv8cwoCQ4hW8PnTsozmN6Y/8JJzk9Ka4vJA8DVz
         YOre+i+u0wUbsn4Af5onZp3tGOzT2NeUsbaAs2smDi5zyqiC1JJDG4aEAE6v/tHIxDTs
         3hryouHij5JTH6PeOcZwypTWGYaQP3sLDfOVgcB9gkXJivKRNPHaMPubAS/m97IuVERt
         xnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730147717; x=1730752517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdMHgBAHHz/JsQ7QRBqmTzxvxXRCqQQA1//u8IAS450=;
        b=Pk9DUXBNMkbgIpE5nSIwKOzM3Q8TztLP+ibG2DQrdcwg12cJ76Bpsce5jFjbYpGgdL
         uHozjR7pgmqkVjCzQKNu4Fx2S2brzOTj2H4q/u9xu2zq0ZSazf2uWvx1YhdWdfEs3WBq
         UIebCw5DI23uqkBGv91ZMHVU6cBv50d3u860JVPEWdOS1Xyl/cwiqR0IJOTG5LJ/slmG
         7F9wC/OdgbcbICsG6JNYJA7iMGDAzrN9OKCWBSFYXRAsR0QaX1NC1z20VM+Qlgz8Fo2V
         MKrfGWsUJVzq6/ZCN/zMKDJA9IWfC9frCgi4+iZiXVoz4kTokSVvQLtoBWY4sgQ+coMr
         6e3Q==
X-Gm-Message-State: AOJu0YzU2aUxDtojVx72s4XiRVVlmVSrWzCLmMKAe5txG2HdfgGEFGIm
	btYKmV34mv91xUd929gWxWK5U6m4BIfImeKNcty2AOlME73R0Q1WenJyx2Px
X-Google-Smtp-Source: AGHT+IGmCvgbWcURT+oY1uS08pdGtH5vLRU8rOHs617qtSaF0akxhLKlLgOK+jOLpe8ZHpim+HvkmQ==
X-Received: by 2002:a05:622a:2308:b0:461:4f03:dbf0 with SMTP id d75a77b69052e-4614f03dcb8mr104072521cf.48.1730147716402;
        Mon, 28 Oct 2024 13:35:16 -0700 (PDT)
Received: from localhost.localdomain ([184.147.230.152])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613228c099sm38215791cf.46.2024.10.28.13.35.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Oct 2024 13:35:15 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v5 0/6] cat-file: add remote-object-info to batch-command
Date: Mon, 28 Oct 2024 16:34:51 -0400
Message-ID: <20241028203457.19715-1-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20240628190503.67389-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a continuation of Calvin Wan's (calvinwan@google.com)
patch series [PATCH v5 0/6] cat-file: add --batch-command remote-object-info command at [1].

Sometimes it is useful to get information about an object without having to download
it completely. The server logic for retrieving size has already been implemented and merged in
"a2ba162cda (object-info: support for retrieving object info, 2021-04-20)"[2].
This patch series implement the client option for it.

This patch series add the `remote-object-info` command to `cat-file --batch-command`.
This command allows the client to make an object-info command request to a server
that supports protocol v2. If the server is v2, but does not have
object-info capability, the entire object is fetched and the
relevant object info is returned.

A few questions open for discussions please:

1. In the current implementation, if a user puts `remote-object-info` in protocol v1,
   `cat-file --batch-command` will die. Which way do we prefer? "error and exit (i.e. die)"
   or "warn and wait for new command".

2. Right now, only the size is supported. If the batch command format
   contains objectsize:disk or deltabase, it will die. The question
   is about objecttype. In the current implementation, it will die too.
   But dying on objecttype breaks the default format. We have changed the
   default format to %(objectname) %(objectsize) when remote-object-info is used.
   Any suggestions on this approach?

[1] https://lore.kernel.org/git/20220728230210.2952731-1-calvinwan@google.com/#t
[2] https://git.kernel.org/pub/scm/git/git.git/commit/?id=a2ba162cda2acc171c3e36acbbc854792b093cb7

Changes since V4
================

- Take write_command_and_capabilities() out of fetch_pack.c, put it in a higher level connect.c.

- Move remote-object-info related logic out of fetch_pack.c, and put them in a new file fetch-object-info.c and fetch-object-info.h.

- Add more comments, esapcially where we fallback to downloading pack files and on functions on sending arguments and receiving data.

- Fix typos and formatting errors.

Thank you.

Eric Ju

Calvin Wan (4):
  fetch-pack: refactor packet writing
  fetch-pack: move fetch initialization
  serve: advertise object-info feature
  transport: add client support for object-info

Eric Ju (2):
  cat-file: add declaration of variable i inside its for loop
  cat-file: add remote-object-info to batch-command

 Documentation/git-cat-file.txt         |  24 +-
 Makefile                               |   1 +
 builtin/cat-file.c                     | 119 +++-
 connect.c                              |  34 ++
 connect.h                              |   4 +
 fetch-object-info.c                    |  95 ++++
 fetch-object-info.h                    |  18 +
 fetch-pack.c                           |  51 +-
 fetch-pack.h                           |   2 +
 object-file.c                          |  11 +
 object-store-ll.h                      |   3 +
 serve.c                                |   4 +-
 t/lib-cat-file.sh                      |  16 +
 t/t1006-cat-file.sh                    |  13 +-
 t/t1017-cat-file-remote-object-info.sh | 739 +++++++++++++++++++++++++
 transport-helper.c                     |  11 +-
 transport.c                            |  80 ++-
 transport.h                            |  11 +
 18 files changed, 1165 insertions(+), 71 deletions(-)
 create mode 100644 fetch-object-info.c
 create mode 100644 fetch-object-info.h
 create mode 100644 t/lib-cat-file.sh
 create mode 100755 t/t1017-cat-file-remote-object-info.sh

Range-diff against v4:
1:  20f32be592 ! 1:  f678c6b76f fetch-pack: refactor packet writing
    @@ Commit message
     
         Refactor write_fetch_command_and_capabilities() to be a more general
         purpose function write_command_and_capabilities(), so that it can be
    -    used by both fetch and future command.
    +    used by both fetch and future commands.
     
         Here "command" means the "operations" supported by Git’s wire protocol
         https://git-scm.com/docs/protocol-v2. An example would be a
    @@ Commit message
         the server side such as "object-info" implemented in "a2ba162cda
         (object-info: support for retrieving object info, 2021-04-20)".
     
    -    In a future separate series, we can move
    -    write_command_and_capabilities() to a higher-level file, such as
    +    The new write_command_and_capabilities() function is also moved to
         connect.c, so that it becomes accessible to other commands.
     
         Helped-by: Jonathan Tan <jonathantanmy@google.com>
    @@ Commit message
         Signed-off-by: Calvin Wan <calvinwan@google.com>
         Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
     
    - ## fetch-pack.c ##
    -@@ fetch-pack.c: static int add_haves(struct fetch_negotiator *negotiator,
    - 	return haves_added;
    + ## connect.c ##
    +@@ connect.c: int server_supports(const char *feature)
    + 	return !!server_feature_value(feature, NULL);
      }
      
    --static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
    --						 const struct string_list *server_options)
    -+static void write_command_and_capabilities(struct strbuf *req_buf,
    -+										   const char *command,
    -+										   const struct string_list *server_options)
    - {
    - 	const char *hash_name;
    - 
    --	ensure_server_supports_v2("fetch");
    --	packet_buf_write(req_buf, "command=fetch");
    -+	ensure_server_supports_v2(command);
    -+	packet_buf_write(req_buf, "command=%s", command);
    - 	if (server_supports_v2("agent"))
    - 		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
    - 	if (advertise_sid && server_supports_v2("session-id"))
    -@@ fetch-pack.c: static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
    - 	packet_buf_delim(req_buf);
    - }
    - 
    -+
    -+void send_object_info_request(int fd_out, struct object_info_args *args)
    ++void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
    ++									const struct string_list *server_options)
     +{
    -+	struct strbuf req_buf = STRBUF_INIT;
    ++	const char *hash_name;
    ++	int advertise_sid;
     +
    -+	write_command_and_capabilities(&req_buf, "object-info", args->server_options);
    ++	git_config_get_bool("transfer.advertisesid", &advertise_sid);
     +
    -+	if (unsorted_string_list_has_string(args->object_info_options, "size"))
    -+		packet_buf_write(&req_buf, "size");
    -+
    -+	if (args->oids) {
    -+		for (size_t i = 0; i < args->oids->nr; i++)
    -+			packet_buf_write(&req_buf, "oid %s", oid_to_hex(&args->oids->oid[i]));
    ++	ensure_server_supports_v2(command);
    ++	packet_buf_write(req_buf, "command=%s", command);
    ++	if (server_supports_v2("agent"))
    ++		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
    ++	if (advertise_sid && server_supports_v2("session-id"))
    ++		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
    ++	if (server_options && server_options->nr) {
    ++		ensure_server_supports_v2("server-option");
    ++		for (int i = 0; i < server_options->nr; i++)
    ++			packet_buf_write(req_buf, "server-option=%s",
    ++					 server_options->items[i].string);
     +	}
     +
    -+	packet_buf_flush(&req_buf);
    -+	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
    -+		die_errno(_("unable to write request to remote"));
    -+
    -+	strbuf_release(&req_buf);
    ++	if (server_feature_v2("object-format", &hash_name)) {
    ++		const int hash_algo = hash_algo_by_name(hash_name);
    ++		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
    ++			die(_("mismatched algorithms: client %s; server %s"),
    ++				the_hash_algo->name, hash_name);
    ++		packet_buf_write(req_buf, "object-format=%s", the_hash_algo->name);
    ++	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1) {
    ++		die(_("the server does not support algorithm '%s'"),
    ++			the_hash_algo->name);
    ++	}
    ++	packet_buf_delim(req_buf);
     +}
     +
    + enum protocol {
    + 	PROTO_LOCAL = 1,
    + 	PROTO_FILE,
    +
    + ## connect.h ##
    +@@
    + #ifndef CONNECT_H
    + #define CONNECT_H
    + 
    ++#include "string-list.h"
    + #include "protocol.h"
    + 
    + #define CONNECT_VERBOSE       (1u << 0)
    +@@ connect.h: void check_stateless_delimiter(int stateless_rpc,
    + 			       struct packet_reader *reader,
    + 			       const char *error);
    + 
    ++void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
    ++									const struct string_list *server_options);
    ++
    + #endif
    +
    + ## fetch-pack.c ##
    +@@ fetch-pack.c: static int add_haves(struct fetch_negotiator *negotiator,
    + 	return haves_added;
    + }
    + 
    +-static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
    +-						 const struct string_list *server_options)
    +-{
    +-	const char *hash_name;
    +-
    +-	ensure_server_supports_v2("fetch");
    +-	packet_buf_write(req_buf, "command=fetch");
    +-	if (server_supports_v2("agent"))
    +-		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
    +-	if (advertise_sid && server_supports_v2("session-id"))
    +-		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
    +-	if (server_options && server_options->nr) {
    +-		int i;
    +-		ensure_server_supports_v2("server-option");
    +-		for (i = 0; i < server_options->nr; i++)
    +-			packet_buf_write(req_buf, "server-option=%s",
    +-					 server_options->items[i].string);
    +-	}
    +-
    +-	if (server_feature_v2("object-format", &hash_name)) {
    +-		int hash_algo = hash_algo_by_name(hash_name);
    +-		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
    +-			die(_("mismatched algorithms: client %s; server %s"),
    +-			    the_hash_algo->name, hash_name);
    +-		packet_buf_write(req_buf, "object-format=%s", the_hash_algo->name);
    +-	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1) {
    +-		die(_("the server does not support algorithm '%s'"),
    +-		    the_hash_algo->name);
    +-	}
    +-	packet_buf_delim(req_buf);
    +-}
    +-
      static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
      			      struct fetch_pack_args *args,
      			      const struct ref *wants, struct oidset *common,
2:  75184a49f5 = 2:  e91f01ec4d fetch-pack: move fetch initialization
3:  7d1f341589 = 3:  dfc685c90b serve: advertise object-info feature
4:  e59964f6c9 ! 4:  7da1a1c904 transport: add client support for object-info
    @@ Commit message
         Signed-off-by: Calvin Wan <calvinwan@google.com>
         Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
     
    + ## Makefile ##
    +@@ Makefile: LIB_OBJS += ewah/ewah_rlw.o
    + LIB_OBJS += exec-cmd.o
    + LIB_OBJS += fetch-negotiator.o
    + LIB_OBJS += fetch-pack.o
    ++LIB_OBJS += fetch-object-info.o
    + LIB_OBJS += fmt-merge-msg.o
    + LIB_OBJS += fsck.o
    + LIB_OBJS += fsmonitor.o
    +
    + ## fetch-object-info.c (new) ##
    +@@
    ++#include "git-compat-util.h"
    ++#include "gettext.h"
    ++#include "hex.h"
    ++#include "pkt-line.h"
    ++#include "connect.h"
    ++#include "oid-array.h"
    ++#include "object-store-ll.h"
    ++#include "fetch-object-info.h"
    ++#include "string-list.h"
    ++
    ++/**
    ++ * send_object_info_request sends git-cat-file object-info command and its
    ++ * arguments into the request buffer.
    ++ */
    ++static void send_object_info_request(const int fd_out, struct object_info_args *args)
    ++{
    ++	struct strbuf req_buf = STRBUF_INIT;
    ++
    ++	write_command_and_capabilities(&req_buf, "object-info", args->server_options);
    ++
    ++	if (unsorted_string_list_has_string(args->object_info_options, "size"))
    ++		packet_buf_write(&req_buf, "size");
    ++
    ++	if (args->oids) {
    ++		for (size_t i = 0; i < args->oids->nr; i++)
    ++			packet_buf_write(&req_buf, "oid %s", oid_to_hex(&args->oids->oid[i]));
    ++	}
    ++
    ++	packet_buf_flush(&req_buf);
    ++	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
    ++		die_errno(_("unable to write request to remote"));
    ++
    ++	strbuf_release(&req_buf);
    ++}
    ++
    ++/**
    ++ * fetch_object_info sends git-cat-file object-info command into the request buf
    ++ * and read the results from packets.
    ++ */
    ++int fetch_object_info(const enum protocol_version version, struct object_info_args *args,
    ++					  struct packet_reader *reader, struct object_info *object_info_data,
    ++					  const int stateless_rpc, const int fd_out)
    ++{
    ++	int size_index = -1;
    ++
    ++	switch (version) {
    ++	case protocol_v2:
    ++		if (!server_supports_v2("object-info"))
    ++			return -1;
    ++		if (unsorted_string_list_has_string(args->object_info_options, "size")
    ++				&& !server_supports_feature("object-info", "size", 0))
    ++			return -1;
    ++		send_object_info_request(fd_out, args);
    ++		break;
    ++	case protocol_v1:
    ++	case protocol_v0:
    ++		die(_("wrong protocol version. expected v2"));
    ++	case protocol_unknown_version:
    ++		BUG("unknown protocol version");
    ++	}
    ++
    ++	for (size_t i = 0; i < args->object_info_options->nr; i++) {
    ++		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
    ++			check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");
    ++			return -1;
    ++		}
    ++		if (unsorted_string_list_has_string(args->object_info_options, reader->line)) {
    ++			if (!strcmp(reader->line, "size")) {
    ++				size_index = i;
    ++				for (size_t j = 0; j < args->oids->nr; j++)
    ++					object_info_data[j].sizep = xcalloc(1, sizeof(long));
    ++			}
    ++			continue;
    ++		}
    ++		return -1;
    ++	}
    ++
    ++	for (size_t i = 0; packet_reader_read(reader) == PACKET_READ_NORMAL && i < args->oids->nr; i++){
    ++		struct string_list object_info_values = STRING_LIST_INIT_DUP;
    ++
    ++		string_list_split(&object_info_values, reader->line, ' ', -1);
    ++		if (0 <= size_index) {
    ++			if (!strcmp(object_info_values.items[1 + size_index].string, ""))
    ++				die("object-info: not our ref %s",
    ++					object_info_values.items[0].string);
    ++
    ++			*object_info_data[i].sizep = strtoul(object_info_values.items[1 + size_index].string, NULL, 10);
    ++		}
    ++
    ++		string_list_clear(&object_info_values, 0);
    ++	}
    ++	check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");
    ++
    ++	return 0;
    ++}
    +
    + ## fetch-object-info.h (new) ##
    +@@
    ++#ifndef FETCH_OBJECT_INFO_H
    ++#define FETCH_OBJECT_INFO_H
    ++
    ++#include "pkt-line.h"
    ++#include "protocol.h"
    ++#include "object-store-ll.h"
    ++
    ++struct object_info_args {
    ++	struct string_list *object_info_options;
    ++	const struct string_list *server_options;
    ++	struct oid_array *oids;
    ++};
    ++
    ++int fetch_object_info(enum protocol_version version, struct object_info_args *args,
    ++					  struct packet_reader *reader, struct object_info *object_info_data,
    ++					  int stateless_rpc, int fd_out);
    ++
    ++#endif /* FETCH_OBJECT_INFO_H */
    +
      ## fetch-pack.c ##
    -@@ fetch-pack.c: static void write_command_and_capabilities(struct strbuf *req_buf,
    - 	packet_buf_delim(req_buf);
    - }
    - 
    --
    - void send_object_info_request(int fd_out, struct object_info_args *args)
    - {
    - 	struct strbuf req_buf = STRBUF_INIT;
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
      	if (args->depth > 0 || args->deepen_since || args->deepen_not)
      		args->deepen = 1;
    @@ fetch-pack.h: struct fetch_pack_args {
      
      	/*
      	 * Indicate that the remote of this request is a promisor remote. The
    -@@ fetch-pack.h: struct fetch_pack_args {
    - 	unsigned connectivity_checked:1;
    - };
    - 
    -+struct object_info_args {
    -+	struct string_list *object_info_options;
    -+	const struct string_list *server_options;
    -+	struct oid_array *oids;
    -+};
    -+
    - /*
    -  * sought represents remote references that should be updated from.
    -  * On return, the names that were found on the remote will have been
    -@@ fetch-pack.h: int report_unmatched_refs(struct ref **sought, int nr_sought);
    -  */
    - int fetch_pack_fsck_objects(void);
    - 
    -+void send_object_info_request(int fd_out, struct object_info_args *args);
    -+
    - #endif
     
      ## transport-helper.c ##
     @@ transport-helper.c: static int fetch_refs(struct transport *transport,
    @@ transport-helper.c: static int fetch_refs(struct transport *transport,
      	 * If we reach here, then the server, the client, and/or the transport
     -	 * helper does not support protocol v2. --negotiate-only requires
     -	 * protocol v2.
    -+	 * helper does not support protocol v2. --negotiate-only and cat-file remote-object-info
    -+	 * require protocol v2.
    ++	 * helper does not support protocol v2. --negotiate-only and cat-file
    ++	 * remote-object-info require protocol v2.
      	 */
      	if (data->transport_options.acked_commits) {
      		warning(_("--negotiate-only requires protocol v2"));
    @@ transport-helper.c: static int fetch_refs(struct transport *transport,
      		if (!(to_fetch[i]->status & REF_STATUS_UPTODATE))
     
      ## transport.c ##
    -@@ transport.c: static struct ref *handshake(struct transport *transport, int for_push,
    - 	return refs;
    - }
    - 
    -+static int fetch_object_info(struct transport *transport, struct object_info *object_info_data)
    -+{
    -+	int size_index = -1;
    -+	struct git_transport_data *data = transport->data;
    -+	struct object_info_args args = { 0 };
    -+	struct packet_reader reader;
    -+
    -+	args.server_options = transport->server_options;
    -+	args.object_info_options = transport->smart_options->object_info_options;
    -+	args.oids = transport->smart_options->object_info_oids;
    -+
    -+	connect_setup(transport, 0);
    -+	packet_reader_init(&reader, data->fd[0], NULL, 0,
    -+			PACKET_READ_CHOMP_NEWLINE |
    -+			PACKET_READ_GENTLE_ON_EOF |
    -+			PACKET_READ_DIE_ON_ERR_PACKET);
    -+	data->version = discover_version(&reader);
    -+
    -+	transport->hash_algo = reader.hash_algo;
    -+
    -+	switch (data->version) {
    -+	case protocol_v2:
    -+		if (!server_supports_v2("object-info"))
    -+			return -1;
    -+		if (unsorted_string_list_has_string(args.object_info_options, "size")
    -+				&& !server_supports_feature("object-info", "size", 0))
    -+			return -1;
    -+		send_object_info_request(data->fd[1], &args);
    -+		break;
    -+	case protocol_v1:
    -+	case protocol_v0:
    -+		die(_("wrong protocol version. expected v2"));
    -+	case protocol_unknown_version:
    -+		BUG("unknown protocol version");
    -+	}
    -+
    -+	for (size_t i = 0; i < args.object_info_options->nr; i++) {
    -+		if (packet_reader_read(&reader) != PACKET_READ_NORMAL) {
    -+			check_stateless_delimiter(transport->stateless_rpc, &reader, "stateless delimiter expected");
    -+			return -1;
    -+		}
    -+		if (unsorted_string_list_has_string(args.object_info_options, reader.line)) {
    -+			if (!strcmp(reader.line, "size")) {
    -+				size_index = i;
    -+				for (size_t j = 0; j < args.oids->nr; j++)
    -+					object_info_data[j].sizep = xcalloc(1, sizeof(long));
    -+			}
    -+			continue;
    -+		}
    -+		return -1;
    -+	}
    -+
    -+	for (size_t i = 0; packet_reader_read(&reader) == PACKET_READ_NORMAL && i < args.oids->nr; i++){
    -+		struct string_list object_info_values = STRING_LIST_INIT_DUP;
    -+
    -+		string_list_split(&object_info_values, reader.line, ' ', -1);
    -+		if (0 <= size_index) {
    -+			if (!strcmp(object_info_values.items[1 + size_index].string, ""))
    -+				die("object-info: not our ref %s",
    -+					object_info_values.items[0].string);
    -+
    -+			*object_info_data[i].sizep = strtoul(object_info_values.items[1 + size_index].string, NULL, 10);
    -+		}
    -+
    -+		string_list_clear(&object_info_values, 0);
    -+	}
    -+	check_stateless_delimiter(transport->stateless_rpc, &reader, "stateless delimiter expected");
    -+
    -+	return 0;
    -+}
    -+
    - static struct ref *get_refs_via_connect(struct transport *transport, int for_push,
    - 					struct transport_ls_refs_options *options)
    - {
    +@@
    + #include "hook.h"
    + #include "pkt-line.h"
    + #include "fetch-pack.h"
    ++#include "fetch-object-info.h"
    + #include "remote.h"
    + #include "connect.h"
    + #include "send-pack.h"
     @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
      	struct ref *refs = NULL;
      	struct fetch_pack_args args;
    @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
     +		&& transport->smart_options->object_info
     +		&& transport->smart_options->object_info_oids->nr > 0) {
     +		struct ref *ref_itr = object_info_refs = alloc_ref("");
    ++		struct packet_reader reader;
    ++		struct object_info_args obj_info_args = { 0 };
     +
    -+		if (!fetch_object_info(transport, data->options.object_info_data))
    -+			goto cleanup;
    ++		obj_info_args.server_options = transport->server_options;
    ++		obj_info_args.object_info_options = transport->smart_options->object_info_options;
    ++		obj_info_args.oids = transport->smart_options->object_info_oids;
    ++
    ++		connect_setup(transport, 0);
    ++		packet_reader_init(&reader, data->fd[0], NULL, 0,
    ++				PACKET_READ_CHOMP_NEWLINE |
    ++				PACKET_READ_GENTLE_ON_EOF |
    ++				PACKET_READ_DIE_ON_ERR_PACKET);
    ++
    ++		data->version = discover_version(&reader);
    ++		transport->hash_algo = reader.hash_algo;
     +
    ++		if (!fetch_object_info(data->version, &obj_info_args, &reader,
    ++			data->options.object_info_data, transport->stateless_rpc,
    ++			data->fd[1])) {
    ++			/*
    ++			 * If the code reaches here, fetch_object_info is successful and
    ++			 * remote object info are retrieved from packets (i.e. without
    ++			 * downloading the objects).
    ++			 */
    ++			goto cleanup;
    ++		}
    + 
    +-	if (!data->finished_handshake) {
    +-		int i;
    ++		/*
    ++		 * If the code reaches here, it means we can't retrieve object info from
    ++		 * packets, and we will fallback to downland the pack files.
    ++		 * We set quiet and no_progress to be true, so that the internal call to
    ++		 * fetch-pack is less verbose.
    ++		 */
     +		args.object_info_data = data->options.object_info_data;
     +		args.quiet = 1;
     +		args.no_progress = 1;
    ++
    ++		/*
    ++		 * Allocate memory for object info data according to oids.
    ++		 * The actual results will be retrieved later from the downloaded
    ++		 * pack files.
    ++		 */
     +		for (size_t i = 0; i < transport->smart_options->object_info_oids->nr; i++) {
     +			ref_itr->old_oid = transport->smart_options->object_info_oids->oid[i];
     +			ref_itr->exact_oid = 1;
    @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
     +				ref_itr->next = NULL;
     +			else
     +				ref_itr->next = alloc_ref("");
    - 
    --	if (!data->finished_handshake) {
    --		int i;
    ++
     +			ref_itr = ref_itr->next;
     +		}
     +
    @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
      			  &transport->pack_lockfiles, data->version);
      
      	data->finished_handshake = 0;
    ++
    ++	/* Retrieve object info data from the downloaded pack files */
     +	if (args.object_info) {
     +		struct ref *ref_cpy_reader = object_info_refs;
     +		for (int i = 0; ref_cpy_reader; i++) {
    @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
      	data->options.self_contained_and_connected =
      		args.self_contained_and_connected;
      	data->options.connectivity_checked = args.connectivity_checked;
    - 
    --	if (!refs)
    -+	if (!refs && !args.object_info)
    - 		ret = -1;
    - 	if (report_unmatched_refs(to_fetch, nr_heads))
    +@@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
      		ret = -1;
      
      cleanup:
5:  4443e5e408 = 5:  2107bfc7ca cat-file: add declaration of variable i inside its for loop
6:  c777a4dd84 ! 6:  740d629626 cat-file: add remote-object-info to batch-command
    @@
      ## Metadata ##
    -Author: Calvin Wan <calvinwan@google.com>
    +Author: Eric Ju <eric.peijian@gmail.com>
     
      ## Commit message ##
         cat-file: add remote-object-info to batch-command
    @@ object-store-ll.h: int for_each_object_in_pack(struct packed_git *p,
     
      ## t/lib-cat-file.sh (new) ##
     @@
    -+# Library of git-cat-file related functions.
    ++# Library of git-cat-file related tests.
     +
     +# Print a string without a trailing newline
     +echo_without_newline () {
-- 
2.47.0

