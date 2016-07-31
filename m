Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93E561F858
	for <e@80x24.org>; Sun, 31 Jul 2016 22:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbcGaWVH (ORCPT <rfc822;e@80x24.org>);
	Sun, 31 Jul 2016 18:21:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33019 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbcGaWVD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2016 18:21:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id o80so23846382wme.0
        for <git@vger.kernel.org>; Sun, 31 Jul 2016 15:20:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=gV0+YxrTOxMPDRwr8VIFqJ98nojf5sCTIQdz+fDt8rw=;
        b=Aoh7tOCEg6xb73oKHElix8fpy2oJFIIAhlrMQCyqoShYOa1fAxxPqdf9g5ZszRRQHl
         9LEcwVz3TMJUcEVQ4z6aXpvoj/9FMyV+nfDV6aPVJrcLYf1t9oDpulG3R3gn5LUxnbxM
         /vv9RfIHVTaJQHLXmMKYA9mGglbhuqtp2oum1osX9OiCJqi0+zY6snbyJy+U6gsSGGd8
         7GHaLN/BhqHNw6s31V1cvyk6XHK5D6jLGS+/EvzDDtHaKEPnYxa/oennWtTuT+9hp5iD
         zb//xxaAagUbQ28SuHUGBOcdCPl3mHUJZjK7+aZRlu0MhOTsMd2fLSHbqTAhsFTJlDOd
         9zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=gV0+YxrTOxMPDRwr8VIFqJ98nojf5sCTIQdz+fDt8rw=;
        b=TmwARBNw0URepYhNiTS/WUbxPjnlWaRAIysZdjFWJMUHl48yBTgilBXbP87dCMtjYy
         thwgNxnGWU5Qp1lKkwW98EMYSnwuU5O9eqeRj6emcEhg5SKTvsp2jkuH4oM1mzWY3f3t
         9Wurj5QoSDBosgQ/QgBmqlMmVglzwt3ckyDZalxIcxLa2TQUjMxA5jiE8uYSedyXeCBk
         d4Kbb0BVnX83JdQ3xjUUjwBA3tbQg9MI+XNyrvHzEludvCAa+OjVpO+su7Z9bOMf013O
         8WO1slcWuBg1W07Wu30GFUMbDJEjfanZhmrXcuvUY2fJ2u0iIE+sTwhp/jVvca/mvEXG
         Ut6A==
X-Gm-Message-State: AEkooutpqgNfPRvUoHY5eBpwrlbCEUPRgC9kqBvKAYbB17pVULc8savLbMiW5U0aMMsaTQ==
X-Received: by 10.28.27.211 with SMTP id b202mr56681669wmb.12.1470003603946;
        Sun, 31 Jul 2016 15:20:03 -0700 (PDT)
Received: from [192.168.1.26] (dba209.neoplus.adsl.tpnet.pl. [83.23.26.209])
        by smtp.googlemail.com with ESMTPSA id f187sm13896446wmf.15.2016.07.31.15.20.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Jul 2016 15:20:03 -0700 (PDT)
Subject: Re: [PATCH v3 10/10] convert: add filter.<driver>.process option
To:	Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160729233801.82844-11-larsxschneider@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Martin-Louis Bright <mlbright@gmail.com>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <2f4743d1-3c93-406d-8b44-da0eb075e65c@gmail.com>
Date:	Mon, 1 Aug 2016 00:19:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160729233801.82844-11-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 30.07.2016 o 01:38, larsxschneider@gmail.com pisze:
[...]
> +Please note that you cannot use an existing filter.<driver>.clean
> +or filter.<driver>.smudge command as filter.<driver>.process
> +command.

I think it would be more readable and easier to understand to write:

  ... you cannot use an existing ... command with
  filter.<driver>.process

About the style: wouldn't `filter.<driver>.process` be better?

>              As soon as Git would detect a file that needs to be
> +processed by this filter, it would stop responding.

This is quite convoluted, and hard to understand.  I would say
that because `clean` and `smudge` filters are expected to read
first, while Git expects `process` filter to say first, using
`clean` or `smudge` filter without changes as `process` filter
would lead to git command deadlocking / hanging / stopping
responding.

