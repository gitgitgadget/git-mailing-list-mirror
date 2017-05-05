Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A61A5207B3
	for <e@80x24.org>; Fri,  5 May 2017 17:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750829AbdEERWZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 13:22:25 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36563 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750784AbdEERWX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 13:22:23 -0400
Received: by mail-pg0-f65.google.com with SMTP id 12so1557847pgc.3
        for <git@vger.kernel.org>; Fri, 05 May 2017 10:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=v2YnR11qv41M8LdFkUNwttJgNjx01EyKVWbCmXW6DIE=;
        b=G0rVYtHo462cyWWcppKojvb8b3Gp2IVM9xhahy3aRHHQpGOvWtuqu9afDPLS7mV5wb
         qDYcybJDMbzHPO5kCr4H0e7s1OKs0qjSYVIwPRpb6/WLyUK7h+ulxWrGkC/DcffkYe1R
         wrpTk8FryW4iXTZwjbJlF3nasD/wpSAie7xRkequF7SM5UnHjC1BZSQoEQUnpeKnM5ps
         V9OnpZT2AUoQiTmVpKkxV+wOopaVXucRLQAiaOWLv8+zOmd6XgFVCJpQNdE5KlXUfez0
         svW6PxAVFozBGE5oPax8m+3joshm+kRYurJGXWA7lxv2psh1pIEsnl1PDjyBcRzstAjt
         z/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=v2YnR11qv41M8LdFkUNwttJgNjx01EyKVWbCmXW6DIE=;
        b=LBLfWJWenYW2fQSJq537FzyAFvn0QSrvFuQbYPDYL7E7QYdHSzIKQiV+XgMrMuiq7s
         LmJxNY4lFKkaRIP2gv4mylG6Vdn+6PZ+pV+295QZimXCHcczV1txhvkbqsaqCGbEjdOW
         IeZDb4go/KwMRYEJdlVhB7ObVdQvuXlXGi61zICzMdjuDbQmppsq1XxxIxNynJJ99K+3
         VBW3+5d7tVkZDq4u81GAPESiiJxUcgZ9eWOaSOnHlkhJ8FKi0EJL8VIQR0z9V23e9aOf
         WObwAuhrcm+WGNE4HvLpHIBxEtJcDPgi9Ns3sXAUCl2Vmu7X6YRYEaiyJMAUkoXO4B8j
         Qb4g==
X-Gm-Message-State: AN3rC/7HdHUvx4P5zPxNd1upWeH2sSkueoK9TifCCdCq1BKfvJWYHaeQ
        JWg/jCm/sLa80g==
X-Received: by 10.99.125.29 with SMTP id y29mr4728612pgc.163.1494004942888;
        Fri, 05 May 2017 10:22:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:aca8:b828:d7c5:8258])
        by smtp.gmail.com with ESMTPSA id t19sm1605064pfg.31.2017.05.05.10.22.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 May 2017 10:22:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/5] Start of a journey: drop NO_THE_INDEX_COMPATIBILITY_MACROS
References: <20170501190719.10669-1-sbeller@google.com>
        <xmqq7f20f3a8.fsf@gitster.mtv.corp.google.com>
        <CACsJy8AZevgFda4ZJAmH_Nyrtuk72FUjdk6B8_SJB=n6quPnbw@mail.gmail.com>
        <xmqqa86tbamh.fsf@gitster.mtv.corp.google.com>
        <20170504191927.GB15203@aiede.svl.corp.google.com>
Date:   Fri, 05 May 2017 10:22:21 -0700
In-Reply-To: <20170504191927.GB15203@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Thu, 4 May 2017 12:19:27 -0700")
Message-ID: <xmqq8tmb8bhu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> That is, one way to do what this series attempts would be the
> following:
>
>  1. rename variables that shadow the_index.

No question about this one.  It is a good thing to do.

>  2. add coccinelle patches (or one coccinelle patch) to
>     contrib/coccinelle implementing *_cache -> *_index migration.
>     Is there a way to do this without making it fail "make coccicheck"?

Quite honestly, I do not see much value in this, but take it merely
as my knee-jerk reaction.  The only scenario I can think of in which
dropping *_cache() macros is an improvement as the end result is
when our goal is to completely drop the singleton index_state
instance, aka "the_index".  I actually think that it may be a
worthwhile goal to eradicate "the_index".

I wonder if somebody can take a small example codepath and make it
not to rely on the existence of "the_index" from start to end?  Have
an instance of index_state on the stack of cmd_foo(), have it call
read_index() into it where it currently calls read_cache(), update
the support functions it calls so that it can pass the pointer to
its index_info throughout the callchain, and see how involved the
necessary changes of all of the above are.  Start from something
simple and small, e.g. "ls-files".  The infrastructure code updated
for such an experiment may be NO_THE_INDEX_COMPATIBILITY_MACROS
clean.

Perhaps we can remove the existence of the_index from the system by
going that route; needless to say, when that goal is achieved, by
definition *_cache() macros will be completely useless and must be
removed, as there is nobody who relies on the existence of and who
uses "the_index".

>  3. migrate library code (but not builtins) using that semantic patch

I do think this is going backwards.  The only thinng replacing
*_cache() to *_index(&the_index) buys you is newbies not having to
know both, but instead they will be exposed to the pattern of
repeated use of *_index(&the_index); i.e. reliance of the existence
of the singleton "the_index" is not reduced, but is stressed which
is a big downside when we are trying to eventually get rid of it.

Also quite honestly, I do not think we want newbies to be touching
the things that needs *_index() interface while this update is going
on.

The remainder of your enumeration goes in a direction different from
getting rid of the_index, so I do not know---I wrote the above under
the assumption that the total removal of "the_index" might be a good
thing to do, and where that assumption would lead us to (e.g. an
obvious side-effect of no longer having the_index is that *_cache()
macros cannot exist), and I am undecided if the assumption is a good
one (yet).


