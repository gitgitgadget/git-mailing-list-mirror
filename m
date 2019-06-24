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
	by dcvr.yhbt.net (Postfix) with ESMTP id CDE5B1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 14:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfFXOUE (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 10:20:04 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46041 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfFXOUD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 10:20:03 -0400
Received: by mail-qt1-f195.google.com with SMTP id j19so14591515qtr.12
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 07:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hchgvqS7AThPm2SNib8NL92wloya77eLQWDYqhX8Nz0=;
        b=KT+kxlAIABcopg1SZV2Dkco2UstHphtrop+Ar4D62T9V/LuLRl7SrrqtYXC2HMfnoz
         CjwYG547ytLWVP8Md5Sh/2t2w43GrmDNrouiyOwOybzz+UyAYWyD2IhuP/BDK3IMCvb9
         VkESNQ3jbXZU0McUZNcKBZessbCzmDnv1NY2BGQf3PDeC/oU3XbX47e9ZKf1llCbc6iy
         N9W0LITGlKgEtWdPc9yvj1rQqFXaOw6kt1VDDUrltS8GReP8PiBsZe0+Q0n/iwFyywON
         NZ3xJCx4YXVKLhetEv5wrqFo5TswKW80hgpndV0+meuasPCIU7QuRa6te/33xjaUueAA
         5a9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hchgvqS7AThPm2SNib8NL92wloya77eLQWDYqhX8Nz0=;
        b=tWzx0CTUA3hqjwbC/aJpSbudS1iCSSopCr8TAZp4fKuOPjZWHq+9x+iWo1+iGtNurf
         RJ1qcqVnX17WkuGI3zLQfMerOdpSQ3Eu2MkM7gpo8xdsIyLagZft8fdFuTiRf025YLP3
         pUg5vVnuNXehMZYG0e12dCKj8UrTp2yMhMq97EEW9Fv0cfgv3m/fgE5sSWCLVVPrruyT
         l2rtChPanPepY9DmjXEOBHcL3bCIj7IxQpZs7975GHf8gJ/smYj3+OnW+0YvqlvTqX/n
         2SWrj79RqFlQWdjo0OjJrmT39d4Fa5yFOGlXEaOk0S5Aa3U3TciMgUAKHFy//cZJcd3W
         7peQ==
X-Gm-Message-State: APjAAAXqWH9RG+maa4KEWVSwXax3ehD+MXU0VYpKSXkqcE9nv4680mMo
        rRyB9HtX+3XIh9TyJfCFz3RH8RUh
X-Google-Smtp-Source: APXvYqxwiQe/ajNHqN+X4erwVgZK60rusJOnhel7FJb9QRBU21KL83083046S/DcQlHup/Nd1EgIow==
X-Received: by 2002:a0c:87ec:: with SMTP id 41mr47747045qvk.196.1561386002619;
        Mon, 24 Jun 2019 07:20:02 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:bd0b:1518:483a:73eb? ([2001:4898:a800:1010:6e41:1518:483a:73eb])
        by smtp.gmail.com with ESMTPSA id t8sm7646199qtc.80.2019.06.24.07.20.01
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 07:20:01 -0700 (PDT)
Subject: Re: [PATCH 3/6] tree-walk.c: remove the_repo from get_tree_entry()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20190624095533.22162-1-pclouds@gmail.com>
 <20190624095533.22162-4-pclouds@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0f13008e-bdf1-70cb-c4ff-e4c572cd5703@gmail.com>
Date:   Mon, 24 Jun 2019 10:20:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190624095533.22162-4-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/24/2019 5:55 AM, Nguyễn Thái Ngọc Duy wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  archive.c              |  4 +++-
>  blame.c                |  4 ++--
>  builtin/rm.c           |  2 +-
>  builtin/update-index.c |  2 +-
>  line-log.c             |  7 ++++---
>  match-trees.c          |  6 +++---
>  merge-recursive.c      |  8 +++++---
>  notes.c                |  2 +-
>  sha1-name.c            |  9 +++++----
>  tree-walk.c            | 18 ++++++++++++------
>  tree-walk.h            |  2 +-
>  11 files changed, 38 insertions(+), 26 deletions(-)
> 
> diff --git a/archive.c b/archive.c
> index 53141c1f0e..a8da0fcc4f 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -418,7 +418,9 @@ static void parse_treeish_arg(const char **argv,
>  		unsigned short mode;
>  		int err;
>  
> -		err = get_tree_entry(&tree->object.oid, prefix, &tree_oid,
> +		err = get_tree_entry(ar_args->repo,

If I'm reading this correctly, this is a place where we previously converted
to using a custom repository pointer but this function boundary reverted us
to the_repository anyway. I know we have some tests around the commit-graph
that ensures it works with an arbitrary repository (and I frequently stumble
over them when I add new dependencies). How can we add more testing around
these new conversions?

The rest looks straight-forward.

Thanks,
-Stolee

