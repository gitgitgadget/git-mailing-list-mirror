Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F0FB2027C
	for <e@80x24.org>; Tue, 30 May 2017 20:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750979AbdE3UdR (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 16:33:17 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35053 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbdE3UdP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 16:33:15 -0400
Received: by mail-qk0-f173.google.com with SMTP id 19so13004325qke.2
        for <git@vger.kernel.org>; Tue, 30 May 2017 13:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=w5witrknjOOZhCrgJ7yUTyT7dSteajptW2VahPdbaEE=;
        b=B37miSd5lsWsob8tuVQqIT34ySKtz2OiT4G92X2vb4hVeNXHBmXHYKRRAWkIw2p06O
         bp5+N6IrHzG+N/p773kxjbPpthw/KoZeBe7FWoGP5H/MQDyn+AH3LN0jxxXq5f7Amd6x
         489XjnmanIN59i8tPeInIiGJtPD4Ba9Jfq2ygx55NEmfkPuMf4zXzsiSmOp/KeL2hpOh
         737C+gqbFySZHmrlnbcNnkXLAXYBgnu9eZW3yJ8CZa4S+GTxmbyogkpnAc0qW27WYSlj
         wmsJoVh99OxTW01JZ4bZtBxRIGA3rZDQEm9cuuR1RVUBbzX+/CfrRyfJSxk5nk2n2xJw
         cUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=w5witrknjOOZhCrgJ7yUTyT7dSteajptW2VahPdbaEE=;
        b=cksYhoCKKcLaOLWhbZUyyKjTdHGewG0GnMN5sJmm0xr5pDw9ji2mgPivd7b6oeQHI4
         wqQbwWZRYT7TQ3MTjJOocRFLJiEOECHGykHvXfOk6YR0iUZshiMSOearcVW053L73BBG
         TNvWkmVuhfJgJBOvjiPDgLjZvX97wQ7bHDgFt8nYMcqWHT4/4OqG1bFcgR3R9MQbDKof
         wVhT9O3tEVlyS2J7ewfl5vXGiLMwsjFjjs+FOVo5QiKIbqxQ+JCZ5XBqn/mGABpeKvUZ
         CBwLDK1FYb8ihrrL8IMLq4pgFdx2K44XG+Z/HODoE1zSfS5lO0JbO1MPx6dAIOO4q2fH
         zhlA==
X-Gm-Message-State: AODbwcBTjt1buLWF2KCQD93BdfEtLsB7A1JdwKKi2yUZbgUiiT/YOoB+
        mYZOQIuaUtjcdKqAIuPnAQB+IdCEaQ==
X-Received: by 10.55.5.135 with SMTP id 129mr16877536qkf.181.1496176394937;
 Tue, 30 May 2017 13:33:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.78.212 with HTTP; Tue, 30 May 2017 13:33:14 -0700 (PDT)
In-Reply-To: <8ac721a5-a90d-3d58-e9dd-a3eb2199d387@gmail.com>
References: <20170518201333.13088-1-benpeart@microsoft.com>
 <CAP8UFD20gvTZqCOcpd1iozNDHOZR1sUKRwi062wL52FNHWNC3w@mail.gmail.com>
 <ab37d437-2a4e-b6ed-621f-5978083cd15b@gmail.com> <CAP8UFD1L+caWyLS5KCX3QqToVuzii+0tX81=eGA=1_+L6O7ynA@mail.gmail.com>
 <8ac721a5-a90d-3d58-e9dd-a3eb2199d387@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 30 May 2017 22:33:14 +0200
Message-ID: <CAP8UFD0xrGrB+QFSV9XYq23w8-eN6JKWSJm3iTc4Sn9Kf44NUw@mail.gmail.com>
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

On Tue, May 30, 2017 at 8:05 PM, Ben Peart <peartben@gmail.com> wrote:
>
>
> On 5/27/2017 2:57 AM, Christian Couder wrote:
>>
>> On Thu, May 25, 2017 at 3:55 PM, Ben Peart <peartben@gmail.com> wrote:
>>>
>>>
>>>
>>> On 5/24/2017 6:54 AM, Christian Couder wrote:
>>>>>
>>>>>
>>>>> Design
>>>>> ~~~~~~
>>>>>
>>>>> A new git hook (query-fsmonitor) must exist and be enabled
>>>>> (core.fsmonitor=true) that takes a time_t formatted as a string and
>>>>> outputs to stdout all files that have been modified since the requested
>>>>> time.
>>>>
>>>>
>>>>
>>>> Is there a reason why there is a new hook, instead of a
>>>> "core.fsmonitorquery" config option to which you could pass whatever
>>>> command line with options?
>>>
>>>
>>>
>>> A hook is a simple and well defined way to integrate git with another
>>> process.  If there is some fixed set of arguments that need to be passed
>>> to
>>> a file system monitor (beyond the timestamp stored in the index
>>> extension),
>>> they can be encoded in the integration script like I've done in the
>>> Watchman
>>> integration sample hook.
>>
>>
>> Yeah, they could be encoded in the integration script, but it could be
>> better if it was possible to just configure a generic command line.
>>
>> For example if the directory that should be watched for filesystem
>> changes could be passed as well as the time since the last changes,
>> perhaps only a generic command line would be need.
>
>
> Maybe I'm not understanding what you have in mind but I haven't found this
> to be the case in the two integrations I've done with file system watchers
> (one internal and Watchman).  They require you download, install, and
> configure them by telling them about the folders you want monitored.  Then
> you can start querying them for changes and processing the output to match
> what git expects.  While the download and install steps vary, having that
> query + process and return results wrapped up in an integration hook has
> worked well.

It looks like one can also just ask watchman to monitor a directory with:

watchman watch /path/to/dir

or:

echo '["watch", "/path/to/dir"]' | watchman -j

Also for example on Linux people might want to use command line tools like:

https://linux.die.net/man/1/inotifywait

and you can pass the directories you want to be watched as arguments
to this kind of tools.

So it would be nice, if we didn't require the user to configure
anything and we could just configure the watching of what we need in
the hook (or a command configured using a config option). If the hook
(or configured command) could be passed the directory by git, it could
also be generic.

>> I am also wondering about sparse checkout, as we might want to pass
>> all the directories we are interested in.
>> How is it supposed to work with sparse checkout?
>
> The fsmonitor code works well with or without a sparse-checkout.  The file
> system monitor is unaware of the sparse checkout so will notify git about
> any change irrespective of whether git will eventually ignore it because the
> skip worktree bit is set.

I was wondering if it could ease the job for the monitoring service
and perhaps improve performance to just ask to watch the directories
we are interested in when using sparse checkout.
On Linux it looks like a separate inotify watch is created for every
subdirectory and there is maximum amount of inotify watches per user.
This can be increased by writing in
/proc/sys/fs/inotify/max_user_watches, but it is not nice to have to
ask admins to increase this.
