Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B3E16A930
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 01:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727314762; cv=none; b=WPCzzc8wFwLnqWWSSQvS1KzmA7NzlK6/p1pZULM+KDVhYbxipnp7wNte4GZOQbftitBID+eWuSmSjYVxiLavYG+tZRvezsLteb0afeTmDnW7xD3A6ZbKuUde4DW2ix1ass9mD4jkHLF7L4PLgxLidT9VLlukldcFF1WWaFaYo7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727314762; c=relaxed/simple;
	bh=F5/Tr6P/R8YyEiwdleaZV8jjYT8/7+Y6v0k9osx8tIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kA7qAj1pBUdErYPL8CjQcAOR3zCpMCr0D0x3LmYujIuO0PP1dEO1MTEEiBQVnu7szyWU5Xw+TYlJ8GijlSjMQXQf29DXBu1VEjenlxCKgSLtxV3/WKlXPfLgLvcEqpyEalT09GirQwYj8LN2zrhPHjAa3J4U9/7mj/UBl71lTug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoSmYvMN; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoSmYvMN"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a9ae0e116cso45380485a.1
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 18:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727314758; x=1727919558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3g2MkFYRsl9ntYj/yRcZCoCaqRvORxDsUe01pln7tIk=;
        b=NoSmYvMN235IoQ6yWE0p/Erfi2lFo6D810Dw66RfltTPgLfbMYgDiNL/37jbCL+pZS
         KIY6Pf7XpbQTg1Jq4JjDPuWeyEk64HEt/T1AestIJ3RO3W4UOKL8myVLzaHB60ohOIPu
         2sbJmAXgRePblBexyyfJKP2ISEuKBJ8cP99qKyuRc7q7Bm5gkGNgm/9QXkt//s28Ku37
         WgNnJKM+N034paZiAcU9PBsqqj8RLe9syTduhyHDfrTzrU6JW2qHGc5WPNp/Vyh7BkSZ
         RnklW/CWut4Ipq5ksBkmmu86/V3WQZdQUaR+85k59NLEa3u62nMTPMmuOBPY5yTtIibo
         GINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727314758; x=1727919558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3g2MkFYRsl9ntYj/yRcZCoCaqRvORxDsUe01pln7tIk=;
        b=lbOMvoofr2+LAR8WEwHnMOVBBHDNOPnHkjPEZnVpEkQUp8ckqHA4x2X/T7EySwgwhW
         hB2TlRCOVgQF6OTIh8xiZUjKMVlSslnrDsUn1xuqnZm2GEqzprlfC6my9src2YAWFct+
         mmc8GgEcuuujYumXNde2vpkic3GMAeNG6ssrDrEtuJNscndzYLT4xU02BdkuAtScbx+z
         COPB/OOmsjq44d1Q94jJM+6IVC4UAFCIfrquBIYUBs4WWDFx5+mG5NEM0lMFjJhLsDNP
         Bkb9+rMYgwg7nYew4JekvpzRhg7UjByYVhrvy5ScmO98ho8ywpYWsH+qg5ccSc5taNny
         QAxA==
X-Gm-Message-State: AOJu0YwCQiH/NdOgexSgeage8CRPyvl+cL1JWXb6GuCqA8psTlXtFeJq
	ItprknSRVp1VZPnTMurUUihIpykDOFbbP80l2n6+rEZePD7xyIi9Lfhl/YTl
X-Google-Smtp-Source: AGHT+IF3++d8IVR8jtIlfBqO6Pv99pgaCXPyi7nVcv20roB4hrmcpPKr7ezIUAhXZDPSS8Jco6XLTA==
X-Received: by 2002:a05:620a:1a96:b0:7ac:b3bf:c30c with SMTP id af79cd13be357-7ace744d7acmr739979685a.45.1727314757526;
        Wed, 25 Sep 2024 18:39:17 -0700 (PDT)
