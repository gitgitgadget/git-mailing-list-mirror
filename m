Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E450201A8
	for <e@80x24.org>; Sun, 19 Feb 2017 13:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbdBSNIF (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 08:08:05 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36041 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751778AbdBSNID (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 08:08:03 -0500
Received: by mail-wm0-f41.google.com with SMTP id c85so55000291wmi.1
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 05:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h5AsGPAmr7M3D4sHpxtjz4G2HzuI2M8HlFPip5vQGNw=;
        b=dkSW8yCuWeiLQtlbO6KhA51cg+Mk2SINmmKOPGC6dm58CVQ1P4l7gshAXG4srEYKKp
         GdXZrPV1WLmIqDRgTOP/NPIZhnO2U0t66JnMqfbpXOO4tsDnxgsU3Gxmg4CCIUcFEDaV
         M+cTGl6QgEWIveDKmIjOn662JPxJgsmSOiEWCF4JubgE1ApAZROTWsY1ZM3o29baP8K9
         pdKL3yoEDregeEaMSJlPWQP2/F92ZHECIszxgjmcrVzVlx7IfCPxfXnDGZZLUThdwcxD
         OIOA+z3BPk/oIGuAZMilDXPtXLFbzJDy6ZPSDg3ruVpJfvYxILcUxkGwaV2WCjsCBkha
         4Glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h5AsGPAmr7M3D4sHpxtjz4G2HzuI2M8HlFPip5vQGNw=;
        b=gjM0lsOtKt6LFS9KC0t9WE8z4lmoMRDunQTuk0twxXOCXFRCD0OXfZCKiI83R/BHnq
         yScdEZWj+4kXTQNb3Vo0A4xQXJHeHxUj5mGNq/JHh4G1cJv/J7sZWzYfmF7V6Dj7R2Ay
         lZguSWuyiXUgnxeZwE8BritoH2rPiPba0vaWAeFdmSk/FjmeUzk1EkBnLV/WYKdNJ3pc
         x2n7IhEJZ1bO/d+7MjeN5xHsxRnL0J4AbAz5zBWVpoYMwjKD7Y2L5OoNIRI5PSxay3VX
         TZ3BSgZVlXY0nF/fYchBaTvgg1BpZA6e4kSF1l7S6tycxa+1jaA+iPCO5nC3802q/7Ps
         K50Q==
X-Gm-Message-State: AMke39ldH75AybmD2T4ZprPr7j/dVn6ZF+WD6BeC3LpG7SDLjcm1DcEjNMwFpWm+GwNa/BGRCylJQlo4OrJ0Sg==
X-Received: by 10.28.8.130 with SMTP id 124mr12958435wmi.65.1487509631507;
 Sun, 19 Feb 2017 05:07:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.15.19 with HTTP; Sun, 19 Feb 2017 05:07:10 -0800 (PST)
In-Reply-To: <CAMX8fZVeAEJ5tfCO_4Pebnq=rysaJ2xDMjH-9pjmPeF4FziLFw@mail.gmail.com>
References: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com>
 <d4991e4b-cbc4-da14-381a-88704e457a19@gmx.net> <3ff5ce3c-285f-cb9a-d1d4-46323524dab7@kdbg.org>
 <CAMX8fZVkBU6M8fkUcRr69V97_NTSOGGmPB1U-ObhmVv3i6wQhg@mail.gmail.com>
 <477d3533-d453-9499-e06e-72f45488d421@kdbg.org> <CAMX8fZW2y+iPRfSbXVcHufbM+CsqgekS_0WnCEJ++=njy_TvKg@mail.gmail.com>
 <CAP8UFD3ngMvVy2XLzYNn9OFbS+zQpWTW=pravpHhA-0PcDVhfg@mail.gmail.com> <CAMX8fZVeAEJ5tfCO_4Pebnq=rysaJ2xDMjH-9pjmPeF4FziLFw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 19 Feb 2017 14:07:10 +0100
Message-ID: <CAP8UFD2R94sPCd5i8NF1oZn+g8X6oYRqP7qYftmny2iXwh59Hw@mail.gmail.com>
Subject: Re: Git bisect does not find commit introducing the bug
To:     Alex Hoffman <spec@gal.ro>
Cc:     Johannes Sixt <j6t@kdbg.org>, Stephan Beyer <s-beyer@gmx.net>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 19, 2017 at 12:32 PM, Alex Hoffman <spec@gal.ro> wrote:
>> At the end of the git-bisect man page (in the SEE ALSO section) there
>> is a link to https://github.com/git/git/blob/master/Documentation/git-bisect-lk2009.txt
>> which has a lot of details about how bisect works.
>
> Thanks for pointing out the SEE ALSO section. I think it makes sense
> to include/describe the entire algorithm in the man page itself,
> although I am not sure whether the graphs would be always correctly
> visually represented in the man page format.

It would possibly be very long to describe the entire algorithm, as it
can be quite complex in some cases and it is difficult to understand
without graphs. Maybe we could describe it, or some parts of it, in a
separate document and provide links at different places in the man
page.
Anyway feel free to send patches.

>> The goal is to find the first bad commit, which is a commit that has
>> only good parents.
>
> OK, bisect's mission is more exact than I thought, which is good. M

Good that you seem to agree with this goal.

>> As o1 is an ancestor of G, then o1 is considered good by the bisect algorithm.
>> If it was bad, it would means that there is a transition from bad to
>> good between o1 and G.
>> But when a good commit is an ancestor of the bad commit, git bisect
>> makes the assumption that there is no transition from bad to good in
>> the graph.
>
> The assumption that there is no transition from bad to good in the
> graph did not hold in my example and it does not hold when a feature
> was recently introduced and gets broken relative shortly afterwards.
> But I consider it is easy to change the algorithm not to assume, but
> rather to check it.

I don't think the default algorithm will change soon, but there have
been discussions for a long time about adding options to use different
algorithms.

For example people have been discussing a "--first-parent" option for
many years as well as recently. It would bisect only along the first
parents of the involved commits, and it could help find the merge
commit that introduced a bug in the mainline.

>> git bisect makes some assumptions that are true most of the time, so
>> in practice it works well most of the time.
>
> Whatever the definition of "most of the time" everyone might have, I
> think there is room for improvement.

So feel free to send patches that would implement an option with the
improvements you want.

> Below I am trying to make a small
> change to the current algorithm in order to deal with the assumption
> that sometimes does not hold (e.g in my example), by explicitly
> validating the check.
>
>> --o1--o2--o3--G--X1
>>     \                \
>>      x1--x2--x3--x4--X2--B--
>>       \              /
>>        y1--y2--y3
>
> Step 1a. (Unchanged) keep only the commits that:
>
>         a) are ancestor of the "bad" commit (including the "bad" commit itself),
>         b) are not ancestor of a "good" commit (excluding the "good" commits).
>
> The following graph results:
>       x1--x2--x3--x4--X2--B--
>        \              /
>         y1--y2--y3

