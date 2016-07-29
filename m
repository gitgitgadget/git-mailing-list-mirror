Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DC111F71B
	for <e@80x24.org>; Fri, 29 Jul 2016 08:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbcG2IEn (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 04:04:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34859 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbcG2IEh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2016 04:04:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so14550756wmg.2
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 01:04:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jnBt5Ve7GN/04aQB0Oh/X713/PvAxM5VOdnGCnREoxo=;
        b=shgthmfcNr2nakWVr+b2oGZ6TZTaUnoTCsAdf7F4eOhOY9kao3Vh6YD5e3Y+5BRGV9
         X7M+OaE4s8vuD8BTWK4Plwh2TbN1tPoCDqU2Q/1QrAtb8N6GN22stcSTy5odQ9MZo6zN
         EOPAxHRVPxbp/napfSOuzpxnpOXWup7PHhAKoLAfV+0N4MziUdGBuEQMOPN3CFox6oHx
         up/DdOUI258KS9HmYHbJmvipm83vwcGgVBvxrQV9XswLQ+80fQat/8DXskX6ldCtROSY
         hr+NScIoEzv33wo3Wa9AZzaN7FP6+JPFQ4nQJgyX+Fpb24s2UZ+r24dWZNKU+dljKPoo
         vNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jnBt5Ve7GN/04aQB0Oh/X713/PvAxM5VOdnGCnREoxo=;
        b=CUaCIoFtD9whKU3wh7SQbKDZeHCwKGyhacrmb69ro6k1kCkju5Ly8c+dVWNPJneGtp
         kQBJRNJVIcWmfCP8yQqccpBh14LlbebdSdzk/u0M0lyF2qXS1i9Btk8DpNtSPIW6XdL6
         aFswfmzH2H4++cNG55NqKi13OQckPHhqFTCiE5vR7OYaDSRYxPX05DPCl+iGFDa+KLUp
         PCAOxW/Z38qqLxCiRQRtesgUOqsI7SrcNIVzBK4QyCYhlzYKLcemSaaE4xOS0KNyVrvI
         8WXVG/HxD9WlZqjQTeh7sBmwkbCfnfxvwtCffTpHprJS5ZCNCXkK9j4R5M7gMaPFyDve
         8UNg==
X-Gm-Message-State: ALyK8tJ9zy9cFCTsrHBf1/tYQoKaE+s/JuZQr4jkx1DAu64IRcMj8Kx2LwR238CXXY2ewA==
X-Received: by 10.28.169.82 with SMTP id s79mr64193725wme.87.1469779475297;
        Fri, 29 Jul 2016 01:04:35 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4145.dip0.t-ipconnect.de. [93.219.65.69])
        by smtp.gmail.com with ESMTPSA id 3sm1799164wms.1.2016.07.29.01.04.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jul 2016 01:04:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 5/5] convert: add filter.<driver>.process option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <57994436.4080308@gmail.com>
