Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13E831F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 22:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751635AbdB0Wp2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 17:45:28 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36309 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdB0Wp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 17:45:27 -0500
Received: by mail-pf0-f194.google.com with SMTP id j5so2763491pfb.3
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 14:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jQxe36gNjRyexxWqsWzUXnhNuErwwhHvEykMbThCq84=;
        b=PohgLdoS6wJLK+g7hirdt4aC5VC9xzVtthHrsKwYYStU9cag83v1m+BLC30D04plG6
         viURAYNaZHPZ31bVmyiwL5ZlyRz8tyjRFFCjG/gsfSaLNfELVnUmeA0wkUt4RqgMkYq0
         KwS49fmDL9kmPLo2gDkFwCcFfCyTDpK59tIh7CgO0yyXNtTWNs+7z+31FHzArHtKXlmN
         HRj4dLx/u/nY+cFCQV6tYEJJMToSwSqdOWtM5p2MRNqt5CcAliBmdsuWj7jfRQh5uPHr
         kvRlnPi9YKBPcmwv3fUPq6rFjD2Psj5c2ABx8cPqSPpYZhuOpsMWPjPbywPVwAFRBMT9
         1wPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jQxe36gNjRyexxWqsWzUXnhNuErwwhHvEykMbThCq84=;
        b=FvOc3jedfFBMpnyoG41aVd1cpmnb5bxYPtxEFt0OzDlRcc9vfrsa49Is8+STfWyP3U
         N0QaVxCEmY5t7JafHwrbqtErCIM0LVqwnwpJgDFRv9gzKNvc0qR/HoB6dyc2qp6vM6VZ
         nmJdpV/D7VKLASr6RLJh0SeX0Dccv3bDWNg5DZTR7XQiPlRHibohI8lVFTdGcLHdhO/f
         Cdgnml00i3pHwAXTlnMnyGSz+ScfC8xhbN8+46IvDPWL2enyb4gWk43Hf35QPneJhF61
         70YvQH5NLj/uCb44r2n2cEKSuTm7RcXJ7oh9f5dgHu7JIGqc+Gt0z0PWbqvDBjNK7103
         7qjA==
X-Gm-Message-State: AMke39kHwZOnNeDe7BfOKAfSxM8aCWPGKVOoVJHFvbzD6b/sq7SgSJzqYNAusJWWBbYZZQ==
X-Received: by 10.98.149.80 with SMTP id p77mr22705506pfd.56.1488235030744;
        Mon, 27 Feb 2017 14:37:10 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id m67sm32543295pfj.32.2017.02.27.14.37.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 14:37:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/6] Specify explicitly where we parse timestamps
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
        <12b60c14dad15e3252e314771b3fe369305bbfc5.1488231002.git.johannes.schindelin@gmx.de>
Date:   Mon, 27 Feb 2017 14:37:09 -0800
In-Reply-To: <12b60c14dad15e3252e314771b3fe369305bbfc5.1488231002.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 27 Feb 2017 22:30:32 +0100
        (CET)")
Message-ID: <xmqqwpcbmfai.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Currently, Git's source code represents all timestamps as `unsigned
> long`. In preparation for using `time_t` instead, let's introduce a
> symbol `parse_timestamp` (currently being defined to `strtoul`) where
> appropriate, so that we can later easily switch to use `strtoull()`
> instead.

This definitely is a very good thing to do as a separate step.

> diff --git a/date.c b/date.c
> index a996331f5b3..a8848f6e141 100644
> --- a/date.c
> +++ b/date.c
> ...
> @@ -1066,7 +1066,7 @@ static const char *approxidate_digit(const char *date, struct tm *tm, int *num,
>  				     time_t now)
>  {
>  	char *end;
> -	unsigned long number = strtoul(date, &end, 10);
> +	time_t number = parse_timestamp(date, &end, 10);

This hunk does not belong to this step.  Everybody else in this step
still receives parse_timestamp()'s return value in ulong, not time_t.
I presume that that will happen in the final step 6/6 (which could
be a huge patch that exceeds 100k?)
