Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D77471F403
	for <e@80x24.org>; Thu,  7 Jun 2018 05:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752588AbeFGF1e (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 01:27:34 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:35283 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752565AbeFGF1d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 01:27:33 -0400
Received: by mail-ua0-f195.google.com with SMTP id s13-v6so2205377uad.2
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 22:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=K00uYlnkeLiuL52TA2CJlN16JgJJ16fUuAKsATd4+1g=;
        b=r47ZcwOB7BuJ7V8qo1Puos+lO3FYnGjplQKXQcAYsc9fb9qC5XfGh1w18VwYwnmKu8
         UpuN9IdlXaYUZTRhZZ+fOtaS6xxUjPrw/9xpSbHaJnSbsEoy/doqB0uzWJvFgDcey71b
         BGZP+Nmh+edJuGNelmcshWHgmUFi+dGWr+uPMOWfqkrGVkazqt1ICzdIBAD2/yQiA94Q
         21g2SqAO+zNLl+sJlQvrlaEEMaGKiB7PB/zb7hG4l9G3RXRxDC4uuUNNIE9loMdeIbfj
         6my2hAaGqxQ1WM/xsYV25xzCkI55U8RMVXMB6wGX3dhvcynjT341pDzaeHKpwJO/Zxfk
         3/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=K00uYlnkeLiuL52TA2CJlN16JgJJ16fUuAKsATd4+1g=;
        b=VuRNmrHibMeF1LRSVvJSWUHijFpGY7RIArrv5qTEmfKjqWILvlq9+IWwk04Mz1c6dH
         CF6Pp0UJi8exsSijBPxeaEEhasiIHJWfmvY2VdkJIPKXTzW+6b/v4gTbytp+IO8L+3Z7
         QjF3ifD/jhMGGUfoxwj5yCExCWhsQw+8EFEC/q2BjbZdLxbDADUYgIayb4EpAOL/4oG5
         WHz8eG6z81fi3MtxCcxwDkq9d1boUKZxfWuYXxOP6DkpbJl2tL4Z7kqskVI3Z+ZIP/zr
         rVO8y+XQcvSBK415Z4lkPeIutiQFdYBzonIPEC78y61o7KjaLjnp8sMOne5xoQP8xv/Z
         aCJg==
X-Gm-Message-State: APt69E1YCXOUKNdlSSw6JsvCcfni4BoMPhGo2bmeoM3aLctszcaVDVuR
        BJCqDXCZldI5B99vH/oWNwtHHBfY6MhUeeSFkFk=
X-Google-Smtp-Source: ADUXVKKxoNAvkTNRVKvnT+i+qk2KkdWGI+BxamHi5eIA1uT/0kcG/jik9rr5bdNzOCIePIohfDOSYLQvBUxxZfq6PeE=
X-Received: by 2002:a9f:3091:: with SMTP id j17-v6mr249391uab.23.1528349252002;
 Wed, 06 Jun 2018 22:27:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 22:27:31 -0700 (PDT)
In-Reply-To: <20180603065810.23841-8-newren@gmail.com>
References: <20180603065810.23841-1-newren@gmail.com> <20180603065810.23841-8-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 6 Jun 2018 22:27:31 -0700
Message-ID: <CABPp-BGZiM=9bXHw0_90x43k51rCNRisM9ccGVRVwQxWkntiBA@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] merge: fix misleading pre-merge check documentation
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 2, 2018 at 11:58 PM, Elijah Newren <newren@gmail.com> wrote:
> builtin/merge.c contains this important requirement for merge strategies:
>
>     ...the index must be in sync with the head commit.  The strategies are
>     responsible to ensure this.
>
> However, Documentation/git-merge.txt says:
>
>     ...[merge will] abort if there are any changes registered in the index
>     relative to the `HEAD` commit.  (One exception is when the changed
>     index entries are in the state that would result from the merge
>     already.)
>
> Interestingly, prior to commit c0be8aa06b85 ("Documentation/git-merge.txt:
> Partial rewrite of How Merge Works", 2008-07-19),
> Documentation/git-merge.txt said much more:
>
>     ...the index file must match the tree of `HEAD` commit...
>     [NOTE]
>     This is a bit of a lite.  In certain special cases [explained
>     in detail]...
>     Otherwise, merge will refuse to do any harm to your repository
>     (that is...your working tree...and index are left intact).
>
> So, this suggests that the exceptions existed because there were special
> cases where it would case no harm, and potentially be slightly more
> convenient for the user.  While the current text in git-merge.txt does
> list a condition under which it would be safe to proceed despite the index
> not matching HEAD, it does not match what is actually implemented, in
> three different ways:
>
>     * The exception is written to describe what unpack-trees allows.  Not
>       all merge strategies allow such an exception, though, making this
>       description misleading.  'ours' and 'octopus' merges have strictly
>       enforced index==HEAD for a while, and the commit previous to this
>       one made 'recursive' do so as well.
>
>     * If someone did a three-way content merge on a specific file using
>       versions from the relevant commits and staged it prior to running
>       merge, then that path would technically satisfy the exception listed
>       in git-merge.txt.  unpack-trees.c would still error out on the path,
>       though, because it defers the three-way content merge logic to other
>       parts of the code (resolve, octopus, or recursive) and has no way of
>       checking whether the index entry from before the merge will match
>       the end result of the merge.
>
>     * The exception as implemented in unpack-trees actually only checked
>       that the index matched the MERGE_HEAD version of the file and that
>       HEAD matched the merge base.  Assuming no renames, that would indeed
>       provide cases where the index matches the end result we'd get from a
>       merge.  But renames means unpack-trees is checking that it instead
>       matches something other than what the final result will be, risking
>       either erroring out when we shouldn't need to, or not erroring out
>       when we should and overwriting the user's staged changes.
>
> In addition to the wording behind this exception being misleading, it is
> also somewhat surprising to see how many times the code for the special
> cases were wrong or the check to make sure the index matched head was
> forgotten altogether:
>
> * Prior to commit ee6566e8d70d ("[PATCH] Rewrite read-tree", 2005-09-05),
>   there were many cases where an unclean index entry was allowed (look for
>   merged_entry_allow_dirty()); it appears that in those cases, the merge
>   would have simply overwritten staged changes with the result of the
>   merge.  Thus, the merge result would have been correct, but the user's
>   uncommitted changes could be thrown away without warning.
>
> * Prior to commit 160252f81626 ("git-merge-ours: make sure our index
>   matches HEAD", 2005-11-03), the 'ours' merge strategy did not check
>   whether the index matched HEAD.  If it didn't, the resulting merge
>   would include all the staged changes, and thus wasn't really an 'ours'
>   strategy.
>
> * Prior to commit 3ec62ad9ffba ("merge-octopus: abort if index does not
>   match HEAD", 2016-04-09), 'octopus' merges did not check whether the
>   index matched HEAD, also resulting in any staged changes from before
>   the commit silently being folded into the resulting merge.  commit
>   a6ee883b8eb5 ("t6044: new merge testcases for when index doesn't match
>   HEAD", 2016-04-09) was also added at the same time to try to test to
>   make sure all strategies did the necessary checking for the requirement
>   that the index match HEAD.  Sadly, it didn't catch all the cases, as
>   evidenced by the remainder of this list...
>
> * Prior to commit 65170c07d466 ("merge-recursive: avoid incorporating
>   uncommitted changes in a merge", 2017-12-21), merge-recursive simply
>   relied on unpack_trees() to do the necessary check, but in one special
>   case it avoided calling unpack_trees() entirely and accidentally ended
>   up silently including any staged changes from before the merge in the
>   resulting merge commit.
>
> * The commit immediately before this one in this series noted that the
>   exceptions were written in a way that assumed no renames, making it
>   unsafe for merge-recursive to use.  merge-recursive was modified to
>   use its own check to enforce that index==HEAD.
>
> This history makes it very tempting to go into builtin/merge.c and replace
> the comment that strategies must enforce that index matches HEAD with code
> that just enforces it.  At this point, that would only affect the
> 'resolve' strategy; all other strategies have each been modified to
> manually enforce it.

I'm curious if anyone has comments on this last paragraph above.
Would anyone object to strictly enforcing index matches HEAD before
all types of merges?
