Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7140A1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 13:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfHZN3l (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 09:29:41 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43559 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbfHZN3k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 09:29:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id b11so17787661qtp.10
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 06:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3+WexfCOIGZXjXt/khnozInQvwhSnHtPGICY9mUeA/4=;
        b=Iu5Kq9Gi4KXFoOEW9yfcmBeRwAHwxi+6itxdsF4i2UBDgrusqD0w3Ov7cbLyGqBXTS
         x8QRzgHiIcb0/IDQMC6XC6m8KdtOESbN8b1LcQIw6bXT6PjT7hRq/1gxwHJE81dwigPX
         7QdG4VfCBh+coOTVl6fVIZPaGQ/hgoIsRZWU/5iml0uBmQVV0ysFQ4artPM9SfAh6tto
         j2RKWYI71KE2Ta/1LxhWGnJJuScmSpfKMsXMB6w2TUVllzYQTSqzyopEJ2rdkZtif6H2
         0TZ+GDf996ef48m3zHSsHYSwd0sSGJABQt9BoYqxj2m6jbqiNuvT9mywnASw8Q2FkRGE
         Qj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3+WexfCOIGZXjXt/khnozInQvwhSnHtPGICY9mUeA/4=;
        b=dTwb9goCM0Qm9U1S2YupDud3enWDAiCAPq8fWnV+t2eLn9Y92s7IILDgD9pjQItgM+
         DaLNsgez2pVboE+MQC03kTa7TjKGpM0vDNyJq0smXdcygyNY4oMI+1R4Uo3LU7HlbvpH
         6J3qHIqJ9/ghu1xCeq0oK1IQeVDCOyquDQYJWniJ7pcnICbfmlMJRFAP8daBSsq+AdZE
         G8iJBxHFvyn4jr4fy9iHfM+7pQl+0J208XjjUWxPhQV4MNFhm+isxqlabdmLFUlAC2KW
         GH4g+6LNY09xfRqLA8cESdA2TjLoCJnSEQtLyGMdLQqqpf8sjJ776vmxUbSPFhbxFisY
         /OIQ==
X-Gm-Message-State: APjAAAUmohEugzr8lpYNKp3yxDlLEcS3zmOLyLe3WAboMhWp3G5ZgX09
        OKscG+LsNnc6ZPeUzokTNYE=
X-Google-Smtp-Source: APXvYqy1ZPXuTHd2yDGo2ORdyklGDYJcQzaZAI50l5kNK1d03rC3rRCQsWCB5CIv+WAMFoZAK/Uc4g==
X-Received: by 2002:ac8:48c3:: with SMTP id l3mr15499209qtr.281.1566826179411;
        Mon, 26 Aug 2019 06:29:39 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:3044:fa5e:d80c:4bc4? ([2001:4898:a800:1012:e177:fa5e:d80c:4bc4])
        by smtp.gmail.com with ESMTPSA id t26sm7134641qtc.95.2019.08.26.06.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2019 06:29:38 -0700 (PDT)
Subject: Re: [PATCH 0/9] [RFC] New sparse-checkout builtin and "cone" mode
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.316.git.gitgitgadget@gmail.com>
 <CABPp-BFcH5hQqujjmc88L3qGx3QAYZ_chH6PXQXyp13ipfV6hQ@mail.gmail.com>
 <08bd295b-ec5a-3128-42cf-acb24971d679@gmail.com>
 <CABPp-BG8GtdaogbCCZqPXYkhMAqseyAXX0ppjUbg_1hVShGG=Q@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c919513a-f41f-2ce8-60ed-e0b0733c0c7f@gmail.com>
Date:   Mon, 26 Aug 2019 09:29:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BG8GtdaogbCCZqPXYkhMAqseyAXX0ppjUbg_1hVShGG=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/24/2019 1:40 AM, Elijah Newren wrote:
> On Thu, Aug 22, 2019 at 6:10 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 8/21/2019 5:52 PM, Elijah Newren wrote:
>>> On Tue, Aug 20, 2019 at 8:12 AM Derrick Stolee via GitGitGadget
>>> <gitgitgadget@gmail.com> wrote:
> 
> <snip>
>>>> Here are some more specific details:
>>>>
>>>>  * git sparse-checkout init enables core.sparseCheckout and populates the
>>>>    sparse-checkout file with patterns that match only the files at root.
>>>
>>> Does it enable core.sparseCheckout in the current worktree, or for all
>>> worktrees?  Do we require extensions.worktreeConfig to be set to true
>>> first?  If we don't require extensions.worktreeConfig to be set to
>>> true, and users add worktrees later, do they encounter negative
>>> surprises (immediately or later)?
>>
>> This is an interesting scenario that I had not considered. Thanks!
>>
>> My guess is that we should set `extensions.worktreeConfig=true` to
>> avoid surprises. I'll need to play with this to discover the answers
>> to these questions:
>>
>> 1. Where does the worktree look for the sparse-checkout file? Does
>>    each worktree have its own sparse-checkout file? Should it?
> 
> For the main/first/primary worktree: .git/info/sparse-checkout
> For all other worktrees: .git/worktrees/$WORKTREE/info/sparse-checkout
> 
> So, yes, each has its own, and from my viewpoint, absolutely yes that
> is what we want.

Thanks for the info! I will definitely consider this in the next version,
and include a test to verify the interaction.

>> 2. If I have `extensions.worktreeConfig=true` and `core.sparseCheckout=true`
>>    in the current worktree and run `git worktree add`, does the new worktree
>>    have `core.sparseCheckout=true`? Can we `git clone --sparse` and then
>>    start building sparse worktrees seamlessly?
> 
> My $0.02: I think `git worktree add` should not only adopt the setting
> of core.sparseCheckout from the current worktree, but it should also
> adopt the $GIT_DIR/info/sparse-checkout file too.  Granted, users can
> change it to something else, but much like a new shell starts up with
> the same current working directory as its parent shell, I think it'd
> be most obvious for people to have a worktree that looked similar to
> the one they launched it from.

This seems natural to me: I'm adding a new worktree and expect the
settings to match my current worktree. If we later want to extend
`git worktree add` to include an `--empty-cone` option (that creates
the worktree as if it was created by `git clone --sparse-cone`) we
could do that independently.

> <snip>
>>> The default of reading from stdin seems a bit unusual to me, and I
>>> worry about having to explain that to users.  I'd rather the add
>>> command took positional parameters (anything that doesn't start with a
>>> hyphen) and added those, e.g.
>>>   $ git sparse-checkout add '/myFolder/*' '
>>> with the option of the user specifying --stdin.
>>
>> I had the same thought, and likely that's where we should go with the
>> builtin. For our needs, the input over stdin is more important for
>> testing, so I built it first. I will adjust the CLI here to take a set
>> of paths over the arguments unless --stdin is given.
>>
>>>>  * git sparse-checkout disable removes the patterns from the sparse-checkout
>>>>    file, disables core.sparseCheckout, and refills the working directory.
>>>
>>> Does it leave an empty sparse-checkout file around?  Also, what if
>>> users have several paths defining their sparse pattern, and want to
>>> temporarily get a full checkout and then come back -- do they need to
>>> re-specify all the paths?  (Maybe this *is* the route we want to go;
>>> I'm just trying to mention any possible negative effects we _might_
>>> run into so we can consider them.  It's not quite as relevant in my
>>> case since people specify a few toplevel modules and sparse-checkout
>>> gets several entries auto-generated for them.)
>>
>> In this case, there is an intermediate step (that follows the existing
>> advice) to modify the sparse-checkout file to contain only "/*\n" then
>> run read-tree to fill the working directory before disabling the config
>> setting.
>>
>> Perhaps "disable" is the wrong word to use, as it makes you think that
>> there should be an "enable" that can quickly toggle between the two
>> modes. Maybe instead it should be "git sparse-checkout reset [empty|full]"
>> where you could 'reset' the sparse-checkout to one of two initial
>> states:
>>
>> 1. empty: only files at root are included.
>> 2. full: all files are included.
>>
>> In each case, we would obliterate the existing sparse-checkout entries,
>> but hopefully that behavior is more clear from the command names.
> 
> Will "reset" be seen as slightly less obvious wording that needs to be
> explained to users?  If so, maybe have "undo" and "empty" verbs?  (Of
> course, "init" already empties, both when starting from full or when
> we have some kind of sparse checkout.)  I dunno, just some ideas.

Thanks for pointing out that my word choice could be improved. I'll
consider several options.

>>>> In cone mode, a user specifies a list of folders which the user wants every
>>>> file inside. In addition, the cone adds all blobs that are siblings of the
>>>> folders in the directory path to that folder. This makes the directories
>>>> look "hydrated" as a user drills down to those recursively-closed folders.
>>>> These directories are called "parent" folders, as a file matches them only
>>>> if the file's immediate parent is that directory.
>>>>
>>>> When building a prototype of this feature, I used a separate file to contain
>>>> the list of recursively-closed folders and built the hashsets dynamically
>>>> based on that file. In this implementation, I tried to maximize the amount
>>>> of backwards-compatibility by storing all data in the sparse-checkout file
>>>> using patterns recognized by earlier Git versions.
>>>>
>>>> For example, if we add A/B/C as a recursive folder, then we add the
>>>> following patterns to the sparse-checkout file:
>>>>
>>>> /*
>>>> !/*/*
>>>> /A/*
>>>> !/A/*/*
>>>> /A/B/*
>>>> !/A/B/*/*
>>>> /A/B/C/*
>>>>
>>>> The alternating positive/negative patterns say "include everything in this
>>>> folder, but exclude everything another level deeper". The final pattern has
>>>> no matching negation, so is a recursively closed pattern.
>>>
>>> Oh, um, would there be any option for fast but without grabbing
>>> sibling and parent files of requested directories?  And could users
>>> still request individual files (not with regex or pathspec, but fully
>>> specifying the path) and still get the fast mode?
>>
>> Exact files could probably be included and still be fast. It requires an
>> extra hash check per entry, but that's a small price to pay I think.
>>
>> With the sibling files, this is something I believe to be user-friendly:
>> as a user drills down into the folder they included recursively, there may
>> be helpful files along the way, like documentation, project files, etc.
>>
>> Here is my philosophical position here: a repo can take advantage of the
>> sparse-checkout feature if it is properly componetized. Those component
>> boundaries are likely at folder boundaries. Any file that exists in a parent
>> folder for two components is likely important to _both_ components. If
>> a file is large and is not needed by both components, it should be placed
>> deeper in the tree, so it can be avoided.
>>
>> With that philosophy in mind, I designed this to help users fall into the
>> "pit of success" when their repo is in a good shape AND to motivate users
>> with repos in non-optimal shapes to reorganize.
>>
>> The thought I had about exact file names is similar: if there is a large
>> list of files in a folder where I only need a subset, then how do I know
>> if a new file is added that I need? It will not show up in the directory
>> without updating the sparse-checkout. A user would discover this need by
>> something going wrong when they are not interacting with version control:
>> a build.
>>
>> This is particularly important with the root directory. We need things
>> like .gitignore, .gitattributes, README, LICENSE, etc. to be populated
>> by default. If there are too many files at root to reasonably work with
>> the repo, then the repo should be reorganized using folders.
>>
>>> Basically, our sparse usage is exclusively specifying leading
>>> directories or full pathnames of individual files, but we really want
>>> the repo to feel smaller and make sure people notice at a glance.  We
>>> have a huge 'modules/' directory, and want people to be able to get
>>> just 15 of the 500 or so subdirectories that would appear in that
>>> directory with a non-sparse checkout.  And similarly we want to be
>>> able to grab just one or two files from a directory of many files.
>>
>> Your modules/ example seems to work with the feature as designed, as
>> you want a set of folders one level deeper. Grabbing one or two files
>> from a directory is a direction we can go with the feature, but I will
>> continue to believe that should be a rare occurrence compared to including
>> a folder recursively.
> 
> Oh, you're right, I was misunderstanding what it'd do.  This does look
> like it's really close to what we're using, and most of the
> differences are probably worth some slightly reshuffling of paths in
> the repo.  Now that I've played with it some, it seems really awesome.
> 
> Being able to grab one or two files from a directory without grabbing
> an entire directory and its parents I think would probably still be
> useful, but I do agree that it'd be a rare occurrence.

I think we can leave the file-by-file addition for later, but may need
to make certain design decisions in this initial version to avoid issues
with adding that feature in the future. (Perhaps the recursive-folder input
should have "/" at the end, to clearly state these are folders, not files.)

>>>> Note that I have some basic warnings to try and check that the
>>>> sparse-checkout file doesn't match what would be written by a cone-mode add.
>>>> In such a case, Git writes a warning to stderr and continues with the old
>>>> pattern matching algorithm. These checks are currently very barebones, and
>>>> would need to be updated with more robust checks for things like regex
>>>> characters in the middle of the pattern. As review moves forward (and if we
>>>> don't change the data storage) then we could spend more time on this.
>>>
>>> Instead of trying to validate the sparse-checkout file everytime,
>>> perhaps we want to change core.sparseCheckout from a boolean to a
>>> tri-state or something where it specifies how to parse the
>>> sparse-checkout file?  Or maybe when special directive (some form of
>>> comment-looking line) appears at the top of sparse-checkout then we
>>> use the hashsets speedup while disallowing general regexes and
>>> pathspecs other than leading directories and full pathnames?
>>
>> In this series, I turn `core.sparseCheckout` into a tri-state, and only
>> try to validate the sparse-checkout when `core.sparseCheckout=cone`.
>> This avoids spending time on the validation when someone is content using
>> the existing feature.
>>
>> The _intent_ of using the sparse-checkout file and no extra data structure
>> was to let other clients (or an older client) read the sparse-checkout data
>> and result in the same working directory. One thing I realized after
>> submitting is that the tri-state config variable will cause old clients
>> to error on parsing the non-boolean value. Instead, in v2 I will introduce
>> a new boolean config variable "core.sparseCheckoutCone" that will do the
>> same thing as the current series when `core.sparseCheckout=cone` and will
>> fix this compat scenario.
> 
> Once we are forced to use yet another config variable, we may as well
> use yet another config file ($GITDIR/info/sparse-checkout-cone or
> something; or maybe a less specific name with greater future
> compatibility via some version marking in it).

I'm hesitant to include a second "source of truth," as that can cause
issues when users modify the sparse-checkout file directly. Since the
existing way to interact with the sparse-checkout is to directly edit
the file, I want to be as careful as possible around users who modify
that themselves. The caveat is that if they specify "cone" mode then
they will get warnings and worse performance if they modify it outside
the limited patterns we allow.

> One thing I noticed twice while using this series was that when I had
> an existing sparse checkout it was easy to get into a weird state
> where things were messed up, I think due to the fact that
> "sparse-checkout init [--cone]" prefers to honor any pre-existing
> $GITDIR/info/sparse-checkout file.  Once my config file was very much
> not cone-compatible, and another time it was empty and caused
> read-tree to error out with something like "there'd be nothing left!".
> I manually twiddled with core.sparseCheckout and the sparse-checkout
> file and 'git read-tree -mu HEAD' to get it fixed, but I'd rather
> avoid others running into such problems.  Sorry I didn't take good
> notes on it; I was just trying to get a good feel for this series.

Thanks for this interesting use case! I think an empty file should be
updated with the root files, since Git does not think that is a valid
state. The current series must only check for existence, not content.
 
>>> I'll try to get some time to look over these patches in the next few days.
>>
>> I look forward to your feedback! I also have some feedback to respond to
>> from my team [1], but I'm waiting to make sure the community likes the
>> overall idea before jumping into code style and method organization
>> details.
> 
> I think this idea is great; I'm a big fan right now.  I'm excited to
> see how this will pan out.

Thanks! I'll be taking a close look at your patch-by-patch feedback
this week and hope to have a non-RFC v2 soon.

-Stolee

