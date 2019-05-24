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
	by dcvr.yhbt.net (Postfix) with ESMTP id CF1221F462
	for <e@80x24.org>; Fri, 24 May 2019 14:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403921AbfEXOI2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 10:08:28 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39457 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403914AbfEXOI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 10:08:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id f1so7252513lfl.6
        for <git@vger.kernel.org>; Fri, 24 May 2019 07:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to;
        bh=ANipaKJC+mwQNAi9SKqRbHXZuaQtcmiGCdRW0FfGYps=;
        b=ItWm6YdqndzsD2a4G+4FwlBVBvi+I8RCM5eLvLzSMDvo04ceYslswz6fMNLxYnEtBO
         6XdALF1ThRf5LOQu2SJBT9h5h8hWWjnJFFjrnkezwIu8FZVcN5vm5iWNyIZwjZ4r0jI8
         /EzwKHHAt1WXVTDyMMrn53e3yW+c/PcpHzBwmCuOcMXWH2rN8M5ZEW660E2vfLVSPdQN
         q0S7eX3efFHdtAvROZx6+x7d2oXy8/MdE78qqIRl5xfyVvjmghh6k2isQnR/LeNRfLAB
         fuA8jgFX3hhXq7ViFYNbHuyEsUbIkguW8RNZSltzYKPOJEC+2WAquF8+2sV/k1Hbg2Vm
         WZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to;
        bh=ANipaKJC+mwQNAi9SKqRbHXZuaQtcmiGCdRW0FfGYps=;
        b=ee2xbAl7dONrSnyn2PHQRAYHN1s8e5Xj5IzlyuA7d6ynqhXvj/wOfk7N1x1QXgJnGz
         nwj5eh48YF1ltwrH1NkMv66tLsGp/HRoFJiyjyhILf+c4mWiWYoaeZNWqd7vzFdWPdaX
         bTyP5oLrjayBlI/XBur/a9uEKpORrcORZ6i93kt0kzo8dklfKHXsw41DIMosvMI5khKB
         rZz9NsQjervu6FlLebelOMGrQYOMLJ+YzkF0scrIVHoZjWAHA75xPu729pR8GCruWCFf
         KSAQMemKNIimunu2Qx12lca7IgssF5vzDUeoY3FqLJjnhYT12MZqwXznIC8V/gVnS+8c
         Y16Q==
X-Gm-Message-State: APjAAAXKUjvas+/I49GW/uuuX6X9iPhnb2+ToadgmzVg4AXUXcMV2Azt
        Zd56J9Xh1/rqvU4mKgftBs+2fwhhyxSoBdd2Rj2NVUKy
X-Google-Smtp-Source: APXvYqxHORnvu+BLtaGNxATRFRu/2u+PIG6tpPms1iAUNE6ZedypjdwtDqI4mR/044Mur7pzgzBDoqmREtGkhQVANYY=
X-Received: by 2002:a19:ee0a:: with SMTP id g10mr15613463lfb.127.1558706905479;
 Fri, 24 May 2019 07:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd499AidrL4jCG_WytPJF9yHfJJJvWJ5fpjKN6sGBY5Weu8Hg@mail.gmail.com>
In-Reply-To: <CAHd499AidrL4jCG_WytPJF9yHfJJJvWJ5fpjKN6sGBY5Weu8Hg@mail.gmail.com>
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Fri, 24 May 2019 09:08:13 -0500
X-Google-Sender-Auth: vWIkguIHl_CHM5Kjkjtc7OWzagE
Message-ID: <CAHd499ArS4h=V=407D70uXhtAguvVmcogHVS3J199ECJAhgfgw@mail.gmail.com>
Subject: Re: Need help merging unrelated histories
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 24, 2019 at 9:04 AM Robert Dailey <rcdailey.lists@gmail.com> wrote:
>
> Everything I'm going to describe is related to this repository:
>
> https://github.com/powervr-graphics/Native_SDK
>
> This repo has several distinct branches. None of them seem to be tied
> to each other. Instead of having a `master` where they branched off
> each of their releases (e.g. 3.1, 3.2, 4.0), it looks like they made a
> copy of previous branches with no ancestry and then continued coding
> on that.
>
> What I'm trying to do is go back and rebase all of the X.X branches
> onto a new `master` branch. I started off with this:
>
> $ git checkout --orphan master
>
> Then I committed a `.gitattributes`. Next, I rebased the first
> (oldest) release branch:
>
> $ git rebase -i --onto master origin/3.0 --root
>
> Then I merged:
>
> $ git checkout master && git merge --no-ff -
>
> Next, I did 3.1:
>
> $ git rebase -i --onto master origin/3.0 origin/3.1 -X theirs
>
> Using interactive mode, Git is smart enough to detect duplicate
> commits and eliminates those, even though the 2 branches do not share
> a merge base. I continued doing this all the way up to rebasing 4.3,
> but that's when things got tough. I see a lot of 'UD', 'UA', 'AU',
> 'AA' merge conflicts. These are obviously due to the fact that the
> branches aren't connected. But I expected was that `-X theirs` would
> always favor what's on the branch being rebased. However, it seems
> this only affects modified conflicts, not adds or deletes.
>
> I was trying to find a way to bulk-resolve these. I mean, if git sees
> a file added on the left AND the right, I want the right one (theirs;
> the one coming from the 4.3 branch). Even though the branches are
> unrelated in terms of their history, I want the net effect of the
> rebase to essentially reflect the files on 4.3 itself. If a file isn't
> present on HEAD, delete it. If a file exists on REBASE_HEAD but not on
> HEAD, then add it. If the same file exists on both, favor the one on
> REBASE_HEAD.
>
> But I don't see a way of doing that. I tried `git checkout --theirs .`
> and `git checkout REBASE_HEAD -- .` but this doesn't work with all
> conflict types.
>
> Can anyone provide some advice on how to properly restructure this
> repository to create some ancestry, as if all along a `master` existed
> and all release branches were based on this in a linear fashion?

By the way, everything I've done so far (up to 4.2) is located here:

https://github.com/rcdailey/Native_SDK

There is a `master` branch in my fork of that repo. I am not sure if
I've done it correctly so far, or if how I've done this up to 4.2
explains why 4.3 is so hard.
