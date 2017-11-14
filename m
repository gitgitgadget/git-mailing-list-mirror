Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B1171F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 20:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754951AbdKNUOI (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 15:14:08 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:47162 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752151AbdKNUOH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 15:14:07 -0500
Received: by mail-qt0-f171.google.com with SMTP id y5so12460842qtk.4
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 12:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=I/YOtqzJD6vEq/UU8KbjmvOQNvXv1/4GEbF63SILBX0=;
        b=LeBr1hQPFYcGJDPyrluYPT5pJJMRN6kWihqykTwRFdwj6alr280/lg8imwjzkQOWC3
         v5EDODeywjeqPK6aNLYwh3tvfTgAeFyZ6Kq45dHX2zjUVwvbVWo4fr3lYjnJqozCNqNx
         kvedtUxh0RroGcwGLUoDX9wiMbH4wij0G1QKQy7y60x7J0VOFcJbMgncbSpJQYLZ5dMk
         aZoj69wc7KAt92Xk+qE+jCae04fc8alPHzJ7m5VA3A4hEYKbi1l5cT+c0dqw9mlgv3Xn
         uJxQiyty1S8ImkgeJEXHETCrDd9TXwF5d+sR4YqB/BKVTHOaXEGQYEk0KkHadKWKR+yo
         C7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=I/YOtqzJD6vEq/UU8KbjmvOQNvXv1/4GEbF63SILBX0=;
        b=i+2f/Toc8m2tuvkZUZrpCHyH65k3DyOgLkmGVn/+BPoofeh13gcAjPyUoRgsyDRvDO
         ZRCFoiuXCg7nIAyKlfNNcSH2+7GetsSB0OW95cNGF5LV27QERMOox5PLUKa9GEj6fE+i
         CkU5GQKlYQsxsQOqt3HLcUUCpshK0h1QZFjauNgHb3EsgIe+i8Su7bYqtEYhl26Ucq6n
         MWPm9UTyrXqgOM/KtFlVdS2gJvbS/NndXSiPkooZ6rndoTz3b3dUZ4A7lX3Vj/DVW97E
         i2m0ZBs17P57AHucEeTHCSb/6LfEjQ6Nsh5LJdY70Ez4PfTlzVK4rICEvnLC/WN70u3l
         WZLw==
X-Gm-Message-State: AJaThX7lhcQe0k+1eCs30D0IA3aWpZMBV/84faF5ASRtJU4cQi825D8X
        Wde1ixeEidi10EY7swJvhdFphfRYJaIlyXFUZ2s=
X-Google-Smtp-Source: AGs4zMbHBDqQ6FA/4KSqwvjAXI1wTfAExcydCnEUsA1EixBe/rcEC+2fZ2t6LWWDBZ9+9VjL2lrVtI1Ked1+xFJq12Q=
X-Received: by 10.237.35.37 with SMTP id h34mr3374172qtc.9.1510690446199; Tue,
 14 Nov 2017 12:14:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Tue, 14 Nov 2017 12:14:05 -0800 (PST)
In-Reply-To: <20171114084517.GA12097@hank>
References: <20171112134305.3949-1-t.gummerer@gmail.com> <20171112134305.3949-2-t.gummerer@gmail.com>
 <xmqq1sl2c21g.fsf@gitster.mtv.corp.google.com> <20171114084517.GA12097@hank>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 14 Nov 2017 15:14:05 -0500
X-Google-Sender-Auth: bu5ThvKN5yxMaGBk6MMnQ3UnrFI
Message-ID: <CAPig+cTYC01Y9-EvyNo9hxQRbT60iqp8MqXEB_zWBi14kPV1Ng@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] worktree: make add dwim
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 14, 2017 at 3:45 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> On 11/13, Junio C Hamano wrote:
>> If so, as long as the new DWIM kicks in ONLY when "topic" does not
>> exist, I suspect that there is no backward compatibility worries.
>> The command line
>>
>>     $ git worktree add ../a-new-worktree topic
>>
>> would just have failed because three was no 'topic' branch yet, no?
>
> Indeed, with this there would not be any backwards compatility
> worries.
>
> Ideally I'd still like to make
>
>     $ git worktree add ../topic
>
> work as described above, to avoid having to type 'topic' twice (the
> directory name matches the branch name for the vast majority of my
> worktrees) but that should then come behind a flag/config option?
> Following your reasoning above it should probably be called something
> other than --guess.
>
> Maybe --guess-remote and worktree.guessRemote would do?  I'm quite bad
> at naming though, so other suggestions are very welcome.

For my own edification...

git worktree add ../dir branch

* Checks out branch into ../dir if branch exists.

* Errors out if branch does not exist. However, if we consider the
history of the implementation of worktrees[*1*], then this really
ought to try the "origin/branch -> branch" DWIM before erroring-out.
Implementing this DWIM could be considered a regression fix according
to [*1*] and, as Junio points out, should not pose backward
compatibility worries.

git worktree add ../topic

* Correctly errors out, refusing to create a new branch named "topic",
if "topic" is already a branch.

* Creates a new branch named "topic" if no such local branch exists.

The desired new DWIMing would change the second bullet point to:

* If no local branch named "topic" exists, DWIM it from "origin/topic"
if possible, else create a new local branch named "topic".

But that's a behavior change since, with the existing implementation,
a newly created local "topic" has no relation to, and does not track,
any origin/topic branch. The proposed --guess option is to avoid users
being hit by this backward incompatibility, however, one could also
view the proposed DWIMing as some sort of bug fix since, at least
some, users would expect the DWIMing since it already takes place
elsewhere.

So, at least two options exist:

* Just make the new DWIMing the default behavior, accepting that it
might bite a few people. Fallout can be mitigated somewhat by
prominently announcing that the DWIMing took place, in which case the
user can take corrective action (say, by choosing a different worktree
name); nothing is lost and no damage done since this is happening only
at worktree creation time.

* Add a new option to enable DWIMing; perhaps name it -t/--track,
which is familiar terminology and still gives you a relatively short
and sweet "git worktree add -t ../topic".

Given the mentioned mitigation factor and that some/many users likely
would expect it to DWIM "origin/topic -> topic" anyhow, I'd lean in
favor of the first option (but perhaps I'm too daring with other
people's workflows).

FOOTNOTES

[*1*]: When Duy first implemented worktree support, he incorporated it
directly into the git-checkout command ("git checkout --to worktree
..."), which means that he got all the git-checkout features for free,
including the "origin/branch -> branch" DWIM. When worktree support
was later moved to git-worktree, it lost most of the features
inherited implicitly from git-checkout, such as -b, -B, --detach, so
those were added back to git-worktree explicitly. However, at that
early stage, git-worktree was still piggy-backing atop git-checkout,
thus likely was still getting the "origin/branch -> branch" DWIM for
free. A final iteration converted git-worktree away from heavyweight
git-checkout to lightweight git-reset, at which point he DWIMing was
lost. If you take this history into account, then loss of
"origin/branch -> branch" DWIMing is a regression, so restoring it
could be considered a bug fix.
