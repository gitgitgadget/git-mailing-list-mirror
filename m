Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D33521F731
	for <e@80x24.org>; Thu,  8 Aug 2019 14:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732487AbfHHOXE (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 10:23:04 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44454 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfHHOXE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 10:23:04 -0400
Received: by mail-ot1-f65.google.com with SMTP id b7so69030286otl.11
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 07:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R++FIHQD+zqmvEDZnGgXwSYiCIEs/iiSsCAc1OJBehU=;
        b=v3Mio9h3T+gizYwiysKHIj+X/Ci5jos93ggO5aXPnTOz+Rb54NNorZK0kvajQ0xpeY
         0DaldmDWP0t1Pndj1nLhNUyAzpxhf6haYEszd+tX+xEWg1plYGCFvn0hB1Yvm9e2XLyq
         AcNnXw/sImesFZt3nSWx7eWJiZCy4i5caQ4xvpNV22os4fUJGg3Duqage3Xzeqs9G1AK
         lVuuKzkRFqk0oMrA9nnIBzhtVzhfOLXCsrDEfrfZSXpWCj0wDlg4OXxifrXO0bbFZ7Ki
         p3qMJk8Geb0jQ/G+NYm7Z8VL7m/1wBOShSYjqX12uyXLlaNPsd6ZJCN0ipoRCMeTaIaM
         LBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R++FIHQD+zqmvEDZnGgXwSYiCIEs/iiSsCAc1OJBehU=;
        b=V3rrVpvYGoIUIp2hEw0Xb9sOlW0rKvb/TwFswAUvntJ8j0yS75iLriukkNfg2NAmWQ
         r5BC+4H3WPFZkfj622FS3s8+29QaPWZNKuzyuaTNWDle8pyY4jXbTgSmNdR2lHa36+5v
         d1KAtOXv1A4xmvl9Hua3CeqOMiByKudFUVPPT/9DMA+WdqUJ4CtBulCb1pCfjZuHxqPC
         n805DouaW3WoIBjkerjuyC822clM1X4crVRb+xylIse8eA4aL7yQsQKNOvJV1n9BOVdd
         Yoqu9ZoamY0Mh81J7WRzhfgXHF59Fy2L3k3fwuR5KVbxsjhRDdS/WIEtoOQhbNMiHR9b
         nnzQ==
X-Gm-Message-State: APjAAAX3doZnxZf6jmY1ZQDTxeRA+YKVYpYUxQTvSwCqudSU3YtyCybR
        sMt20cvGtHh958AvVzj8IujzsYUDzm91HxnQQ6q+MQ==
X-Google-Smtp-Source: APXvYqwP+wR5+d4hKczd6ILnzAke+dVcG9MdWKqH/6NgWIJ7Nuu2ZiUTntVuxZkzbQgZDuHM3rHJtogoEb4hRqup1nU=
X-Received: by 2002:a6b:621a:: with SMTP id f26mr13867167iog.127.1565274183436;
 Thu, 08 Aug 2019 07:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW5MZNQ=AWwL+4wh6wERYJTMVv_1DKCBk4OK9Asui_bQBA@mail.gmail.com>
 <CAHd-oW7pT=RhsCnkhRzGDy1gXWN7a4AnwdYCNa6q6uri1O51FQ@mail.gmail.com> <CAP8UFD1HgjcQDS2ypJVe_r3-Jpy1ENNGR+kCfa72Kmht28ZNJw@mail.gmail.com>
In-Reply-To: <CAP8UFD1HgjcQDS2ypJVe_r3-Jpy1ENNGR+kCfa72Kmht28ZNJw@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 8 Aug 2019 11:22:51 -0300
Message-ID: <CAHd-oW5FYLnTp-_y7hAVOYUj=ugY3jGoqpWC_SVoKmfjwqf9=A@mail.gmail.com>
Subject: Re: [GSoC] My project blog
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 6, 2019 at 4:16 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi Matheus,
>
> On Tue, Aug 6, 2019 at 4:54 AM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
> >
> > Here's my report from last week:
> > https://matheustavares.gitlab.io/posts/week-11-wip-grep-protecting-textconv-and-submodules
>
> Thank you for another great report!
>
> > I'm working to protect the operations I left behind on the first
> > version of the patchset[1]. And for that, I used a lot of the code Duy
> > provided[2] me as an example in the early days of this project. The
> > race conditions are now majorly gone, but the patches still need some
> > refactoring and there are still some problems to overcome.
>
> This looks good to me! I think you are now way past the point where
> you know much more about this than me, but anyway the following might
> give you some ideas or perhaps in some other ways help you:
>
>   - About "Try to remove the obj_read_lock", which is the last point
> on your TODO list, it doesn't look necessary before you submit a patch
> series, unless there is no performance improvement without it. You
> could, as far as I can tell, do it in a later patch series.
>
>   - I guess " --recurse-submodules" is not used very often with git
> grep. For example I never use it on the Git repo even when I perhaps
> should. So if it would simplify things to just disable the
> improvements you made when " --recurse-submodules" is used, then you
> might consider doing that. You could later send another patch series
> that would enable your improvements when " --recurse-submodules" is
> used.

Thanks for the suggestions, Christian. So, I think I could finish and
send the patchset without the optimization for --recurse-submodules
and --textconv, while I don't finish support for them, right? And I
think 'obj_read_lock' may be removed in a future patch, as you said,
because we already have good speedup without removing it. Finally,
should I also add a "NOTES" section to Documentation/git-grep.txt
saying which options --threads is not compatible with?

Thanks,
Matheus
