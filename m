Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB0A820986
	for <e@80x24.org>; Tue, 27 Sep 2016 15:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933709AbcI0PiD (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 11:38:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36350 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932947AbcI0PiB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 11:38:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id b184so1762923wma.3
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 08:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=A1VlsqognKmf2GtVBwT1/f5BlkicMl/x10MAkv6SE9o=;
        b=A9xqTK/xOHKMEWn4XqMX8vWXEvLpqtK1jkNaKu4b/4ybbNHyiFfbHcymnmkiz/oeh4
         kg2aOBtmvzZhLSHIOxNV2DtlgsOatx+3twsXck9MZLYgrj78TAycfVmU2zuj4GqCSegb
         x4IdjdKwdxx0YRoS4ATb/Gi1bGSPArafm2sfu26nTfzn3cDQirg+AVBmM22PI7ycPjnW
         60V/CdhdQVH5LPCzfpqXR2TkjtRepnPsSOdL8RbykT6YLWdG8mVPHY+XbQIdLYNaepm9
         0uUiK5xJgR/ejnJC/7gLp9F/NSd9/1cRvUzmtcFjVxbH3wiRkH0Rdn4+hA2R7tGgkC7V
         7oJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=A1VlsqognKmf2GtVBwT1/f5BlkicMl/x10MAkv6SE9o=;
        b=DT3F/YFaeJTBCoak10XQf+x+0/IKCUVV5HtzA5cDUVXe6O8kB7XK1ITlt+CZUehcTL
         vBTC2Vm5DnqIX37sNm1HhjyFQKth7bwHkpGefhI2+M2wC+IKsmY8DFlL2Ohwno5CkDNq
         omfdt+rKM5Q2vfb7Yt1fnfbv1igQyHJ4t5rAUFVDNtgIe99bp8zzIofqWYVSBA4BwwYV
         MiV2CBMfB2uVyXX068X5WBb3nnPlSBuwOk5kQKDXXRBYmpFVoMQWPv+r2BX13IZqsRC4
         1/XZIdTW8hm7xCoPJGDKyZgwoePsEOzSp+d2mgNrMi7/R97qnMKRWhcCcY3QRExHzqgL
         boOQ==
X-Gm-Message-State: AA6/9RkBdXZHveWG5uWM4Hh5ZSKbVWR16i0vLTPBYmi9GkKfRKJTAE+LTujSnd3KB7WM1g==
X-Received: by 10.28.211.10 with SMTP id k10mr3758246wmg.16.1474990679466;
        Tue, 27 Sep 2016 08:37:59 -0700 (PDT)
Received: from [192.168.1.26] (dbw202.neoplus.adsl.tpnet.pl. [83.23.48.202])
        by smtp.googlemail.com with ESMTPSA id 193sm3731146wmo.14.2016.09.27.08.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2016 08:37:58 -0700 (PDT)
Subject: Re: [PATCH v8 11/11] convert: add filter.<driver>.process option
To:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <20160920190247.82189-12-larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <2a604438-b6cd-876d-0ec2-90027dea99b9@gmail.com>
Date:   Tue, 27 Sep 2016 17:37:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160920190247.82189-12-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Part second of the review of 11/11.

W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com pisze:

> diff --git a/contrib/long-running-filter/example.pl b/contrib/long-running-filter/example.pl
> new file mode 100755
> index 0000000..c13a631
> --- /dev/null
> +++ b/contrib/long-running-filter/example.pl
[...]
> +( packet_txt_read() eq ( 0, "git-filter-client" ) ) || die "bad initialize";
> +( packet_txt_read() eq ( 0, "version=2" ) )         || die "bad version";
> +( packet_bin_read() eq ( 1, "" ) )                  || die "bad version end";

What I would like to see here is some kind of packet_read_list()
or packet_txt_read_list() that reads until flush packet or EOF,
and returns list of chomp-ed lines (without LF terminator).

Then you can examine those lines:

   my @lines = packet_read_list();
   $lines[0] eq "git-filter-client"      or die "bad initialization: '$lines[0]'";
   grep { $_ eq "version=2" } @lines     or die "bad version: version=2 not found";

Note: I have not checked that I got operator precedence right.

> +
> +packet_txt_write("git-filter-server");
> +packet_txt_write("version=2");

Here using packet_write_list() would help us to not forget to
send the flush packet:

  packet_write_list(
  	"git-filter-server",
  	"version=2"
  );

[...]
> diff --git a/convert.c b/convert.c
> index 597f561..bd66257 100644
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
> @@ -442,7 +443,7 @@ static int filter_buffer_or_fd(int in, int out, void *data)
>  	return (write_err || status);
>  }
>  
> -static int apply_filter(const char *path, const char *src, size_t len, int fd,
> +static int apply_single_file_filter(const char *path, const char *src, size_t len, int fd,
>                          struct strbuf *dst, const char *cmd)
>  {
>  	/*
> @@ -456,12 +457,6 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
>  	struct async async;
>  	struct filter_params params;
>  
> -	if (!cmd || !*cmd)
> -		return 0;
> -
> -	if (!dst)
> -		return 1;
> -
>  	memset(&async, 0, sizeof(async));
>  	async.proc = filter_buffer_or_fd;
>  	async.data = &params;

I have reordered a few chunks of this patch to make it easier to
see what happens here, and to review this part of patch.

[moved here from further in the patch]
> +static int apply_filter(const char *path, const char *src, size_t len,
> +                        int fd, struct strbuf *dst, struct convert_driver *drv,
> +                        const unsigned int wanted_capability)
> +{
> +	const char *cmd = NULL;
> +
> +	if (!drv)
> +		return 0;
> +
> +	if (!dst)
> +		return 1;

To reduce the size of this patch (which is not yet of the size that
would make vger reject the email :-/), perhaps this split into 
apply_single_file_filter() and apply_filter(), without yet adding
apply_multi_file_filter(). The apply_filter() would be semi-simple
wrapper, with the same signature as above.

> +
> +	if (!drv->process && (CAP_CLEAN & wanted_capability) && drv->clean)

This is just a very minor nitpicking, but wouldn't it be easier
to read with those checks reordered?

  +	if ((wanted_capability & CAP_CLEAN) && !drv->process && drv->clean)

That is: if we want `clean` capability, and `process` is not set,
and there is `clean` filter.

Though the following would also work...

  +	if ((wanted_capability & CAP_CLEAN) && !drv->process)

> +		cmd = drv->clean;
> +	else if (!drv->process && (CAP_SMUDGE & wanted_capability) && drv->smudge)
> +		cmd = drv->smudge;
> +
> +	if (cmd && *cmd)

... thanks to this check (the 'cmd' part, which we need to check anyway).

'cmd = drv->clean', then 'if (cmd)' is the same as 'if (drv->clean)',
then 'cmd = drv->clean', then 'if (cmd)', isn't it.

Not sure if it would be more readable, or less readable.

CAP_CLEAN and CAP_SMUDGE are, in theory, mutually exclusive.  Note that
the above order prefers `smudge` to `clean` if both given, while in other
places we prefer `clean` to `smudge` if both given.


> +		return apply_single_file_filter(path, src, len, fd, dst, cmd);
> +	else if (drv->process && *drv->process)
> +		return apply_multi_file_filter(path, src, len, fd, dst, drv->process, wanted_capability);
> +
> +	return 0;
> +}

Nice and clean wrapper.

> +

[moved here from further in the patch]
> @@ -839,7 +1140,7 @@ int would_convert_to_git_filter_fd(const char *path)
>  	if (!ca.drv->required)
>  		return 0;
>  
> -	return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
> +	return apply_filter(path, NULL, 0, -1, NULL, ca.drv, CAP_CLEAN);
>  }
>  
>  const char *get_convert_attr_ascii(const char *path)

This would also be a part of move adding apply_single_file_filter()
and converting apply_filter() to wrapper around single / multi file
filters.

> @@ -493,14 +488,317 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
>  	return !err;
>  }
>  
> +#define CAP_CLEAN    (1u<<0)
> +#define CAP_SMUDGE   (1u<<1)

It's a pity that ANSI C does not include binary constants, like e.g.
modern Perl, that is '0b0001u' and '0b0010u'; we could use hexadecimal
constants '0x01u' and '0x02u', but perhaps the above is more readable,
and as performant.

> +
> +struct cmd2process {
> +	struct hashmap_entry ent; /* must be the first member! */
> +	unsigned int supported_capabilities;
> +	const char *cmd;
> +	struct child_process process;
> +};
> +
> +static int cmd_process_map_initialized;
> +static struct hashmap cmd_process_map;
> +
> +static int cmd2process_cmp(const struct cmd2process *e1,
> +                           const struct cmd2process *e2,
> +                           const void *unused)
> +{
> +	return strcmp(e1->cmd, e2->cmd);
> +}
> +
> +static struct cmd2process *find_multi_file_filter_entry(struct hashmap *hashmap, const char *cmd)
> +{
> +	struct cmd2process key;
> +	hashmap_entry_init(&key, strhash(cmd));
> +	key.cmd = cmd;
> +	return hashmap_get(hashmap, &key, NULL);
> +}


All right, basic hashmap for the list of command processes, here
so that we can find correct driver for current file, and reuse it
if it was started already.

I see that git code does not use /* ............ */ etc to separate
subsections / subparts of a file, so I won't ask for it ;-(

> +
> +static void kill_multi_file_filter(struct hashmap *hashmap, struct cmd2process *entry)
> +{
> +	if (!entry)
> +		return;
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +	/*
> +	 * We kill the filter most likely because an error happened already.
> +	 * That's why we are not interested in any error code here.
> +	 */

Good explanation.

> +	close(entry->process.in);
> +	close(entry->process.out);
> +	sigchain_pop(SIGPIPE);
> +	finish_command(&entry->process);
> +	hashmap_remove(hashmap, entry, NULL);
> +	free(entry);
> +}

That's more 'kill_and_remove_...', but that would make too long
function name.

Small and readable.  Nice.

> +
> +static int packet_write_list(int fd, const char *line, ...)
> +{
> +	va_list args;
> +	int err;
> +	va_start(args, line);
> +	for (;;) {
> +		if (!line)
> +			break;
> +		if (strlen(line) > PKTLINE_DATA_MAXLEN)

Here we see that having PKTLINE_DATA_MAXLEN (or LARGE_PACKET_DATA_MAX)
constant is quite useful.

> +			return -1;
> +		err = packet_write_fmt_gently(fd, "%s\n", line);

I wonder if adding the fact that we are writing text packets
to function name would be worth it.  Nah.  Also, it is file-local
(static) function.

> +		if (err)
> +			return err;
> +		line = va_arg(args, const char*);
> +	}
> +	va_end(args);
> +	return packet_flush_gently(fd);
> +}

Nice abstraction.

> +
> +static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, const char *cmd)
> +{
> +	int err;
> +	struct cmd2process *entry;
> +	struct child_process *process;
> +	const char *argv[] = { cmd, NULL };
> +	struct string_list cap_list = STRING_LIST_INIT_NODUP;
> +	char *cap_buf;
> +	const char *cap_name;
> +
> +	entry = xmalloc(sizeof(*entry));
> +	hashmap_entry_init(entry, strhash(cmd));
> +	entry->cmd = cmd;
> +	entry->supported_capabilities = 0;
> +	process = &entry->process;
> +
> +	child_process_init(process);
> +	process->argv = argv;
> +	process->use_shell = 1;
> +	process->in = -1;
> +	process->out = -1;
> +
> +	if (start_command(process)) {
> +		error("cannot fork to run external filter '%s'", cmd);
> +		kill_multi_file_filter(hashmap, entry);
> +		return NULL;
> +	}

I guess there is a reason why we init hashmap entry, try to start
external process, then kill entry of unable to start, instead of
trying to start external process, and adding hashmap entry when
we succeed?

> +
> +	sigchain_push(SIGPIPE, SIG_IGN);

I guess that this is here to handle errors writing to filter
by ourself, isn't it?

> +
> +	err = packet_write_list(process->in, "git-filter-client", "version=2", NULL);
> +	if (err)
> +		goto done;

Ugh, error / exception handling in C.

> +
> +	err = strcmp(packet_read_line(process->out, NULL), "git-filter-server");
> +	if (err) {
> +		error("external filter '%s' does not support long running filter protocol", cmd);
> +		goto done;
> +	}
> +	err = strcmp(packet_read_line(process->out, NULL), "version=2");
> +	if (err)

We could have described the error here better.

  +		error("external filter '%s' does not support filter protocol version 2", cmd);

But this is probably not necessary; it should be rare to find
filter process that support the protocol halfway right.

> +		goto done;

I guess this would get more complicated if/when there is need
for new version of the protocol.

Shouldn't we read flush packet here?  Ah, sorry, we know that we
should get only two lines from the `process` filter driver, and
not variable number of lines, so there is no need to flush here.

Disregard my comments about lack of flush packet in the example
of long running filter script.  Well, unless the protocol itself
would get adjusted to always use flush packet to terminate set
of metadata lines, even if number of lines is fixed.

> +
> +	err = packet_write_list(process->in, "clean=true", "smudge=true", NULL);

So I see that Git sends all capabilities it supports, not only
those that given git command needs (which might be hard to find
out).

If it were possible at this point of code for Git to know, for
example, that it would only do `clean` operation, shouldn't it
write "clean=true", "smudge=false"? ;-PPP

Note that this "=true" is totally spurious.  Maybe "capability=clean",
or just "clean" would make a better protocol?

> +
> +	for (;;) {
> +		cap_buf = packet_read_line(process->out, NULL);
> +		if (!cap_buf)
> +			break;
> +		string_list_split_in_place(&cap_list, cap_buf, '=', 1);
> +
> +		if (cap_list.nr != 2 || strcmp(cap_list.items[1].string, "true"))
> +			continue;
> +
> +		cap_name = cap_list.items[0].string;
> +		if (!strcmp(cap_name, "clean")) {
> +			entry->supported_capabilities |= CAP_CLEAN;
> +		} else if (!strcmp(cap_name, "smudge")) {
> +			entry->supported_capabilities |= CAP_SMUDGE;
> +		} else {
> +			warning(
> +				"external filter '%s' requested unsupported filter capability '%s'",
> +				cmd, cap_name
> +			);
> +		}
> +
> +		string_list_clear(&cap_list, 0);
> +	}

I guess there is a reason why it was not extracted into helper
function?

Well, both because handling of variable-length response, where
multiple lines must be analyzed, happens only once, and also
because returning list of variable-length strings in C is hard
(alloca? string_list?).

> +
> +done:
> +	sigchain_pop(SIGPIPE);
> +
> +	if (err || errno == EPIPE) {
> +		error("initialization for external filter '%s' failed", cmd);
> +		kill_multi_file_filter(hashmap, entry);
> +		return NULL;
> +	}

Good.

> +
> +	hashmap_add(hashmap, entry);
> +	return entry;
> +}
> +
> +static void read_multi_file_filter_values(int fd, struct strbuf *status) {

This is more

  +static void read_multi_file_filter_status(int fd, struct strbuf *status) {

It doesn't read arbitrary values, it examines 'metadata' from
filter for "status=<foo>" lines.

> +	struct strbuf **pair;

Shouldn't it be initialized to NULL, like in strbuf_split_buf()
code?

> +	char *line;
> +	for (;;) {
> +		line = packet_read_line(fd, NULL);
> +		if (!line)
> +			break;
> +		pair = strbuf_split_str(line, '=', 2);

Why, oh why, there is no Documentation/technical/api-strbuf.txt?
Well, strbuf.h is really well commented... but perhaps not enough.

> +		if (pair[0] && pair[0]->len && pair[1]) {
> +			if (!strcmp(pair[0]->buf, "status=")) {
> +				strbuf_reset(status);
> +				strbuf_addbuf(status, pair[1]);
> +			}

So it is last status=<foo> line wins behavior?

> +		}

Shouldn't we free 'struct strbuf **pair', maybe allocated by the
strbuf_split_str() function, and reset to NULL?

> +	}
> +}
> +
> +static int apply_multi_file_filter(const char *path, const char *src, size_t len,
> +                                   int fd, struct strbuf *dst, const char *cmd,
> +                                   const unsigned int wanted_capability)
> +{
> +	int err;
> +	struct cmd2process *entry;
> +	struct child_process *process;
> +	struct stat file_stat;
> +	struct strbuf nbuf = STRBUF_INIT;

This name doesn't tell us much, but I guess there is precedence?

> +	struct strbuf filter_status = STRBUF_INIT;
> +	char *filter_type;
> +
> +	if (!cmd_process_map_initialized) {
> +		cmd_process_map_initialized = 1;
> +		hashmap_init(&cmd_process_map, (hashmap_cmp_fn) cmd2process_cmp, 0);
> +		entry = NULL;
> +	} else {
> +		entry = find_multi_file_filter_entry(&cmd_process_map, cmd);
> +	}
> +
> +	fflush(NULL);

Why this fflush(NULL) is needed here?

> +
> +	if (!entry) {
> +		entry = start_multi_file_filter(&cmd_process_map, cmd);
> +		if (!entry)
> +			return 0;
> +	}
> +	process = &entry->process;

All right, we start process filter, or get existing instance.

> +
> +	if (!(wanted_capability & entry->supported_capabilities))
> +		return 0;

If filter doesn't support wanted capability, then Git just
wouldn't filter.  Looks good to me.

> +
> +	if (CAP_CLEAN & wanted_capability)
> +		filter_type = "clean";
> +	else if (CAP_SMUDGE & wanted_capability)
> +		filter_type = "smudge";
> +	else
> +		die("unexpected filter type");

This should never happen; we should always request one of those
capabilities, and only one.

> +
> +	if (fd >= 0 && !src) {
> +		if (fstat(fd, &file_stat) == -1)
> +			return 0;
> +		len = xsize_t(file_stat.st_size);
> +	}

Errr... is it necessary?  The protocol no longer provides size=<n>
hint, and neither uses such hint if provided.

> +
> +	sigchain_push(SIGPIPE, SIG_IGN);

Right, we want to handle errors ourself.

> +
> +	err = strlen(filter_type) > PKTLINE_DATA_MAXLEN;
> +	if (err)
> +		goto done;

Errr... this should never happen.  We control which capabilities
we pass, it can be only "clean" or "smudge", nothing else. Those
would always be shorter than PKTLINE_DATA_MAXLEN.

Never mind that that is "command=smudge\n" etc. that needs to
be shorter that PKTLINE_DATA_MAXLEN!

So, IMHO it should be at most assert, and needs to be corrected
anyway.

> +
> +	err = packet_write_fmt_gently(process->in, "command=%s\n", filter_type);
> +	if (err)
> +		goto done;
> +
> +	err = strlen(path) > PKTLINE_DATA_MAXLEN;

Actually

  +	err = strlen(path) > PKTLINE_DATA_MAXLEN - strlen("pathname=\n");

This version was chosen in the very unlikely case if
strlen(path) + strlen("pathname=\n") would overflow.

  +	err = strlen("pathname=") + strlen(path) + strlen("\n") > PKTLINE_DATA_MAXLEN;

;-)

> +	if (err)
> +		goto done;

This should never happen, PATH_MAX everywhere is much shorter
than PKTLINE_DATA_MAXLEN / LARGE_PACKET_MAX.  Or is it?

Anyway, we should probably explain or warn

   		error("path name too long: '%s'", path);

Though if length of pathname is of the order of 2^16, I don't
think printing it would help :-)

