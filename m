Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 808581F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 22:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752767AbdKMWEz (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 17:04:55 -0500
Received: from mail-ua0-f180.google.com ([209.85.217.180]:55650 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752705AbdKMWEz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 17:04:55 -0500
Received: by mail-ua0-f180.google.com with SMTP id r11so4897301uah.12
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 14:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J+GbmnM3FdF4xLPcFdRZLXzoX1B6tKHRv8PN1Gatx+Y=;
        b=cJXTuUeZM/7fMIoonN7Y+P3ai+y60Hhiame+cA2yeFak56S6mvsGHTnkma6wk5ydPb
         mbGvLYUxpBRidc+iyQOwqMVtf2WN3qiX7blgAvYBoulU5TLNj21wpZm0cjsbk5ji+y/m
         aidp6P/9g3zoYlxkKMdA2eEfv0CRj5NKINc8kHmPefte0ROO0kTnveu4NEEq/lf0NnAm
         Sz6lksJxr94y8bKW4asuzTc6BFAs/3Zi3GiV/HiQKtrYGOSipk1QqbBYo27uAU7qxfAc
         9Xgy9gaWj0/mCxWIXfhtS3OIFHgUr+cCmMdgpc+BEie8cmMVVykfktww68Z7x/M+lv4j
         1Meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J+GbmnM3FdF4xLPcFdRZLXzoX1B6tKHRv8PN1Gatx+Y=;
        b=b4KF6kRrWFpZ6wpiHLEugqEBZ/6qR+gZnO2TjL2SY9/OXO3cp9rV9wqzAgPi6lx5Qu
         dg2F2J/1UOx/nEgnQap3Sf2AjpJ3tfOZ++AfU3hUymBcogIw/4pBKDnkIa3eappVYpQF
         3DdE84lGivmukRYJUdzzP8AJe+aSxKrLWGBuSY6VM3pJxYO5xeR739sqzhpkrcwaYq5x
         sw7e0jqKXOcxUcM1JNTOXiT0s5bixpUK+52QjoKZkjxGHz68FfAXdAnyPL4GXuvHyNbA
         hXCyBLN6VKUpYg9oaz+7ROTzimyIv3aKES1i9S78izkGCamyVlJHZsSdqGED+MR3X7X+
         6JSA==
X-Gm-Message-State: AJaThX56QGn1DtP7Mhk7qjo+jA8AlmAm9lX6gmE6Zd5GKm7hO7QTz/tP
        e+n3E6gadFIHquDpLwnyKJgHRmRs2rmnLN/IK2I=
X-Google-Smtp-Source: AGs4zMYvop6lv92yQ1FP0D6iwaS0TBABMMuwWFa0dIrn5qKmiMR0snKpOVmESH0prxPw7mU3U0sJW7drES/QjW6qzeY=
X-Received: by 10.176.95.138 with SMTP id b10mr9356019uaj.55.1510610693782;
 Mon, 13 Nov 2017 14:04:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Mon, 13 Nov 2017 14:04:53 -0800 (PST)
In-Reply-To: <CAGZ79kYXbvDL_SoEENf60DsDFA-yEWfvgv8bNv_v+mw042ZH=w@mail.gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-3-newren@gmail.com>
 <CAGZ79kYXbvDL_SoEENf60DsDFA-yEWfvgv8bNv_v+mw042ZH=w@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Nov 2017 14:04:53 -0800
Message-ID: <CABPp-BFX-xZf962vuCjJSaB0=sPMT_zNF8+mGPG04dFi5PE6SQ@mail.gmail.com>
Subject: Re: [PATCH 02/30] merge-recursive: Fix logic ordering issue
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the reviews!

On Mon, Nov 13, 2017 at 11:48 AM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Nov 10, 2017 at 11:05 AM, Elijah Newren <newren@gmail.com> wrote:
>> merge_trees() did a variety of work, including:
>>   * Calling get_unmerged() to get unmerged entries
>>   * Calling record_df_conflict_files() with all unmerged entries to
>>     do some work to ensure we could handle D/F conflicts correctly
>>   * Calling get_renames() to check for renames.
>>
>> An easily overlooked issue is that get_renames() can create more
>> unmerged entries and add them to the list, which have the possibility of
>> being involved in D/F conflicts.
>
> I presume these are created via insert_stage_data called in
> get_renames, when the path entry is not found?

Yes.

>> So the call to
>> record_df_conflict_files() should really be moved after all the rename
>> detection.  I didn't come up with any testcases demonstrating any bugs
>> with the old ordering, but I suspect there were some for both normal
>> renames and for directory renames.  Fix the ordering.
>
> It is hard to trace this down, though looking at
> 3af244caa8 (Cumulative update of merge-recursive in C, 2006-07-27)
> may help us reason about it.

It doesn't really go back that far.  I added the
record_df_conflict_files() function (originally named
make_room_for_directories_of_df_conflicts()) in commit ef02b31721
(merge-recursive: Make room for directories in D/F conflicts
2010-09-20); the rename happened in commit 70cc3d36eb
(merge-recursive: Save D/F conflict filenames instead of unlinking
them 2011-08-11).

> How would a bug look like?

Some of these corner cases sometimes get confusing to try to reason
about and duplicate, so I was trying to avoid that....oh, well.  :-)
I mostly wanted to use the simple logic that:
record_df_conflict_files() exists to take an inventory of all unmerged
files to make sure that D/F conflicts can be handled appropriately.
get_renames() has the potential for adding more unmerged files, thus I
should have placed record_df_conflict_files() after get_renames() when
I introduced it.

But since you asked...

A bug here would essentially mean that a git merge fails to handle
files in directories under a D/F conflict; when trying to process such
files and write out their conflict state to disk, it would fail to
create the necessary directory because a file is in the way.

In order to trigger it, you'd need to have a D/F conflict where the
file involved in the D/F conflict wasn't unmerged after unpack_trees()
but only "shows up" due to the rename detection (i.e. added by the
insert_stage_data() call as you mention above).  I think reading
through Documentation/technical/trivial-merge.txt, that this actually
isn't possible with what I'm calling "normal" renames; it's actually
something newly possible only due to directory rename detection.  But
you may have to get the merge direction just right, you might have to
worry about files that sort between a file with the same name as a
directory and the files within the directory (e.g. "path.txt" in the
list "path", then "path.txt", then "path/foo").

Do you feel it's important that I come up with a demonstration case
here?  If so, I'll see if I can generate one.
