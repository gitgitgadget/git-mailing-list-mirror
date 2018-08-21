Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E056E1F954
	for <e@80x24.org>; Tue, 21 Aug 2018 19:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbeHUWZD (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 18:25:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34356 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbeHUWZD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 18:25:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id g33-v6so6698537wrd.1
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 12:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4bXBewPI7gyzyuwAISENplQFR2/yKcCZbJMd/UYll04=;
        b=ooXhjgY3sqie9K8AByV35AWTMl9FwzpHJqQyplUpJLHIK1HSrS8rjxI+tBQ7IGr1iJ
         fWRU7Oj0Qr9G67PdKV0oNjb7XHTrluR9ykvulIIvkbK7CoxIppPeePxtuptu8GfnMeYT
         I+04i8GYpSvt0pG50isPYGSndJ1QHkeNl5NXA6KiIqnYYNe7m+SvMkCPLwG4NFue7oZA
         oT9kwZ22UjXnZSzzadEQW/Me+BclGhHduw9+C21B+pO6GAD6LJfBhf9mR8PkIXGHxc8o
         Utq5gBUuyKNctO7XzWtApvaO+hzkBWujUTUae8XJYaYHHUIywaNlSTPKTTskMRb+Uv6n
         ODfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4bXBewPI7gyzyuwAISENplQFR2/yKcCZbJMd/UYll04=;
        b=QGgwEXCFLKAP3yrFk3tiRIB/VUoCygd3ma5jSdqzIY3PcsQr9ad0+veMhobPCNISOE
         xixULi21vuRbQVHjBK0ie45tmhvXICB/0/hHdWZDKFprPIUMiD5is8XelhGTBEuguYJf
         pOMg+ZVzHNjWg4L9Y3ej9TNrQsZa96ukth0oz8PEVzi6DRWRrU72A8cFo4dSLgsVJ1vf
         XKqGFKsTXG80hQg1tYxxfz7V/QEBO4MOTVtHXHMOdw+5ioouOsGWAEGovnVH56/Efb5W
         1lLAwfnjmeqJHAts5n0bcO/W4dH7bb1tr87uL/LhT8dGfAhPLMHGTRAGzYpUepGeozb4
         84SA==
X-Gm-Message-State: AOUpUlGcYNyjpU+rNOIQr0bo2LZ6zSk7sFPxRDEWrK10IMdc2Jfi7hz+
        SFSgzd4S02ZkKIVBcREPcUetPtKk
X-Google-Smtp-Source: AA+uWPzIUDg7Y9XLssUO5K0/wmjz82KjdelSiWhPPsFeO3mTFtPjdGKyw/JxIYPjIHGeMEL4ak9cQA==
X-Received: by 2002:adf:83c6:: with SMTP id 64-v6mr33482468wre.5.1534878220466;
        Tue, 21 Aug 2018 12:03:40 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r5-v6sm2476355wmc.39.2018.08.21.12.03.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 12:03:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test-tool.h: include git-compat-util.h
References: <20180821184140.GA24165@sigill.intra.peff.net>
Date:   Tue, 21 Aug 2018 12:03:38 -0700
In-Reply-To: <20180821184140.GA24165@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 21 Aug 2018 14:41:40 -0400")
Message-ID: <xmqqsh378rud.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The test-tool programs include "test-tool.h" as their first
> include, which breaks our CodingGuideline of "the first
> include must be git-compat-util.h or an equivalent".
>
> Rather than change them all, let's instead make test-tool.h
> one of those equivalents, just like we do for builtin.h
> (which many of the actual git builtins include first).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Repost, as the original was in a larger thread about includes and didn't
> get any comment.

Thanks.  Will queue.

>
>  t/helper/test-tool.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index e926c416ea..e954e8c522 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -1,6 +1,8 @@
>  #ifndef __TEST_TOOL_H__
>  #define __TEST_TOOL_H__
>  
> +#include "git-compat-util.h"
> +
>  int cmd__chmtime(int argc, const char **argv);
>  int cmd__config(int argc, const char **argv);
>  int cmd__ctype(int argc, const char **argv);
