Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F02A1F404
	for <e@80x24.org>; Thu, 23 Aug 2018 22:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeHXBdw (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 21:33:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45887 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbeHXBdw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 21:33:52 -0400
Received: by mail-pl1-f193.google.com with SMTP id j8-v6so164527pll.12
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 15:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f6PozVB5n3eXmSrfcoPkNCJySolgXYt3WMyMwjihTzI=;
        b=B5HxB0u+nJxc6izrAkTWiARfr680tPagIUi0GUQszNiHaBJNhwuCMDnlZ6bFk94oxL
         GQj7yYlQimM1y2ZbtxzdIIiXMcg8bDTWVKkV/Lnt06lzydKIVPeT7vELJ1Bg4ugmAp2A
         gvJ4NZSRzoTk9UrWLUotkjnlKDLSce/6VsaffsxH0mUGkq/goHSjZrkpFcaYfxCh2rF2
         uIsD4TfsqhoVIvwfk8ZAu10n9g7RLvs89GyGkv//rBXXWPw8vXBzFa/seU/33vSsN6V4
         KZ6wPT6PesmtrUjqheIOXPJMt1cQx+zOpAz/KnDRsEpttxwKeqtm6hlThGyFbGRRHtIy
         6yWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f6PozVB5n3eXmSrfcoPkNCJySolgXYt3WMyMwjihTzI=;
        b=BvrV74kdgllC2pc/od+HkqhtSzpXYK41ulbg0dSWDzFq2TOaP/obwjdfnjoZhmA6r8
         zdYJzZjbGGyX4RTS86JQpUWV8xxf4rQeyCFByz+Fjd5Nmlnt3x34Sphie2PKxfHYjX8N
         Ws6w4V+Mq25uIuBzYtYES8OnB08Mro2c0PxLswzDeAzVhwiTd8qvpLKHTcWq26LDs5kK
         /zGTsXDShjWrTVZiz5MvQ5iHnZZbnu7jsln3VBuOx+OtYqrN+BzfvK4OP/GjBuRtls29
         dBwdGBfEfetoLcqDwbUn/IfmLY8UVTwjXAGVbHQe8ps9osu/6MSfSCPUxxZ6uCFxmNQv
         fQ1Q==
X-Gm-Message-State: AOUpUlGM/I67zmLnNAXTupxLlhj3DLIEmVhjhg6KfG9e5lT8U2L16K/j
        dXp/5BSJD+JaNlsrB7wjvi0=
X-Google-Smtp-Source: AA+uWPxd9LWIfpz6XbDMysR9i5Ha4cBFGDmONO0vKHHobt5Mu+9AtXz+AWHqMCKehZhqk+C479EJLw==
X-Received: by 2002:a17:902:b70f:: with SMTP id d15-v6mr52900984pls.53.1535061730179;
        Thu, 23 Aug 2018 15:02:10 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id n4-v6sm7850232pgp.80.2018.08.23.15.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 15:02:09 -0700 (PDT)
Date:   Thu, 23 Aug 2018 15:02:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v3] range-diff: update stale summary of --no-dual-color
Message-ID: <20180823220207.GC99542@aiede.svl.corp.google.com>
References: <20180823211028.GA99542@aiede.svl.corp.google.com>
 <20180823215748.3474-1-kyle@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823215748.3474-1-kyle@kyleam.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer wrote:

> 275267937b (range-diff: make dual-color the default mode, 2018-08-13)
> replaced --dual-color with --no-dual-color but left the option's
> summary untouched.  Rewrite the summary to describe --no-dual-color
> rather than dual-color.
>
> Helped-by: Jonathan Nieder <jrnieder@gmail.com>

Ha, I don't think I deserve much credit here, but I'll take it. ;-)

> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Kyle Meyer <kyle@kyleam.com>
> ---
>  builtin/range-diff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
