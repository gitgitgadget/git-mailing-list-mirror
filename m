Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16CC61FD99
	for <e@80x24.org>; Mon, 15 Aug 2016 05:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbcHOFdL (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 01:33:11 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:34475 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbcHOFdK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 01:33:10 -0400
Received: by mail-yw0-f175.google.com with SMTP id z8so21920254ywa.1
        for <git@vger.kernel.org>; Sun, 14 Aug 2016 22:33:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SItd7zGXLCCQHYb7VKxSbmXXiULKODhsedp9jJlaHwc=;
        b=fcjMduftzbf7J4KCPZgT5gr22IenSiyh15H917LZjDnJq3j6Ry9hemZHG7biN6TN3C
         0GqD9SB//cIWnYrk1HaRosx+9Qqi1iiZYnR3ndLM+4qLAVGkbYdO4DI7NOHhR7bnqIK2
         yiv4ZRpcecgrtVoAOWc//NQ+1zAvp8w7v8bMEI9wTfAhYj04f1TJTLKf4uiC1GYXdBpz
         J4oVmwlxgRz2vbeiZOahLs4s8uubVi++pnvvdXxTQG/bpg5tIwjpXqbC5ATGqP6vs/rd
         mZdANpIchcB1zsvC6PHw+OMKp4PepyUvSvhgGzWexFD5jOcSDLmo/Vzfz/NK2fO2gvpI
         b1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SItd7zGXLCCQHYb7VKxSbmXXiULKODhsedp9jJlaHwc=;
        b=Qx65/I0XYUximQZs8lf4hrhSiGOvo1uK2CqcWzkLEhql4+QoRI5pxqPW4cFcwu520b
         5hzz8hSuMnk4pStjosq2q0ewZw2v7y2AkEMvMGgf7YMi2v4TfNFluj1OQRdI8nLlw1BF
         EGA3lWGqAzdf5XEfJDqH0JUZCbiGt1IZzATPY2Q6cjEUGNrTpfzOtBupWV9jsJEYQoZF
         LTrcDBobxRSn2Luubs1TiB4XhbvxNWaTr9SPRv8zRvawhMS4ANsH2l3fCjKdPg1hByz3
         evUEM5AQdc5XRtSjg8B7BIE7q+lArJluzz70/ZP3Cbh21RrMNCTu2YamSZLp50pUdWqc
         ta9A==
X-Gm-Message-State: AEkoousISYnpLsK+tuPwBDJntxsWT/Y46mkIz/JgHehbzS6xqyY7NvYchXZzhklsWGZtxnxd5lHYkINOc+Gx0A==
X-Received: by 10.13.228.196 with SMTP id n187mr20243800ywe.83.1471239189686;
 Sun, 14 Aug 2016 22:33:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Sun, 14 Aug 2016 22:32:49 -0700 (PDT)
In-Reply-To: <xmqqa8gfkpw1.fsf@gitster.mtv.corp.google.com>
References: <20160811225946.18381-1-jacob.e.keller@intel.com>
 <20160811225946.18381-2-jacob.e.keller@intel.com> <xmqqvaz5vgc7.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xoX6AT7tGb5AJr1CSjzAQ67o8QXJFF1LxsV_7E_pF-moA@mail.gmail.com>
 <CA+P7+xq+GTbvzOtVvpu4_rdYYy-hhGZHhpk_ka=KkeU7UmQRew@mail.gmail.com>
 <CAPc5daVmyx+EX8H0yETfO6Vv+A7DqBM5bsqrnJdYzbEhVnA1wQ@mail.gmail.com>
 <CA+P7+xp_sPk6P1qyyDfOgpkXU1GxWPivfSzvveS4PAvGb-=ggQ@mail.gmail.com> <xmqqa8gfkpw1.fsf@gitster.mtv.corp.google.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Sun, 14 Aug 2016 22:32:49 -0700
Message-ID: <CA+P7+xr9RcKQ0uO_F7CtK6nsz83KH0OqpFaBVnzL1jqyP9YfSQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] diff: add --diff-line-prefix option for passing in
 a prefix
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Aug 14, 2016 at 2:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> On Fri, Aug 12, 2016 at 2:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> On Fri, Aug 12, 2016 at 2:43 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>>> Ok so the big problem here is that unlike with diff which has support
>>>> for line-prefixes already due to needing it for graph mode, I can't
>>>> figure out where to get the prefix added for log output.
>>>
>>> Doesn't the --graph mode show the graph lines already? I think most
>>> if not all of that processing happens inside log-tree.c::show_log().
>>
>> Yes but the problem is how to get this additional prefix to be displayed for
>>
>> (a) non graph mode
>> (b) for graph mode but display the prefix before the graph prefix
>>
>> It doesn't seem straight forward, and I haven't figured out how the
>> graph code already works.
>
> Because you only need "diff --line-prefix" to work while leaving
> "log --line-prefix" broken for the purpose of your immediate purpose
> to update "diff/log [--graph and other options] --submodule=<type>"
> to show "diff A B" in the submodule, I think it is OK to leave it
> broken, as long as it is clearly documented that "--line-prefix"
> should also apply to the log message part but the current code
> doesn't.  Eventually, when somebody wants to add a new <type> that
> runs "log -p A..B" instead of "diff A B" in submodules and wants to
> make it interact well with "log --graph" at the superproject level,
> they need to fix the breakage you leave behind.  That would be much
> better than "because I cannot figure out how to prefix on the log
> part, I'll name this --diff-line-prefix", which will force us to
> support that half-baked option forever while having to add a proper
> "--line-prefix" eventually anyway.

I will look more into how to do the log version tomorrow, if I am
still stuck I will re-work the patches as you suggest here.

I am hoping I can find a good solution for how to handle it though.

Thanks,
Jake
