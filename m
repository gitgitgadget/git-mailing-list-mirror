Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0464E1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 23:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbeFGXyz (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 19:54:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55425 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752178AbeFGXyy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 19:54:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id v16-v6so245636wmh.5
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 16:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YiTdbJh99fdIlcRDtYKpbKO91X3LRwQ4hZrYsM4vGw0=;
        b=gv6Xp9bT/J1MQjeWgULDkRLrEirOGAkH5RU8HGcM11UIR+P3drnB5WCP/93EYnmpCQ
         gPcwAdBUv02YsfrkoUwZ3Q0ej+6540psM8n+5xkoN3J/4oP9m+CisKik9mArf9Up5E//
         jDOx6bbPEGMsZ8qqlH5tIrr1YTO67Ko58stAMNusO8V+ZR9du2Ez0OyhxDNCNUn/woc7
         Hon25qWGnu+98PzGgWJrB7zzj5ZovF/zXhf/hmvealbY0/f5MOTLxceFXX1f8J4qRou+
         w8f79v2oAGsm0vOxk1dCku0VognacOqiXbhtFbYDEXCjVq0kRkhTljelPckchZ6dydU9
         Hl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YiTdbJh99fdIlcRDtYKpbKO91X3LRwQ4hZrYsM4vGw0=;
        b=PpbdEUaO5G7DEWmMKzQxzTrVHGk+7bQGFHfOIWkAFYDS4ohhh5c1XTvzacvPYqeRvA
         JbUvwJja34UADsohKU3EXD/18qd5RejVCuBNVBIMzyhR8PhmUhXVonw6gfZ6Ahnu+AaW
         z00L4xXcSUFj87OTviXdMCIDpeUjLsanm6uUnUSSrG9wj+3BVAlDDEdiU0/BxXkUL6iR
         ZBdNfqDHxVMYUG2vLbkeBc1MspkFivGernO34QZ4A97ioD6Rd+5S6ingxgGmj4Q0vhhc
         LICAXTzBvj58EWWL5JDLA5SzHWGovdbvNwWrmLgrVPZdb1ckmfQlpIqkWTNR2Q5RMJNF
         T0zg==
X-Gm-Message-State: APt69E1snWQBcQ07QLCujBMZsydhW2x6PQN2twdG9q0T94ajdo8a23Sw
        U6bZHIUpeGr4k81G3enP4RnezSR9VDllxjGlO7E=
X-Google-Smtp-Source: ADUXVKInsw6P21zGBlOmgOdxMITBN5sFCNcVGsbAgVbCToKEF3AswAtsEolzoJS4gbrk3paoJK5e/bkHTDeW5TMyYl0=
X-Received: by 2002:a50:8b03:: with SMTP id l3-v6mr4398684edl.265.1528415692903;
 Thu, 07 Jun 2018 16:54:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:ee8c:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 16:54:32 -0700 (PDT)
In-Reply-To: <20180517194653.48928-1-sbeller@google.com>
References: <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
 <20180517194653.48928-1-sbeller@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 7 Jun 2018 16:54:32 -0700
Message-ID: <CA+P7+xqHejWOc=2v_OsJn8T-pUthxDgXWcLV1mbaSsRw1_iVTA@mail.gmail.com>
Subject: Re: [PATCH 0/8] Reroll of sb/diff-color-move-more
To:     Stefan Beller <sbeller@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 17, 2018 at 12:46 PM, Stefan Beller <sbeller@google.com> wrote:
>>> * sb/diff-color-move-more (2018-04-25) 7 commits
>>...
>>>
>>>  Will merge to 'next'.
>>
>>I did not get around to fix it up, there are still review
>>comments outstanding. (The test is broken in the last commit.)
>
> This is a reroll of sb/diff-color-move-more, with the test fixed as well
> as another extra patch, that would have caught the bad test.
>
> The range diff is below.
>
> Thanks,
> Stefan
>
> Stefan Beller (8):
>   xdiff/xdiff.h: remove unused flags
>   xdiff/xdiffi.c: remove unneeded function declarations
>   diff.c: do not pass diff options as keydata to hashmap
>   diff.c: adjust hash function signature to match hashmap expectation
>   diff.c: add a blocks mode for moved code detection
>   diff.c: decouple white space treatment from move detection algorithm
>   diff.c: add --color-moved-ignore-space-delta option
>   diff: color-moved white space handling options imply color-moved
>

I've been using this locally, and it's really nice. One question I
had, are there plans to make the whitespace options configurable? I
really like the option for enabling lines to count as moved when the
whitespace changes uniformly, (it helps make changes more obvious when
doing indentation changes such as wrapping code within a block).
However, it's rather a long option name to type out. I didn't see any
obvious config options to enable it by default though.

Thanks,
Jake
