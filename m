Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA30820954
	for <e@80x24.org>; Tue, 28 Nov 2017 23:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbdK1XG3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 18:06:29 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:38149 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750904AbdK1XG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 18:06:28 -0500
Received: by mail-it0-f51.google.com with SMTP id r6so1832192itr.3
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 15:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MRY6+AdhaVfcS8rpBTINRWJAyZu0nMWi5NGugFy+wfg=;
        b=oRaYaVJNafZjcYS+OpX+9PydbV8DjAfnujwvtl8dzVtNn427pjP24TK8/VI7TjeUVv
         lGb2Q25YNMqkqdOT8N/9Nfxtv4HRzAOs1aNzRWgnz3CLuru7ryj7W3ZnZ2MORiC9eieH
         WkbOdy2SulqfMSAiS9CY/n4+pjzTVHcDW/eZQcPQllTnm0ChwrGgxDOHuHfayq1QSABM
         tm2br7aSpGUwokM1pks5H0uZ0YAMUNt2pYdfc5puyyBFLwbuDjBqWte6/ivkw/9bKxTv
         1eEN5NV8Jd7fMsIAhWXr5K4e73p2AeEtiaKQOApPrZ/cB/ljK/tN2fuft1LUZ+RWOfwn
         kUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MRY6+AdhaVfcS8rpBTINRWJAyZu0nMWi5NGugFy+wfg=;
        b=UQFwc8DnZHF15kFdnH9FUKfKYV3Mn0qocucxII8lKzk40g+I94qe5xtKe4gBOUmq1m
         LwYfU1Moa1mwL1SHaVJ4TUeaUYVakwCfFvVh8Et0450oLu4+peoOYhEkT5G71swy4o5l
         iHUgtWDRdOUeu02t5vGv9jcijj/jTkqJiICzAtm0M3hFdiLEhrSUz+aT6BTrASjzD8ve
         kuhn9lXXQBHt5te2fl+BVOpIIcZuGjbTEbjZOKrTcWxGt3DbPBQ9xE/YWu4W3cyDmife
         hA93pDvuGi5b0N+x+Ha5e1GygzMaPtz63zlRXREI0+rw851V7AWwGozTZsumh/suBa1r
         WA7w==
X-Gm-Message-State: AJaThX5mDOruvG9PK+duP/djBhhnPY69qE0KGm0qA7RG7qdqy7YxNR+i
        dhWn4kKQgaJsTOJ42wUv0rkL6Q==
X-Google-Smtp-Source: AGs4zMbqnNfDOIGz+9+1YpHAy7UjOJoGTNWaOj1TfjubhlrT5O5pw5ioy4SMws7MMyCTbZxglIWlpg==
X-Received: by 10.36.228.15 with SMTP id o15mr4668430ith.46.1511910386838;
        Tue, 28 Nov 2017 15:06:26 -0800 (PST)
Received: from google.com ([2620:0:100e:422:d514:add4:62c9:d57f])
        by smtp.gmail.com with ESMTPSA id n184sm327713itg.9.2017.11.28.15.06.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Nov 2017 15:06:25 -0800 (PST)
