Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94F9E1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 05:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbeHOISs (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 04:18:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41520 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeHOISs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 04:18:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id y10-v6so69461pfn.8
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 22:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OKxffVI2NpSGknidO3sFTGRhc7//7Xi5eejT3Z++6As=;
        b=XSDfpLJDDQFgmpHAZztV46u/rZCVNTmwJo0zdgdAV7gETFQFl9ap9S1vcWOvkJxqF4
         xaRkyiB11pQtlKGQGXkt8TJZBMv9dWPWMU3Wk4D7SFoOKO8Roh862GlEKGMlXnz4mehn
         HkrbhvjMwBT/Tq9uOuf5Q3PXKoQxxXmuuoRrgX6Ui7PnOHu1slda067Zfj267ZhDhKkT
         ZMzVwG9oQO9J4wP0oJ0DClc6T/HIwRpcNLAoPo9ICNvhbxKC2Fc0QBsetZuxt9sW2M0A
         PAUP30oSPOtMNyaRgv5c1hcBxFfD6GM31LJ5R7XQOzhpNfy+tsdHlv7E/pGKDiqw1FUw
         VjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OKxffVI2NpSGknidO3sFTGRhc7//7Xi5eejT3Z++6As=;
        b=SmTZ91pAufe1qRs4tbKTLFfdpMl1ITcC2GcGz/B6qsGB2OWvtwuY7sIxjOQlo1AB6X
         hURF+yWflHaWG+mJAbBhhPG3xi/63RJoxcs2v7J1K+yVKRpuQ73nyxDdQPksPWI1ah0S
         JZABGeCDWdVfUdare/yZ9zPKat1VbGDcvo5sj49tjDQ9GgTirVZi81SERrY0alpoRPdZ
         lAUOgKTAj0V1TQK1fe0mj7qjv+7ZX96HFW0jRs+j8p0OHlxDxmnOhAF62Byg09JiiNQb
         HTWvnmcUdkAI0DND4Ai328wCYvxWhfgfPuJms1UsQkjn1IlAdRmUIK+MooGXiLfYgApq
         ufbQ==
X-Gm-Message-State: AOUpUlHnok9+ITBL/c1gMCJyqA0TAZ2AOU1rAlyGqRslt0BezGg2FXAc
        RpNCdIXEnKOLARHzKDjCsd44lZgQ
X-Google-Smtp-Source: AA+uWPwb15rbjsXWMqWIgxGQydN8SvXXGSzNGu+LWKqeyeWbD2DbbEXnM+TALZxE/IwRaT3ggxVkoA==
X-Received: by 2002:a63:81c3:: with SMTP id t186-v6mr24208527pgd.413.1534310889402;
        Tue, 14 Aug 2018 22:28:09 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d19-v6sm69743370pfe.42.2018.08.14.22.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 22:28:09 -0700 (PDT)
Date:   Tue, 14 Aug 2018 22:28:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com
Subject: Re: [PATCHv3 5/6] compat/precompose_utf8.h: use more common include
 guard style
Message-ID: <20180815052807.GG32543@aiede.svl.corp.google.com>
References: <20180811205024.11291-1-newren@gmail.com>
 <20180813171749.10481-1-newren@gmail.com>
 <20180813171749.10481-6-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813171749.10481-6-newren@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  compat/precompose_utf8.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

The more unusual style is less likely to be recognized by compilers, so
we can waste some I/O re-reading the header at compile time.

> --- a/compat/precompose_utf8.h
> +++ b/compat/precompose_utf8.h
> @@ -1,4 +1,6 @@
>  #ifndef PRECOMPOSE_UNICODE_H
> +#define PRECOMPOSE_UNICODE_H
> +
>  #include <sys/stat.h>
>  #include <sys/types.h>
>  #include <dirent.h>

Not about this patch: these headers are #include-d in git-compat-util.h
which we assume to be already included first before anything else.  Can
we remove these redundant #includes?
