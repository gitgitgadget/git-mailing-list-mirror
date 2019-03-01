Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A275D20248
	for <e@80x24.org>; Fri,  1 Mar 2019 00:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731792AbfCAAKC (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 19:10:02 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44661 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731073AbfCAAKC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 19:10:02 -0500
Received: by mail-pl1-f195.google.com with SMTP id c4so10523787pls.11
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 16:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WZs8q8YkHqcSlzK3i+F/Cnyzp+u2K0Sozr7QMsip3TI=;
        b=XkiKfsa+dnqKiRn8txaIygmiJ3G1Wg1ZptQicY13mqsKTkxVf0nhkrWCBd/iEwxPOC
         ga6nz2khYMxzbBmhry78DJqR9j6sMM77ry2jwe+HvqfH2PudmMCIDckV7Y2VRq9ewNiO
         W/aH0cAvXKj35saqYNQ2pOrZ5eyW/Vn5/TPg2ZjKCzdZLlkrV91WjGWLcYLXmfo3+E+v
         LYs7F9BIGGg3JUYIYBklI3ugdZg2sLmBvjVjKZll+Uq9UyJb8XHMhKvFwHE+pXUm7s6b
         8YDLdZYlxBZKLcjI3YSgHXaiWtODjW6aiQ9kKosXT4Z2u04FnFbkbBrgy9MzVk5wEypY
         XLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=WZs8q8YkHqcSlzK3i+F/Cnyzp+u2K0Sozr7QMsip3TI=;
        b=rj+dfdKwMnoemA98CFcT49rglsQ8hD8M/EGjec46K3+9XL+DrqIln7Mkqga5U+sEcr
         pH6CTordHBuiJRPb0/EaFhrAffktMEIc4DxBeK5xmop1O8i0viMj+6I5ZEBMTphTGMvA
         jwb7U/CMkxMaOOyoIMWdX31c9KlyETdnaKqf+j08nw1rosapqtaToOXQ4atGUTkrcX7C
         LB2qu82pvhk7NUwjUgRAcTNkyI9q4IwZ1J4nYtzKqz5aTjHQprlyk8CitKVvQ0UmKz/Y
         01GMmeVHSppXk3ZjTbCWlayA5C7QDC7KnhnMG3/MPJoSuuAZW4X5weGWlVI3mKVJzjkk
         v8Ug==
X-Gm-Message-State: APjAAAVVXlRceVt5qxIq7D33WDjYdVBsdFU7W1v1h8P7fXC4KiFInXuR
        Hzacgvmc3lD8VE462HbuFKI8+g==
X-Google-Smtp-Source: APXvYqw7gNCfZOvTkJvywik8qEpomqe4GVCz9/go4afpAxb6L99QOaPfzPAwsp/8NxhYyIbSaqJTXA==
X-Received: by 2002:a17:902:8687:: with SMTP id g7mr2274294plo.96.1551399000660;
        Thu, 28 Feb 2019 16:10:00 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id d86sm15218070pfm.18.2019.02.28.16.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 16:09:59 -0800 (PST)
Date:   Thu, 28 Feb 2019 16:09:54 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        christian.couder@gmail.com, avarab@gmail.com
Subject: Re: [WIP 7/7] upload-pack: send part of packfile response as uri
Message-ID: <20190301000954.GA47591@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, christian.couder@gmail.com,
        avarab@gmail.com
References: <cover.1550963965.git.jonathantanmy@google.com>
 <aae0f669627d7be45a967c6df464bf1ecdabce6d.1550963965.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aae0f669627d7be45a967c6df464bf1ecdabce6d.1550963965.git.jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.02.23 15:39, Jonathan Tan wrote:
> Teach upload-pack to send part of its packfile response as URIs.
> 
> An administrator may configure a repository with one or more
> "uploadpack.blobpackfileuri" lines, each line containing an OID and a
> URI. A client may configure fetch.uriprotocols to be a comma-separated
> list of protocols that it is willing to use to fetch additional
> packfiles - this list will be sent to the server. Whenever an object
> with one of those OIDs would appear in the packfile transmitted by
> upload-pack, the server may exclude that object, and instead send the
> URI. The client will then download the packs referred to by those URIs
> before performing the connectivity check.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/pack-objects.c | 63 ++++++++++++++++++++++++++++++++++
>  fetch-pack.c           | 58 +++++++++++++++++++++++++++++++
>  t/t5702-protocol-v2.sh | 54 +++++++++++++++++++++++++++++
>  upload-pack.c          | 78 ++++++++++++++++++++++++++++++++++++++----
>  4 files changed, 247 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index a9fac7c128..73309821e2 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -110,6 +110,8 @@ static unsigned long window_memory_limit = 0;
>  
>  static struct list_objects_filter_options filter_options;
>  
> +static struct string_list uri_protocols = STRING_LIST_INIT_NODUP;
> +
>  enum missing_action {
>  	MA_ERROR = 0,      /* fail if any missing objects are encountered */
>  	MA_ALLOW_ANY,      /* silently allow ALL missing objects */
> @@ -118,6 +120,14 @@ enum missing_action {
>  static enum missing_action arg_missing_action;
>  static show_object_fn fn_show_object;
>  
> +struct configured_exclusion {
> +	struct oidmap_entry e;
> +	char *uri;
> +};
> +static struct oidmap configured_exclusions;
> +
> +static struct oidset excluded_by_config;
> +
>  /*
>   * stats
>   */
> @@ -832,6 +842,23 @@ static off_t write_reused_pack(struct hashfile *f)
>  	return reuse_packfile_offset - sizeof(struct pack_header);
>  }
>  
> +static void write_excluded_by_configs(void)
> +{
> +	struct oidset_iter iter;
> +	const struct object_id *oid;
> +
> +	oidset_iter_init(&excluded_by_config, &iter);
> +	while ((oid = oidset_iter_next(&iter))) {
> +		struct configured_exclusion *ex =
> +			oidmap_get(&configured_exclusions, oid);
> +
> +		if (!ex)
> +			BUG("configured exclusion wasn't configured");
> +		write_in_full(1, ex->uri, strlen(ex->uri));
> +		write_in_full(1, "\n", 1);
> +	}
> +}
> +
>  static const char no_split_warning[] = N_(
>  "disabling bitmap writing, packs are split due to pack.packSizeLimit"
>  );
> @@ -1125,6 +1152,25 @@ static int want_object_in_pack(const struct object_id *oid,
>  		}
>  	}
>  
> +	if (uri_protocols.nr) {
> +		struct configured_exclusion *ex =
> +			oidmap_get(&configured_exclusions, oid);
> +		int i;
> +		const char *p;
> +
> +		if (ex) {
> +			for (i = 0; i < uri_protocols.nr; i++) {
> +				if (skip_prefix(ex->uri,
> +						uri_protocols.items[i].string,
> +						&p) &&
> +				    *p == ':') {
> +					oidset_insert(&excluded_by_config, oid);
> +					return 0;
> +				}
> +			}
> +		}
> +	}
> +
>  	return 1;
>  }
>  
> @@ -2726,6 +2772,19 @@ static int git_pack_config(const char *k, const char *v, void *cb)
>  			    pack_idx_opts.version);
>  		return 0;
>  	}
> +	if (!strcmp(k, "uploadpack.blobpackfileuri")) {
> +		struct configured_exclusion *ex = xmalloc(sizeof(*ex));
> +		const char *end;
> +
> +		if (parse_oid_hex(v, &ex->e.oid, &end) || *end != ' ')
> +			die(_("value of uploadpack.blobpackfileuri must be "
> +			      "of the form '<sha-1> <uri>' (got '%s')"), v);
> +		if (oidmap_get(&configured_exclusions, &ex->e.oid))
> +			die(_("object already configured in another "
> +			      "uploadpack.blobpackfileuri (got '%s')"), v);
> +		ex->uri = xstrdup(end + 1);
> +		oidmap_put(&configured_exclusions, ex);
> +	}
>  	return git_default_config(k, v, cb);
>  }
>  
> @@ -3318,6 +3377,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  			 N_("do not pack objects in promisor packfiles")),
>  		OPT_BOOL(0, "delta-islands", &use_delta_islands,
>  			 N_("respect islands during delta compression")),
> +		OPT_STRING_LIST(0, "uri-protocol", &uri_protocols,
> +				N_("protocol"),
> +				N_("exclude any configured uploadpack.blobpackfileuri with this protocol")),
>  		OPT_END(),
>  	};
>  
> @@ -3492,6 +3554,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  		return 0;
>  	if (nr_result)
>  		prepare_pack(window, depth);
> +	write_excluded_by_configs();
>  	write_pack_file();
>  	if (progress)
>  		fprintf_ln(stderr,
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 812be15d7e..edbe4b3ec3 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -38,6 +38,7 @@ static struct lock_file shallow_lock;
>  static const char *alternate_shallow_file;
>  static char *negotiation_algorithm;
>  static struct strbuf fsck_msg_types = STRBUF_INIT;
> +static struct string_list uri_protocols = STRING_LIST_INIT_DUP;
>  
>  /* Remember to update object flag allocation in object.h */
>  #define COMPLETE	(1U << 0)
> @@ -1147,6 +1148,26 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
>  		warning("filtering not recognized by server, ignoring");
>  	}
>  
> +	if (server_supports_feature("fetch", "packfile-uris", 0)) {
> +		int i;
> +		struct strbuf to_send = STRBUF_INIT;
> +
> +		for (i = 0; i < uri_protocols.nr; i++) {
> +			const char *s = uri_protocols.items[i].string;
> +
> +			if (!strcmp(s, "https") || !strcmp(s, "http")) {
> +				if (to_send.len)
> +					strbuf_addch(&to_send, ',');
> +				strbuf_addstr(&to_send, s);
> +			}
> +		}
> +		if (to_send.len) {
> +			packet_buf_write(&req_buf, "packfile-uris %s",
> +					 to_send.buf);
> +			strbuf_release(&to_send);
> +		}
> +	}
> +
>  	/* add wants */
>  	add_wants(args->no_dependents, wants, &req_buf);
>  
> @@ -1322,6 +1343,32 @@ static void receive_wanted_refs(struct packet_reader *reader,
>  		die(_("error processing wanted refs: %d"), reader->status);
>  }
>  
> +static void receive_packfile_uris(struct packet_reader *reader)
> +{
> +	process_section_header(reader, "packfile-uris", 0);
> +	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
> +		const char *p;
> +		struct child_process cmd = CHILD_PROCESS_INIT;
> +
> +
> +		if (!skip_prefix(reader->line, "uri ", &p))
> +			die("expected 'uri <uri>', got: %s\n", reader->line);
> +
> +		argv_array_push(&cmd.args, "http-fetch");
> +		argv_array_push(&cmd.args, "--packfile");
> +		argv_array_push(&cmd.args, p);
> +		cmd.git_cmd = 1;
> +		cmd.no_stdin = 1;
> +		cmd.no_stdout = 1;
> +		if (start_command(&cmd))
> +			die("fetch-pack: unable to spawn");
> +		if (finish_command(&cmd))
> +			die("fetch-pack: unable to finish");
> +	}
> +	if (reader->status != PACKET_READ_DELIM)
> +		die("expected DELIM");
> +}
> +

