Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96B431F462
	for <e@80x24.org>; Sat, 27 Jul 2019 08:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfG0Inz (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jul 2019 04:43:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33508 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbfG0Inz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jul 2019 04:43:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id h19so39487062wme.0
        for <git@vger.kernel.org>; Sat, 27 Jul 2019 01:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1eJSVMLDvKGG/DuF8VaGPYLi3VZ+H+gUKHzvZAT1nZA=;
        b=HIYA4JYJElle+fGC/O/TRS0A7KqXOrZH7P7d0nKROehy0CbnuIuJ6Mn/bLuVOqbsfv
         v+kAtlNF0KXryj+PdR7/Dw3Zzwadg6sJVfUWx9xvSs73/UNC7F7z7o9H4YPO9fw9+RRz
         sWlXjrKOzM9Off3gb75AzTG5dlq6E77lQawP6IKJkbA+jCNshpYVOL9FpSE7UfDMd1NF
         lAHAq+3ZhUIkMcYaS87kzaXciwbrYdl4TgXFszXqUK+2A61UVhNQgypjs6nhUl5d0WOw
         TA6JZu+9u2kcJLTd3bhsNWPF7OvlNDSEklckdMxQCM2GFPo9a5ah4zRrL5zMBxDNX8Lz
         Zu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1eJSVMLDvKGG/DuF8VaGPYLi3VZ+H+gUKHzvZAT1nZA=;
        b=APA554uKArVFZ41xm1t5DiBlL/a9Z0qFzR8HMjw5nKerFYLzwBvHv3mE5SHLoQuX91
         IF4Ch7lFY/Hl88wiGW1DJgEIjbIO8CTVIOtCxMCc/h82x0+dgHJnm8JMoN7TOm6mMXfr
         leE1b7BzDcnqkJcVR2Wjckfi4M9Kgiy6IpgHQvxeps3FTNZGmBq8w72WcmqtAf0Xj16s
         fm9+KtsZR+t95RFTzoD2xsijn95jMMlQAoz+xU88LV7p0G/+YWTDjli9bxNLJ2+070US
         S0AdgPyC9xNa2nDJqLsLBGOkdYS99WqegfESbYP20FxZpxNQ4GA4GskwB0CywGHXEExU
         JdAg==
X-Gm-Message-State: APjAAAU00CAeAYWemEa6abREjI3UXyD9sNhoJ4Rrot29F2ZMG2TvWVLx
        wuMpC9xXYh5IG+antb3ScpWKt2+H
X-Google-Smtp-Source: APXvYqyYBzPEv6ONW6XfqCtKhqUOms62n4wkQWQGdGnKWF4aoTRnC6LPAsWFnqAoWYcVw+N+eRb+yA==
X-Received: by 2002:a05:600c:34d:: with SMTP id u13mr62753354wmd.48.1564217033626;
        Sat, 27 Jul 2019 01:43:53 -0700 (PDT)
Received: from szeder.dev (x4db47bfc.dyn.telefonica.de. [77.180.123.252])
        by smtp.gmail.com with ESMTPSA id a81sm56763869wmh.3.2019.07.27.01.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jul 2019 01:43:52 -0700 (PDT)
Date:   Sat, 27 Jul 2019 10:43:48 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] transport-helper: enforce atomic in
 push_refs_with_push
Message-ID: <20190727084348.GO20404@szeder.dev>
References: <20190702005340.66615-1-emilyshaffer@google.com>
 <20190709211043.48597-1-emilyshaffer@google.com>
 <CAPUEspgjSAqHUP2vsCCjqG8b0QkWdgoAByh4XdqsThQMt=V38w@mail.gmail.com>
 <xmqq8ssx53a0.fsf@gitster-ct.c.googlers.com>
 <20190718152234.GI20404@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190718152234.GI20404@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

On Thu, Jul 18, 2019 at 05:22:34PM +0200, SZEDER Gábor wrote:
> Subject: [PATCH] travis-ci: build with GCC 4.8 as well

This patch conflicts with topic 'js/trace2-json-schema', and the
current conflict resolution in 'pu' is not quite correct.

> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index cdd2913440..ff0ef7f08e 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -11,9 +11,9 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
>  esac
>  
>  make
> -make test
> -if test "$jobname" = "linux-gcc"
> -then
> +case "$jobname" in
> +linux-gcc)
> +	make test

This 'make test' here is important, but the confict resolution
accidentally removed it.

>  	export GIT_TEST_SPLIT_INDEX=yes
>  	export GIT_TEST_FULL_IN_PACK_ARRAY=true
>  	export GIT_TEST_OE_SIZE=10
> @@ -21,7 +21,16 @@ then
>  	export GIT_TEST_COMMIT_GRAPH=1
>  	export GIT_TEST_MULTI_PACK_INDEX=1
>  	make test
> -fi
> +	;;
> +linux-gcc-4.8)
> +	# Don't run the tests; we only care about whether Git can be
> +	# built with GCC 4.8, as it errors out on some undesired (C99)
> +	# constructs that newer compilers seem to quietly accept.
> +	;;
> +*)
> +	make test
> +	;;
> +esac
>  
>  check_unignored_build_artifacts
>  
> -- 
> 2.22.0.810.g50207c7d84
> 
> 
