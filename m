Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5948A207FF
	for <e@80x24.org>; Fri,  5 May 2017 17:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750890AbdEERos (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 13:44:48 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35367 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbdEERor (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 13:44:47 -0400
Received: by mail-pg0-f66.google.com with SMTP id i63so1628419pgd.2
        for <git@vger.kernel.org>; Fri, 05 May 2017 10:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9Fq5CNmMc5igCQ1ziR5x5TcPAC2LAt4D3CsEzv/9ZlM=;
        b=BrRZcn7AT3DlG0H+6QwdR/S2Uh762wStArdqUajRkb9BxXWUlibGk55hHAmFEuRgaj
         HLNZrmOQcL9Blg+Ijzpy5ACVjsMRcykjoB/+9ylWffnIj8TGvKDl6rq6yAKQ2cIK6nIC
         sV4wykuVBxg4todMv2U7qjI0HLz2ssruQh4wSWZ9G5r9VQJyyv8x1+py42S1PMaoAAGi
         Hvz6BilGONdHCeZxhJ8sBaSAeEIcy3nnbthZ9eXwf7vxbdhbfeSI6Uo8xlXUXzPVgm/R
         3hFQWCy6IczCpq9+Vb0ZXQ/aFrRvCWv1zr2DA7Sbup8PciqC1BDkFkVa7g7UskZxvrqW
         /lNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9Fq5CNmMc5igCQ1ziR5x5TcPAC2LAt4D3CsEzv/9ZlM=;
        b=S8zsQbQv0W2cu/yfn0YkleoEkJEPlW3kORFx6KCz61oodjqHWlEGrbQMRmeFKXpeFI
         SA10TF+e1kXmIaXmd3O87cgOCqW6yK0Yy06XycjGU+/ZYdJFwLZSvsm4B2RtiUErX3HK
         ZPXE6ay1vTbRR+nwk0iPhfwyONrhyf0/O08lKfHb06Nen6QSLxS9hVTjLqkRMSSXhksj
         7RHydJ3sIKhf7l5sKm8lqlR0YvwPNLfPofitbVPXWzD8rwfZUHDEeCkB8z4Doa3vZd2K
         Ymijl5QbWkSyRjYLGYr5lxjrej34CeBCwh9X6N51FTorkIWm1TymJQfxbG2Zo8C++o6t
         Q3DA==
X-Gm-Message-State: AN3rC/6PSuyBmNFs09WdNQUR9R9pmpDvrLyU3acz3p+4xXI79KGCz43Q
        Ts3B8E8DoH+3KQ==
X-Received: by 10.84.193.3 with SMTP id e3mr31269104pld.21.1494006286948;
        Fri, 05 May 2017 10:44:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:aca8:b828:d7c5:8258])
        by smtp.gmail.com with ESMTPSA id o5sm13941074pfk.126.2017.05.05.10.44.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 May 2017 10:44:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Smith <whydoubt@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [RFC PATCH 02/10] Move textconv_object to be with other textconv methods
References: <20170505052729.7576-1-whydoubt@gmail.com>
        <20170505052729.7576-3-whydoubt@gmail.com>
Date:   Fri, 05 May 2017 10:44:45 -0700
In-Reply-To: <20170505052729.7576-3-whydoubt@gmail.com> (Jeff Smith's message
        of "Fri, 5 May 2017 00:27:21 -0500")
Message-ID: <xmqqwp9v6vw2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Smith <whydoubt@gmail.com> writes:

> Signed-off-by: Jeff Smith <whydoubt@gmail.com>
> ---
>  builtin.h          |  2 --
>  builtin/blame.c    | 28 ----------------------------
>  builtin/cat-file.c |  1 +
>  diff.c             | 23 +++++++++++++++++++++++
>  diff.h             |  7 +++++++
>  5 files changed, 31 insertions(+), 30 deletions(-)

This change makes sense regardless of your primary goal of the
series.  It was not good that one builtin borrowing a helper from
another.  The common helper should live outside builtin/ as a common
code, and in this case, diff.[ch] may be an OK place for it.


>
> diff --git a/builtin.h b/builtin.h
> index 9e4a898..498ac80 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -25,8 +25,6 @@ struct fmt_merge_msg_opts {
>  extern int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
>  			 struct fmt_merge_msg_opts *);
>  
> -extern int textconv_object(const char *path, unsigned mode, const struct object_id *oid, int oid_valid, char **buf, unsigned long *buf_size);
> -
>  extern int is_builtin(const char *s);
>  
>  extern int cmd_add(int argc, const char **argv, const char *prefix);
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 42c56eb..c419981 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -147,34 +147,6 @@ static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
>  }
>  
>  /*
> - * Prepare diff_filespec and convert it using diff textconv API
> - * if the textconv driver exists.
> - * Return 1 if the conversion succeeds, 0 otherwise.
> - */
> -int textconv_object(const char *path,
> -		    unsigned mode,
> -		    const struct object_id *oid,
> -		    int oid_valid,
> -		    char **buf,
> -		    unsigned long *buf_size)
> -{
> -	struct diff_filespec *df;
> -	struct userdiff_driver *textconv;
> -
> -	df = alloc_filespec(path);
> -	fill_filespec(df, oid->hash, oid_valid, mode);
> -	textconv = get_textconv(df);
> -	if (!textconv) {
> -		free_filespec(df);
> -		return 0;
> -	}
> -
> -	*buf_size = fill_textconv(textconv, df, buf);
> -	free_filespec(df);
> -	return 1;
> -}
> -
> -/*
>   * Given an origin, prepare mmfile_t structure to be used by the
>   * diff machinery
>   */
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 1890d7a..79a2c82 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -5,6 +5,7 @@
>   */
>  #include "cache.h"
>  #include "builtin.h"
> +#include "diff.h"
>  #include "parse-options.h"
>  #include "userdiff.h"
>  #include "streaming.h"
> diff --git a/diff.c b/diff.c
> index 11eef1c..a62e989 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -5270,6 +5270,29 @@ size_t fill_textconv(struct userdiff_driver *driver,
>  	return size;
>  }
>  
> +int textconv_object(const char *path,
> +		    unsigned mode,
> +		    const struct object_id *oid,
> +		    int oid_valid,
> +		    char **buf,
> +		    unsigned long *buf_size)
> +{
> +	struct diff_filespec *df;
> +	struct userdiff_driver *textconv;
> +
> +	df = alloc_filespec(path);
> +	fill_filespec(df, oid->hash, oid_valid, mode);
> +	textconv = get_textconv(df);
> +	if (!textconv) {
> +		free_filespec(df);
> +		return 0;
> +	}
> +
> +	*buf_size = fill_textconv(textconv, df, buf);
> +	free_filespec(df);
> +	return 1;
> +}
> +
>  void setup_diff_pager(struct diff_options *opt)
>  {
>  	/*
> diff --git a/diff.h b/diff.h
> index 5be1ee7..52ebd54 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -385,6 +385,13 @@ extern size_t fill_textconv(struct userdiff_driver *driver,
>   */
>  extern struct userdiff_driver *get_textconv(struct diff_filespec *one);
>  
> +/*
> + * Prepare diff_filespec and convert it using diff textconv API
> + * if the textconv driver exists.
> + * Return 1 if the conversion succeeds, 0 otherwise.
> + */
> +extern int textconv_object(const char *path, unsigned mode, const struct object_id *oid, int oid_valid, char **buf, unsigned long *buf_size);
> +
>  extern int parse_rename_score(const char **cp_p);
>  
>  extern long parse_algorithm_value(const char *value);
