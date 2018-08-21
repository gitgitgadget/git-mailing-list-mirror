Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 079451F954
	for <e@80x24.org>; Tue, 21 Aug 2018 05:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbeHUIYQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 04:24:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36162 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbeHUIYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 04:24:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so7912090pfo.3
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 22:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IuwQD5tL3SWXcxIVvRhE4ltQghVqA0ijjJhFKo9KenQ=;
        b=fGhodYFg5+C7mkfjYD9YxxtM2smWHax10dk9yXbYxHq4T2Gy5UiL9jTGeCv7LwwqUv
         vR80xy4jI4Db9AtTKYy1xvEHG/PeHh5oMueFvDRP2SHYlg8XSIfmoCn2QqltiiDwhlMi
         aGyi6AcCIAHr2bf9EGaGD5iqFoJTo0gyHU6ZRRNplCq5jOE4Mw+3HtGi/m5seL4lFW3D
         MzSNJ8FXztEh3yAc9myOgj88ME+H1pBvNI7t2xsE/fsOoThqe5O/9vhIHmTx98YGFG5E
         o0z7aBEHhEe33QYC5TYfMoPaK723bnd8kwFmZMoE91jrZyZWl5m8JPNdCm4oIiHe18g9
         fbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IuwQD5tL3SWXcxIVvRhE4ltQghVqA0ijjJhFKo9KenQ=;
        b=aU+nxIemvUQYg8K/XXeE649XRVJZ17qiDWRS13sWQPqP9wsGeQmVPr4uhHLxQLen+o
         H49QJJTqaS5uuhc970yz3Q+16EwnQrlip2tCx/u1BQhflFH/1cZHiSlUjjyUkE/rOBAn
         oyJlL5VgwMGpU0SPq73ZVHY5iDFZO060LmlO4LkawkOJXx/ou/I0mTwqpM31MovIwSHt
         fPceDI7Va10PTHUunBMCYdP7AARPEIosCyjX+r7zjX+PL3XYW5N5FccUgu7BXaFKwU5R
         b11F4xkdn1U3Oy2nJrbz9eYX9ixYAvnkvK/vDBsB4IObNMxp6okzJsft+D6rrZaHeXqt
         iH4Q==
X-Gm-Message-State: AOUpUlHbkUeA9mR8Okb4iUQ4316uxaMDe/8txMmTPgAX8uX0Io7sm9Sq
        aOyiZliak1+suRmyVMar9kw=
X-Google-Smtp-Source: AA+uWPx27B/D1d0kogrYus8Leg6TZWixxZ4uSGd1m57p0xPJ5nRDwXeC3c0iGPqNu33rc6Yi0jsXSw==
X-Received: by 2002:a62:11c4:: with SMTP id 65-v6mr51497864pfr.54.1534827943415;
        Mon, 20 Aug 2018 22:05:43 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 9-v6sm16280585pfv.53.2018.08.20.22.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 22:05:42 -0700 (PDT)
Date:   Mon, 20 Aug 2018 22:05:41 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1 03/25] structured-logging: add structured logging
 framework
Message-ID: <20180821050541.GC219616@aiede.svl.corp.google.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
 <20180713165621.52017-4-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713165621.52017-4-git@jeffhostetler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler wrote:

[...]
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -144,8 +144,15 @@ static inline int fcntl(int fd, int cmd, ...)
>  	errno = EINVAL;
>  	return -1;
>  }
> +
>  /* bash cannot reliably detect negative return codes as failure */
> +#if defined(STRUCTURED_LOGGING)

Git usually spells this as #ifdef.

> +#include "structured-logging.h"
> +#define exit(code) exit(strlog_exit_code((code) & 0xff))
> +#else
>  #define exit(code) exit((code) & 0xff)
> +#endif

This is hard to follow, since it only makes sense in combination with
the corresponding code in git-compat-util.h.  Can they be defined
together?  If not, can they have comments to make it easier to know to
edit one too when editing the other?