> +
> +
>  Interaction between checkin/checkout attributes
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
> diff --git a/convert.c b/convert.c
> index 522e2c5..be6405c 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -3,6 +3,7 @@
>  #include "run-command.h"
>  #include "quote.h"
>  #include "sigchain.h"
> +#include "pkt-line.h"
>  
>  /*
>   * convert.c - convert a file when checking it out and checking it in.
> @@ -481,11 +482,355 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
>  	return ret;
>  }
>  
> +static int multi_packet_read(int fd_in, struct strbuf *sb, size_t expected_bytes, int is_stream)

About name of this function: `multi_packet_read` is fine, though I wonder
if `packet_read_in_full` with nearly the same parameters as `packet_read`,
or `packet_read_till_flush`, or `read_in_full_packetized` would be better.

Also, the problem is that while we know that what packet_read() stores
would fit in memory (in size_t), it is not true for reading whole file,
which might be very large - for example huge graphical assets like raw
images or raw videos, or virtual machine images.  Isn't that the goal
of git-LFS solutions, which need this feature?  Shouldn't we have then
both `multi_packet_read_to_fd` and `multi_packet_read_to_buf`,
or whatever?

Also, if we have `fd_in`, then perhaps `sb_out`?

I am also unsure if `expected_bytes` (or `expected_size`) should not be
just a size hint, leaving handing mismatch between expected size and
real size of output to the caller; then the `is_stream` would be not
needed.

> +{
> +	int bytes_read;
> +	size_t total_bytes_read = 0;

Why `bytes_read` is int, while `total_bytes_read` is size_t? Ah, I see
that packet_read() returns an int.  It should be ssize_t, just like
read(), isn't it?  But we know that packet size is limited, and would
fit in an int (or would it?).

Also, total_bytes_read could overflow size_t, but then we would have
problems storing the result in strbuf.

> +	if (expected_bytes == 0 && !is_stream)
> +		return 0;

So in all cases *except* size = 0 we expect flush packet after the
contents, but size = 0 is a corner case without flush packet?

> +
> +	if (is_stream)
> +		strbuf_grow(sb, LARGE_PACKET_MAX);           // allocate space for at least one packet
> +	else
> +		strbuf_grow(sb, st_add(expected_bytes, 1));  // add one extra byte for the packet flush
> +
> +	do {
> +		bytes_read = packet_read(
> +			fd_in, NULL, NULL,
> +			sb->buf + total_bytes_read, sb->len - total_bytes_read - 1,
> +			PACKET_READ_GENTLE_ON_EOF
> +		);
> +		if (bytes_read < 0)
> +			return 1;  // unexpected EOF

Don't we usually return negative numbers on error?  Ah, I see that the
return is a bool, which allows to use boolean expression with 'return'.
But I am still unsure if it is good API, this return value.

If we move handling of size mismatch to the caller, then the function
can simply return the size of data read (probably off_t or uint64_t).
Then the caller can check if it is what it expected, and react accordingly.

> +
> +		if (is_stream &&
> +			bytes_read > 0 &&
> +			sb->len - total_bytes_read - 1 <= 0)
> +			strbuf_grow(sb, st_add(sb->len, LARGE_PACKET_MAX));
> +		total_bytes_read += bytes_read;
> +	}
> +	while (
> +		bytes_read > 0 &&                   // the last packet was no flush
> +		sb->len - total_bytes_read - 1 > 0  // we still have space left in the buffer

Ah, so buffer is resized only in the 'is_stream' case.  Perhaps then
use an "int options" instead of 'is_stream', and have one of flags
tell if we should resize or not, that is if size parameter is hint
or a strict limit.

> +	);
> +	strbuf_setlen(sb, total_bytes_read);
> +	return (is_stream ? 0 : expected_bytes != total_bytes_read);
> +}
> +
> +static int multi_packet_write_from_fd(const int fd_in, const int fd_out)

Is it equivalent of copy_fd() function, but where destination uses pkt-line
and we need to pack data into pkt-lines?

> +{
> +	int did_fail = 0;
> +	ssize_t bytes_to_write;
> +	while (!did_fail) {
> +		bytes_to_write = xread(fd_in, PKTLINE_DATA_START(packet_buffer), PKTLINE_DATA_LEN);

Using global variable packet_buffer makes this code thread-unsafe, isn't it?
But perhaps that is not a problem, because other functions are also
using this global variable.

It is more of PKTLINE_DATA_MAXLEN, isn't it?

> +		if (bytes_to_write < 0)
> +			return 1;
> +		if (bytes_to_write == 0)
> +			break;
> +		did_fail |= direct_packet_write(fd_out, packet_buffer, PKTLINE_HEADER_LEN + bytes_to_write, 1);
> +	}
> +	if (!did_fail)
> +		did_fail = packet_flush_gentle(fd_out);

Shouldn't we try to flush even if there was an error?  Or is it
that if there is an error writing, then there is some problem
such that we know that flush would not work?

> +	return did_fail;

Return true on fail?  Shouldn't we follow example of copy_fd()
from copy.c, and return COPY_READ_ERROR, or COPY_WRITE_ERROR,
or PKTLINE_WRITE_ERROR?


> +}
> +
> +static int multi_packet_write_from_buf(const char *src, size_t len, int fd_out)

It is equivalent of write_in_full(), with different order of parameters,
but where destination file descriptor expects pkt-line and we need to pack
data into pkt-lines?

NOTE: function description comments?

> +{
> +	int did_fail = 0;
> +	size_t bytes_written = 0;
> +	size_t bytes_to_write;

Note to self: bytes_to_write should fit in size_t, as it is limited to
PKTLINE_DATA_LEN.  bytes_written should fit in size_t, as it is at most
len, which is of type size_t.

> +	while (!did_fail) {
> +		if ((len - bytes_written) > PKTLINE_DATA_LEN)
> +			bytes_to_write = PKTLINE_DATA_LEN;
> +		else
> +			bytes_to_write = len - bytes_written;
> +		if (bytes_to_write == 0)
> +			break;
> +		did_fail |= direct_packet_write_data(fd_out, src + bytes_written, bytes_to_write, 1);
> +		bytes_written += bytes_to_write;

Ah, I see now why we need both direct_packet_write() and
direct_packet_write_data().  Nice abstraction, makes for
clear code.

The last parameter of '1' means 'gently', isn't it?

> +	}
> +	if (!did_fail)
> +		did_fail = packet_flush_gentle(fd_out);
> +	return did_fail;
> +}

I think all three/four of those functions should be added in a separate
commit, separate patch in patch series.  Namely:

 - for git -> filter:
    * read from fd,      write pkt-line to fd  (off_t)
    * read from str+len, write pkt-line to fd  (size_t, ssize_t)
 - for filter -> git:
    * read pkt-line from fd, write to fd       (off_t)
    * read pkt-line from fd, write to str+len  (size_t, ssize_t)

Perhaps some of those can be in one overloaded function, perhaps it would
be easier to keep them separate.

Also, I do wonder how the fetch / push code spools pack file received
over pkt-lines to disk.  Can we reuse that code?  Or maybe that code
could use those new functions?


> +
> +#define FILTER_CAPABILITIES_STREAM   0x1
> +#define FILTER_CAPABILITIES_CLEAN    0x2
> +#define FILTER_CAPABILITIES_SMUDGE   0x4
> +#define FILTER_CAPABILITIES_SHUTDOWN 0x8
> +#define FILTER_SUPPORTS_STREAM(type) ((type) & FILTER_CAPABILITIES_STREAM)
> +#define FILTER_SUPPORTS_CLEAN(type)  ((type) & FILTER_CAPABILITIES_CLEAN)
> +#define FILTER_SUPPORTS_SMUDGE(type) ((type) & FILTER_CAPABILITIES_SMUDGE)
> +#define FILTER_SUPPORTS_SHUTDOWN(type) ((type) & FILTER_CAPABILITIES_SHUTDOWN)
> +
> +struct cmd2process {
> +	struct hashmap_entry ent; /* must be the first member! */
> +	const char *cmd;
> +	int supported_capabilities;

