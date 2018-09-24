Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BD951F453
	for <e@80x24.org>; Mon, 24 Sep 2018 17:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbeIXX1r (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 19:27:47 -0400
Received: from mail-ua1-f41.google.com ([209.85.222.41]:38491 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbeIXX1r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 19:27:47 -0400
Received: by mail-ua1-f41.google.com with SMTP id j17-v6so1504317uan.5
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 10:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hh0JCph08XzJGTNZ2VS5Y+mXWVamYn8C3k87+jeFjyg=;
        b=eJDOBFN3ucnS5I3z9pqm6GAVEWZZbSshdaLqQnVA+1+/kKofpfGwzPdlq+nth3ybxN
         iJt39iSiywpAh5YXVUVoDkCU2zGqbUPrPrSFM7A4Id4tWjS/EwKJ8z/fuF9EdL24Y6C+
         LkOjJ8+PV9gRTuqpPPABKF9KHi7av0whYlUlFCi1iyq25o69/1T9B6XFxFbYZBy6llde
         A5pE+5oPmAn3OeMtwm5l+rFjLoDtaTcCjxzZkfCRpLU2Svs/EYeeMmQv8vq9vR1aCKCS
         wCF3YDbV00jJDamW0TOdaCa4oAF6RoGh7OID3hf32lWiJJri8HwrHmaqk6kIfnsTx9k5
         z/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hh0JCph08XzJGTNZ2VS5Y+mXWVamYn8C3k87+jeFjyg=;
        b=RVN56WT+JRHDybu1U0+sHq6+3GBZFHDv5OEUsW4MQVqonlyOv024RAkSPlQM4+gNL5
         kAUSiZGgyDligPZEkxfgLE6iXuWdec19h4ly+KC0CFW75r4xNXx6sGvBhZcfZe+wqB/V
         0sUz0JIifRBkQwwvEgohVMW8jVTYdjTUAJhYh40HmK2aNZg+EEqf8aJ2QjxVzOgB2P0M
         JGvwnE64RnXqWRwvMOsFj7KPY8o1YYV9XJf/eRF70p0EwAN2f7RAaj/3mgBjeUpdHgTD
         89fnzwpZpLVQq8xgxBCaToHNrmRMRSI9od0mOrIXfT+c7WbbGjtow67OLXnl8yNOSEdG
         29Ow==
X-Gm-Message-State: ABuFfojZWX69n1wLYGGGr+7G7imTAKTX0DzSnERVUHMRvW96VK1BBWBc
        NxdAYIoKaECARJoo6H3RqbvCXJW+iIB2MygQQIhUQtS2
X-Google-Smtp-Source: ACcGV61jidA1KE3bt8PeAR+KZcLUH5LSWW/A1kpXTC9ZiW7u5JQDNM6nfQbh222NMxeTcj7Xf9OESNySN2tUiNPsNFo=
X-Received: by 2002:a9f:2986:: with SMTP id s6-v6mr3126246uas.28.1537809875037;
 Mon, 24 Sep 2018 10:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <F65AF000-7AE0-44C8-81C8-E58D6769FAA3@gmail.com>
In-Reply-To: <F65AF000-7AE0-44C8-81C8-E58D6769FAA3@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 24 Sep 2018 10:24:23 -0700
Message-ID: <CABPp-BGL-3_nhZSpt0Bz0EVY-6-mcbgZMmx4YcXEfA_ZrTqFUw@mail.gmail.com>
Subject: Re: Import/Export as a fast way to purge files from Git?
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        me@ttaylorr.com, "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 23, 2018 at 6:08 AM Lars Schneider <larsxschneider@gmail.com> wrote:
>
> Hi,
>
> I recently had to purge files from large Git repos (many files, many commits).
> The usual recommendation is to use `git filter-branch --index-filter` to purge
> files. However, this is *very* slow for large repos (e.g. it takes 45min to
> remove the `builtin` directory from git core). I realized that I can remove
> files *way* faster by exporting the repo, removing the file references,
> and then importing the repo (see Perl script below, it takes ~30sec to remove
> the `builtin` directory from git core). Do you see any problem with this
> approach?

It looks like others have pointed you at other tools, and you're
already shifting to that route.  But I think it's a useful question to
answer more generally, so for those that are really curious...


The basic approach is fine, though if you try to extend it much you
can run into a few possible edge/corner cases (more on that below).
I've been using this basic approach for years and even created a
mini-python library[1] designed specifically to allow people to create
"fast-filters", used as
   git fast-export <options> | your-fast-filter | git fast-import <options>

But that library didn't really take off; even I have rarely used it,
often opting for filter-branch despite its horrible performance or a
simple fast-export | long-sed-command | fast-import (with some extra
pre-checking to make sure the sed wouldn't unintentionally munge other
data).  BFG is great, as long as you're only interested in removing a
few big items, but otherwise doesn't seem very useful (to be fair,
it's very upfront about only wanting to solve that problem).
Recently, due to continuing questions on filter-branch and folks still
getting confused with it, I looked at existing tools, decided I didn't
think any quite fit, and started looking into converting
git_fast_filter into a filter-branch-like tool instead of just a
libary.  Found some bugs and missing features in fast-export along the
way (and have some patches I still need to send in).  But I kind of
got stuck -- if the tool is in python, will that limit adoption too
much?  It'd be kind of nice to have this tool in core git.  But I kind
of like leaving open the possibility of using it as a tool _or_ as a
library, the latter for the special cases where case-specific
programmatic filtering is needed.  But a developer-convenience library
makes almost no sense unless in a higher level language, such as
python.  I'm still trying to make up my mind about what I want (and
what others might want), and have been kind of blocking on that.  (If
others have opinions, I'm all ears.)


Anyway, the edge/corner cases you can watch out for:

  - Signed tags are a problem; you may need to specify
--signed-tags=strip to fast-export

  - References to other commits in your commit messages will now be
incorrect.  I think a good tool should either default to rewriting
commit ids in commit messages or at least have an option to do so
(BFG does this; filter-branch doesn't; fast-export format makes it
really hard for a filter based on it to do so)

  - If the paths you remove are the only paths modified in a commit,
the commit can become empty.  If you're only filtering a few paths
out, this might be nothing more than a minor inconvenience for you.
However, if you're trying to prune directories (and perhaps several
toplevel ones), then it can be extremely annoying to have a new
history with the vast majority of all commits being empty.
(filter-branch has an option for this; BFG does not; tools based on
fast-export output can do it with sufficient effort).

  - If you start pruning empty commits, you have to worry about
rewriting branches and tags to remaining parents.  This _might_ happen
for free depending on your history's structure and the fast-export
stream, but to be correct in general you will have to specify the new
commit for some branches or tags.

  - If you start pruning empty commits, you have to decide whether to
allow pruning of merge commits.  Your first reaction might be to not
allow it, but if one parent and its entire history are all pruned,
then transforming the merge commit to a normal commit and then
considering whether it is empty and allowing it to be pruned is much
better.

  - If you start pruning empty commits, you also have to worry about
history topology changing, beyond the all-ancestors-empty case above.
For example, the last non-empty commit in the ancestry of a merge on
both sides may be the same commit, making the merge-commit have the
same parent twice.  Should the duplicate parent be de-duped,
transforming the commit into a normal non-merge commit?  (I'd say yes
-- this commit is likely to be empty and prunable once you do so, but
I'm not sure everyone would agree with converting a merge commit to a
non-merge.)  Similarly, what if the rewritten parents of a merge have
one parent that is the direct ancestor of another?  Can the extra
unnecessary parent be removed as a parent?  (And again, such a commit
is likely to become empty and be prunable itself.)

  - If you try to avoid the extra work involved with pruning empty
commits by passing path-specifiers as rev-list-args to fast-export,
and use the --tag-of-filtered-object=rewrite option if needed, then
depending on the topology you can hit any of three bugs: an outright
die() (despite the --tag-of-filtered-object=rewrite), a branch being
reset to a non-existent mark (causing fast-import to die), or find
that a ref which you explicitly requested to be part of the export is
silently omitted from the stream.  (granted, these aren't fundamental
issues; they're just bugs in fast-export that I seem to have been the
first to find.)

  -  filter-branch has a nice ability to rewrite only the last few
commits using a range specifier like HEAD~10..HEAD.  Trying the same
with fast-export will get you a history with only 10 commits, the
first of which squashes all early history together.  Trying to
duplicate the filter-branch behavior can be done, but it requires
multiple exports with different args and usage of --export-marks and
--import-marks; it's cumbersome and somewhat non-obvious.

  - some filters are difficult; e.g. if you want to mimick
filter-branch's --parent-filter, or BFG's --strip-blobs-with-ids, you
run into the issue that the fast-export stream doesn't provide the
original sha1sums for commits or blobs and there's no easy way for you
to associate it with the given mark.


Those are the ones I know about.  It's possible that there are others.

Hope that helps or is at least interesting.

Elijah


[1] https://public-inbox.org/git/51419b2c0904072035u1182b507o836a67ac308d32b9@mail.gmail.com/