[...]
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1239,4 +1239,13 @@ extern void unleak_memory(const void *ptr, size_t len);
>  #define UNLEAK(var) do {} while (0)
>  #endif
>  
> +#include "structured-logging.h"

Is this #include needed?  Usually git-compat-util.h only defines C
standard library functions or utilities that are used everywhere.

[...]
> --- a/git.c
> +++ b/git.c
[...]
> @@ -700,7 +701,7 @@ static int run_argv(int *argcp, const char ***argv)
>  	return done_alias;
>  }
>  
> -int cmd_main(int argc, const char **argv)
> +static int real_cmd_main(int argc, const char **argv)
>  {
>  	const char *cmd;
>  	int done_help = 0;
> @@ -779,3 +780,8 @@ int cmd_main(int argc, const char **argv)
>  
>  	return 1;
>  }
> +
> +int cmd_main(int argc, const char **argv)
> +{
> +	return slog_wrap_main(real_cmd_main, argc, argv);
> +}

Can real_cmd_main get a different name, describing what it does?

[...]
> --- a/structured-logging.c
> +++ b/structured-logging.c
> @@ -1,3 +1,10 @@
[...]
> +static uint64_t my__start_time;
> +static uint64_t my__exit_time;
> +static int my__is_config_loaded;
> +static int my__is_enabled;
> +static int my__is_pretty;
> +static int my__signal;
> +static int my__exit_code;
> +static int my__pid;
> +static int my__wrote_start_event;
> +static int my__log_fd = -1;

Please don't use this my__ notation.  The inconsistency with the rest
of Git makes the code feel out of place and provides an impediment to
smooth reading.

[...]
> +static void emit_start_event(void)
> +{
> +	struct json_writer jw = JSON_WRITER_INIT;
> +
> +	/* build "cmd_start" event message */
> +	jw_object_begin(&jw, my__is_pretty);
> +	{
> +		jw_object_string(&jw, "event", "cmd_start");
> +		jw_object_intmax(&jw, "clock_us", (intmax_t)my__start_time);
> +		jw_object_intmax(&jw, "pid", (intmax_t)my__pid);

The use of blocks here is unexpected and makes me wonder what kind of
macro wizardry is going on.  Perhaps this is idiomatic for the
json-writer API; if so, can you add an example to json-writer.h to
help the next surprised reader?

That said, I think

	json_object_begin(&jw, ...);

	json_object_string(...
	json_object_int(...
	...

	json_object_begin_inline_array(&jw, "argv");
	for (k = 0; k < argv.argc; k++)
		json_object_string(...
	json_object_end(&jw);

	json_object_end(&jw);

is still readable and less unexpected.

[...]
> +static void emit_exit_event(void)
> +{
> +	struct json_writer jw = JSON_WRITER_INIT;
> +	uint64_t atexit_time = getnanotime() / 1000;
> +
> +	/* close unterminated forms */

What are unterminated forms?

> +	if (my__errors.json.len)
> +		jw_end(&my__errors);
[...]
> +int slog_default_config(const char *key, const char *value)
> +{
> +	const char *sub;
> +
> +	/*
> +	 * git_default_config() calls slog_default_config() with "slog.*"
> +	 * k/v pairs.  git_default_config() MAY or MAY NOT be called when
> +	 * cmd_<command>() calls git_config().

No need to shout.

[...]
> +/*
> + * If cmd_<command>() did not cause slog_default_config() to be called
> + * during git_config(), we try to lookup our config settings the first
> + * time we actually need them.
> + *
> + * (We do this rather than using read_early_config() at initialization
> + * because we want any "-c key=value" arguments to be included.)
> + */

Which function is initialization referring to here?

Lazy loading in order to guarantee loading after a different subsystem
sounds a bit fragile, so I wonder if we can make the sequencing more
explicit.

Stopping here.  I still like where this is going, but some aspects of
the coding style are making it hard to see the forest for the trees.
Perhaps some more details about API in the design doc would help.

Thanks and hope that helps,
Jonathan
