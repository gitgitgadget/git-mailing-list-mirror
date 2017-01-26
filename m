Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E60A41F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 18:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752876AbdAZSco (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 13:32:44 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33028 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753880AbdAZScn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 13:32:43 -0500
Received: by mail-pf0-f179.google.com with SMTP id y143so67061399pfb.0
        for <git@vger.kernel.org>; Thu, 26 Jan 2017 10:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wdyTZMAEcekI/rODgnJgsPVIxrj60W6gEJkZTOq0ZYM=;
        b=d4v8eCPo2LBKwsoUTSj/WAl6pB8jBK2ORAfq0kphAsFFpxU9Z0el+G8j0WCpApBsqC
         Tfyb2BIb9ojmCZRNopk/KTVkSc/tlwNFj7STEVhiWXMDo1yoIDfPBkTo9j/ehYeymteY
         1U3gmLk+9gqzrsEfpIeMXF+DfKr+gCeSvmstcbae+eGcy63bFvUKfl6jdwZVFzKbiZqz
         Y8OsqEtsf3f0/KWKhVN4trRcAp35dJzNEme8OLkdDpvlyxqyjRq1Vf++nYh4rbPpA6jF
         K2HwqZFByB+M5LZdQtW1keN4u7Jb38Fth+irr0fRJTTlOA50ZKV2ljpEMfSpu+RHK91+
         WwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wdyTZMAEcekI/rODgnJgsPVIxrj60W6gEJkZTOq0ZYM=;
        b=YohQQssn5UeuZB48sZWpIbdUMG9N54hTFAogKauepLUjL0oDDHMl1ZPTE2rP9f+Vdg
         CJqGRJH0yzXvQq24Vt5kxvvUeqA1DRURxELi11CCfWXs3MXrG9Pd7ybGRd0w4Z1Gr378
         QScaQoqLNFBA9WXZduGYVQlQyVJgYYKN+Effuq14uKznlegjijq1gjaM1Oa57shA2ZJx
         X3MHf/gMx48wpDYNd3SvRY69FZ0f6CU5Cfj99fQyb9LvhqNk+swgOonsKCjpLaAwjQLm
         arPY2NRM59YcFhmfxRpkZsLyHAEEDKhE4jelEVBR6f+QuS5D/+ixZ+6MqwUMBMea2McW
         8JNA==
X-Gm-Message-State: AIkVDXJOMkxn5wzc9q5gfPvZG9v6OsSnvcJpi8DAfwDOoUuYQsb5FNC37jshc1Gw81GPU+SA
X-Received: by 10.84.134.169 with SMTP id 38mr6041906plh.67.1485455551574;
        Thu, 26 Jan 2017 10:32:31 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:d901:f11e:e93:985])
        by smtp.gmail.com with ESMTPSA id d124sm5070101pga.30.2017.01.26.10.32.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 26 Jan 2017 10:32:30 -0800 (PST)
Date:   Thu, 26 Jan 2017 10:32:29 -0800
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: PATCH 1/2] abspath: add absolute_pathdup()
Message-ID: <20170126183229.GA3626@google.com>
References: <d94d742d-1247-ac35-c081-7db1f2178d34@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d94d742d-1247-ac35-c081-7db1f2178d34@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/26, René Scharfe wrote:
> Add a function that returns a buffer containing the absolute path of its
> argument and a semantic patch for its intended use.  It avoids an extra
> string copy to a static buffer.
> 
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  abspath.c                                | 7 +++++++
>  cache.h                                  | 1 +
>  contrib/coccinelle/xstrdup_or_null.cocci | 6 ++++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/abspath.c b/abspath.c
> index fce40fddcc..2f0c26e0e2 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -239,6 +239,13 @@ const char *absolute_path(const char *path)
>  	return sb.buf;
>  }
>  
> +char *absolute_pathdup(const char *path)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	strbuf_add_absolute_path(&sb, path);
> +	return strbuf_detach(&sb, NULL);
> +}
> +
>  /*
>   * Unlike prefix_path, this should be used if the named file does
>   * not have to interact with index entry; i.e. name of a random file
> diff --git a/cache.h b/cache.h
> index 00a029af36..d7b7a8cd7a 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1069,6 +1069,7 @@ const char *real_path(const char *path);
>  const char *real_path_if_valid(const char *path);
>  char *real_pathdup(const char *path);
>  const char *absolute_path(const char *path);
> +char *absolute_pathdup(const char *path);
>  const char *remove_leading_path(const char *in, const char *prefix);
>  const char *relative_path(const char *in, const char *prefix, struct strbuf *sb);
>  int normalize_path_copy_len(char *dst, const char *src, int *prefix_len);
> diff --git a/contrib/coccinelle/xstrdup_or_null.cocci b/contrib/coccinelle/xstrdup_or_null.cocci
> index 3fceef132b..8e05d1ca4b 100644
> --- a/contrib/coccinelle/xstrdup_or_null.cocci
> +++ b/contrib/coccinelle/xstrdup_or_null.cocci
> @@ -5,3 +5,9 @@ expression V;
>  - if (E)
>  -    V = xstrdup(E);
>  + V = xstrdup_or_null(E);
> +
> +@@
> +expression E;
> +@@
> +- xstrdup(absolute_path(E))
> ++ absolute_pathdup(E)
> -- 
> 2.11.0
> 

These two patches look good to me.

-- 
Brandon Williams
