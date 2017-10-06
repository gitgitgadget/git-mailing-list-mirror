Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38DA51FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 17:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbdJFRJQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 13:09:16 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:65148 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751489AbdJFRJP (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Oct 2017 13:09:15 -0400
X-AuditID: 12074413-38bff70000007929-88-59d7b8ba1a06
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 7D.2E.31017.AB8B7D95; Fri,  6 Oct 2017 13:09:14 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCDED.dip0.t-ipconnect.de [87.188.205.237])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v96H9B9F016424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 6 Oct 2017 13:09:12 -0400
Subject: Re: [PATCH 2/2] refs_resolve_ref_unsafe: handle d/f conflicts for
 writes
To:     Jeff King <peff@peff.net>, Andreas Krey <a.krey@gmx.de>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>
References: <20171006143745.w6q2yfgy6nvd2m2a@sigill.intra.peff.net>
 <20171006144217.y6oxux26hh2fb7og@sigill.intra.peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <38c17fdc-7a3b-d166-1abe-afe64fc823c5@alum.mit.edu>
Date:   Fri, 6 Oct 2017 19:09:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171006144217.y6oxux26hh2fb7og@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsUixO6iqLtrx/VIgwnLRSyWHetktOi60s1k
        0dB7hdmie8pbRosfLT3MDqweO2fdZff48DHO41nvHkaPi5eUPT5vkgtgjeKySUnNySxLLdK3
        S+DK6Nl9ga1gglrFzi2/WRsYF8p2MXJySAiYSCxc9Yqpi5GLQ0hgB5PE38VHGSGc80wSPbu7
        mUCqhAWCJeZPbWAEsUUErCUutc5kByliFpjGKPHv1nZWkISQQK3E55XXwRrYBHQlFvU0g9m8
        AvYSS/e8AbI5OFgEVCR6D6aDmKICERIbNvJDVAhKnJz5hAXE5hRwkdj0rZ8ZxGYWUJf4M+8S
        lC0ucevJfCYIW15i+9s5zBMYBWYhaZ+FpGUWkpZZSFoWMLKsYpRLzCnN1c1NzMwpTk3WLU5O
        zMtLLdI118vNLNFLTSndxAgJe+EdjLtOyh1iFOBgVOLhNVx7PVKINbGsuDL3EKMkB5OSKK/8
        JqAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd5nk4FyvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJ
        JanZqakFqUUwWRkODiUJXr/tQI2CRanpqRVpmTklCGkmDk6Q4TxAw/VAaniLCxJzizPTIfKn
        GBWlxHnzQBICIImM0jy4XlhaesUoDvSKMG8cSBUPMKXBdb8CGswENHhO0xWQwSWJCCmpBsbA
        Q5cn3RVLKlAp2Xt8Qfofw7bGKacbHp/oulireuh4okNXpTGnvD73yqMWs86cFg427Y3kUlzE
        IMujPJ/Vu3ntOsPf4Y2e8ZfuSIpN/povWun2tsJuR/9Lro87TsxfIrNZzkKpadO085tf7AgJ
        +ZrHIbc3f6by2YJZt9LS/1Y5vH/w699RcTclluKMREMt5qLiRAAwToKiJgMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/06/2017 04:42 PM, Jeff King wrote:
> If our call to refs_read_raw_ref() fails, we check errno to
> see if the ref is simply missing, or if we encountered a
> more serious error. If it's just missing, then in "write"
> mode (i.e., when RESOLVE_REFS_READING is not set), this is
> perfectly fine.
> 
> However, checking for ENOENT isn't sufficient to catch all
> missing-ref cases. In the filesystem backend, we may also
> see EISDIR when we try to resolve "a" and "a/b" exists.
> Likewise, we may see ENOTDIR if we try to resolve "a/b" and
> "a" exists. In both of those cases, we know that our
> resolved ref doesn't exist, but we return an error (rather
> than reporting the refname and returning a null sha1).
> 
> This has been broken for a long time, but nobody really
> noticed because the next step after resolving without the
> READING flag is usually to lock the ref and write it. But in
> both of those cases, the write will fail with the same
> errno due to the directory/file conflict.
> 
> There are two cases where we can notice this, though:
> 
>   1. If we try to write "a" and there's a leftover directory
>      already at "a", even though there is no ref "a/b". The
>      actual write is smart enough to move the empty "a" out
>      of the way.
> 
>      This is reasonably rare, if only because the writing
>      code has to do an independent resolution before trying
>      its write (because the actual update_ref() code handles
>      this case fine). The notes-merge code does this, and
>      before the fix in the prior commit t3308 erroneously
>      expected this case to fail.
> 
>   2. When resolving symbolic refs, we typically do not use
>      the READING flag because we want to resolve even
>      symrefs that point to unborn refs. Even if those unborn
>      refs could not actually be written because of d/f
>      conflicts with existing refs.
> 
>      You can see this by asking "git symbolic-ref" to report
>      the target of a symref pointing past a d/f conflict.
> 
> We can fix the problem by recognizing the other "missing"
> errnos and treating them like ENOENT. This should be safe to
> do even for callers who are then going to actually write the
> ref, because the actual writing process will fail if the d/f
> conflict is a real one (and t1404 checks these cases).
> 
> Arguably this should be the responsibility of the
> files-backend to normalize all "missing ref" errors into
> ENOENT (since something like EISDIR may not be meaningful at
> all to a database backend). However other callers of
> refs_read_raw_ref() may actually care about the distinction;
> putting this into resolve_ref() is the minimal fix for now.
> 
> The new tests in t1401 use git-symbolic-ref, which is the
> most direct way to check the resolution by itself.
> Interestingly we actually had a test that setup this case
> already, but we only used it to verify that the funny state
> could be overwritten, not that it could be resolved.
> 
> We also add a new test in t3200, as "branch -m" was the
> original motivation for looking into this. What happens is
> this:
> 
>   0. HEAD is pointing to branch "a"
> 
>   1. The user asks to rename "a" to "a/b".
> 
>   2. We create "a/b" and delete "a".
> 
>   3. We then try to update any worktree HEADs that point to
>      the renamed ref (including the main repo HEAD). To do
>      that, we have to resolve each HEAD. But now our HEAD is
>      pointing at "a", and we get EISDIR due to the loose
>      "a/b". As a result, we think there is no HEAD, and we
>      do not update it. It now points to the bogus "a".
> 
> Interestingly this case used to work, but only accidentally.
> Before 31824d180d (branch: fix branch renaming not updating
> HEADs correctly, 2017-08-24), we'd update any HEAD which we
> couldn't resolve. That was wrong, but it papered over the
> fact that we were incorrectly failing to resolve HEAD.
> 
> So while the bug demonstrated by the git-symbolic-ref is
> quite old, the regression to "branch -m" is recent.

Thanks for your detailed investigation and analysis and for the new tests.

This makes sense to me at the level of fixing the bug.

I do have one twinge of uneasiness at a deeper level, that I haven't had
time to check...

Does this patch make it easier to *set* HEAD to an unborn branch that
d/f conflicts with an existing reference? If so, that might be a
slightly worse UI for users. I'd rather learn about such a problem when
setting HEAD (when I am thinking about the new branch name and am in the
frame of mind to solve the problem) rather than later, when I try to
commit to the new branch.

Even if so, that wouldn't be a problem with this patch per se, but
rather a possible accidental side-effect of fixing the bug.

Michael

> [...]
