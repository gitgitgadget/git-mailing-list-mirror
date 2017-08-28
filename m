Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57B61208DB
	for <e@80x24.org>; Mon, 28 Aug 2017 22:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbdH1Wpb (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 18:45:31 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38828 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751237AbdH1Wpa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 18:45:30 -0400
Received: by mail-qk0-f193.google.com with SMTP id o63so1644906qkb.5
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 15:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wHq/mm5bH7Ir/2hY5cB/1UySXPFgIbi2smvqm9aAV44=;
        b=p5vYnwCLpDUH46QsukfvVruqOj8Ei7GynSz9n8TKVd62PyPoDRGyzNHmeH3R9fOyfD
         2CXLUb5x7vHXyXbAjKBUFPrxB38Rprq2/Ojz601bsXLyU2wwb7IlxLAkAq8E+GRCkVQd
         ivMWfRnnDwabOlrundhbcBf/2HEhH8KqK+6wNWP/sQbWnLeS4MPRen38NYP3wBxI6HXe
         PzT8a9QhPNz0gEriRp9Yw0K6oVMMHA+G5dhg21d0jT8IE51ED8t1dGIORk/ydnButsqT
         behfCRl+jVlNOusWdAkf3ubLLe4MQebuzG/pARDKYn6VJSmLGInbP1IykQyjzdSAne5H
         O9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wHq/mm5bH7Ir/2hY5cB/1UySXPFgIbi2smvqm9aAV44=;
        b=GM6e5tD1K5LLHCCtJhD7oLv8pUKmBFhkVhZ/MDmv3Q1pA4sNBZEQGtO+SjX7RwolAK
         cg4difd6/Omcb3Hqtvmz85N6aW+vbXTjbHiJLD1HwMw/8pnvGrbJBtCflYhIlmYUSjLU
         9YLtEDEHzOpyrOM0kCQuidMD65f9dmSQIledvD9nrVxBf0/66MiliRoh0Z163BhO1LvE
         Om87KnkRB8W8QjXwy1nLU/AHDgE5N+oO+aOobKTOALX3y2dG/Y+fMzRyac6ouj2WFiaj
         +DeqqEe87ohN1BPfa5bXT7tw1jxctKlkfAtEPNEAKowTlhH6E3bKFtXvqZ1CQtZf3Yuo
         EfFg==
X-Gm-Message-State: AHYfb5g9VntsiHm/dmS0EQHuZh/O+3/yKVM8HxtJCyvv3mOvyOo+ko2i
        UApGs3He/6M1xc8iQjQ=
X-Received: by 10.55.155.147 with SMTP id d141mr3132683qke.227.1503960329622;
        Mon, 28 Aug 2017 15:45:29 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id p7sm1043324qkl.53.2017.08.28.15.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Aug 2017 15:45:28 -0700 (PDT)
Subject: Re: [PATCH 2/3] merge-recursive: remove return value from
 get_files_dirs
To:     Kevin Willford <kewillf@microsoft.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
References: <20170828202829.3056-1-kewillf@microsoft.com>
 <20170828202829.3056-3-kewillf@microsoft.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <8f1a7139-6f5b-eb47-ecb6-ded1d550b06a@gmail.com>
Date:   Mon, 28 Aug 2017 18:45:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170828202829.3056-3-kewillf@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/28/2017 4:28 PM, Kevin Willford wrote:
> The return value of the get_files_dirs call is never being used.
> Looking at the history of the file and it was originally only
> being used for debug output statements.  Also when
> read_tree_recursive return value is non zero it is changed to
> zero.  This leads me to believe that it doesn't matter if
> read_tree_recursive gets an error.
> 
> Since the debug output has been removed and the caller isn't
> checking the return value there is no reason to keep calulating
> and returning a value.
> 

Did a quick search and you're right, nothing is using the return value. 
No reason to spend time calculating it.  Looks good.

> Signed-off-by: Kevin Willford <kewillf@microsoft.com>
> ---
>   merge-recursive.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 033d7cd406..d47f40ea81 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -328,15 +328,11 @@ static int save_files_dirs(const unsigned char *sha1,
>   	return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
>   }
>   
> -static int get_files_dirs(struct merge_options *o, struct tree *tree)
> +static void get_files_dirs(struct merge_options *o, struct tree *tree)
>   {
> -	int n;
>   	struct pathspec match_all;
>   	memset(&match_all, 0, sizeof(match_all));
> -	if (read_tree_recursive(tree, "", 0, 0, &match_all, save_files_dirs, o))
> -		return 0;
> -	n = o->current_file_set.nr + o->current_directory_set.nr;
> -	return n;
> +	read_tree_recursive(tree, "", 0, 0, &match_all, save_files_dirs, o);
>   }
>   
>   /*
> 
