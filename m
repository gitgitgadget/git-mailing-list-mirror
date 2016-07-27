Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 314311F855
	for <e@80x24.org>; Wed, 27 Jul 2016 23:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932717AbcG0XbZ (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 19:31:25 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35617 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932710AbcG0XbY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 19:31:24 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so8646441wmg.2
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 16:31:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=oZYVXWU8D15yGBDqc6/q+g83FcLy6iO8kaOi9MlHXSc=;
        b=rkFpMZ7Pzswh6eH4FxCR8edbKGKydgRjvo59FNbL6QBnLlaPo5zUt1D1R+UGQ92KBJ
         RekRNGZYj5A/UqS1wn4kWjOpi0jeopVqUn5LWIhfv5rVEdWRMy5zVpPV/duIjFShGGRY
         UPRdcOSCqRvAgTkiM0ZL85MSrY1wkjSe6PKl+4sgs2hp4LZz6S/q8DQ6yJSqGp6mx9Iv
         qHGWlQ3hqDV90/r7j8hLsvzyuYkzgaiKgk+5NjCM8zzF7L9X+OXkZ380FhkZMtIiQFUt
         GM5v40J9miefrJOxF08ETitBtyWPeigu4HPa3/kXVSZtb/GTwlXuE2rx0rTgHhRBQKsx
         xypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=oZYVXWU8D15yGBDqc6/q+g83FcLy6iO8kaOi9MlHXSc=;
        b=cnr75h0JG8FnOpsYcOaXQyeUyd4oCGSSGcTMKy/JBhTvgHalVeR/06gzSi1/wlIB3G
         u+e1fWrmbzjk+NhtZp75YXJdbjwQmg44LEkdkizSkC/zyUfzHNGGZfvpwfhm8ycX2knc
         DLtsDsblBb1l+MckrZAXLjOld1779DVNKZy8qFBYXNtIZxeImoK8kn7gPNUqqGtd7Yel
         pQdeNqMUBQ9NK/aohItdwfrhd22UNSJYsYjPVYxttrnXZSg9hYvRGzPof5OofrbFyd/O
         6CWsn+Wz4xTCA0hmVX+Fzl49cqe5kPJ7CW7aJ45dg55uaIU1OZS/UIKJw8je/xS30G6c
         Nzvw==
X-Gm-Message-State: AEkoouvrkvg/ru+/AdYqU6uCBYQl456zfGdawhtT7D2D4OGiqj9NaEkwT05JggJoM4nPSA==
X-Received: by 10.194.186.231 with SMTP id fn7mr30304836wjc.164.1469662280896;
        Wed, 27 Jul 2016 16:31:20 -0700 (PDT)
Received: from [192.168.1.26] (epw206.neoplus.adsl.tpnet.pl. [83.20.64.206])
        by smtp.googlemail.com with ESMTPSA id n131sm37479791wmd.3.2016.07.27.16.31.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jul 2016 16:31:19 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] convert: add filter.<driver>.process option
To:	larsxschneider@gmail.com, git@vger.kernel.org
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160727000605.49982-1-larsxschneider@gmail.com>
 <20160727000605.49982-6-larsxschneider@gmail.com>
Cc:	gitster@pobox.com, tboegi@web.de, mlbright@gmail.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr, pclouds@gmail.com,
	e@80x24.org, ramsay@ramsayjones.plus.com, peff@peff.net
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <57994436.4080308@gmail.com>
Date:	Thu, 28 Jul 2016 01:31:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20160727000605.49982-6-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-27 o 02:06, larsxschneider@gmail.com pisze:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Git's clean/smudge mechanism invokes an external filter process for every
> single blob that is affected by a filter. If Git filters a lot of blobs
> then the startup time of the external filter processes can become a
> significant part of the overall Git execution time.

