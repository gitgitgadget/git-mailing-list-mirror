Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00C371F404
	for <e@80x24.org>; Fri,  6 Apr 2018 00:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeDFAvn (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 20:51:43 -0400
Received: from connotech.com ([76.10.176.241]:57396 "EHLO mail.connotech.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751274AbeDFAvn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 20:51:43 -0400
Received: from [192.168.1.11] (unknown [192.168.1.11])
        by mail.connotech.com (Postfix) with ESMTPA id 0DA03196E4F;
        Fri,  6 Apr 2018 00:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=connotech.com; s=key3;
        t=1522975902; bh=Bpa32Pmx2os04fDDOpDensZNRr/6bzj6s2aSxwL8fyc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=pVRQlCFVyWom4ICqzjHTk47zr6u/ovTcYObFbhBS/5SM6PxQZ6fL6d8Nxgb9zCIXe
         hyGvr0OFjF4eHsj/E6k0V0ELPluQ2AIii32YVzGDW82RIx/zEmNeRC3+pW8CpL2urR
         VreX6hF+jqczJFTz2bhpdV3xj7rL3VcvU9+WbpJ8=
Message-ID: <5AC6C460.7060005@connotech.com>
Date:   Fri, 06 Apr 2018 00:50:40 +0000
From:   Thierry Moreau <thierry.moreau@connotech.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     Bryan Turner <bturner@atlassian.com>
CC:     Git Users <git@vger.kernel.org>
Subject: Re: Self-inflicted "abort" in a newbie attempt at read-only exploration
 of a cloned repository?
References: <5AC67C43.9080500@connotech.com> <CAGyf7-E9=Mm1oJdhwHTmg2byrOxMRFVEjmYHCFGqqP8pvK=vJg@mail.gmail.com> <CAGyf7-GZgTpYXt4s+NURABYLBr8HQAZWxsrpLLVKnsOf2SYcBQ@mail.gmail.com>
In-Reply-To: <CAGyf7-GZgTpYXt4s+NURABYLBr8HQAZWxsrpLLVKnsOf2SYcBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/04/18 11:34 PM, Bryan Turner wrote:
> On Thu, Apr 5, 2018 at 4:18 PM, Bryan Turner <bturner@atlassian.com> wrote:
>>
>> So passing --work-tree tells Git where to store your _files_, but it's
>> still using the same .git directory.
>>
>> If your goal is to have worktrees for various versions, that implies
>> the git worktree [1] command might be more along the lines of what
>> you're looking for. An invocation based on above might look like this:
>> $ git -C linux-stable/ worktree add $PWD/tmp/ checkout linux-4.15.y
>
> Apologies, I didn't mean to have the "checkout" in that.
> $ git -C linux-stable/ worktree add $PWD/tmp/ linux-4.15.y
>
>>
>> That should leave linux-4.16.y checked out in linux-stable, while
>> creating a full work tree in $PWD/tmp that has 4.15.y checked out.
>>
>> Note that worktree is a newer git command. 2.17 has it, but old
>> versions like 2.1 won't.
>>
>> [1] https://git-scm.com/docs/git-worktree
>>
>> Hope this helps!

For sure, it helps! Thanks.

- Thierry

