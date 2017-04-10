Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B543720966
	for <e@80x24.org>; Mon, 10 Apr 2017 12:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752880AbdDJMl4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 08:41:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35260 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752750AbdDJMlz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 08:41:55 -0400
Received: by mail-wm0-f68.google.com with SMTP id d79so9450543wmi.2
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 05:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gIwepm41/E0u/bqm4hC5rXu9mWV4zXqp7CzFTah9MJ8=;
        b=BSv88SLCY4qoWnYUa0q22WNtALZginEvNp+B7bveqs8fGsK0MCJ7Y+tsB/jD3y2AW5
         B9d39DdlCRmTBAu5kllKUzr+K4t6WHH0bZwZRVGWUX9xkX2g6PwKC3srCEuTFKMjmHXv
         DaClOQNajCjxpk3E/1D2HihCAyukGQwkgHow7FFs6QOMFY2PBAj76L6ykwfKIRnNNMRY
         zWcJVCI0TqEAlnetWv/epO2BvXG+jXN1i72pOh6tuEYLSLvz4iC/veO7KOVKKp7xqmSy
         IYNQHZETLonOz4GQU9DyuktGMmw2sjtLQZLDqA1i8MxwHsVKhuWOjNr9clFDFnDCZUqF
         bapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gIwepm41/E0u/bqm4hC5rXu9mWV4zXqp7CzFTah9MJ8=;
        b=Q09y5AUwajniOUihHD8cT2/StGC5FyNTd64qmwn1Am8011T0l1NDL3kWs9/gGJ6PnI
         SnT/GEJoPRUlsDlRf2lwNtLurqHs1wprqdyS9wSYoHA2XfmrM2Oo7mRbvcTm4Md545JE
         r0m3SsfjnL1f06edTw8JaeXDCFX00oa7IkZlWuTLt8e1XdnLtz+WeC/epW0WvUNnDc6W
         n0gcjjMr/93nv4tIcgFl1JnC6gNzbdO+c+W2cOIdsyEH4qnf2vODksWXhirMXpBIBdCt
         VzfqtTqHoblPOeBu0LyCEJvOsbFmYCsKHhXYblKzWRHuHGDHzQeHGu3mubR1Cc64XgZP
         YtWA==
X-Gm-Message-State: AN3rC/4D7Nxz5dBhEtnL5jcgkidJKY32vXn+vJrKPE1b+M4IPRekXIB2
        +JaJwZ8hlzQSmg==
X-Received: by 10.28.144.200 with SMTP id s191mr9916312wmd.27.1491828114025;
        Mon, 10 Apr 2017 05:41:54 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 3sm11097029wrv.33.2017.04.10.05.41.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 05:41:53 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 7/8] sub-process: move sub-process functions into separate files
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170407120354.17736-8-benpeart@microsoft.com>
Date:   Mon, 10 Apr 2017 14:41:52 +0200
Cc:     git@vger.kernel.org, gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <40AA3048-3B05-4950-8981-942DB58B464F@gmail.com>
References: <20170407120354.17736-1-benpeart@microsoft.com> <20170407120354.17736-8-benpeart@microsoft.com>
To:     Ben Peart <peartben@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Apr 2017, at 14:03, Ben Peart <peartben@gmail.com> wrote:
>=20
> Move the sub-proces functions into sub-process.h/c.  Add documentation
> for the new module in Documentation/technical/api-sub-process.txt
>=20
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
> Documentation/technical/api-sub-process.txt |  54 +++++++++++++
> Makefile                                    |   1 +
> convert.c                                   | 119 =
+---------------------------
> sub-process.c                               | 116 =
+++++++++++++++++++++++++++
> sub-process.h                               |  46 +++++++++++
> 5 files changed, 218 insertions(+), 118 deletions(-)
> create mode 100644 Documentation/technical/api-sub-process.txt
> create mode 100644 sub-process.c
> create mode 100644 sub-process.h
>=20
> diff --git a/Documentation/technical/api-sub-process.txt =
b/Documentation/technical/api-sub-process.txt
> new file mode 100644
> index 0000000000..eb5005aa72
> --- /dev/null
> +++ b/Documentation/technical/api-sub-process.txt
> @@ -0,0 +1,54 @@
> +sub-process API
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The sub-process API makes it possible to run background sub-processes
> +that should run until the git command exits and communicate with it
> +through stdin and stdout.  This reduces the overhead of having to =
fork
> +a new process each time it needs to be communicated with.