> +
> +	err = packet_write_fmt_gently(process->in, "pathname=%s\n", path);
> +	if (err)
> +		goto done;
> +
> +	err = packet_flush_gently(process->in);
> +	if (err)
> +		goto done;

All right, this list of values, currently composed of "command=<sth>"
and "pathname=<sth>" - both of which are required, may be variable
length, so we need flush packet.

> +
> +	if (fd >= 0)
> +		err = write_packetized_from_fd(fd, process->in);
> +	else
> +		err = write_packetized_from_buf(src, len, process->in);
> +	if (err)
> +		goto done;

Looks good, and I think it is better if the caller decided rather
that write_packetized(fd, src, len, process->in) deciding.

Note for implementers: write in full, read in full, no streaming
support (Git doesn't start to read filter output until it writes
to filter in full).  This is opposed to what `clean` and `smudge`
filters support.

> +
> +	read_multi_file_filter_values(process->out, &filter_status);
> +	err = strcmp(filter_status.buf, "success");
> +	if (err)
> +		goto done;
> +
> +	err = read_packetized_to_buf(process->out, &nbuf) < 0;
> +	if (err)
> +		goto done;
> +
> +	read_multi_file_filter_values(process->out, &filter_status);
> +	err = strcmp(filter_status.buf, "success");

