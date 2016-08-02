Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 299011F858
	for <e@80x24.org>; Tue,  2 Aug 2016 10:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456AbcHBKXY (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 06:23:24 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:34368 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488AbcHBKXW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 06:23:22 -0400
Received: by mail-vk0-f49.google.com with SMTP id s189so119045964vkh.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2016 03:23:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=0FgMZGcz1N8j9PN4Bs/x9sF6MCE7C6qEW+0Ey1e6+O0=;
        b=rxUjPSe7UU5bBhn95Cmk8MIEjqGlmlEeGc+2gwcGjZUYQCWTEfKog3QFIXkBJKIgZg
         YVsfT2CPXdg+kcUWQfsxbkgWvgq5nnHDX6cJpIE2wUcubXZeWCM9jFxFgUeyhHzxAJz3
         x35xeHTaNGjCCEn5/1Mn25FVsNmtDgIyi3DjG5CV2N6mC5W6ZZgSDxab438r5rOV/bSt
         sJpx/Z6UaQDG7pgHuNszCZvEDhmRzmmFKgGQL8fz7HAaX0NKrIhbXfqJy6luXpUJ1kDo
         Vuw44utYafTDMshzJNv143W0sWeSck1xHX3PVEmiWBx92r0IlaEjBlFrUVn7deL2GxfR
         FgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=0FgMZGcz1N8j9PN4Bs/x9sF6MCE7C6qEW+0Ey1e6+O0=;
        b=A0hx06v3zUow6VUEHsrZeicXjGHsTQD17Lptefiq3fwEsupOA/cAw37vAITuiGmWGp
         eANUSXb8cj1AyalXYZSPlEptycuoId1BQ29hAEPryQDmdca02iOBhuYOeaJZfbnq2dCx
         Evy35Eppmq4+CZA+753NS9aJidWSdRWDjXJagDEsqVJOp+bXXb/M2mTyGmR14XsRBGqq
         i7T9QPmFGbc+C03o5q9pqQAAw70fDv7rXEk8sbu0+edXvvm6zZFE0qii5PVa/DKaRD8J
         fjm2bzbS1Gtlr6OeCeOsWudPILJlo82AA11PfawCvdeXEZyZMqH4Eej6R0DQl8jRS8mY
         qNow==
X-Gm-Message-State: AEkoouvkTgvBXd7UjA4Odns0fJc6AEL3SYi+neXnFvgTsf7BSfnnegOTCwRX/2GTPdp+ZADtJ+OLf8hd4s2DSg==
X-Received: by 10.31.169.148 with SMTP id s142mr25641248vke.39.1470132907058;
 Tue, 02 Aug 2016 03:15:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.10.69 with HTTP; Tue, 2 Aug 2016 03:15:06 -0700 (PDT)
In-Reply-To: <xmqqwpk0f5jr.fsf@gitster.mtv.corp.google.com>
References: <CABEd3j8VLbpeWbA6BfHYp5aLPEy0PesqYoHM9u4OM=b7Qm=LDg@mail.gmail.com>
 <xmqqinvonwxc.fsf@gitster.mtv.corp.google.com> <CABEd3j-MW--YSC9=nwcgHzxd6cqmUY+ky3-wLxMiMmbBGsvS7Q@mail.gmail.com>
 <CABEd3j--sxCwv6fWmNxTtdpgwU0_YKbfiFONX6TsQFZGn79yuQ@mail.gmail.com>
 <CAP8UFD118RdB5dX2-wEm5VnKud7sirHhdC9kvWmXV0eAQHvfsA@mail.gmail.com>
 <xmqq7fc0jmhx.fsf@gitster.mtv.corp.google.com> <CAP8UFD315CgntwYiC9g-R7KN0XiL9635Vwv_y8yi4n-uj8o90A@mail.gmail.com>
 <xmqqwpk0f5jr.fsf@gitster.mtv.corp.google.com>
From:	Oleg Taranenko <olegtaranenko@gmail.com>
Date:	Tue, 2 Aug 2016 12:15:06 +0200
Message-ID: <CABEd3j_6DNgs1u5AdkkzWt7U=J2fZ4a-2jewVjkfExt0KPvWiQ@mail.gmail.com>
Subject: Re: git bisect for reachable commits only
To:	git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Guys,

thanks for discussion, I will try to reply in bulk here.
First, assuming the common ancestor is GOOD based on the fact that
some descendant given as GOOD is pretty bad idea.
It may be, but may not be. In the git-flow like workflows new features
(aka branches) are created from trunk (master/develop/...)
sporadically,
but later they will mutual merging. I would say more probably they
have not common base, then have.

Second, I don't ask "create a new algorithm to find all transition
from good/old to bad/new", not nesessary. If programmer feels
something
suspicious, he/she can create another bisect session with narrowed commit range.

Third, testing of any specific commit can be very expensive operation.
In my case - shutdown servers/refresh dbs/clean/rebuild in
eclipse/running servers/dropping browser cache/running app in
browser/going through some pages/view UI.
Some of steps of course are automated, but some not. Anyway I spend
5-10 min for every iteration. So knowing what commit is bad or good is
very valuable, then I'm very interested to hunt the bug-introduced
commit with minimal count of testing.

Scenario 4 (I will keep my previous mail numbering for possible later reference)
                 z1----z2---z3
                /     /      \
    G----x1----x2----/---x3---x4--B
          \         /   /
           y1--y2--y3--y4

This is the happy straight case with closed DAG (hehe, git for
scientists) between given G good and B bad commits.
Ideal bisect will check first the shortest way between G & B:
x1/x2/x3/x4. Let name first-bug commit we are really hunting H and
current first-bug candidate as h.
If h == x1 or x2 -> stop, found
If h == x3, bisect will try to test y2/y3/y4 path only
If h == x4, bisect will select shortest path z1/z2 (keeping in mind,
that x2 is already tested and is good)
  If h == z1 - found
  if h == z2 - looking in path y1/y2/y3

Scenario 5.
              v1-------v2
             /          \
        w1--/---w2-------w3---------w4--w5
       /   /   /                         \
      /   /   /            z1----z2---z3  \
     /   /   /            /     /      \   \
    C3--C2--C1--G--x1----x2----/---x3---x4--x5--x6--B
                    \         /   /
                     y1--y2--y3--y4

Unhappy case, we have side branches which may introduce bug behaviour,
we need to look it through to figure out why it was done, what problem
was solved for that and so on.
Let looking in shortest path x1-x6. If h == x1..x4 - happy use case of
scenario 4. If discover that h == x5, we are forgetting about z/y
paths, but first we looking for nearest common commit (C1). As far as
we agree that currently is not clear when the new feature was
introduced we need to explicit check commit C1 whether it contains a
feature we are hunting bug up.
if C1 is good then pretty possible bad transition was happend in w2-w5
commits. Else (C1 is bad) assume that there is no transition from good
to bad, then assume H == x5 (stop)
if C1 is good and h == w4/w5 => stop,
  else if h == w3, new roundtrip, forgetting about w1 commit(not
interesting), testing C2, if bad - stop H == w3, if good, v1/v2
commits are to test.
  else if h == w2, forgetting C2 testing, just testing C3. If bad,
stop, H == w3, if good, w1 to test.

Using this approach we can safe working with ever octopus merging
(personally I'm not using, but why not)


Scenario 6.
                    z1---z2---z3
                   /    /       \
    C1--G--x1----x2----/------x3 |
     \      \         /         \|
      \      y1--y2--y3--y4--y5--y6--B
       \              \         /|
        \              w1--w2-w3 |
         \                      /
          v1------------------v2

Important note. Before start every side circuit based on common
ancestor user should be explicitly warned, that this is not just
ordinal intermediate bisect commit testing, but possible new round
trips with new commit/steps counts
For example, if current shortest path is x1-x6, bisect should say
about only 6 commits (3 after bisect), not calculating commits in
other paths.
Reaching node decision, bisect will stay and prompt for testing new
common ancestor with clear instructions what happens, if it will be
good or bad, (new unchecked commits and new left bisect steps, in case
good and stop or switch to other path in case of octopus).

I have another request to get git bisect more user-friendly, regarding
rolling back last step or steps, if accidentally 'git bisect bad' or
'good' was wrong entered, but I think it worth for another thread.


Cheers, Oleg
