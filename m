Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A7B91F597
	for <e@80x24.org>; Mon, 30 Jul 2018 18:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbeG3Tqt (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 15:46:49 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37894 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbeG3Tqs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 15:46:48 -0400
Received: by mail-qt0-f196.google.com with SMTP id y19-v6so13096279qto.5
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 11:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OOwm5s5WbBH2gEYj4Z6vK37Ehjd4fyXLb8hGbf8kVWI=;
        b=Cig6u0Xx2X2qoeEF0J//hl0krS7qapghOhjvWxpzsXA4hO7my4xl3Gw5/Bo6zs9lAx
         soSqZGmGNq3BzMa4foZ0IUrNYFJhZR0g26nyJmdXGzfG0UvBHPyaMnPD/4u9yZOzZ/5t
         35xTR/AohFf/eb+MvXUYsHmH09k7DOV2q06GWWirAVnuZNzLH6H66yORFsdLnL/ESyxs
         dEn1n7W9mf7nJc4NDyLViatMLmUsKR8Z1V0S5bXuM3R6A4MWBgr7XG9/DttG5RAN8QTt
         DgRMndeb6MuAk2raZrKmb1yy1lNDMulrpmI4DIFAK0e+28aMMGKmUVyJ5m8tD3tu/43V
         9SWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OOwm5s5WbBH2gEYj4Z6vK37Ehjd4fyXLb8hGbf8kVWI=;
        b=VydUE1XoCQFt7+X8B3zd7F5cWqmVVnBuLmUOTqhUqYk/7gFUzpFWuMK0KDXqWII+x3
         Pj+rg/0owsc4BXTyO6ieDTZv5OMigdv/TG2KY0KsVHePMSVCHyfUP1rLKV0jzTJNbL5X
         z5mcnVfZ1RM5CE4mIjX3Xetrn0kXPGV7Gw02aLpKZmMWNIX9MzqKPyb1U1Fc5ilmIgkC
         TV1PunWDrYOloRXu3B+t8fhfezJw1qYOGAuU1uhTwJCO1X7QPr8owkMkqtB2+TnYkFpK
         FfXmWM/VAkiNXaGLnWNUXXW0yftyHf+fHr+qz99S0BBx/s6Vlonl95FUS5/WwCYMC7/2
         PaQQ==
X-Gm-Message-State: AOUpUlFcLWYuwNAejeqwo5+ZwDHVIjL1k+1C4yhWpL5nof1qzPbuQa31
        0ietcU+1NUOuk6d9ff7r7SbX08DX
X-Google-Smtp-Source: AAOMgpdJSDsFOz2Bx/mitKw6DX+dnmFoS8HVeANsO16S3xBnf0GuESSjwlHsMlACnxROSFG5SxvHXQ==
X-Received: by 2002:ac8:710f:: with SMTP id z15-v6mr17005906qto.387.1532974236297;
        Mon, 30 Jul 2018 11:10:36 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id h68-v6sm7478794qkc.97.2018.07.30.11.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 11:10:35 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] Speed up unpack_trees()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        peff@peff.net
References: <20180727154241.GA21288@duynguyen.home>
 <20180729103306.16403-1-pclouds@gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <9a9a309c-7143-e642-cfd8-6df76e77995a@gmail.com>
Date:   Mon, 30 Jul 2018 14:10:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180729103306.16403-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/29/2018 6:33 AM, Nguyễn Thái Ngọc Duy wrote:
> This series speeds up unpack_trees() a bit by using cache-tree.
> unpack-trees could bit split in three big parts
> 
> - the actual tree unpacking and running n-way merging
> - update worktree, which could be expensive depending on how much I/O
>    is involved
> - repair cache-tree
> 
> This series focuses on the first part alone and could give 700%
> speedup (best case possible scenario, real life ones probably not that
> impressive).
> 
> It also shows that the reparing cache-tree is kinda expensive. I have
> an idea of reusing cache-tree from the original index, but I'll leave
> that to Ben or others to try out and see if it helps at all.
> 
> v2 fixes the comments from Junio, adds more performance tracing and
> reduces the cost of adding index entries.
> 
> Nguyễn Thái Ngọc Duy (4):
>    unpack-trees.c: add performance tracing
>    unpack-trees: optimize walking same trees with cache-tree
>    unpack-trees: reduce malloc in cache-tree walk
>    unpack-trees: cheaper index update when walking by cache-tree
> 
>   cache-tree.c   |   2 +
>   cache.h        |   1 +
>   read-cache.c   |   3 +-
>   unpack-trees.c | 161 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   unpack-trees.h |   1 +
>   5 files changed, 166 insertions(+), 2 deletions(-)
> 

I ran "git checkout" on a large repo and averaged the results of 3 runs. 
  This clearly demonstrates the benefit of the optimized unpack_trees() 
as even the final "diff-index" is essentially a 3rd call to unpack_trees().

baseline	new	
----------------------------------------------------------------------
0.535510167	0.556558733	s: read cache .git/index
0.3057373	0.3147105	s: initialize name hash
0.0184082	0.023558433	s: preload index
0.086910967	0.089085967	s: refresh index
7.889590767	2.191554433	s: unpack trees
0.120760833	0.131941267	s: update worktree after a merge
2.2583504	2.572663167	s: repair cache-tree
0.8916137	0.959495233	s: write index, changed mask = 28
3.405199233	0.2710663	s: unpack trees
0.000999667	0.0021554	s: update worktree after a merge
3.4063306	0.273318333	s: diff-index
16.9524923	9.462943133	s: git command: 
'c:\git-sdk-64\usr\src\git\git.exe' checkout

The first call to unpack_trees() saves 72%
The 2nd and 3rd call save 92%
Total time savings for the entire command was 44%

In the performance game of whack-a-mole, that call to repair cache-tree 
is now looking quite expensive...

Ben
