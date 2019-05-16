Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC1921F461
	for <e@80x24.org>; Thu, 16 May 2019 01:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfEPBqY (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 21:46:24 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:38364 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfEPBOf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 21:14:35 -0400
Received: by mail-qk1-f176.google.com with SMTP id a64so1267930qkg.5
        for <git@vger.kernel.org>; Wed, 15 May 2019 18:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pExmcxiScxUcFeI6zybdEVQxC+cjD0e8gmV0ENI9UmE=;
        b=EOenvPSFYbYhUdtLsLtH6YxISjbM0708MuKDiI4gIBNPbyuHrC/8Gmbs2m0iudN+AK
         V/VXQlYhhjWR6te3G/YQon+y2DD7xThvCDFsP0laFzSpO15tA2VAV4iv7e5NarsVmszd
         iGlV8lg1xKJTpsf+Pdpuxjhz8qL6jZTG3rkE8b3sPxDDGADKMb4mqkdDcGUfdjSlfCii
         0NdJKDmrHFGTe9/oxRDGmyNQSMQBETK6XQOVtHEChInpoOTqKXdnDqWmjWlzS88qUm0C
         USX85zUJj6eSnQ6fcXmhW3nzxLRZ65O1DI5fpegbE1QWU09I7Hz6OnwLMmcTHoOqJt0X
         VnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pExmcxiScxUcFeI6zybdEVQxC+cjD0e8gmV0ENI9UmE=;
        b=G3brQTzoZWIhSMt08at3vRsoVBKZzBUatBqDb8GPJmjxFPJ1T+BTGsM1n9PPJ+Rdzu
         5ZmoGqZphUFyrieigD2nsc3CiJmPpw7zkugO3NLODQ+pAW8zoA9+/X41V2/ELqYR0z29
         koCk3Khrxy1Kc76y0wWe+5B1NchtU8K7IH7fMkM6IqmINVxphkiXLEMc/KD49PcmudH0
         s84HOqPDK5R3NK+Lpjjku8bR1BXsQIUnhsNH6n09UEIqHd3qPw3iGYYzsoZgyeodMib+
         67OzRBHIwVB4RDLFGGVUkQ+hp9QrxmDiKpBmvtq6u2puzIYVGiSDh/8XKOdLuMkjDYoL
         JqmA==
X-Gm-Message-State: APjAAAVl83RLhDz3h1zp03cuX19S93Bnh3ajTqdPW2uT98fiHuL/KeKa
        A6v9jqrfPQXSM21MmN9FCMNl2z51J5o=
X-Google-Smtp-Source: APXvYqwQ847pPofmbZDtlWDxdnQb6MYk6Coux2xc9PhlmfW7RSRO5MmaYjCY3XMnrP1SxSn/vYNcTA==
X-Received: by 2002:a37:6082:: with SMTP id u124mr19048046qkb.144.1557969273522;
        Wed, 15 May 2019 18:14:33 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id a51sm2720286qta.85.2019.05.15.18.14.32
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 18:14:32 -0700 (PDT)
Subject: Re: Finer timestamps and serialization in git
To:     esr@thyrsus.com
Cc:     git@vger.kernel.org
References: <20190515191605.21D394703049@snark.thyrsus.com>
 <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
 <20190515233230.GA124956@thyrsus.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ab3222ab-9121-9534-1472-fac790bf08a4@gmail.com>
Date:   Wed, 15 May 2019 21:14:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190515233230.GA124956@thyrsus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/15/2019 7:32 PM, Eric S. Raymond wrote:
> Derrick Stolee <stolee@gmail.com>:
>> On 5/15/2019 3:16 PM, Eric S. Raymond wrote:
>>> The deeper problem is that I want something from Git that I cannot
>>> have with 1-second granularity. That is: a unique timestamp on each
>>> commit in a repository.
>>
>> This is impossible in a distributed version control system like Git
>> (where the commits are immutable). No matter your precision, there is
>> a chance that two machiens commit at the exact same moment on two different
>> machines and then those commits are merged into the same branch.
> 
> It's easy to work around that problem. Each git daemon has to single-thread
> its handling of incoming commits at some level, because you need a lock on the
> file system to guarantee consistent updates to it.
> 
> So if a commit comes in that would be the same as the date of the
> previous commit on the current branch, you bump the incoming commit timestamp.

This changes the commit, causing it to have a different object id, and
now the client that pushed that commit disagrees with your machine on
the history.

> That's the simple case. The complicated case is checking for date
> collisions on *other* branches. But there are ways to make that fast,
> too. There's a very obvious one involving a presort that is is O(log2
> n) in the number of commits.
> 
> I wouldn't have brought this up in the first place if I didn't have a
> pretty clear idea how to do it in code!
> 
>> Even when you specify a committer, there are many environments where a set
>> of parallel machines are creating commits with the same identity.
> 
> If those commit sets become the same commit in the final graph, this is
> not a problem for total ordering.
> 
>>> Why do I want this? There are number of reasons, all related to a
>>> mathematical concept called "total ordering".  At present, commits in
>>> a Git repository only have partial ordering. 
>>
>> This is true of any directed acyclic graph. If you want a total ordering
>> that is completely unambiguous, then you should think about maintaining
>> a linear commit history by requiring rebasing instead of merging.
> 
> Excuse me, but your premise is incorrect.  A git DAG isn't just "any" DAG.
> The presence of timestamps makes a total ordering possible.
> 
> (I was a theoretical mathematician in a former life. This is all very
> familiar ground to me.)

Same. But you seem to have a fundamental misunderstanding about the immutability
of commits, which is core to how Git works. If you change a commit, then you
get a new object id and now distributed copies don't agree on the history.

>>> One consequence is that
>>> action stamps - the committer/date pairs I use as VCS-independent commit
>>> identifications in reposurgeon - are not unique.  When a patch sequence
>>> is applied, it can easily happen fast enough to give several successive
>>> commits the same committer-ID and timestamp.
>>
>> Sorting by committer/date pairs sounds like an unhelpful idea, as that
>> does not take any graph topology into account. It happens that commits
>> can actually have an _earlier_ commit date than its parent.
> 
> Yes, I'm aware of that.  The uniqueness properties that make a total
> ordering desirable are not actually dependent on timestamp order
> coinciding with topo order.
> 
>> Changing the granularity of timestamps requires changing the commit format,
>> which is probably a non-starter.
> 
> That's why I started by noting that you're going to have to break the
> format anyway to move to an ECDSA hash (or whatever you end up using).
> 
> I'm saying that *since you'll need to do that anyway*, it's a good time
> to think about making timestamps finer-grained and unique.

That change is difficult enough as it is. I don't think your goals justify
making this more complicated. You are also not considering:

 * The in-memory data type now needs to be a floating-point type, or an
   even larger integer type using a different set of units.

 * This data type now affects our priority queues for commit walks, how
   we store the commit date in the commit-graph file, how we compute
   relative dates for 'git log' pretty formats.

-Stolee

