Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27DAF1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 19:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757123AbeDBTfr (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 15:35:47 -0400
Received: from mail-yb0-f174.google.com ([209.85.213.174]:45264 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756742AbeDBTfq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 15:35:46 -0400
Received: by mail-yb0-f174.google.com with SMTP id k199-v6so5368587ybk.12
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 12:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VD5q6fzvG86xvars/j5M4zCg5a92/6ThFd5BjkkwuqQ=;
        b=jirturPJW9MSoYKk1NomnwyxX0g+Db2FugcMdlM2ldNRjT+AbjvBILoXajp8FMLxxP
         6Dl8qIdXaYcg+cWvZMNkYbkxYIl15iJjdSyd5ct5yUXkgySDUqioZDeegwefbUNleP00
         Cw4+cuwKCL+H4vHvpDEvhxkhEWHMnKf4vD/1NfRy+T0QLf7IKj0Y2w2QifE+iE3/KJIk
         AxaaCRW6Gv0OU4R5cURCflvp2knhFYI3K0/5O7cbXR1WBCGfapiAMMt7je87PXiiMymV
         YmEo73v5lmXgKMlBhx4LkDrWMsHWkoF682XEUMQuB2QkKg5sU/PvxnC1LttorZZQSyou
         1SEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VD5q6fzvG86xvars/j5M4zCg5a92/6ThFd5BjkkwuqQ=;
        b=ptXvdZvpSPQhpoDhQd4CBv0ytxbctt/v1RntG9Iyr444MdmPMJEhROrn+hLPQA6wkO
         n5qreSjDBDlw53chDPBkw1q/N5P+E8asXk1tQUfXUcIAe6G6g7bO9B2hmM32KFFkUBiX
         DTPF95utk4m5QKsWRdt5NJ6ehxon61MFaxkaT6o9XzHa6eO11Bxv8RzyjOXg1Od+txol
         kcPlmmemnt84q46uaku4THidAnMtv8drwpHRKONaYjneWQGInjeAvAnxNvoSrz/9cTr5
         1wMGKOzgo5wCxdEoCfHcJNAI4cyKQctiRtvXLp9e/1S6SCs2VHI+sKVzjLx4hzcRudwG
         w2tw==
X-Gm-Message-State: ALQs6tAVs7PXbz3ubq7CsHFj0ljEcryh02XAi7Wnm5JSBOWEowcwrd0C
        w0f9FTpvLsEsKZD4kmUflj3V00cnXKgYG28dgYgvqw==
X-Google-Smtp-Source: AIpwx4/DjhMTcgBIL+dNze9s+KG5TzH9DUMC44XDT2pqUonW6Mw9v/JRHeDmIkfODs5HOcuajfm9hpWYrdFA8uAqVsE=
X-Received: by 2002:a25:ba51:: with SMTP id z17-v6mr3705128ybj.334.1522697744940;
 Mon, 02 Apr 2018 12:35:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Mon, 2 Apr 2018 12:35:44 -0700 (PDT)
In-Reply-To: <CAHd499AraFfWY-L9+RFj2E=p58QK0njyS8dQHEOGHjeoTW=YQw@mail.gmail.com>
References: <20180307211140.19272-1-rcdailey@gmail.com> <CAGZ79kZk7N4zQUS1eMFMPTuPPuo5ViOeLj5hQHV=E+A=OO+D0w@mail.gmail.com>
 <xmqqina56t8h.fsf@gitster-ct.c.googlers.com> <CAGZ79kZ_j3_mhk5asNEBgBe_2qD7=18foJgW=p0+p=uJa3U2nw@mail.gmail.com>
 <CAHd499AraFfWY-L9+RFj2E=p58QK0njyS8dQHEOGHjeoTW=YQw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 2 Apr 2018 12:35:44 -0700
Message-ID: <CAGZ79kb6Ot_Lso+_K6VXcLsT=1hv0JaXXF8j3PpH+2FHQ-8QpA@mail.gmail.com>
Subject: Re: [PATCH] Support long format for log-based submodule diff
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 1, 2018 at 6:07 PM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> On Tue, Mar 27, 2018 at 5:17 PM, Stefan Beller <sbeller@google.com> wrote:
>>> >> $ git diff --submodule=log --submodule-log-detail=(long|short)
>>> >>
>>> >> I'm not sure what makes sense here. I welcome thoughts/discussion and
>>> >> will provide follow-up patches.
>>> >
>>> > The case of merges is usually configured with --[no-]merges, or
>>> > --min-parents=<n>.
>>
>>> But that is a knob that controls an irrelevant aspect of the detail
>>> in the context of this discussion, isn't it?  This code is about "to
>>> what degree the things that happened between two submodule commits
>>> in an adjacent pair of commits in the superproject are summarized?"
>>
>> And I took it a step further and wanted to give a general solution, which
>> allows giving any option that the diff machinery accepts to only apply
>> to the submodule diffing part of the current diff.
>>
>>> The hack Robert illustrates below is to change it to stop favouring
>>> such projects with "clean" histories, and show "log --oneline
>>> --no-merges --left-right".  When presented that way, clean histories
>>> of topic-branch based projects will suffer by losing conciseness,
>>> but clean histories of totally linear projects will still be shown
>>> the same way, and messy history that sometimes merges, sometimes
>>> merges mergy histories, and sometimes directly builds on the trunk
>>> will be shown as an enumeration of individual commits in a flat way
>>> by ignoring merges and not restricting the traversal to the first
>>> parent chains, which would appear more uniform than what the current
>>> code shows.
>>
>> Oh, I realize this is in the *summary* code path, I was thinking about the
>> show_submodule_inline_diff, which would benefit from more diff options.
>>
>>> I do not see a point in introducing --min/max-parents as a knob to
>>> control how the history is summarized.
>>
>> For a summary a flat list of commits may be fine, ignoring
>> (ideally non-evil) merges.
>>
>>> This is a strongly related tangent, but I wonder if we can and/or
>>> want to share more code with the codepath that prepares the log
>>> message for a merge.  It summarizes what happened on the side branch
>>> since it forked from the history it is joining back to (I think it
>>> is merge.c::shortlog() that computes this)
>>
>> I do not find code there. To me it looks like builtin/fmt-merge-msg.c
>> is responsible for coming up with a default merge message?
>> In that file there is a shortlog() function, which walks revisions
>> and puts together the subject lines of commits.
>>
>>> and it is quite similar
>>> to what Robert wants to use for submodules here.  On the other hand,
>>> in a project _without_ submodule, if you are pulling history made by
>>> your lieutenant whose history is full of linear merges of topic
>>> branches to the mainline, it may not be a bad idea to allow
>>> fmt-merge-msg to alternatively show something similar to the "diff
>>> --submodule=log" gives us, i.e. summarize the history of the side
>>> branch being merged by just listing the commits on the first-parent
>>> chain.  So I sense some opportunity for cross pollination here.
>>
>> The cross pollination that I sense is the desire in both cases to freely
>> specify the format as it may depend on the workflow.
>
> First I want to apologize for having taken so long to get back with
> each of you about this. I actually have a lot of work started to
> expand the --submodule option to add a "full-log" option in addition
> to the existing "log". This is a pretty big task for me already,
> mostly because I'm unfamiliar with git and have limited personal time
> to do this at home (this is part of what I am apologizing for).

No worries wrt. time.

> I kind
> of get what Stefan and Junio are saying. There's a lot of opportunity
> for cleanup. More specific to my use case, adding some functionality
> to generate a log message (although I've developed a bash script to do
> this since I wrote my original email. I'll attach it to this email for
> those interested).

The functionality looks very similar what Gerrit does in its
"superproject subscription mode", which would update the submodules in
the superproject automatically, when you submit on the submodule.
For example [1] is an update of the Gerrit project itself, that has some
submodules. This commit only updates the replication plugin, but
provides a summary what happened in that plugin.

[1] https://gerrit.googlesource.com/gerrit/+/db20af7123221b0b2f01d1f06e4eaac32a04cef6


I wonder if there is need for this in upstream git as well, e.g.
"git submodule update --remote" would also want to have a
switch "--commit-with-proposed-commit-message" or if the
standard commit message template would provide a submodule
summary for you. I realize that there is the config option
status.submoduleSummary already, but it is not as clear as either
your script or the Gerrit example.

> Also I get that taking this a notch higher and
> adding a new option to pass options down to submodules also addresses
> my case. Before I waste anyone's time on this, I want to make sure
> that my very narrow and specific implementation will be ideal. By all
> means I do not want to do things the easy way which ends up adding
> "cruft" you'll have to deal with later.

Sounds good. I am undecided whether to count this as cruft, as it brings in
real improvements for certain histories. And if you need this, it is not cruft
but a feature.

> If there's a larger effort to
> generalize this and other things related to submodules maybe I can
> just wait for that to happen instead? What direction would you guys
> recommend?

You could do that, though there are no timelines and you'd wait quite a
long time, potentially.

> Junio basically hit the nail on the head with the comparisons of
> different mainlines. I think some repositories are more disciplined
> than others. At my workplace, I deal with a lot of folks that aren't
> interested in learning git beyond the required day to day
> responsibilities. It's difficult to enforce very specific branching,
> rebase, and merge habits. As such, the best I can do to work around
> that for building release notes is to exclude merge commits (since
> most of the time, people keep the default message which is generally
> useless) and include all commits in the ancestry path (since often
> times commits on the right side of a merge will have important
> information such as JIRA issue keys, which if shown in the parent repo
> will cause appropriate links back to parent repositories to show when
> changes in submodules were introduced there as well).

It sounds it is fixing a real need, so don't call it cruft. ;)

> Based on how constructive this email thread has gotten since I started
> it, I'm starting to feel like my solution is too narrowly-focused and
> doesn't have the long term appeal expected. Let me know, I'm happy to
> do what I can but I think it will be limited due to my lack of domain
> expertise in the code base and inability to invest the required time
> for significant scope of work.

I guess we can have it as

  $ git diff --submodule=long-log

for now? Or instead "detailed-log" or "log-with-commits" ?

Thanks,
Stefan
