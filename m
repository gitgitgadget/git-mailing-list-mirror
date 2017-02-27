Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 430DD20254
	for <e@80x24.org>; Mon, 27 Feb 2017 18:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbdB0SXN (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:23:13 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35095 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdB0SXL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:23:11 -0500
Received: by mail-pg0-f41.google.com with SMTP id b129so47279165pgc.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6mTOGzv7hPwJ7i5R/dBaN4YMpIl6Sh4bmjkS8qBmWfo=;
        b=Kbageu+SRiiJ65rXjC70xDgA3TFVpcFb+SIjvhGuYnA4kGvsGnCVXkRVuBrvG0obw6
         xxFQ+hE6oBaY3e/O5C4Te6FgrD/XcWUvoW/2uncAQL0bTiOjNqdp23lLIvRhEKqCCMhY
         AbwCmph4lfSCJz438PAjEO+XaZhYHkpe72YgeC0FZEhj/wZXOJGMMoWCWA737GL6hK5L
         7Thda2s3+avK4JmwvLWxBw+24fVbUeHV2VLhBLTFt51w9oyLjC2Cs8kfS0LLUtL2dBxG
         /+gLoFJ/0XvJdccIIjbC6t6WBZZ0ItIFyidgqAwbUUFiILxAioPMZRFOEZxfp57loOVG
         n2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6mTOGzv7hPwJ7i5R/dBaN4YMpIl6Sh4bmjkS8qBmWfo=;
        b=WfuAl1Hwk91fuEimsAx0Dgi5IxUZOiYdCFLls4jYx/hDOms5K7de0MlYjmiK30nHor
         UV7baLJakH2N/bxBmTZdP2xE0NKaIsZrFaPdvxD9sUTvMWBeUtKKnQgZIZ+H6E2Upot9
         46zAyUd2vDH9sxYJrpZbtSJM4NCIjWbPVMyS3af+Db53sMvbpQQzBnbNripPqABYzapQ
         2mFEFqrieLADZpIxoAxWobtJIN7shZkDbK2t2hr85ETjrHJMJoOEBexRO1Epo7K8SyNP
         shXXN1teTsu8LISeTlrkjUnCN/C/ozGiRfM41b9doAEfY0BU4k4y00kAeyCja2KrMuTE
         gW2w==
X-Gm-Message-State: AMke39lpjjQPmTdd514MDAUFo//gRCewdy+v4EovsW9X197CXnSjpAU1NLafVRT8GyePqIhz
X-Received: by 10.84.177.36 with SMTP id w33mr26110673plb.105.1488219739159;
        Mon, 27 Feb 2017 10:22:19 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:5d0b:b83e:e4b4:f20d])
        by smtp.gmail.com with ESMTPSA id n8sm32247527pgd.5.2017.02.27.10.22.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:22:18 -0800 (PST)
Date:   Mon, 27 Feb 2017 10:22:17 -0800
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf: add strbuf_add_real_path()
Message-ID: <20170227182217.GC153455@google.com>
References: <4d191b86-d36c-e3ec-99c6-d15baa6b659a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d191b86-d36c-e3ec-99c6-d15baa6b659a@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/25, René Scharfe wrote:
> Add a function for appending the canonized absolute pathname of a given
> path to a strbuf.  It keeps the existing contents intact, as expected of
> a function of the strbuf_add() family, while avoiding copying the result
> if the given strbuf is empty.  It's more consistent with the rest of the
> strbuf API than strbuf_realpath(), which it's wrapping.
> 
> Also add a semantic patch demonstrating its intended usage and apply it
> to the current tree.  Using strbuf_add_real_path() instead of calling
> strbuf_addstr() and real_path() avoids an extra copy to a static buffer.
> 

Seems like a reasonable thing to do.  When I wrote strbuf_realpath() I
think I looked at the strbuf_getcwd() function for what it did (since it
handled paths) and it simply uses the provided buffer disregarding what
is already stored in it.

> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  contrib/coccinelle/strbuf.cocci |  6 ++++++
>  setup.c                         |  2 +-
>  strbuf.c                        | 11 +++++++++++
>  strbuf.h                        | 14 ++++++++++++++
>  4 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf.cocci
> index 63995f22ff..1d580e49b0 100644
> --- a/contrib/coccinelle/strbuf.cocci
> +++ b/contrib/coccinelle/strbuf.cocci
> @@ -38,3 +38,9 @@ expression E1, E2, E3;
>  @@
>  - strbuf_addstr(E1, find_unique_abbrev(E2, E3));
>  + strbuf_add_unique_abbrev(E1, E2, E3);
> +
> +@@
> +expression E1, E2;
> +@@
> +- strbuf_addstr(E1, real_path(E2));
> ++ strbuf_add_real_path(E1, E2);
> diff --git a/setup.c b/setup.c
> index 967f289f1e..f14cbcd338 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -254,7 +254,7 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
>  		if (!is_absolute_path(data.buf))
>  			strbuf_addf(&path, "%s/", gitdir);
>  		strbuf_addbuf(&path, &data);
> -		strbuf_addstr(sb, real_path(path.buf));
> +		strbuf_add_real_path(sb, path.buf);
>  		ret = 1;
>  	} else {
>  		strbuf_addstr(sb, gitdir);
> diff --git a/strbuf.c b/strbuf.cq
> index 8fec6579f7..ace58e7367 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -707,6 +707,17 @@ void strbuf_add_absolute_path(struct strbuf *sb, const char *path)
>  	strbuf_addstr(sb, path);
>  }
>  
> +void strbuf_add_real_path(struct strbuf *sb, const char *path)
> +{
> +	if (sb->len) {
> +		struct strbuf resolved = STRBUF_INIT;
> +		strbuf_realpath(&resolved, path, 1);
> +		strbuf_addbuf(sb, &resolved);
> +		strbuf_release(&resolved);
> +	} else
> +		strbuf_realpath(sb, path, 1);

I know its not required but I would have braces on the 'else' branch
since they were needed on the 'if' branch.  But that's up to you and
your style :)

> +}
> +
>  int printf_ln(const char *fmt, ...)
>  {
>  	int ret;
> diff --git a/strbuf.h b/strbuf.h
> index cf1b5409e7..cf8e4bf532 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -441,6 +441,20 @@ extern int strbuf_getcwd(struct strbuf *sb);
>   */
>  extern void strbuf_add_absolute_path(struct strbuf *sb, const char *path);
>  
> +/**
> + * Canonize `path` (make it absolute, resolve symlinks, remove extra
> + * slashes) and append it to `sb`.  Die with an informative error
> + * message if there is a problem.
> + *
> + * The directory part of `path` (i.e., everything up to the last
> + * dir_sep) must denote a valid, existing directory, but the last
> + * component need not exist.
> + *
> + * Callers that don't mind links should use the more lightweight
> + * strbuf_add_absolute_path() instead.
> + */
> +extern void strbuf_add_real_path(struct strbuf *sb, const char *path);
> +
>  
>  /**
>   * Normalize in-place the path contained in the strbuf. See
> -- 
> 2.12.0
> 

-- 
Brandon Williams
