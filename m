Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 081B41F955
	for <e@80x24.org>; Mon,  1 Aug 2016 18:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754720AbcHASOJ (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 14:14:09 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34599 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754315AbcHASNh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2016 14:13:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so27312138wma.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2016 11:12:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=95mvQg1oNBFOjOrPoqi0Qn6+kXucl4iRI4OWzdBefNE=;
        b=egMU6GvnEl4dFSJ37FWS5ZnTKSa5oSXF3/TcBvjL0S4jTfsRDgpvYnnnFTTInxgXQZ
         fWr97H9ANEd3gUtSMbc2XSlkEdBMNdsHyw/BHT+65mq8a6V2gV/V6as4DQDqp7Eg2ECV
         iTOHciSE6tQayDtWw4++kEWvpVeqCkkt5mkSKqkrP8Bx0m0K4tCvGVSAXe2ZWDfcZ4Ip
         NGfIQr8+4zsjkaPgtmVT4MF6QQRw2xQSakK8J7peUzrpO/r6TyJJa1zLkvRxuXDylHdt
         PnwJzS/JB5av+ECHWFWOQiU70cYvpETfnHwlO/9f2VZJfwWQfFW33kjS9ixGnBH1JIYr
         axtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=95mvQg1oNBFOjOrPoqi0Qn6+kXucl4iRI4OWzdBefNE=;
        b=GGhWDmGDPHv5B0MFIfFc10PiSUEvDJsxCBWmN6NlkZaKfBRjsCUpURrgn0SV7PAt7p
         v4x62KJhsgMqCbukiAEAYeo6u2ME/d+jmJd7YEfpflFP0JaxTHB1qja/wzIxotS0Hn/g
         GDBFUS6IsvgBLCHo3GOk1hj1TAnkoQA2e+HNwsQKVy363F3skBE2gp7FYhppfgaiUb+D
         Gj11/VgH9/J/wlK3CBFa+/BhkPUlp9v6vXgNw8slT6ON5ezf3u94wJ1nbRzy3IOecFmw
         6RsMvXME9T7p//uDw8MqWO8gFeZcDX0NA1+3sVipwIZ4hAhl6k/NtHZRfJDNs35hoXWZ
         pj9Q==
X-Gm-Message-State: AEkoousoh53fyRRWJYHiLo9AgQHH/D8qOoBjgx2dBLiPUsvpin38c6hKWcvV8h1Wdxc98g==
X-Received: by 10.28.92.71 with SMTP id q68mr14520486wmb.85.1470074159276;
        Mon, 01 Aug 2016 10:55:59 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id bw9sm31598147wjc.33.2016.08.01.10.55.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Aug 2016 10:55:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 10/10] convert: add filter.<driver>.process option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <2f4743d1-3c93-406d-8b44-da0eb075e65c@gmail.com>
Date:	Mon, 1 Aug 2016 19:55:46 +0200
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Martin-Louis Bright <mlbright@gmail.com>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <5180D54D-92C4-4875-AEB3-801663D70A8B@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/> <20160729233801.82844-1-larsxschneider@gmail.com> <20160729233801.82844-11-larsxschneider@gmail.com> <2f4743d1-3c93-406d-8b44-da0eb075e65c@gmail.com>
To:	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 01 Aug 2016, at 00:19, Jakub Narębski <jnareb@gmail.com> wrote:
> 
> W dniu 30.07.2016 o 01:38, larsxschneider@gmail.com pisze:
> [...]
>> +Please note that you cannot use an existing filter.<driver>.clean
>> +or filter.<driver>.smudge command as filter.<driver>.process
>> +command.
> 
> I think it would be more readable and easier to understand to write:
> 
>  ... you cannot use an existing ... command with
>  filter.<driver>.process
> 
> About the style: wouldn't `filter.<driver>.process` be better?

OK, changed it!


>>             As soon as Git would detect a file that needs to be
>> +processed by this filter, it would stop responding.
> 
> This is quite convoluted, and hard to understand.  I would say
> that because `clean` and `smudge` filters are expected to read
> first, while Git expects `process` filter to say first, using
> `clean` or `smudge` filter without changes as `process` filter
> would lead to git command deadlocking / hanging / stopping
> responding.

How about this:

Please note that you cannot use an existing `filter.<driver>.clean`
or `filter.<driver>.smudge` command with `filter.<driver>.process`
because the former two use a different inter process communication
protocol than the latter one. As soon as Git would detect a file
that needs to be processed by such an invalid "process" filter, 
it would wait for a proper protocol handshake and appear "hanging".