Received: from localhost.localdomain ([142.188.15.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde49acebsm227789985a.0.2024.09.25.18.39.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Sep 2024 18:39:16 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v3 0/6] cat-file: add remote-object-info to batch-command
Date: Wed, 25 Sep 2024 21:38:50 -0400
Message-ID: <20240926013856.35527-1-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.46.0
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

V1 of the patch series can be found here:
https://lore.kernel.org/git/20240628190503.67389-1-eric.peijian@gmail.com/

v2 of the patch series can be found here:
https://lore.kernel.org/git/20240720034337.57125-1-eric.peijian@gmail.com/

Changes since V2
================

- Fix typos and formatting errors

- Add more information in commit messages

- Confirm that new logics in transport.c, fetch-pack.c and transport-helper.c
  are covered in the new test file t1017-cat-file-remote-object-info.sh

Thank you.

Eric Ju

Calvin Wan (5):
  fetch-pack: refactor packet writing
  fetch-pack: move fetch initialization
  serve: advertise object-info feature
  transport: add client support for object-info
  cat-file: add remote-object-info to batch-command

Eric Ju (1):
  cat-file: add declaration of variable i inside its for loop

 Documentation/git-cat-file.txt         |  22 +-
 builtin/cat-file.c                     | 119 +++-
 fetch-pack.c                           |  49 +-
 fetch-pack.h                           |  10 +
 object-file.c                          |  11 +
 object-store-ll.h                      |   3 +
 serve.c                                |   4 +-
 t/t1017-cat-file-remote-object-info.sh | 750 +++++++++++++++++++++++++
 transport-helper.c                     |   8 +-
 transport.c                            | 116 +++-
 transport.h                            |  11 +
 11 files changed, 1070 insertions(+), 33 deletions(-)
 create mode 100755 t/t1017-cat-file-remote-object-info.sh

Range-diff against v2:
1:  f90a74cbb2 ! 1:  b570dee186 fetch-pack: refactor packet writing
    @@ Metadata
      ## Commit message ##
         fetch-pack: refactor packet writing
     
    -    A subsequent patch needs to write capabilities for another command.
         Refactor write_fetch_command_and_capabilities() to be a more general
         purpose function write_command_and_capabilities(), so that it can be
         used by both fetch and future command.
    @@ Commit message
         the server side such as "object-info" implemented in "a2ba162cda
         (object-info: support for retrieving object info, 2021-04-20)".
     
    +    In a future separate series, we can move
    +    write_command_and_capabilities() to a higher-level file, such as
    +    connect.c, so that it becomes accessible to other commands.
    +
         Helped-by: Jonathan Tan <jonathantanmy@google.com>
         Helped-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Calvin Wan <calvinwan@google.com>
    @@ fetch-pack.c: static int add_haves(struct fetch_negotiator *negotiator,
     -static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
     -						 const struct string_list *server_options)
     +static void write_command_and_capabilities(struct strbuf *req_buf,
    -+						 const struct string_list *server_options, const char* command)
    ++										   const char *command,
    ++										   const struct string_list *server_options)
      {
      	const char *hash_name;
      
    @@ fetch-pack.c: static int add_haves(struct fetch_negotiator *negotiator,
      	if (server_supports_v2("agent"))
      		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
      	if (advertise_sid && server_supports_v2("session-id"))
    +@@ fetch-pack.c: static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
    + 	packet_buf_delim(req_buf);
    + }
    + 
    ++
    ++void send_object_info_request(int fd_out, struct object_info_args *args)
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
    + static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
    + 			      struct fetch_pack_args *args,
    + 			      const struct ref *wants, struct oidset *common,
     @@ fetch-pack.c: static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
      	int done_sent = 0;
      	struct strbuf req_buf = STRBUF_INIT;
      
     -	write_fetch_command_and_capabilities(&req_buf, args->server_options);
    -+	write_command_and_capabilities(&req_buf, args->server_options, "fetch");
    ++	write_command_and_capabilities(&req_buf, "fetch", args->server_options);
      
      	if (args->use_thin_pack)
      		packet_buf_write(&req_buf, "thin-pack");
    @@ fetch-pack.c: void negotiate_using_fetch(const struct oid_array *negotiation_tip
      					   negotiation_round);
      		strbuf_reset(&req_buf);
     -		write_fetch_command_and_capabilities(&req_buf, server_options);
    -+		write_command_and_capabilities(&req_buf, server_options, "fetch");
    ++		write_command_and_capabilities(&req_buf, "fetch", server_options);
      
      		packet_buf_write(&req_buf, "wait-for-done");
      
2:  64ec1ab9f9 = 2:  e8777e8776 fetch-pack: move fetch initialization
3:  68c35ab6c1 = 3:  d00d19cf2c serve: advertise object-info feature
4:  3e5a65ab46 ! 4:  3e1773910c transport: add client support for object-info
    @@ fetch-pack.c: static void write_command_and_capabilities(struct strbuf *req_buf,
      	packet_buf_delim(req_buf);
      }
      
    -+void send_object_info_request(int fd_out, struct object_info_args *args)
    -+{
    -+	struct strbuf req_buf = STRBUF_INIT;
    -+
    -+	write_command_and_capabilities(&req_buf, args->server_options, "object-info");
    -+
    -+	if (unsorted_string_list_has_string(args->object_info_options, "size"))
    -+		packet_buf_write(&req_buf, "size");
    -+
    -+	if (args->oids) {
    -+		for (size_t i = 0; i < args->oids->nr; i++)
    -+			packet_buf_write(&req_buf, "oid %s", oid_to_hex(&args->oids->oid[i]));
    -+	}
    -+
    -+	packet_buf_flush(&req_buf);
    -+	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
    -+		die_errno(_("unable to write request to remote"));
    -+
    -+	strbuf_release(&req_buf);
    -+}
    -+
    - static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
    - 			      struct fetch_pack_args *args,
    - 			      const struct ref *wants, struct oidset *common,
    +-
    + void send_object_info_request(int fd_out, struct object_info_args *args)
    + {
    + 	struct strbuf req_buf = STRBUF_INIT;
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
      	if (args->depth > 0 || args->deepen_since || args->deepen_not)
      		args->deepen = 1;
    @@ transport-helper.c: static int fetch_refs(struct transport *transport,
      		warning(_("--negotiate-only requires protocol v2"));
      		return -1;
      	}
    -+	if (transport->smart_options->object_info) {
    -+		// fail the command explicitly to avoid further commands input
    -+		die(_("remote-object-info requires protocol v2"));
    -+	}
      
    ++	/* fail the command explicitly to avoid further commands input. */
    ++	if (transport->smart_options->object_info)
    ++		die(_("remote-object-info requires protocol v2"));
    ++
      	if (!data->get_refs_list_called)
      		get_refs_list_using_list(transport, 0);
    + 
     
      ## transport.c ##
     @@ transport.c: static struct ref *handshake(struct transport *transport, int for_push,
    @@ transport.c: static struct ref *handshake(struct transport *transport, int for_p
     +		if (!server_supports_v2("object-info"))
     +			return -1;
     +		if (unsorted_string_list_has_string(args.object_info_options, "size")
    -+				&& !server_supports_feature("object-info", "size", 0)) {
    ++				&& !server_supports_feature("object-info", "size", 0))
     +			return -1;
    -+		}
     +		send_object_info_request(data->fd[1], &args);
     +		break;
     +	case protocol_v1:
    @@ transport.c: static struct ref *handshake(struct transport *transport, int for_p
     +		if (unsorted_string_list_has_string(args.object_info_options, reader.line)) {
     +			if (!strcmp(reader.line, "size")) {
     +				size_index = i;
    -+				for (size_t j = 0; j < args.oids->nr; j++) {
    ++				for (size_t j = 0; j < args.oids->nr; j++)
     +					object_info_data[j].sizep = xcalloc(1, sizeof(long));
    -+				}
     +			}
     +			continue;
     +		}
    @@ transport.c: static struct ref *handshake(struct transport *transport, int for_p
     +					object_info_values.items[0].string);
     +
     +			*object_info_data[i].sizep = strtoul(object_info_values.items[1 + size_index].string, NULL, 10);
    -+
     +		}
     +
     +		string_list_clear(&object_info_values, 0);
    @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
     +			ref_itr->old_oid = transport->smart_options->object_info_oids->oid[i];
     +			ref_itr->exact_oid = 1;
     +			if (i == transport->smart_options->object_info_oids->nr - 1)
    -+				/* last element, no need to allocat to next */
    ++				/* last element, no need to allocate to next */
     +				ref_itr -> next = NULL;
     +			else
     +				ref_itr->next = alloc_ref("");
    @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
     +	if (args.object_info) {
     +		struct ref *ref_cpy_reader = object_info_refs;
     +		for (int i = 0; ref_cpy_reader; i++) {
    -+			oid_object_info_extended(the_repository, &ref_cpy_reader->old_oid, &args.object_info_data[i], OBJECT_INFO_LOOKUP_REPLACE);
    ++			oid_object_info_extended(the_repository, &ref_cpy_reader->old_oid,
    ++				&args.object_info_data[i], OBJECT_INFO_LOOKUP_REPLACE);
     +			ref_cpy_reader = ref_cpy_reader->next;
     +		}
     +	}
5:  eb1c87f3fd = 5:  bb110fbc93 cat-file: add declaration of variable i inside its for loop
6:  e33c1f93bc ! 6:  6dd143c164 cat-file: add remote-object-info to batch-command
    @@ Documentation/git-cat-file.txt: info <object>::
     +	Print object info for object references `<object>` at specified <remote> without
     +	downloading objects from remote. If the object-info capability is not
     +	supported by the server, the objects will be downloaded instead.
    -+	Error when no object references is provided.
    ++	Error when no object references are provided.
     +	This command may be combined with `--buffer`.
     +
      flush::
    @@ Documentation/git-cat-file.txt: newline. The available atoms are:
      
      If no format is specified, the default format is `%(objectname)
     -%(objecttype) %(objectsize)`.
    -+%(objecttype) %(objectsize)`, except remote-object-info command who uses
    ++%(objecttype) %(objectsize)`, except for `remote-object-info` commands which use
     +`%(objectname) %(objectsize)` for now because "%(objecttype)" is not supported yet.
     +When "%(objecttype)" is supported, default format should be unified.
      
    @@ Documentation/git-cat-file.txt: scripting purposes.
      CAVEATS
      -------
      
    -+Note that since objecttype, objectsize:disk and deltabase are currently not supported by the
    -+remote-object-info, git will error and exit when they are in the format string.
    -+
    ++Note that since %(objecttype), %(objectsize:disk) and %(deltabase) are currently not supported by the
    ++`remote-object-info` command, we will error and exit when they are in the format string.
     +
      Note that the sizes of objects on disk are reported accurately, but care
      should be taken in drawing conclusions about which refs or objects are
    @@ builtin/cat-file.c: static void batch_one_object(const char *obj_name,
     +		CALLOC_ARRAY(remote_object_info, object_info_oids.nr);
     +		gtransport->smart_options->object_info = 1;
     +		gtransport->smart_options->object_info_oids = &object_info_oids;
    -+		/*
    -+		 * 'size' is the only option currently supported.
    -+		 * Other options that are passed in the format will exit with error.
    -+		 */
    -+		if (strstr(opt->format, "%(objectsize)")) {
    -+			string_list_append(&object_info_options, "size");
    -+		} else {
    ++
    ++		/* 'objectsize' is the only option currently supported */
    ++		if (!strstr(opt->format, "%(objectsize)"))
     +			die(_("%s is currently not supported with remote-object-info"), opt->format);
    -+		}
    ++
    ++		string_list_append(&object_info_options, "size");
    ++
     +		if (object_info_options.nr > 0) {
     +			gtransport->smart_options->object_info_options = &object_info_options;
     +			gtransport->smart_options->object_info_data = remote_object_info;
    @@ builtin/cat-file.c: static void parse_cmd_info(struct batch_options *opt,
     +			data->size = *remote_object_info[i].sizep;
     +		} else {
     +			/*
    -+			 * When reaching here, it means remote-object-info can't retrive
    -+			 * infomation from server withoug downloading them, and the objects
    ++			 * When reaching here, it means remote-object-info can't retrieve
    ++			 * information from server without downloading them, and the objects
     +			 * have been fetched to client already.
    -+			 * Print the infomation using the logic for local objects.
    ++			 * Print the information using the logic for local objects.
     +			 */
     +			data->skip_object_info = 0;
     +		}
    @@ builtin/cat-file.c: static void parse_cmd_info(struct batch_options *opt,
      		struct strbuf *output,
      		struct expand_data *data,
     @@ builtin/cat-file.c: static const struct parse_cmd {
    - 	parse_cmd_fn_t fn;
    - 	unsigned takes_args;
      } commands[] = {
    --	{ "contents", parse_cmd_contents, 1},
    --	{ "info", parse_cmd_info, 1},
    --	{ "flush", NULL, 0},
    -+	{ "contents", parse_cmd_contents, 1 },
    -+	{ "info", parse_cmd_info, 1 },
    -+	{ "remote-object-info", parse_cmd_remote_object_info, 1 },
    -+	{ "flush", NULL, 0 },
    + 	{ "contents", parse_cmd_contents, 1},
    + 	{ "info", parse_cmd_info, 1},
    ++	{ "remote-object-info", parse_cmd_remote_object_info, 1},
    + 	{ "flush", NULL, 0},
      };
      
    - static void batch_objects_command(struct batch_options *opt,
     
      ## object-file.c ##
     @@ object-file.c: int read_loose_object(const char *path,
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +tag_size=$(strlen "$tag_content")
     +
     +set_transport_variables () {
    -+	hello_sha1=$(echo_without_newline "$hello_content" | git hash-object --stdin)
    -+	tree_sha1=$(git -C "$1" write-tree)
    -+	commit_sha1=$(echo_without_newline "$commit_message" | git -C "$1" commit-tree $tree_sha1)
    -+	tag_sha1=$(echo_without_newline "$tag_content" | git -C "$1" hash-object -t tag --stdin -w)
    ++	hello_oid=$(echo_without_newline "$hello_content" | git hash-object --stdin)
    ++	tree_oid=$(git -C "$1" write-tree)
    ++	commit_oid=$(echo_without_newline "$commit_message" | git -C "$1" commit-tree $tree_oid)
    ++	tag_oid=$(echo_without_newline "$tag_content" | git -C "$1" hash-object -t tag --stdin -w)
     +	tag_size=$(strlen "$tag_content")
     +}
     +
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +# Since "%(objecttype)" is currently not supported by the command remote-object-info ,
     +# the filters are set to "%(objectname) %(objectsize)" in some test cases.
     +
    -+# Test --batch-command remote-object-info with 'git://' transport
    ++# Test --batch-command remote-object-info with 'git://' transport with
    ++# transfer.advertiseobjectinfo set to true, i.e. server has object-info capability
     +. "$TEST_DIRECTORY"/lib-git-daemon.sh
     +start_git_daemon --export-all --enable=receive-pack
     +daemon_parent=$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +		cd "$daemon_parent/daemon_client_empty" &&
     +
     +		# These results prove remote-object-info can get object info from the remote
    -+		echo "$hello_sha1 $hello_size" >expect &&
    -+		echo "$tree_sha1 $tree_size" >>expect &&
    -+		echo "$commit_sha1 $commit_size" >>expect &&
    -+		echo "$tag_sha1 $tag_size" >>expect &&
    ++		echo "$hello_oid $hello_size" >expect &&
    ++		echo "$tree_oid $tree_size" >>expect &&
    ++		echo "$commit_oid $commit_size" >>expect &&
    ++		echo "$tag_oid $tag_size" >>expect &&
     +
     +		# These results prove remote-object-info did not download objects from the remote
    -+		echo "$hello_sha1 missing" >>expect &&
    -+		echo "$tree_sha1 missing" >>expect &&
    -+		echo "$commit_sha1 missing" >>expect &&
    -+		echo "$tag_sha1 missing" >>expect &&
    ++		echo "$hello_oid missing" >>expect &&
    ++		echo "$tree_oid missing" >>expect &&
    ++		echo "$commit_oid missing" >>expect &&
    ++		echo "$tag_oid missing" >>expect &&
     +
     +		git cat-file --batch-command="%(objectname) %(objectsize)" >actual <<-EOF &&
    -+		remote-object-info "$GIT_DAEMON_URL/parent" $hello_sha1
    -+		remote-object-info "$GIT_DAEMON_URL/parent" $tree_sha1
    -+		remote-object-info "$GIT_DAEMON_URL/parent" $commit_sha1
    -+		remote-object-info "$GIT_DAEMON_URL/parent" $tag_sha1
    -+		info $hello_sha1
    -+		info $tree_sha1
    -+		info $commit_sha1
    -+		info $tag_sha1
    ++		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
    ++		remote-object-info "$GIT_DAEMON_URL/parent" $tree_oid
    ++		remote-object-info "$GIT_DAEMON_URL/parent" $commit_oid
    ++		remote-object-info "$GIT_DAEMON_URL/parent" $tag_oid
    ++		info $hello_oid
    ++		info $tree_oid
    ++		info $commit_oid
    ++		info $tag_oid
     +		EOF
     +		test_cmp expect actual
     +	)
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +		cd "$daemon_parent/daemon_client_empty" &&
     +
     +		# These results prove remote-object-info can get object info from the remote
    -+		echo "$hello_sha1 $hello_size" >expect &&
    -+		echo "$tree_sha1 $tree_size" >>expect &&
    -+		echo "$commit_sha1 $commit_size" >>expect &&
    -+		echo "$tag_sha1 $tag_size" >>expect &&
    ++		echo "$hello_oid $hello_size" >expect &&
    ++		echo "$tree_oid $tree_size" >>expect &&
    ++		echo "$commit_oid $commit_size" >>expect &&
    ++		echo "$tag_oid $tag_size" >>expect &&
     +
     +		# These results prove remote-object-info did not download objects from the remote
    -+		echo "$hello_sha1 missing" >>expect &&
    -+		echo "$tree_sha1 missing" >>expect &&
    -+		echo "$commit_sha1 missing" >>expect &&
    -+		echo "$tag_sha1 missing" >>expect &&
    ++		echo "$hello_oid missing" >>expect &&
    ++		echo "$tree_oid missing" >>expect &&
    ++		echo "$commit_oid missing" >>expect &&
    ++		echo "$tag_oid missing" >>expect &&
     +
     +		git cat-file --batch-command="%(objectname) %(objectsize)" >actual <<-EOF &&
    -+		remote-object-info "$GIT_DAEMON_URL/parent" $hello_sha1 $tree_sha1 $commit_sha1 $tag_sha1
    -+		info $hello_sha1
    -+		info $tree_sha1
    -+		info $commit_sha1
    -+		info $tag_sha1
    ++		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid $tree_oid $commit_oid $tag_oid
    ++		info $hello_oid
    ++		info $tree_oid
    ++		info $commit_oid
    ++		info $tag_oid
     +		EOF
     +		test_cmp expect actual
     +	)
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +		set_transport_variables "$daemon_parent" &&
     +		cd "$daemon_parent/daemon_client_empty" &&
     +
    -+		echo "$hello_sha1 $hello_size" >expect &&
    -+		echo "$tree_sha1 $tree_size" >>expect &&
    -+		echo "$commit_sha1 $commit_size" >>expect &&
    -+		echo "$tag_sha1 $tag_size" >>expect &&
    ++		echo "$hello_oid $hello_size" >expect &&
    ++		echo "$tree_oid $tree_size" >>expect &&
    ++		echo "$commit_oid $commit_size" >>expect &&
    ++		echo "$tag_oid $tag_size" >>expect &&
     +		GIT_TRACE_PACKET=1 git cat-file --batch-command >actual <<-EOF &&
    -+		remote-object-info "$GIT_DAEMON_URL/parent" $hello_sha1 $tree_sha1
    -+		remote-object-info "$GIT_DAEMON_URL/parent" $commit_sha1 $tag_sha1
    ++		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid $tree_oid
    ++		remote-object-info "$GIT_DAEMON_URL/parent" $commit_oid $tag_oid
     +		EOF
     +		test_cmp expect actual
     +	)
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +		cd "$daemon_parent/daemon_client_empty" &&
     +
     +		# These results prove remote-object-info can get object info from the remote
    -+		echo "$hello_sha1 $hello_size" >expect &&
    -+		echo "$tree_sha1 $tree_size" >>expect &&
    -+		echo "$commit_sha1 $commit_size" >>expect &&
    -+		echo "$tag_sha1 $tag_size" >>expect &&
    ++		echo "$hello_oid $hello_size" >expect &&
    ++		echo "$tree_oid $tree_size" >>expect &&
    ++		echo "$commit_oid $commit_size" >>expect &&
    ++		echo "$tag_oid $tag_size" >>expect &&
     +
     +		# These results prove remote-object-info did not download objects from the remote
    -+		echo "$hello_sha1 missing" >>expect &&
    -+		echo "$tree_sha1 missing" >>expect &&
    -+		echo "$commit_sha1 missing" >>expect &&
    -+		echo "$tag_sha1 missing" >>expect &&
    ++		echo "$hello_oid missing" >>expect &&
    ++		echo "$tree_oid missing" >>expect &&
    ++		echo "$commit_oid missing" >>expect &&
    ++		echo "$tag_oid missing" >>expect &&
     +
     +		git cat-file --batch-command="%(objectname) %(objectsize)" --buffer >actual <<-EOF &&
    -+		remote-object-info "$GIT_DAEMON_URL/parent" $hello_sha1 $tree_sha1
    -+		remote-object-info "$GIT_DAEMON_URL/parent" $commit_sha1 $tag_sha1
    -+		info $hello_sha1
    -+		info $tree_sha1
    -+		info $commit_sha1
    -+		info $tag_sha1
    ++		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid $tree_oid
    ++		remote-object-info "$GIT_DAEMON_URL/parent" $commit_oid $tag_oid
    ++		info $hello_oid
    ++		info $tree_oid
    ++		info $commit_oid
    ++		info $tag_oid
     +		flush
     +		EOF
     +		test_cmp expect actual
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +		set_transport_variables "$daemon_parent" &&
     +		cd "$daemon_parent/daemon_client_empty" &&
     +
    -+		printf "%s\0" "$hello_sha1 $hello_size" >expect &&
    -+		printf "%s\0" "$tree_sha1 $tree_size" >>expect &&
    -+		printf "%s\0" "$commit_sha1 $commit_size" >>expect &&
    -+		printf "%s\0" "$tag_sha1 $tag_size" >>expect &&
    -+
    -+		printf "%s\0" "$hello_sha1 missing" >>expect &&
    -+		printf "%s\0" "$tree_sha1 missing" >>expect &&
    -+		printf "%s\0" "$commit_sha1 missing" >>expect &&
    -+		printf "%s\0" "$tag_sha1 missing" >>expect &&
    -+
    -+		batch_input="remote-object-info $GIT_DAEMON_URL/parent $hello_sha1 $tree_sha1
    -+remote-object-info $GIT_DAEMON_URL/parent $commit_sha1 $tag_sha1
    -+info $hello_sha1
    -+info $tree_sha1
    -+info $commit_sha1
    -+info $tag_sha1
    ++		printf "%s\0" "$hello_oid $hello_size" >expect &&
    ++		printf "%s\0" "$tree_oid $tree_size" >>expect &&
    ++		printf "%s\0" "$commit_oid $commit_size" >>expect &&
    ++		printf "%s\0" "$tag_oid $tag_size" >>expect &&
    ++
    ++		printf "%s\0" "$hello_oid missing" >>expect &&
    ++		printf "%s\0" "$tree_oid missing" >>expect &&
    ++		printf "%s\0" "$commit_oid missing" >>expect &&
    ++		printf "%s\0" "$tag_oid missing" >>expect &&
    ++
    ++		batch_input="remote-object-info $GIT_DAEMON_URL/parent $hello_oid $tree_oid
    ++remote-object-info $GIT_DAEMON_URL/parent $commit_oid $tag_oid
    ++info $hello_oid
    ++info $tree_oid
    ++info $commit_oid
    ++info $tag_oid
     +" &&
     +		echo_without_newline_nul "$batch_input" >commands_null_delimited &&
     +
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +		cd "$daemon_parent/daemon_client_empty" &&
     +
     +		# Prove object is not on the client
    -+		echo "$hello_sha1 missing" >expect &&
    -+		echo "$tree_sha1 missing" >>expect &&
    -+		echo "$commit_sha1 missing" >>expect &&
    -+		echo "$tag_sha1 missing" >>expect &&
    ++		echo "$hello_oid missing" >expect &&
    ++		echo "$tree_oid missing" >>expect &&
    ++		echo "$commit_oid missing" >>expect &&
    ++		echo "$tag_oid missing" >>expect &&
     +
     +		# These results prove remote-object-info can retrieve object info
    -+		echo "$hello_sha1 $hello_size" >>expect &&
    -+		echo "$tree_sha1 $tree_size" >>expect &&
    -+		echo "$commit_sha1 $commit_size" >>expect &&
    -+		echo "$tag_sha1 $tag_size" >>expect &&
    ++		echo "$hello_oid $hello_size" >>expect &&
    ++		echo "$tree_oid $tree_size" >>expect &&
    ++		echo "$commit_oid $commit_size" >>expect &&
    ++		echo "$tag_oid $tag_size" >>expect &&
     +
     +		# These results are for the info command
     +		# They prove objects are downloaded
    -+		echo "$hello_sha1 $hello_size" >>expect &&
    -+		echo "$tree_sha1 $tree_size" >>expect &&
    -+		echo "$commit_sha1 $commit_size" >>expect &&
    -+		echo "$tag_sha1 $tag_size" >>expect &&
    ++		echo "$hello_oid $hello_size" >>expect &&
    ++		echo "$tree_oid $tree_size" >>expect &&
    ++		echo "$commit_oid $commit_size" >>expect &&
    ++		echo "$tag_oid $tag_size" >>expect &&
     +
     +		git cat-file --batch-command="%(objectname) %(objectsize)" >actual <<-EOF &&
    -+		info $hello_sha1
    -+		info $tree_sha1
    -+		info $commit_sha1
    -+		info $tag_sha1
    -+		remote-object-info $GIT_DAEMON_URL/parent $hello_sha1 $tree_sha1 $commit_sha1 $tag_sha1
    -+		info $hello_sha1
    -+		info $tree_sha1
    -+		info $commit_sha1
    -+		info $tag_sha1
    ++		info $hello_oid
    ++		info $tree_oid
    ++		info $commit_oid
    ++		info $tag_oid
    ++		remote-object-info $GIT_DAEMON_URL/parent $hello_oid $tree_oid $commit_oid $tag_oid
    ++		info $hello_oid
    ++		info $tree_oid
    ++		info $commit_oid
    ++		info $tag_oid
     +		EOF
     +
     +		# revert server state back
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +
     +stop_git_daemon
     +
    -+# Test --batch-command remote-object-info with 'file://' transport
    ++# Test --batch-command remote-object-info with 'file://' transport with
    ++# transfer.advertiseobjectinfo set to true, i.e. server has object-info capability
     +# shellcheck disable=SC2016
     +test_expect_success 'create repo to be served by file:// transport' '
     +	git init server &&
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +		cd file_client_empty &&
     +
     +		# These results prove remote-object-info can get object info from the remote
    -+		echo "$hello_sha1 $hello_size" >expect &&
    -+		echo "$tree_sha1 $tree_size" >>expect &&
    -+		echo "$commit_sha1 $commit_size" >>expect &&
    -+		echo "$tag_sha1 $tag_size" >>expect &&
    ++		echo "$hello_oid $hello_size" >expect &&
    ++		echo "$tree_oid $tree_size" >>expect &&
    ++		echo "$commit_oid $commit_size" >>expect &&
    ++		echo "$tag_oid $tag_size" >>expect &&
     +
     +		# These results prove remote-object-info did not download objects from the remote
    -+		echo "$hello_sha1 missing" >>expect &&
    -+		echo "$tree_sha1 missing" >>expect &&
    -+		echo "$commit_sha1 missing" >>expect &&
    -+		echo "$tag_sha1 missing" >>expect &&
    ++		echo "$hello_oid missing" >>expect &&
    ++		echo "$tree_oid missing" >>expect &&
    ++		echo "$commit_oid missing" >>expect &&
    ++		echo "$tag_oid missing" >>expect &&
     +
     +		git cat-file --batch-command="%(objectname) %(objectsize)" >actual <<-EOF &&
    -+		remote-object-info "file://${server_path}" $hello_sha1
    -+		remote-object-info "file://${server_path}" $tree_sha1
    -+		remote-object-info "file://${server_path}" $commit_sha1
    -+		remote-object-info "file://${server_path}" $tag_sha1
    -+		info $hello_sha1
    -+		info $tree_sha1
    -+		info $commit_sha1
    -+		info $tag_sha1
    ++		remote-object-info "file://${server_path}" $hello_oid
    ++		remote-object-info "file://${server_path}" $tree_oid
    ++		remote-object-info "file://${server_path}" $commit_oid
    ++		remote-object-info "file://${server_path}" $tag_oid
    ++		info $hello_oid
    ++		info $tree_oid
    ++		info $commit_oid
    ++		info $tag_oid
     +		EOF
     +		test_cmp expect actual
     +	)
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +		cd file_client_empty &&
     +
     +		# These results prove remote-object-info can get object info from the remote
    -+		echo "$hello_sha1 $hello_size" >expect &&
    -+		echo "$tree_sha1 $tree_size" >>expect &&
    -+		echo "$commit_sha1 $commit_size" >>expect &&
    -+		echo "$tag_sha1 $tag_size" >>expect &&
    ++		echo "$hello_oid $hello_size" >expect &&
    ++		echo "$tree_oid $tree_size" >>expect &&
    ++		echo "$commit_oid $commit_size" >>expect &&
    ++		echo "$tag_oid $tag_size" >>expect &&
     +
     +		# These results prove remote-object-info did not download objects from the remote
    -+		echo "$hello_sha1 missing" >>expect &&
    -+		echo "$tree_sha1 missing" >>expect &&
    -+		echo "$commit_sha1 missing" >>expect &&
    -+		echo "$tag_sha1 missing" >>expect &&
    ++		echo "$hello_oid missing" >>expect &&
    ++		echo "$tree_oid missing" >>expect &&
    ++		echo "$commit_oid missing" >>expect &&
    ++		echo "$tag_oid missing" >>expect &&
     +
     +
     +		git cat-file --batch-command="%(objectname) %(objectsize)" >actual <<-EOF &&
    -+		remote-object-info "file://${server_path}" $hello_sha1 $tree_sha1 $commit_sha1 $tag_sha1
    -+		info $hello_sha1
    -+		info $tree_sha1
    -+		info $commit_sha1
    -+		info $tag_sha1
    ++		remote-object-info "file://${server_path}" $hello_oid $tree_oid $commit_oid $tag_oid
    ++		info $hello_oid
    ++		info $tree_oid
    ++		info $commit_oid
    ++		info $tag_oid
     +		EOF
     +		test_cmp expect actual
     +	)
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +		cd file_client_empty &&
     +
     +		# These results prove remote-object-info can get object info from the remote
    -+		echo "$hello_sha1 $hello_size" >expect &&
    -+		echo "$tree_sha1 $tree_size" >>expect &&
    -+		echo "$commit_sha1 $commit_size" >>expect &&
    -+		echo "$tag_sha1 $tag_size" >>expect &&
    ++		echo "$hello_oid $hello_size" >expect &&
    ++		echo "$tree_oid $tree_size" >>expect &&
    ++		echo "$commit_oid $commit_size" >>expect &&
    ++		echo "$tag_oid $tag_size" >>expect &&
     +
     +		# These results prove remote-object-info did not download objects from the remote
    -+		echo "$hello_sha1 missing" >>expect &&
    -+		echo "$tree_sha1 missing" >>expect &&
    -+		echo "$commit_sha1 missing" >>expect &&
    -+		echo "$tag_sha1 missing" >>expect &&
    ++		echo "$hello_oid missing" >>expect &&
    ++		echo "$tree_oid missing" >>expect &&
    ++		echo "$commit_oid missing" >>expect &&
    ++		echo "$tag_oid missing" >>expect &&
     +
     +		git cat-file --batch-command="%(objectname) %(objectsize)" --buffer >actual <<-EOF &&
    -+		remote-object-info "file://${server_path}" $hello_sha1 $tree_sha1
    -+		remote-object-info "file://${server_path}" $commit_sha1 $tag_sha1
    -+		info $hello_sha1
    -+		info $tree_sha1
    -+		info $commit_sha1
    -+		info $tag_sha1
    ++		remote-object-info "file://${server_path}" $hello_oid $tree_oid
    ++		remote-object-info "file://${server_path}" $commit_oid $tag_oid
    ++		info $hello_oid
    ++		info $tree_oid
    ++		info $commit_oid
    ++		info $tag_oid
     +		flush
     +		EOF
     +		test_cmp expect actual
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +		server_path="$(pwd)/server" &&
     +		cd file_client_empty &&
     +
    -+		echo "$hello_sha1 $hello_size" >expect &&
    -+		echo "$tree_sha1 $tree_size" >>expect &&
    -+		echo "$commit_sha1 $commit_size" >>expect &&
    -+		echo "$tag_sha1 $tag_size" >>expect &&
    ++		echo "$hello_oid $hello_size" >expect &&
    ++		echo "$tree_oid $tree_size" >>expect &&
    ++		echo "$commit_oid $commit_size" >>expect &&
    ++		echo "$tag_oid $tag_size" >>expect &&
     +
     +		git cat-file --batch-command >actual <<-EOF &&
    -+		remote-object-info "file://${server_path}" $hello_sha1 $tree_sha1
    -+		remote-object-info "file://${server_path}" $commit_sha1 $tag_sha1
    ++		remote-object-info "file://${server_path}" $hello_oid $tree_oid
    ++		remote-object-info "file://${server_path}" $commit_oid $tag_oid
     +		EOF
     +		test_cmp expect actual
     +	)
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +		server_path="$(pwd)/server" &&
     +		cd file_client_empty &&
     +
    -+		printf "%s\0" "$hello_sha1 $hello_size" >expect &&
    -+		printf "%s\0" "$tree_sha1 $tree_size" >>expect &&
    -+		printf "%s\0" "$commit_sha1 $commit_size" >>expect &&
    -+		printf "%s\0" "$tag_sha1 $tag_size" >>expect &&
    -+
    -+		printf "%s\0" "$hello_sha1 missing" >>expect &&
    -+		printf "%s\0" "$tree_sha1 missing" >>expect &&
    -+		printf "%s\0" "$commit_sha1 missing" >>expect &&
    -+		printf "%s\0" "$tag_sha1 missing" >>expect &&
    -+
    -+		batch_input="remote-object-info \"file://${server_path}\" $hello_sha1 $tree_sha1
    -+remote-object-info \"file://${server_path}\" $commit_sha1 $tag_sha1
    -+info $hello_sha1
    -+info $tree_sha1
    -+info $commit_sha1
    -+info $tag_sha1
    ++		printf "%s\0" "$hello_oid $hello_size" >expect &&
    ++		printf "%s\0" "$tree_oid $tree_size" >>expect &&
    ++		printf "%s\0" "$commit_oid $commit_size" >>expect &&
    ++		printf "%s\0" "$tag_oid $tag_size" >>expect &&
    ++
    ++		printf "%s\0" "$hello_oid missing" >>expect &&
    ++		printf "%s\0" "$tree_oid missing" >>expect &&
    ++		printf "%s\0" "$commit_oid missing" >>expect &&
    ++		printf "%s\0" "$tag_oid missing" >>expect &&
    ++
    ++		batch_input="remote-object-info \"file://${server_path}\" $hello_oid $tree_oid
    ++remote-object-info \"file://${server_path}\" $commit_oid $tag_oid
    ++info $hello_oid
    ++info $tree_oid
    ++info $commit_oid
    ++info $tag_oid
     +" &&
     +		echo_without_newline_nul "$batch_input" >commands_null_delimited &&
     +
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +		cd file_client_empty &&
     +
     +		# Prove object is not on the client
    -+		echo "$hello_sha1 missing" >expect &&
    -+		echo "$tree_sha1 missing" >>expect &&
    -+		echo "$commit_sha1 missing" >>expect &&
    -+		echo "$tag_sha1 missing" >>expect &&
    ++		echo "$hello_oid missing" >expect &&
    ++		echo "$tree_oid missing" >>expect &&
    ++		echo "$commit_oid missing" >>expect &&
    ++		echo "$tag_oid missing" >>expect &&
     +
     +		# These results prove remote-object-info can retrieve object info
    -+		echo "$hello_sha1 $hello_size" >>expect &&
    -+		echo "$tree_sha1 $tree_size" >>expect &&
    -+		echo "$commit_sha1 $commit_size" >>expect &&
    -+		echo "$tag_sha1 $tag_size" >>expect &&
    ++		echo "$hello_oid $hello_size" >>expect &&
    ++		echo "$tree_oid $tree_size" >>expect &&
    ++		echo "$commit_oid $commit_size" >>expect &&
    ++		echo "$tag_oid $tag_size" >>expect &&
     +
     +		# These results are for the info command
     +		# They prove objects are downloaded
    -+		echo "$hello_sha1 $hello_size" >>expect &&
    -+		echo "$tree_sha1 $tree_size" >>expect &&
    -+		echo "$commit_sha1 $commit_size" >>expect &&
    -+		echo "$tag_sha1 $tag_size" >>expect &&
    ++		echo "$hello_oid $hello_size" >>expect &&
    ++		echo "$tree_oid $tree_size" >>expect &&
    ++		echo "$commit_oid $commit_size" >>expect &&
    ++		echo "$tag_oid $tag_size" >>expect &&
     +
     +		git cat-file --batch-command="%(objectname) %(objectsize)" >actual <<-EOF &&
    -+		info $hello_sha1
    -+		info $tree_sha1
    -+		info $commit_sha1
    -+		info $tag_sha1
    -+		remote-object-info "file://${server_path}" $hello_sha1 $tree_sha1 $commit_sha1 $tag_sha1
    -+		info $hello_sha1
    -+		info $tree_sha1
    -+		info $commit_sha1
    -+		info $tag_sha1
    ++		info $hello_oid
    ++		info $tree_oid
    ++		info $commit_oid
    ++		info $tag_oid
    ++		remote-object-info "file://${server_path}" $hello_oid $tree_oid $commit_oid $tag_oid
    ++		info $hello_oid
    ++		info $tree_oid
    ++		info $commit_oid
    ++		info $tag_oid
     +		EOF
     +
     +		# revert server state back
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_client_empty" &&
     +
     +		# These results prove remote-object-info can get object info from the remote
    -+		echo "$hello_sha1 $hello_size" >expect &&
    -+		echo "$tree_sha1 $tree_size" >>expect &&
    -+		echo "$commit_sha1 $commit_size" >>expect &&
    -+		echo "$tag_sha1 $tag_size" >>expect &&
    ++		echo "$hello_oid $hello_size" >expect &&
    ++		echo "$tree_oid $tree_size" >>expect &&
    ++		echo "$commit_oid $commit_size" >>expect &&
    ++		echo "$tag_oid $tag_size" >>expect &&
     +
     +		# These results prove remote-object-info did not download objects from the remote
    -+		echo "$hello_sha1 missing" >>expect &&
    -+		echo "$tree_sha1 missing" >>expect &&
    -+		echo "$commit_sha1 missing" >>expect &&
    -+		echo "$tag_sha1 missing" >>expect &&
    ++		echo "$hello_oid missing" >>expect &&
    ++		echo "$tree_oid missing" >>expect &&
    ++		echo "$commit_oid missing" >>expect &&
    ++		echo "$tag_oid missing" >>expect &&
     +
     +		git cat-file --batch-command="%(objectname) %(objectsize)" >actual <<-EOF &&
    -+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_sha1
    -+		remote-object-info "$HTTPD_URL/smart/http_parent" $tree_sha1
    -+		remote-object-info "$HTTPD_URL/smart/http_parent" $commit_sha1
    -+		remote-object-info "$HTTPD_URL/smart/http_parent" $tag_sha1
    -+		info $hello_sha1
    -+		info $tree_sha1
    -+		info $commit_sha1
    -+		info $tag_sha1
    ++		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid
    ++		remote-object-info "$HTTPD_URL/smart/http_parent" $tree_oid
    ++		remote-object-info "$HTTPD_URL/smart/http_parent" $commit_oid
    ++		remote-object-info "$HTTPD_URL/smart/http_parent" $tag_oid
    ++		info $hello_oid
    ++		info $tree_oid
    ++		info $commit_oid
    ++		info $tag_oid
     +		EOF
     +		test_cmp expect actual
     +	)
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_client_empty" &&
     +
     +		# These results prove remote-object-info can get object info from the remote
    -+		echo "$hello_sha1 $hello_size" >expect &&
    -+		echo "$tree_sha1 $tree_size" >>expect &&
    -+		echo "$commit_sha1 $commit_size" >>expect &&
    -+		echo "$tag_sha1 $tag_size" >>expect &&
    ++		echo "$hello_oid $hello_size" >expect &&
    ++		echo "$tree_oid $tree_size" >>expect &&
    ++		echo "$commit_oid $commit_size" >>expect &&
    ++		echo "$tag_oid $tag_size" >>expect &&
     +
     +		# These results prove remote-object-info did not download objects from the remote
    -+		echo "$hello_sha1 missing" >>expect &&
    -+		echo "$tree_sha1 missing" >>expect &&
    -+		echo "$commit_sha1 missing" >>expect &&
    -+		echo "$tag_sha1 missing" >>expect &&
    ++		echo "$hello_oid missing" >>expect &&
    ++		echo "$tree_oid missing" >>expect &&
    ++		echo "$commit_oid missing" >>expect &&
    ++		echo "$tag_oid missing" >>expect &&
     +
     +		git cat-file --batch-command="%(objectname) %(objectsize)" >actual <<-EOF &&
    -+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_sha1 $tree_sha1 $commit_sha1 $tag_sha1
    -+		info $hello_sha1
    -+		info $tree_sha1
    -+		info $commit_sha1
    -+		info $tag_sha1
    ++		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid $tree_oid $commit_oid $tag_oid
    ++		info $hello_oid
    ++		info $tree_oid
    ++		info $commit_oid
    ++		info $tag_oid
     +		EOF
     +		test_cmp expect actual
     +	)
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_client_empty" &&
     +
     +		# These results prove remote-object-info can get object info from the remote
    -+		echo "$hello_sha1 $hello_size" >expect &&
    -+		echo "$tree_sha1 $tree_size" >>expect &&
    -+		echo "$commit_sha1 $commit_size" >>expect &&
    -+		echo "$tag_sha1 $tag_size" >>expect &&
    ++		echo "$hello_oid $hello_size" >expect &&
    ++		echo "$tree_oid $tree_size" >>expect &&
    ++		echo "$commit_oid $commit_size" >>expect &&
    ++		echo "$tag_oid $tag_size" >>expect &&
     +
     +		# These results prove remote-object-info did not download objects from the remote
    -+		echo "$hello_sha1 missing" >>expect &&
    -+		echo "$tree_sha1 missing" >>expect &&
    -+		echo "$commit_sha1 missing" >>expect &&
    -+		echo "$tag_sha1 missing" >>expect &&
    ++		echo "$hello_oid missing" >>expect &&
    ++		echo "$tree_oid missing" >>expect &&
    ++		echo "$commit_oid missing" >>expect &&
    ++		echo "$tag_oid missing" >>expect &&
     +
     +		git cat-file --batch-command="%(objectname) %(objectsize)" --buffer >actual <<-EOF &&
    -+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_sha1 $tree_sha1
    -+		remote-object-info "$HTTPD_URL/smart/http_parent" $commit_sha1 $tag_sha1
    -+		info $hello_sha1
    -+		info $tree_sha1
    -+		info $commit_sha1
    -+		info $tag_sha1
    ++		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid $tree_oid
    ++		remote-object-info "$HTTPD_URL/smart/http_parent" $commit_oid $tag_oid
    ++		info $hello_oid
    ++		info $tree_oid
    ++		info $commit_oid
    ++		info $tag_oid
     +		flush
     +		EOF
     +		test_cmp expect actual
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
     +		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_client_empty" &&
     +
    -+		echo "$hello_sha1 $hello_size" >expect &&
    -+		echo "$tree_sha1 $tree_size" >>expect &&
    -+		echo "$commit_sha1 $commit_size" >>expect &&
    -+		echo "$tag_sha1 $tag_size" >>expect &&
    ++		echo "$hello_oid $hello_size" >expect &&
    ++		echo "$tree_oid $tree_size" >>expect &&
    ++		echo "$commit_oid $commit_size" >>expect &&
    ++		echo "$tag_oid $tag_size" >>expect &&
     +
     +		git cat-file --batch-command >actual <<-EOF &&
    -+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_sha1 $tree_sha1
    -+		remote-object-info "$HTTPD_URL/smart/http_parent" $commit_sha1 $tag_sha1
    ++		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid $tree_oid
    ++		remote-object-info "$HTTPD_URL/smart/http_parent" $commit_oid $tag_oid
     +		EOF
     +		test_cmp expect actual
     +	)
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
     +		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_client_empty" &&
     +
    -+		printf "%s\0" "$hello_sha1 $hello_size" >expect &&
    -+		printf "%s\0" "$tree_sha1 $tree_size" >>expect &&
    -+		printf "%s\0" "$commit_sha1 $commit_size" >>expect &&
    -+		printf "%s\0" "$tag_sha1 $tag_size" >>expect &&
    ++		printf "%s\0" "$hello_oid $hello_size" >expect &&
    ++		printf "%s\0" "$tree_oid $tree_size" >>expect &&
    ++		printf "%s\0" "$commit_oid $commit_size" >>expect &&
    ++		printf "%s\0" "$tag_oid $tag_size" >>expect &&
     +
    -+		batch_input="remote-object-info $HTTPD_URL/smart/http_parent $hello_sha1 $tree_sha1
    -+remote-object-info $HTTPD_URL/smart/http_parent $commit_sha1 $tag_sha1
    ++		batch_input="remote-object-info $HTTPD_URL/smart/http_parent $hello_oid $tree_oid
    ++remote-object-info $HTTPD_URL/smart/http_parent $commit_oid $tag_oid
     +" &&
     +		echo_without_newline_nul "$batch_input" >commands_null_delimited &&
     +
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
     +
     +		test_must_fail git cat-file --batch-command="%(objectsize:disk)" 2>err <<-EOF &&
    -+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_sha1
    ++		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid
     +		EOF
     +		test_grep "%(objectsize:disk) is currently not supported with remote-object-info" err
     +	)
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
     +
     +		test_must_fail git cat-file --batch-command="%(deltabase)" 2>err <<-EOF &&
    -+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_sha1
    ++		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid
     +		EOF
     +		test_grep "%(deltabase) is currently not supported with remote-object-info" err
     +	)
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
     +
     +		test_must_fail git -c protocol.version=0 cat-file --batch-command="%(objectname) %(objectsize)" 2>err <<-EOF &&
    -+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_sha1
    ++		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid
     +		EOF
     +		test_grep "remote-object-info requires protocol v2" err
     +	)
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
     +
     +		test_must_fail git -c protocol.version=0 cat-file --batch-command 2>err <<-EOF &&
    -+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_sha1
    ++		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid
     +		EOF
     +		test_grep "remote-object-info requires protocol v2" err
     +	)
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_client_empty" &&
     +
     +		# Prove object is not on the client
    -+		echo "$hello_sha1 missing" >expect &&
    -+		echo "$tree_sha1 missing" >>expect &&
    -+		echo "$commit_sha1 missing" >>expect &&
    -+		echo "$tag_sha1 missing" >>expect &&
    ++		echo "$hello_oid missing" >expect &&
    ++		echo "$tree_oid missing" >>expect &&
    ++		echo "$commit_oid missing" >>expect &&
    ++		echo "$tag_oid missing" >>expect &&
     +
     +		# These results prove remote-object-info can retrieve object info
    -+		echo "$hello_sha1 $hello_size" >>expect &&
    -+		echo "$tree_sha1 $tree_size" >>expect &&
    -+		echo "$commit_sha1 $commit_size" >>expect &&
    -+		echo "$tag_sha1 $tag_size" >>expect &&
    ++		echo "$hello_oid $hello_size" >>expect &&
    ++		echo "$tree_oid $tree_size" >>expect &&
    ++		echo "$commit_oid $commit_size" >>expect &&
    ++		echo "$tag_oid $tag_size" >>expect &&
     +
     +		# These results are for the info command
     +		# They prove objects are downloaded
    -+		echo "$hello_sha1 $hello_size" >>expect &&
    -+		echo "$tree_sha1 $tree_size" >>expect &&
    -+		echo "$commit_sha1 $commit_size" >>expect &&
    -+		echo "$tag_sha1 $tag_size" >>expect &&
    ++		echo "$hello_oid $hello_size" >>expect &&
    ++		echo "$tree_oid $tree_size" >>expect &&
    ++		echo "$commit_oid $commit_size" >>expect &&
    ++		echo "$tag_oid $tag_size" >>expect &&
     +
     +		git cat-file --batch-command >actual <<-EOF &&
    -+		info $hello_sha1
    -+		info $tree_sha1
    -+		info $commit_sha1
    -+		info $tag_sha1
    -+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_sha1 $tree_sha1 $commit_sha1 $tag_sha1
    -+		info $hello_sha1
    -+		info $tree_sha1
    -+		info $commit_sha1
    -+		info $tag_sha1
    ++		info $hello_oid
    ++		info $tree_oid
    ++		info $commit_oid
    ++		info $tag_oid
    ++		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid $tree_oid $commit_oid $tag_oid
    ++		info $hello_oid
    ++		info $tree_oid
    ++		info $commit_oid
    ++		info $tag_oid
     +		EOF
     +
     +		# revert server state back
-- 
2.46.0