I wonder if switching from int (perhaps with field width of 1 to denote
that it is boolean-like flag) to mask makes it more readable, or less.
But I think it is.


Reading Documentation/technical/api-hashmap.txt I found the following
recommendation:

  `struct hashmap_entry`::

        An opaque structure representing an entry in the hash table, which must
        be used as first member of user data structures. Ideally it should be
        followed by an int-sized member to prevent unused memory on 64-bit
        systems due to alignment.

Therefore it "int supported_capabilities" should precede
"const char *cmd", I think.  Though it is not strictly necessary; it
is not as if this hash table were large (maximum size is limited by
the number of filter drivers configured), so we don't waste much space
due to internal padding / due to alignment.

> +	struct child_process process;
> +};
> +
> +static int cmd_process_map_initialized = 0;
> +static struct hashmap cmd_process_map;

Reading Documentation/technical/api-hashmap.txt I see that:

  `tablesize` is the allocated size of the hash table. A non-0 value indicates
  that the hashmap is initialized.

So cmd_process_map_initialized is not really needed, is it?

> +
> +static int cmd2process_cmp(const struct cmd2process *e1,
> +							const struct cmd2process *e2,
> +							const void *unused)
> +{
> +	return strcmp(e1->cmd, e2->cmd);
> +}

Well, to be exact (which is decidely not needed!) two commands might
be equivalent not being identical as strings (e.g. extra space between
parameters).  But it is something the user should care about, not Git.

> +
> +static struct cmd2process *find_protocol2_filter_entry(struct hashmap *hashmap, const char *cmd)

I'm not sure if *_protocol2_* is needed; those functions are static,
local to convert.c.