Date:	Fri, 29 Jul 2016 10:04:31 +0200
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Eric Wong <e@80x24.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Transfer-Encoding: 8BIT
Message-Id: <7F1F1A0E-8FC3-4FBD-81AA-37786DE0EF50@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com> <20160727000605.49982-1-larsxschneider@gmail.com> <20160727000605.49982-6-larsxschneider@gmail.com> <57994436.4080308@gmail.com>
To:	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 28 Jul 2016, at 01:31, Jakub Narębski <jnareb@gmail.com> wrote:
> 
> W dniu 2016-07-27 o 02:06, larsxschneider@gmail.com pisze:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> Git's clean/smudge mechanism invokes an external filter process for every
>> single blob that is affected by a filter. If Git filters a lot of blobs
>> then the startup time of the external filter processes can become a
>> significant part of the overall Git execution time.
> 
> It is not strictly necessary... but do we have any benchmarks for this,
> or is it just the feeling?  That is, in what situations Git may filter
> a large number of files (initial checkout? initial add?, switching
> to unrelated branch? getting large files from LFS solution?, and when
> startup time might become significant part of execution time (MS Windows?
> fast filters?)?

All the operations you mentioned are slow because they all cause filter
process invocations. I benchmarked the new filter protocol and it is 
almost 70x faster when switching branches on my local machine (i7, SSD, 
OS X) with a test repository containing 12,000 files that need to be 
filtered. 
Details here: https://github.com/github/git-lfs/pull/1382

Based on my previous experience with Git filter invocations I expect even
more dramatic results on Windows (I will benchmark this, too, as soon as
the list agrees on this approach).


>> This patch adds the filter.<driver>.process string option which, if used,
> 
> String option... what are possible values?  What happens if you use
> value that is not recognized by Git (it is "if used", isn't it)?  That's
> not obvious from the commit message (though it might be from the docs).

Then the process invocation will fail in the same way current filter
process invocations fail. If "filter.<driver>.required" is set then
Git will fail, otherwise not. 


> What is missing is the description that it is set to a command, and
> how it interacts with `clean` and `smudge` options.

Right, I'll add that! I implemented it in a way that the "filter.<driver>.clean" 
and "filter.<driver>.smudge" take presence over "filter.<driver>.process".

This allows the use of a `single-shot` clean filter and a `long-running` 
smudge as suggested by Junio in the v1 discussion (no ref, gmane down).


>> keeps the external filter process running and processes all blobs with
>> the following packet format (pkt-line) based protocol over standard input
>> and standard output.
>> 
>> Git starts the filter on first usage and expects a welcome
>> message, protocol version number, and filter capabilities
>> seperated by spaces:
> 
> s/seperated/separated/

Thanks!


> Is there any handling of misconfigured one-shot filters, or would
> they still hang the execution of a Git command?

They would still hang. Would it be sufficient to mention that in the
docs?


>> ------------------------
>> packet:          git< git-filter-protocol
>> packet:          git< version 2
>> packet:          git< clean smudge
> 
> Wouldn't "capabilities clean smudge" be better?  Or is it the
> "clean smudge" proposal easier to handle?

Good suggestion! This is easy to handle and I think it mimics
the pack-protocol a bit more closely.


>> ------------------------
>> Supported filter capabilities are "clean" and "smudge".
>> 
>> Afterwards Git sends a command (e.g. "smudge" or "clean" - based
>> on the supported capabilities), the filename, the content size as
>> ASCII number in bytes, and the content in packet format with a
>> flush packet at the end:
>> ------------------------
>> packet:          git> smudge
>> packet:          git> testfile.dat
> 
> And here we don't have any problems with files containing embedded
> newlines etc.  Also Git should not be sending invalid file names.
> The question remains: is it absolute file path, or basename?

It sends a path absolute in context of the Git repo (e.g. subdir/testfile.dat).
I'll add that to the docs and I'll add a test case to demonstrate it.

> 
>> packet:          git> 7
>> packet:          git> CONTENT
> 
> Can Git send file contents using more than one packet?  I think
> it should be stated upfront.

OK


>> packet:          git> 0000
>> ------------------------
> 
> Why we need to send content size upfront?  Well, it is not a problem
> for Git, but (as I wrote in reply to the cover letter for this
> series) might be a problem for filter scripts.

I think sending it upfront is nice for buffer allocations of big files
and it doesn't cost us anything to do it.


>> The filter is expected to respond with the result content size as
>> ASCII number in bytes and the result content in packet format with
>> a flush packet at the end:
>> ------------------------
>> packet:          git< 57
> 
> This is not neccessary (and might be hard for scripts to do) if
> pkt-line protocol is used.
> 
> In short: I think pkt-line is not worth the complication on
> the Git side and on the filter size, unless it is used for
> streaming, or at least filter not having to calculate output
> size upfront.

As I stated in my other response to you, I think there is value
in having a single protocol for streaming and non-streaming
content. I'll add a capability "stream" that doesn't require the 
"size upfront" answer from the filter.


> 
>> packet:          git< SMUDGED_CONTENT
>> packet:          git< 0000
>> ------------------------
>> Please note: In a future version of Git the capability "stream"
>> might be supported. In that case the content size must not be
>> part of the filter response.
>> 
>> Afterwards the filter is expected to wait for the next command.
> 
> When filter is supposed to exit, then?

Never by its own. The filter is always shutdown by Git. Something
for the docs, I guess :-)


>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> Helped-by: Martin-Louis Bright <mlbright@gmail.com>
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> Documentation/gitattributes.txt |  54 +++++++-
>> convert.c                       | 269 ++++++++++++++++++++++++++++++++++++++--
>> t/t0021-conversion.sh           | 175 ++++++++++++++++++++++++++
>> t/t0021/rot13-filter.pl         | 146 ++++++++++++++++++++++
>> 4 files changed, 631 insertions(+), 13 deletions(-)
>> create mode 100755 t/t0021/rot13-filter.pl
>> 
>> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
>> index 8882a3e..8fb40d2 100644
>> --- a/Documentation/gitattributes.txt
>> +++ b/Documentation/gitattributes.txt
>> @@ -300,7 +300,11 @@ checkout, when the `smudge` command is specified, the command is
>> fed the blob object from its standard input, and its standard
>> output is used to update the worktree file.  Similarly, the
>> `clean` command is used to convert the contents of worktree file
>> -upon checkin.
>> +upon checkin. By default these commands process only a single
>> +blob and terminate. If a long running filter process (see section
>> +below) is used then Git can process all blobs with a single filter
>> +invocation for the entire life of a single Git command (e.g.
>> +`git add .`).
> 
> Ah, all right, here we give an example.
> 
> But, is "blob" term used in this document, or do we use "file"
> and "file contents" only?

Both terms are used in the document. Blob is also already used in a
similar context above.


>> 
>> One use of the content filtering is to massage the content into a shape
>> that is more convenient for the platform, filesystem, and the user to use.
>> @@ -375,6 +379,54 @@ substitution.  For example:
>> ------------------------
>> 
>> 
>> +Long Running Filter Process
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +If the filter command (string value) is defined via
>> +filter.<driver>.process then Git can process all blobs with a
>> +single filter invocation for the entire life of a single Git
>> +command by talking with the following packet format (pkt-line)
>> +based protocol over standard input and standard output.
> 
> Ah, so now it is the name of command,

Correct!


> and I assume it is
> exclusive with `clean` / `smudge`, or does it only takes
> precedence based on capabilities of filter (that is if
> for example "`process`" does not include 'clean' capability,
> then `clean` filter is used, using per-file "protocol").
> Or do something different happens (like preference for
> old-style `clean` and `smudge` filters, and `process`
> used if any unset)?

The existing `single-shot` clean/smudge filter takes precedence
if they are available. The reason is that we would need to
start the `long-running` filter to figure out what capabilities
it has. On the upside I think that is the safest course of action
for existing Git installations out there.

I'll add test cases to demonstrate/ensure that behavior.


> Anyway, Git command would never (I think) run both
> "clean" and "smudge" filters.  But I might be wrong.

I think Git can invoke both filters on checkout.


> Yeah, I know this going back and forth seems like 
> bike-shedding, but designing good user-facing API
> is very, very important.

I agree and I really appreciate that you sacrifice your time to think
it through!


>> +
>> +Git starts the filter on first usage and expects a welcome
>> +message, protocol version number, and filter capabilities
>> +seperated by spaces:
>> +------------------------
>> +packet:          git< git-filter-protocol
>> +packet:          git< version 2
>> +packet:          git< clean smudge
>> +------------------------
> 
> Neither of those is terminated by end of line character,
> that is, "\n", isn't it?

Correct. Will add that.

> 
>> diff --git a/convert.c b/convert.c
>> index 522e2c5..5ff200b 100644
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
>> @@ -481,11 +482,232 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
>> 	return ret;
>> }
>> 
>> +static off_t multi_packet_read(struct strbuf *sb, const int fd, const size_t size)
> 
> What's the purpose of this function?  Is it to gather read whole
> contents of file into strbuf?  Or is it to read at most 'size'
> bytes of file / of pkt-line stream into strbuf?