>> +
>> +
>> Interaction between checkin/checkout attributes
>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> 
>> diff --git a/convert.c b/convert.c
>> index 522e2c5..be6405c 100644
>> --- a/convert.c
>> +++ b/convert.c
>> @@ -3,6 +3,7 @@
>> #include "run-command.h"
>> #include "quote.h"
>> #include "sigchain.h"
>> +#include "pkt-line.h"
>> 
>> /*
>>  * convert.c - convert a file when checking it out and checking it in.
>> @@ -481,11 +482,355 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
>> 	return ret;
>> }
>> 
>> +static int multi_packet_read(int fd_in, struct strbuf *sb, size_t expected_bytes, int is_stream)
> 
> About name of this function: `multi_packet_read` is fine, though I wonder
> if `packet_read_in_full` with nearly the same parameters as `packet_read`,
> or `packet_read_till_flush`, or `read_in_full_packetized` would be better.

I like `multi_packet_read` and will rename!


> Also, the problem is that while we know that what packet_read() stores
> would fit in memory (in size_t), it is not true for reading whole file,
> which might be very large - for example huge graphical assets like raw
> images or raw videos, or virtual machine images.  Isn't that the goal
> of git-LFS solutions, which need this feature?  Shouldn't we have then
> both `multi_packet_read_to_fd` and `multi_packet_read_to_buf`,
> or whatever?

Git LFS works well with the current clean/smudge mechanism that uses the
same on in memory buffers. I understand your concern but I think this
improvement is out of scope for this patch series.


> Also, if we have `fd_in`, then perhaps `sb_out`?

Agreed!


> I am also unsure if `expected_bytes` (or `expected_size`) should not be
> just a size hint, leaving handing mismatch between expected size and
> real size of output to the caller; then the `is_stream` would be not
> needed.

As mentioned in a previous email... I will drop the "size" support in
this patch series as it is not really needed.


>> +{
>> +	int bytes_read;
>> +	size_t total_bytes_read = 0;
> 
> Why `bytes_read` is int, while `total_bytes_read` is size_t? Ah, I see
> that packet_read() returns an int.  It should be ssize_t, just like
> read(), isn't it?  But we know that packet size is limited, and would
> fit in an int (or would it?).

Yes, it is limited but I agree on ssize_t!


> Also, total_bytes_read could overflow size_t, but then we would have
> problems storing the result in strbuf.

Would that check be ok?

		if (total_bytes_read > SIZE_MAX - bytes_read)
			return 1;  // `total_bytes_read` would overflow and is not representable


>> +	if (expected_bytes == 0 && !is_stream)
>> +		return 0;
> 
> So in all cases *except* size = 0 we expect flush packet after the
> contents, but size = 0 is a corner case without flush packet?

I agree that is inconsistent... I will change it!


>> +
>> +	if (is_stream)
>> +		strbuf_grow(sb, LARGE_PACKET_MAX);           // allocate space for at least one packet
>> +	else
>> +		strbuf_grow(sb, st_add(expected_bytes, 1));  // add one extra byte for the packet flush
>> +
>> +	do {
>> +		bytes_read = packet_read(
>> +			fd_in, NULL, NULL,
>> +			sb->buf + total_bytes_read, sb->len - total_bytes_read - 1,
>> +			PACKET_READ_GENTLE_ON_EOF
>> +		);
>> +		if (bytes_read < 0)
>> +			return 1;  // unexpected EOF
> 
> Don't we usually return negative numbers on error?  Ah, I see that the
> return is a bool, which allows to use boolean expression with 'return'.
> But I am still unsure if it is good API, this return value.

According to Peff zero for success is the usual style:
http://public-inbox.org/git/20160728133523.GB21311%40sigill.intra.peff.net/


> If we move handling of size mismatch to the caller, then the function
> can simply return the size of data read (probably off_t or uint64_t).
> Then the caller can check if it is what it expected, and react accordingly.

True, but as discussed previously I will remove the size.


>> +
>> +		if (is_stream &&
>> +			bytes_read > 0 &&
>> +			sb->len - total_bytes_read - 1 <= 0)
>> +			strbuf_grow(sb, st_add(sb->len, LARGE_PACKET_MAX));
>> +		total_bytes_read += bytes_read;
>> +	}
>> +	while (
>> +		bytes_read > 0 &&                   // the last packet was no flush
>> +		sb->len - total_bytes_read - 1 > 0  // we still have space left in the buffer
> 
> Ah, so buffer is resized only in the 'is_stream' case.  Perhaps then
> use an "int options" instead of 'is_stream', and have one of flags
> tell if we should resize or not, that is if size parameter is hint
> or a strict limit.

Obsolete


>> +	);
>> +	strbuf_setlen(sb, total_bytes_read);
>> +	return (is_stream ? 0 : expected_bytes != total_bytes_read);
>> +}
>> +
>> +static int multi_packet_write_from_fd(const int fd_in, const int fd_out)
> 
> Is it equivalent of copy_fd() function, but where destination uses pkt-line
> and we need to pack data into pkt-lines?

Correct!


>> +{
>> +	int did_fail = 0;
>> +	ssize_t bytes_to_write;
>> +	while (!did_fail) {
>> +		bytes_to_write = xread(fd_in, PKTLINE_DATA_START(packet_buffer), PKTLINE_DATA_LEN);
> 
> Using global variable packet_buffer makes this code thread-unsafe, isn't it?
> But perhaps that is not a problem, because other functions are also
> using this global variable.

Correct!


> It is more of PKTLINE_DATA_MAXLEN, isn't it?

Agreed, will change!


> 
>> +		if (bytes_to_write < 0)
>> +			return 1;
>> +		if (bytes_to_write == 0)
>> +			break;
>> +		did_fail |= direct_packet_write(fd_out, packet_buffer, PKTLINE_HEADER_LEN + bytes_to_write, 1);
>> +	}
>> +	if (!did_fail)
>> +		did_fail = packet_flush_gentle(fd_out);
> 
> Shouldn't we try to flush even if there was an error?  Or is it
> that if there is an error writing, then there is some problem
> such that we know that flush would not work?

Right, that's what I though.


>> +	return did_fail;
> 
> Return true on fail?  Shouldn't we follow example of copy_fd()
> from copy.c, and return COPY_READ_ERROR, or COPY_WRITE_ERROR,
> or PKTLINE_WRITE_ERROR?

OK. How about this?

static int multi_packet_write_from_fd(const int fd_in, const int fd_out)
{
	int did_fail = 0;
	ssize_t bytes_to_write;
	while (!did_fail) {
		bytes_to_write = xread(fd_in, PKTLINE_DATA_START(packet_buffer), PKTLINE_DATA_MAXLEN);
		if (bytes_to_write < 0)
			return COPY_READ_ERROR;
		if (bytes_to_write == 0)
			break;
		did_fail |= direct_packet_write(fd_out, packet_buffer, PKTLINE_HEADER_LEN + bytes_to_write, 1);
	}
	if (!did_fail)
		did_fail = packet_flush_gently(fd_out);
	return (did_fail ? COPY_WRITE_ERROR : 0);
}


>> +}
>> +
>> +static int multi_packet_write_from_buf(const char *src, size_t len, int fd_out)
> 
> It is equivalent of write_in_full(), with different order of parameters,
> but where destination file descriptor expects pkt-line and we need to pack
> data into pkt-lines?

True. Do you suggest to reorder parameters? I also would like to rename `src` to `src_in`, OK?

> 
> NOTE: function description comments?

What do you mean here?


>> +{
>> +	int did_fail = 0;
>> +	size_t bytes_written = 0;
>> +	size_t bytes_to_write;
> 
> Note to self: bytes_to_write should fit in size_t, as it is limited to
> PKTLINE_DATA_LEN.  bytes_written should fit in size_t, as it is at most
> len, which is of type size_t.
> 
>> +	while (!did_fail) {
>> +		if ((len - bytes_written) > PKTLINE_DATA_LEN)
>> +			bytes_to_write = PKTLINE_DATA_LEN;
>> +		else
>> +			bytes_to_write = len - bytes_written;
>> +		if (bytes_to_write == 0)
>> +			break;
>> +		did_fail |= direct_packet_write_data(fd_out, src + bytes_written, bytes_to_write, 1);
>> +		bytes_written += bytes_to_write;
> 
> Ah, I see now why we need both direct_packet_write() and
> direct_packet_write_data().  Nice abstraction, makes for
> clear code.
> 
> The last parameter of '1' means 'gently', isn't it?

Correct. Thanks :)


>> +	}
>> +	if (!did_fail)
>> +		did_fail = packet_flush_gentle(fd_out);
>> +	return did_fail;
>> +}
> 
> I think all three/four of those functions should be added in a separate
> commit, separate patch in patch series.

OK

>  Namely:
> 
> - for git -> filter:
>    * read from fd,      write pkt-line to fd  (off_t)
>    * read from str+len, write pkt-line to fd  (size_t, ssize_t)
> - for filter -> git:
>    * read pkt-line from fd, write to fd       (off_t)

This one does not exist.


>    * read pkt-line from fd, write to str+len  (size_t, ssize_t)
> 
> Perhaps some of those can be in one overloaded function, perhaps it would
> be easier to keep them separate.

I would like to keep them separate as it is easier to comprehend.

> 
> Also, I do wonder how the fetch / push code spools pack file received
> over pkt-lines to disk.  Can we reuse that code?

I haven't found any.


>  Or maybe that code
> could use those new functions?

I think so, but this would be out of scope for this series :)


>> +
>> +#define FILTER_CAPABILITIES_STREAM   0x1
>> +#define FILTER_CAPABILITIES_CLEAN    0x2
>> +#define FILTER_CAPABILITIES_SMUDGE   0x4
>> +#define FILTER_CAPABILITIES_SHUTDOWN 0x8
>> +#define FILTER_SUPPORTS_STREAM(type) ((type) & FILTER_CAPABILITIES_STREAM)
>> +#define FILTER_SUPPORTS_CLEAN(type)  ((type) & FILTER_CAPABILITIES_CLEAN)
>> +#define FILTER_SUPPORTS_SMUDGE(type) ((type) & FILTER_CAPABILITIES_SMUDGE)
>> +#define FILTER_SUPPORTS_SHUTDOWN(type) ((type) & FILTER_CAPABILITIES_SHUTDOWN)
>> +
>> +struct cmd2process {
>> +	struct hashmap_entry ent; /* must be the first member! */
>> +	const char *cmd;
>> +	int supported_capabilities;
> 
> I wonder if switching from int (perhaps with field width of 1 to denote
> that it is boolean-like flag) to mask makes it more readable, or less.
> But I think it is.
> 
> 
> Reading Documentation/technical/api-hashmap.txt I found the following
> recommendation:
> 
>  `struct hashmap_entry`::
> 
>        An opaque structure representing an entry in the hash table, which must
>        be used as first member of user data structures. Ideally it should be
>        followed by an int-sized member to prevent unused memory on 64-bit
>        systems due to alignment.
> 
> Therefore it "int supported_capabilities" should precede
> "const char *cmd", I think.  Though it is not strictly necessary; it
> is not as if this hash table were large (maximum size is limited by
> the number of filter drivers configured), so we don't waste much space
> due to internal padding / due to alignment.