> +{
> +	struct cmd2process k;

Does this name of variable 'k' follow established convention?
'key' would be more descriptive, but it's not as if this function
was long; so 'k' is all right, I think.

> +	hashmap_entry_init(&k, strhash(cmd));
> +	k.cmd = cmd;
> +	return hashmap_get(hashmap, &k, NULL);
> +}
> +
> +static void kill_protocol2_filter(struct hashmap *hashmap, struct cmd2process *entry) {

Programming style: the opening brace should be on separate line,
that is:

  +static void kill_protocol2_filter(struct hashmap *hashmap, struct cmd2process *entry)
  +{

> +	if (!entry)
> +		return;
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +	close(entry->process.in);
> +	close(entry->process.out);
> +	sigchain_pop(SIGPIPE);
> +	finish_command(&entry->process);
> +	child_process_clear(&entry->process);
> +	hashmap_remove(hashmap, entry, NULL);
> +	free(entry);
> +}

All those, from #define FILTER_CAPABILITIES_ to here could be put
in a separate patch, to reduce size of this one.  But I am less
sure that it is worth it for this case.

> +
> +void shutdown_protocol2_filter(pid_t pid)
> +{
[...]

In my opinion this should be postponed to a separate commit.

> +}
> +
> +static struct cmd2process *start_protocol2_filter(struct hashmap *hashmap, const char *cmd)

This has some parts in common with existing filter_buffer_or_fd().
I wonder if it would be worth to extract those common parts.

But perhaps it would be better to leave such refactoring for later.

> +{
> +	int did_fail;
> +	struct cmd2process *entry;
> +	struct child_process *process;
> +	const char *argv[] = { cmd, NULL };
> +	struct string_list capabilities = STRING_LIST_INIT_NODUP;
> +	char *capabilities_buffer;
> +	int i;
> +
> +	entry = xmalloc(sizeof(*entry));
> +	hashmap_entry_init(entry, strhash(cmd));
> +	entry->cmd = cmd;
> +	entry->supported_capabilities = 0;
> +	process = &entry->process;
> +
> +	child_process_init(process);

filter_buffer_or_fd() uses instead

  struct child_process child_process = CHILD_PROCESS_INIT;

But I see that you need to access &entry->process anyway, so you
need to have it here, and in this case child_process_init() is
equivalent.

I wonder if it would be worth it to use strbuf for cmd.

> +	process->argv = argv;
> +	process->use_shell = 1;
> +	process->in = -1;
> +	process->out = -1;
> +	process->clean_on_exit = 1;
> +	process->clean_on_exit_handler = shutdown_protocol2_filter;

These two lines are new, and related to the "shutdown" capability, isn't it?

> +
> +	if (start_command(process)) {
> +		error("cannot fork to run external filter '%s'", cmd);
> +		kill_protocol2_filter(hashmap, entry);

I guess the alternative solution of adding filter to the hashmap only
after starting the process would be racy?

Ah, disregard that. I see that this pattern is a common way to error
out in this function (for process-related errors).

> +		return NULL;
> +	}
> +
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +	did_fail = strcmp(packet_read_line(process->out, NULL), "git-filter-protocol");
> +	if (!did_fail)
> +		did_fail |= strcmp(packet_read_line(process->out, NULL), "version 2");
> +	if (!did_fail)
> +		capabilities_buffer = packet_read_line(process->out, NULL);
> +	else
> +		capabilities_buffer = NULL;
> +	sigchain_pop(SIGPIPE);
> +
> +	if (!did_fail && capabilities_buffer) {
> +		string_list_split_in_place(&capabilities, capabilities_buffer, ' ', -1);
> +		if (capabilities.nr > 1 &&
> +			!strcmp(capabilities.items[0].string, "capabilities")) {
> +			for (i = 1; i < capabilities.nr; i++) {
> +				const char *requested = capabilities.items[i].string;
> +				if (!strcmp(requested, "stream")) {
> +					entry->supported_capabilities |= FILTER_CAPABILITIES_STREAM;
> +				} else if (!strcmp(requested, "clean")) {
> +					entry->supported_capabilities |= FILTER_CAPABILITIES_CLEAN;
> +				} else if (!strcmp(requested, "smudge")) {
> +					entry->supported_capabilities |= FILTER_CAPABILITIES_SMUDGE;
> +				} else if (!strcmp(requested, "shutdown")) {
> +					entry->supported_capabilities |= FILTER_CAPABILITIES_SHUTDOWN;
> +				} else {
> +					warning(
> +						"external filter '%s' requested unsupported filter capability '%s'",
> +						cmd, requested
> +					);
> +				}
> +			}
> +		} else {
> +			error("filter capabilities not found");
> +			did_fail = 1;
> +		}
> +		string_list_clear(&capabilities, 0);
> +	}

I wonder if the above conditional wouldn't be better to be put in
a separate function, parse_filter_capabilities(capabilities_buffer),
returning a mask, or having mask as an out parameter, and returning
an error condition.

> +
> +	if (did_fail) {
> +		error("initialization for external filter '%s' failed", cmd);

More detailed information not needed, because one can use GIT_PACKET_TRACE.
Would it be worth add this information as a kind of advice, or put it
in the documentation of the `process` option?

> +		kill_protocol2_filter(hashmap, entry);
> +		return NULL;
> +	}
> +
> +	hashmap_add(hashmap, entry);
> +	return entry;
> +}
> +
> +static int apply_protocol2_filter(const char *path, const char *src, size_t len,
> +						int fd, struct strbuf *dst, const char *cmd,
> +						const int wanted_capability)

apply_protocol2_filter, or apply_process_filter?  Or rather,
s/_protocol2_/_process_/g ?

This is equivalent to

   static int apply_filter(const char *path, const char *src, size_t len, int fd,
                           struct strbuf *dst, const char *cmd)

Could we have extended that one instead?

> +{
> +	int ret = 1;
> +	struct cmd2process *entry;
> +	struct child_process *process;
> +	struct stat file_stat;
> +	struct strbuf nbuf = STRBUF_INIT;
> +	size_t expected_bytes = 0;
> +	char *strtol_end;
> +	char *strbuf;
> +	char *filter_type;
> +	char *filter_result = NULL;
> +

> +	if (!cmd || !*cmd)
> +		return 0;
> +
> +	if (!dst)
> +		return 1;

This is the same as in apply_filter().

> +
> +	if (!cmd_process_map_initialized) {
> +		cmd_process_map_initialized = 1;
> +		hashmap_init(&cmd_process_map, (hashmap_cmp_fn) cmd2process_cmp, 0);
> +		entry = NULL;
> +	} else {
> +		entry = find_protocol2_filter_entry(&cmd_process_map, cmd);
> +	}

Here we try to find existing process, rather than starting new
as in apply_filter()

> +
> +	fflush(NULL);

This is the same as in apply_filter(), but I wonder what it is for.

> +
> +	if (!entry) {
> +		entry = start_protocol2_filter(&cmd_process_map, cmd);
> +		if (!entry) {
> +			return 0;
> +		}

Style; we prefer:

  +		if (!entry)
  +			return 0;

This is very similar to apply_filter(), but the latter uses start_async()
from "run-command.h", with filter_buffer_or_fd() as asynchronous process,
which gets passed command to run in struct filter_params.  In this
function start_protocol2_filter() runs start_command(), synchronous API.

Why the difference?

> +	}
> +	process = &entry->process;
> +
> +	if (!(wanted_capability & entry->supported_capabilities))
> +		return 1;  // it is OK if the wanted capability is not supported
> +
> +	if FILTER_SUPPORTS_CLEAN(wanted_capability)
> +		filter_type = "clean";
> +	else if FILTER_SUPPORTS_SMUDGE(wanted_capability)
> +		filter_type = "smudge";
> +	else
> +		die("unexpected filter type");

Style: it should be

  +	if (FILTER_SUPPORTS_CLEAN(wanted_capability))
  +		filter_type = "clean";
  +	else if (FILTER_SUPPORTS_SMUDGE(wanted_capability))
  +		filter_type = "smudge";
  +	else
  +		die("unexpected filter type");

even though by accident the macro provides the parentheses to "if".

Can we make an error/die message more detailed?  Maybe it is
not possible...

> +
> +	if (fd >= 0 && !src) {
> +		if (fstat(fd, &file_stat) == -1)
> +			return 0;
> +		len = file_stat.st_size;
> +	}

All right, when fstat() can fail?  Could we then send contents without
size upfront, or is it better to require size to make it more consistent
for filter drivers scripts?

Could this whole "send single file" be put in a separate function?
Or is it not worth it?

> +
> +	sigchain_push(SIGPIPE, SIG_IGN);

Hmmm... ignoring SIGPIPE was good for one-shot filters.  Is it still
O.K. for per-command persistent ones?

> +
> +	packet_buf_write(&nbuf, "%s\n", filter_type);
> +	ret &= !direct_packet_write(process->in, nbuf.buf, nbuf.len, 1);
> +
> +	if (ret) {
> +		strbuf_reset(&nbuf);
> +		packet_buf_write(&nbuf, "filename=%s\n", path);
> +		ret = !direct_packet_write(process->in, nbuf.buf, nbuf.len, 1);
> +	}

Perhaps a better solution would be

        if (err)
        	goto fin_error;

rather than this.

> +
> +	if (ret) {
> +		strbuf_reset(&nbuf);
> +		packet_buf_write(&nbuf, "size=%"PRIuMAX"\n", (uintmax_t)len);
> +		ret = !direct_packet_write(process->in, nbuf.buf, nbuf.len, 1);
> +	}

Or maybe extract writing the header for a file into a separate function?
This one gets a bit long...

> +
> +	if (ret) {
> +		if (fd >= 0)
> +			ret = !multi_packet_write_from_fd(fd, process->in);
> +		else
> +			ret = !multi_packet_write_from_buf(src, len, process->in);
> +	}

This is not streaming.  The above sends whole file, or whole string to
the filter process, without draining filter output.  If the filter were
to read some, then write some, it might deadlock on full buffers, isn't it?
Or am I mistaken?

> +
> +	if (ret && !FILTER_SUPPORTS_STREAM(entry->supported_capabilities)) {
> +		strbuf = packet_read_line(process->out, NULL);
> +		if (strlen(strbuf) > 5 && !strncmp("size=", strbuf, 5)) {
> +			expected_bytes = (off_t)strtol(strbuf + 5, &strtol_end, 10);
> +			ret = (strtol_end != strbuf && errno != ERANGE);
> +		} else {
> +			ret = 0;
> +		}
> +	}
> +
> +	if (ret) {
> +		strbuf_reset(&nbuf);
> +		ret = !multi_packet_read(process->out, &nbuf, expected_bytes,
> +			FILTER_SUPPORTS_STREAM(entry->supported_capabilities));
> +	}

What happens if the output of filter does not fit in size_t?  I see that
(I think) this problem is inherited from the original implementation.

> +
> +	if (ret) {
> +		filter_result = packet_read_line(process->out, NULL);
> +		ret = !strcmp(filter_result, "success");
> +	}
> +
> +	sigchain_pop(SIGPIPE);
> +
> +	if (ret) {
> +		strbuf_swap(dst, &nbuf);
> +	} else {
> +		if (!filter_result || strcmp(filter_result, "reject")) {
> +			// Something went wrong with the protocol filter. Force shutdown!
> +			error("external filter '%s' failed", cmd);
> +			kill_protocol2_filter(&cmd_process_map, entry);
> +		}
> +	}

So if Git gets finish signal "success" from filter, it accepts the output.
If Git gets finish signal "reject" from filter, it restarts filter (and
reject the output - user can retry the command himself / herself).
If Git gets any other finish signal, for example "error" (but this is not
standarized), then it rejects the output, keeping the unfiltered result,
but keeps filtering.

I think it is not described in this detail in the documentation of the
new protocol.

> +	strbuf_release(&nbuf);
> +	return ret;
> +}

I wonder if this point might be start of the new patch... but then you
would have no way to test what you wrote.

> +
>  static struct convert_driver {
>  	const char *name;
>  	struct convert_driver *next;
>  	const char *smudge;
>  	const char *clean;
> +	const char *process;
>  	int required;
>  } *user_convert, **user_convert_tail;

All right.

>  
> @@ -526,6 +871,10 @@ static int read_convert_config(const char *var, const char *value, void *cb)
>  	if (!strcmp("clean", key))
>  		return git_config_string(&drv->clean, var, value);
>  
> +	if (!strcmp("process", key)) {
> +		return git_config_string(&drv->process, var, value);
> +	}
> +

All right.

>  	if (!strcmp("required", key)) {
>  		drv->required = git_config_bool(var, value);
>  		return 0;
> @@ -823,7 +1172,12 @@ int would_convert_to_git_filter_fd(const char *path)
>  	if (!ca.drv->required)
>  		return 0;
>  
> -	return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
> +	if (!ca.drv->clean && ca.drv->process)
> +		return apply_protocol2_filter(
> +			path, NULL, 0, -1, NULL, ca.drv->process, FILTER_CAPABILITIES_CLEAN
> +		);
> +	else
> +		return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);

Could we augment apply_filter() instead, so that the invocation is

        return apply_filter(path, NULL, 0, -1, NULL, ca.drv, FILTER_CLEAN);

Though I am not sure if moving this conditional to apply_filter would
be a good idea; maybe wrapper around augmented apply_filter_do()?

>  }
>  
>  const char *get_convert_attr_ascii(const char *path)
> @@ -856,17 +1210,24 @@ int convert_to_git(const char *path, const char *src, size_t len,
>                     struct strbuf *dst, enum safe_crlf checksafe)
>  {
>  	int ret = 0;
> -	const char *filter = NULL;
> +	const char *clean_filter = NULL;
> +	const char *process_filter = NULL;
>  	int required = 0;
>  	struct conv_attrs ca;
>  
>  	convert_attrs(&ca, path);
>  	if (ca.drv) {
> -		filter = ca.drv->clean;
> +		clean_filter = ca.drv->clean;
> +		process_filter = ca.drv->process;
>  		required = ca.drv->required;
>  	}

All right (assuming un-augmented apply_filter()).

>  
> -	ret |= apply_filter(path, src, len, -1, dst, filter);
> +	if (!clean_filter && process_filter)
> +		ret |= apply_protocol2_filter(
> +			path, src, len, -1, dst, process_filter, FILTER_CAPABILITIES_CLEAN
> +		);
> +	else
> +		ret |= apply_filter(path, src, len, -1, dst, clean_filter);

I wonder if it would be more readable to write it like this
(and of course elsewhere too):

  +	if (!clean_filter && process_filter)
  +		ret |= apply_protocol2_filter(
  +			path, src, len, -1, dst, process_filter, FILTER_CAPABILITIES_CLEAN
  +		);
  +	else
  +		ret |= apply_filter(
  +			path, src, len, -1, dst, clean_filter);
  +		);