This function reads pkt-lines until a flush packet into the strbuf.


> We probably don't want to keep the whole file in memory,
> if possible.

I understand your concern but this what the original implementation
does, too, and therefore I would like to keep the behavior:
https://github.com/git/git/blob/8c6d1f9807c67532e7fb545a944b064faff0f70b/convert.c#L462


>> +{
>> +	off_t bytes_read;
>> +	off_t total_bytes_read = 0;
>> +	strbuf_grow(sb, size + 1);	// we need one extra byte for the packet flush
> 
> Why we put packet flush into strbuf?  Or is it only temporarily,
> and we adjust that at the end... I see that it is.

Correct.


>> +	do {
>> +		bytes_read = packet_read(
>> +			fd, NULL, NULL,
>> +			sb->buf + total_bytes_read, sb->len - total_bytes_read - 1,
>> +			PACKET_READ_GENTLE_ON_EOF
>> +		);
>> +		total_bytes_read += bytes_read;
>> +	}
>> +	while (
>> +		bytes_read > 0 && 					// the last packet was no flush
>> +		sb->len - total_bytes_read - 1 > 0 	// we still have space left in the buffer
>> +	);
>> +	strbuf_setlen(sb, total_bytes_read);
>> +	return total_bytes_read;
>> +}
>> +
>> +static int multi_packet_write(const char *src, size_t len, const int in, const int out)
> 
> What's the purpose of this function?  What are those 'in' and 'out'
> parameters?  Those names do not describe them well.  If they are
> file descriptors, add fd_* prefix (or whatever Git code uses).
> Edit: I see that's what existing code uses.

