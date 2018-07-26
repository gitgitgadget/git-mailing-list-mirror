Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AC0C208E8
	for <e@80x24.org>; Thu, 26 Jul 2018 00:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbeGZB6Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 21:58:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37731 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbeGZB6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 21:58:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id n7-v6so6378021pgq.4
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 17:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jNyiX3ciB+wUrDwOBi6lCg1/LIoD9Bt82EOo+I2jCss=;
        b=Yuj27PEj750cuhYquxLrhW5TNlxYRRMxTuqJswb+n5AoijM/ZOyISClF2SR5B2Fo1A
         cg96hmi44mgWzMd9pY9PRnVNgXq9Q/1+xBUk9tba8oVQQ+BRCs+zNPeAzF2qZDY0cV3U
         bcnh20H60b/oCyFimhSvP8Hw2arldjalFENRmy0AsT735GGRlQOzz0Aa2EgPLs8/Bek5
         roWoCE8fK5TveBODbdOOxm79BVrhhpnIyGTOw+Hsit+S1RfwEgm/Ab4ac+HSU1FMYcdM
         bU4uN4OxxwSsr8IWhqDeIXtRH/JeUsdOmhH60220Pbmcn7qdrV9k9kF7rDo/oWPk4cdo
         mKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jNyiX3ciB+wUrDwOBi6lCg1/LIoD9Bt82EOo+I2jCss=;
        b=n2aLcnzqP913F9n3Gd8j5CxcTQJYiFcrP7UtQoZqk3xEIQQjQrZcVF14Abutxyd/AK
         uvsah1Sc7v7bnNbgaLYrqh4Jzygz6eAeDzMYfFwuqwJ527V89iEsfqqazeL/hJ2m3o4H
         WXxBnAnV+txXObZmzmcWn9Yt6PTfP0KJAZRZQ6L6bbTMoGOTVYLPepVLttqmbgnBP5l6
         ETb6+Qr13DLQDX5EKlGsyFZvgXwlcTFMKBxLdR15mTjdOTAKEzZiY8nDkm+EGM5lK9+S
         q0liOPGi8rTqp803WTWTdA30Gc+msDWhi01sZkglewLOeV+a313I/QwCbdPGQlP0/fbt
         kQuA==
X-Gm-Message-State: AOUpUlHV6po6ZeCnl+pU5p2qCyfTaDZhCFydQgb+dJBHuucCgaUpRje+
        nD41yaQbxl0bqwuASzQyC4oZW4Bc
X-Google-Smtp-Source: AAOMgpfmlp3+J9KMsC5dvqx+QZsAW+UGEh7lygvEYcQhc5k671B3bmT0J99q8AC79KgpBIk3bgy7Bg==
X-Received: by 2002:a62:4a41:: with SMTP id x62-v6mr24399780pfa.45.1532565852243;
        Wed, 25 Jul 2018 17:44:12 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id i20-v6sm26057078pfj.82.2018.07.25.17.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 17:44:11 -0700 (PDT)
Date:   Wed, 25 Jul 2018 17:44:00 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] packfile: ensure that enum object_type is defined
Message-ID: <20180726004400.GA217613@aiede.svl.corp.google.com>
References: <20180725215607.19910-1-dev+git@drbeat.li>
 <20180725215607.19910-2-dev+git@drbeat.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725215607.19910-2-dev+git@drbeat.li>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli wrote:

> When compiling under Apple LLVM version 9.1.0 (clang-902.0.39.2) with
> "make DEVELOPER=1 DEVOPTS=pedantic", the compiler says
>
>     error: redeclaration of already-defined enum 'object_type' is a GNU
>     extension [-Werror,-Wgnu-redeclared-enum]
>
> According to https://en.cppreference.com/w/c/language/declarations
> (section "Redeclaration"), a repeated declaration after the definition
> is only legal for structs and unions, but not for enums.
>
> Drop the belated declaration of enum object_type and include cache.h
> instead to make sure the enum is defined.
>
> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  packfile.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks!  I had run into this using clang on Linux, too, but hadn't
spent the time to track it down and write a patch.

Running

	git grep -e 'enum [^ ]*;'

doesn't find any other instances of this error.  Thanks for fixing it.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

By the way, not about this patch:

[...]
> +++ b/packfile.h
> @@ -1,12 +1,12 @@
>  #ifndef PACKFILE_H
>  #define PACKFILE_H
>  
> +#include "cache.h"
>  #include "oidset.h"
>  
>  /* in object-store.h */
>  struct packed_git;
>  struct object_info;
> -enum object_type;

This '/* in object-store.h */' comment can easily go stale since
nothing enforces that it stays accurate.  I don't think it's a useful
comment to have anyway, since it's straightforward to grep for where
the struct is defined.  I think we should remove the comment.

Thanks,
Jonathan
