Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B74041F428
	for <e@80x24.org>; Sun, 29 Apr 2018 20:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751924AbeD2UxR (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 16:53:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:53589 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750815AbeD2UxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 16:53:16 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LyA2L-1eH1tK46Kb-015bZ1; Sun, 29
 Apr 2018 22:53:12 +0200
Date:   Sun, 29 Apr 2018 22:53:11 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3] unpack_trees: fix breakage when o->src_index !=
 o->dst_index
In-Reply-To: <CACsJy8DyP_mXXJKn52Jzqe63N3GLpXePCr8ha97Lv9hr6u-M0w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804292251000.79@tvgsbejvaqbjf.bet>
References: <xmqq604h717y.fsf@gitster-ct.c.googlers.com> <20180424065045.13905-1-newren@gmail.com> <CACsJy8DyP_mXXJKn52Jzqe63N3GLpXePCr8ha97Lv9hr6u-M0w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:x8+t0ts61Q5gnmIvI4JEURsQabxnFvzOx3On0vSql6YA9dwo5KM
 N3ytAga9RmaRl1Lityw9EK3IkFgtrgezC1XM+d9zMzXDInJn5Xz+QIcEDwgLylGNKO63l8d
 W2sJt6c1vJx5KQmmxdw3vi/S8gzouFxhhjvP5IhY2OppWBLb/qJdgL8LVSI0LgwshfAstcy
 sJ5vNAF8NcUO0U74LiCJA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zhMz8UR5QTI=:K625JbcK1VCivZoY1k5WX8
 FHWx+fS2g1HjOx7HbUZwFmkjzWFcL39nf312UMEf4L1OsxeAlbnPpD1tKO4mp/j5O3m22m49r
 XHSn1u4HoeHihjr2lKiYih6Wo5EvokHqWJhLBcB9GoHqv1XM6BbZcpSi7ZnjQFAQgpoLyuxfV
 tAPT9xh0s9iZBR2W4UAaQLHrcBcAAuVEkcP1l2q/+nPrPIVpecpQ/JoTwzj2e65HsMuvKjrXY
 ukLvDIyGmX4PwMVezzvD7RL9alj85/LyssLSBVzwvd41A0TQ+mpw9QyZeF0rMf7VOvZkkSZAQ
 Oo4HGLhoInWtJZ8oUXUEJayT7EAEUluYj/z2s5BQAaDPb8NU5uLji5ah+mclIlLz3AohUF2KO
 P/v0ZmDLUcljvnkk3jJXC08kwXH28WiXRvppDK8BrWvnwXzXAWspyeyIu0Tz4cmnHjvL+Yu6W
 tQTH3gwMgbC+5mRQZZ/JRNHn9RslPVtbZe/ggUUFr6FYFogkxpbz9jTm81uDBdHol3o+d5OxK
 ldyXYQkZeEPQoDWhFkM1ktWaRFNkqbyr4HA5RXjijGGTli1PoOuETAZ40nCcjOWWKXBeVOs6k
 3eRMbV9u9/mw/ZTCaI33/VTf3dGj/sHFlCu9EKJxw2WuJGhg1C3PBPugJRuXbHqdbdGgerJTr
 R2kFcTV4lmSuxE0zL6Gvyo/M7R3mm86WBHckK+cL1gSM3mPa6TM17FMLOW4oossSJHu2YDAPH
 mt9HbLh0v6mmOrXOxJN1u41VhalVHXEr8IuLfuiMeby+uL7Q1lP09CqP8020VnXJBoa98toBb
 Np18cUp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Sun, 29 Apr 2018, Duy Nguyen wrote:

