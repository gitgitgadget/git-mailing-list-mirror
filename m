Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 424AA2035A
	for <e@80x24.org>; Tue, 11 Jul 2017 18:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756283AbdGKSaq (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 14:30:46 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:38263 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756085AbdGKSap (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 14:30:45 -0400
Received: by mail-it0-f48.google.com with SMTP id k192so247256ith.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 11:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=646s5Ofkkzd+Lq4M/B6a90PAvhaEM+jpnU2UwR6ldD4=;
        b=fd17xYppzAp23O7jTTWxjNRVc3+DgWLjo0pAj8I9tXcw4CmWwDOM+iJ7g9qlX8qEai
         N2LycbJf5ZcoBLWSRDxs4Ib/LM8XMWY1b+o/Oqs5Oe/zG0xiEh8Kd+Epa9XZxBVxhAJI
         Welf79uryO7PuJfG5tn+aRBxwjEgUqthl4BixsFRQ35jW/Y5FKATs0dvM5tjTRlLrD3t
         kQuJop1x6IuUJj0A6oTHO23eBiswKZGNRjF35inAOdOnjCgB8KEmTWkyN2F66D7gXwp2
         beqhTszmotixbgytlCKkVKuQuDW/2QjCSgdGhDpreMUJ71ZDIQL12V0ceUad8zbt4NcX
         xc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=646s5Ofkkzd+Lq4M/B6a90PAvhaEM+jpnU2UwR6ldD4=;
        b=RdpszcLpEtr9RQ5uSa5J8BQBNTYesKjM75b5avPDsTMMt9W8BApapYIpO9LNgDnn/A
         /fm8qwHPtb3PPJM+xSiME7K6292heHeiQdyv0WXQAimZ+27rDBuukmjSlOUD/NUaPpqh
         3Mmqt9II88idK1SWB5Ewd8NOifRqh4CbwEn91FwHD9QkxO+rGJS3A1FI/uy0ChbU4NeJ
         SA7FYz2n/jZdD0u0LUQZ170Ua+QITc29IdiLOo7ZnQ7mG5qtgvMLAe4CwGanXpxoPIGi
         QoR+3hXwlsS4TznTuwcid1Zi2Za0WxeEqPCzugmq01D5MDzYUcE8KfS+RYQAzAHxR6m2
         xeBA==
X-Gm-Message-State: AIVw1126lObxFGS8d1rc7PpVdIPe8eFpjLOYIsRcaBluAucao2yxMkmG
        4BMxS6zqOWqWu8ZfWIbZI1LHVX8H0A==
X-Received: by 10.36.172.77 with SMTP id m13mr17641710iti.59.1499797844379;
 Tue, 11 Jul 2017 11:30:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.26.138 with HTTP; Tue, 11 Jul 2017 11:30:43 -0700 (PDT)
In-Reply-To: <CAGZ79kb6-cDo8tmLdJzY=xd-SM_sM0aM9B6=vcKv6DWspmK7vQ@mail.gmail.com>
References: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
 <xmqqh8yi3mur.fsf@gitster.mtv.corp.google.com> <CAEcERAzRMo+fRPbc3_MAU2XgKUyaLAeCVsZvCr9FbSjo7u+MfA@mail.gmail.com>
 <CAGZ79kb6-cDo8tmLdJzY=xd-SM_sM0aM9B6=vcKv6DWspmK7vQ@mail.gmail.com>
From:   Nikolay Shustov <nikolay.shustov@gmail.com>
Date:   Tue, 11 Jul 2017 14:30:43 -0400
Message-ID: <CAEcERAypv3x7rFx8sRHyLV0vtn=vBYzjEF9ykJT19YNCAh6JBQ@mail.gmail.com>
Subject: Re: "groups of files" in Git?
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for #3.
As for 1+2, the documentation says:

"Each line in gitattributes file is of form:

pattern attr1 attr2 ...

...
When the pattern matches the path in question, the attributes listed
on the line are given to the path."

My understanding is that to have the bunch of the files in the
separate directories having the same attribute, I would have to, for
each file, create a separate gitattributes line with the exact
paths/filename and needed attribute. Is it would you are suggesting or
I misunderstood the idea?


On Tue, Jul 11, 2017 at 2:19 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Jul 11, 2017 at 11:10 AM, Nikolay Shustov
> <nikolay.shustov@gmail.com> wrote:
>> Thank you for the explanation. The example about backend and frontend
>> is relevant even though I normally have to deal with more layers at
>> the same time.
>>
>> However, in my case I have the thing that you have already tried to
>> address, partially: the changes always align with file boundaries BUT
>> not with directory boundaries. Imagine you have the stack of backend,
>> data transport and frontend layers. The feature has to touch all three
>> layers thus resulting in the changes in the apparently different
>> directories. Thus, making the distinction by the pathspec (if I
>> understood it right from reading the documentation) would not help.
>>
>> The attributes could be a solution, if I could:
>> 1. create attribute designated to the feature
>> 2. "mark" uncommitted files in different directory with that attribute
>
> 1+2 should be answered by the gitattributes man page
> https://git-scm.com/docs/gitattributes
>
>
>> 3. filter the list of unchanged files with such attribute
>
> This sounds like one of
>   "git status :(attr:backend) ."
>   "git status :(exclude,attr:backend) ."
>
>> 4. create commit for the files only with the certain attribute
>>
>> You've kindly demonstrated that #4 is doable; however I could not
>> clearly get for the Git documentation if #1 - #3 are achievable...
>> Could you point me to the right place in the documentation, please?
>>