It is not strictly necessary... but do we have any benchmarks for this,
or is it just the feeling?  That is, in what situations Git may filter
a large number of files (initial checkout? initial add?, switching
to unrelated branch? getting large files from LFS solution?, and when
startup time might become significant part of execution time (MS Windows?
fast filters?)?

> 
> This patch adds the filter.<driver>.process string option which, if used,

String option... what are possible values?  What happens if you use
value that is not recognized by Git (it is "if used", isn't it)?  That's
not obvious from the commit message (though it might be from the docs).

What is missing is the description that it is set to a command, and
how it interacts with `clean` and `smudge` options.

> keeps the external filter process running and processes all blobs with
> the following packet format (pkt-line) based protocol over standard input
> and standard output.
> 
> Git starts the filter on first usage and expects a welcome
> message, protocol version number, and filter capabilities
> seperated by spaces:

s/seperated/separated/

Is there any handling of misconfigured one-shot filters, or would
they still hang the execution of a Git command?

> ------------------------
> packet:          git< git-filter-protocol
> packet:          git< version 2
> packet:          git< clean smudge

Wouldn't "capabilities clean smudge" be better?  Or is it the
"clean smudge" proposal easier to handle?

> ------------------------
> Supported filter capabilities are "clean" and "smudge".
> 
> Afterwards Git sends a command (e.g. "smudge" or "clean" - based
> on the supported capabilities), the filename, the content size as
> ASCII number in bytes, and the content in packet format with a
> flush packet at the end:
> ------------------------
> packet:          git> smudge
> packet:          git> testfile.dat

And here we don't have any problems with files containing embedded
newlines etc.  Also Git should not be sending invalid file names.
The question remains: is it absolute file path, or basename?

> packet:          git> 7
> packet:          git> CONTENT

Can Git send file contents using more than one packet?  I think
it should be stated upfront.

> packet:          git> 0000
> ------------------------

Why we need to send content size upfront?  Well, it is not a problem
for Git, but (as I wrote in reply to the cover letter for this
series) might be a problem for filter scripts.

> 
> The filter is expected to respond with the result content size as
> ASCII number in bytes and the result content in packet format with
> a flush packet at the end:
> ------------------------
> packet:          git< 57

This is not neccessary (and might be hard for scripts to do) if
pkt-line protocol is used.

In short: I think pkt-line is not worth the complication on
the Git side and on the filter size, unless it is used for
streaming, or at least filter not having to calculate output
size upfront.

> packet:          git< SMUDGED_CONTENT
> packet:          git< 0000
> ------------------------
> Please note: In a future version of Git the capability "stream"
> might be supported. In that case the content size must not be
> part of the filter response.
> 
> Afterwards the filter is expected to wait for the next command.

When filter is supposed to exit, then?

> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> Helped-by: Martin-Louis Bright <mlbright@gmail.com>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  Documentation/gitattributes.txt |  54 +++++++-
>  convert.c                       | 269 ++++++++++++++++++++++++++++++++++++++--
>  t/t0021-conversion.sh           | 175 ++++++++++++++++++++++++++
>  t/t0021/rot13-filter.pl         | 146 ++++++++++++++++++++++
>  4 files changed, 631 insertions(+), 13 deletions(-)
>  create mode 100755 t/t0021/rot13-filter.pl
> 
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 8882a3e..8fb40d2 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -300,7 +300,11 @@ checkout, when the `smudge` command is specified, the command is
>  fed the blob object from its standard input, and its standard
>  output is used to update the worktree file.  Similarly, the
>  `clean` command is used to convert the contents of worktree file
> -upon checkin.
> +upon checkin. By default these commands process only a single
> +blob and terminate. If a long running filter process (see section
> +below) is used then Git can process all blobs with a single filter
> +invocation for the entire life of a single Git command (e.g.
> +`git add .`).

Ah, all right, here we give an example.

But, is "blob" term used in this document, or do we use "file"
and "file contents" only?

>  
>  One use of the content filtering is to massage the content into a shape
>  that is more convenient for the platform, filesystem, and the user to use.
> @@ -375,6 +379,54 @@ substitution.  For example:
>  ------------------------
>  
>  
> +Long Running Filter Process
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +If the filter command (string value) is defined via
> +filter.<driver>.process then Git can process all blobs with a
> +single filter invocation for the entire life of a single Git
> +command by talking with the following packet format (pkt-line)
> +based protocol over standard input and standard output.

Ah, so now it is the name of command, and I assume it is
exclusive with `clean` / `smudge`, or does it only takes
precedence based on capabilities of filter (that is if
for example "`process`" does not include 'clean' capability,
then `clean` filter is used, using per-file "protocol").
Or do something different happens (like preference for
old-style `clean` and `smudge` filters, and `process`
used if any unset)?

Anyway, Git command would never (I think) run both
"clean" and "smudge" filters.  But I might be wrong.

Yeah, I know this going back and forth seems like 
bike-shedding, but designing good user-facing API
is very, very important.

> +
> +Git starts the filter on first usage and expects a welcome
> +message, protocol version number, and filter capabilities
> +seperated by spaces:
> +------------------------
> +packet:          git< git-filter-protocol
> +packet:          git< version 2
> +packet:          git< clean smudge
> +------------------------

Neither of those is terminated by end of line character,
that is, "\n", isn't it?

> diff --git a/convert.c b/convert.c
> index 522e2c5..5ff200b 100644
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
> @@ -481,11 +482,232 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
>  	return ret;
>  }
>  
> +static off_t multi_packet_read(struct strbuf *sb, const int fd, const size_t size)

What's the purpose of this function?  Is it to gather read whole
contents of file into strbuf?  Or is it to read at most 'size'
bytes of file / of pkt-line stream into strbuf?

We probably don't want to keep the whole file in memory,
if possible.

> +{
> +	off_t bytes_read;
> +	off_t total_bytes_read = 0;
> +	strbuf_grow(sb, size + 1);	// we need one extra byte for the packet flush

Why we put packet flush into strbuf?  Or is it only temporarily,
and we adjust that at the end... I see that it is.

> +	do {
> +		bytes_read = packet_read(
> +			fd, NULL, NULL,
> +			sb->buf + total_bytes_read, sb->len - total_bytes_read - 1,
> +			PACKET_READ_GENTLE_ON_EOF
> +		);
> +		total_bytes_read += bytes_read;
> +	}
> +	while (
> +		bytes_read > 0 && 					// the last packet was no flush
> +		sb->len - total_bytes_read - 1 > 0 	// we still have space left in the buffer
> +	);
> +	strbuf_setlen(sb, total_bytes_read);
> +	return total_bytes_read;
> +}
> +
> +static int multi_packet_write(const char *src, size_t len, const int in, const int out)

What's the purpose of this function?  What are those 'in' and 'out'
parameters?  Those names do not describe them well.  If they are
file descriptors, add fd_* prefix (or whatever Git code uses).
Edit: I see that's what existing code uses.

Edit: so we are reading from *src + len or from fd_in, depending on
whether fd_in is set to 0 or not?  I guess that follows existing
code, where it is even worse, because it is hidden...

> +{
> +	int ret = 1;
> +	char header[4];
> +	char buffer[8192];

Could those two be in one variable?  Also, 'header' or 'pkt_header'?

Why 8192, and not LARGE_PACKET_MAX - 4?

> +	off_t bytes_to_write;
> +	while (ret) {
> +		if (in >= 0) {
> +			bytes_to_write = xread(in, buffer, sizeof(buffer));
> +			if (bytes_to_write < 0)
> +				ret &= 0;
> +			src = buffer;
> +		} else {
> +			bytes_to_write = len > LARGE_PACKET_MAX - 4 ? LARGE_PACKET_MAX - 4 : len;
> +			len -= bytes_to_write;
> +		}
> +		if (!bytes_to_write)
> +			break;
> +		set_packet_header(header, bytes_to_write + 4);
> +		ret &= write_in_full(out, &header, sizeof(header)) == sizeof(header);
> +		ret &= write_in_full(out, src, bytes_to_write) == bytes_to_write;

These three lines are equivalent to write_packet(), or however
it is named, isn't it?

> +	}
> +	ret &= write_in_full(out, "0000", 4) == 4;

This is equivalent to packet_flush(), or however it is named,
isn't it?

> +	return ret;
> +}
> +
> +struct cmd2process {
> +	struct hashmap_entry ent; /* must be the first member! */
> +	const char *cmd;
> +	int clean;
> +	int smudge;

These two are 'int' used as 'bool', isn't it?

> +	struct child_process process;
> +};
[...]
> +static struct cmd2process *find_protocol_filter_entry(struct hashmap *hashmap, const char *cmd)

Wouldn't it be more descriptive to name the first parameter
to this function 'cmd_hashmap', or something like that, rather
than plain 'hashmap' (it might be the same that is used / was
used for a global variable)?

Edit: or 'cmd_process_map'.

> +{
> +	struct cmd2process k;
> +	hashmap_entry_init(&k, strhash(cmd));
> +	k.cmd = cmd;
> +	return hashmap_get(hashmap, &k, NULL);
> +}

[...]
> +static struct cmd2process *start_protocol_filter(struct hashmap *hashmap, const char *cmd)
> +{
> +	int ret = 1;
> +	struct cmd2process *entry;
> +	struct child_process *process;
> +	const char *argv[] = { NULL, NULL };

Could we initialize it with  { cmd, NULL };?

Edit: Ah, I see that you follow filter_buffer_or_fd() example from
convert.c, isn't it?

> +	struct string_list capabilities = STRING_LIST_INIT_NODUP;
> +	char *capabilities_buffer;
> +	int i;
> +
> +	entry = xmalloc(sizeof(*entry));
> +	hashmap_entry_init(entry, strhash(cmd));
> +	entry->cmd = cmd;
> +	entry->clean = 0;
> +	entry->smudge = 0;

Wouldn't

   	entry->clean = entry->smudge = 0;

be more readable?

> +	process = &entry->process;
> +
> +	child_process_init(process);
> +	argv[0] = cmd;
> +	process->argv = argv;
> +	process->use_shell = 1;
> +	process->in = -1;

Maybe

  +	process->in  = -1;

to align, but perhaps it is not worth it.

> +	process->out = -1;
> +
> +	if (start_command(process)) {
> +		error("cannot fork to run external persistent filter '%s'", cmd);

Just a question: is "cannot fork" the only reason why start_command()
might have failed there?

Edit: Ah, I see that you follow filter_buffer_or_fd() example from
convert.c, again.

> +		stop_protocol_filter(hashmap, entry);
> +		return NULL;
> +	}
> +
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +	ret &= strcmp(packet_read_line(process->out, NULL), "git-filter-protocol") == 0;
> +	ret &= strcmp(packet_read_line(process->out, NULL), "version 2") == 0;

So that's why you need packet_read_line() to return string...

> +	capabilities_buffer = packet_read_line(process->out, NULL);
> +	sigchain_pop(SIGPIPE);
> +
> +	string_list_split_in_place(&capabilities, capabilities_buffer, ' ', -1);

This does not modify capabilities_buffer, does it?

> +	for (i = 0; i < capabilities.nr; i++) {
> +		const char *requested = capabilities.items[i].string;
> +		if (!strcmp(requested, "clean")) {
> +			entry->clean = 1;
> +		} else if (!strcmp(requested, "smudge")) {
> +			entry->smudge = 1;
> +		} else {
> +			warning(
> +				"filter process '%s' requested unsupported filter capability '%s'",
> +				cmd, requested
> +			);

Nice.  This makes it (somewhat) forward- and backward-compatibile.

> +		}
> +	}
> +	string_list_clear(&capabilities, 0);
> +
> +	if (!ret) {
> +		error("initialization for external persistent filter '%s' failed", cmd);

Do we need more detailed information about the source of error?

> +		stop_protocol_filter(hashmap, entry);
> +		return NULL;
> +	}
> +
> +	hashmap_add(hashmap, entry);
> +	return entry;
> +}
> +
> +static int cmd_process_map_init = 0;
> +static struct hashmap cmd_process_map;
> +
> +static int apply_protocol_filter(const char *path, const char *src, size_t len,
> +						int fd, struct strbuf *dst, const char *cmd,
> +						const char *filter_type)

That is... quite a lot of parameters.  But I guess there is precedens.
But I think 'fd' belongs to previous line, as it is alternative to
src+len.

> +{
> +	int ret = 1;
> +	struct cmd2process *entry;
> +	struct child_process *process;
> +	struct stat file_stat;
> +	struct strbuf nbuf = STRBUF_INIT;
> +	off_t expected_bytes;
> +	char *strtol_end;
> +	char *strbuf;
> +
> +	if (!cmd || !*cmd)
> +		return 0;
> +
> +	if (!dst)
> +		return 1;
> +
> +	if (!cmd_process_map_init) {
> +		cmd_process_map_init = 1;
> +		hashmap_init(&cmd_process_map, (hashmap_cmp_fn) cmd2process_cmp, 0);
> +		entry = NULL;

Is it better than having entry NULL-initialized?

> +	} else {
> +		entry = find_protocol_filter_entry(&cmd_process_map, cmd);
> +	}
> +
> +	if (!entry) {
> +		entry = start_protocol_filter(&cmd_process_map, cmd);

Hmmm... apply_filter() uses start_async() for some reason.  Why
it does not apply for this new kind of filter?

> +		if (!entry) {
> +			return 0;
> +		}
> +	}
> +	process = &entry->process;
> +
> +	if (!(!strcmp(filter_type, "clean") && entry->clean) &&
> +		!(!strcmp(filter_type, "smudge") && entry->smudge)) {

Would it be more readable as !(A || B) rather than (!A && !B)?

> +		return 0;
> +	}
> +
> +	if (fd >= 0 && !src) {
> +		ret &= fstat(fd, &file_stat) != -1;
> +		len = file_stat.st_size;
> +	}

All right, so we either use src+len,  or if we use fd we get
file size.

> +
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +
> +	packet_write(process->in, "%s\n", filter_type);
> +	packet_write(process->in, "%s\n", path);
> +	packet_write(process->in, "%zu\n", len);

So "\n" is included in protocol?

> +	ret &= multi_packet_write(src, len, fd, process->in);

How git-receive-pack etc. handle multi-packet write?

> +
> +	strbuf = packet_read_line(process->out, NULL);
> +	expected_bytes = (off_t)strtol(strbuf, &strtol_end, 10);
> +	ret &= (strtol_end != strbuf && errno != ERANGE);
> +
> +	if (expected_bytes > 0) {
> +		ret &= multi_packet_read(&nbuf, process->out, expected_bytes) == expected_bytes;
> +	}
> +
> +	sigchain_pop(SIGPIPE);
> +
> +	if (ret) {
> +		strbuf_swap(dst, &nbuf);
> +	} else {
> +		// Something went wrong with the protocol filter. Force shutdown!
> +		stop_protocol_filter(&cmd_process_map, entry);

Some error message would be nice... or do we print in down in stack?

> +	}
> +	strbuf_release(&nbuf);
> +	return ret;
> +}
> +


[...]
> @@ -823,7 +1049,10 @@ int would_convert_to_git_filter_fd(const char *path)
>  	if (!ca.drv->required)
>  		return 0;
>  
> -	return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
> +	if (!ca.drv->clean && ca.drv->process)
> +		return apply_protocol_filter(path, NULL, 0, -1, NULL, ca.drv->process, "clean");
> +	else
> +		return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);

