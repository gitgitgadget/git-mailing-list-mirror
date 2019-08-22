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
	by dcvr.yhbt.net (Postfix) with ESMTP id AFBDB1F461
	for <e@80x24.org>; Thu, 22 Aug 2019 13:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732234AbfHVNKw (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 09:10:52 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:33887 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730641AbfHVNKv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 09:10:51 -0400
Received: by mail-qk1-f169.google.com with SMTP id m10so5043220qkk.1
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 06:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kN+7HonwCl3t2wcKywDU9V4nKX78Zk41BwAPn2C/KGg=;
        b=RKXREzoDKhy0fKT6QtM1aAIcWodlwGTF+0ibGbyXExpxyuzAK2Vy3pkOAWnYcapAD2
         9Ismv9ELiJk96RZ91pxxeAdY4rP+InMS95DU2KDLnrA9s5Afl13/SoYvUI4TMltwskjc
         OrS/f3d0W2bh88L/zEBYyyOdHFF1gHKiTIBkGJELlrgPWwE6lN/KCbYR02HRsdCn4dL3
         1HUoBZ6+GNG0feayDbOD1m4HIp0cl7l18uYYc1Yh4pkYFGmWSGZogOACsRkVKQ5ZmgXv
         NfIj/k2EiGO4zlofNgtMh2zOVoTzT2Savh01zHtBz7OJv8XvjMxENBg9ST4Gay8ykHES
         WCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kN+7HonwCl3t2wcKywDU9V4nKX78Zk41BwAPn2C/KGg=;
        b=QWEgApWxUK2WeTQyusJWQabEBg6/MFRE3khkPSVyUlWnIxzpsc1JVImCExRusv6S1y
         gwnN471ry5pKYf3xjgoMrfabqnuh2N6oC/FK3vjdQaBpkS1VV2x54Y13ioFN+G6FOz0K
         tE0EzBrvBgJ6X1A2vvtzLs4ibpSpF0Srl4an6qkYubeKvCuDW0xDzY20UgXuyUsJX/B5
         aq88byl5U5i9EOTOm7VhPAVUCTZ/q3NvKy3x++lhJGDLMSNpuvWQSS2L5NVScBCUjZcg
         1Tcc44UkGPx9dsFdmfZhE8+cocQlY5fmuRuAN1sbsDp9yBKY0vJcz5u2z1WsQq0lB8cj
         VQKA==
X-Gm-Message-State: APjAAAXGpPmZs7/YqP3m3JVmzLSmNHjpWhzfGNbIZe0qAKFvltqhKPwx
        mWvh0VfwIUVL/1rFTEcxZls=
X-Google-Smtp-Source: APXvYqx5HuY6XH10k9uSIDFxPfs1mJ/eQL6O6gqj+XWnS2NE8q4z/9iMJihkLWD6VpXRXdReDdou8Q==
X-Received: by 2002:a37:79c7:: with SMTP id u190mr36357305qkc.26.1566479450443;
        Thu, 22 Aug 2019 06:10:50 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:7dcd:416c:c779:cf77? ([2001:4898:a800:1010:2f03:416c:c779:cf77])
        by smtp.gmail.com with ESMTPSA id v4sm636511qtj.77.2019.08.22.06.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2019 06:10:49 -0700 (PDT)
Subject: Re: [PATCH 0/9] [RFC] New sparse-checkout builtin and "cone" mode
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.316.git.gitgitgadget@gmail.com>
 <CABPp-BFcH5hQqujjmc88L3qGx3QAYZ_chH6PXQXyp13ipfV6hQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <08bd295b-ec5a-3128-42cf-acb24971d679@gmail.com>
Date:   Thu, 22 Aug 2019 09:10:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFcH5hQqujjmc88L3qGx3QAYZ_chH6PXQXyp13ipfV6hQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/21/2019 5:52 PM, Elijah Newren wrote:
> On Tue, Aug 20, 2019 at 8:12 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> This RFC includes a potential direction to make the sparse-checkout more
>> user-friendly. While there, I also present a way to use a limited set of
>> patterns to gain a significant performance boost in very large repositories.
>>
>> Sparse-checkout is only documented as a subsection of the read-tree docs
>> [1], which makes the feature hard to discover. Users have trouble navigating
>> the feature, especially at clone time [2], and have even resorted to
>> creating their own helper tools [3].
> 
> Ooh, intriguing.  Count me as another person who has resorted to
> making my own helper tool for others to use (specific to our internal
> repository, though, as it also figures out inter-module dependencies
> to allow specifying only a few modules of interest while still
> checking out everything needed to build those; but it'd be nice to
> need less scripting to handle the git-related bits to actually
> sparsify or densify).
> 
>> This RFC attempts to solve these problems using a new builtin. Here is a
>> sample workflow to give a feeling for how it can work:
>>
>> In an existing repo:
>>
>> $ git sparse-checkout init
>> $ ls
>> myFile1.txt myFile2.txt
>>
>> $ git sparse-checkout add
>> /myFolder/*
>> ^D
>> $ ls
>> myFile1.txt myFile2.txt myFolder
>> $ ls myFolder
>> a.c a.h
>> $ git sparse-checkout disable
>> $ ls
>> hiddenFolder myFile1.txt myFile2.txt myFolder
>>
>> At clone time:
>>
>> $ git clone --sparse origin repo
>> $ cd repo
>> $ ls
>> myFile1.txt myFile2.txt
>> $ git sparse-checkout add
>> /myFolder/*
>> ^D
>> $ ls
>> myFile1.txt myFile2.txt myFolder
>>
>> Here are some more specific details:
>>
>>  * git sparse-checkout init enables core.sparseCheckout and populates the
>>    sparse-checkout file with patterns that match only the files at root.
> 
> Does it enable core.sparseCheckout in the current worktree, or for all
> worktrees?  Do we require extensions.worktreeConfig to be set to true
> first?  If we don't require extensions.worktreeConfig to be set to
> true, and users add worktrees later, do they encounter negative
> surprises (immediately or later)?

This is an interesting scenario that I had not considered. Thanks!

My guess is that we should set `extensions.worktreeConfig=true` to
avoid surprises. I'll need to play with this to discover the answers
to these questions:

1. Where does the worktree look for the sparse-checkout file? Does
   each worktree have its own sparse-checkout file? Should it?

2. If I have `extensions.worktreeConfig=true` and `core.sparseCheckout=true`
   in the current worktree and run `git worktree add`, does the new worktree
   have `core.sparseCheckout=true`? Can we `git clone --sparse` and then
   start building sparse worktrees seamlessly?
 
> worktrees in combination with sparseCheckouts were a headache here
> until I just forced people to manually first set
> extensions.worktreeConfig to true before using my 'sparsify' script,
> regardless of whether the user was currently using worktrees.  That
> fixed the issues, but having to provide a long error message and
> explanation of why I wanted users to set some special config first was
> slightly annoying.
> 
> I wonder if 'git worktree' and maybe even 'git config' should
> themselves have special handling for core.sparseCheckouts, because it
> can be a real mess otherwise.
> 
>>  * git clone learns the --sparse argument to run git sparse-checkout init
>>    before the first checkout.
> 
> Nice.
> 
>>  * git sparse-checkout add reads patterns from stdin, one per line, then
>>    adds them to the sparse-checkout file and refreshes the working
>>    directory.
> 
> The default of reading from stdin seems a bit unusual to me, and I
> worry about having to explain that to users.  I'd rather the add
> command took positional parameters (anything that doesn't start with a
> hyphen) and added those, e.g.
>   $ git sparse-checkout add '/myFolder/*' '
> with the option of the user specifying --stdin.

I had the same thought, and likely that's where we should go with the
builtin. For our needs, the input over stdin is more important for
testing, so I built it first. I will adjust the CLI here to take a set
of paths over the arguments unless --stdin is given.

>>  * git sparse-checkout disable removes the patterns from the sparse-checkout
>>    file, disables core.sparseCheckout, and refills the working directory.
> 
> Does it leave an empty sparse-checkout file around?  Also, what if
> users have several paths defining their sparse pattern, and want to
> temporarily get a full checkout and then come back -- do they need to
> re-specify all the paths?  (Maybe this *is* the route we want to go;
> I'm just trying to mention any possible negative effects we _might_
> run into so we can consider them.  It's not quite as relevant in my
> case since people specify a few toplevel modules and sparse-checkout
> gets several entries auto-generated for them.)

In this case, there is an intermediate step (that follows the existing
advice) to modify the sparse-checkout file to contain only "/*\n" then
run read-tree to fill the working directory before disabling the config
setting.

Perhaps "disable" is the wrong word to use, as it makes you think that
there should be an "enable" that can quickly toggle between the two
modes. Maybe instead it should be "git sparse-checkout reset [empty|full]"
where you could 'reset' the sparse-checkout to one of two initial
states:

1. empty: only files at root are included.
2. full: all files are included.

In each case, we would obliterate the existing sparse-checkout entries,
but hopefully that behavior is more clear from the command names.

> Also, I'm particularly worried that a user with multiple worktrees,
> both sparse, could run 'git sparse-checkout disable' in one and then
> find that when they return to the other worktree they get a variety of
> nasty surprises (e.g. accidental staging or committing of the deletion
> of a huge number of files, random weird errors, or gradual and weird
> de-sparsifying as various git commands are run).  This, of course, can
> be averted by making sure core.sparseCheckout is set on a per-worktree
> basis, but that seems to be something people only do after running
> into problems several times unless some kind of tooling enforces it.
> 
>>  * git sparse-checkout list lists the contents of the sparse-checkout file.
>>
>>
>>
>> The documentation for the sparse-checkout feature can now live primarily
>> with the git-sparse-checkout documentation.
> 
> Yaay!
> 
>> Cone Mode
>> =========
>>
>> What really got me interested in this area is a performance problem. If we
>> have N patterns in the sparse-checkout file and M entries in the index, then
>> we can perform up to O(N * M) pattern checks in clear_ce_flags(). This
>> quadratic growth is not sustainable in a repo with 1,000+ patterns and
>> 1,000,000+ index entries.
> 
> This has worried me for a while, even if it hasn't yet caused us
> issues in practice.
> 
>> To solve this problem, I propose a new, more restrictive mode to
>> sparse-checkout: "cone mode". In this mode, all patterns are based on prefix
>> matches at a directory level. This can then use hashsets for fast
>> performance -- O(M) instead of O(N*M). My hashset implementation is based on
>> the virtual filesystem hook in the VFS for Git custom code [4].
> 
> Sweet!
> 
>> In cone mode, a user specifies a list of folders which the user wants every
>> file inside. In addition, the cone adds all blobs that are siblings of the
>> folders in the directory path to that folder. This makes the directories
>> look "hydrated" as a user drills down to those recursively-closed folders.
>> These directories are called "parent" folders, as a file matches them only
>> if the file's immediate parent is that directory.
>>
>> When building a prototype of this feature, I used a separate file to contain
>> the list of recursively-closed folders and built the hashsets dynamically
>> based on that file. In this implementation, I tried to maximize the amount
>> of backwards-compatibility by storing all data in the sparse-checkout file
>> using patterns recognized by earlier Git versions.
>>
>> For example, if we add A/B/C as a recursive folder, then we add the
>> following patterns to the sparse-checkout file:
>>
>> /*
>> !/*/*
>> /A/*
>> !/A/*/*
>> /A/B/*
>> !/A/B/*/*
>> /A/B/C/*
>>
>> The alternating positive/negative patterns say "include everything in this
>> folder, but exclude everything another level deeper". The final pattern has
>> no matching negation, so is a recursively closed pattern.
> 
> Oh, um, would there be any option for fast but without grabbing
> sibling and parent files of requested directories?  And could users
> still request individual files (not with regex or pathspec, but fully
> specifying the path) and still get the fast mode?

Exact files could probably be included and still be fast. It requires an
extra hash check per entry, but that's a small price to pay I think.

With the sibling files, this is something I believe to be user-friendly:
as a user drills down into the folder they included recursively, there may
be helpful files along the way, like documentation, project files, etc.

Here is my philosophical position here: a repo can take advantage of the
sparse-checkout feature if it is properly componetized. Those component
boundaries are likely at folder boundaries. Any file that exists in a parent
folder for two components is likely important to _both_ components. If
a file is large and is not needed by both components, it should be placed
deeper in the tree, so it can be avoided.

With that philosophy in mind, I designed this to help users fall into the
"pit of success" when their repo is in a good shape AND to motivate users
with repos in non-optimal shapes to reorganize.

The thought I had about exact file names is similar: if there is a large
list of files in a folder where I only need a subset, then how do I know
if a new file is added that I need? It will not show up in the directory
without updating the sparse-checkout. A user would discover this need by
something going wrong when they are not interacting with version control:
a build.

This is particularly important with the root directory. We need things
like .gitignore, .gitattributes, README, LICENSE, etc. to be populated
by default. If there are too many files at root to reasonably work with
the repo, then the repo should be reorganized using folders.

> Basically, our sparse usage is exclusively specifying leading
> directories or full pathnames of individual files, but we really want
> the repo to feel smaller and make sure people notice at a glance.  We
> have a huge 'modules/' directory, and want people to be able to get
> just 15 of the 500 or so subdirectories that would appear in that
> directory with a non-sparse checkout.  And similarly we want to be
> able to grab just one or two files from a directory of many files.

Your modules/ example seems to work with the feature as designed, as
you want a set of folders one level deeper. Grabbing one or two files
from a directory is a direction we can go with the feature, but I will
continue to believe that should be a rare occurrence compared to including
a folder recursively.

>> Note that I have some basic warnings to try and check that the
>> sparse-checkout file doesn't match what would be written by a cone-mode add.
>> In such a case, Git writes a warning to stderr and continues with the old
>> pattern matching algorithm. These checks are currently very barebones, and
>> would need to be updated with more robust checks for things like regex
>> characters in the middle of the pattern. As review moves forward (and if we
>> don't change the data storage) then we could spend more time on this.
> 
> Instead of trying to validate the sparse-checkout file everytime,
> perhaps we want to change core.sparseCheckout from a boolean to a
> tri-state or something where it specifies how to parse the
> sparse-checkout file?  Or maybe when special directive (some form of
> comment-looking line) appears at the top of sparse-checkout then we
> use the hashsets speedup while disallowing general regexes and
> pathspecs other than leading directories and full pathnames?

In this series, I turn `core.sparseCheckout` into a tri-state, and only
try to validate the sparse-checkout when `core.sparseCheckout=cone`.
This avoids spending time on the validation when someone is content using
the existing feature.

The _intent_ of using the sparse-checkout file and no extra data structure
was to let other clients (or an older client) read the sparse-checkout data
and result in the same working directory. One thing I realized after
submitting is that the tri-state config variable will cause old clients
to error on parsing the non-boolean value. Instead, in v2 I will introduce
a new boolean config variable "core.sparseCheckoutCone" that will do the
same thing as the current series when `core.sparseCheckout=cone` and will
fix this compat scenario.

> I'll try to get some time to look over these patches in the next few days.

I look forward to your feedback! I also have some feedback to respond to
from my team [1], but I'm waiting to make sure the community likes the
overall idea before jumping into code style and method organization
details.

Thanks,
-Stolee

[1] https://github.com/microsoft/git/pull/180

