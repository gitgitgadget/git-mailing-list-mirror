Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C39ECAAD5
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 14:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbiIBOXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 10:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbiIBOWt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 10:22:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CDC60514
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 06:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662126502;
        bh=lvFrx2qTA6z87D4lqgF9F19jBQlzmYS27OoZVwGqLuo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZjDG8YbY8ubON5+H57z5KLUkYYpUMfygk44Mt9pDi37vrlUApS/q3qoJ8E/r+CR7T
         GP+dqj8RyggMb8p4RKzS3cCAMp2wmFV//LXkA2ZDmAO/ipDQarYiMDVD5JWPLqKp/O
         ALrFT3nGlRgoiNdSk1yqTB+koiJ5plNAobfHayd4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wLZ-1oReCE4151-007SDb; Fri, 02
 Sep 2022 15:48:22 +0200
Date:   Fri, 2 Sep 2022 15:48:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Derrick Stolee <derrickstolee@github.com>
cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 0/3] list-object-filter: introduce depth filter
In-Reply-To: <a14028be-2fd2-258d-94f5-c010669de8a6@github.com>
Message-ID: <o48053s6-5540-1234-5roq-92q6981r2306@tzk.qr>
References: <pull.1343.git.1662025272.gitgitgadget@gmail.com> <a14028be-2fd2-258d-94f5-c010669de8a6@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XFgEuHKTKPLSSGTaBEyKfevfAi1i9KiL7HYdnozL4QHOCInYIku
 QGVe2QmWWBxKdnl+c2montuOsK+ReXO0jFnAOKrq2BC2jQLtWc3hmEZqBkEQjbX/dWr5k4+
 fyeb5f5MAK+JcomcDwWw9gJpMWLoJNVi8yLmdqJv6Lfo3OIlP1lwSTLmZNnvQxH4G4uAVXn
 tkyHftJbsBuud6mkcz9Dw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a5Q8h1pygnM=:vtiKDyavNu7LMEL+DnqOSS
 xLuxIYXsP9nYMFJQMdLNuYTZQrucYLaw4hUISS6XjXNBUb6eR+RoRxu05XBEL3xt4f44s7JM5
 sIAiqc8h6xei+GerjAxu2MriWT5LZib+0k9fnl5R1jXik2yRmGhQ/qaUVFK/U+AQ3bqIC66dx
 RyLacyW5m/2O4tkdCZ2cksGdeyviviZdMGNnvwOH9qSBukrfQx5JG9p7nAmmQahmessbM6Q2G
 oS+RWJUKaklHXoHHbjQoF40LN8PGK1H8yuNKSxJYoxL0cuYRLiOCk8mkAMBiAWaIOOF4f+Lhl
 FN5WsyRoXEEtMtsZDtV87SEjI4CDfOGIndixdyj0sVRxcqxz/rjFlCsM5jS1xCfFf4ZaGsC1o
 Rx7XZDo+R+kUAIB+4PxRIEjxqHzClJZcuwc9KXVajRNgD0E/zVLUYDK46yU1/872y/P7Pw9DV
 wCjzVRbI62ew2G5KvvcziSOgVF7upK2yN/cH9NJ3sIjGdGSQcS3gzKHjepAgeV+PX4a+bUU1J
 eSq5kX9bQuUXP/pRpQ6CnCJuzRAjuajqDoE+DLknSDls1m2JfRRPBa/gT1cdpIURB1RP5+Tj4
 csmTJ8kU9isnie8f7r8XicZPEOwv29oEa+WGQog3H8j/lmLzSO+vzmGYsRFitfWxyfTf2rfJh
 QQX8m/FX7tfa/Z20DYMoJGFNcyNc0+9rHkLH+vfCmlkC0eAIxvTj2kMefUe9WkcuxoqUUDot8
 2MGZ6cBaZBdhhZfcNGkTVwHoas6TLSJORvXWFYljs3MViH0sSWKjMIo0R0vW4R52MmbSKZVac
 g+s0mDnSbEutAY3YFBCBGzq6fUwFSvq24t1ut4DujYcUvHbkH9ZCNU6rXaG+LTPUnXXwV/lBe
 WYkhV2NqtIRy50rZLxV+yveGvx2AcR8JwzHgknE8P7+/dNQXyfGu4NY1f/pRp8pv9S1jB40eq
 Z26wpiqEcUvD3T5stxUUuNjsXog7ysfcELRectPgaYDxii2GYlzQ2BYxGCLVUdgP9YjNuQKqF
 XNvK80kNn92i7mXt8WrSLIZQDGiVTcYtbRLyF3TKHZa3jlkTsvAftfYtGqM3a4tgh80uStcBI
 ymgUyMMtqz3hxVBUT5dKSO5zGWytSm+7lZREl5gUiRTk09h41DHBlZ0NjWRCfwd81dV1sdGCc
 MBJYiZHE/b2hwCJUjolOy4QCIE
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi ZheNing,

