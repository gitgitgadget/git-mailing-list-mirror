Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 160EC1F404
	for <e@80x24.org>; Tue,  6 Mar 2018 13:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753454AbeCFN0L (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 08:26:11 -0500
Received: from mail.javad.com ([54.86.164.124]:41755 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750817AbeCFN0J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 08:26:09 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 22663405E9;
        Tue,  6 Mar 2018 13:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520342768;
        bh=Z6KN3xYVwTnRmw8zXTECvRHwcwDZ7/6pLWqj9Hg12uE=; l=7928;
        h=Received:From:To:Subject;
        b=kAlAYGEvNGrdGBSMMBnT71beatSujkdkKvzmsMuzjH/jptlmTXeUql9IZkOQFhL2b
         GbJ2jFQwpbxv/06gLsI2AsZT0HN8YJeiJHzI6p6MeSfFKJCnTMm2mbbm5tHSsJanV/
         8cpMAe2TBOFP1a7QOJY+YLYgjExx4xNWKQIhnSrw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520342768;
        bh=Z6KN3xYVwTnRmw8zXTECvRHwcwDZ7/6pLWqj9Hg12uE=; l=7928;
        h=Received:From:To:Subject;
        b=kAlAYGEvNGrdGBSMMBnT71beatSujkdkKvzmsMuzjH/jptlmTXeUql9IZkOQFhL2b
         GbJ2jFQwpbxv/06gLsI2AsZT0HN8YJeiJHzI6p6MeSfFKJCnTMm2mbbm5tHSsJanV/
         8cpMAe2TBOFP1a7QOJY+YLYgjExx4xNWKQIhnSrw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520342768;
        bh=Z6KN3xYVwTnRmw8zXTECvRHwcwDZ7/6pLWqj9Hg12uE=; l=7928;
        h=Received:From:To:Subject;
        b=kAlAYGEvNGrdGBSMMBnT71beatSujkdkKvzmsMuzjH/jptlmTXeUql9IZkOQFhL2b
         GbJ2jFQwpbxv/06gLsI2AsZT0HN8YJeiJHzI6p6MeSfFKJCnTMm2mbbm5tHSsJanV/
         8cpMAe2TBOFP1a7QOJY+YLYgjExx4xNWKQIhnSrw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520342768;
        bh=Z6KN3xYVwTnRmw8zXTECvRHwcwDZ7/6pLWqj9Hg12uE=; l=7928;
        h=Received:From:To:Subject;
        b=kAlAYGEvNGrdGBSMMBnT71beatSujkdkKvzmsMuzjH/jptlmTXeUql9IZkOQFhL2b
         GbJ2jFQwpbxv/06gLsI2AsZT0HN8YJeiJHzI6p6MeSfFKJCnTMm2mbbm5tHSsJanV/
         8cpMAe2TBOFP1a7QOJY+YLYgjExx4xNWKQIhnSrw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520342768;
        bh=Z6KN3xYVwTnRmw8zXTECvRHwcwDZ7/6pLWqj9Hg12uE=; l=7928;
        h=Received:From:To:Subject;
        b=kAlAYGEvNGrdGBSMMBnT71beatSujkdkKvzmsMuzjH/jptlmTXeUql9IZkOQFhL2b
         GbJ2jFQwpbxv/06gLsI2AsZT0HN8YJeiJHzI6p6MeSfFKJCnTMm2mbbm5tHSsJanV/
         8cpMAe2TBOFP1a7QOJY+YLYgjExx4xNWKQIhnSrw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520342768;
        bh=Z6KN3xYVwTnRmw8zXTECvRHwcwDZ7/6pLWqj9Hg12uE=; l=7928;
        h=Received:From:To:Subject;
        b=kAlAYGEvNGrdGBSMMBnT71beatSujkdkKvzmsMuzjH/jptlmTXeUql9IZkOQFhL2b
         GbJ2jFQwpbxv/06gLsI2AsZT0HN8YJeiJHzI6p6MeSfFKJCnTMm2mbbm5tHSsJanV/
         8cpMAe2TBOFP1a7QOJY+YLYgjExx4xNWKQIhnSrw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520342768;
        bh=Z6KN3xYVwTnRmw8zXTECvRHwcwDZ7/6pLWqj9Hg12uE=; l=7928;
        h=Received:From:To:Subject;
        b=kAlAYGEvNGrdGBSMMBnT71beatSujkdkKvzmsMuzjH/jptlmTXeUql9IZkOQFhL2b
         GbJ2jFQwpbxv/06gLsI2AsZT0HN8YJeiJHzI6p6MeSfFKJCnTMm2mbbm5tHSsJanV/
         8cpMAe2TBOFP1a7QOJY+YLYgjExx4xNWKQIhnSrw=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1etCbW-0007pY-Dt; Tue, 06 Mar 2018 16:26:06 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC v2] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com>
Date:   Tue, 06 Mar 2018 16:26:06 +0300
In-Reply-To: <87y3jtqdyg.fsf@javad.com> (Sergey Organov's message of "Fri, 16
        Feb 2018 16:08:39 +0300")
Message-ID: <87r2oxe3o1.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This is v2 of my "Rebasing merges" proposal.

Significant changes are:

1. Fixed mistake in the final merge step in the original proposal: wrong
   merge base was used. Thanks everybody who provided test-cases, and
   special thanks to Igor Djordjevic <igor.d.djordjevic@gmail.com> for
   implementing and testing a few variants of the method.

2. Added discussion of the exact place where handling of special
   frequent cases such as "git merge -ours", if any, should go.

3. I now use "True Merge" name instead of former "Trivial Merge", to
   avoid confusion with what Git documentation calls "trivial merge",
   thanks to Junio C Hamano <gitster@pobox.com> for pointing this out.

During discussion of the original proposal, yet another way of
implementing a true rebase of a merge commit has been suggested by
Phillip Wood <phillip.wood@dunelm.org.uk>[1]. His method also gathers
the changes on both sides of the merge and then merges them back to the
original merge, so both methods have similar concept and differ in
implementation. It looks like both implementations bring the same
result, at least it was so in the limited testing that Igor performed.

[1] https://public-inbox.org/git/6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net/


-------8<-------------8<------

By accepting the challenges raised in recent discussion of advanced
support for history rebasing and editing in Git, I hopefully figured out
a clean and elegant method of rebasing merges that I think is "The Right
Way (TM)" to perform this so far troublesome operation. ["(TM)" here has
second meaning: "True Merge" (TM), see below.]

Let me begin with quick outline of the method, to illustrate the
simplicity of the approach, and special thanks here must go to "Johannes
Sixt" <j6t@kdbg.org> for his original bright idea to use "cherry-pick
-m1" to rebase merge commits.

Given 2 original branches, b1 and b2, and a merge commit M that joins
them, suppose we've already rebased b1 to b1', and b2 to b2'. Suppose
also that B1' and B2' happen to be the tip commits on b1' and b2',
respectively.

To produce merge commit M' that joins b1' and b2', the following
operations will suffice:

1. Checkout b2' and cherry-pick -m2 M, to produce U2' (and new b2').
2. Checkout b1' and cherry-pick -m1 M, to produce U1' (and new b1').
3. Perform 3-way merge of U1' and U2' using original M as merge base,
   to get UM'.
4. Get rid of U1' and U2' by re-writing parent references of UM' from
   U1' and U2' to  B1' and B2', respectively, to produce M'.
5. Mission complete.

Let's now turn to the method itself and see why and how it actually
works.

First off, let me introduce you to my new friend, the True Merge, or
(TM) for short. By definition, (TM) is a merge that brings absolutely
no differences to the sides of the merge. (I also like to call him
"Angel Merge" (AM), both as being the most beautiful of all merges, and
as direct antithesis to "[d]evil merge"; or even "Perfect Merge" (PM),
but the latter goes after lunch time.)

Being trivial history joint and nothing else, (TM)/(AM)/(PM) is safe and
easy to be rebased (see below). However, since most of us have never met
(TM) in practice, you probably wonder how (TM) can actually help us
handle general case of rebasing of some random merge.

Let's start with this history:

    M
   / \
  B1  B2

where B1 and B2 are tip commits of 2 branches, and M is the merge commit
that joins them. Let's transform this history to the following one,
contextually equivalent to the original, by introducing 2 non-merge
utility commits U1 and U2, and a new utility merge commit UM:

    UM
   /  \
  U1   U2
  |    |
  B1   B2

were contents of all the created commits match, and are exact copies of
the original content of M. I.e., provided [A] denotes "content of commit
A", we have:

  [UM] = [U1] = [U2] = [M]

Stress again how these changes to the history preserve the exact content
of the original merge ([UM] = [M]), how U1 an U2 represent content
changes due to the merge on either side[*], and how content of neither
preceding nor subsequent commits is affected by the change of
representation.

Now observe that as [U1] = [UM], and [U2] = [UM], the UM happens to be
exactly our new friend -- the "True Merge (TM)" his true self,
introducing exactly zero changes to content. Pure history joint.

Next, we separately rebase both branches of our new representation of
the history to whatever new base we need, and we get:

  U1'  U2'
  |    |
  B1'  B2'

where U1' and U2' are rebased versions of U1 and U2, obtained by usual
rebasing methods for non-merge commits.

Finally, let's merge back our branches.

To perform the right kind of merge, notice that U1' and U2' have
diverged from U1 and U2, respectively. Further, provided [U1] = [U2] =
[UM] = [M], they have both diverged from the original merge commit
M. Therefore, to merge U1' and U2' into UM', it suffices to use 3-way
merge using original M as the merge base:

    UM'
   /  \
  U1'  U2'
   \  /
    M

Note that unlike merging of B1' and B2' that current "git rebase
--preserve-merges/--recreate-merges" performs, merging of U1' and U2' is
safe, as original UM, being (TM), doesn't itself carry any content
changes, and thus none could be missed by ignoring the UM. Essentially,
reproducing a (TM) is just joining corresponding histories back, and
that's what merge operation is all about.

If the resulting U1' and U2' happen to match ([U1'] = [U2']), we have
got our lovely (TM) back and we are clear to proceed automatically.

OTOH, if the resulting U1' and U2' differ, we should better stop for
user inspection and possible amendment of the resulting UM'. At this
point special treatment of any rather frequent cases (such as "git merge
-ours") could be applied before amendment, if need to be. Amendment by
replacing UM' with re-merge of B2' and B1' could be suggested to the
user as well. Options are plenty.

Finally, to get to our required merge commit M', we get the content of
UM' (possibly amended by the user), and record two actual parents of the
merge:

    M'
   / \
  B1' B2'

where [M'] = [UM'].

That's it. Mission complete.

The method is expected to have the following nice features:

- it carefully preserves user changes by rebasing the merge commit
itself, in a way that is semantically similar to rebasing simple
(non-merge) commits, yet it allows changes made to branches during
history editing to propagate over corresponding merge commit that joins
the branches, even automatically when the changes don't conflict, as
expected.

- it has provision for detection of even slightest chances of ending up
with surprising merge (just check if UM' is still (TM)), so that
implementation could stop for user inspection and amendment when
appropriate, yet it is capable of handling trivial cases smoothly and
automatically.

- it never falls back to simple invocation of merge operation on rebased
original branches themselves, thus avoiding the problem of lack of
knowledge of how the merge at hand has been performed in the first
place.

- it allows implementation to let user manually perform whatever merge
she wishes when suspect result is automatically detected.

- it extends trivially to octopus merges.

- it appears to be shiny to the point that it will likely be able to
handle even darkest [d]evil merges nicely, no special treatment
required.

Footnote:

[*] We may as well consider the (UM,U1,U2) trio to be semantically split
representation of git merge commit, where U1 and U2 represent content
changes to the sides, and UM represents pure history joint. Or, the
other way around, we may consider git merge commit to be optimized
representation of this trio. I think this split representation could
help to simplify reasoning about git merges in general.

-- Sergey
