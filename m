Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6825C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbiDMUrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbiDMUrT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:47:19 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8572546AB
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:44:55 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id z15so2228770qtj.13
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ugblbcZpfT6HJKVFaNd6Odltt4dDFSQMXrkFUaf1fO4=;
        b=JL+PI/WnHJEDH7R5hDq1dydGkPVjKDYaW+GLgDL5FjTZx7EZZhaCiF/cBNUHbFrN63
         2Cz013N3p7CDAleoHCVKLpKB1roRwBSUuv65QBskLYRAIot8NntJiOm+VH+mkkb9XzTM
         W9jqxY6ZDbn43ljwXDOPyQNqJxY8oA8WZHFdpxqvsVMO3VajA2g9qhhdxiOXMQEbslkd
         AqkBi8wnc+CAip451RI9j3nYYGjab4+qrSNZWCH9yUuqLvr9vA35rU/mv2j5YCarYWjD
         nrt41oBwq5AojCCoxeeoY8FdphsIDKocXGFafaVged8G5WeC6pj7UU11wJKDkYCsfbEU
         KYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ugblbcZpfT6HJKVFaNd6Odltt4dDFSQMXrkFUaf1fO4=;
        b=JKSZuwiq4hHX0qFdEYOnhdS1haipflaukwYGYWcuRVW13nQ7bg0n6yk9De+yIKd5WC
         GiIGo0gnvo36EBs0FsW8zKJZQ9D2Xk+CYNow6lAHx9/81lE1lsVTHmf35mqRpVTnb23L
         uxXgjvrcRto7xMGoLoL5oRvCXB3HmnsLNgEqBu2g54GyRsEJDwAYcSQELd+8ub2UF26Z
         PmDlXEt26LH0XLMbDwIe2XS0lFCVzinlaxsS8nGM8+haN1G18BAd0OY7b3nyiHjbRgh/
         13Fel8lzwsFHK7MdTdIEtmzDH1B0wQldK1yaEh1BlVORWQABtXH2lElTbxqJZZ/xSyf+
         3m6w==
X-Gm-Message-State: AOAM531qSJsGJyJfm3j/khS8vDKclv4x4QANHi3/5aXkhZFb2CThfHRn
        Glieo0agA+wRUl76+4aygM9qhY8LYMce8Sbz
X-Google-Smtp-Source: ABdhPJy4m2z/JXsygsVbRsAy/A3KGYDLfa3u+lESVhou5YcK91xPzz5RclgS+UINjFdk54E6BTx0Gg==
X-Received: by 2002:ac8:776a:0:b0:2ee:a9d5:569c with SMTP id h10-20020ac8776a000000b002eea9d5569cmr8553217qtu.599.1649882694670;
        Wed, 13 Apr 2022 13:44:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x20-20020a05622a001400b002f04bcd1e55sm4495961qtw.70.2022.04.13.13.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:44:54 -0700 (PDT)
Date:   Wed, 13 Apr 2022 16:44:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Shubham Mishra <shivam828787@gmail.com>
Cc:     git@vger.kernel.org, kaartic.sivaraam@gmail.com
Subject: Re: [PATCH 1/1] Initial draft proposal
Message-ID: <Ylc2RXwJaP2M0vqd@nand.local>
References: <20220409184350.1124-1-shivam828787@gmail.com>
 <20220409184350.1124-3-shivam828787@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220409184350.1124-3-shivam828787@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shubham,

On Sun, Apr 10, 2022 at 12:13:50AM +0530, Shubham Mishra wrote:
> Initial draft proposal for reachability bitmap

Thanks so much for your interest in this project and the time you've
spent putting together this proposal. Sorry that it has taken me a few
days to get back to you. Let's take a look...

(I should mention that this shouldn't be reviewed to be picked up by
Junio, so it would be fine to just send the contents of "proposal.txt"
as an email to the list directly instead of a patch. But it's fine to
review it either way, just stating this in case other readers aren't
sure).