OK


> Edit: so we are reading from *src + len or from fd_in, depending on
> whether fd_in is set to 0 or not?  I guess that follows existing
> code, where it is even worse, because it is hidden...

Right


>> +{
>> +	int ret = 1;
>> +	char header[4];
>> +	char buffer[8192];
> 
> Could those two be in one variable?  Also, 'header' or 'pkt_header'?
> 
> Why 8192, and not LARGE_PACKET_MAX - 4?

Agreed. I've changed that.


> 
>> +	off_t bytes_to_write;
>> +	while (ret) {
>> +		if (in >= 0) {
>> +			bytes_to_write = xread(in, buffer, sizeof(buffer));
>> +			if (bytes_to_write < 0)
>> +				ret &= 0;
>> +			src = buffer;
>> +		} else {
>> +			bytes_to_write = len > LARGE_PACKET_MAX - 4 ? LARGE_PACKET_MAX - 4 : len;
>> +			len -= bytes_to_write;
>> +		}
>> +		if (!bytes_to_write)
>> +			break;
>> +		set_packet_header(header, bytes_to_write + 4);
>> +		ret &= write_in_full(out, &header, sizeof(header)) == sizeof(header);
>> +		ret &= write_in_full(out, src, bytes_to_write) == bytes_to_write;
> 
> These three lines are equivalent to write_packet(), or however
> it is named, isn't it?

A little different. As I discussed with Peff elsewhere the existing write_packet
functions doesn't write the content of src directly. It creates a buffer which 
would cause unnecessary copy operations. However, as Junio noted, creating
these pkt-lines here is wrong. I will add an function to pkt-line.h that can create
a pkt-line without buffer.


>> +	}
>> +	ret &= write_in_full(out, "0000", 4) == 4;
> 
> This is equivalent to packet_flush(), or however it is named,
> isn't it?

packet_flush uses "write_or_die" internally. If the a non required filter fails
then this is no reason to die. However, using this pkt-line knowledge here is
wrong. I will add a new function to pkt-line.h. What do you think about
"tolerant_packet_flush" as function name?


>> +	return ret;
>> +}
>> +
>> +struct cmd2process {
>> +	struct hashmap_entry ent; /* must be the first member! */
>> +	const char *cmd;
>> +	int clean;
>> +	int smudge;
> 
> These two are 'int' used as 'bool', isn't it?

Yes, but I realized that this becomes cumbersome with more "bools". I create a bitmap
and a few macros to check and set the bitmap (seems to be the Git way for these kind
of problems).


>> +	struct child_process process;
>> +};
> [...]
>> +static struct cmd2process *find_protocol_filter_entry(struct hashmap *hashmap, const char *cmd)
> 
> Wouldn't it be more descriptive to name the first parameter
> to this function 'cmd_hashmap', or something like that, rather
> than plain 'hashmap' (it might be the same that is used / was
> used for a global variable)?
> 
> Edit: or 'cmd_process_map'.

I could, but wouldn't that shadow the global variable? Wouldn't that be even
more confusing?