Though it would screw up "git blame -C -C -w"

>  	if (!ret && required)
>  		die("%s: clean filter '%s' failed", path, ca.drv->name);
>  
> @@ -885,13 +1246,21 @@ int convert_to_git(const char *path, const char *src, size_t len,
>  void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
>  			      enum safe_crlf checksafe)
>  {
> +	int ret = 0;

Right, 'ret' is needed because we now have two possibilities:
`clean` filter and `process` filter.

>  	struct conv_attrs ca;
>  	convert_attrs(&ca, path);
>  
>  	assert(ca.drv);
> -	assert(ca.drv->clean);
> +	assert(ca.drv->clean || ca.drv->process);
> +
> +	if (!ca.drv->clean && ca.drv->process)
> +		ret = apply_protocol2_filter(
> +			path, NULL, 0, fd, dst, ca.drv->process, FILTER_CAPABILITIES_CLEAN
> +		);
> +	else
> +		ret = apply_filter(path, NULL, 0, fd, dst, ca.drv->clean);
>  
> -	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv->clean))
> +	if (!ret)
>  		die("%s: clean filter '%s' failed", path, ca.drv->name);
>  
>  	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
> @@ -902,14 +1271,16 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
>  					    size_t len, struct strbuf *dst,
>  					    int normalizing)
>  {
> -	int ret = 0, ret_filter = 0;
> -	const char *filter = NULL;
> +	int ret = 0, ret_filter;

Why the change:

  -	int ret = 0, ret_filter = 0;
  +	int ret = 0, ret_filter;

> +	const char *smudge_filter = NULL;
> +	const char *process_filter = NULL;
>  	int required = 0;
>  	struct conv_attrs ca;
>  
>  	convert_attrs(&ca, path);
>  	if (ca.drv) {
> -		filter = ca.drv->smudge;
> +		process_filter = ca.drv->process;
> +		smudge_filter = ca.drv->smudge;
>  		required = ca.drv->required;
>  	}

All right, the same.

[...]
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index 34c8eb9..e8a7703 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -296,4 +296,409 @@ test_expect_success 'disable filter with empty override' '
>  	test_must_be_empty err
>  '
>  
> +test_expect_success PERL 'required process filter should filter data' '
> +	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge shutdown" &&
> +	test_config_global filter.protocol.required true &&
> +	rm -rf repo &&
> +	mkdir repo &&
> +	(
> +		cd repo &&
> +		git init &&
> +
> +		echo "*.r filter=protocol" >.gitattributes &&
> +		git add . &&
> +		git commit . -m "test commit" &&

This is more of "Initial commit", not that it matters

> +		git branch empty &&
> +
> +		cat ../test.o >test.r &&

Err, the above is just copying file, isn't it?
Maybe it was copied from other tests, I have not checked.

> +		echo "test22" >test2.r &&
> +		mkdir testsubdir &&
> +		echo "test333" >testsubdir/test3.r &&

All right, we test text file, we test binary file (I assume), we test
file in a subdirectory.  What about testing empty file?  Or large file
which would not fit in the stdin/stdout buffer (as EXPENSIVE test)?

> +
> +		rm -f rot13-filter.log &&
> +		git add . &&

So this runs "clean" filter, storing cleaned contents in the index.

> +		sort rot13-filter.log | uniq -c | sed "s/^[ ]*//" >uniq-rot13-filter.log &&
> +		cat >expected_add.log <<-\EOF &&
> +			1 IN: clean test.r 57 [OK] -- OUT: 57 [OK]
> +			1 IN: clean test2.r 7 [OK] -- OUT: 7 [OK]
> +			1 IN: clean testsubdir/test3.r 8 [OK] -- OUT: 8 [OK]

And we check the "know size upfront" case (mistakenly called non-"stream").

> +			1 IN: shutdown -- [OK]

And test "shutdown" capability (not as separate test).

> +			1 start
> +			1 wrote filter header
> +		EOF

And we are required to keep the expected_add.log file sorted by hand???

> +		test_cmp expected_add.log uniq-rot13-filter.log &&
> +
> +		>rot13-filter.log &&

Truncate log. Still in the same test.

> +		git commit . -m "test commit" &&

This is test commit with files undergoing "clean" part of filter.

> +		sort rot13-filter.log | uniq -c | sed "s/^[ ]*//" |
> +			sed "s/^\([0-9]\) IN: clean/x IN: clean/" >uniq-rot13-filter.log &&

There is known performance regression, in that filter is run more
than once on given file.

Actually... why it does not use cleaned-up contents from the index?

> +		cat >expected_commit.log <<-\EOF &&
> +			x IN: clean test.r 57 [OK] -- OUT: 57 [OK]
> +			x IN: clean test2.r 7 [OK] -- OUT: 7 [OK]
> +			x IN: clean testsubdir/test3.r 8 [OK] -- OUT: 8 [OK]
> +			1 IN: shutdown -- [OK]
> +			1 start
> +			1 wrote filter header

Right, this is the goal of the patch series: for filter to be started
only once per git command invocation.

> +		EOF
> +		test_cmp expected_commit.log uniq-rot13-filter.log &&
> +

Still in the same test, even though we would be testing "smudge"
capability now.  

It's a pity that t/test-lib.sh does not support subtests from
the TAP specification (Test Anything Protocol that Git testsuite
uses).

> +		>rot13-filter.log &&
> +		rm -f test?.r testsubdir/test3.r &&
> +		git checkout . &&

All right, we removed some files so that "git checkout ." could
restore them to life.

> +		cat rot13-filter.log | grep -v "IN: clean" >smudge-rot13-filter.log &&

Useless use of cat

  +		grep -v "IN: clean"  rot13-filter.log  >smudge-rot13-filter.log &&

Also: why 'git checkout <path>' would run "clean" filter?
Is it existing strange behaviour?

> +		cat >expected_checkout.log <<-\EOF &&
> +			start
> +			wrote filter header
> +			IN: smudge test2.r 7 [OK] -- OUT: 7 [OK]
> +			IN: smudge testsubdir/test3.r 8 [OK] -- OUT: 8 [OK]
> +			IN: shutdown -- [OK]
> +		EOF

This time without 'sort | uniq -c'.  Is it really needed for the
"good" case, or is it there for two cases to look similar?

> +		test_cmp expected_checkout.log smudge-rot13-filter.log &&
> +
> +		git checkout empty &&

Shouldn't we check that switching to branch 'empty' does not run
filters, or is it covered by other tests?  Or perhaps this simply
does not matter here, is it?

> +
> +		>rot13-filter.log &&
> +		git checkout master &&

Does it test different callpath than 'git checkout .'?  Well, the
set of files is different...

> +		cat rot13-filter.log | grep -v "IN: clean" >smudge-rot13-filter.log &&
> +		cat >expected_checkout_master.log <<-\EOF &&
> +			start
> +			wrote filter header
> +			IN: smudge test.r 57 [OK] -- OUT: 57 [OK]
> +			IN: smudge test2.r 7 [OK] -- OUT: 7 [OK]
> +			IN: smudge testsubdir/test3.r 8 [OK] -- OUT: 8 [OK]
> +			IN: shutdown -- [OK]
> +		EOF
> +		test_cmp expected_checkout_master.log smudge-rot13-filter.log &&
> +

And here we start checking that the filter did filter,
that is the content in the repository is "clean"ed-up.
Still the same test.

> +		./../rot13.sh <test.r >expected &&
> +		git cat-file blob :test.r >actual &&
> +		test_cmp expected actual &&
> +
> +		./../rot13.sh <test2.r >expected &&
> +		git cat-file blob :test2.r >actual &&
> +		test_cmp expected actual &&
> +
> +		./../rot13.sh <testsubdir/test3.r >expected &&
> +		git cat-file blob :testsubdir/test3.r >actual &&
> +		test_cmp expected actual
> +	)
> +'
> +
> +test_expect_success PERL 'required process filter should filter data stream' '
> +	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl stream clean smudge" &&
> +	test_config_global filter.protocol.required true &&

Errr... I don't see how it is different from the previous test.
[...]

> +
> +test_expect_success PERL 'required process filter should filter smudge data and one-shot filter should clean' '

All right, so this tests the precedence... well, it doesn't.

It tests that `process` filter with "smudge" capability only works well
with one-shot `clean` filter.

> +	test_config_global filter.protocol.clean ./../rot13.sh &&
> +	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl smudge" &&

Why the difference in pathnames (the directory part) between those two?

> +	test_config_global filter.protocol.required true &&
> +	rm -rf repo &&
> +	mkdir repo &&
> +	(
> +		cd repo &&
> +		git init &&
> +
> +		echo "*.r filter=protocol" >.gitattributes &&
> +		git add . &&
> +		git commit . -m "test commit" &&
> +		git branch empty &&
> +
> +		cat ../test.o >test.r &&
> +		echo "test22" >test2.r &&
> +		mkdir testsubdir &&
> +		echo "test333" >testsubdir/test3.r &&
> +
> +		rm -f rot13-filter.log &&
> +		git add . &&
> +		test_must_be_empty rot13-filter.log &&
> +
> +		>rot13-filter.log &&
> +		git commit . -m "test commit" &&
> +		test_must_be_empty rot13-filter.log &&

All right, these tests that `process` filter is not ran.  But we don't
know if it is because it lacks capability, or because it is overriden
by one-shot filter (well, that comes later).

> +
> +		>rot13-filter.log &&
> +		rm -f test?.r testsubdir/test3.r &&
> +		git checkout . &&
> +		cat rot13-filter.log | grep -v "IN: clean" >smudge-rot13-filter.log &&
> +		cat >expected_checkout.log <<-\EOF &&
> +			start
> +			wrote filter header
> +			IN: smudge test2.r 7 [OK] -- OUT: 7 [OK]
> +			IN: smudge testsubdir/test3.r 8 [OK] -- OUT: 8 [OK]
> +		EOF
> +		test_cmp expected_checkout.log smudge-rot13-filter.log &&

This part is repeated many, many times.  Maybe add some helper
shell function for this?

[...]
> +		./../rot13.sh <test.r >expected &&
> +		git cat-file blob :test.r >actual &&
> +		test_cmp expected actual &&
> +
> +		./../rot13.sh <test2.r >expected &&
> +		git cat-file blob :test2.r >actual &&
> +		test_cmp expected actual &&
> +
> +		./../rot13.sh <testsubdir/test3.r >expected &&
> +		git cat-file blob :testsubdir/test3.r >actual &&
> +		test_cmp expected actual

Here we test that equivalent one-shot cleanup filter was run.
Here also we have repeated contents; maybe some helper function
would make it shorter?

> +	)
> +'

Here I am stopping examining tests in detail.

> +test_expect_success PERL 'required process filter should clean only' '
> +test_expect_success PERL 'required process filter should process files larger LARGE_PACKET_MAX' '

Those two tests do not depend on being required or not; it is only
that without required they would fail softly in case of latter test
(which we can detect too).

> +test_expect_success PERL 'required process filter should with clean error should fail' '
> +test_expect_success PERL 'process filter should restart after unexpected write failure' '

So these two are sort of complimentary.  When `process` is required,
then it should fail if it cannot filter some file.  If it is not,
it should keep processing other files.

> +test_expect_success PERL 'process filter should not restart after intentionally rejected file' '

Uh... all right, so "reject" means that filter cannot continue?
Strange meaning for 'reject', though ;-)

