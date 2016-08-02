Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E02481F71B
	for <e@80x24.org>; Tue,  2 Aug 2016 17:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756996AbcHBR0l (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 13:26:41 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:34743 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756866AbcHBRZm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 13:25:42 -0400
Received: by mail-io0-f175.google.com with SMTP id q83so219747476iod.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2016 10:25:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FPJv61Cy7UJUucTq/R/Iulw88R6SLIQzCIaNwR9ksX8=;
        b=d0mirqUSG8dVmqUB/WUl6Do+jMD2I2t1foUP3dVKDyFjX7BKgHaqOcK9wXJU2bsoqY
         X0LEihKWq3tXgy1HZmPbF3j0arPau00V6im1lJnk6SxJ38sK3E1CzjTQmbSTHSb+3sdv
         ngeyngdzfMKAfRc+VLiRbJOaBQ0j2RPX/S6o3uGLPNvO9QY6jnwCSeSbHZTG5rVG7IKs
         D1oyi+dFYfPv0MOx14m9DBSkerW2LP7YZ4MpKqiCD25SI453N5WL5A2HcHpsCjvgZs67
         /rG/ldqvKfNqApdwkdvF7RvAdu2Zo5MwdYgR0VGhKpTDBXZJIx7gdlDYnd7oz6/e6VE2
         I7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FPJv61Cy7UJUucTq/R/Iulw88R6SLIQzCIaNwR9ksX8=;
        b=BCfeJBuAF3UXnAosg0Jra4Bdthq7J7Pc1W7b2EBpDqzXJCW7rDq97beYoue3YyGtbS
         zfbxFLP7X+4C1rcbRVaDHG/RGKPA8eg7Tldy4rhqmcfBuvdtd/MyiTrvLs0KpNmsKx4N
         7JKp24/sgVrb45JFpiFqHfwOf8vIgRqfuWTYxLARRsUckk3mdro0WrBLmGk7wxdh3mkk
         l8OYyqhF4zu+JQoz+F+ISiCXVGlzLBlT7+Pk90NLK+Kux0LpmXPMei40vskr2oZDgqbQ
         lSVvviwDHiy8h3K5pwJUxpEsx8m1xch7daH1tchSl54PCCeujXW8EkNQy2YMgD9IOUtH
         KTQQ==
X-Gm-Message-State: AEkoous+FpO8UCBpJCx0UxevWsWdpWn2ykYjPxPiucvzsmmVndVvEw2BgRX9MNscGenHg+oKUOkqK7cQIQKHE9Fo
X-Received: by 10.107.131.38 with SMTP id f38mr65652384iod.173.1470158727361;
 Tue, 02 Aug 2016 10:25:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 2 Aug 2016 10:25:26 -0700 (PDT)
In-Reply-To: <CABEd3j_6DNgs1u5AdkkzWt7U=J2fZ4a-2jewVjkfExt0KPvWiQ@mail.gmail.com>
References: <CABEd3j8VLbpeWbA6BfHYp5aLPEy0PesqYoHM9u4OM=b7Qm=LDg@mail.gmail.com>
 <xmqqinvonwxc.fsf@gitster.mtv.corp.google.com> <CABEd3j-MW--YSC9=nwcgHzxd6cqmUY+ky3-wLxMiMmbBGsvS7Q@mail.gmail.com>
 <CABEd3j--sxCwv6fWmNxTtdpgwU0_YKbfiFONX6TsQFZGn79yuQ@mail.gmail.com>
 <CAP8UFD118RdB5dX2-wEm5VnKud7sirHhdC9kvWmXV0eAQHvfsA@mail.gmail.com>
 <xmqq7fc0jmhx.fsf@gitster.mtv.corp.google.com> <CAP8UFD315CgntwYiC9g-R7KN0XiL9635Vwv_y8yi4n-uj8o90A@mail.gmail.com>
 <xmqqwpk0f5jr.fsf@gitster.mtv.corp.google.com> <CABEd3j_6DNgs1u5AdkkzWt7U=J2fZ4a-2jewVjkfExt0KPvWiQ@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 2 Aug 2016 10:25:26 -0700
Message-ID: <CAGZ79kbx-eq=NPMYon5MV_T5cqiFmcZ_F6zGQO5p7mgLg8bQ4A@mail.gmail.com>
Subject: Re: git bisect for reachable commits only
To:	Oleg Taranenko <olegtaranenko@gmail.com>
Cc:	git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 2, 2016 at 3:15 AM, Oleg Taranenko <olegtaranenko@gmail.com> wrote:
> Guys,
>
> thanks for discussion, I will try to reply in bulk here.
> First, assuming the common ancestor is GOOD based on the fact that
> some descendant given as GOOD is pretty bad idea.
> It may be, but may not be. In the git-flow like workflows new features
> (aka branches) are created from trunk (master/develop/...)
> sporadically,
> but later they will mutual merging. I would say more probably they
> have not common base, then have.

git bisect has the underlying assumption that the BUG is not there initially
and introduced by one specific commit, and continues to be there until B.
With this assumption you can do a binary search, which allows searching
in O(log n), which is optimal for the number of iterations needed.

>
> Second, I don't ask "create a new algorithm to find all transition
> from good/old to bad/new", not nesessary. If programmer feels
> something
> suspicious, he/she can create another bisect session with narrowed commit range.
>
> Third, testing of any specific commit can be very expensive operation.
> In my case - shutdown servers/refresh dbs/clean/rebuild in
> eclipse/running servers/dropping browser cache/running app in
> browser/going through some pages/view UI.
> Some of steps of course are automated, but some not. Anyway I spend
> 5-10 min for every iteration. So knowing what commit is bad or good is
> very valuable, then I'm very interested to hunt the bug-introduced
> commit with minimal count of testing.


As you point out each iteration is a burden to the user, so they should be
kept to a minimum.

>
> Scenario 4 (I will keep my previous mail numbering for possible later reference)
>                  z1----z2---z3
>                 /     /      \
>     G----x1----x2----/---x3---x4--B
>           \         /   /
>            y1--y2--y3--y4
>
> This is the happy straight case with closed DAG (hehe, git for
> scientists) between given G good and B bad commits.
> Ideal bisect will check first the shortest way between G & B:
> x1/x2/x3/x4. Let name first-bug commit we are really hunting H and
> current first-bug candidate as h.
> If h == x1 or x2 -> stop, found
> If h == x3, bisect will try to test y2/y3/y4 path only
> If h == x4, bisect will select shortest path z1/z2 (keeping in mind,
> that x2 is already tested and is good)
>   If h == z1 - found
>   if h == z2 - looking in path y1/y2/y3

* git is agnostic of the workflow, i.e. it doesn't know the notion of
topic branches or such.
* What is the worst case in you strategy?
  (h=y4 means 7 tests by the user IIUC)

Given the assumptions as laid out above such that we are able to
do a binary search, the ideal candidate for scenario 4 is
y4 or z3 as these split the set of commits to be investigated into
2 equally sized sets of ancestors and non-ancestors.

When a specific workflow is given, it may make sense to weight
commits differently. Also some people asked for a strategy that only
checks merge commits first, as there are far fewer merge commits and
these generally are used for introducing a new feature or refactoring.