Looks good to me (LGTM).

> +
> +done:
> +	sigchain_pop(SIGPIPE);
> +
> +	if (err || errno == EPIPE) {
> +		if (!strcmp(filter_status.buf, "error")) {
> +			/* The filter signaled a problem with the file. */
> +		} else if (!strcmp(filter_status.buf, "abort")) {
> +			/*
> +			 * The filter signaled a permanent problem. Don't try to filter
> +			 * files with the same command for the lifetime of the current
> +			 * Git process.
> +			 */
> +			 entry->supported_capabilities &= ~wanted_capability;
> +		} else {
> +			/*
> +			 * Something went wrong with the protocol filter.
> +			 * Force shutdown and restart if another blob requires filtering!

Is this exclamation mark '!' here necessary?

> +			 */
> +			error("external filter '%s' failed", cmd);
> +			kill_multi_file_filter(&cmd_process_map, entry);
> +		}

Looks good.  Three error conditions: resumable error from filter,
failure of filter (kill, would restart if necessary), and abort.

> +	} else {
> +		strbuf_swap(dst, &nbuf);
> +	}
> +	strbuf_release(&nbuf);
> +	return !err;

I guess this is for `filter.<driver>.required` to handle correctly
filter error-ing out, or filter failing, while not aborting
if filter simply doesn't support `clean` or `smudge` capability.