So we process the packfile URIs one by one as we receive them from the
server? If we expect these packfiles to be large (otherwise why are we
bothering to offload them to the CDN), is there a risk that the
connection to the server might time out while we're downloading from the
CDN?

>  enum fetch_state {
>  	FETCH_CHECK_LOCAL = 0,
>  	FETCH_SEND_REQUEST,
> @@ -1414,6 +1461,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  				receive_wanted_refs(&reader, sought, nr_sought);
>  
>  			/* get the pack */
> +			if (process_section_header(&reader, "packfile-uris", 1)) {
> +				receive_packfile_uris(&reader);
> +			}
>  			process_section_header(&reader, "packfile", 0);
>  			if (get_pack(args, fd, pack_lockfile))
>  				die(_("git fetch-pack: fetch failed."));
> @@ -1464,6 +1514,14 @@ static void fetch_pack_config(void)
>  	git_config_get_bool("transfer.fsckobjects", &transfer_fsck_objects);
>  	git_config_get_string("fetch.negotiationalgorithm",
>  			      &negotiation_algorithm);
> +	if (!uri_protocols.nr) {
> +		char *str;
> +
> +		if (!git_config_get_string("fetch.uriprotocols", &str) && str) {
> +			string_list_split(&uri_protocols, str, ',', -1);
> +			free(str);
> +		}
> +	}
>  
>  	git_config(fetch_pack_config_cb, NULL);
>  }
> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index db4ae09f2f..6dbe2e9584 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -656,6 +656,60 @@ test_expect_success 'when server does not send "ready", expect FLUSH' '
>  	test_i18ngrep "expected no other sections to be sent after no .ready." err
>  '
>  
> +test_expect_success 'part of packfile response provided as URI' '
> +	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> +	rm -rf "$P" http_child log &&
> +
> +	git init "$P" &&
> +	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
> +
> +	echo my-blob >"$P/my-blob" &&
> +	git -C "$P" add my-blob &&
> +	echo other-blob >"$P/other-blob" &&
> +	git -C "$P" add other-blob &&
> +	git -C "$P" commit -m x &&
> +
> +	# Create a packfile for my-blob and configure it for exclusion.
> +	git -C "$P" hash-object my-blob >h &&
> +	git -C "$P" pack-objects --stdout <h \
> +		>"$HTTPD_DOCUMENT_ROOT_PATH/one.pack" &&
> +	git -C "$P" config \
> +		"uploadpack.blobpackfileuri" \
> +		"$(cat h) $HTTPD_URL/dumb/one.pack" &&
> +
> +	# Do the same for other-blob.
> +	git -C "$P" hash-object other-blob >h2 &&
> +	git -C "$P" pack-objects --stdout <h2 \
> +		>"$HTTPD_DOCUMENT_ROOT_PATH/two.pack" &&
> +	git -C "$P" config --add \
> +		"uploadpack.blobpackfileuri" \
> +		"$(cat h2) $HTTPD_URL/dumb/two.pack" &&
> +
> +	GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
> +		git -c protocol.version=2 \
> +		-c fetch.uriprotocols=http,https \
> +		clone  "$HTTPD_URL/smart/http_parent" http_child &&
> +
> +	# Ensure that my-blob and other-blob are in separate packfiles.
> +	for idx in http_child/.git/objects/pack/*.idx
> +	do
> +		git verify-pack --verbose $idx >out &&
> +		if test "$(grep "^[0-9a-f]\{40\} " out | wc -l)" = 1
> +		then
> +			if grep $(cat h) out
> +			then
> +				>hfound
> +			fi &&
> +			if grep $(cat h2) out
> +			then
> +				>h2found
> +			fi
> +		fi
> +	done &&
> +	test -f hfound &&
> +	test -f h2found
> +'
> +
>  stop_httpd
>  
>  test_done
> diff --git a/upload-pack.c b/upload-pack.c
> index 987d2e139b..2365b707bc 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -105,9 +105,12 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
>  struct output_state {
>  	char buffer[8193];
>  	int used;
> +	unsigned packfile_uris_started : 1;
> +	unsigned packfile_started : 1;
>  };
>  
> -static int relay_pack_data(int pack_objects_out, struct output_state *os)
> +static int relay_pack_data(int pack_objects_out, struct output_state *os,
> +			   int write_packfile_line)
>  {
>  	/*
>  	 * We keep the last byte to ourselves
> @@ -128,6 +131,37 @@ static int relay_pack_data(int pack_objects_out, struct output_state *os)
>  	}
>  	os->used += readsz;
>  
> +	while (!os->packfile_started) {
> +		char *p;
> +		if (os->used >= 4 && !memcmp(os->buffer, "PACK", 4)) {
> +			os->packfile_started = 1;
> +			if (write_packfile_line) {
> +				if (os->packfile_uris_started)
> +					packet_delim(1);
> +				packet_write_fmt(1, "\1packfile\n");
> +			}
> +			break;
> +		}
> +		if ((p = memchr(os->buffer, '\n', os->used))) {
> +			if (!os->packfile_uris_started) {
> +				os->packfile_uris_started = 1;
> +				if (!write_packfile_line)
> +					BUG("packfile_uris requires sideband-all");
> +				packet_write_fmt(1, "\1packfile-uris\n");
> +			}
> +			*p = '\0';
> +			packet_write_fmt(1, "\1uri %s\n", os->buffer);
> +
> +			os->used -= p - os->buffer + 1;
> +			memmove(os->buffer, p + 1, os->used);
> +		} else {
> +			/*
> +			 * Incomplete line.
> +			 */
> +			return readsz;
> +		}
> +	}
> +
>  	if (os->used > 1) {
>  		send_client_data(1, os->buffer, os->used - 1);
>  		os->buffer[0] = os->buffer[os->used - 1];
> @@ -141,7 +175,8 @@ static int relay_pack_data(int pack_objects_out, struct output_state *os)
>  }
>  
>  static void create_pack_file(const struct object_array *have_obj,
> -			     const struct object_array *want_obj)
> +			     const struct object_array *want_obj,
> +			     const struct string_list *uri_protocols)
>  {
>  	struct child_process pack_objects = CHILD_PROCESS_INIT;
>  	struct output_state output_state = {0};
> @@ -192,6 +227,11 @@ static void create_pack_file(const struct object_array *have_obj,
>  					 expanded_filter_spec.buf);
>  		}
>  	}
> +	if (uri_protocols) {
> +		for (i = 0; i < uri_protocols->nr; i++)
> +			argv_array_pushf(&pack_objects.args, "--uri-protocol=%s",
> +					 uri_protocols->items[0].string);
> +	}
>  
>  	pack_objects.in = -1;
>  	pack_objects.out = -1;
> @@ -278,7 +318,8 @@ static void create_pack_file(const struct object_array *have_obj,
>  		}
>  		if (0 <= pu && (pfd[pu].revents & (POLLIN|POLLHUP))) {
>  			int result = relay_pack_data(pack_objects.out,
> -						     &output_state);
> +						     &output_state,
> +						     !!uri_protocols);
>  
>  			if (result == 0) {
>  				close(pack_objects.out);
> @@ -1123,7 +1164,7 @@ void upload_pack(struct upload_pack_options *options)
>  	if (want_obj.nr) {
>  		struct object_array have_obj = OBJECT_ARRAY_INIT;
>  		get_common_commits(&reader, &have_obj, &want_obj);
> -		create_pack_file(&have_obj, &want_obj);
> +		create_pack_file(&have_obj, &want_obj, 0);
>  	}
>  }
>  
> @@ -1138,6 +1179,7 @@ struct upload_pack_data {
>  	timestamp_t deepen_since;
>  	int deepen_rev_list;
>  	int deepen_relative;
> +	struct string_list uri_protocols;
>  
>  	struct packet_writer writer;
>  
> @@ -1157,6 +1199,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
>  	struct oid_array haves = OID_ARRAY_INIT;
>  	struct object_array shallows = OBJECT_ARRAY_INIT;
>  	struct string_list deepen_not = STRING_LIST_INIT_DUP;
> +	struct string_list uri_protocols = STRING_LIST_INIT_DUP;
>  
>  	memset(data, 0, sizeof(*data));
>  	data->wants = wants;
> @@ -1164,6 +1207,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
>  	data->haves = haves;
>  	data->shallows = shallows;
>  	data->deepen_not = deepen_not;
> +	data->uri_protocols = uri_protocols;
>  	packet_writer_init(&data->writer, 1);
>  }
>  
> @@ -1322,9 +1366,17 @@ static void process_args(struct packet_reader *request,
>  			continue;
>  		}
>  
> +		if (skip_prefix(arg, "packfile-uris ", &p)) {
> +			string_list_split(&data->uri_protocols, p, ',', -1);
> +			continue;
> +		}
> +
>  		/* ignore unknown lines maybe? */
>  		die("unexpected line: '%s'", arg);
>  	}
> +
> +	if (data->uri_protocols.nr && !data->writer.use_sideband)
> +		string_list_clear(&data->uri_protocols, 0);
>  }
>  
>  static int process_haves(struct oid_array *haves, struct oid_array *common,
> @@ -1514,8 +1566,13 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
>  			send_wanted_ref_info(&data);
>  			send_shallow_info(&data, &want_obj);
>  
> -			packet_writer_write(&data.writer, "packfile\n");
> -			create_pack_file(&have_obj, &want_obj);
> +			if (data.uri_protocols.nr) {
> +				create_pack_file(&have_obj, &want_obj,
> +						 &data.uri_protocols);
> +			} else {
> +				packet_write_fmt(1, "packfile\n");
> +				create_pack_file(&have_obj, &want_obj, NULL);
> +			}
>  			state = FETCH_DONE;
>  			break;
>  		case FETCH_DONE:
> @@ -1536,6 +1593,7 @@ int upload_pack_advertise(struct repository *r,
>  		int allow_filter_value;
>  		int allow_ref_in_want;
>  		int allow_sideband_all_value;
> +		char *str = NULL;
>  
>  		strbuf_addstr(value, "shallow");
>  
> @@ -1557,6 +1615,14 @@ int upload_pack_advertise(struct repository *r,
>  					   &allow_sideband_all_value) &&
>  		     allow_sideband_all_value))
>  			strbuf_addstr(value, " sideband-all");
> +
> +		if (!repo_config_get_string(the_repository,
> +					    "uploadpack.blobpackfileuri",
> +					    &str) &&
> +		    str) {
> +			strbuf_addstr(value, " packfile-uris");
> +			free(str);
> +		}
>  	}
>  
>  	return 1;
> -- 
> 2.19.0.271.gfe8321ec05.dirty
> 
