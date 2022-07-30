Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47E5C00144
	for <git@archiver.kernel.org>; Sat, 30 Jul 2022 00:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiG3Auo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 20:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiG3Aun (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 20:50:43 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D190E71BF4
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 17:50:41 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id v28so4781455qkg.13
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 17:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+9Q298738EvtMyG/xg5XNOYUUe1w8ij+KuzwBSPcrEg=;
        b=o7zF6a2xlDNO5gA849CshgjGMtcOIlEM1aC3A/Q7iA5ZGY2JP/dxdanBWgGNZFGyTc
         7LNcfskIEX8adeqQCy5aPXU1C2BpZLAIiiQPsS2mlWEcxHuKAgaKg9XXf2o9KmndFvDQ
         2Jbnw9+3toEcg69vtRKuWQXrEUmSrOTIDTDt5tRhWp8d3sou34XKETZZU9rGjZOZwHIL
         VcQzOOrsFSBtUNgXtdAYdYVs/eCd+tHFUc9vMsAQWE53I5PYjVWynOLv1ICGFy/FtCD/
         YhacX9x+4x0FgNbOMtevXXNK7YVpjUE9/XycnNAfySHwFFlAn6ie23X/RX437+PWMKis
         jHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+9Q298738EvtMyG/xg5XNOYUUe1w8ij+KuzwBSPcrEg=;
        b=VbF8q1QOhUX2IYHEOyDBOJFWSsHMT5DXeNHiRd8gsO85R/CXnwR8CHAcHqRZ7p7SSW
         NiEvJM3yqP9fNMySxmG8bY+u2U284VSaAtFVicP5RX9coRy0k5wE1BB2UusXNMxRX3ir
         /RSzx/xqngc8gqPm3Rxzg/CEsgo2DLrfvvHApXtUuSmzCUimFl7pSEsnqsMmeCiFL7ui
         xXq0JwKJkZZDwlJ59cZCmJr/qihTAMRssmmzrsNTEAx/c/g5o+fAMAfIsahLdcKDGoCZ
         ZkxgyROzRh0FH9z6XoHWwpNzC/kOspaFsP4UrreswQAPPU07YSIFxM2zQSLhhhSOVbJr
         w4nw==
X-Gm-Message-State: AJIora+2LR6Sr+bG3aIYbjhF7v6A7bY86GlCfUCIbDQjYGg5VvXZSJx1
        LE8x1T6klMf3Bx7CbfLyCMaZ88c7j4rtCxb9Hcg=
X-Google-Smtp-Source: AGRyM1taAmepryPyXM7aTp7G3FaJ40INC+5WqagbJIzwBcKNf89NOXm5S6BVq0ynUHGzvti5JILzVD2HNvs/rd34whk=
X-Received: by 2002:a37:6855:0:b0:6b8:803d:a306 with SMTP id
 d82-20020a376855000000b006b8803da306mr1447856qkc.183.1659142240964; Fri, 29
 Jul 2022 17:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1307.git.1659084748350.gitgitgadget@gmail.com> <pull.1307.v2.git.1659114727.gitgitgadget@gmail.com>
In-Reply-To: <pull.1307.v2.git.1659114727.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 29 Jul 2022 17:50:30 -0700
Message-ID: <CABPp-BGKUkVKJK87jZn-7A3AuxDjKwttVpez9UVZrTJZyCFodw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] merge-ort: clean up after failed merge
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 10:12 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> I was investigating why seen's CI runs fail, and came up with this fix.
>
> Changes since v1:
>
>  * Rebased onto en/merge-ort-perf.
>  * Now we're not only cleaning up the merge data structure, but also leaving
>    the Trace2 region when returning early from merge_switch_to_result().
>
> Johannes Schindelin (2):
>   merge-ort: clean up after failed merge
>   merge-ort: do leave Trace2 region even if checkout fails
>
>  merge-ort.c | 5 +++++
>  1 file changed, 5 insertions(+)

Thanks, series looks good to me:

Reviewed-by: Elijah Newren <newren@gmail.com>