So the rule is: if `clean` is not set, and `process` is, try to use
process for cleaning.  It was not clear for me from the documentation.

>  }
>  
>  const char *get_convert_attr_ascii(const char *path)
> @@ -856,17 +1085,22 @@ int convert_to_git(const char *path, const char *src, size_t len,
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
>  
> -	ret |= apply_filter(path, src, len, -1, dst, filter);
> +	if (!clean_filter && process_filter)
> +		ret |= apply_protocol_filter(path, src, len, -1, dst, process_filter, "clean");
> +	else
> +		ret |= apply_filter(path, src, len, -1, dst, clean_filter);

And the rule is the same here, as it should.

>  	if (!ret && required)
>  		die("%s: clean filter '%s' failed", path, ca.drv->name);

Is it a correct error message for `process`?  I guess it is, as it prints
the name of driver, and not attempted command.  Well, we might be using
"process" filter in 'clean' mode,... but that is sophistry.

[...]
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index b9911a4..c4793ed 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -4,6 +4,11 @@ test_description='blob conversion via gitattributes'
>  
>  . ./test-lib.sh
>  
> +if ! test_have_prereq PERL; then
> +	skip_all='skipping perl interface tests, perl not available'
> +	test_done
> +fi

Do all tests require Perl?

> +test_expect_success 'required protocol filter should filter data' '
[...]
> +test_expect_success 'protocol filter large file' '
[...]
> +test_expect_success 'required protocol filter should fail with clean' '
[...]
> +test_expect_success 'protocol filter should restart after failure' '
[...]

> diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
> new file mode 100755
> index 0000000..7176836
> --- /dev/null
> +++ b/t/t0021/rot13-filter.pl
> @@ -0,0 +1,146 @@
> +#!/usr/bin/perl
> +#
> +# Example implementation for the Git filter protocol version 2
> +# See Documentation/gitattributes.txt, section "Filter Protocol"
> +#
> +# This implementation supports two special test cases:
> +# (1) If data with the filename "clean-write-fail.r" is processed with
> +#     a "clean" operation then the write operation will die.
> +# (2) If data with the filename "smudge-write-fail.r" is processed with
> +#     a "smudge" operation then the write operation will die.

Nice.

> +#
> +
> +use strict;
> +use warnings;
> +
> +my $MAX_PACKET_CONTENT_SIZE = 65516;
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

This is a bit untypical bracket style...

> +        die "invalid packet size '$bytes_read' field";
> +    }
> +    my $pkt_size = hex($buffer);
> +    if ( $pkt_size == 0 ) {
> +        return ( 1, "" );
> +    }
> +    elsif ( $pkt_size > 4 ) {
> +        my $content_size = $pkt_size - 4;
> +        $bytes_read = read STDIN, $buffer, $content_size;
> +        if ( $bytes_read != $content_size ) {
> +            die "invalid packet";
> +        }
> +        return ( 0, $buffer );
> +    }
> +    else {
> +        die "invalid packet size";
> +    }
> +}

