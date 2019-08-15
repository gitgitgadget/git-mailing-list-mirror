Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5159F1F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 16:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbfHOQ0e (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 12:26:34 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46001 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731855AbfHOQ0d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 12:26:33 -0400
Received: by mail-qk1-f193.google.com with SMTP id m2so2251910qki.12
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 09:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BgKn4A5iWT9iqzo1+Lk4F/d78zZBDapu8/q67f9ECDA=;
        b=L9T1dIwpBS4w0c+Zi+UdRYqPqjzWX12k7t7Y3dN1PWNwz1AtvXPHRn6C/W1eX/kwfl
         QCDedSHQGZiJYhqdJ0XeF/65It5R3Z4sDeyj5Wv0COWtYdRvymVlKbfos6pM9PIF8TvG
         T1QKjPKS4Qzi0e+b87x3Jk0MCQ1w5qmMud5pe5icwPcMidXnlDCYBfmDyfKyIMb5dn/n
         xGsnoFQ5qynu76F1IX/B03UepasQJaaGWAgMnrgWAin86S5FWwwojBKHouwMXq7b8JZQ
         Mdu89qEiNhHqO4O65ikvDnlstTSu45nVtyVbp8QBM2t2BM0m3UMHfI25EHVhDannk+BK
         HJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BgKn4A5iWT9iqzo1+Lk4F/d78zZBDapu8/q67f9ECDA=;
        b=AxJtLcnxO8ht3ZPoAzm6POn38gVDdG2jJ8sbjdpg/7O3XyMk4ninRqQIxfX4vH9QLW
         7Qaeux1rCGaPjXcgzgAZc8WzsuoB83JT10hsIJtpdUWs81tOeDUowpXfZnwxLffizGmk
         mZ16MAondUWYkvDycLQtLDd90LLvDQs46QM9IZn1bnVzT8A8NkV+ghUy8XCAijLBKJWm
         qsaKJE1wKHNBet8inQOyXhf/LtJTIe6zlKNBT4B/R33eULJYwiTzwTqUN3Hmp34Nx6FL
         P/wLbk0FswGVSB2ZXA5jYxJbnWN34pDEgA4FCT167Q1zcauI7WsnSHEs6EK1XlJ8LphR
         QPjg==
X-Gm-Message-State: APjAAAWzypLvhm1wwE9GQWgdB1cZCpwJukSfpjNENbAh9I0Xt6jG8G+C
        UtdJ0MgJ6/ymRsvfg3Tcm5wtG6MiEq2S3sJcJiw=
X-Google-Smtp-Source: APXvYqw68bjdE5DyLj+sT/kMN5BOc1n8aProLf/8ChEA2b3XRAY2dn1C4nobFVAmVavYx8WRYeT4B7cnmYfFBm5X9go=
X-Received: by 2002:a37:4986:: with SMTP id w128mr4640138qka.417.1565886392782;
 Thu, 15 Aug 2019 09:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190712150235.12633-1-vcnaik94@gmail.com> <20190801161558.12838-1-vcnaik94@gmail.com>
In-Reply-To: <20190801161558.12838-1-vcnaik94@gmail.com>
From:   Varun Naik <vcnaik94@gmail.com>
Date:   Thu, 15 Aug 2019 09:26:21 -0700
Message-ID: <CAK_rgsGYa6LoGDHz=sGDXY26Lvg3dxV-poB5FQHf5G6BuOKVPg@mail.gmail.com>
Subject: Re: [PATCH v3] diff-lib.c: handle empty deleted ita files
To:     Varun Naik <vcnaik94@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 1, 2019 at 9:16 AM Varun Naik <vcnaik94@gmail.com> wrote:
>
> It is possible to delete a committed file from the index and then add it
> as intent-to-add. Certain forms of `git diff` should show the file.
> After `git reset HEAD`, the file should be identical in the index and
> HEAD. The commands already work correctly if the file has contents in
> HEAD. This patch provides the desired behavior even when the file is
> empty in HEAD.
>
> The affected "diff" commands and the "reset" command call
> diff-lib.c:do_oneway_diff() with a cache entry in the index and a cache
> entry in HEAD. An ita file is represented in the index by a cache entry
> with the same hash as an empty file. For a nonempty deleted ita file,
> do_oneway_diff() calls show_modified(), which detects a diff between the
> cache entry in the index and the cache entry in HEAD and therefore deems
> the file "modified". However, for an empty deleted ita file,
> do_oneway_diff() previously detected no such diff between the two cache
> entries and therefore deemed the file "not modified". After this fix,
> for any deleted ita file, do_oneway_diff() calls diff_index_show_file()
> and deems the file "deleted".
>
> `git diff-index --cached HEAD` prints a row of output for both a
> "modified" and a "deleted" file, although the output differs slightly.
> `git reset HEAD` treats a "modified" and a "deleted" file similarly,
> resurrecting the file in the index from HEAD.
>
> This change should not affect newly added ita files. For those, the
> "tree" cache entry is NULL, so the changed code is not executed.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Varun Naik <vcnaik94@gmail.com>
> ---

Bumping this email, since I noticed v2 is still in pu.

Varun