>> +{
>> +	struct cmd2process k;
>> +	hashmap_entry_init(&k, strhash(cmd));
>> +	k.cmd = cmd;
>> +	return hashmap_get(hashmap, &k, NULL);
>> +}
> 
> [...]
>> +static struct cmd2process *start_protocol_filter(struct hashmap *hashmap, const char *cmd)
>> +{
>> +	int ret = 1;
>> +	struct cmd2process *entry;
>> +	struct child_process *process;
>> +	const char *argv[] = { NULL, NULL };
> 
> Could we initialize it with  { cmd, NULL };?
> 
> Edit: Ah, I see that you follow filter_buffer_or_fd() example from
> convert.c, isn't it?

Correct. But filter_buffer_or_fd() requires some extra work on cmd
that is not necessary here. I change it to your suggestion!


>> +	struct string_list capabilities = STRING_LIST_INIT_NODUP;
>> +	char *capabilities_buffer;
>> +	int i;
>> +
>> +	entry = xmalloc(sizeof(*entry));
>> +	hashmap_entry_init(entry, strhash(cmd));
>> +	entry->cmd = cmd;
>> +	entry->clean = 0;
>> +	entry->smudge = 0;
> 
> Wouldn't
> 
>   	entry->clean = entry->smudge = 0;
> 
> be more readable?

I changed it to a bitmap with a single int :)


>> +	process = &entry->process;
>> +
>> +	child_process_init(process);
>> +	argv[0] = cmd;
>> +	process->argv = argv;
>> +	process->use_shell = 1;
>> +	process->in = -1;
> 
> Maybe
> 
>  +	process->in  = -1;
> 
> to align, but perhaps it is not worth it.

Not aligned in the original code, therefore I wouldn't do it here.


>> +	process->out = -1;
>> +
>> +	if (start_command(process)) {
>> +		error("cannot fork to run external persistent filter '%s'", cmd);
> 
> Just a question: is "cannot fork" the only reason why start_command()
> might have failed there?
> 
> Edit: Ah, I see that you follow filter_buffer_or_fd() example from
> convert.c, again.

Correct.


>> +		stop_protocol_filter(hashmap, entry);
>> +		return NULL;
>> +	}
>> +
>> +	sigchain_push(SIGPIPE, SIG_IGN);
>> +	ret &= strcmp(packet_read_line(process->out, NULL), "git-filter-protocol") == 0;
>> +	ret &= strcmp(packet_read_line(process->out, NULL), "version 2") == 0;
> 
> So that's why you need packet_read_line() to return string...
> 
>> +	capabilities_buffer = packet_read_line(process->out, NULL);
>> +	sigchain_pop(SIGPIPE);
>> +
>> +	string_list_split_in_place(&capabilities, capabilities_buffer, ' ', -1);
> 
> This does not modify capabilities_buffer, does it?

Maybe, but this wouldn't matter as we don't use this buffer afterwards.


>> +	for (i = 0; i < capabilities.nr; i++) {
>> +		const char *requested = capabilities.items[i].string;
>> +		if (!strcmp(requested, "clean")) {
>> +			entry->clean = 1;
>> +		} else if (!strcmp(requested, "smudge")) {
>> +			entry->smudge = 1;
>> +		} else {
>> +			warning(
>> +				"filter process '%s' requested unsupported filter capability '%s'",
>> +				cmd, requested
>> +			);
> 
> Nice.  This makes it (somewhat) forward- and backward-compatibile.

Thanks :)


>> +		}
>> +	}
>> +	string_list_clear(&capabilities, 0);
>> +
>> +	if (!ret) {
>> +		error("initialization for external persistent filter '%s' failed", cmd);
> 
> Do we need more detailed information about the source of error?

Not sure. The beauty of pkt-line is that someone can just set GIT_TRACE_PACKET=1 to
see what is going on. I feel that this is enough and we don't need to have fine grained
error reporting...


>> +		stop_protocol_filter(hashmap, entry);
>> +		return NULL;
>> +	}
>> +
>> +	hashmap_add(hashmap, entry);
>> +	return entry;
>> +}
>> +
>> +static int cmd_process_map_init = 0;
>> +static struct hashmap cmd_process_map;
>> +
>> +static int apply_protocol_filter(const char *path, const char *src, size_t len,
>> +						int fd, struct strbuf *dst, const char *cmd,
>> +						const char *filter_type)
> 
> That is... quite a lot of parameters.  But I guess there is precedens.

