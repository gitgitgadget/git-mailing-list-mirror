Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1CC11F404
	for <e@80x24.org>; Wed, 31 Jan 2018 15:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932125AbeAaPkE (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 10:40:04 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:47075 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932085AbeAaPkD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 10:40:03 -0500
Received: by mail-qk0-f176.google.com with SMTP id l64so15257540qke.13
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 07:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZDOA73fy3/+rDe1yF3pKoK43uwDepjll959aXKlN04Y=;
        b=EMSKTvIjUgsLHbZRGnyP4xtr7sumXt9DYPkOmp1bpLlcbYkkO2hOG2BSZGj65PZrxe
         pH+JK15kNK/jUOwGiEUmFzK1TB2mLeRKoO1Lyk35N0lR/iu83PR5xoc6BLlwDNY+R6u7
         ebLEzC/z3fj70EaASnEr3orNjcKBySTx+zbmx3XBQCdMLiksp/qF7DiloCl6+Eg3g7O7
         f0jIShE4vZpl5tNe2q1lm9voa52c4WzHPb6+Q0hzVHIQfpTYWq0EsAcRwPeUH/JwwQnx
         M5Wf2SHtH6de4EysPZfRnbUKpLdOc05tc7o7pr2Bm9tFBKfhgrgqD64eEgDdMelIgGbz
         fOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZDOA73fy3/+rDe1yF3pKoK43uwDepjll959aXKlN04Y=;
        b=rTQ3kRz8PFI5dhvx5TdG75WcsGbqw0F2Iw6dNm89oYXHDXb2oRsWxr7NexAbffBQPQ
         H+rU3Pft14gYBVQpmnkWsUK0foySBMbil3OyK14FFyt9tg2xnqHLzXu64KqnFYLg+Hcb
         oiGVAz7g2vQKcYq4WGeEYAOsV4mCZb6WRdfWvwpwe3uB4kRNHHtxDezs4AEG062DuONA
         ud3hrNDPrr3i23A1BrVeAUlfjhZdk9JkhV2gADVJPDd305k6KWAHmdRdHTgaDeS8Qh6f
         ySHrnS/FLFrNtCVOyzkNuok7zRg8TzLeeSxqGg+LM28G0ROotFak3kcTNNFRnpGhGzFl
         jg1Q==
X-Gm-Message-State: AKwxyteYwtaYJ/eBJxdRuIP+697Kt9M4zpqcA2UQJ5bT/XboxzMRENlw
        k/ENYEGVhQg9BsW3DmP8crw=
X-Google-Smtp-Source: AH8x2250ouma20k1xwaC7og8Zw4vXjILXmMuTvicXO1NGKE/6VkcJKSPlcbmKiQ/E3e3RO3z0Drkuw==
X-Received: by 10.55.138.68 with SMTP id m65mr47026700qkd.166.1517413202176;
        Wed, 31 Jan 2018 07:40:02 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id y123sm11082454qka.42.2018.01.31.07.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 07:40:01 -0800 (PST)
Subject: Re: [PATCH v2 12/27] serve: introduce git-serve
To:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, jrnieder@gmail.com
References: <20180103001828.205012-1-bmwill@google.com>
 <20180125235838.138135-1-bmwill@google.com>
 <20180125235838.138135-13-bmwill@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a9500d32-3f0a-4979-dcde-fb2acf0b3434@gmail.com>
Date:   Wed, 31 Jan 2018 10:39:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180125235838.138135-13-bmwill@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/25/2018 6:58 PM, Brandon Williams wrote:
> Introduce git-serve, the base server for protocol version 2.
>
> Protocol version 2 is intended to be a replacement for Git's current
> wire protocol.  The intention is that it will be a simpler, less
> wasteful protocol which can evolve over time.
>
> Protocol version 2 improves upon version 1 by eliminating the initial
> ref advertisement.  In its place a server will export a list of
> capabilities and commands which it supports in a capability
> advertisement.  A client can then request that a particular command be
> executed by providing a number of capabilities and command specific
> parameters.  At the completion of a command, a client can request that
> another command be executed or can terminate the connection by sending a
> flush packet.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>   .gitignore                              |   1 +
>   Documentation/technical/protocol-v2.txt | 117 +++++++++++++++
>   Makefile                                |   2 +
>   builtin.h                               |   1 +
>   builtin/serve.c                         |  30 ++++
>   git.c                                   |   1 +
>   serve.c                                 | 249 ++++++++++++++++++++++++++++++++
>   serve.h                                 |  15 ++
>   t/t5701-git-serve.sh                    |  56 +++++++
>   9 files changed, 472 insertions(+)
>   create mode 100644 Documentation/technical/protocol-v2.txt
>   create mode 100644 builtin/serve.c
>   create mode 100644 serve.c
>   create mode 100644 serve.h
>   create mode 100755 t/t5701-git-serve.sh
>
> diff --git a/.gitignore b/.gitignore
> index 833ef3b0b..2d0450c26 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -140,6 +140,7 @@
>   /git-rm
>   /git-send-email
>   /git-send-pack
> +/git-serve
>   /git-sh-i18n
>   /git-sh-i18n--envsubst
>   /git-sh-setup
> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> new file mode 100644
> index 000000000..7f619a76c
> --- /dev/null
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -0,0 +1,117 @@
> + Git Wire Protocol, Version 2
> +==============================
> +
> +This document presents a specification for a version 2 of Git's wire
> +protocol.  Protocol v2 will improve upon v1 in the following ways:
> +
> +  * Instead of multiple service names, multiple commands will be
> +    supported by a single service.

As someone unfamiliar with the old protocol code, this statement is 
underselling the architectural significance of your change. The new 
model allows a single service to handle all different wire protocols 
(git://, ssh://, https://) while being agnostic to the command-specific 
logic. It also hides the protocol negotiation away from these consumers.

The ease with which you are adding new commands in later commits really 
demonstrates the value of this patch. To make that point here, you would 
almost need to document the old model to show how it was difficult to 
use and extend. Perhaps this document will not need expanding since the 
code speaks for itself.

I just wanted to state for the record that the new architecture is a big 
improvement and will make more commands much easier to implement.

> +  * Easily extendable as capabilities are moved into their own section
> +    of the protocol, no longer being hidden behind a NUL byte and
> +    limited by the size of a pkt-line (as there will be a single
> +    capability per pkt-line).
> +  * Separate out other information hidden behind NUL bytes (e.g. agent
> +    string as a capability and symrefs can be requested using 'ls-refs')
> +  * Reference advertisement will be omitted unless explicitly requested
> +  * ls-refs command to explicitly request some refs
> +

nit: some bullets have full stops (.) and others do not.

> + Detailed Design
> +=================
> +
> +A client can request to speak protocol v2 by sending `version=2` in the
> +side-channel `GIT_PROTOCOL` in the initial request to the server.
> +
> +In protocol v2 communication is command oriented.  When first contacting a
> +server a list of capabilities will advertised.  Some of these capabilities
> +will be commands which a client can request be executed.  Once a command
> +has completed, a client can reuse the connection and request that other
> +commands be executed.
> +
> + Special Packets
> +-----------------
> +
> +In protocol v2 these special packets will have the following semantics:
> +
> +  * '0000' Flush Packet (flush-pkt) - indicates the end of a message
> +  * '0001' Delimiter Packet (delim-pkt) - separates sections of a message
> +
> + Capability Advertisement
> +--------------------------
> +
> +A server which decides to communicate (based on a request from a client)
> +using protocol version 2, notifies the client by sending a version string
> +in its initial response followed by an advertisement of its capabilities.
> +Each capability is a key with an optional value.  Clients must ignore all
> +unknown keys.  Semantics of unknown values are left to the definition of
> +each key.  Some capabilities will describe commands which can be requested
> +to be executed by the client.
> +
> +    capability-advertisement = protocol-version
> +			       capability-list
> +			       flush-pkt
> +
> +    protocol-version = PKT-LINE("version 2" LF)
> +    capability-list = *capability
> +    capability = PKT-LINE(key[=value] LF)
> +
> +    key = 1*CHAR
> +    value = 1*CHAR
> +    CHAR = 1*(ALPHA / DIGIT / "-" / "_")
> +
> +A client then responds to select the command it wants with any particular
> +capabilities or arguments.  There is then an optional section where the
> +client can provide any command specific parameters or queries.
> +
> +    command-request = command
> +		      capability-list
> +		      (command-args)
> +		      flush-pkt
> +    command = PKT-LINE("command=" key LF)
> +    command-args = delim-pkt
> +		   *arg
> +    arg = 1*CHAR
> +
> +The server will then check to ensure that the client's request is
> +comprised of a valid command as well as valid capabilities which were
> +advertised.  If the request is valid the server will then execute the
> +command.
> +
> +When a command has finished a client can either request that another
> +command be executed or can terminate the connection by sending an empty
> +request consisting of just a flush-pkt.
> +
> + Capabilities
> +~~~~~~~~~~~~~~
> +
> +There are two different types of capabilities: normal capabilities,
> +which can be used to to convey information or alter the behavior of a
> +request, and command capabilities, which are the core actions that a
> +client wants to perform (fetch, push, etc).
> +
> + agent
> +-------
> +
> +The server can advertise the `agent` capability with a value `X` (in the
> +form `agent=X`) to notify the client that the server is running version
> +`X`.  The client may optionally send its own agent string by including
> +the `agent` capability with a value `Y` (in the form `agent=Y`) in its
> +request to the server (but it MUST NOT do so if the server did not
> +advertise the agent capability). The `X` and `Y` strings may contain any
> +printable ASCII characters except space (i.e., the byte range 32 < x <
> +127), and are typically of the form "package/version" (e.g.,
> +"git/1.8.3.1"). The agent strings are purely informative for statistics
> +and debugging purposes, and MUST NOT be used to programmatically assume
> +the presence or absence of particular features.
> +
> + stateless-rpc
> +---------------
> +
> +If advertised, the `stateless-rpc` capability indicates that the server
> +supports running commands in a stateless-rpc mode, which means that a
> +command lasts for only a single request-response round.
> +
> +Normally a command can last for as many rounds as are required to
> +complete it (multiple for negotiation during fetch or no additional
> +trips in the case of ls-refs).  If the client sends the `stateless-rpc`
> +capability with a value of `true` (in the form `stateless-rpc=true`)
> +then the invoked command must only last a single round.
> diff --git a/Makefile b/Makefile
> index 3b849c060..18c255428 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -881,6 +881,7 @@ LIB_OBJS += revision.o
>   LIB_OBJS += run-command.o
>   LIB_OBJS += send-pack.o
>   LIB_OBJS += sequencer.o
> +LIB_OBJS += serve.o
>   LIB_OBJS += server-info.o
>   LIB_OBJS += setup.o
>   LIB_OBJS += sha1-array.o
> @@ -1014,6 +1015,7 @@ BUILTIN_OBJS += builtin/rev-parse.o
>   BUILTIN_OBJS += builtin/revert.o
>   BUILTIN_OBJS += builtin/rm.o
>   BUILTIN_OBJS += builtin/send-pack.o
> +BUILTIN_OBJS += builtin/serve.o
>   BUILTIN_OBJS += builtin/shortlog.o
>   BUILTIN_OBJS += builtin/show-branch.o
>   BUILTIN_OBJS += builtin/show-ref.o
> diff --git a/builtin.h b/builtin.h
> index f332a1257..3f3fdfc28 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -215,6 +215,7 @@ extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
>   extern int cmd_revert(int argc, const char **argv, const char *prefix);
>   extern int cmd_rm(int argc, const char **argv, const char *prefix);
>   extern int cmd_send_pack(int argc, const char **argv, const char *prefix);
> +extern int cmd_serve(int argc, const char **argv, const char *prefix);
>   extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
>   extern int cmd_show(int argc, const char **argv, const char *prefix);
>   extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
> diff --git a/builtin/serve.c b/builtin/serve.c
> new file mode 100644
> index 000000000..d3fd240bb
> --- /dev/null
> +++ b/builtin/serve.c
> @@ -0,0 +1,30 @@
> +#include "cache.h"
> +#include "builtin.h"
> +#include "parse-options.h"
> +#include "serve.h"
> +
> +static char const * const serve_usage[] = {
> +	N_("git serve [<options>]"),
> +	NULL
> +};
> +
> +int cmd_serve(int argc, const char **argv, const char *prefix)
> +{
> +	struct serve_options opts = SERVE_OPTIONS_INIT;
> +
> +	struct option options[] = {
> +		OPT_BOOL(0, "stateless-rpc", &opts.stateless_rpc,
> +			 N_("quit after a single request/response exchange")),
> +		OPT_BOOL(0, "advertise-capabilities", &opts.advertise_capabilities,
> +			 N_("exit immediately after advertising capabilities")),
> +		OPT_END()
> +	};
> +
> +	/* ignore all unknown cmdline switches for now */
> +	argc = parse_options(argc, argv, prefix, options, serve_usage,
> +			     PARSE_OPT_KEEP_DASHDASH |
> +			     PARSE_OPT_KEEP_UNKNOWN);
> +	serve(&opts);
> +
> +	return 0;
> +}
> diff --git a/git.c b/git.c
> index f71073dc8..f85d682b6 100644
> --- a/git.c
> +++ b/git.c
> @@ -461,6 +461,7 @@ static struct cmd_struct commands[] = {
>   	{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
>   	{ "rm", cmd_rm, RUN_SETUP },
>   	{ "send-pack", cmd_send_pack, RUN_SETUP },
> +	{ "serve", cmd_serve, RUN_SETUP },
>   	{ "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
>   	{ "show", cmd_show, RUN_SETUP },
>   	{ "show-branch", cmd_show_branch, RUN_SETUP },
> diff --git a/serve.c b/serve.c
> new file mode 100644
> index 000000000..90e3defe8
> --- /dev/null
> +++ b/serve.c
> @@ -0,0 +1,249 @@
> +#include "cache.h"
> +#include "repository.h"
> +#include "config.h"
> +#include "pkt-line.h"
> +#include "version.h"
> +#include "argv-array.h"
> +#include "serve.h"
> +
> +static int always_advertise(struct repository *r,
> +			    struct strbuf *value)
> +{
> +	return 1;
> +}
> +
> +static int agent_advertise(struct repository *r,
> +			   struct strbuf *value)
> +{
> +	if (value)
> +		strbuf_addstr(value, git_user_agent_sanitized());
> +	return 1;
> +}
> +
> +struct protocol_capability {
> +	/*
> +	 * The name of the capability.  The server uses this name when
> +	 * advertising this capability, and the client uses this name to
> +	 * specify this capability.
> +	 */
> +	const char *name;
> +
> +	/*
> +	 * Function queried to see if a capability should be advertised.
> +	 * Optionally a value can be specified by adding it to 'value'.
> +	 * If a value is added to 'value', the server will advertise this
> +	 * capability as "<name>=<value>" instead of "<name>".
> +	 */
> +	int (*advertise)(struct repository *r, struct strbuf *value);
> +
> +	/*
> +	 * Function called when a client requests the capability as a command.
> +	 * The command request will be provided to the function via 'keys', the
> +	 * capabilities requested, and 'args', the command specific parameters.
> +	 *
> +	 * This field should be NULL for capabilities which are not commands.
> +	 */
> +	int (*command)(struct repository *r,
> +		       struct argv_array *keys,
> +		       struct argv_array *args);
> +};
> +
> +static struct protocol_capability capabilities[] = {
> +	{ "agent", agent_advertise, NULL },
> +	{ "stateless-rpc", always_advertise, NULL },
> +};
> +
> +static void advertise_capabilities(void)
> +{
> +	struct strbuf capability = STRBUF_INIT;
> +	struct strbuf value = STRBUF_INIT;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(capabilities); i++) {
> +		struct protocol_capability *c = &capabilities[i];
> +
> +		if (c->advertise(the_repository, &value)) {
> +			strbuf_addstr(&capability, c->name);
> +
> +			if (value.len) {
> +				strbuf_addch(&capability, '=');
> +				strbuf_addbuf(&capability, &value);
> +			}
> +
> +			strbuf_addch(&capability, '\n');
> +			packet_write(1, capability.buf, capability.len);
> +		}
> +
> +		strbuf_reset(&capability);
> +		strbuf_reset(&value);
> +	}
> +
> +	packet_flush(1);
> +	strbuf_release(&capability);
> +	strbuf_release(&value);
> +}
> +
> +static struct protocol_capability *get_capability(const char *key)
> +{
> +	int i;
> +
> +	if (!key)
> +		return NULL;
> +
> +	for (i = 0; i < ARRAY_SIZE(capabilities); i++) {
> +		struct protocol_capability *c = &capabilities[i];
> +		const char *out;
> +		if (skip_prefix(key, c->name, &out) && (!*out || *out == '='))
> +			return c;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int is_valid_capability(const char *key)
> +{
> +	const struct protocol_capability *c = get_capability(key);
> +
> +	return c && c->advertise(the_repository, NULL);
> +}
> +
> +static int is_command(const char *key, struct protocol_capability **command)
> +{
> +	const char *out;
> +
> +	if (skip_prefix(key, "command=", &out)) {
> +		struct protocol_capability *cmd = get_capability(out);
> +
> +		if (!cmd || !cmd->advertise(the_repository, NULL) || !cmd->command)
> +			die("invalid command '%s'", out);
> +		if (*command)
> +			die("command already requested");
> +
> +		*command = cmd;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +int has_capability(const struct argv_array *keys, const char *capability,
> +		   const char **value)
> +{
> +	int i;
> +	for (i = 0; i < keys->argc; i++) {
> +		const char *out;
> +		if (skip_prefix(keys->argv[i], capability, &out) &&
> +		    (!*out || *out == '=')) {
> +			if (value) {
> +				if (*out == '=')
> +					out++;
> +				*value = out;
> +			}
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +enum request_state {
> +	PROCESS_REQUEST_KEYS = 0,
> +	PROCESS_REQUEST_ARGS,
> +	PROCESS_REQUEST_DONE,
> +};
> +
> +static int process_request(void)
> +{
> +	enum request_state state = PROCESS_REQUEST_KEYS;
> +	char *buffer = packet_buffer;
> +	unsigned buffer_size = sizeof(packet_buffer);
> +	int pktlen;
> +	struct argv_array keys = ARGV_ARRAY_INIT;
> +	struct argv_array args = ARGV_ARRAY_INIT;
> +	struct protocol_capability *command = NULL;
> +
> +	while (state != PROCESS_REQUEST_DONE) {
> +		switch (packet_read_with_status(0, NULL, NULL, buffer,
> +						buffer_size, &pktlen,
> +						PACKET_READ_CHOMP_NEWLINE)) {
> +		case PACKET_READ_EOF:
> +			BUG("Should have already died when seeing EOF");
> +		case PACKET_READ_NORMAL:
> +			break;
> +		case PACKET_READ_FLUSH:
> +			state = PROCESS_REQUEST_DONE;
> +			continue;
> +		case PACKET_READ_DELIM:
> +			if (state != PROCESS_REQUEST_KEYS)
> +				die("protocol error");
> +			state = PROCESS_REQUEST_ARGS;
> +			/*
> +			 * maybe include a check to make sure that a
> +			 * command/capabilities were given.
> +			 */
> +			continue;
> +		}
> +
> +		switch (state) {
> +		case PROCESS_REQUEST_KEYS:
> +			/* collect request; a sequence of keys and values */
> +			if (is_command(buffer, &command) ||
> +			    is_valid_capability(buffer))
> +				argv_array_push(&keys, buffer);
> +			else
> +				die("unknown capability '%s'", buffer);
> +			break;
> +		case PROCESS_REQUEST_ARGS:
> +			/* collect arguments for the requested command */
> +			argv_array_push(&args, buffer);
> +			break;
> +		case PROCESS_REQUEST_DONE:
> +			continue;
> +		}
> +	}
> +
> +	/*
> +	 * If no command and no keys were given then the client wanted to
> +	 * terminate the connection.
> +	 */
> +	if (!keys.argc && !args.argc)
> +		return 1;
> +
> +	if (!command)
> +		die("no command requested");
> +
> +	command->command(the_repository, &keys, &args);
> +
> +	argv_array_clear(&keys);
> +	argv_array_clear(&args);
> +	return 0;
> +}
> +
> +/* Main serve loop for protocol version 2 */
> +void serve(struct serve_options *options)
> +{
> +	if (options->advertise_capabilities || !options->stateless_rpc) {
> +		/* serve by default supports v2 */
> +		packet_write_fmt(1, "version 2\n");
> +
> +		advertise_capabilities();
> +		/*
> +		 * If only the list of capabilities was requested exit
> +		 * immediately after advertising capabilities
> +		 */
> +		if (options->advertise_capabilities)
> +			return;
> +	}
> +
> +	/*
> +	 * If stateless-rpc was requested then exit after
> +	 * a single request/response exchange
> +	 */
> +	if (options->stateless_rpc) {
> +		process_request();
> +	} else {
> +		for (;;)
> +			if (process_request())
> +				break;
> +	}
> +}
> diff --git a/serve.h b/serve.h
> new file mode 100644
> index 000000000..fe65ba9f4
> --- /dev/null
> +++ b/serve.h
> @@ -0,0 +1,15 @@
> +#ifndef SERVE_H
> +#define SERVE_H
> +
> +struct argv_array;
> +extern int has_capability(const struct argv_array *keys, const char *capability,
> +			  const char **value);
> +
> +struct serve_options {
> +	unsigned advertise_capabilities;
> +	unsigned stateless_rpc;
> +};
> +#define SERVE_OPTIONS_INIT { 0 }
> +extern void serve(struct serve_options *options);
> +
> +#endif /* SERVE_H */
> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> new file mode 100755
> index 000000000..b5cc049e5
> --- /dev/null
> +++ b/t/t5701-git-serve.sh
> @@ -0,0 +1,56 @@
> +#!/bin/sh
> +
> +test_description='test git-serve and server commands'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'test capability advertisement' '
> +	cat >expect <<-EOF &&
> +	version 2
> +	agent=git/$(git version | cut -d" " -f3)
> +	stateless-rpc
> +	0000
> +	EOF
> +
> +	git serve --advertise-capabilities >out &&
> +	test-pkt-line unpack <out >actual &&
> +	test_cmp actual expect
> +'
> +
> +test_expect_success 'stateless-rpc flag does not list capabilities' '
> +	test-pkt-line pack >in <<-EOF &&
> +	0000
> +	EOF
> +	git serve --stateless-rpc >out <in &&
> +	test_must_be_empty out
> +'
> +
> +test_expect_success 'request invalid capability' '
> +	test-pkt-line pack >in <<-EOF &&
> +	foobar
> +	0000
> +	EOF
> +	test_must_fail git serve --stateless-rpc 2>err <in &&
> +	test_i18ngrep "unknown capability" err
> +'
> +
> +test_expect_success 'request with no command' '
> +	test-pkt-line pack >in <<-EOF &&
> +	agent=git/test
> +	0000
> +	EOF
> +	test_must_fail git serve --stateless-rpc 2>err <in &&
> +	test_i18ngrep "no command requested" err
> +'
> +
> +test_expect_success 'request invalid command' '
> +	test-pkt-line pack >in <<-EOF &&
> +	command=foo
> +	agent=git/test
> +	0000
> +	EOF
> +	test_must_fail git serve --stateless-rpc 2>err <in &&
> +	test_i18ngrep "invalid command" err
> +'
> +
> +test_done

