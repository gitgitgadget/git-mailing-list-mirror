Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D59C01F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 15:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfJUPEd (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 11:04:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52819 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfJUPEd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 11:04:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id r19so13742662wmh.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 08:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tc28T7fly7SNBtCYNfD3tfBuIfg4oBBe/1aX4pX/Z7Q=;
        b=gNIuTrv9a/+q/dPsGxcTFzCYAujfeGwQzfxMbskgdwSgKy2srep5BF+cgIpq45PKbJ
         5UFgNykVXdFNcor6s9UflGkJYuiqn7ZE/DonxYK9TI/LShm00Xia4pgtr0lmm/OVfrkf
         ftD8CdQu+x6e+bQxH6ckurPNfaRX8iU3FuyuwRJy7KMn0pr7/gck2guK4fi3wzew1NhS
         dD/au9yWiwdaNe/7vNpHCpmOLOOT/n2r0Domx4o8jjlvwrtXWlb4MvuoCRoeUbYVo9R/
         UjbhgTzfiSfpcwL213tnYrbUCyVw0o9AjX7j3uukhhlu5+AWxrcQ/CFdrIqeLeGgbJQ+
         l0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tc28T7fly7SNBtCYNfD3tfBuIfg4oBBe/1aX4pX/Z7Q=;
        b=bqon63zqmqFNHlqF3TXd/P8QX7iPS8tX1jUB/HiThKYfuQe8LKExYDB6gRxLjx0v2r
         2q7tIlFcjbxeEGHkir8Xg+burmlj9RLuNGYGNOqxb+wcnzWv8RTBomiuXJExhOel7BdQ
         9Ui5H+qRatP3ESWcve8Pntts4UldUDC/YKO1Vcbbp4RDVVobl6S3z8fHw9IOldZFzgEs
         yZGHmC2ZJdCcKPxKABfx4tkNtA8OCXylCo1t+zXCJuNjoZ3h0ysR/KCkH/lVFN0PS+uD
         Ho7XbtPZLLnVgA37Wb6z3mjyzu0bIel+qolxybvOnzU++h2ma1JthokYcZfLSoa/NL+y
         sRqw==
X-Gm-Message-State: APjAAAWRzT4CGU4AsYTjNjhXzHWh1OMp2giVYwEIZ/kCUOz1EPf/j7Me
        WP9iHTWLbxNYvIUk6/ZxlxGPVG5g
X-Google-Smtp-Source: APXvYqxiDfkJaAvvYAD1Zi/q4x6X6eAOCLfp0091NxdWJ4Y/KLuOJRWJj0armC7BMOFDurr4vqriUQ==
X-Received: by 2002:a1c:a842:: with SMTP id r63mr3816592wme.23.1571670269365;
        Mon, 21 Oct 2019 08:04:29 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-28-119.as13285.net. [92.22.28.119])
        by smtp.gmail.com with ESMTPSA id u1sm25249494wru.90.2019.10.21.08.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 08:04:26 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 13/17] read-tree: show progress by default
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <a229e1ee0cb96c5f8c2c5d430641c386bc082a2d.1571666187.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <3de0f590-c75c-2470-232f-73a07876df88@gmail.com>
Date:   Mon, 21 Oct 2019 16:04:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <a229e1ee0cb96c5f8c2c5d430641c386bc082a2d.1571666187.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 21/10/2019 14:56, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The read-tree builtin has a --verbose option that signals to show
> progress and other data while updating the index. Update this to
> be on by default when stderr is a terminal window.
> 
> This will help tools like 'git sparse-checkout' to automatically
> benefit from progress indicators when a user runs these commands.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>   builtin/read-tree.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
> index ca5e655d2f..69963d83dc 100644
> --- a/builtin/read-tree.c
> +++ b/builtin/read-tree.c
> @@ -162,6 +162,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
>   	opts.head_idx = -1;
>   	opts.src_index = &the_index;
>   	opts.dst_index = &the_index;
> +	opts.verbose_update = isatty(2);

I'm slightly wary of changing the output of plumbing commands like this. 
If a script wants progress output it can already get it by passing 
--verbose. With this change a script that does not want that output now 
has to pass --no-verbose. If 'git sparse-checkout' wants progress 
indicators why not put the isatty() check there and pass the appropriate 
option to read-tree?

Best Wishes

Phillip

>   	git_config(git_read_tree_config, NULL);
>   
> 