Agreed. But this mimics the original apply_protocol() interface and therefore 
I would like to keep it.


> But I think 'fd' belongs to previous line, as it is alternative to
> src+len.

You could also argue that fd is an alternative to src+len and belongs on a 
new line :-) In any way... if I would move fd up then we would exceed 80 chars...


>> +{
>> +	int ret = 1;
>> +	struct cmd2process *entry;
>> +	struct child_process *process;
>> +	struct stat file_stat;
>> +	struct strbuf nbuf = STRBUF_INIT;
>> +	off_t expected_bytes;
>> +	char *strtol_end;
>> +	char *strbuf;
>> +
>> +	if (!cmd || !*cmd)
>> +		return 0;
>> +
>> +	if (!dst)
>> +		return 1;
>> +
>> +	if (!cmd_process_map_init) {
>> +		cmd_process_map_init = 1;
>> +		hashmap_init(&cmd_process_map, (hashmap_cmp_fn) cmd2process_cmp, 0);
>> +		entry = NULL;
> 
> Is it better than having entry NULL-initialized?

I did this based on my understanding of Eric's feedback:

"Compilers complain about uninitialized variables.  Blindly
setting them to NULL can allow them to be dereferenced;
triggering segfaults; especially if it's passed to a different
compilation unit the compiler can't see."

See: http://public-inbox.org/git/20160725072745.GB11634%40starla/


>> +	} else {
>> +		entry = find_protocol_filter_entry(&cmd_process_map, cmd);
>> +	}
>> +
>> +	if (!entry) {
>> +		entry = start_protocol_filter(&cmd_process_map, cmd);
> 
> Hmmm... apply_filter() uses start_async() for some reason.  Why
> it does not apply for this new kind of filter?

Implementing the protocol in an async manner would be way harder
and is only necessary if you want to support true streaming (that
is reading and writing at the same time). This might be desired but
is out of scope for this patch series.


>> +		if (!entry) {
>> +			return 0;
>> +		}
>> +	}
>> +	process = &entry->process;
>> +
>> +	if (!(!strcmp(filter_type, "clean") && entry->clean) &&
>> +		!(!strcmp(filter_type, "smudge") && entry->smudge)) {
> 
> Would it be more readable as !(A || B) rather than (!A && !B)?

I solved it with a bitmask - no DeMorgan anymore :)


>> +		return 0;
>> +	}
>> +
>> +	if (fd >= 0 && !src) {
>> +		ret &= fstat(fd, &file_stat) != -1;
>> +		len = file_stat.st_size;
>> +	}
> 
> All right, so we either use src+len,  or if we use fd we get
> file size.

Right.


>> +
>> +	sigchain_push(SIGPIPE, SIG_IGN);
>> +
>> +	packet_write(process->in, "%s\n", filter_type);
>> +	packet_write(process->in, "%s\n", path);
>> +	packet_write(process->in, "%zu\n", len);
> 
> So "\n" is included in protocol?

Yes. Pkt-line states "A non-binary line SHOULD BE terminated by an LF"
(see Documentation/technical/protocol-common.txt)


>> +	ret &= multi_packet_write(src, len, fd, process->in);
> 
> How git-receive-pack etc. handle multi-packet write?

This is my solution that avoids an unnecessary buffer. As mentioned
above I move this code to its proper place in pkt-line.h/c.


