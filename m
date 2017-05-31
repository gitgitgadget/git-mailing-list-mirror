Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9D5E20D0A
	for <e@80x24.org>; Wed, 31 May 2017 07:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750994AbdEaHhT (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 03:37:19 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33242 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbdEaHhS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 03:37:18 -0400
Received: by mail-qk0-f178.google.com with SMTP id y201so5494314qka.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 00:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vsF5koBz3hpFI7pmSkNwhWHO1OA4nJkVSHuP+c5TAvQ=;
        b=ArhN2U+kG+69efcbaj5uEnnI+oMc3/sRFwaDEALOMEFh29HZ0NSNdxjbOdc1nqMM4P
         4uCrc7dANclfb0MoX3kcp3ES+vkudbYlZKfr381OukY/ViJ5aj9MHpF4mROoEDizPVuI
         3muJ5I3ccDpEU1GyhWEdO0JCsDzDtxdamcldZOOF1WuY1cfL4W+lMogoCrmJgwwVvvLN
         eyRNri9wz6ime5kzpvjlSDpK6vxSaRrYlvpYbvu64kYC5n7xXriLnyAiGZBYFU4ztVqo
         W9xTztB15fVeuWhL4ePLScgjAEQk1ODHAK89WzKf+ImLWjNPtOGIEKsLu4f+TEp7imZG
         2uUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vsF5koBz3hpFI7pmSkNwhWHO1OA4nJkVSHuP+c5TAvQ=;
        b=ozELFRAxMO187A+jOcE3Lr+DMvC7j9bR6tQfvX3VRyNUi6eVsYYRVNqmB2WEgwN3pE
         lWjkjIYu9K8noIq4mo34FDSJ92pJ5DAR8GRld4eEylFH4SREFtPa4mz+QIetrsrQaMDC
         5kmm6vHQ/qoVrMY8IbODqRMLzZTRPP3rNAZbRJhhgsP0y6SCvOJcqxzEVw/8IeMXPiiK
         hQDWyrwrJpiqPtBfeTrUM7BTW3ESHfLq+nQmu9eBPkB9lCwoJZwCpSjupBufOx6SuFb5
         FhCZyPHoPbmCf9JhfFs9SeFSmSWeCMFZ4+VULEcGwweTU8cZsByxKBTb52oRqxSFqwUP
         J7Mg==
X-Gm-Message-State: AODbwcA/AWmvoNeaaHDVsOr6yTHK8HoEtBdRT3uBcYTFHBIkCZjPM/yb
        Brff8ruQKym1ruk3kUxQFsvVxOl+UQ==
X-Received: by 10.55.146.199 with SMTP id u190mr25408414qkd.109.1496216237646;
 Wed, 31 May 2017 00:37:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.78.212 with HTTP; Wed, 31 May 2017 00:37:17 -0700 (PDT)
In-Reply-To: <0d553422-5b4f-cfdd-961a-d007826b68cb@gmail.com>
References: <20170518201333.13088-1-benpeart@microsoft.com>
 <CAP8UFD20gvTZqCOcpd1iozNDHOZR1sUKRwi062wL52FNHWNC3w@mail.gmail.com>
 <ab37d437-2a4e-b6ed-621f-5978083cd15b@gmail.com> <CAP8UFD1L+caWyLS5KCX3QqToVuzii+0tX81=eGA=1_+L6O7ynA@mail.gmail.com>
 <8ac721a5-a90d-3d58-e9dd-a3eb2199d387@gmail.com> <CAP8UFD0xrGrB+QFSV9XYq23w8-eN6JKWSJm3iTc4Sn9Kf44NUw@mail.gmail.com>
 <0d553422-5b4f-cfdd-961a-d007826b68cb@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 31 May 2017 09:37:17 +0200
Message-ID: <CAP8UFD3aZU1D+bbqDEV05QG06gySt9PPL7XD4Xz0TP84zM8M6A@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Fast git status via a file system watcher
To:     Ben Peart <peartben@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>>> Yeah, they could be encoded in the integration script, but it could be
>>>> better if it was possible to just configure a generic command line.
>>>>
>>>> For example if the directory that should be watched for filesystem
>>>> changes could be passed as well as the time since the last changes,
>>>> perhaps only a generic command line would be need.
>>>
>>> Maybe I'm not understanding what you have in mind but I haven't found
>>> this
>>> to be the case in the two integrations I've done with file system
>>> watchers
>>> (one internal and Watchman).  They require you download, install, and
>>> configure them by telling them about the folders you want monitored.
>>> Then
>>> you can start querying them for changes and processing the output to
>>> match
>>> what git expects.  While the download and install steps vary, having that
>>> query + process and return results wrapped up in an integration hook has
>>> worked well.
>>
>> It looks like one can also just ask watchman to monitor a directory with:
>>
>> watchman watch /path/to/dir
>>
>> or:
>>
>> echo '["watch", "/path/to/dir"]' | watchman -j
>>
>> Also for example on Linux people might want to use command line tools
>> like:
>>
>> https://linux.die.net/man/1/inotifywait
>>
>> and you can pass the directories you want to be watched as arguments
>> to this kind of tools.
>>
>> So it would be nice, if we didn't require the user to configure
>> anything and we could just configure the watching of what we need in
>> the hook (or a command configured using a config option). If the hook
>> (or configured command) could be passed the directory by git, it could
>> also be generic.
>
> OK, I think I understand what you're attempting to accomplish now. Often,
> Watchman (and other similar tools) are used to do much more than speed up
> git (in fact, _all_ use cases today are not used for that since this patch
> series hasn't been accepted yet :)).  They trigger builds, run verification
> tools, test passes, or other tasks.

Yeah, but some people might only be interested in installing Watchman
or similar tools to speed up "git status".

> I'm afraid that attempting to have the user configure git to configure the
> tool "automatically" is just adding an extra layer of complexity rather than
> making it simpler.

I think that for the user it makes things simpler, as the user
wouldn't have to configure anything.

For example if the hook does something like the following :

# Check that watchman is already watching the worktree
if ! watchman watch-list | grep "\"$GIT_WORK_TREE\""
then
       # Ask watchman to watch the worktree
       watchman watch "$GIT_WORK_TREE"
       exit 1
fi

# Query Watchman for all the changes since the requested time
echo "[\"query\", \"$GIT_WORK_TREE\", {\"since\": $1,
\"fields\":[\"name\"]}]" | \
watchman -j | \
...

Then users might not need to configure Watchman in the first place,
and if they move their repo they might not need to reconfigure
Watchman.

> I'll leave that to a future patch series to work out.

Yeah, the above improvement can be done later.

>>>> I am also wondering about sparse checkout, as we might want to pass
>>>> all the directories we are interested in.
>>>> How is it supposed to work with sparse checkout?
>>>
>>>
>>> The fsmonitor code works well with or without a sparse-checkout.  The
>>> file
>>> system monitor is unaware of the sparse checkout so will notify git about
>>> any change irrespective of whether git will eventually ignore it because
>>> the
>>> skip worktree bit is set.
>>
>> I was wondering if it could ease the job for the monitoring service
>> and perhaps improve performance to just ask to watch the directories
>> we are interested in when using sparse checkout.
>> On Linux it looks like a separate inotify watch is created for every
>> subdirectory and there is maximum amount of inotify watches per user.
>> This can be increased by writing in
>> /proc/sys/fs/inotify/max_user_watches, but it is not nice to have to
>> ask admins to increase this.
>
> Having a single instance that watches the root of the working directory is
> the simplest model and minimizes use of system resources like inotify as
> there is only one needed per clone.

From https://linux.die.net/man/1/inotifywait:

-r, --recursive

Watch all subdirectories of any directories passed as arguments.
Watches will be set up recursively to an unlimited depth. Symbolic
links are not traversed. Newly created subdirectories will also be
watched.

Warning: If you use this option while watching the root directory of a
large tree, it may take quite a while until all inotify watches are
established, and events will not be received in this time. Also, since
one inotify watch will be established per subdirectory, it is possible
that the maximum amount of inotify watches per user will be reached.
The default maximum is 8192; it can be increased by writing to
/proc/sys/fs/inotify/max_user_watches.

> In addition, when the sparse-checkout file is modified, there is no need to
> try and automatically update the monitor by adding and removing folders as
> necessary.

Yeah, I agree it is simpler to not have to worry about the
sparse-checkout file being modified.

> Finally, if files or directories are excluded via sparse-checkout, they are
> removed from the working directory at checkout time so don't add any
> additional overhead to the file system watcher anyway as they clearly can't
> generate write events if they don't exist.

Yeah, but if you configure sparse-checkout when you already have
untracked files in many directories, like .o files, these files and
the directories they are in are not removed when you perform a
checkout, so the directories are still watched by the file system
watcher.
