Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E63711F661
	for <e@80x24.org>; Wed, 12 Jul 2017 20:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbdGLUac (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 16:30:32 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36222 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753175AbdGLUa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 16:30:29 -0400
Received: by mail-wm0-f51.google.com with SMTP id 62so4988537wmw.1
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 13:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Ny0SJaz/KscxfPilntobm/1KibGov9VHgV7+WlK5Kmo=;
        b=ee3W/SX1tcmjvzRhOu3Je6/6+MWLvOBOrzEDCVyoQBCdyTPj+RSRs+d/56K7UbUxap
         S0FcUQoMK8IAAgGqwGdvbgLATsFrIAwGzwA69tdiiX8Z5hvMmCUrSbM+EsFWvqrkblcC
         r4WqkDLOfmyVAY7IXeA2gzcn8ZzyDX11Zix6uDaTFeQJZn6wSJ2ixqLeiqioyYVfA6uD
         G+e5SkcUEZOUmU7eiPhLVDopY6uYoPu3yHiGlscF4a4BvQqbrbKNz9mpmmwZx85anRTo
         Fvo4Z6XcNLXHgVLZ0UJkC0LbK1YHQ51TO2DVEu4FXcW0Y17o/LGIZE9DiFfYX+kMGcFQ
         ku7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Ny0SJaz/KscxfPilntobm/1KibGov9VHgV7+WlK5Kmo=;
        b=BKbHcMNl1Dsa6e9TVfnb9yyBk/500YuCO4zs/H/VI6d3yvWS+k3HcV4H8osQGRqOWi
         T7HIM4s52wrXeHPmdWtlLyhpAQmkPPjv+usZD8XZPtwNG9K+6EApttdmWad2UZ0Stk5m
         054ZoMBa2KtY/Dq48XuxP5r5WPLz3NYreWTN0Zc1+lspeu9eJfTf4ehTmHLSy81Jn7bg
         RtHB1HrEmhuUDCr51tHNM5MPi0bXNVM/aF6o2SlocH0A8IGCb6Nn2mHQ+XpLRqEbhlbP
         vCbOm4QNbWjKpSD+y+LznpAkHQmAb/JG9Q4vZA7vnkmZDWhINMd2qb4Eltbe32uXNIyu
         mYwQ==
X-Gm-Message-State: AIVw113JJufUJnvnuv7dyNrBvaO/bhAnEne2FZYTL6szKZg9dTaRwNdR
        JRGQjCod+2PLJWmn8Ac=
X-Received: by 10.28.55.5 with SMTP id e5mr3997086wma.32.1499891428097;
        Wed, 12 Jul 2017 13:30:28 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id c2sm2727950wre.22.2017.07.12.13.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jul 2017 13:30:26 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dVOHB-0005ul-DD; Wed, 12 Jul 2017 22:30:25 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: git gc --auto aquires *.lock files that make a subsequent git-fetch error out
References: <20130126224038.GA20849@sigill.intra.peff.net> <87bmopzbqx.fsf@gmail.com> <20170712200054.mxcabiyttijpbkbb@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20170712200054.mxcabiyttijpbkbb@sigill.intra.peff.net>
Date:   Wed, 12 Jul 2017 22:30:25 +0200
Message-ID: <87a849z9cu.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 12 2017, Jeff King jotted:

> On Wed, Jul 12, 2017 at 09:38:46PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> In 131b8fcbfb ("fetch: run gc --auto after fetching", 2013-01-26) first
>> released with v1.8.2 Jeff changed git-fetch to run "git gc --auto"
>> afterwards.
>>
>> This means that if you run two git fetches in a row the second one may
>> fail because it can't acquire the *.lock files on the remote branches you
>> have & which the next git-fetch needs to update.
>
> Is it really "in a row" that's a problem? The second fetch should not
> begin until the first one is done, including until its auto-gc exits.
> And even with background gc, we do the ref-locking operations first, due
> to 62aad1849 (gc --auto: do not lock refs in the background,
> 2014-05-25).
>
>> I happen to run into this on a git.git which has a lot of remotes (most
>> people on-list whose remotes I know about) and fetch them in parallel:
>>
>>     $ git config alias.pfetch
>>     !parallel 'git fetch {}' ::: $(git remote)
>
> Ah, so it's not in a row. It's parallel. Then yes, you may run into
> problems with the gc locks conflicting with real operations. This isn't
> really unique to fetch. Any simultaneous operation can run into problems
> (e.g., on a busy server repo you may see conflicts between pack-refs and
> regular pushes).

This is what I thought at first, and I've only encountered the issue in
this parallel mode (mainly because it's tedious to reproduce). But I
think the traces below show that it would happen with "git fetch --all"
& "git remote update" as well, so the parallel invocations didn't
matter.

I.e. I'd just update my first remote, then git-gc would start in the
background and lock refs for my other remotes, which I'd then fail to
update.

>> And so would 'git fetch --all':
>>
>>     $ GIT_TRACE=1 git fetch --all 2>&1|grep --line-buffered built-in|grep -v rev-list
>>     19:31:26.273577 git.c:328               trace: built-in: git 'fetch' '--all'
>>     19:31:26.278869 git.c:328               trace: built-in: git 'fetch' '--append' 'origin'
>>     19:31:27.993312 git.c:328               trace: built-in: git 'gc' '--auto'
>>     19:31:27.995855 git.c:328               trace: built-in: git 'fetch' '--append' 'avar'
>>     19:31:29.656925 git.c:328               trace: built-in: git 'gc' '--auto'
>>
>> I think those two cases are bugs (but ones which I don't have the
>> inclination to chase myself beyond sending this E-Mail). We should be
>> running the 'git gc --auto' at the very end of the entire program, not
>> after fetching every single remote.
>>
>> Passing some env variable (similar to the config we pass via the env) to
>> subprograms to make them avoid "git gc --auto" so the main process can
>> do it would probably be the most simple solution.
>
> Yes, I agree that's poor. Ideally there would be a command-line option
> to tell the sub-fetches not to run auto-gc. It could be done with:
>
>   git -c gc.auto=0 fetch --append ...
>
> Or we could even take the "--append" as a hint not to run auto-gc.
>
>> The more general case (such as with my parallel invocation) is harder to
>> solve.
>
> Yes, I don't think it can solved. The most general case is two totally
> unrelated processes which know nothing about each other.
>
>> Maybe "git gc --auto" should have a heuristic so it checks whether
>> there's been recent activity on the repo, and waits until there's been
>> say 60 seconds of no activity, or alternatively if it's waited 600
>> seconds and hasn't run gc yet.
>
> That sounds complicated.
>
>> Ideally a "real" invocation like git-fetch would have a way to simply
>> steal any *.lock a background "git gc --auto" creates, aborting the gc
>> but allowing the "real" invocation to proceed. But that sounds even
>> trickier to implement, and might without an extra heuristic on top
>> postpone gc indefinitely.
>
> The locks are generally due to ref-packing and reflog expiration.  I
> think in the long run, it would be nice to move to a ref store that
> didn't need packing, and that could do reflog expiration more
> atomically.
>
> I think the way "reflog expire" is done holds the locks for a lot longer
> than is strictly necessary, too (it actually computes reachability for
> --expire-unreachable on the fly while holding some locks).
>
> -Peff