Thanks! I will change it to your suggestion anyway!


> 
>> +	struct child_process process;
>> +};
>> +
>> +static int cmd_process_map_initialized = 0;
>> +static struct hashmap cmd_process_map;
> 
> Reading Documentation/technical/api-hashmap.txt I see that:
> 
>  `tablesize` is the allocated size of the hash table. A non-0 value indicates
>  that the hashmap is initialized.
> 
> So cmd_process_map_initialized is not really needed, is it?

I copied that from config.c:
https://github.com/git/git/blob/f8f7adce9fc50a11a764d57815602dcb818d1816/config.c#L1425-L1428

`git grep "tablesize"` reveals that the check for `tablesize` is only used
in hashmap.c ... so what approach should we use?


>> +
>> +static int cmd2process_cmp(const struct cmd2process *e1,
>> +							const struct cmd2process *e2,
>> +							const void *unused)
>> +{
>> +	return strcmp(e1->cmd, e2->cmd);
>> +}
> 
> Well, to be exact (which is decidely not needed!) two commands might
> be equivalent not being identical as strings (e.g. extra space between
> parameters).  But it is something the user should care about, not Git.
> 
>> +
>> +static struct cmd2process *find_protocol2_filter_entry(struct hashmap *hashmap, const char *cmd)
> 
> I'm not sure if *_protocol2_* is needed; those functions are static,
> local to convert.c.

