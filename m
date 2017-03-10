Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 327F61FC43
	for <e@80x24.org>; Fri, 10 Mar 2017 20:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933345AbdCJUsR (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 15:48:17 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33672 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933268AbdCJUsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 15:48:16 -0500
Received: by mail-pg0-f53.google.com with SMTP id 25so42853401pgy.0
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 12:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KrIKqGR0DFM6wu3dpNWKjJYkyyr4p3MiAR/uMpEPFAI=;
        b=HdUDKwf7yshIdeRX07daXYTgh+X0pdbldh8N5s6vMp31mvdperP60ePdjjhskmmucy
         C9gyu+qLXP4INTpgIXBkJQkiJb3Uj/WImLuMFska742FF+sxzJoV0mBG8GU8rCvpiPuM
         /6fxeeJjKLXi0zhewlh8j8EC8acfDIkYUNDZCZwQctbqilJKStuNFzDu6JgI2XqY3a1r
         EKtZDgF8LtOcGz3Hyln8wbdg9G6mAV3RxgSdR89TGAsCVCvBGr+ft3Bxcm5Asv9FwZx2
         QvFdZng3Z/WLr/IWP1yKCitoJTewionYbLZWgQW/4+LK1vpKAanAL4+MvdZcBJ3cbmAx
         z6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KrIKqGR0DFM6wu3dpNWKjJYkyyr4p3MiAR/uMpEPFAI=;
        b=c/XsOC9+34FdAvB+Kx10QjWQ+Z5n9Zch/PwZhOo/gmBXsdYBj43rDrfkvnxE9OxHO1
         VwNNUlJFMAejyvUnvxRpK+XbrmYaD67/rw+bIBGoWLCfISOS+LZ5BMZdedDZFjE+sx6i
         3HoNwsSY/ry4X4CJUGu10XqhLQt9Hkn5odlnAFx8EzCpPpjuPqDHSsZodz5sKyKY1x2r
         D4XbhdHd3YIx35qNTouiAN6RWjnT5kb3pUBgbkWPn2tIlxqOqgjjxIiTdkRa6+0KmXTz
         UVWclWo4ujTnAc3vKBvJXIjshm3mQWAiR5sGmtjcSRnAvgH69zdXfIRhy4YyiEWetjnB
         Ffig==
X-Gm-Message-State: AMke39k+H3bW/Z/30X05CEKc/sE7J5grHIv5EJHHX2gs3q7VqzrV+2NrZsU/vNE8rdoNKKPuO+qXhXacBiYe1PCv
X-Received: by 10.84.239.8 with SMTP id w8mr28164336plk.73.1489178894502; Fri,
 10 Mar 2017 12:48:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Fri, 10 Mar 2017 12:48:13 -0800 (PST)
In-Reply-To: <xmqq7f3wyifv.fsf@gitster.mtv.corp.google.com>
References: <20170309003858.GB153031@google.com> <20170309012734.21541-1-me@vtolstov.org>
 <20170309012734.21541-3-me@vtolstov.org> <20170309181837.GF153031@google.com>
 <xmqqvargyl39.fsf@gitster.mtv.corp.google.com> <CAGZ79kbhG9XhRccqA555Zp-FENJ5Q6Nd+LnNTZno1J_=cGQctQ@mail.gmail.com>
 <xmqq7f3wyifv.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 10 Mar 2017 12:48:13 -0800
Message-ID: <CAGZ79kbX6Wq_58MPRM08b0eL8vqtnRytr1PHSCTRDnA=3FEXwA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] submodule--helper.c: remove duplicate code
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Valery Tolstov <me@vtolstov.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 12:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Fri, Mar 10, 2017 at 11:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Brandon Williams <bmwill@google.com> writes:
>>>
>>>> On 03/09, Valery Tolstov wrote:
>>>>> Remove code fragment from module_clone that duplicates functionality
>>>>> of connect_work_tree_and_git_dir in dir.c
>>>>>
>>>>> Signed-off-by: Valery Tolstov <me@vtolstov.org>
>>>>
>>>> Looks good.
>>>
>>> I'll queue with your Reviewed-by: added.
>>>
>>> If sb/checkout-recurse-submodules is going to be rerolled, I'd
>>> appreciate if it includes this patch inserted at an appropriate
>>> place in the series, instead of me having to remember re-applying
>>> this patch every time it happens.
>>
>> Instead of mixing these two series, can you just take Valerys series as is,
>> and sb/checkout-recurse-submodules builds on top of that when rerolled?
>
> That's fine by me, too, but that still means I need to keep an eye
> on two independent topics that interact each other.  Is a single
> patch 2/2 that important to be on a separate topic?  Expressed in
> another way, is it expected that sb/checkout-recurse-submodules
> would take forever to mature relative to these two patches?

Using the times and number of rerolls this has been around, it
is a not unreasonable to estimate sb/checkout-... will take longer
than this code deduplication patch.

Thanks,
Stefan
