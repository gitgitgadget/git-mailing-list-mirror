Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FF301F4DD
	for <e@80x24.org>; Wed, 23 Aug 2017 23:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbdHWXXI (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 19:23:08 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36604 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdHWXXH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 19:23:07 -0400
Received: by mail-oi0-f45.google.com with SMTP id g131so15440424oic.3
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 16:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ct3p9Oc5tC59B2uLGpY93yM7IzlrjIOWiTUPGqOKohc=;
        b=CqJUkmnYDOp8lVgviPm3dF7LS7YzVa5+/aRRKT4OH9Q9s1pzM8zE4n2sW6BMEkC2Yy
         NdHALL2H3IFqq5WTASXUeyz7dBKK10KXtsdHVuXqvkPIkMcCXCbsIZawu2wJvksM15fu
         dt0LHQXBpu5p2GaNkMkruEoh3aopmumPMEhPMX5FD4rQpDhJzs/feS/Zgve2LwDdEelV
         ntOOjsCsl3pzFKhGFqoUi0qTmGJUyqNtZSmAiSUuYYZp7/EwuQuvhGjetTvn2L34ekE0
         7Xq4LATO6Va7QOnxsCr2uurEb5G3XqZu2auGdTiSr33CkPmn9JHuIibxizTvA/fVEemy
         SKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ct3p9Oc5tC59B2uLGpY93yM7IzlrjIOWiTUPGqOKohc=;
        b=ljORdK0+33IoWYpnBC9Z+1intGC1/Ig/9Aze7nfPrdApwASGnUr1VbmD9/c6/b3vid
         Nq17X+GlTULups5oEjaHUPnWQ/x2IX+4j3PBqonYLXnahHsLIz+cIb42ENok5qbqP03O
         xJKq9fD916JFtTPhuDJlHmTPfcdXaRHuz2eYuKseTaKPus5M3Z9H4ynQf6sFfXZI+4wu
         3JXWCNhe6MFpBxlHRFNVd5UB033MSO5KXXLebltCkaj54CSnf6289Sa4a4OaIDqMBEFi
         qjkFpFvkrfkADr7ED4eGKgwnw582iYpMXoedtbFzTp7XKDs5DwRqSZmmp/FLpBAtPUYQ
         1RBg==
X-Gm-Message-State: AHYfb5hbOMJvhC5fWT2imyUYXOztmecGI7AHlr3fcVd38d6PGeqS7bsn
        Us7Kpo2fVcoY+EbZ0donUb8bdE4T3Q==
X-Received: by 10.202.207.131 with SMTP id f125mr5718853oig.37.1503530586478;
 Wed, 23 Aug 2017 16:23:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.7.74 with HTTP; Wed, 23 Aug 2017 16:23:05 -0700 (PDT)
In-Reply-To: <20170823154747.vxtyy2v2ofkxwrkx@sigill.intra.peff.net>
References: <CAOkDyE8KxFvM4CJhC4U=Jb95D6HQ-4qQBtKAgBMyHH15UOhvqg@mail.gmail.com>
 <CAM9Z-n=ypt_fyFcPjYD28NNoxnJ2ZSovd1TbERdA8RJY1Va=kA@mail.gmail.com>
 <CAOkDyE9phgZ4ToWTWa2GYgfVkDknCqWr+KEyqVoHg0RVrVVk9A@mail.gmail.com>
 <CAOkDyE_VhGUzn=PmAVsbaTe1ZeBwBVGpF4Muz5MBckMAB6cf=g@mail.gmail.com> <20170823154747.vxtyy2v2ofkxwrkx@sigill.intra.peff.net>
From:   Adam Spiers <git@adamspiers.org>
Date:   Thu, 24 Aug 2017 00:23:05 +0100
X-Google-Sender-Auth: x734B8-kEwVWnZpQjtTq3jQsVK4
Message-ID: <CAOkDyE9pWFLRQ0cZO03bc3Q9r=AzLHMUQ0kxb4bdsTJowcLz=g@mail.gmail.com>
Subject: Re: splitting off shell test framework
To:     Jeff King <peff@peff.net>
Cc:     Drew Northup <n1xim.email@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "Jason J Pyeron CTR (US)" <jason.j.pyeron.ctr@mail.mil>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23 August 2017 at 16:47, Jeff King <peff@peff.net> wrote:
> On Wed, Aug 23, 2017 at 02:46:30PM +0100, Adam Spiers wrote:
>> >> Done at least once already:
>> >>
>> >> http://comments.gmane.org/gmane.comp.version-control.git/201591
>> [...]
>>
>> but sadly since then gmane has shuffled off its mortal coil and I can't
>> remember / find what this URL referred to.  Please could someone
>> point me at a working link?
>
> Try:
>
>   https://public-inbox.org/git/?q=gmane:201591
>
> Public-inbox uses message-ids as its primary key, but keeps a static
> mapping of gmane articles to message-ids. But the corpus of gmane ids
> isn't growing anymore, and public-inbox URLs can be trivially converted
> to other systems which index on the message id[1].

Thanks a lot; that's super helpful!

> [1] I actually keep a local archive and convert public-inbox URLs into
>     local requests that I view in mutt.

Sounds like a neat trick - any scripts / config worth sharing?