>  test_done
> diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
> new file mode 100755
> index 0000000..cb0925d
> --- /dev/null
> +++ b/t/t0021/rot13-filter.pl
> @@ -0,0 +1,177 @@
> +#!/usr/bin/perl
> +#
> +# Example implementation for the Git filter protocol version 2
> +# See Documentation/gitattributes.txt, section "Filter Protocol"
> +#
> +# The script takes the list of supported protocol capabilities as
> +# arguments ("stream", "clean", and "smudge" are supported).

What about "shutdown"?

> +#
> +# This implementation supports three special test cases:
> +# (1) If data with the filename "clean-write-fail.r" is processed with
> +#     a "clean" operation then the write operation will die.
> +# (2) If data with the filename "smudge-write-fail.r" is processed with
> +#     a "smudge" operation then the write operation will die.

All right, so it is hard failure with filter script dying.

> +# (3) If data with the filename "failure.r" is processed with any
> +#     operation then the filter signals that the operation was not
> +#     successful.

All right, so it is failure detected by filter script and signalled to Git.

> +#
> +
> +use strict;
> +use warnings;

So no more "use autodie", because of compatibility with old Perls.

> +
> +my $MAX_PACKET_CONTENT_SIZE = 65516;
> +my @capabilities            = @ARGV;

