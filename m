Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F2071F744
	for <e@80x24.org>; Sat,  9 Jul 2016 04:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbcGIE6s (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 00:58:48 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:36572 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbcGIE6q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 00:58:46 -0400
Received: by mail-yw0-f173.google.com with SMTP id b72so53296872ywa.3
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 21:58:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0s7+wbFr4Z8T9PYUO3jQY/XeV4UFjLR/lPYkHgRa8Sg=;
        b=q1gDQrjGXYdZP0H6ivIaFzidv6bKHqNv6f259UZl1is86ersoLUItM6VP63fDevHzI
         fKLMdCrYibBqEyXNSjtmkWUHrAqAFHDyPxucOyFQtXZmmy1RMfAL5SO0PBnQZFuJC0ts
         PI3QlluH8lVwH615hh2Ujqp6L7iqbEQKY5cWsGI3TNu7cIEYo5eTcsJtY9iVZHWXP9Eu
         Fzd809sLYzQdRAcNbHor8weXKEScUC+A26HnzpN4z9LquD1lM/suziP5oi3D7YmvxgE7
         6DMTjmCM+LUFGBwW/0LDa8TZMmV6RKXFyyILxB+h1VLToeycJvhcL6iJk52a+4o/YlaU
         37AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0s7+wbFr4Z8T9PYUO3jQY/XeV4UFjLR/lPYkHgRa8Sg=;
        b=GjCBnxga4q7e50zSZTocTRWsfa6mwG3zOGwg/zkXr/2+9hMnUjYWHITfQYSEuRe3Ru
         beYkGKwmMH7aQyDLKwaQo45tc7GUPDd6rUHuZhpm+0OpHSQqyvWdgDkOpGChSlT4nPLD
         y+CYkFGDOF6MbrhYPbLH64hG97oy13OzPX254ogib/IqSawfC5mv4nwfsDYbEHl8D4FF
         TZ6hBbzZARD95mSmB2BgIQgKrjfH86RoaebcnVa3EH/x0taOnZAMacCRtHOa2SKUvbm2
         Wh2Ux3iGKetK1klctTmsKxwBmLPsyScI1HNaYqJBaCIOknRXQRzwmInNH8Yu+7lB82mQ
         HOjg==
X-Gm-Message-State: ALyK8tI+CUsRf6U0EveHvJIKvzwb6ik/UhXlFu2mQdSCJ/cODJgBpSD8xqaHktSuxeQhfpUF4C5X4zyTD1Yxag==
X-Received: by 10.13.245.132 with SMTP id e126mr6775810ywf.258.1468040325780;
 Fri, 08 Jul 2016 21:58:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.34.133 with HTTP; Fri, 8 Jul 2016 21:58:26 -0700 (PDT)
In-Reply-To: <20160709022223.GC1916@gmail.com>
References: <20160707184408.GA1916@gmail.com> <CA+P7+xoM=-=sokA_+WDuY7KYUwSa=Qu8Y9U1aPHOgSH3n-VZnA@mail.gmail.com>
 <20160708003646.GB1916@gmail.com> <CA+P7+xr_dYbno+JsTmaG+WWrgwsAXXGTyA6HL4A4A34ahHMD=Q@mail.gmail.com>
 <20160709022223.GC1916@gmail.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Fri, 8 Jul 2016 21:58:26 -0700
Message-ID: <CA+P7+xoLKmUaJ9f1obVVDyjBTBe=XvSACvL8uiJWYf+2MTMN8w@mail.gmail.com>
Subject: Re: git branch doesn't allow me to forcibly delete branch which was
 checked out in a now-deleted worktree dir
To:	Erik Johnson <palehose@gmail.com>
Cc:	Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 8, 2016 at 7:22 PM, Erik Johnson <palehose@gmail.com> wrote:
> On Fri, Jul 08, 2016 at 05:41:17PM -0700, Jacob Keller wrote:
>> It is possible we should update "git branch -d" should perform a
>> worktree prune first, since that would enable it to determine that you
>> deleted the directory, and any worktree which is removable should be
>> marked as persistent.
>>
>> Given that there is a known workaround (git worktree prune) and that
>> it is expected behavior for a branch checked out to prevent deletion,
>> I think the best coarse of action would be to patch git branch -d to
>> do a prune before attempting to delete.
>>
>> Thanks,
>> Jake
>
>
> Well, I never mentioned -d (I was using -D), but I think we're both in
> agreement.
>
>

Out of curiosity, what is git branch -D behavior when the worktree does exist?

Thanks,
Jake
