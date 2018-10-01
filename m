Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC3DC1F453
	for <e@80x24.org>; Mon,  1 Oct 2018 15:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbeJAVtB (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 17:49:01 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36980 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbeJAVtB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 17:49:01 -0400
Received: by mail-it1-f195.google.com with SMTP id m9-v6so11913510ita.2
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 08:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HWuyxlgAGUFWvzj4p/l0+nsSPuEcgpvGHOcktOMJa6g=;
        b=H5rHNoXGkZU1oqSadtOEepoBq5YxNDzLxyirkFAPx5jKcST2cv9lj++J+ci4+SCFxH
         GdwRCW90Go6tsxuQuov0caQA0MqhNvZQoGRPXGahFjtMTU5CqfnODYeZ1VQsIXE9S5Zu
         KmMkP4ccQBodEzugxocIVWhpSWUdt8RGBGpSJV1dkTwxmYY6xV9m5DtiIMEcE1U7EXgm
         sv/2HS/Z6QpmpBkZCevvA0i0oFpk1ApLMudAsGHppjbbl7eZEdYYykMFgpZR+tggAvjD
         GRIY5aeT2p/EIhFgzfMyxfF2kLzsqyBNctjVLO062MN/e/IMDxbk6oGSyPndqWUO8/8F
         zpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HWuyxlgAGUFWvzj4p/l0+nsSPuEcgpvGHOcktOMJa6g=;
        b=DIc+a554wpB9rWPJEPQWC3a+ch19d+77hfdMwkWyeMM5M+McS+ZSW4WaNHRB4txc00
         sdRoIHfNveI7/mshfGy4BweVp1uCOVphcC6q+jtft3JJvgslFdneFuuaPVUUrQBEvXxJ
         yLgpHJiLdcmSlU5rx6MbHtU29SvdrEVHJ8QmD1SLYdTSjucwqCU0NaFTpBa6WmwQjpIw
         6EMH8OcDTippvrQlDcxEoIiB+RJRQtIekYKJmSK5mPKx2MSpvXQm53cqVXIkQSZf9AhF
         HC5FOj0FOPCnOaM7YZ0AH0/13ibL3A5l8foSxoM7sn7MBtdyEi5AWN1I5ftLuh47Tqx2
         jiqQ==
X-Gm-Message-State: ABuFfohZsksJZVzHIU3woGtEe4OSKM8ZbdlXry3YjAKh0xMrwafIV7+H
        jrgE5n6arRpdDdeX38sb9oeN6Tf9D6jfkB/u3yo=
X-Google-Smtp-Source: ACcGV61bwrMl3uzG54/N/l61slwCmBF95SJl9cQnxQQSZJjfAMG9QO/9FsN1W4FXtN4vP0ezptV2NyoA/9cAzYIh/74=
X-Received: by 2002:a02:940a:: with SMTP id a10-v6mr8084456jai.94.1538406645418;
 Mon, 01 Oct 2018 08:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181001134556.33232-1-peartben@gmail.com> <20181001134556.33232-3-peartben@gmail.com>
In-Reply-To: <20181001134556.33232-3-peartben@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 1 Oct 2018 17:10:18 +0200
Message-ID: <CACsJy8DRLPmrGD1podPJ12G3VitsK3dQnq+2sOjCiQj6N4ayTQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] read-cache: clean up casting and byte decoding
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 1, 2018 at 3:46 PM Ben Peart <peartben@gmail.com> wrote:
>
> From: Ben Peart <benpeart@microsoft.com>
>
> This patch does a clean up pass to minimize the casting required to work
> with the memory mapped index (mmap).
>
> It also makes the decoding of network byte order more consistent by using
> get_be32() where possible.
>
> Signed-off-by: Ben Peart <peartben@gmail.com>
> ---
>  read-cache.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 583a4fb1f8..6ba99e2c96 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1650,7 +1650,7 @@ int verify_index_checksum;
>  /* Allow fsck to force verification of the cache entry order. */
>  int verify_ce_order;
>
> -static int verify_hdr(struct cache_header *hdr, unsigned long size)
> +static int verify_hdr(const struct cache_header *hdr, unsigned long size)

OK more constness. Good.

>  {
>         git_hash_ctx c;
>         unsigned char hash[GIT_MAX_RAWSZ];
> @@ -1674,7 +1674,7 @@ static int verify_hdr(struct cache_header *hdr, unsigned long size)
>  }
>
>  static int read_index_extension(struct index_state *istate,
> -                               const char *ext, void *data, unsigned long sz)
> +                               const char *ext, const char *data, unsigned long sz)

But it's not clear why you need to change the data type from void * to
char * here. I guess all the consumer functions take 'const char *'
anyway, so it's best to use 'const char *'?

Not worth a reroll (to give a reason why you do this in the commit
message), unless there are other changes.
-- 
Duy
