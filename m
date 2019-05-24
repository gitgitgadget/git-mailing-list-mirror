Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2F751F462
	for <e@80x24.org>; Fri, 24 May 2019 14:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403934AbfEXOFL (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 10:05:11 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:34989 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403907AbfEXOFK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 10:05:10 -0400
Received: by mail-lj1-f173.google.com with SMTP id h11so8798053ljb.2
        for <git@vger.kernel.org>; Fri, 24 May 2019 07:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=U0xbbqA4wkmp0Eq+WFvI9l7SFdpb1z0iwOxF84OhH8E=;
        b=PhGvELX9osxxhph3UCCIm8OAE+kcDuyLlMwj+kVO174JA4py3B4Yr3iuueilPB+68c
         /d7pLV6/D1HGjfqDMwNUO/xIH3XguWSttcplkO1O9swlAr6sxX/AgP1vrVrFI8wNvboK
         dXj6/WZI46b6dY3d/drtRJpbiid4UjQAC0n/pWI8anqs0V94b+vougx5xeKNryhW55gu
         Jl/R42F0TdCpdDibVPtKfZzPj83WiSw1LmcjlZs3LPqXDkCVCJiQmRKp6wIPtPTx6Wyj
         maeYbF3WvzjAi6n8NzZpW2GR7aAhTDQKLFmMxaQTVRPXb78lo+/7hQKPUbEIrkMTySqO
         KNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=U0xbbqA4wkmp0Eq+WFvI9l7SFdpb1z0iwOxF84OhH8E=;
        b=lgfRPayxPJ4pmeMtrDXdjnEEx/mX2JqkqMKMuywfXYH0tuGtiE/uJdnQiiejXGXHVv
         0yO1irwqE23UPSUPGcVwnGVEOhvz0KcZ/HLSbWOi2sQbW+uabiMqqneJoAfwQyBc5hFe
         PoaD188VbIne1euFT4bEO/7s0HYdo8IGcCmXIMIioQHwppl4YUkro3t6EeKwIqLKr90r
         3Lueh+NLY4J/KcJMeet3afvrnIu6He+hseQKepS373H2xoovaFo4IdCtwh7wMB/Mi4MP
         /5qn1gXiYGMBWHEMst/AsPwVDvIpIdR9o/VEzEnkbcr3H2iCmpOlO5kQvmOsLTl4tYov
         NWcA==
X-Gm-Message-State: APjAAAWtNEQfrHMQUfQllglr6RxxKee3qKQJEUgh9rrwJrcQ2qP6vxt+
        Heo0EIzA5ylaFmojKoez2Wwvxm4067Vwr/MIM+bxrZ8L
X-Google-Smtp-Source: APXvYqx39r1ZEVfMhUJh11mlsJN+DkHMU5le+WynP2NaWhCzH6bix3QCKmLQ7t2W3xgx/37YAJzug/jiIhJs5yPjX2E=
X-Received: by 2002:a2e:1412:: with SMTP id u18mr18173357ljd.197.1558706708469;
 Fri, 24 May 2019 07:05:08 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Fri, 24 May 2019 09:04:57 -0500
X-Google-Sender-Auth: qbSnZnrdqmyWB1ITmNFd3xKEaCM
Message-ID: <CAHd499AidrL4jCG_WytPJF9yHfJJJvWJ5fpjKN6sGBY5Weu8Hg@mail.gmail.com>
Subject: Need help merging unrelated histories
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Everything I'm going to describe is related to this repository:

https://github.com/powervr-graphics/Native_SDK

This repo has several distinct branches. None of them seem to be tied
to each other. Instead of having a `master` where they branched off
each of their releases (e.g. 3.1, 3.2, 4.0), it looks like they made a
copy of previous branches with no ancestry and then continued coding
on that.

What I'm trying to do is go back and rebase all of the X.X branches
onto a new `master` branch. I started off with this:

$ git checkout --orphan master

Then I committed a `.gitattributes`. Next, I rebased the first
(oldest) release branch:

$ git rebase -i --onto master origin/3.0 --root

Then I merged:

$ git checkout master && git merge --no-ff -

Next, I did 3.1:

$ git rebase -i --onto master origin/3.0 origin/3.1 -X theirs

Using interactive mode, Git is smart enough to detect duplicate
commits and eliminates those, even though the 2 branches do not share
a merge base. I continued doing this all the way up to rebasing 4.3,
but that's when things got tough. I see a lot of 'UD', 'UA', 'AU',
'AA' merge conflicts. These are obviously due to the fact that the
branches aren't connected. But I expected was that `-X theirs` would
always favor what's on the branch being rebased. However, it seems
this only affects modified conflicts, not adds or deletes.

I was trying to find a way to bulk-resolve these. I mean, if git sees
a file added on the left AND the right, I want the right one (theirs;
the one coming from the 4.3 branch). Even though the branches are
unrelated in terms of their history, I want the net effect of the
rebase to essentially reflect the files on 4.3 itself. If a file isn't
present on HEAD, delete it. If a file exists on REBASE_HEAD but not on
HEAD, then add it. If the same file exists on both, favor the one on
REBASE_HEAD.

But I don't see a way of doing that. I tried `git checkout --theirs .`
and `git checkout REBASE_HEAD -- .` but this doesn't work with all
conflict types.

Can anyone provide some advice on how to properly restructure this
repository to create some ancestry, as if all along a `master` existed
and all release branches were based on this in a linear fashion?