> On Tue, Apr 24, 2018 at 8:50 AM, Elijah Newren <newren@gmail.com> wrote:
> > Currently, all callers of unpack_trees() set o->src_index == o->dst_index.
> > The code in unpack_trees() does not correctly handle them being different.
> > There are two separate issues:
> >
> > First, there is the possibility of memory corruption.  Since
> > unpack_trees() creates a temporary index in o->result and then discards
> > o->dst_index and overwrites it with o->result, in the special case that
> > o->src_index == o->dst_index, it is safe to just reuse o->src_index's
> > split_index for o->result.  However, when src and dst are different,
> > reusing o->src_index's split_index for o->result will cause the
> > split_index to be shared.  If either index then has entries replaced or
> > removed, it will result in the other index referring to free()'d memory.
> >
> > Second, we can drop the index extensions.  Previously, we were moving
> > index extensions from o->dst_index to o->result.  Since o->src_index is
> > the one that will have the necessary extensions (o->dst_index is likely to
> > be a new index temporary index created to store the results), we should be
> > moving the index extensions from there.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >
> > Differences from v2:
> >   - Don't NULLify src_index until we're done using it
> >   - Actually built and tested[1]
> >
> > But it now passes the testsuite on both linux and mac[2], and I even re-merged
> > all 53288 merge commits in linux.git (with a merge of this patch together with
> > the directory rename detection series) for good measure.  [Only 7 commits
> > showed a difference, all due to directory rename detection kicking in.]
> >
> > [1] Turns out that getting all fancy with an m4.10xlarge and nice levels of
> > parallelization are great until you realize that your new setup omitted a
> > critical step, leaving you running a slightly stale version of git instead...
> > :-(
> >
> > [2] Actually, I get two test failures on mac from t0050-filesystem.sh, both
> > with unicode normalization tests, but those two tests fail before my changes
> > too.  All the other tests pass.
> >
> >  unpack-trees.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> >
> > diff --git a/unpack-trees.c b/unpack-trees.c
> > index e73745051e..49526d70aa 100644
> > --- a/unpack-trees.c
> > +++ b/unpack-trees.c
> > @@ -1284,9 +1284,20 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
> >         o->result.timestamp.sec = o->src_index->timestamp.sec;
> >         o->result.timestamp.nsec = o->src_index->timestamp.nsec;
> >         o->result.version = o->src_index->version;
> > -       o->result.split_index = o->src_index->split_index;
> > -       if (o->result.split_index)
> > +       if (!o->src_index->split_index) {
> > +               o->result.split_index = NULL;
> > +       } else if (o->src_index == o->dst_index) {
> > +               /*
> > +                * o->dst_index (and thus o->src_index) will be discarded
> > +                * and overwritten with o->result at the end of this function,
> > +                * so just use src_index's split_index to avoid having to
> > +                * create a new one.
> > +                */
> > +               o->result.split_index = o->src_index->split_index;
> >                 o->result.split_index->refcount++;
> > +       } else {
> > +               o->result.split_index = init_split_index(&o->result);
> > +       }
> >         hashcpy(o->result.sha1, o->src_index->sha1);
> >         o->merge_size = len;
> >         mark_all_ce_unused(o->src_index);
> > @@ -1401,7 +1412,6 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
> >                 }
> >         }
> >
> > -       o->src_index = NULL;
> >         ret = check_updates(o) ? (-2) : 0;
> >         if (o->dst_index) {
> >                 if (!ret) {
> > @@ -1412,12 +1422,13 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
> >                                                   WRITE_TREE_SILENT |
> >                                                   WRITE_TREE_REPAIR);
> >                 }
> > -               move_index_extensions(&o->result, o->dst_index);
> > +               move_index_extensions(&o->result, o->src_index);
> 
> While this looks like the right thing to do on paper, I believe it's
> actually broken for a specific case of untracked cache. In short,
> please do not touch this line. I will send a patch to revert
> edf3b90553 (unpack-trees: preserve index extensions - 2017-05-08),
> which essentially deletes this line, with proper explanation and
> perhaps a test if I could come up with one.
> 
> When we update the index, we depend on the fact that all updates must
> invalidate the right untracked cache correctly. In this unpack
> operations, we start copying entries over from src to result. Since
> 'result' (at least from the beginning) does not have an untracked
> cache, it has nothing to invalidate when we copy entries over. By the
> time we have done preparing 'result', what's recorded in src's (or
> dst's for that matter) untracked cache may or may not apply to
> 'result'  index anymore. This copying only leads to more problems when
> untracked cache is used.

Is there really no way to invalidate just individual entries?

I have a couple of worktrees which are *huge*. And edf3b90553 really
helped relieve the pain a bit when running `git status`. Now you say that
even a `git checkout -b new-branch` would blow the untracked cache away
again?

It would be *really* nice if we could prevent that performance regression
somehow.

Ciao,
Dscho
