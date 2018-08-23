Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56D061F954
	for <e@80x24.org>; Thu, 23 Aug 2018 02:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeHWGOr (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 02:14:47 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34055 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbeHWGOr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 02:14:47 -0400
Received: by mail-pl0-f67.google.com with SMTP id f6-v6so1720039plo.1
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 19:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UeaM3F208lyLwcsSa6t8kxWApPLzPHaOAhUUEoOwSN4=;
        b=EznP2wCqIH/vON8Nqkg3MgLJY/7xQRvcJ46yACXTzp8gxcXKL2uIubJ+vOu/IWGPCP
         J8uhZKbyAGc30wEYcdjQU9xVw+2sSq2TvnFNu1hB4WE3vYgi/mIsRNAcXLOBrhUzYHio
         BggQh9joyNa/Ag2A3roj+zIT+xO5OUAG/DtWSR6sioE4ruL+WKvX1c/Y8hy2QC6ASKm7
         PCCgC+Fo1X+aqcIa0dfXUBIQQvkUa5jnQ1HZatwDce+M3qtwxc++OQJRoFUEB9kIxwBk
         bokKbfzXGkEQYq4GdD9eqPjCz/+W4/6/nV9zvXx0QgQMhyY20KB0NxwFnswksGNyUbj9
         S8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UeaM3F208lyLwcsSa6t8kxWApPLzPHaOAhUUEoOwSN4=;
        b=iNLui8v2wflJNjEmOjKWcW/G7l92rm19zLSu2emYRoHS+oOvsVh/rpju1BH/9zN1IE
         tKp2QY6Na02Xg0pZ8WmClAnAbPtiVhGtI5dLNnn1jGYjL2Jzo/ouws1sKsSobJiQYvgQ
         NpYAmbuNQVwfl10v9x/KR4ajmdGJRHEHCM41HzhZxqAOQ0NZ5nmtRDauPI/up2BSgqtN
         +cOtUymaNYqKLCPa1pf8o6NovXesMQ/gnAEHBw70+8V0AMLxTFhHMFz6yGFABCL4gbBh
         2AG8Xz1rqvPNRhyhL6WxqXwZJeRepPuzMlSzv+Njh43mJ6OOuUt8A0/iJQo7jc1MGuCP
         ZYLw==
X-Gm-Message-State: AOUpUlHwU9MDNOVkwaXQldkNpP5ndhIgM9MZuo/Ex0DhKU5C4dJhHltu
        NSb2GVO1oy8KouFQPb+kftqbSZxW
X-Google-Smtp-Source: AA+uWPyxSw1gP7LMJDfbNvfpsADZQzyVrMfGa7quE/bJxh/XzZJzhQZjrueOuRqtMaThArlFk0yfjQ==
X-Received: by 2002:a17:902:bf44:: with SMTP id u4-v6mr57026160pls.84.1534992441230;
        Wed, 22 Aug 2018 19:47:21 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id l123-v6sm3529202pgl.82.2018.08.22.19.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 19:47:20 -0700 (PDT)
Date:   Wed, 22 Aug 2018 19:47:19 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] range-diff: update stale summary of --no-dual-color
Message-ID: <20180823024719.GG92374@aiede.svl.corp.google.com>
References: <20180823023955.12980-1-kyle@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823023955.12980-1-kyle@kyleam.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Kyle Meyer wrote:

> 275267937b (range-diff: make dual-color the default mode, 2018-08-13)
> replaced --dual-color with --no-dual-color but left the option's
> summary untouched.  Rewrite the summary to describe --no-dual-color
> rather than dual-color.
>
> Signed-off-by: Kyle Meyer <kyle@kyleam.com>
> ---
>  builtin/range-diff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, good catch!

> diff --git a/builtin/range-diff.c b/builtin/range-diff.c
> index f52d45d9d6..7dc90a5ec3 100644
> --- a/builtin/range-diff.c
> +++ b/builtin/range-diff.c
> @@ -25,7 +25,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
>  		OPT_INTEGER(0, "creation-factor", &creation_factor,
>  			    N_("Percentage by which creation is weighted")),
>  		OPT_BOOL(0, "no-dual-color", &simple_color,
> -			    N_("color both diff and diff-between-diffs")),
> +			    N_("restrict coloring to outer diff markers")),

What is an outer diff marker?

Thanks,
Jonathan