Minor nit, maybe:
The sub-process API makes it possible to run background sub-processes
for the entire lifetime of a Git invocation. If Git needs to communicate
with an external process multiple times, then this can reduces the =
process
invocation overhead. Git and the sub-process communicate through stdin =
and=20
stdout.=20

Feel free to ignore as this is bike-shedding.


> +
> +The sub-processes are kept in a hashmap by command name and looked up
> +via the subprocess_find_entry function.  If an existing instance can =
not
> +be found then a new process should be created and started.  When the
> +parent git command terminates, all sub-processes are also terminated.
> +
> +This API is based on the run-command API.
> +
> +Data structures
> +---------------
> +
> +* `struct subprocess_entry`
> +
> +The sub-process structure.  Members should not be accessed directly.
> +
> +Types
> +-----
> +
> +'int(*subprocess_start_fn)(struct subprocess_entry *entry)'::
> +
> +	User-supplied function to initialize the sub-process.  This is
> +	typically used to negoiate the interface version and =
capabilities.
s/negoiate/negotiate/


> +
> +
> +Functions
> +---------
> +
> +`subprocess_start`::
> +
> +	Start a subprocess and add it to the subprocess hashmap.
> +
> +`subprocess_stop`::
> +
> +	Kill a subprocess and remove it from the subprocess hashmap.
> +
> +`subprocess_find_entry`::
> +
> +	Find a subprocess in the subprocess hashmap.

As mentioned in an earlier review, this function also initializes the
hashmap as (maybe to the user unexpected?) side effect.

=
http://public-inbox.org/git/48FA4601-0819-4DE2-943A-7A791BA7C583@gmail.com=
/