> About Me
>
> I am Shubham, I am currently working as a Software Engineer at
> Microsoft India. I am a 2021 graduate from Delhi University. I am
> passionate about core engineering and backend technologies. I love to
> see beyond all abstractions and how things really work under the hood.
> So, I can work from their roots and make things better. I feel
> engineering is all about the tradeoffs that we make and I am trying to
> learn them to become a better Engineer.
>
> I am passionate about open source technologies and have quite a good
> amount of contribution to them, I participated in GSoC 2020 with
> [KDE](https://summerofcode.withgoogle.com/archive/2020/projects/6473982317953024),
> did Internship with Linux Foundation -
> [HDV](https://wiki.lfnetworking.org/display/LN/HDV), Season of KDE -
> [report](https://community.kde.org/SoK/2020/StatusReport/Shubham), and
> I am doing voluntary contributions to VSperf, BoostC++ and some other
> open-source projects.

Great, that all sounds like terrific experience! Typically GSoC only
allows accepted contributors to participate once, but an exception has
been made for participants in the 2020 and 2021 cycles, so you would be
eligible here under those rules.

   https://developers.google.com/open-source/gsoc/faq#what_are_the_eligibility_requirements_for_participation

> Project Abstract
>
> During repository clones, the Git server needs to find out all the
> objects which clients do not have and need to be sent to the client.
>
> To make the process faster, Git uses bitmaps to quickly find all the
> related objects from an object. Bitmap approach is a performance
> optimization over the legacy "Counting Objects" - the process in which
> the git server used to iterate through the graph from branch tips to
> the beginning of history to list down all objects that need to be
> sent.
>
> bitmap made reachability faster but uncompressed bitmaps can cost a
> lot of extra storage. Git uses a C ported version of
> [EWAHBoolArray](https://github.com/lemire/EWAHBoolArray) to compress
> bitmaps which get stored in the ".bitmap" file with the same prefix
> "sha" as ".pack" and ".idx".

Right; there are more than 8.5M objects in my (very outdated copy of
linux.git), so it would be impractical to store an 8.5M-bit array for
each selected commit.

> The aim of the project is to design a performance test suite as well
> as do the necessary changes to improve bitmap performance by trying
> out a new compression scheme that can make read operations along with
> other common operations like intersect, union and negate faster.

Well stated. Like I mentioned in another similar proposal, I think
validating our assumption that the performance of bitmap decompression
is worth pursuing is a good first step. We may find that using a
different compression scheme:

  - makes it faster to read bitmaps (by taking less time to decompress
    them)
  - makes it faster to write them (by taking less time to compress the
    bit-arrays)
  - use less memory for one, the other, or both of the above

, alternatively, we may find that switching EWAH for something else
doesn't make a meaningful dent in any of those areas, in which case we
can find something else to work on, too ;-).

> Me & Git:
>
> ## Microproject:
>
> I worked on the microproject "Avoid pipes in git related commands in
> test scripts", the patches for it has been merged to master now
>
>   * https://public-inbox.org/git/20220224054720.23996-3-shivam828787@gmail.com/
>   * https://public-inbox.org/git/20220224054720.23996-3-shivam828787@gmail.com/
>
> I run a pattern matching grep to find all git commands on LHS of pipes
> and fix all of them from file t001-t050.
>
> As an outcome of this process, I got to learn the code review process
> at git work, which is quite cool and different from other
> organization's I contributed to before.
>
> I learned about building source code, running tests, using email to
> send patches, communicating with reviewers and sending the next patch
> version process.

Terrific; I was glad to see that you were able to work on modernizing
those test scripts by removing git invocations on the left-hand side of
a pipe. Hopefully that gave you some good hands-on experience with our
development process, which it sounds like it did.

> ## Current understanding:
>
> - I have gone through git internals, and I well understood about the
>   pack files as well as the difference between git objects (tree, blob,
>   commit).
>
> - I have gone through some documentations - "MyFirstObjectWalk", etc.
>   it was a good hands-on to get some glimpse of general object related
>   tasks.
>
> - I understand how bitmap works in general, I have got some idea how
>   EWAH compression works and also I have gone through the research paper
>   on roaring run.
>
> - I played with commands of pack-object - "git pack-objects dir
>   --progress < obj_lists.txt" and read the code of related files
>   "pack-bitmap.c" and parts of "pack-object.c"

Great; if you are looking for more areas to dig in, I'd recommend
reading:

    - pack-bitmap-writer.c
    - midx.c (the bitmap-related parts)
    - and spending extra time with pack-objects.c (as you mention you
      already have, but this is the best place to look for how
      pack-objects uses bitmaps to accelerate its work).

There are other parts of the code that use bitmaps, too, for some more
straightforward tasks. See for e.g., the parts of builtin/rev-list.c
that match a search for "bitmap".

> Execution plan:
>
> I am interested in keeping my primary focus on "building a performance
> suite and improving bitmaps performance by finding a better
> compression scheme" project and if I finish this early or even after
> the GSoC timeline, I will be happy to contribute to other tasks too.

I think that's a good strategy. Like I mentioned in the other proposal,
too, the goal behind having a few different sub-projects to pick from is
that it gives you some additional flexibility to choose what is most
interesting to you. It definitely isn't meant to suggest that we should
do all of the sub-projects within, since I think any one of them done
right could easily fill up the entire GSoC contribution period.

> [...] I do not have enough knowledge yet to figure out how
> compatible croaring is with the current .bitmap format. We might need
> to make changes in the current .bitmap format accordingly.

Good summary in the parts I elided with the [...] in the quoted section
above.

I think that we will likely want to introduce a new bitmap format. We
*could* use the existing format, and indicate to older readers that we
are using a newer format by incrementing the version identifier and
otherwise leaving the format unchanged.

But I would like to get away from the existing .bitmap format, since the
way we read the hash-cache extension makes it difficult to add things
like a variable-width table of contents. So it would be nice to make the
.bitmap format compatible with the new-ish chunk-format API that Stolee
worked on a year or two ago.

Of course, this will be a not-insignificant project in and of itself. It
also carries some notable downside that JGit won't be able to read the
newer format of bitmaps. We could consider expanding the GSoC project to
help JGit add support for that, but I don't think it's strictly necessary
for you to take that on, since JGit should gracefully ignore the unknown
version number.

> Steps I will be following to accomplish the task-
>
> 1\. Get a better understanding of bitmap related functionalities/
> codebase, EWAH, roaring+run techniques.
>
> 2\. try to build out an initial draft version implementing only
> minimal required core changes, I will try to get a review on it from a
> wider audience (including mentors).
>
> 3\. make changes according to the comment and repeat the review
> process.
>
> 4\. build a performance suite for the changes I have done in the above
> steps.

It may be worth making this occur after the first step in your proposal,
since it removes bias from when you design the performance tests and
keeps us honest about whether or not our changes are worth making.

(Please don't worry about the possibility of replacing EWAH compression
not helping bitmap performance; if it doesn't, there is no shortage of
other things that we can work on in this area ;-)).

> 6\. Until this time, I will also get a good understanding of the
> bitmap related projects, so if we will be able to make good progress
> on roaring+run. I can start picking other subprojects too like 'table
> of contents' for the .bitmap file where past work -
> [https://lore.kernel.org/git/YNuiM8TR5evSeNsN@nand.local/](https://lore.kernel.org/git/YNuiM8TR5evSeNsN@nand.local/)
> can act as a good reference to me or/and 'append-only bitmap
> generation' subproject.

I think it makes sense to pick one or the other, since both will be
fairly involved. Like I said earlier, I think we'll have to investigate
a new .bitmap format for the "table of contents" project, so we may want
to dedicate some time to sketching out what that would look like.

> Timeline
>
> I am available to dedicate around 30-35 hours every week to the project.

That seems reasonable to me.

> Community bonding periods -
>
> 1.  Exploring code base mostly related to bitmaps
> 2.  research on other bitmap compression techniques
> 3.  reading technical documents
> 4.  interacting with mentors to understand them and project in more detail.
>
> 12 June - 25 July:
>
> 1.  Writing the first version with the new compression technique
> 2.  Get the initial version reviewed by reviewers and make changes accordingly.
> 3.  write performance test for these changes
>
> 25 July - 4 sept
>
> 1.  if tests result well, extending the above functionality to completely move to a new technique.
> 2.  writing more performance tests.
> 3.  start picking up other tasks if time left
>
> Sept 5 - Sept 12
>
> 1.  I will make sure to get all changes merged before this week including tests
> 2.  if not, make a decision with mentior on extending the project

This looks reasonable-ish to me, though I would suggest a couple of
changes:

  - Dedicate some time to investigating whether or not a new .bitmap
    format is required up front, adjusting the rest of the schedule
    accordingly if it is.

  - Move the writing the performance tests up much earlier, since I
    think it makes sense to start there, rather than to wait until the
    end to start evaluating our changes (and it removes some degree of
    bias, like I mentioned earlier).

I'm not too attached to the particular dates, TBH, and much more
interested in the general pace and priority of things.

> Blog
>
> I want to make blog writing a habit so I planned to publish biweekly
> blogs at [https://shubham828.github.io/](https://shubham828.github.io/)
> during this GSoC and after that. This is something I started during my
> last GSoC too but unfortunately couldn't continue post-gsoc. This GSoC
> gives me another opportunity to become a regular blogger.

Wonderful, I'll look forward to reading your blog posts in this area if
we end up working on it.

> After GSoC
>
> I would love to be a regular contributor of Git. After GSoC, I can
> pick any left out subprojects of bitmap reachability and I would also
> be happy to extend my knowledge beyond bitmaps to learn and contribute
> to other parts of git too.

That's great!

Thanks,
Taylor