> +}
> +
>  static struct convert_driver {
>  	const char *name;
>  	struct convert_driver *next;
>  	const char *smudge;
>  	const char *clean;
> +	const char *process;

LGTM.

>  	int required;
>  } *user_convert, **user_convert_tail;
>  

[a section of chunk moved up]

>  static int read_convert_config(const char *var, const char *value, void *cb)
>  {
>  	const char *key, *name;
> @@ -538,6 +836,9 @@ static int read_convert_config(const char *var, const char *value, void *cb)
>  	if (!strcmp("clean", key))
>  		return git_config_string(&drv->clean, var, value);
>  
> +	if (!strcmp("process", key))
> +		return git_config_string(&drv->process, var, value);
> +

LGTM.

>  	if (!strcmp("required", key)) {
>  		drv->required = git_config_bool(var, value);
>  		return 0;

[a chunk of diff moved up]

> @@ -872,18 +1173,12 @@ int convert_to_git(const char *path, const char *src, size_t len,
>                     struct strbuf *dst, enum safe_crlf checksafe)
>  {
>  	int ret = 0;
> -	const char *filter = NULL;

All right, this was (I think) moved into apply_filter()...

> -	int required = 0;

...but this looks like just a removal of a temporary variable,
which could have been done in a separate preparatory patch.

>  	struct conv_attrs ca;
>  
>  	convert_attrs(&ca, path);
> -	if (ca.drv) {
> -		filter = ca.drv->clean;
> -		required = ca.drv->required;
> -	}
>  
> -	ret |= apply_filter(path, src, len, -1, dst, filter);
> -	if (!ret && required)
> +	ret |= apply_filter(path, src, len, -1, dst, ca.drv, CAP_CLEAN);
> +	if (!ret && ca.drv && ca.drv->required)
>  		die("%s: clean filter '%s' failed", path, ca.drv->name);

Looks good.  (And could be a part of patch adding apply_filter()
as wrapper.)

>  
>  	if (ret && dst) {
> @@ -905,9 +1200,9 @@ void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
>  	convert_attrs(&ca, path);
>  
>  	assert(ca.drv);
> -	assert(ca.drv->clean);
> +	assert(ca.drv->clean || ca.drv->process);

Hmmm... asserts.  Well, they were here.

>  
> -	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv->clean))
> +	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN))
>  		die("%s: clean filter '%s' failed", path, ca.drv->name);
>  