>> +
>> +	strbuf = packet_read_line(process->out, NULL);
>> +	expected_bytes = (off_t)strtol(strbuf, &strtol_end, 10);
>> +	ret &= (strtol_end != strbuf && errno != ERANGE);
>> +
>> +	if (expected_bytes > 0) {
>> +		ret &= multi_packet_read(&nbuf, process->out, expected_bytes) == expected_bytes;
>> +	}
>> +
>> +	sigchain_pop(SIGPIPE);
>> +
>> +	if (ret) {
>> +		strbuf_swap(dst, &nbuf);
>> +	} else {
>> +		// Something went wrong with the protocol filter. Force shutdown!
>> +		stop_protocol_filter(&cmd_process_map, entry);
> 
> Some error message would be nice... or do we print in down in stack?

OK, I will add an error(...).


>> +	}
>> +	strbuf_release(&nbuf);
>> +	return ret;
>> +}
>> +
> 
> 
> [...]
>> @@ -823,7 +1049,10 @@ int would_convert_to_git_filter_fd(const char *path)
>> 	if (!ca.drv->required)
>> 		return 0;
>> 
>> -	return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
>> +	if (!ca.drv->clean && ca.drv->process)
>> +		return apply_protocol_filter(path, NULL, 0, -1, NULL, ca.drv->process, "clean");
>> +	else
>> +		return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
> 
> So the rule is: if `clean` is not set, and `process` is, try to use
> process for cleaning.  It was not clear for me from the documentation.

True. I will add that to the docs.


