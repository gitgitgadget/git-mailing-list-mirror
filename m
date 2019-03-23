Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0590320248
	for <e@80x24.org>; Sat, 23 Mar 2019 20:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfCWUoo (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Mar 2019 16:44:44 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45484 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfCWUoo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Mar 2019 16:44:44 -0400
Received: by mail-ed1-f66.google.com with SMTP id m16so4413883edd.12
        for <git@vger.kernel.org>; Sat, 23 Mar 2019 13:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=uao90tj6EuB+kfLT9hfiB5RZntZzpxxPFaEBfINlwdk=;
        b=dPWqcAVvsKB7lNOsfIAUlsweOyCPYAyMkI5x5SdwRTv3UzialRsDHaPcXB4fvsER+Q
         04T794DOojifGpqpupapF7x2Bp8+5kjXYzmcl2YoO3btdCUgyCqAR/Hej005xAxIj0pF
         /qVb1GQTTOdmQnNWPeYNx8+2TyUxorvK0BDd114cYmO9/oh4OJ/Vshnz12MORVaKQuz2
         aBr79gSI6QgQAyIxBazTMVroVtlXF1qeirOiMN8mz4wW7FKT2yIS7qHgTCz/tkegNDn7
         Sn9msB7isj6g+BcXgzkVYB4arnCmfXU2XgoGHta7s2eX8M1rej384wTpXCaq8tePtKKp
         KZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=uao90tj6EuB+kfLT9hfiB5RZntZzpxxPFaEBfINlwdk=;
        b=q+qlPh9kGOf0o/xrIDdSJdZQi+V9TdN2fS2FZH2zdVltOPjm5BFZu0qC5RIo3yMH/H
         2ShtCm2cpqHOL+ekISS6JHNtTwGFMkLngQ8AzgU4q+NANVwkJAz4iv/Gl6V2AW4olwkR
         8Si7tRYzI9wNLpiOwqtjDOU4g5VEDm+aBprWHlGEvW5aSieBIztQ8PurszYfq7Ojloqk
         m7LUHhZJ5t+spE6CwPOAhzrwlQKEluw92dE4QIm23oKIyWhwuZvgqEgECEr3gROpE+3z
         QW2YbKDH6roPx5K6WshZfn+Ew74RH1iyOY/WECEihngWhqXyaCN8kRXGFgpDYgdzurg8
         8G5A==
X-Gm-Message-State: APjAAAU1tjJ00dslpMPE+8IiWFE0mHZdp+qZtHh6Tfogfl9rlg1kpAiU
        KHCy+3q6vknrLH7JR2rh3pk=
X-Google-Smtp-Source: APXvYqzl54ZQy2Ze/dY9x43PVAs2dyZ8W/g4S15+6suWRShkimv3zrXFWKesbnYClhdXhZriYyQ60g==
X-Received: by 2002:a17:906:950f:: with SMTP id u15mr9263677ejx.118.1553373881846;
        Sat, 23 Mar 2019 13:44:41 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id k13sm3823928edl.59.2019.03.23.13.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Mar 2019 13:44:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com
Subject: Re: [PATCH v3 1/1] trace2: write to directory targets
References: <cover.1552519463.git.steadmon@google.com> <cover.1553202340.git.steadmon@google.com> <ce5258610ffbc2e498ff33336c5c89b69468d4fd.1553202340.git.steadmon@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <ce5258610ffbc2e498ff33336c5c89b69468d4fd.1553202340.git.steadmon@google.com>
Date:   Sat, 23 Mar 2019 21:44:39 +0100
Message-ID: <87bm21coco.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 21 2019, Josh Steadmon wrote:

> When the value of a trace2 environment variable is an absolute path
> referring to an existing directory, write output to files (one per
> process) underneath the given directory. Files will be named according
> to the final component of the trace2 SID, followed by a counter to avoid
> potential collisions.

Is this "counter to avoid collisions" something you've seen the need to
have in practice, or could we just squash this on top:

    diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
    index c3d82ca6a4..06cbef5837 100644
    --- a/trace2/tr2_dst.c
    +++ b/trace2/tr2_dst.c
    @@ -13,11 +13,6 @@
      */
     #define TR2_ENVVAR_DST_DEBUG "GIT_TR2_DST_DEBUG"

    -/*
    - * How many attempts we will make at creating an automatically-named trace file.
    - */
    -#define MAX_AUTO_ATTEMPTS 10
    -
     static int tr2_dst_want_warning(void)
     {
     	static int tr2env_dst_debug = -1;
    @@ -48,7 +43,6 @@ static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
     	const char *last_slash, *sid = tr2_sid_get();
     	struct strbuf path = STRBUF_INIT;
     	size_t base_path_len;
    -	unsigned attempt_count;

     	last_slash = strrchr(sid, '/');
     	if (last_slash)
    @@ -60,17 +54,7 @@ static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
     	strbuf_addstr(&path, sid);
     	base_path_len = path.len;

    -	for (attempt_count = 0; attempt_count < MAX_AUTO_ATTEMPTS; attempt_count++) {
    -		if (attempt_count > 0) {
    -			strbuf_setlen(&path, base_path_len);
    -			strbuf_addf(&path, ".%d", attempt_count);
    -		}
    -
    -		fd = open(path.buf, O_WRONLY | O_CREAT | O_EXCL, 0666);
    -		if (fd != -1)
    -			break;
    -	}
    -
    +	fd = open(path.buf, O_WRONLY | O_CREAT | O_EXCL, 0666);
     	if (fd == -1) {
     		if (tr2_dst_want_warning())
     			warning("trace2: could not open '%.*s' for '%s' tracing: %s",

The reason I'm raising this is that it seems like sweeping an existing
issue under the rug. We document that the "sid" is "unique", and it's just:

    <nanotime / 1000 (i.e. *nix time in microseconds)>-<pid>

So that might be a lie, and in particular I can imagine that say if
every machine at Google is logging traces into some magic mounted FS
that there'll be collisions there.

But then let's *fix that*, because we're also e.g. going to have other
consumers of these traces using the sid's as primary keys in a logging
system.

I wonder if we should just make it a bit longer, human-readable, and
include a hash of the hostname:

    perl -MTime::HiRes=gettimeofday -MSys::Hostname -MDigest::SHA=sha1_hex -MPOSIX=strftime -wE '
        my ($t, $m) = gettimeofday;
        my $host_hex = substr sha1_hex(hostname()), 0, 8;
        my $htime = strftime("%Y%m%d%H%M%S", localtime);
        my $sid = sprintf("%s-%6d-%s-%s",
            $htime,
            $m,
            $host_hex,
            $$ & 0xFFFF,
        );
        say $sid;
    '

Which gets you a SID like:

    20190323213918-404788-c2f5b994-19027

I.e.:

    <YYYYMMDDHHMMSS>-<microsecond-offset>-<8 chars of sha1(hostname -f)>-<pid>

There's obviously ways to make that more compact, but in this case I
couldn't see a reason to, also using UTC would be a good idea.

All the trace2 tests pass if I fake that up. Jeff H: Do you have
anything that relies on the current format?

> This makes it more convenient to collect traces for every git invocation
> by unconditionally setting the relevant trace2 envvar to a constant
> directory name.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  Documentation/technical/api-trace2.txt |  5 ++
>  t/t0210-trace2-normal.sh               | 15 ++++++
>  trace2/tr2_dst.c                       | 63 +++++++++++++++++++++++++-
>  3 files changed, 81 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
> index 2de565fa3d..d0948ba250 100644
> --- a/Documentation/technical/api-trace2.txt
> +++ b/Documentation/technical/api-trace2.txt
> @@ -109,6 +109,11 @@ values are recognized.
>
>  	Enables the target, opens and writes to the file in append mode.
>
> +	If the target already exists and is a directory, the traces will be
> +	written to files (one per process) underneath the given directory. They
> +	will be named according to the last component of the SID (optionally
> +	followed by a counter to avoid filename collisions).
> +
>  `af_unix:[<socket_type>:]<absolute-pathname>`::
>
>  	Enables the target, opens and writes to a Unix Domain Socket
> diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
> index 03a0aedb1d..819430658b 100755
> --- a/t/t0210-trace2-normal.sh
> +++ b/t/t0210-trace2-normal.sh
> @@ -80,6 +80,21 @@ test_expect_success 'normal stream, return code 1' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'automatic filename' '
> +	test_when_finished "rm -r traces actual expect" &&
> +	mkdir traces &&
> +	GIT_TR2="$(pwd)/traces" test-tool trace2 001return 0 &&
> +	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <"$(ls traces/*)" >actual &&
> +	cat >expect <<-EOF &&
> +		version $V
> +		start _EXE_ trace2 001return 0
> +		cmd_name trace2 (trace2)
> +		exit elapsed:_TIME_ code:0
> +		atexit elapsed:_TIME_ code:0
> +	EOF
> +	test_cmp expect actual
> +'
> +
>  # Verb 002exit
>  #
>  # Explicit exit(code) from within cmd_<verb> propagates <code>.
> diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
> index fd490a43ad..c3d82ca6a4 100644
> --- a/trace2/tr2_dst.c
> +++ b/trace2/tr2_dst.c
> @@ -1,5 +1,6 @@
>  #include "cache.h"
>  #include "trace2/tr2_dst.h"
> +#include "trace2/tr2_sid.h"
>
>  /*
>   * If a Trace2 target cannot be opened for writing, we should issue a
> @@ -12,6 +13,11 @@
>   */
>  #define TR2_ENVVAR_DST_DEBUG "GIT_TR2_DST_DEBUG"
>
> +/*
> + * How many attempts we will make at creating an automatically-named trace file.
> + */
> +#define MAX_AUTO_ATTEMPTS 10
> +
>  static int tr2_dst_want_warning(void)
>  {
>  	static int tr2env_dst_debug = -1;
> @@ -36,6 +42,55 @@ void tr2_dst_trace_disable(struct tr2_dst *dst)
>  	dst->need_close = 0;
>  }
>
> +static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
> +{
> +	int fd;
> +	const char *last_slash, *sid = tr2_sid_get();
> +	struct strbuf path = STRBUF_INIT;
> +	size_t base_path_len;
> +	unsigned attempt_count;
> +
> +	last_slash = strrchr(sid, '/');
> +	if (last_slash)
> +		sid = last_slash + 1;
> +
> +	strbuf_addstr(&path, tgt_prefix);
> +	if (!is_dir_sep(path.buf[path.len - 1]))
> +		strbuf_addch(&path, '/');
> +	strbuf_addstr(&path, sid);
> +	base_path_len = path.len;
> +
> +	for (attempt_count = 0; attempt_count < MAX_AUTO_ATTEMPTS; attempt_count++) {
> +		if (attempt_count > 0) {
> +			strbuf_setlen(&path, base_path_len);
> +			strbuf_addf(&path, ".%d", attempt_count);
> +		}
> +
> +		fd = open(path.buf, O_WRONLY | O_CREAT | O_EXCL, 0666);
> +		if (fd != -1)
> +			break;
> +	}
> +
> +	if (fd == -1) {
> +		if (tr2_dst_want_warning())
> +			warning("trace2: could not open '%.*s' for '%s' tracing: %s",
> +				(int) base_path_len, path.buf,
> +				dst->env_var_name, strerror(errno));
> +
> +		tr2_dst_trace_disable(dst);
> +		strbuf_release(&path);
> +		return 0;
> +	}
> +
> +	strbuf_release(&path);
> +
> +	dst->fd = fd;
> +	dst->need_close = 1;
> +	dst->initialized = 1;
> +
> +	return dst->fd;
> +}
> +
>  static int tr2_dst_try_path(struct tr2_dst *dst, const char *tgt_value)
>  {
>  	int fd = open(tgt_value, O_WRONLY | O_APPEND | O_CREAT, 0666);
> @@ -202,8 +257,12 @@ int tr2_dst_get_trace_fd(struct tr2_dst *dst)
>  		return dst->fd;
>  	}
>
> -	if (is_absolute_path(tgt_value))
> -		return tr2_dst_try_path(dst, tgt_value);
> +	if (is_absolute_path(tgt_value)) {
> +		if (is_directory(tgt_value))
> +			return tr2_dst_try_auto_path(dst, tgt_value);
> +		else
> +			return tr2_dst_try_path(dst, tgt_value);
> +	}
>
>  #ifndef NO_UNIX_SOCKETS
>  	if (starts_with(tgt_value, PREFIX_AF_UNIX))
