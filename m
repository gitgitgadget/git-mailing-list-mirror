Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD9CA1F4BE
	for <e@80x24.org>; Wed,  9 Oct 2019 12:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbfJIMdZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 08:33:25 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35804 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731225AbfJIMdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 08:33:25 -0400
Received: by mail-qt1-f195.google.com with SMTP id m15so3147057qtq.2
        for <git@vger.kernel.org>; Wed, 09 Oct 2019 05:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/nAIT69an0NDzOHRHi72xoWJgVY/XAD19s5Vbhbp//I=;
        b=D26lvsTgQ874TTQq67SWc64/1v/LoLzpkXFSu3CmQXIgbIxJ+Us7yiTnIa2QUHl8kv
         MLZxVXXSr0kAV3UxwTSt93Ua/+A+FUaR3UggbCpIExT97DZT3p5DDk1WFd08k49fP44N
         DZMk5skWBJEy6DPaq+OrEneJskZuvG11iL/wezHm/AUg3sYokEYC+cRQ6vczngNQAPpx
         i2VY+EeB6o9uCN8UFVGLCTh0tveOwvVnqC5jFPlaTWG4QOxNVWO75yynatJEyU9FKX77
         rZVkwZ3Kq5SGzfIf26CE6jZNyLi1mjD6U+331hKFhA1XQwvRLcKZT48hwszN60tReRf8
         qGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/nAIT69an0NDzOHRHi72xoWJgVY/XAD19s5Vbhbp//I=;
        b=d7HPKQU6Ndd53ddl/EN234FOeqKcuRCrKzqtaMJQxhDXuqyc+yRkdkyJbIiFZnIoh0
         HKreMljcmz/ZRM6AH6kwmTmkSlIXPfok4Wfxq9cO+sDt+DlO3klEEZ4vKSUn/RFpbnLN
         0QGBFKj4rcIbK3DZd9ZYgiSX3B6Ak8OEhRm1rUyovVenYctl5/m90LAPNlvRHdBQUFjn
         WssMs8EJxuFdHhpYoaDbg70l67NVS7USUYw/xc05GZ9QHaZv/b7vouRW0GK6o6xT82vR
         IhdN/UI2czjl5Zjyf5RH8wJ++BRIfUiZkFlHBuB6055+/k8Oktk38KRQM01fWaEBuJ1m
         QMWQ==
X-Gm-Message-State: APjAAAWzvgVF5+QgDdjIBY8fC3wETXyuTOBxKAMPSlrkJ+gM79n/9Mbd
        2yq/Z7D59AZmmZ5c2o2glaQBBYeBv7g=
X-Google-Smtp-Source: APXvYqzd/nzjecu3tiqDvs/DtOnrs609YyMujAjSoy9aKswzlOV/iCIACiD7npz7bs7dVTsxU3NVsQ==
X-Received: by 2002:aed:3847:: with SMTP id j65mr3374087qte.124.1570624404035;
        Wed, 09 Oct 2019 05:33:24 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4529:c1e2:44b7:b11c? ([2001:4898:a800:1012:f65c:c1e2:44b7:b11c])
        by smtp.gmail.com with ESMTPSA id w14sm776686qki.73.2019.10.09.05.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 05:33:23 -0700 (PDT)
Subject: Re: I just pulled, and git log --graph does not show all
To:     Uwe Brauer <oub@mat.ucm.es>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git <git@vger.kernel.org>
References: <87sgomyows.fsf@mat.ucm.es> <20191008230130.GE29845@szeder.dev>
 <871rvmsaxn.fsf@mat.ucm.es>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3a8158f4-03d6-820d-c7b1-ca27b5261863@gmail.com>
Date:   Wed, 9 Oct 2019 08:33:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <871rvmsaxn.fsf@mat.ucm.es>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/9/2019 2:13 AM, Uwe Brauer wrote:
> 
>    > On Tue, Sep 24, 2019 at 12:22:27PM +0200, Uwe Brauer wrote:
> 
>    > I hear you: I had a brief encounter with Mercurial not that long ago, 
>    > and there were several things that didn't work the way I expected (or 
>    > rather: the way I got used to with Git).  The subtle and sometimes
>    > not-so-subtle differences between the concepts and philosophy of the
>    > two systems might very well explain why Git didn't work the way you
>    > expected.
> 
>    > However, it's impossible to give any explanation or advice without
>    > knowing more about the situation, e.g. at least the exact commands
>    > that you run and what they outputted, if you still have them or at
>    > least if you can still reproduce the issue. (with potentially
>    > sensitive URLs and/or branchnames redacted, if necessary).
> 
> Thanks for your answer.
> 
> Could you please try out 
> git clone https://git.code.sf.net/p/matlab-emacs/src matlab-emacs-hg
> 
> Then you will see
> 
> That 
> git log --graph
> and
> 
> git log --graph --all
> 
> Are giving two different results and I don't understand why the branch
> is not shown when using 
> 
> git log --graph
> 
> Funny thing is when I use the hg-git plugin and run 
> 
> hg clone https://git.code.sf.net/p/matlab-emacs/src matlab-emacs-hg
> 
> I see this branch, converted to a hg bookmark.

"git log --graph" has an implicit "HEAD" added on the end, to say
"start walking from my current commit". The "--all" says "walk from
all refs", so the set of commits to walk is larger.

"git log" defaults to showing history from your current position in
history, so you can look at the recent commits that you have created
or what changes led to your current state. Adding the "--all" gives
you a higher-level view of the repository, but can be very noisy
when trying to discover what has happened for your current state.

In particular, say you are trying to dig into a bug in Git 2.23.0.
A "git checkout v2.23.0" will change your HEAD to be at the commit
used to build that version. You can use "git log" to view the
history leading to that release, and see if you can determine recent
changes that would have caused a regression. If you use "git log --all",
then the commits in the "master" branch will appear before your
current HEAD, and you'll be looking at commits that "haven't happened
yet" according to your current place in history.

I hope this helps.

-Stolee

