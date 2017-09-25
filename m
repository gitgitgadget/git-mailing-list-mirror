Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8ADF202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 17:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965301AbdIYRYu (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 13:24:50 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:51439 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964851AbdIYRYt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 13:24:49 -0400
Received: by mail-pg0-f43.google.com with SMTP id k193so4349465pgc.8
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 10:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uqlhVXrLdp8K7PkHbLRjAR41IlmmER5itZjJYBlmq6g=;
        b=j+ywVeGxRIDeoIDXA5HsexNBc5tIdRaoJ0J6yoYpqKUsOhtIZDDfpZ92NS3lup01KE
         dpFpB6o9b/hS7/ze3jm9wgNwmaTvfHV3Qx4Gwn/rXpzm6r4xwEmQp38f+ng8DSNdyv+S
         dnZtwDyacrGwesLEMkfdgiPJSsPUXmr/aAfP5iTaR2oJcYr8icO/bXP5v73FZkh0+ATB
         RBeKgXhgMRgYVsQ8jhAUJ311qnN25hO2Zj3GDVosUJTPAGjYssM5inlt9DNtgYah92c3
         GxsKD4bap+am4x9i0zmsLKOZUC9SsnT637sSkEOWFOg1+G9AZO7WTCVrWqL1jwvXJ7UK
         5fVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uqlhVXrLdp8K7PkHbLRjAR41IlmmER5itZjJYBlmq6g=;
        b=Xr3QIPsVx63HqEUq4GOee6NaSpIcwdhRcws1Uiaw/nBzaH681SbS6PXRR59ASaJjoG
         NZSaqasjgw7HbC7cQ+LeNvaoHemzFppvBZk0BXQfDBk3j+NCABsoU9rkOTb0FFquv02L
         kZUoTtiBQNWxmFkdcQZ756ZV94mNjZyxc6Lu3aA3GidfYekQeOzZG+P6Z5uHJg2OP9FJ
         rzphFbXM0F3yxcDiRa4rPoHRH+94/hQpzICuRvI7pztIktgCFIOPulBp6OBo6IR2rvv+
         s2OdfSYaaYdY0v0zg/0jqCuI1j6AGO3itvb6sNzu278qpp07CeQJjz9ZLh+gRB1YrVOP
         79Ow==
X-Gm-Message-State: AHPjjUg5LgLZPjeiBtfv9Lq2JH+aLqWjYmp34w6zQByxpwunr1gGm45m
        fFC6BSW6fd6Sgp+Q1FFmlCqSEA==
X-Google-Smtp-Source: AOwi7QAa0rIABADplMrLT6PJYbFPlA6jdbRBIGSVQa3z97+GRM5mFBaSdkFjtB62ftYH+XE+xRYJDg==
X-Received: by 10.99.65.70 with SMTP id o67mr8329339pga.193.1506360289178;
        Mon, 25 Sep 2017 10:24:49 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:2d6e:b6b:1517:59cb])
        by smtp.gmail.com with ESMTPSA id w12sm14275300pfk.83.2017.09.25.10.24.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 10:24:48 -0700 (PDT)
Date:   Mon, 25 Sep 2017 10:24:46 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 2/4] Clarify return value ownership of real_path and
 read_gitfile_gently
Message-ID: <20170925172446.GB35385@google.com>
References: <20170925155927.32328-1-hanwen@google.com>
 <20170925155927.32328-3-hanwen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170925155927.32328-3-hanwen@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/25, Han-Wen Nienhuys wrote:
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  abspath.c | 3 +++
>  setup.c   | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/abspath.c b/abspath.c
> index 708aff8d4..792a2d533 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -202,6 +202,9 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
>  	return retval;
>  }
>  
> +/* Resolve `path` into an absolute, cleaned-up path. The return value
> + * comes from a global shared buffer and should not be freed.
> + */

nit: Our comment style requires the opening '/*' which starts a comment
block to be on its own line.

>  const char *real_path(const char *path)
>  {
>  	static struct strbuf realpath = STRBUF_INIT;
> diff --git a/setup.c b/setup.c
> index 6d8380acd..31853724c 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -541,7 +541,8 @@ void read_gitfile_error_die(int error_code, const char *path, const char *dir)
>  
>  /*
>   * Try to read the location of the git directory from the .git file,
> - * return path to git directory if found.
> + * return path to git directory if found. The return value comes from
> + * a shared pool and should not be freed.
>   *
>   * On failure, if return_error_code is not NULL, return_error_code
>   * will be set to an error code and NULL will be returned. If
> -- 
> 2.14.1.821.g8fa685d3b7-goog
> 

-- 
Brandon Williams
