Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD71E207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 13:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1170768AbdDXNOd (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 09:14:33 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:35185 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1170262AbdDXNOb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 09:14:31 -0400
Received: by mail-io0-f181.google.com with SMTP id r16so185863601ioi.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 06:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pDXCiYcyf+kg8l93aVZjonPukjo8AHp+zyOU5Tsz59E=;
        b=PHqpKqytrG7cRGW6h+WtPweGmu1Mw9bsC088Ow/fdwBigq9maCMNSiKRvYJpukhfrA
         KUTmZminvH3XeZ0BODNTnNfdsmGbzvDAkoXCmwJmVl12/3XD6toSkJaboy/0bQh9VGws
         pyx/UNxmwUe1UTyEt6rg0/huc+p2Mfyx6SxYRZyNkZXhq78rM+QQZCNlPtQ085+uHt50
         YsvVNPvI/Q2v+IDJ8by8ThBMIYdenbONFwz1oGxWrdyx5mk+PtNZAJLMxVB57VAvupyI
         AKoHJDJxk2JgLgS1ZSQEyNRHYnOt1bK81knEjK+ww434a0VM7edybu/LAZbQGOyIMygc
         sRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pDXCiYcyf+kg8l93aVZjonPukjo8AHp+zyOU5Tsz59E=;
        b=DC90GI3+HlgNmGlCO2VQVBhPxJHVKQRbcmzOUYLFg0zhUXU8zK10TOd7KYZ7zcnkx+
         M8b+ynz/fTMkGMU6q1zvchdh9mpkyX608eowFMQAM9VqWE6KlusLcbW7Up/abfBomVE3
         PgaC3gNgYfj3TNe008M2gfMjr2+db+0fmmCR+9ZwyKDrhKmnHpR+GzVYD87DF3xP5hHo
         wvJaf0Qj3cei8GJYirhsof0j8/tvKkuaUyi20FOQDZ+BBjEyhjm7ixNmVjsHlZokoIQh
         gp7PEzu7yK39pKpEImPl2sHOxIfFpLEpPihxLWPlkrlUUeu9L2PGdLxK8PnUZh24qAPN
         7BYQ==
X-Gm-Message-State: AN3rC/4yVqLSQemDRSea3ngwsWpCBE+3Jqmf0lH3KYD3JgF/IFUow32H
        C4AKDvR4URhbb65P1bxqiLQPuqH44g==
X-Received: by 10.157.6.78 with SMTP id 72mr13641997otn.37.1493039665593; Mon,
 24 Apr 2017 06:14:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Mon, 24 Apr 2017 06:13:55 -0700 (PDT)
In-Reply-To: <20170424114919.kvgiybj2cm7xecpp@sigill.intra.peff.net>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de> <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
 <20170424112928.rty5xejep4mnxph2@sigill.intra.peff.net> <20170424114919.kvgiybj2cm7xecpp@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 24 Apr 2017 20:13:55 +0700
Message-ID: <CACsJy8DoK__R5k0+5EVoagc+NiFNd1yjxWxwOS234H-wJ047wg@mail.gmail.com>
Subject: Re: [PATCH 1/5] add SWAP macro
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2017 at 6:49 PM, Jeff King <peff@peff.net> wrote:
> diff --git a/prio-queue.c b/prio-queue.c
> index 17252d231..fc3860fdc 100644
> --- a/prio-queue.c
> +++ b/prio-queue.c
> @@ -21,7 +21,7 @@ void prio_queue_reverse(struct prio_queue *queue)
>
>         if (queue->compare != NULL)
>                 die("BUG: prio_queue_reverse() on non-LIFO queue");
> -       for (i = 0; i <= (j = (queue->nr - 1) - i); i++)
> +       for (i = 0; i < (j = (queue->nr - 1) - i); i++)
>                 swap(queue, i, j);
>  }

FWIW This shuts valgrind-3.10.1 up.
-- 
Duy