>> }
>> 
>> const char *get_convert_attr_ascii(const char *path)
>> @@ -856,17 +1085,22 @@ int convert_to_git(const char *path, const char *src, size_t len,
>>                    struct strbuf *dst, enum safe_crlf checksafe)
>> {
>> 	int ret = 0;
>> -	const char *filter = NULL;
>> +	const char *clean_filter = NULL;
>> +	const char *process_filter = NULL;
>> 	int required = 0;
>> 	struct conv_attrs ca;
>> 
>> 	convert_attrs(&ca, path);
>> 	if (ca.drv) {
>> -		filter = ca.drv->clean;
>> +		clean_filter = ca.drv->clean;
>> +		process_filter = ca.drv->process;
>> 		required = ca.drv->required;
>> 	}
>> 
>> -	ret |= apply_filter(path, src, len, -1, dst, filter);
>> +	if (!clean_filter && process_filter)
>> +		ret |= apply_protocol_filter(path, src, len, -1, dst, process_filter, "clean");
>> +	else
>> +		ret |= apply_filter(path, src, len, -1, dst, clean_filter);
> 
> And the rule is the same here, as it should.
> 
>> 	if (!ret && required)
>> 		die("%s: clean filter '%s' failed", path, ca.drv->name);
> 
> Is it a correct error message for `process`?  I guess it is, as it prints
> the name of driver, and not attempted command.  Well, we might be using
> "process" filter in 'clean' mode,... but that is sophistry.

I see where you are coming from. However, it tries to run the "clean" filter 
with the process and therefore I think the message is correct.


> [...]
>> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
>> index b9911a4..c4793ed 100755
>> --- a/t/t0021-conversion.sh
>> +++ b/t/t0021-conversion.sh
>> @@ -4,6 +4,11 @@ test_description='blob conversion via gitattributes'
>> 
>> . ./test-lib.sh
>> 
>> +if ! test_have_prereq PERL; then
>> +	skip_all='skipping perl interface tests, perl not available'
>> +	test_done
>> +fi
> 
> Do all tests require Perl?

No. I will add the PERL requirement explicitly to the tests that need it.


>> +test_expect_success 'required protocol filter should filter data' '
> [...]
>> +test_expect_success 'protocol filter large file' '
> [...]
>> +test_expect_success 'required protocol filter should fail with clean' '
> [...]
>> +test_expect_success 'protocol filter should restart after failure' '
> [...]
> 
>> diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
>> new file mode 100755
>> index 0000000..7176836
>> --- /dev/null
>> +++ b/t/t0021/rot13-filter.pl
>> @@ -0,0 +1,146 @@
>> +#!/usr/bin/perl
>> +#
>> +# Example implementation for the Git filter protocol version 2
>> +# See Documentation/gitattributes.txt, section "Filter Protocol"
>> +#
>> +# This implementation supports two special test cases:
>> +# (1) If data with the filename "clean-write-fail.r" is processed with
>> +#     a "clean" operation then the write operation will die.
>> +# (2) If data with the filename "smudge-write-fail.r" is processed with
>> +#     a "smudge" operation then the write operation will die.
> 
> Nice.
> 
>> +#
>> +
>> +use strict;
>> +use warnings;
>> +
>> +my $MAX_PACKET_CONTENT_SIZE = 65516;
>> +
>> +sub rot13 {
>> +    my ($str) = @_;
>> +    $str =~ y/A-Za-z/N-ZA-Mn-za-m/;
>> +    return $str;
>> +}
>> +
>> +sub packet_read {
>> +    my $buffer;
>> +    my $bytes_read = read STDIN, $buffer, 4;
>> +    if ( $bytes_read == 0 ) {
>> +        return;
>> +    }
>> +    elsif ( $bytes_read != 4 ) {
> 
> This is a bit untypical bracket style...

With bracket style you mean the spaces? I used PerlTidy in 
standard mode. I will adjust it to look more like perl/Git.pm ...

http://perltidy.sourceforge.net/

> 
>> +        die "invalid packet size '$bytes_read' field";
>> +    }
>> +    my $pkt_size = hex($buffer);
>> +    if ( $pkt_size == 0 ) {
>> +        return ( 1, "" );
>> +    }
>> +    elsif ( $pkt_size > 4 ) {
>> +        my $content_size = $pkt_size - 4;
>> +        $bytes_read = read STDIN, $buffer, $content_size;
>> +        if ( $bytes_read != $content_size ) {
>> +            die "invalid packet";
>> +        }
>> +        return ( 0, $buffer );
>> +    }
>> +    else {
>> +        die "invalid packet size";
>> +    }
>> +}
> 
> So packet reading is not that difficult...
> 
>> +
>> +sub packet_write {
>> +    my ($packet) = @_;
>> +    print STDOUT sprintf( "%04x", length($packet) + 4 );
>> +    print STDOUT $packet;
>> +    STDOUT->flush();
>> +}
> 
> ...and packet write is easy.
> 
>> +
>> +sub packet_flush {
>> +    print STDOUT sprintf( "%04x", 0 );
>> +    STDOUT->flush();
>> +}
>> +
>> +open my $debug, ">>", "output.log";
>> +print $debug "start\n";
>> +$debug->flush();
>> +
>> +packet_write("git-filter-protocol\n");
>> +packet_write("version 2\n");
>> +packet_write("clean smudge\n");
>> +print $debug "wrote filter header\n";
>> +$debug->flush();
> 
> Isn't $debug flushed automatically?

Maybe, but autoflush is not explicitly enabled. I will
enable it again (I disabled it because of Eric's comment
but I re-read the comment and he is only talking about
pipes).

http://public-inbox.org/git/20160723072721.GA20875%40starla/


>> +
>> +while (1) {
>> +    my $command = packet_read();
>> +    unless ( defined($command) ) {
>> +        exit();
>> +    }
>> +    chomp $command;
>> +    print $debug "IN: $command";
>> +    $debug->flush();
>> +    my $filename = packet_read();
>> +    chomp $filename;
>> +    print $debug " $filename";
>> +    $debug->flush();
>> +    my $filelen = packet_read();
>> +    chomp $filelen;
>> +    print $debug " $filelen";
>> +    $debug->flush();
>> +
>> +    $filelen =~ /\A\d+\z/ or die "bad filelen: $filelen";
>> +    my $output;
>> +
>> +    if ( $filelen > 0 ) {
>> +        my $input = "";
>> +        {
>> +            binmode(STDIN);
>> +            my $buffer;
>> +            my $done = 0;
>> +            while ( !$done ) {
>> +                ( $done, $buffer ) = packet_read();
>> +                $input .= $buffer;
>> +            }
>> +            print $debug " [OK] -- ";
>> +            $debug->flush();
>> +        }
>> +
>> +        if ( $command eq "clean" ) {
>> +            $output = rot13($input);
>> +        }
>> +        elsif ( $command eq "smudge" ) {
>> +            $output = rot13($input);
>> +        }
>> +        else {
>> +            die "bad command";
> 
> Perhaps
> 
>               die "bad command $command";

Agreed.


>> +        }
>> +    }
>> +
>> +    my $output_len = length($output);
>> +    packet_write("$output_len\n");
>> +    print $debug "OUT: $output_len ";
>> +    $debug->flush();
>> +    if ( $output_len > 0 ) {
>> +        if (   ( $command eq "clean" and $filename eq "clean-write-fail.r" )
> 
> What happened here with whitespace around parentheses?

Perl tidy :-)
Will fix!

Thanks a lot for this extensive review, again!

Best,
Lars