> +
> +`subprocess_get_child_process`::
> +
> +	Get the underlying `struct child_process` from a subprocess.
> +
> +`subprocess_read_status`::
> +
> +	Helper function to read packets looking for the last =
"status=3D<foo>"
> +	key/value pair.
> diff --git a/Makefile b/Makefile
> index 9f8b35ad41..add945b560 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -838,6 +838,7 @@ LIB_OBJS +=3D streaming.o
> LIB_OBJS +=3D string-list.o
> LIB_OBJS +=3D submodule.o
> LIB_OBJS +=3D submodule-config.o
> +LIB_OBJS +=3D sub-process.o
> LIB_OBJS +=3D symlinks.o
> LIB_OBJS +=3D tag.o
> LIB_OBJS +=3D tempfile.o
> diff --git a/convert.c b/convert.c
> index 235a6a5279..baa41da760 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -4,6 +4,7 @@
> #include "quote.h"
> #include "sigchain.h"
> #include "pkt-line.h"
> +#include "sub-process.h"
>=20
> /*
>  * convert.c - convert a file when checking it out and checking it in.
> @@ -496,86 +497,11 @@ static int apply_single_file_filter(const char =
*path, const char *src, size_t le
> #define CAP_CLEAN    (1u<<0)
> #define CAP_SMUDGE   (1u<<1)
>=20
> -struct subprocess_entry {
> -	struct hashmap_entry ent; /* must be the first member! */
> -	const char *cmd;
> -	struct child_process process;
> -};
> -
> struct cmd2process {
> 	struct subprocess_entry subprocess; /* must be the first member! =
*/
> 	unsigned int supported_capabilities;
> };
>=20
> -static int subprocess_map_initialized;
> -static struct hashmap subprocess_map;
> -
> -static int cmd2process_cmp(const struct subprocess_entry *e1,
> -			   const struct subprocess_entry *e2,
> -			   const void *unused)
> -{
> -	return strcmp(e1->cmd, e2->cmd);
> -}
> -
> -static struct subprocess_entry *subprocess_find_entry(const char =
*cmd)
> -{
> -	struct subprocess_entry key;
> -
> -	if (!subprocess_map_initialized) {
> -		subprocess_map_initialized =3D 1;
> -		hashmap_init(&subprocess_map, =
(hashmap_cmp_fn)cmd2process_cmp, 0);
> -		return NULL;
> -	}
> -
> -	hashmap_entry_init(&key, strhash(cmd));
> -	key.cmd =3D cmd;
> -	return hashmap_get(&subprocess_map, &key, NULL);
> -}
> -
> -static void subprocess_read_status(int fd, struct strbuf *status)
> -{
> -	struct strbuf **pair;
> -	char *line;
> -	for (;;) {
> -		line =3D packet_read_line(fd, NULL);
> -		if (!line)
> -			break;
> -		pair =3D strbuf_split_str(line, '=3D', 2);
> -		if (pair[0] && pair[0]->len && pair[1]) {
> -			/* the last "status=3D<foo>" line wins */
> -			if (!strcmp(pair[0]->buf, "status=3D")) {
> -				strbuf_reset(status);
> -				strbuf_addbuf(status, pair[1]);
> -			}
> -		}
> -		strbuf_list_free(pair);
> -	}
> -}
> -
> -static void subprocess_stop(struct subprocess_entry *entry)
> -{
> -	if (!entry)
> -		return;
> -
> -	entry->process.clean_on_exit =3D 0;
> -	kill(entry->process.pid, SIGTERM);
> -	finish_command(&entry->process);
> -
> -	hashmap_remove(&subprocess_map, entry, NULL);
> -	free(entry);
> -}
> -
> -static void subprocess_exit_handler(struct child_process *process)
> -{
> -	sigchain_push(SIGPIPE, SIG_IGN);
> -	/* Closing the pipe signals the subprocess to initiate a =
shutdown. */
> -	close(process->in);
> -	close(process->out);
> -	sigchain_pop(SIGPIPE);
> -	/* Finish command will wait until the shutdown is complete. */
> -	finish_command(process);
> -}
> -
> static int start_multi_file_filter_fn(struct subprocess_entry =
*subprocess)
> {
> 	int err;
> @@ -639,49 +565,6 @@ static int start_multi_file_filter_fn(struct =
subprocess_entry *subprocess)
> 	return err;
> }
>=20
> -typedef int(*subprocess_start_fn)(struct subprocess_entry *entry);
> -int subprocess_start(struct subprocess_entry *entry, const char *cmd,
> -	subprocess_start_fn startfn)
> -{
> -	int err;
> -	struct child_process *process;
> -	const char *argv[] =3D { cmd, NULL };
> -
> -	if (!subprocess_map_initialized) {
> -		subprocess_map_initialized =3D 1;
> -		hashmap_init(&subprocess_map, =
(hashmap_cmp_fn)cmd2process_cmp, 0);
> -	}
> -
> -	entry->cmd =3D cmd;
> -	process =3D &entry->process;
> -
> -	child_process_init(process);
> -	process->argv =3D argv;
> -	process->use_shell =3D 1;
> -	process->in =3D -1;
> -	process->out =3D -1;
> -	process->clean_on_exit =3D 1;
> -	process->clean_on_exit_handler =3D subprocess_exit_handler;
> -
> -	err =3D start_command(process);
> -	if (err) {
> -		error("cannot fork to run subprocess '%s'", cmd);
> -		return err;
> -	}
> -
> -	hashmap_entry_init(entry, strhash(cmd));
> -
> -	err =3D startfn(entry);
> -	if (err) {
> -		error("initialization for subprocess '%s' failed", cmd);
> -		subprocess_stop(entry);
> -		return err;
> -	}
> -
> -	hashmap_add(&subprocess_map, entry);
> -	return 0;
> -}
> -
> static int apply_multi_file_filter(const char *path, const char *src, =
size_t len,
> 				   int fd, struct strbuf *dst, const =
char *cmd,
> 				   const unsigned int wanted_capability)
> diff --git a/sub-process.c b/sub-process.c
> new file mode 100644
> index 0000000000..60bb650012
> --- /dev/null
> +++ b/sub-process.c
> @@ -0,0 +1,116 @@
> +/*
> + * Generic implementation of background process infrastructure.
> + */
> +#include "sub-process.h"
> +#include "sigchain.h"
> +#include "pkt-line.h"
> +
> +static int subprocess_map_initialized;
> +static struct hashmap subprocess_map;
> +
> +static int cmd2process_cmp(const struct subprocess_entry *e1,
> +			   const struct subprocess_entry *e2,
> +			   const void *unused)
> +{
> +	return strcmp(e1->cmd, e2->cmd);
> +}
> +
> +struct subprocess_entry *subprocess_find_entry(const char *cmd)
> +{
> +	struct subprocess_entry key;
> +
> +	if (!subprocess_map_initialized) {
> +		subprocess_map_initialized =3D 1;
> +		hashmap_init(&subprocess_map, =
(hashmap_cmp_fn)cmd2process_cmp, 0);
> +		return NULL;
> +	}
> +
> +	hashmap_entry_init(&key, strhash(cmd));
> +	key.cmd =3D cmd;
> +	return hashmap_get(&subprocess_map, &key, NULL);
> +}
> +
> +void subprocess_read_status(int fd, struct strbuf *status)
> +{
> +	struct strbuf **pair;
> +	char *line;
> +	for (;;) {
> +		line =3D packet_read_line(fd, NULL);
> +		if (!line)
> +			break;
> +		pair =3D strbuf_split_str(line, '=3D', 2);
> +		if (pair[0] && pair[0]->len && pair[1]) {
> +			/* the last "status=3D<foo>" line wins */
> +			if (!strcmp(pair[0]->buf, "status=3D")) {
> +				strbuf_reset(status);
> +				strbuf_addbuf(status, pair[1]);
> +			}
> +		}
> +		strbuf_list_free(pair);
> +	}
> +}
> +
> +void subprocess_stop(struct subprocess_entry *entry)
> +{
> +	if (!entry)
> +		return;
> +
> +	entry->process.clean_on_exit =3D 0;
> +	kill(entry->process.pid, SIGTERM);
> +	finish_command(&entry->process);
> +
> +	hashmap_remove(&subprocess_map, entry, NULL);
> +}
> +
> +static void subprocess_exit_handler(struct child_process *process)
> +{
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +	/* Closing the pipe signals the subprocess to initiate a =
shutdown. */
> +	close(process->in);
> +	close(process->out);
> +	sigchain_pop(SIGPIPE);
> +	/* Finish command will wait until the shutdown is complete. */
> +	finish_command(process);
> +}
> +
> +int subprocess_start(struct subprocess_entry *entry, const char *cmd,
> +	subprocess_start_fn startfn)
> +{
> +	int err;
> +	struct child_process *process;
> +	const char *argv[] =3D { cmd, NULL };
> +
> +	if (!subprocess_map_initialized) {
> +		subprocess_map_initialized =3D 1;
> +		hashmap_init(&subprocess_map, =
(hashmap_cmp_fn)cmd2process_cmp, 0);
> +	}
> +
> +	entry->cmd =3D cmd;
> +	process =3D &entry->process;
> +
> +	child_process_init(process);
> +	process->argv =3D argv;
> +	process->use_shell =3D 1;
> +	process->in =3D -1;
> +	process->out =3D -1;
> +	process->clean_on_exit =3D 1;
> +	process->clean_on_exit_handler =3D subprocess_exit_handler;
> +
> +	err =3D start_command(process);
> +	if (err) {
> +		error("cannot fork to run subprocess '%s'", cmd);
> +		return err;
> +	}
> +
> +	hashmap_entry_init(entry, strhash(cmd));
> +
> +	err =3D startfn(entry);
> +	if (err) {
> +		error("initialization for subprocess '%s' failed", cmd);
> +		subprocess_stop(entry);
> +		return err;
> +	}
> +
> +	hashmap_add(&subprocess_map, entry);
> +	return 0;
> +}
> diff --git a/sub-process.h b/sub-process.h
> new file mode 100644
> index 0000000000..0cf1760a0a
> --- /dev/null
> +++ b/sub-process.h
> @@ -0,0 +1,46 @@
> +#ifndef SUBPROCESS_H
> +#define SUBPROCESS_H
> +
> +#include "git-compat-util.h"
> +#include "hashmap.h"
> +#include "run-command.h"
> +
> +/*
> + * Generic implementation of background process infrastructure.
> + * See Documentation/technical/api-background-process.txt.
> + */
> +
> + /* data structures */
> +
> +struct subprocess_entry {
> +	struct hashmap_entry ent; /* must be the first member! */
> +	const char *cmd;
> +	struct child_process process;
> +};
> +
> +/* subprocess functions */
> +
> +typedef int(*subprocess_start_fn)(struct subprocess_entry *entry);
> +int subprocess_start(struct subprocess_entry *entry, const char *cmd,
> +		subprocess_start_fn startfn);
> +
> +void subprocess_stop(struct subprocess_entry *entry);
> +
> +struct subprocess_entry *subprocess_find_entry(const char *cmd);
> +
> +/* subprocess helper functions */
> +
> +static inline struct child_process *subprocess_get_child_process(
> +		struct subprocess_entry *entry)
> +{
> +	return &entry->process;
> +}
> +
> +/*
> + * Helper function that will read packets looking for "status=3D<foo>"
> + * key/value pairs and return the value from the last "status" packet
> + */
> +
> +void subprocess_read_status(int fd, struct strbuf *status);
> +
> +#endif
> --=20
> 2.12.0.windows.1.31.g1548525701.dirty

Looks all good to me. This patch also fixes the failing t0021 "invalid=20=

process filter must fail (and not hang!)" introduced here:
=
http://public-inbox.org/git/5900F7F1-89D9-433E-A6C3-0AB27C815BE6@gmail.com=
/

TBH, I don't see why this fixes the test, though.

Thanks,
Lars=