first of all: thank you for working on this. In the past, I thought that
this feature would be likely something we would want to have in Git.

But Stolee's concerns are valid, and made me think about it more. See
below for a more detailed analysis.

On Thu, 1 Sep 2022, Derrick Stolee wrote:

> On 9/1/2022 5:41 AM, ZheNing Hu via GitGitGadget wrote:
>
> > [...]
> >
> > Disadvantages of git clone --filter=3Dblob:none with git
> > sparse-checkout: The git client needs to send a lot of missing
> > objects' id to the server, this can be very wasteful of network
> > traffic.
>
> Asking for a list of blobs (especially limited to a sparse-checkout) is
> much more efficient than what will happen when a user tries to do almost
> anything in a repository formed the way you did here.

I agree. When you have all the commit and tree objects on the local side,
you can enumerate all the blob objects you need in one fell swoop, then
fetch them in a single network round trip.

When you lack tree objects, or worse, commit objects, this is not true.
You may very well need to fetch _quite_ a bunch of objects, then inspect
them to find out that you need to fetch more tree/commit objects, and then
a couple more round trips, before you can enumerate all of the objects you
need.

Concrete example: let's assume that you clone git.git with a "partial
depth" of 50. That is, while cloning, all of the tip commits' graphs will
be traversed up until the commits that are removed by 49 edges in the
commit graph. For example, v0.99~49 will be present locally after cloning,
but not v0.99~50.

Now, the first-parent depth of v0.99 is 955 (verify with `git rev-list
=2D-count --first-parent v0.99`). None of the commits reachable from v0.99
other than the tip itself seem to be closer to any other tag, so all
commits reachable from v0.99~49 will be missing locally. And since reverts
are rare, we must assume that the vast majority of the associated root
tree objects are missing, too.

Digging through history, a contributor might need to investigate where,
say, `t/t4100/t-apply-7.expect` was introduced (it was in v0.99~206)
because they found something looking like a bug and they need to read the
commit message to see whether it was intentional. They know that this file
was already present in v0.99. Naturally, the command-line to investigate
that is:

	git log --diff-filter=3DA v0.99 -- t/t4100/t-apply-7.expect

So what does Git do in that operation? It traverses the commits starting
from v0.99, following the chain along the commit parents. When it
encounters v0.99~49, it figures out that it has to fetch v0.99~50. To see
whether v0.99~49 introduced that file, it then has to inspect that commit
object and then fetch the tree object (v0.99~50^{tree}). Then, Git
inspects that tree to find out the object ID for v0.99~50^{tree}:t/, sees
that it is identical to v0.99~49^{tree}:t/ and therefore the pathspec
filter skips this commit from the output of the `git log` command. A
couple of parent traversals later (always fetching the parent commit
object individually, then the associated tree object, then figuring out
that `t/` is unchanged) Git will encounter v0.99~55 where `t/` _did_
change. So now it also has to fetch _that_ tree object.

In total, we are looking at 400+ individual network round trips just to
fetch the required tree/commit objects, i.e. before Git can show you the
output of that `git log` command. And that's just for back-filling the
missing tree/commit objects.

If we had done this using a shallow clone, Git would have stopped at the
shallow boundary, the user would have had a chance to increase the depth
in bigger chunks (probably first extending the depth by 50, then maybe
100, then maybe going for 500) and while it would have been a lot of
manual labor, the total time would be still a lot shorter than those 400+
network round trips (which likely would incur some throttling on the
server side).

> Thinking about this idea, I don't think it is viable. I would need to
> see a lot of work done to test these scenarios closely to believe that
> this type of partial clone is a desirable working state.

Indeed, it is hard to think of a way how the design could result in
anything but undesirable behavior, both on the client and the server side.

We also have to consider that our experience with large repositories
demonstrates that tree and commit objects delta pretty well and are
virtually never a concern when cloning. It is always the sheer amount of
blob objects that is causing poor user experience when performing
non-partial clones of large repositories.

Now, I can be totally wrong in my expectation that there is _no_ scenario
where cloning with a "partial depth" would cause anything but poor
performance. If I am wrong, then there is value in having this feature,
but since it causes undesirable performance in all cases I can think of,
it definitely should be guarded behind an opt-in flag.

Ciao,
Dscho