I would say that the above graph is missing X1.

> Step 1b. (New) Mark all root commits of the resulting graph (i.e
> commits without parents) as unconfirmed (unconfirmed=node that has
> only bad parents). Remove all root commits that user already confirmed
> (e.g if user already marked its parent as good right before starting
> bisect run). For every unconfirmed root commit check if it has any
> good parents. In the example above check whether x1 has good parents.

I think I understand the above...

>      If the current root element has any parents and none of them is
> good, we can delete all paths from it until to the next commit that
> has a parent in the ancestors of GOOD. In the example above to delete
> the path x1-x3 and x1-y3. Also add new resulting root commits to the
> list of unconfirmed commits (commit x4).
>      Otherwise mark it as confirmed.

... but I don't understand the logic of the above. If the root element
has a bad parent, then it means that the "first bad commit" is either
the bad parent or one of its ancestors, so it is not logical to delete
it. In your example if x1 has one bad parent, this bad parent and its
ancestors should be included in the search of the first bad commit.

Otherwise the goal is not any more to find the first bad commit.

PS: I saw that you have just sent another version of the algorithm,
but I don't want to take a look at it right now. Anyway I am keeping
my above comments as they might still be useful.

> Step2. Continue the existing algorithm.
>
>
> If this improvement works (i.e you do not find any bugs in it and it
> is feasible to implement, which seems to me)

As you describe it, I don't think it is compatible with the goal of
finding the first bad commit.
Also there are many things that are feasible to implement, but it
doesn't mean that someone will soon make the effort to implement them
in a way that looks good enough to be deemed worth merging into the
current code base.

> the following would be
> its advantages:
> 1. An assumption less, as we explicitly check the assumption.

Checking can be costly. If the probability that the check will fail is
very low, while the cost of checking is high, it is less costly on
average to not check.

> 2. It might be quicker, because we delete parts of graph that cannot
> contain transitions.

I don't agree that it's a good idea to delete what you suggest above.
Or if you think that the goal should not be to find the "first bad
commit" in the above case, then you should explain what the goal
should be.

> 3. It returns more exact results.

Yeah, but checking every commit related to the good and bad commits
would also return more exact results. (This can probably be done using
`git rebase --exec ...` by the way.) One could even print a nice graph
with all the good and bad commits. The problem is that it would not be
efficient. If git bisect makes some assumptions, it is because they
have been deemed reasonable and they have worked well in practice.
It's also because the goal of git bisect is to be efficient, otherwise
there would be no point in using a binary search algorithm in the
first place.