Date:   Tue, 28 Nov 2017 15:06:24 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: Bug in pathspec handling (in conjunction with submodules)
Message-ID: <20171128230624.GA194092@google.com>
References: <alpine.DEB.2.21.1.1711260210060.6482@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1711260210060.6482@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/26, Johannes Schindelin wrote:
> Hi Duy & Brandon,
> 
> in 74ed43711fd (grep: enable recurse-submodules to work on <tree> objects,
> 2016-12-16), the do_match() function in tree-walk.c was changed so that it
> can recurse across submodule boundaries.
> 
> However, there is a bug, and I *think* there may be two bugs actually. Or
> even three.
> 
> First of all, here is an MCVE that I distilled from
> https://github.com/git-for-windows/git/issues/1371:
> 
> 	git init repo
> 	cd repo
> 
> 	git init submodule
> 	git -C submodule commit -m initial --allow-empty
> 
> 	touch "[bracket]"
> 	git add "[bracket]"
> 	git commit -m bracket
> 	git add submodule
> 	git commit -m submodule
> 
> 	git rev-list HEAD -- "[bracket]"
> 
> Nothing fancy, just adding a file with brackets in the name, then a
> submodule, then showing the commit history filtered by the funny file
> name.
> 
> However, the log prints *both* commits. Clearly the submodule commit
> should *not* be shown.
> 
> Now, how does this all happen?
> 
> Since the pathspec contains brackets, parse_pathspec() marks it as
> containing wildcards and sets nowildcard_len to 0.
> 
> Now, note that [bracket] *is* a wildcard expression: it should only match
> a single character that is one of  a, b, c, e, k, r or t.
> 
> I think this is the first bug: `git rev-list` should not even match the
> commit that adds the file [bracket] because its file name does not match
> that expression. From where I sit, it would appear that f1a2ddbbc2d
> (tree_entry_interesting(): optimize wildcard matching when base is
> matched, 2010-12-15) simply added the fnmatch() code without disabling the
> literal match_entry() code when the pathspec contains a pattern.

I can see both sides to this, wanting to try matching literally first
and then trying the wildcards, so I don't really have an opinion on
how/if we should fix that.

> 
> But it does not stop there: there is *another* bug which causes the
> pattern to somehow match the submodule. I *guess* the idea of
> https://github.com/git/git/commit/74ed43711#diff-7a08243175f2cae66aedf53f7dce3bdfR1015
> was to allow a pattern like *.c to match files in a submodule, but the
> pattern [bracket] should not match any file in submodule/. I think that
> that code needs to be a little bit more careful to try to match the
> submodule's name against the pattern (it seems to interpret nowildcard_len
> == 0 to mean that the wildcard is `*`).

This is a much bigger issue and I'm surprised it took this long to find
this bug.  And of course its due to one of my earlier contributions to
the project :)

> 
> However, the commit introducing that code wanted to teach *grep* (not
> *rev-list*) a new trick, and it relies on the `recursive` flag of the
> pathspec to be set.

This is the root cause of the bug.  The added code to match against
submodules was intended to allow for matching past submodule boundaries
for those commands (like grep) which are recursing submodules.  So
really there should be an additional flag which is passed in to trigger
this logic instead of relying on the recursive flag of the pathspec.  Or
we can add a recurse_submodules flag to the pathspec struct and respect
that flag instead of the 'recursive' flag.

I have a quick patch to do just that which I'll send shortly.

> 
> And now it gets really interesting. Or confusing, depending on your mental
> condition. This recursive flag of the pathspec is set in
> ll_diff_tree_paths() (yep, changing the flag in the passed-in opt
> structure... which I found a bit... unexpected, given the function name, I
> would have been less surprised if that function only diff'ed the trees and
> used the options without changing the options). That flag-change was
> introduced in
> https://github.com/git/git/commit/bc96cc87dbb2#diff-15203e8cd8ee9191113894de9d97a8a6R149
> which is another patch that changed the tree diff machinery to accommodate
> `git grep` (but maybe not really paying a lot of attention to the fact
> that the same machinery is called repeatedly by the revision machinery,
> too).
> 
> I am really confused by this code mainly due to the fact that the term
> "recursive" is pretty ambiguous in that context: does it refer to
> directories/tree objects, or to submodules? I guess it is used for both
> when there should be two flags so that rev-list can recurse over tree
> objects but not submodules (unless told to do so).
> 
> The problem, of course, is that `git rev-list HEAD -- '[bracket]'` never
> recurses into the submodule. And therefore, the promised "more accurate
> matching [...] in the submodule" is never performed. And the commit adding
> the submodule is never pruned.
> 
> Since I am not really familiar with all that tree diff code (and as a
> general rule to protect my mental health, I try my best to stay away from
> submodules, too), but you two are, may I ask you gentle people to have a
> closer look to fix those bugs?
> 
> Thanks,
> Dscho

-- 
Brandon Williams
