Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A07821F404
	for <e@80x24.org>; Wed, 31 Jan 2018 14:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753543AbeAaOke (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 09:40:34 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41245 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbeAaOkc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 09:40:32 -0500
Received: by mail-qt0-f193.google.com with SMTP id i1so22058906qtj.8
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 06:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LSXTSyROK7uCoDZXOgRdz4+jmyYJi5cXlrfT9mkMKXQ=;
        b=Ksr9vNnVOWFqr23TnqVtAPu21dnxNtkWu2s7tOpvMHxKSt0riVqQYcUWXfap6aDCNf
         qWs9+a0BbIdOXpDVMHeIjKE8DbbOw7mqxIvZUY8qCX5r4gT4LNBAFN/wDQMYjgHaORb9
         u16w8S/Yb8Wt9Mwu2lfLEfBuL/Yoa7IHq7HevTLxke4QePshFFl7OpIyutaimctGEPf7
         rffCocn2Mhw2XwP6SBZsji+GmreVu0K/n9jQX5hSrqsvGC4GVk1bLpiDqL1tkoAr916C
         pXhnhYIL0yn4lEOWV8nVPHZ0aqblN8P5Ulvkt6/KsHtxyuKSUO/waeBUDF2DD5Ksjov5
         mUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LSXTSyROK7uCoDZXOgRdz4+jmyYJi5cXlrfT9mkMKXQ=;
        b=GKoBskQaocOGlSgNdHXkTMzm1nvbOH7FYRYTxa/DiuFOYWFPdsI5eU7vUskzd1sPxx
         yBABdfqj2dV9wIJMTIAppncX+fD17PP+zNryyEKd/I607nYyKpK6M0SIXIFVtHrS1ZlY
         4Fo7rE4/rIOb9jzioRlgYvyhqIuqayhGrYcj+Fve06330BKPcq6EgpxUQjHX6YKprNdP
         HNCh63wiqtFv7VuFRZpI+T2eN5RIvtEr6f/Ayoca47TXfNi17R76R8jxzy3Yn5OCx+/k
         6tMahNEqbepE2Ro9AVQuOAaUKXGJZ/Pa95qI0z7WeW2UWf5i0h+f7uqJ7shOWFBxEN9x
         EjuA==
X-Gm-Message-State: AKwxytdXZnTUakjk6DUwBURE5o2q3aP22pGASV32gpAKtbDqXo263qZ9
        7hnQ8bps9R4P0UpjTEVTKaQ=
X-Google-Smtp-Source: AH8x224O6Z0G2lB7sPn+09jR8aenrECwSQk26/Oi5eDX94Jt2DXZT771+06KDoe2sl3BaJ2WGNPJTQ==
X-Received: by 10.237.51.226 with SMTP id v89mr3663005qtd.126.1517409631709;
        Wed, 31 Jan 2018 06:40:31 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id r34sm12902654qtd.48.2018.01.31.06.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 06:40:30 -0800 (PST)
Subject: Re: [PATCH v2 08/27] connect: discover protocol version outside of
 get_remote_heads
To:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, jrnieder@gmail.com
References: <20180103001828.205012-1-bmwill@google.com>
 <20180125235838.138135-1-bmwill@google.com>
 <20180125235838.138135-9-bmwill@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <223c0249-24e3-d714-faa5-3c7166b92e99@gmail.com>
Date:   Wed, 31 Jan 2018 09:40:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180125235838.138135-9-bmwill@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/25/2018 6:58 PM, Brandon Williams wrote:
> In order to prepare for the addition of protocol_v2 push the protocol
> version discovery outside of 'get_remote_heads()'.  This will allow for
> keeping the logic for processing the reference advertisement for
> protocol_v1 and protocol_v0 separate from the logic for protocol_v2.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>   builtin/fetch-pack.c | 16 +++++++++++++++-
>   builtin/send-pack.c  | 17 +++++++++++++++--
>   connect.c            | 27 ++++++++++-----------------
>   connect.h            |  3 +++
>   remote-curl.c        | 20 ++++++++++++++++++--
>   remote.h             |  5 +++--
>   transport.c          | 24 +++++++++++++++++++-----
>   7 files changed, 83 insertions(+), 29 deletions(-)
>
> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index 366b9d13f..85d4faf76 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -4,6 +4,7 @@
>   #include "remote.h"
>   #include "connect.h"
>   #include "sha1-array.h"
> +#include "protocol.h"
>   
>   static const char fetch_pack_usage[] =
>   "git fetch-pack [--all] [--stdin] [--quiet | -q] [--keep | -k] [--thin] "
> @@ -52,6 +53,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>   	struct fetch_pack_args args;
>   	struct oid_array shallow = OID_ARRAY_INIT;
>   	struct string_list deepen_not = STRING_LIST_INIT_DUP;
> +	struct packet_reader reader;
>   
>   	packet_trace_identity("fetch-pack");
>   
> @@ -193,7 +195,19 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>   		if (!conn)
>   			return args.diag_url ? 0 : 1;
>   	}
> -	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, &shallow);
> +
> +	packet_reader_init(&reader, fd[0], NULL, 0,
> +			   PACKET_READ_CHOMP_NEWLINE |
> +			   PACKET_READ_GENTLE_ON_EOF);
> +
> +	switch (discover_version(&reader)) {
> +	case protocol_v1:
> +	case protocol_v0:
> +		get_remote_heads(&reader, &ref, 0, NULL, &shallow);
> +		break;
> +	case protocol_unknown_version:
> +		BUG("unknown protocol version");

Is this really a BUG in the client, or a bug/incompatibility in the server?

Perhaps I'm misunderstanding, but it looks like discover_version() will 
die() on an unknown version (the die() is in 
protocol.c:determine_protocol_version_client()). So maybe that's why 
this is a BUG()?

If there is something to change here, this BUG() appears three more times.

> +	}
>   
>   	ref = fetch_pack(&args, fd, conn, ref, dest, sought, nr_sought,
>   			 &shallow, pack_lockfile_ptr);
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index fc4f0bb5f..83cb125a6 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -14,6 +14,7 @@
>   #include "sha1-array.h"
>   #include "gpg-interface.h"
>   #include "gettext.h"
> +#include "protocol.h"
>   
>   static const char * const send_pack_usage[] = {
>   	N_("git send-pack [--all | --mirror] [--dry-run] [--force] "
> @@ -154,6 +155,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
>   	int progress = -1;
>   	int from_stdin = 0;
>   	struct push_cas_option cas = {0};
> +	struct packet_reader reader;
>   
>   	struct option options[] = {
>   		OPT__VERBOSITY(&verbose),
> @@ -256,8 +258,19 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
>   			args.verbose ? CONNECT_VERBOSE : 0);
>   	}
>   
> -	get_remote_heads(fd[0], NULL, 0, &remote_refs, REF_NORMAL,
> -			 &extra_have, &shallow);
> +	packet_reader_init(&reader, fd[0], NULL, 0,
> +			   PACKET_READ_CHOMP_NEWLINE |
> +			   PACKET_READ_GENTLE_ON_EOF);
> +
> +	switch (discover_version(&reader)) {
> +	case protocol_v1:
> +	case protocol_v0:
> +		get_remote_heads(&reader, &remote_refs, REF_NORMAL,
> +				 &extra_have, &shallow);
> +		break;
> +	case protocol_unknown_version:
> +		BUG("unknown protocol version");
> +	}
>   
>   	transport_verify_remote_names(nr_refspecs, refspecs);
>   
> diff --git a/connect.c b/connect.c
> index 00e90075c..db3c9d24c 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -62,7 +62,7 @@ static void die_initial_contact(int unexpected)
>   		      "and the repository exists."));
>   }
>   
> -static enum protocol_version discover_version(struct packet_reader *reader)
> +enum protocol_version discover_version(struct packet_reader *reader)
>   {
>   	enum protocol_version version = protocol_unknown_version;
>   
> @@ -234,7 +234,7 @@ enum get_remote_heads_state {
>   /*
>    * Read all the refs from the other end
>    */
> -struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
> +struct ref **get_remote_heads(struct packet_reader *reader,
>   			      struct ref **list, unsigned int flags,
>   			      struct oid_array *extra_have,
>   			      struct oid_array *shallow_points)
> @@ -242,24 +242,17 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>   	struct ref **orig_list = list;
>   	int len = 0;
>   	enum get_remote_heads_state state = EXPECTING_FIRST_REF;
> -	struct packet_reader reader;
>   	const char *arg;
>   
> -	packet_reader_init(&reader, in, src_buf, src_len,
> -			   PACKET_READ_CHOMP_NEWLINE |
> -			   PACKET_READ_GENTLE_ON_EOF);
> -
> -	discover_version(&reader);
> -
>   	*list = NULL;
>   
>   	while (state != EXPECTING_DONE) {
> -		switch (packet_reader_read(&reader)) {
> +		switch (packet_reader_read(reader)) {
>   		case PACKET_READ_EOF:
>   			die_initial_contact(1);
>   		case PACKET_READ_NORMAL:
> -			len = reader.pktlen;
> -			if (len > 4 && skip_prefix(reader.line, "ERR ", &arg))
> +			len = reader->pktlen;
> +			if (len > 4 && skip_prefix(reader->line, "ERR ", &arg))
>   				die("remote error: %s", arg);
>   			break;
>   		case PACKET_READ_FLUSH:
> @@ -271,22 +264,22 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>   
>   		switch (state) {
>   		case EXPECTING_FIRST_REF:
> -			process_capabilities(reader.line, &len);
> -			if (process_dummy_ref(reader.line)) {
> +			process_capabilities(reader->line, &len);
> +			if (process_dummy_ref(reader->line)) {
>   				state = EXPECTING_SHALLOW;
>   				break;
>   			}
>   			state = EXPECTING_REF;
>   			/* fallthrough */
>   		case EXPECTING_REF:
> -			if (process_ref(reader.line, len, &list, flags, extra_have))
> +			if (process_ref(reader->line, len, &list, flags, extra_have))
>   				break;
>   			state = EXPECTING_SHALLOW;
>   			/* fallthrough */
>   		case EXPECTING_SHALLOW:
> -			if (process_shallow(reader.line, len, shallow_points))
> +			if (process_shallow(reader->line, len, shallow_points))
>   				break;
> -			die("protocol error: unexpected '%s'", reader.line);
> +			die("protocol error: unexpected '%s'", reader->line);
>   		case EXPECTING_DONE:
>   			break;
>   		}
> diff --git a/connect.h b/connect.h
> index 01f14cdf3..cdb8979dc 100644
> --- a/connect.h
> +++ b/connect.h
> @@ -13,4 +13,7 @@ extern int parse_feature_request(const char *features, const char *feature);
>   extern const char *server_feature_value(const char *feature, int *len_ret);
>   extern int url_is_local_not_ssh(const char *url);
>   
> +struct packet_reader;
> +extern enum protocol_version discover_version(struct packet_reader *reader);
> +
>   #endif
> diff --git a/remote-curl.c b/remote-curl.c
> index 0053b0954..9f6d07683 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -1,6 +1,7 @@
>   #include "cache.h"
>   #include "config.h"
>   #include "remote.h"
> +#include "connect.h"
>   #include "strbuf.h"
>   #include "walker.h"
>   #include "http.h"
> @@ -13,6 +14,7 @@
>   #include "credential.h"
>   #include "sha1-array.h"
>   #include "send-pack.h"
> +#include "protocol.h"
>   
>   static struct remote *remote;
>   /* always ends with a trailing slash */
> @@ -176,8 +178,22 @@ static struct discovery *last_discovery;
>   static struct ref *parse_git_refs(struct discovery *heads, int for_push)
>   {
>   	struct ref *list = NULL;
> -	get_remote_heads(-1, heads->buf, heads->len, &list,
> -			 for_push ? REF_NORMAL : 0, NULL, &heads->shallow);
> +	struct packet_reader reader;
> +
> +	packet_reader_init(&reader, -1, heads->buf, heads->len,
> +			   PACKET_READ_CHOMP_NEWLINE |
> +			   PACKET_READ_GENTLE_ON_EOF);
> +
> +	switch (discover_version(&reader)) {
> +	case protocol_v1:
> +	case protocol_v0:
> +		get_remote_heads(&reader, &list, for_push ? REF_NORMAL : 0,
> +				 NULL, &heads->shallow);
> +		break;
> +	case protocol_unknown_version:
> +		BUG("unknown protocol version");
> +	}
> +
>   	return list;
>   }
>   
> diff --git a/remote.h b/remote.h
> index 1f6611be2..2016461df 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -150,10 +150,11 @@ int check_ref_type(const struct ref *ref, int flags);
>   void free_refs(struct ref *ref);
>   
>   struct oid_array;
> -extern struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
> +struct packet_reader;
> +extern struct ref **get_remote_heads(struct packet_reader *reader,
>   				     struct ref **list, unsigned int flags,
>   				     struct oid_array *extra_have,
> -				     struct oid_array *shallow);
> +				     struct oid_array *shallow_points);
>   
>   int resolve_remote_symref(struct ref *ref, struct ref *list);
>   int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid);
> diff --git a/transport.c b/transport.c
> index 8e8779096..63c3dbab9 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -18,6 +18,7 @@
>   #include "sha1-array.h"
>   #include "sigchain.h"
>   #include "transport-internal.h"
> +#include "protocol.h"
>   
>   static void set_upstreams(struct transport *transport, struct ref *refs,
>   	int pretend)
> @@ -190,13 +191,26 @@ static int connect_setup(struct transport *transport, int for_push)
>   static struct ref *get_refs_via_connect(struct transport *transport, int for_push)
>   {
>   	struct git_transport_data *data = transport->data;
> -	struct ref *refs;
> +	struct ref *refs = NULL;
> +	struct packet_reader reader;
>   
>   	connect_setup(transport, for_push);
> -	get_remote_heads(data->fd[0], NULL, 0, &refs,
> -			 for_push ? REF_NORMAL : 0,
> -			 &data->extra_have,
> -			 &data->shallow);
> +
> +	packet_reader_init(&reader, data->fd[0], NULL, 0,
> +			   PACKET_READ_CHOMP_NEWLINE |
> +			   PACKET_READ_GENTLE_ON_EOF);
> +
> +	switch (discover_version(&reader)) {
> +	case protocol_v1:
> +	case protocol_v0:
> +		get_remote_heads(&reader, &refs,
> +				 for_push ? REF_NORMAL : 0,
> +				 &data->extra_have,
> +				 &data->shallow);
> +		break;
> +	case protocol_unknown_version:
> +		BUG("unknown protocol version");
> +	}
>   	data->got_remote_heads = 1;
>   
>   	return refs;