Looks good.  (And could be a part of patch adding apply_filter()
as wrapper.)

>  	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
> @@ -919,15 +1214,9 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
>  					    int normalizing)
>  {
>  	int ret = 0, ret_filter = 0;
> -	const char *filter = NULL;
> -	int required = 0;
>  	struct conv_attrs ca;
>  
>  	convert_attrs(&ca, path);
> -	if (ca.drv) {
> -		filter = ca.drv->smudge;
> -		required = ca.drv->required;
> -	}

Well, this is the same change as a bit eaelier.

>  
>  	ret |= ident_to_worktree(path, src, len, dst, ca.ident);
>  	if (ret) {
> @@ -936,9 +1225,10 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
>  	}
>  	/*
>  	 * CRLF conversion can be skipped if normalizing, unless there
> -	 * is a smudge filter.  The filter might expect CRLFs.
> +	 * is a smudge or process filter (even if the process filter doesn't
> +	 * support smudge).  The filters might expect CRLFs.
>  	 */
> -	if (filter || !normalizing) {
> +	if ((ca.drv && (ca.drv->smudge || ca.drv->process)) || !normalizing) {
>  		ret |= crlf_to_worktree(path, src, len, dst, ca.crlf_action);
>  		if (ret) {
>  			src = dst->buf;
> @@ -946,8 +1236,8 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
>  		}
>  	}
>  
> -	ret_filter = apply_filter(path, src, len, -1, dst, filter);
> -	if (!ret_filter && required)
> +	ret_filter = apply_filter(path, src, len, -1, dst, ca.drv, CAP_SMUDGE);
> +	if (!ret_filter && ca.drv && ca.drv->required)
>  		die("%s: smudge filter %s failed", path, ca.drv->name);
>  
>  	return ret | ret_filter;

Looks good to me.  I understand ca.drv is checked so that ca.drv->required
and/or ca.drv->smudge / ca.drv->clean / ca.drv->process can be safely
checked, isn't it.

> @@ -1399,7 +1689,7 @@ struct stream_filter *get_stream_filter(const char *path, const unsigned char *s
>  	struct stream_filter *filter = NULL;
>  
>  	convert_attrs(&ca, path);
> -	if (ca.drv && (ca.drv->smudge || ca.drv->clean))
> +	if (ca.drv && (ca.drv->process || ca.drv->smudge || ca.drv->clean))

LGTM, understandable change.

>  		return NULL;
>  
>  	if (ca.crlf_action == CRLF_AUTO || ca.crlf_action == CRLF_AUTO_CRLF)
> diff --git a/pkt-line.h b/pkt-line.h
> index 6df8449..3d873f3 100644
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -86,6 +86,7 @@ ssize_t read_packetized_to_buf(int fd_in, struct strbuf *sb_out);
>  
>  #define DEFAULT_PACKET_MAX 1000
>  #define LARGE_PACKET_MAX 65520
> +#define PKTLINE_DATA_MAXLEN (LARGE_PACKET_MAX - 4)

What the... didn't you use PKTLINE_DATA_MAXLEN in one of
earlier patches in this series?  How this even...?

>  extern char packet_buffer[LARGE_PACKET_MAX];
>  
>  #endif
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index dc50938..210c4f6 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh

I'll stop here, and I'll finish the review later.

To be continued,
-- 
Jakub Narębski

