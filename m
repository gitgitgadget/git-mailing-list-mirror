Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 338A31F954
	for <e@80x24.org>; Mon, 20 Aug 2018 21:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbeHUAkc (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 20:40:32 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46394 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeHUAkc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 20:40:32 -0400
Received: by mail-yw1-f67.google.com with SMTP id j131-v6so1610035ywc.13
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 14:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zCksqeeYgGxBlKSV7UKhuwrg5MUG10DSdj7M39TTQzI=;
        b=L2ZflSacdRu0Rnv3bVopKgehHk5EQUIR0obG0qkeGKKTH5gBrn2HYQvx31KEAKfB1x
         Tc533soj8VafHolDFoD22xP+xHnLq/nHWtYoU9duIU1J7DT7lnAXKA9OzNFOyeGpc67n
         fzP+bYsLhLNhLq+P8o/ZY+A4TrrbuLoObCxai0oSjPFiA9GdPRUXGHGcKNbxoL6E8gte
         qEZTKF7kSvjjmZMBiMfwqj4NL1mI6Ytju6YZ3T73WUIRg0WPozKkey9en/UqKZKSDF5a
         x5HvIahrDbCCXHMZjkSG8d+JPx3f+6B66pYtNVXP82dlWKvwjpDvTk3aCP+Wh7Pvavuj
         QqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zCksqeeYgGxBlKSV7UKhuwrg5MUG10DSdj7M39TTQzI=;
        b=GNE/6ucoYzh+9kPK+if9LGrjH+BZizv2ch1brA+fZ4Tx7q/KxQlnW3pfUvLAMTivAQ
         fdvRzkZjo6Oz+d9kCwYpdp+lHaF1wwHoTOx56TZscQjqd9nuD/vuq+CXv0TQCzwFRDWp
         j99OkO0XHyqFWz2kUo0SpoEn7H5hesPfeKl/IbVdzFoSBBdJavToGMM3UFOa4kSBKKC/
         Og7rzfkHJlvqfxPfEnuFpkDweMr+ERn5v2C6u1Lo1MSRa6w0rA4b0U3XRk/QDlotDS76
         WGaUftj09MD+TwU8Fo+LCZ47X7IFCmOwBWssmRqc+RIs7VBWN7XvQktPQ5nI/Prnaqdi
         j7wA==
X-Gm-Message-State: AOUpUlFEslQq1qiHrodmbluazQCKNWpZvA4R1g6QPnk0khn2CsuFQAo7
        MgDYDDJDMECyoogrTxfv07tjddpsIiE5p4eZayfjJA==
X-Google-Smtp-Source: AA+uWPwpAw+B7USAv/tHMq98159PTHNSYkHiT9dB+pmWGF5hf7y0gqZQtlo5Ll5Dc5c+JoMbnun8ECjjIkZtRxxQoIE=
X-Received: by 2002:a81:a9c4:: with SMTP id g187-v6mr25145695ywh.238.1534800197755;
 Mon, 20 Aug 2018 14:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180820165124.152146-1-dstolee@microsoft.com> <20180820165124.152146-4-dstolee@microsoft.com>
In-Reply-To: <20180820165124.152146-4-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 20 Aug 2018 14:23:06 -0700
Message-ID: <CAGZ79kY8i3y6_r=bQAx7V5=ckSmb_RgyByjJwtS+7Qr2y8x8LQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] midx: mark bad packed objects
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 20, 2018 at 9:52 AM Derrick Stolee <dstolee@microsoft.com> wrote:
>
> When an object fails to decompress from a pack-file, we mark the object
> as 'bad' so we can retry with a different copy of the object (if such a
> copy exists).
>
> Before now, the multi-pack-index did not update the bad objects list for
> the pack-files it contains, and we did not check the bad objects list
> when reading an object. Now, do both.

This sounds like a bug fix unlike patches 1 & 2 that sound like
feature work(2) or making code more readable(1).
(After studying the code, this doesn't sound like a bug fix any more,
but a safety thing)

Is it worth having this on a separate track coming in
faster than the rest of this series?

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  midx.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/midx.c b/midx.c
> index 6824acf5f8..7fa75a37a3 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -280,6 +280,16 @@ static int nth_midxed_pack_entry(struct multi_pack_index *m, struct pack_entry *
>         if (!is_pack_valid(p))
>                 return 0;
>
> +       if (p->num_bad_objects) {
> +               uint32_t i;

Is there a reason that i needs to be if 32 bits?
Would size_t (for iterating) or 'int' (as a default
like in many for loops) be ok, too?
