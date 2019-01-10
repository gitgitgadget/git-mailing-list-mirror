Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E32931F803
	for <e@80x24.org>; Thu, 10 Jan 2019 20:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfAJUFI (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 15:05:08 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:40518 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbfAJUFI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 15:05:08 -0500
Received: by mail-wm1-f45.google.com with SMTP id f188so245975wmf.5
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 12:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xjepAdtMKry319lwpaUfI6NvAfMMmgE9u7Ek3ORWCOw=;
        b=PQt1qT8ZeJg1ndbR43vGcfBawMQxWbWPSU3jmQAuC6Spwlgre43rYOhC+3lmbUeC4u
         nUT9PUz04I8U3Y5o9zLwPxbhjf9Z2GM3swdGJWsbLzjyo+dWCH/2efdnrBoGKpw5j4yC
         7ZVKRHrGzXhIBBzUcXOcQKvvhaWCnTXh3FPFgudFv5leJuxdkyuHMHbq0GehnFFxYN3q
         jFu5boTjes0kcg4rWhkFcfL0nnzpHzPJtPACVQHrQsWI8sLbuYd3eenyezED3GTjouyF
         J2mp1yY5kfHLoft13ZqcX4A9KPjNSzWK9HwMSskKbeOX5ew9PvwojFa8zbrBqWNHh5G8
         idog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xjepAdtMKry319lwpaUfI6NvAfMMmgE9u7Ek3ORWCOw=;
        b=sgLSkgdL0q0OyDQ42jwiczFd5pWumkuL9nE3Ti8+8bP1OHejQXom2IfjLmsjd8+IQh
         qk85saL6D+zmkb+Hwv77W4wYZZvBqh5daIuTwElo5tZFH9Ql2MGr6jswEBEVDaBBI5zV
         r9KKK//h7yl4EXk8S2V1oRuqitxHugQql6mK4cEFc/vPeCcugfD/cbsHt/mAFgron0wq
         ACwjvDiMZ0r+01B/xHAdpiZoOLHhxWVewfHhnv7L+QiXUd+0n6cXhuD3iwN6TxoZMIeL
         LxY02NbQ3QAq7FjA3r92qPPfd1/9qIhwQU3cuDn7D+p+qVvsovk3JlJ2VjB1WQHkr6oj
         Indw==
X-Gm-Message-State: AJcUukdYbVoxF4GAX8XLEqDdc9EQ+s1nB1kCkGBfgdo+k3tvJdKEp0M/
        jdU2/TjrImAJ0HRlm0GTSe4=
X-Google-Smtp-Source: ALg8bN7tPGJZytsoiHsL6zhnZVaxRA39LcPZCiVZsGco8P2SWJSLcREnPqTGZDl3xnyfqFyBDg5d9w==
X-Received: by 2002:a1c:e715:: with SMTP id e21mr180222wmh.101.1547150707067;
        Thu, 10 Jan 2019 12:05:07 -0800 (PST)
Received: from szeder.dev (x4d0cf90e.dyn.telefonica.de. [77.12.249.14])
        by smtp.gmail.com with ESMTPSA id w6sm17630709wme.46.2019.01.10.12.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 12:05:05 -0800 (PST)
Date:   Thu, 10 Jan 2019 21:05:03 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Sun Chao <sunchao9@huawei.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v5 4/5] pack-redundant: consistent sort method
Message-ID: <20190110200503.GM4673@szeder.dev>
References: <20190109164731.GJ4673@szeder.dev>
 <20190110120142.22271-5-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190110120142.22271-5-worldhello.net@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 10, 2019 at 08:01:41PM +0800, Jiang Xin wrote:
> diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
> index 56591d283f..e9d2586e2e 100644
> --- a/builtin/pack-redundant.c
> +++ b/builtin/pack-redundant.c

> @@ -421,16 +422,22 @@ static inline off_t pack_set_bytecount(struct pack_list *pl)
>  	return ret;
>  }
>  
> -static int cmp_pack_list_reverse(const void *a, const void *b)
> +static int cmp_remaining_objects(const void *a, const void *b)
>  {
>  	struct pack_list *pl_a = *((struct pack_list **)a);
>  	struct pack_list *pl_b = *((struct pack_list **)b);
> -	size_t sz_a = pl_a->remaining_objects->size;
> -	size_t sz_b = pl_b->remaining_objects->size;
>  
> -	if (sz_a == sz_b)
> -		return 0;
> -	else if (sz_a < sz_b)
> +	/* if have the same remaining_objects, big pack first */
> +	if (pl_a->remaining_objects->size == pl_b->remaining_objects->size)
> +		if (pl_a->all_objects_size == pl_b->all_objects_size)
> +			return 0;
> +		else if (pl_a->all_objects_size < pl_b->all_objects_size)
> +			return 1;
> +		else
> +			return -1;

My compiler complains about the above nested if statements:

  builtin/pack-redundant.c: In function ‘cmp_remaining_objects’:
  builtin/pack-redundant.c:345:5: error: suggest explicit braces to avoid ambiguous ‘else’ [-Werror=parentheses]
    if (pl_a->remaining_objects->size == pl_b->remaining_objects->size)
       ^
  cc1: all warnings being treated as errors
  Makefile:2302: recipe for target 'builtin/pack-redundant.o' failed

After adding a pair of {} to the outer if statement
't5323-pack-redundant.sh' passed successfully even on macOS (on Travis
CI).

