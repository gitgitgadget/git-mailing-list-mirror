Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3DBE1F462
	for <e@80x24.org>; Fri, 24 May 2019 00:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388695AbfEXAzU (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 20:55:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38523 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388065AbfEXAzU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 20:55:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id b76so4211432pfb.5
        for <git@vger.kernel.org>; Thu, 23 May 2019 17:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PiRpH0kpfjYfs+KvxiT8VEMJ7Up9qAZx0huu9LR+4Zw=;
        b=b7Hlr7/gPo7T5txo1Spd4ahznZVypSEMXtU6iLZxdqlzEBVOv7zz7/QzK3WC3pnz0k
         QAwvof4QopQdEl2ADrV2LetJLl5eAwjF8pfDk3djFwZZbYev/nVkcVu/4SwvTGAntvOV
         xnMj7AdD0mNijL9ktRRfUBl2rUP0SpenmyCatbxjNzUrDo8I/JnYCSxhXuudJE8SHv0e
         VS7qb0mOsdcIMqf73TKl+K9xA8JMOemUAfLanJ8DCM8t4ZK2eRCMIGRsAIuGQev+TaD2
         YhHHcJqYwDmw1DyKhmfsuAApmToguNk2gRm0D+792khK9iqIENQNvbIe6lzsK5FfJE5Y
         q/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PiRpH0kpfjYfs+KvxiT8VEMJ7Up9qAZx0huu9LR+4Zw=;
        b=L6NXQJW/BOBcT3YX6zzRhydXQ2BtFo5MGP0kWwV3hvr5hytPTbZ8FzVM8E3YY8tlmX
         3owjnuIGSD9VQg7r3HUHDvfpJ2l2UawG2GXB0DYc2y/DHJPvySDnYM4koT0vq2EcCVmn
         zD5w5Mw3H8uTgGU2lymaiH/V73Mjy67MVNne4woTxnEH5uk68cyzKt6Pj3g5KpdY1wuo
         OepPPU1uw+TgWoAy8/3F8RzqT1OjniGaT+f84mOv2/OiEG/qKEXl6GOeEqwBXBkPjjWH
         GDIyCTMXbUtvRiBJWCTmSP0pdVlqNcx7dPx4UGDKf8Q0XCRaWMmdXQ2a2vKlpvWSjEfL
         BYlw==
X-Gm-Message-State: APjAAAXYkEDE0UvDqFFQsuKua6BHkO+oUrt/gJphOARFMKAYRZYVtieR
        iGh8ZIbmqk4c+cf9W+KdRmg2AQ==
X-Google-Smtp-Source: APXvYqxxc0wjAA5hTOgPQj97Ssr0O1ZbjaFsef0Dc43VyhAMCOrRlrakmZibcL8wTEB4wdpnGRYupA==
X-Received: by 2002:aa7:9dc9:: with SMTP id g9mr71905889pfq.228.1558659318651;
        Thu, 23 May 2019 17:55:18 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id a30sm528632pje.4.2019.05.23.17.55.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 17:55:17 -0700 (PDT)
Date:   Thu, 23 May 2019 17:55:12 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     jonathantanmy@google.com, jrn@google.com, git@vger.kernel.org,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, matvore@comcast.net
Subject: Re: [PATCH v1 2/5] list-objects-filter-options: error is localizeable
Message-ID: <20190524005512.GC46998@google.com>
References: <cover.1558484115.git.matvore@google.com>
 <6f4da02d494323e3ca946b4b20bf78d9dee419e4.1558484115.git.matvore@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f4da02d494323e3ca946b4b20bf78d9dee419e4.1558484115.git.matvore@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 21, 2019 at 05:21:51PM -0700, Matthew DeVore wrote:
> The "invalid filter-spec" message is user-facing and not a BUG, so make
> it localizeable.

What does it look like? Is it human-readable in its current form? I ask
because (without having looked ahead) I think you're going to move it
from a BUG to a user-facing error in a later patchset (which I don't
think the commit message reflects well). If I'm wrong, and today it's a
possibly user-facing string, then I think this patch could stand on its
own outside of this patchset, which would probably save you some effort
keeping a simple change in limbo for a long time. But if I'm right, I
think the commit message could use some work.

 - Emily

> 
> Signed-off-by: Matthew DeVore <matvore@google.com>
> ---
>  list-objects-filter-options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> index c0036f7378..e46ea467bc 100644
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -81,21 +81,21 @@ static int gently_parse_list_objects_filter(
>  		filter_options->choice = LOFC_SPARSE_PATH;
>  		filter_options->sparse_path_value = strdup(v0);
>  		return 0;
>  	}
>  	/*
>  	 * Please update _git_fetch() in git-completion.bash when you
>  	 * add new filters
>  	 */
>  
>  	if (errbuf)
> -		strbuf_addf(errbuf, "invalid filter-spec '%s'", arg);
> +		strbuf_addf(errbuf, _("invalid filter-spec '%s'"), arg);
>  
>  	memset(filter_options, 0, sizeof(*filter_options));
>  	return 1;
>  }
>  
>  int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
>  			      const char *arg)
>  {
>  	struct strbuf buf = STRBUF_INIT;
>  	if (gently_parse_list_objects_filter(filter_options, arg, &buf))
> -- 
> 2.21.0
> 
