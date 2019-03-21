Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D02F820248
	for <e@80x24.org>; Thu, 21 Mar 2019 02:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfCUCFB (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 22:05:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39841 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCUCFB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 22:05:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id t124so1091943wma.4
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 19:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PU/N7dTsMc93G5wpWhDCWr8tWB6819geMyN6co5kitg=;
        b=qnkRxkvORcrBlmcKPd5HH0xt44MdlSs+Zr6krrzGEq+hq2ZwFBBkZXAgp6Sw0bhmaF
         nmKj1V/tbV2nUdeaUdciLHccKuKp3BaN3J+bU28gx/lkz8MI86JZ/GsUIO9K4CT+CY99
         eZbQDeItskTmPQhjSw4zIbWhRB691QknzqSd9K54UmagnUVUXcvpnZUB6Zn0XTSYAkW/
         VaxkQlpyeVrXNbov/D8OvdjO7WKyH/w7O256gRzNawVOo1ecn/btdQ4r3hSqCF5MQxE/
         laYz4cbFbt3EHlxtj2PfQf+qvhZMclC6FeIAL422L1j9qSyHV9YKV6LPdbkm+3cYP+3M
         Ni2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PU/N7dTsMc93G5wpWhDCWr8tWB6819geMyN6co5kitg=;
        b=Hbb+UHCe9OVlgTYpe9W8yemGBxIBgEFcfJ//9V3vwEkFoKiUv0r1v52RiMVX3IM93M
         +7xfKl4zy+/XwAyEcQ3YjaDzTflyPSA/aJAbyTU5XVGarglOBpVGFRsF0ZA3jymmv3B6
         Kf9fuvdY2wB38XD9Qzc7Nz15q858XZrCf4U/xqpaX/K1CFzNJwrLoI3ZKnUxP7YC6rKW
         a3wy7GM7ao6K3kGGsPF+2vmD+DfT+fdTaRBn0CMHpQjn2t5SsIOPbeJ4WaWNkpzwkAi+
         q8STDxsWcosi1GZ8N4UD5ewNSmD3lvb6DRzyL7fgsMo2BW2tsEFc5WvrjGkEXe1Hc900
         4Eow==
X-Gm-Message-State: APjAAAXs0N0rJiLK+GHNJGoUgDdv13cPOGQNWHCxv1vL0p/Os5OF31lh
        0jqXPSo7jXLu8/5VObejj30=
X-Google-Smtp-Source: APXvYqxQ9tviZU19vESLUU+vQx7k/0KDNFNLmD6TjCU5Jmb1IaS5U+H3Pre2jEPHlwRXfSykTfe7Hw==
X-Received: by 2002:a1c:1fcf:: with SMTP id f198mr751827wmf.145.1553133898498;
        Wed, 20 Mar 2019 19:04:58 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id o17sm1900132wrw.73.2019.03.20.19.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 19:04:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, avarab@gmail.com,
        peff@peff.net, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2 1/1] trace2: write to directory targets
References: <cover.1552519463.git.steadmon@google.com>
        <cover.1553126984.git.steadmon@google.com>
        <59d8c6511bc8c5fd25473c282768b38c97df9e6b.1553126984.git.steadmon@google.com>
Date:   Thu, 21 Mar 2019 11:04:57 +0900
In-Reply-To: <59d8c6511bc8c5fd25473c282768b38c97df9e6b.1553126984.git.steadmon@google.com>
        (Josh Steadmon's message of "Wed, 20 Mar 2019 17:16:01 -0700")
Message-ID: <xmqqmulpt22e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
> index 03a0aedb1d..26c9c1b3b8 100755
> --- a/t/t0210-trace2-normal.sh
> +++ b/t/t0210-trace2-normal.sh
> @@ -80,6 +80,21 @@ test_expect_success 'normal stream, return code 1' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'randomized filename' '
> +	test_when_finished "rm -r traces actual expect" &&
> +	mkdir traces &&
> +	GIT_TR2="$(pwd)/traces" test-tool trace2 001return 0 &&
> +	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <"$(ls traces/*)" >actual &&

This is cute.

What we want to test for this new feature is that the directory
traces/ that was originally empty now has exactly one readable file,
which was created by producing a trace.

And redirecting from "$(ls traces/*)" would succeed only when there
is exactly one readble file in the directory.  If it has none, or
more than one, the redirection will fail and we'd notice the error.

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
> index fd490a43ad..0e752914dc 100644
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
> + * How many attempts we will make at creating a random trace output path.
> + */
> +#define MAX_RANDOM_ATTEMPTS 10

With the updated design, randomness is no longer the primary
property of this new feature.  The fact that the names are
automatically assigned is.  It could be that the source of tr2_sid
may (or may not) be some randomness, but the point is that the
caller in this patch does not care how tr2_sid is computed.

I'd call this max-attempts (or max-autopath-attempts, but that is
rather long, and I do not think inside the scope of "tr2_dst" that
is about "destination", there will be anything but the destination
path we'd "attempt" with a reasonable maximum value to compute, so
the "-autopath" clarification would not buy us much)....

>  static int tr2_dst_want_warning(void)
>  {
>  	static int tr2env_dst_debug = -1;
> @@ -36,6 +42,53 @@ void tr2_dst_trace_disable(struct tr2_dst *dst)
>  	dst->need_close = 0;
>  }
>  
> +static int tr2_dst_try_random_path(struct tr2_dst *dst, const char *tgt_prefix)

.... and I'd call this s/random/auto/ instead, if I were writing
this patch following the updated design.

> +{
> +	int fd;
> +	const char *last_slash, *sid = tr2_sid_get();
> +	struct strbuf base_path = STRBUF_INIT, final_path = STRBUF_INIT;
> +	unsigned attempt_count;
> +
> +	last_slash = strrchr(sid, '/');
> +	if (last_slash)
> +		sid = last_slash + 1;
> +
> +	strbuf_addstr(&base_path, tgt_prefix);
> +	if (!is_dir_sep(base_path.buf[base_path.len - 1]))
> +		strbuf_addch(&base_path, '/');
> +	strbuf_addstr(&base_path, sid);

I do not think it is such a huge deal, but you can remember the
value of base_path.len at this point and then get rid of the other
strbuf (and copying into it).  As that will leave only one path
variable you need to worry about, you can shorten base_path to just
path if you go that route.

    baselen = path.len;

> +	for (attempt_count = 0; attempt_count < MAX_RANDOM_ATTEMPTS; attempt_count++) {
> +		strbuf_reset(&final_path);
> +		strbuf_addbuf(&final_path, &base_path);
> +		strbuf_addf(&final_path, ".%d", attempt_count);
> +		fd = open(final_path.buf, O_WRONLY | O_CREAT | O_EXCL, 0666);

If you follow the "get rid of final_path" route, these would become:

    strbuf_setlen(&path, baselen);
    strbuf_addf(&path, ".%d", count);
    fd = open(path.buf, ..., 0666);

> +		if (fd != -1)
> +			break;
> +	}

And that way, you have one fewer strbuf to _release() at the end and
at early exit points.

> +		if (tr2_dst_want_warning())
> +			warning("trace2: could not open '%s' for '%s' tracing: %s",
> +				base_path.buf, dst->env_var_name, strerror(errno));

This would need to become

		warning("trace2: could not open '%.*s' for '%s' tracing: %s",
			path.buf, baselen, dst->env_var_name, strerror(errno));

if we go that route.
