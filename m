Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 241321F463
	for <e@80x24.org>; Thu, 26 Sep 2019 17:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfIZRdz (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 13:33:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34313 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfIZRdy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 13:33:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id a11so3741882wrx.1
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 10:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZEtvNRtmUYQinVjjAq2dEp7EEOYJwm1mPaemOyMoC8A=;
        b=Iu32NbxKOQwOE5cTXkYgmseY09XXWHAIrVYjixeD8vvE494CcOZ5+kNHzojnnO2jX9
         HvkPPDrLiGHUe+NAtXGIVCIuKcIgSh8aF6mVyx5KUxl2/Uu9DjZ1IW7rE9DrfciCV1fQ
         JoJ4An6jCDjNAouGcE3gKkUPzD6wQtzwMOHH+LUntLkFWm/zU9Ec1D02hL0+j3SrNzxZ
         kuFgesDBWseWb55lY5cBOGC3XbyNwMOKgo3DLgAV5l3zc8IArms9G3cxhcvbPqVj3TAz
         MX+n1WaMj3jucNFSvUehn2xs/B0lnl6zT7loq/tHQ1+Qb+rHr5U91Qv78QUJ8yj947EZ
         Wwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZEtvNRtmUYQinVjjAq2dEp7EEOYJwm1mPaemOyMoC8A=;
        b=Tj8edFYLowNyN3pugEbc7miC6uUp/r6pEGhwXPYz/GtrDw8V8hxb89vhJFC/UBM5Hr
         tJckSAPCdN7VfShHGmTUslGmV6IqCz3xCUOf/uuEQz4NTwr/gREzrcMcHCitjoKcVIj1
         zHWmig/M+OrhbQJlMquPjnw0/BdOd9zVDpzb8GPUariB8a+06RfLjHBH71Xn3ukf3I10
         qxOJSQe7RUAuyf7l+B2YTUoqVk6AI8kFWXIGADk5JiQfXwcp1u0TBqDOFK8v4MbkWH4p
         j5gOlrCIxAZkdd38b/XtATXK5vzxux2+LRBzHTNhV9NDccCyCVxZn/Ci6qDRA4c8zdnG
         AZaw==
X-Gm-Message-State: APjAAAXWGXR1Ch8y+YGL7Vh8Emv+tEMO4Ti/fbAUZWcb5HiM9jOGWZpY
        a58yYkcKZWyVCwWvggQNEKBN/w4a
X-Google-Smtp-Source: APXvYqwShhzzt72bKIVLktwWYMTzV92aFHqmlx4OBFPoKdX/h1xp+fxoPl8UzNR7tVqiy9nUkzMJ1Q==
X-Received: by 2002:a05:6000:14c:: with SMTP id r12mr3853519wrx.303.1569519232123;
        Thu, 26 Sep 2019 10:33:52 -0700 (PDT)
Received: from szeder.dev (x4db9381f.dyn.telefonica.de. [77.185.56.31])
        by smtp.gmail.com with ESMTPSA id o14sm4107735wrw.11.2019.09.26.10.33.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 10:33:51 -0700 (PDT)
Date:   Thu, 26 Sep 2019 19:33:48 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 08/15] name-rev: pull out deref handling from the
 recursion
Message-ID: <20190926173348.GH2637@szeder.dev>
References: <20190920181302.GA26402@szeder.dev>
 <20190920181407.GB26402@szeder.dev>
 <20190921095718.GA23203@szeder.dev>
 <a507bbd1-88cf-6668-908e-92978fb77930@web.de>
 <20190922190511.GB10866@szeder.dev>
 <822d19dc-5202-b67f-5c0c-e5c69a679237@web.de>
 <20190923185908.GB2637@szeder.dev>
 <0febc113-ce84-4794-890f-4703c07057dc@web.de>
 <20190923204714.GC2637@szeder.dev>
 <ce55a33b-aa8b-9325-fe87-8ff4c7e02627@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce55a33b-aa8b-9325-fe87-8ff4c7e02627@web.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 24, 2019 at 07:03:50PM +0200, René Scharfe wrote:
> Am 23.09.19 um 22:47 schrieb SZEDER Gábor:
> > On Mon, Sep 23, 2019 at 09:55:11PM +0200, René Scharfe wrote:
> >> -- >8 --
> >> Subject: [PATCH] name-rev: use FLEX_ARRAY for tip_name in struct rev_name
> >>
> >> Give each rev_name its very own tip_name string.  This simplifies memory
> >> ownership, as callers of name_rev() only have to make sure the tip_name
> >> parameter exists for the duration of the call and don't have to preserve
> >> it for the whole run of the program.
> >>
> >> It also saves four or eight bytes per object because this change removes
> >> the pointer indirection.  Memory usage is still higher for linear
> >> histories that previously shared the same tip_name value between
> >> multiple name_rev instances.
> >
> > Besides looking at memory usage, have you run any performance
> > benchmarks?  Here it seems to make 'git name-rev --all >out' slower by
> > 17% in the git repo and by 19.5% in the linux repo.
> 
> Did measure now; I also see a slowdown with my patch applied:

Thanks for confirming.

> We can reuse a strbuf instead of allocating new strings when adding
> suffixes to get some of the performance loss back.  I guess it's easier
> after the recursion is removed.  Numbers:

Agreed, the conflicts on first sight are too ugly to have these
changes in parallel cooking topics.  Furthermore, after the recursion
is gone we can measure the memory usage and performance impact of your
changes even in big linear repositories.

I think I will drop the last two patches plugging memory leaks from v2
of my series, because it seems your proposed changes do it cleaner and
make them moot anyway.