No autoflush this time?

> +
> +sub rot13 {
> +    my ($str) = @_;
> +    $str =~ y/A-Za-z/N-ZA-Mn-za-m/;
> +    return $str;
> +}
> +
> +sub packet_read {
> +    my $buffer;
> +    my $bytes_read = read STDIN, $buffer, 4;
> +    if ( $bytes_read == 0 ) {
> +        return;
> +    }
> +    elsif ( $bytes_read != 4 ) {
> +        die "invalid packet size '$bytes_read' field";
> +    }
> +    my $pkt_size = hex($buffer);
> +    if ( $pkt_size == 0 ) {
> +        return ( 1, "" );

Unusual return convention.  Though it is a test script, so
it doesn't matter much.

> +    }
> +    elsif ( $pkt_size > 4 ) {
> +        my $content_size = $pkt_size - 4;
> +        $bytes_read = read STDIN, $buffer, $content_size;
> +        if ( $bytes_read != $content_size ) {
> +            die "invalid packet";

More detailed error message, maybe?

> +        }
> +        return ( 0, $buffer );
> +    }
> +    else {
> +        die "invalid packet size";
> +    }
> +}
> +
> +sub packet_write {
> +    my ($packet) = @_;
> +    print STDOUT sprintf( "%04x", length($packet) + 4 );
> +    print STDOUT $packet;
> +    STDOUT->flush();
> +}
> +
> +sub packet_flush {
> +    print STDOUT sprintf( "%04x", 0 );
> +    STDOUT->flush();
> +}
> +
> +open my $debug, ">>", "rot13-filter.log";
> +print $debug "start\n";
> +$debug->flush();
> +
> +packet_write("git-filter-protocol\n");
> +packet_write("version 2\n");
> +packet_write( "capabilities " . join( ' ', @capabilities ) . "\n" );
> +print $debug "wrote filter header\n";
> +$debug->flush();
> +
> +while (1) {
> +    my $command = packet_read();
> +    unless ( defined($command) ) {
> +        exit();
> +    }
> +    chomp $command;
> +    print $debug "IN: $command";
> +    $debug->flush();
> +
> +    if ( $command eq "shutdown" ) {
> +        print $debug " -- [OK]";
> +        $debug->flush();
> +        packet_write("done\n");
> +        exit();
> +    }
> +
> +    my ($filename) = packet_read() =~ /filename=([^=]+)\n/;
> +    print $debug " $filename";
> +    $debug->flush();
> +    my ($filelen) = packet_read() =~ /size=([^=]+)\n/;
> +    chomp $filelen;

I think this chomp is not needed, as "\n" is not included.
Though the regexp should probably be anchored.

> +    print $debug " $filelen";
> +    $debug->flush();
> +
> +    $filelen =~ /\A\d+\z/ or die "bad filelen: $filelen";
> +    my $output;
> +
> +    if ( $filelen > 0 ) {

So here is a special case for $filelen = 0.
Negative $filelen is not allowed, via regexp.

> +        my $input = "";
> +        {
> +            binmode(STDIN);
> +            my $buffer;
> +            my $done = 0;
> +            while ( !$done ) {
> +                ( $done, $buffer ) = packet_read();
> +                $input .= $buffer;
> +            }
> +            print $debug " [OK] -- ";
> +            $debug->flush();
> +        }
> +
> +        if ( $command eq "clean" and grep( /^clean$/, @capabilities ) ) {
> +            $output = rot13($input);
> +        }
> +        elsif ( $command eq "smudge" and grep( /^smudge$/, @capabilities ) ) {
> +            $output = rot13($input);
> +        }

These two conditionals could be shortened, but then they would be less
readable.  Or not:

           if ( grep { $_ eq $command } @capabilities ) {
           	$output = rot13($input);
           }

> +        else {
> +            die "bad command $command";
> +        }
> +    }
> +
> +    my $output_len = length($output);
> +    if ( $filename eq "reject.r" ) {
> +        $output_len = 0;
> +    }
> +
> +    if ( grep( /^stream$/, @capabilities ) ) {
> +        print $debug "OUT: STREAM ";
> +    }
> +    else {
> +        packet_write("size=$output_len\n");
> +        print $debug "OUT: $output_len ";
> +    }
> +    $debug->flush();
> +
> +    if ( $filename eq "reject.r" ) {
> +        packet_write("reject\n");
> +        print $debug "[REJECT]\n";    # Could also be an error

How if could be an error?

> +        $debug->flush();
> +    }
> +
> +    if ( $output_len > 0 ) {
> +        if (( $command eq "clean" and $filename eq "clean-write-fail.r" )
> +            or
> +            ( $command eq "smudge" and $filename eq "smudge-write-fail.r" ))

Perhaps simply:

  +        if ( $filename eq "${command}-write-fail.r" ) {

> +        {
> +            print $debug "[WRITE FAIL]\n";
> +            $debug->flush();
> +            die "write error";
> +        }
> +        else {
> +            while ( length($output) > 0 ) {
> +                my $packet = substr( $output, 0, $MAX_PACKET_CONTENT_SIZE );
> +                packet_write($packet);
> +                if ( length($output) > $MAX_PACKET_CONTENT_SIZE ) {
> +                    $output = substr( $output, $MAX_PACKET_CONTENT_SIZE );
> +                }
> +                else {
> +                    $output = "";
> +                }
> +            }
> +            packet_flush();
> +            packet_write("success\n");
> +            print $debug "[OK]\n";
> +            $debug->flush();
> +        }
> +    }
> +}
> 

