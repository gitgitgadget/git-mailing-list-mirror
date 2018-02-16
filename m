Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44E3B1F404
	for <e@80x24.org>; Fri, 16 Feb 2018 13:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968078AbeBPNIp (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 08:08:45 -0500
Received: from mail.javad.com ([54.86.164.124]:49667 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967920AbeBPNIn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 08:08:43 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id D89E340AE9;
        Fri, 16 Feb 2018 13:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518786522;
        bh=kt6A2nAtiK0zxTGg/9BL6/iu5r5BLm5XV2jtQ2z2EKM=; l=5508;
        h=Received:From:To:Subject;
        b=NxkNjSLzVt8IlofDa/bFt1JVUe2KVfe0i8Tnl+Zc39xdvlP01kiB2wx3h1cZo7kHv
         ekvM2EVbKm+I7zQRqfB2nDVwKAYMONPeuJQOCeyF3oRx/ly86VjN5jO8TKsOc0Il08
         W/mDmuaEZNwNCfWYDQ/ILZ9+l8B26BcvHEOepSaE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518786522;
        bh=kt6A2nAtiK0zxTGg/9BL6/iu5r5BLm5XV2jtQ2z2EKM=; l=5508;
        h=Received:From:To:Subject;
        b=NxkNjSLzVt8IlofDa/bFt1JVUe2KVfe0i8Tnl+Zc39xdvlP01kiB2wx3h1cZo7kHv
         ekvM2EVbKm+I7zQRqfB2nDVwKAYMONPeuJQOCeyF3oRx/ly86VjN5jO8TKsOc0Il08
         W/mDmuaEZNwNCfWYDQ/ILZ9+l8B26BcvHEOepSaE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518786522;
        bh=kt6A2nAtiK0zxTGg/9BL6/iu5r5BLm5XV2jtQ2z2EKM=; l=5508;
        h=Received:From:To:Subject;
        b=NxkNjSLzVt8IlofDa/bFt1JVUe2KVfe0i8Tnl+Zc39xdvlP01kiB2wx3h1cZo7kHv
         ekvM2EVbKm+I7zQRqfB2nDVwKAYMONPeuJQOCeyF3oRx/ly86VjN5jO8TKsOc0Il08
         W/mDmuaEZNwNCfWYDQ/ILZ9+l8B26BcvHEOepSaE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518786522;
        bh=kt6A2nAtiK0zxTGg/9BL6/iu5r5BLm5XV2jtQ2z2EKM=; l=5508;
        h=Received:From:To:Subject;
        b=NxkNjSLzVt8IlofDa/bFt1JVUe2KVfe0i8Tnl+Zc39xdvlP01kiB2wx3h1cZo7kHv
         ekvM2EVbKm+I7zQRqfB2nDVwKAYMONPeuJQOCeyF3oRx/ly86VjN5jO8TKsOc0Il08
         W/mDmuaEZNwNCfWYDQ/ILZ9+l8B26BcvHEOepSaE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518786522;
        bh=kt6A2nAtiK0zxTGg/9BL6/iu5r5BLm5XV2jtQ2z2EKM=; l=5508;
        h=Received:From:To:Subject;
        b=NxkNjSLzVt8IlofDa/bFt1JVUe2KVfe0i8Tnl+Zc39xdvlP01kiB2wx3h1cZo7kHv
         ekvM2EVbKm+I7zQRqfB2nDVwKAYMONPeuJQOCeyF3oRx/ly86VjN5jO8TKsOc0Il08
         W/mDmuaEZNwNCfWYDQ/ILZ9+l8B26BcvHEOepSaE=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1emfkl-00087o-UB; Fri, 16 Feb 2018 16:08:39 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
Date:   Fri, 16 Feb 2018 16:08:39 +0300
Message-ID: <87y3jtqdyg.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

By accepting the challenges raised in recent discussion of advanced
support for history rebasing and editing in Git, I hopefully figured out
a clean and elegant method of rebasing merges that I think is "The Right
Way (TM)" to perform this so far troublesome operation. ["(TM)" here has
second meaning: a "Trivial Merge (TM)", see below.]

Let me begin by outlining the method in git terms, and special thanks
here must go to "Johannes Sixt" <j6t@kdbg.org> for his original bright
idea to use "cherry-pick -m1" to rebase merge commits.

End of preface -- here we go.

Given 2 original branches, b1 and b2, and a merge commit M that joins
them, suppose we've already rebased b1 to b1', and b2 to b2'. Suppose
also that B1' and B2' happen to be the tip commits on b1' and b2',
respectively.

To produce merge commit M' that joins b1' and b2', the following
operations will suffice:

1. Checkout b2' and cherry-pick -m2 M, to produce U2' (and new b2').
2. Checkout b1' and cherry-pick -m1 M, to produce U1' (and new b1').
3. Merge --no-ff new b2' to current new b1', to produce UM'.
4. Get rid of U1' and U2' by re-writing parent references of UM' from
   U1' and U2' to  B1' and B2', respectively, to produce M'.
5. Mission complete.

Let's now see why and how the method actually works.

Firs off, let me introduce you to my new friend, the Trivial Merge, or
(TM) for short. By definition, (TM) is a merge that introduces
absolutely no differences to the sides of the merge. (I also like to
sometimes call him "Angel Merge", both as the most beautiful of all
merges, and as direct antithesis to "evil merge".)

One very nice thing about (TM) is that to safely rebase it, it suffices
to merge its (rebased) parents. It is safe in this case, as (TM) itself
doesn't posses any content changes, and thus none could be missed by
replacing it with another merge commit.

I bet most of us have never seen (TM) in practice though, so let's see
how (TM) can help us handle general case of some random merge. What I'm
going to do is to create a virtual (TM) and see how it goes from there.

Let's start with this history:

  M
 / \
B1  B2

And let's transform it to the following one, contextually equivalent to
the original, by introducing 2 simple utility commits U1 and U2, and a
new utility merge commit UM:

  UM
 /  \
U1   U2
|    |
B1   B2

Here content of any of the created UM, U1, and U2 is the same, and is
exact copy of original content of M. I.e., provided [A] denotes
"content of commit A", we have:

[UM] = [U1] = [U2] = [M]

Stress again how these changes to the history preserve the exact content
of the original merge ([UM] = [M]), and how U1 an U2 represent content
changes due to merge on either side[*], and how neither preceding nor
subsequent commits content would be affected by the change of
representation.

Now observe that as [U1] = [UM], and [U2] = [UM], the UM happens to be
exactly our new friend -- the "Trivial Merge (TM)" his true self,
introducing zero changes to content.

Next we rebase our new representation of the history and we get:

  UM'
 /  \
U1'  U2'
|    |
B1'  B2'

Here UM' is bare merge of U1' and U2', in exact accordance with the
method of rebasing a (TM) we've already discussed above, and U1' and U2'
are rebased versions of U1 and U2, obtained by usual rebasing methods
for non-merge commits.

(Note, however, that at this point UM' is not necessarily a (TM)
anymore, so in real implementation it may make sense to check if UM' is
not a (TM) and stop for possible user amendment.)

Finally, to get to our required merge commit M', we get the content of
UM' and record two actual parents of the merge:

  M'
 / \
B1' B2'

Where [M'] = [UM'].

That's it. Mission complete.

I expect the method to have the following nice features:

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
place. It doesn't prevent implementation from letting user to manually
perform whatever merge she wishes when suspect result is automatically
detected though.

- it extends trivially to octopus merges.

- it appears shiny to the point that it will likely be able to handle
even darkest evil merges nicely, no special treatment required.

Footnote:

[*] We may as well consider the (UM,U1,U2) trio to be semantically split
representation of git merge commit, where U1 and U2 represent content
changes to the sides, and UM represents pure history joint. Or, the
other way around, we may consider git merge commit to be optimized
representation of this trio. I think this split representation could
help to simplify reasoning about git merges in general.

-- Sergey