I want to make sure that the reader understands that these functions are
related to the filter protocol version 2. Not OK?


>> +{
>> +	struct cmd2process k;
> 
> Does this name of variable 'k' follow established convention?
> 'key' would be more descriptive, but it's not as if this function
> was long; so 'k' is all right, I think.

I agree on "key".


> 
>> +	hashmap_entry_init(&k, strhash(cmd));
>> +	k.cmd = cmd;
>> +	return hashmap_get(hashmap, &k, NULL);
>> +}
>> +
>> +static void kill_protocol2_filter(struct hashmap *hashmap, struct cmd2process *entry) {
> 
> Programming style: the opening brace should be on separate line,
> that is:
> 
>  +static void kill_protocol2_filter(struct hashmap *hashmap, struct cmd2process *entry)
>  +{

Agreed!


>> +	if (!entry)
>> +		return;
>> +	sigchain_push(SIGPIPE, SIG_IGN);
>> +	close(entry->process.in);
>> +	close(entry->process.out);
>> +	sigchain_pop(SIGPIPE);
>> +	finish_command(&entry->process);
>> +	child_process_clear(&entry->process);
>> +	hashmap_remove(hashmap, entry, NULL);
>> +	free(entry);
>> +}
> 
> All those, from #define FILTER_CAPABILITIES_ to here could be put
> in a separate patch, to reduce size of this one.  But I am less
> sure that it is worth it for this case.
> 
>> +
>> +void shutdown_protocol2_filter(pid_t pid)
>> +{
> [...]
> 
> In my opinion this should be postponed to a separate commit.

Agreed!

> 
>> +}
>> +
>> +static struct cmd2process *start_protocol2_filter(struct hashmap *hashmap, const char *cmd)
> 
> This has some parts in common with existing filter_buffer_or_fd().
> I wonder if it would be worth to extract those common parts.
> 
> But perhaps it would be better to leave such refactoring for later.
> 
>> +{
>> +	int did_fail;
>> +	struct cmd2process *entry;
>> +	struct child_process *process;
>> +	const char *argv[] = { cmd, NULL };
>> +	struct string_list capabilities = STRING_LIST_INIT_NODUP;
>> +	char *capabilities_buffer;
>> +	int i;
>> +
>> +	entry = xmalloc(sizeof(*entry));
>> +	hashmap_entry_init(entry, strhash(cmd));
>> +	entry->cmd = cmd;
>> +	entry->supported_capabilities = 0;
>> +	process = &entry->process;
>> +
>> +	child_process_init(process);
> 
> filter_buffer_or_fd() uses instead
> 
>  struct child_process child_process = CHILD_PROCESS_INIT;
> 
> But I see that you need to access &entry->process anyway, so you
> need to have it here, and in this case child_process_init() is
> equivalent.
> 
> I wonder if it would be worth it to use strbuf for cmd.

What do you mean by "worth it to use strbuf for cmd"? Why would
we need a strbuf?


>> +	process->argv = argv;
>> +	process->use_shell = 1;
>> +	process->in = -1;
>> +	process->out = -1;
>> +	process->clean_on_exit = 1;
>> +	process->clean_on_exit_handler = shutdown_protocol2_filter;
> 
> These two lines are new, and related to the "shutdown" capability, isn't it?

Yes.


> 
>> +
>> +	if (start_command(process)) {
>> +		error("cannot fork to run external filter '%s'", cmd);
>> +		kill_protocol2_filter(hashmap, entry);
> 
> I guess the alternative solution of adding filter to the hashmap only
> after starting the process would be racy?
> 
> Ah, disregard that. I see that this pattern is a common way to error
> out in this function (for process-related errors).
> 
>> +		return NULL;
>> +	}
>> +
>> +	sigchain_push(SIGPIPE, SIG_IGN);
>> +	did_fail = strcmp(packet_read_line(process->out, NULL), "git-filter-protocol");
>> +	if (!did_fail)
>> +		did_fail |= strcmp(packet_read_line(process->out, NULL), "version 2");
>> +	if (!did_fail)
>> +		capabilities_buffer = packet_read_line(process->out, NULL);
>> +	else
>> +		capabilities_buffer = NULL;
>> +	sigchain_pop(SIGPIPE);
>> +
>> +	if (!did_fail && capabilities_buffer) {
>> +		string_list_split_in_place(&capabilities, capabilities_buffer, ' ', -1);
>> +		if (capabilities.nr > 1 &&
>> +			!strcmp(capabilities.items[0].string, "capabilities")) {
>> +			for (i = 1; i < capabilities.nr; i++) {
>> +				const char *requested = capabilities.items[i].string;
>> +				if (!strcmp(requested, "stream")) {
>> +					entry->supported_capabilities |= FILTER_CAPABILITIES_STREAM;
>> +				} else if (!strcmp(requested, "clean")) {
>> +					entry->supported_capabilities |= FILTER_CAPABILITIES_CLEAN;
>> +				} else if (!strcmp(requested, "smudge")) {
>> +					entry->supported_capabilities |= FILTER_CAPABILITIES_SMUDGE;
>> +				} else if (!strcmp(requested, "shutdown")) {
>> +					entry->supported_capabilities |= FILTER_CAPABILITIES_SHUTDOWN;
>> +				} else {
>> +					warning(
>> +						"external filter '%s' requested unsupported filter capability '%s'",
>> +						cmd, requested
>> +					);
>> +				}
>> +			}
>> +		} else {
>> +			error("filter capabilities not found");
>> +			did_fail = 1;
>> +		}
>> +		string_list_clear(&capabilities, 0);
>> +	}
> 
> I wonder if the above conditional wouldn't be better to be put in
> a separate function, parse_filter_capabilities(capabilities_buffer),
> returning a mask, or having mask as an out parameter, and returning
> an error condition.

Agreed.


>> +
>> +	if (did_fail) {
>> +		error("initialization for external filter '%s' failed", cmd);
> 
> More detailed information not needed, because one can use GIT_PACKET_TRACE.
> Would it be worth add this information as a kind of advice, or put it
> in the documentation of the `process` option?

I will put it into the docs.


> 
>> +		kill_protocol2_filter(hashmap, entry);
>> +		return NULL;
>> +	}
>> +
>> +	hashmap_add(hashmap, entry);
>> +	return entry;
>> +}
>> +
>> +static int apply_protocol2_filter(const char *path, const char *src, size_t len,
>> +						int fd, struct strbuf *dst, const char *cmd,
>> +						const int wanted_capability)
> 
> apply_protocol2_filter, or apply_process_filter?  Or rather,
> s/_protocol2_/_process_/g ?

Mh. I wanted to convey that this functions is protocol V2 related...

> 
> This is equivalent to
> 
>   static int apply_filter(const char *path, const char *src, size_t len, int fd,
>                           struct strbuf *dst, const char *cmd)
> 
> Could we have extended that one instead?

Initially I had one function but that got kind of long ... I prefer two for now.


>> +{
>> +	int ret = 1;
>> +	struct cmd2process *entry;
>> +	struct child_process *process;
>> +	struct stat file_stat;
>> +	struct strbuf nbuf = STRBUF_INIT;
>> +	size_t expected_bytes = 0;
>> +	char *strtol_end;
>> +	char *strbuf;
>> +	char *filter_type;
>> +	char *filter_result = NULL;
>> +
> 
>> +	if (!cmd || !*cmd)
>> +		return 0;
>> +
>> +	if (!dst)
>> +		return 1;
> 
> This is the same as in apply_filter().
> 
>> +
>> +	if (!cmd_process_map_initialized) {
>> +		cmd_process_map_initialized = 1;
>> +		hashmap_init(&cmd_process_map, (hashmap_cmp_fn) cmd2process_cmp, 0);
>> +		entry = NULL;
>> +	} else {
>> +		entry = find_protocol2_filter_entry(&cmd_process_map, cmd);
>> +	}
> 
> Here we try to find existing process, rather than starting new
> as in apply_filter()
> 
>> +
>> +	fflush(NULL);
> 
> This is the same as in apply_filter(), but I wonder what it is for.

"If the stream argument is NULL, fflush() flushes all
 open output streams."

http://man7.org/linux/man-pages/man3/fflush.3.html

> 
>> +
>> +	if (!entry) {
>> +		entry = start_protocol2_filter(&cmd_process_map, cmd);
>> +		if (!entry) {
>> +			return 0;
>> +		}
> 
> Style; we prefer:
> 
>  +		if (!entry)
>  +			return 0;

Agreed.


> This is very similar to apply_filter(), but the latter uses start_async()
> from "run-command.h", with filter_buffer_or_fd() as asynchronous process,
> which gets passed command to run in struct filter_params.  In this
> function start_protocol2_filter() runs start_command(), synchronous API.
> 
> Why the difference?

The protocol V2 requires a sequential processing of the packets. See
discussion with Junio here:
http://public-inbox.org/git/xmqqbn1th5qn.fsf%40gitster.mtv.corp.google.com/

[LONG SNIP]

I will answer the second half in a separate email.

Thanks for the review,
Lars