So packet reading is not that difficult...

> +
> +sub packet_write {
> +    my ($packet) = @_;
> +    print STDOUT sprintf( "%04x", length($packet) + 4 );
> +    print STDOUT $packet;
> +    STDOUT->flush();
> +}

...and packet write is easy.

> +
> +sub packet_flush {
> +    print STDOUT sprintf( "%04x", 0 );
> +    STDOUT->flush();
> +}
> +
> +open my $debug, ">>", "output.log";
> +print $debug "start\n";
> +$debug->flush();
> +
> +packet_write("git-filter-protocol\n");
> +packet_write("version 2\n");
> +packet_write("clean smudge\n");
> +print $debug "wrote filter header\n";
> +$debug->flush();

Isn't $debug flushed automatically?

> +
> +while (1) {
> +    my $command = packet_read();
> +    unless ( defined($command) ) {
> +        exit();
> +    }
> +    chomp $command;
> +    print $debug "IN: $command";
> +    $debug->flush();
> +    my $filename = packet_read();
> +    chomp $filename;
> +    print $debug " $filename";
> +    $debug->flush();
> +    my $filelen = packet_read();
> +    chomp $filelen;
> +    print $debug " $filelen";
> +    $debug->flush();
> +
> +    $filelen =~ /\A\d+\z/ or die "bad filelen: $filelen";
> +    my $output;
> +
> +    if ( $filelen > 0 ) {
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
> +        if ( $command eq "clean" ) {
> +            $output = rot13($input);
> +        }
> +        elsif ( $command eq "smudge" ) {
> +            $output = rot13($input);
> +        }
> +        else {
> +            die "bad command";

Perhaps

               die "bad command $command";

> +        }
> +    }
> +
> +    my $output_len = length($output);
> +    packet_write("$output_len\n");
> +    print $debug "OUT: $output_len ";
> +    $debug->flush();
> +    if ( $output_len > 0 ) {
> +        if (   ( $command eq "clean" and $filename eq "clean-write-fail.r" )

What happened here with whitespace around parentheses?

> +            or
> +            ( $command eq "smudge" and $filename eq "smudge-write-fail.r" ) )
> +        {
> +            print $debug " [FAIL]\n";
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
> +            print $debug "[OK]\n";
> +            $debug->flush();
> +        }
> +    }
> +}
> 

