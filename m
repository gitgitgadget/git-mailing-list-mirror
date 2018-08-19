Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 967801F954
	for <e@80x24.org>; Sun, 19 Aug 2018 01:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbeHSEZA (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 00:25:00 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37472 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbeHSEZA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 00:25:00 -0400
Received: by mail-pl0-f65.google.com with SMTP id c6-v6so544446pls.4
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 18:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JuRYC5iptKvP3sx/EwwpNB1+I2OLftfSau7GcNH9668=;
        b=sOoqKmKL6JlLkajzRr/tzQLyVqLYFjKC9+QFvM7db+nmd0avxqj8UG3/pY/3hA6lne
         3kq/2cH6rRpF8lUuziJRSofWSfMvsqLRCS2NH+ivpRHukMVbgn56Npm60JFzohQIwDU9
         PGOkcFcxUfnJX3xH09rXjpao/Ai8Q88OHJ1mslnUXyqFgeqT8fuHULSXo8NPA64Tz2cZ
         vwbCQTY0KR/ofHGaMzEqAPefQMQRJ9aBzYE4aFSUkHgXbWSvj7qSXtYQPF/d0VS02nhF
         49DGL2JoRPkD++Na9r7eMlf9KgfL8AYrc6SQckvb2OC63nmAAeJ8Y8zWI/xHYFRnHRFo
         dhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JuRYC5iptKvP3sx/EwwpNB1+I2OLftfSau7GcNH9668=;
        b=ueVq4k4oE9v6Gpegr3W0fQLl//OQ4eeuWH7qJg2uC1aD6frCktL/jjaSC0IAlhQWww
         dtS4kff6CGwMqFnyASPvUim6im3W0tiL3CAoFqM84h1e1OorV4lh2/pfg/8z3CRIUZtA
         UD6BUVNnrOVKqyfd5tGKOtLZLqeMaOevQLv0JkOirOaOWpuulcFdgauaPX4WJ7PaGzCz
         HMCgkxVfLTKJw/5cL+6uzrxgbppr+gZWxKtg9hjZdRDrydqC2aWnM+XNvlsG7mTalWMe
         SudlzbHHFtHTKvOPgRacg3rSyydaBp3bkJSXsC6BR98FenAy8CwgsMObHMM8qZSqQxh6
         rVUQ==
X-Gm-Message-State: AOUpUlEGQWUumVUf+q+EbJyuFVBL2HqMolFg3YVj3Ad4Irn80Agyfmic
        w3mISS+oHJJDF2Drpz8wIyRswHdRwzQL0JYqTdY83ZEL
X-Google-Smtp-Source: AA+uWPze5+p++TpsmWyrJ4pHYmsp0MMCzN0kTS7nAFZpzkaIV+BgdJGSTm8pnixJYsaXq1EXYBF+au9dPOsCjPHgJ+g=
X-Received: by 2002:a17:902:b492:: with SMTP id y18-v6mr8171956plr.26.1534641321002;
 Sat, 18 Aug 2018 18:15:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de05:0:0:0:0 with HTTP; Sat, 18 Aug 2018 18:14:40
 -0700 (PDT)
In-Reply-To: <CACSZ0PzcvYNtZEHqWCrU-5+hT=YeJ4DHpJ0j83QYn1qVEs5fjg@mail.gmail.com>
References: <CACSZ0Pwzs2e7E5RUEPDcEUsa=inzCyBAptU7YaCUw+5=MutSsA@mail.gmail.com>
 <20180818225052.GE144170@aiede.svl.corp.google.com> <CACSZ0PzcvYNtZEHqWCrU-5+hT=YeJ4DHpJ0j83QYn1qVEs5fjg@mail.gmail.com>
From:   =?UTF-8?Q?Michael_Mur=C3=A9?= <batolettre@gmail.com>
Date:   Sun, 19 Aug 2018 03:14:40 +0200
Message-ID: <CACSZ0PyfOV4o8k+H-OSjVSYGHgy=v=4q2S-x7NABxQNY9976Ug@mail.gmail.com>
Subject: Re: git-bug: Distributed bug tracker embedded in git
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> There's been some recent work to make
> Git's merge code (also used for cherry-pick) less reliant on the index
> and worktree.

Yes please ! In the mean time, someone suggested another trick [0].

> Can you say more about the federation model it intends to support?

My goal is to have a workflow similar as what git does, to be
versatile and leave to the users the choice of the topology they want
to use. Obviously, it will be most of the time a single remote where
they collaborate.

As a bug tracker is a different workflow than regular code, there will
be some tooling to help. For instance, automatic push/pull will help
make it easier to use and more "out of the way".

In the data model, each commit in the linear chain link to an array of
new edit operations. That means that each commit is strictly
independent from the others. When you get updates for a bug and you
need to merge them, you will simply rebase your new commits on top of
the linear chain.

This design has several properties:

- the merge happen on the user repo where git-bug is installed and can
validate new data
- the remote used doesn't have to be aware of git-bug
- when pushing an update of a ref, the remote will make sure that it's
fast forward, that is, no previous edit operations has been removed.
It ensure that the history is append only.

So for now, collaboration is based on push/pull to whatever remote you
want, as git does, with the exception of the Web UI. The goal here is
to have it running locally for each user but also to make it a public
interface for users that don't have write access to the repo, much
like any bug tracker has.

In the future, it could be possible to have more fancy features like a
federated forge with ActivityPub, but that's way outside of the scope
of the project for now.

[0]: https://github.com/MichaelMure/git-bug/issues/15

2018-08-19 2:45 GMT+02:00 Michael Mur=C3=A9 <batolettre@gmail.com>:
> Here was my reasoning for the naming choice:
>
> - I need something meaningful
> - I need something that encompass the idea and features of a bug
> tracker because the narrower ideas and actions will be in sub commands
> - other projects already used other words, in particular "issue"
> - it kind of sounds and looks good
>
> You say that it's a namespace grab and I understand that, but in the
> other hand, there is not that much freedom when choosing a name. Sorry
> if I'm stepping on someone's toe :-|
>
> 2018-08-19 0:50 GMT+02:00 Jonathan Nieder <jrnieder@gmail.com>:
>> (cc-ing Elijah Newren for the points about merging)
>> Hi again,
>>
>> To avoid the other thread shadowing more important things:
>>
>> Michael Mur=C3=A9 wrote:
>>
>>> Someone suggested in the Hacker News thread [0] to post it here as well=
.
>>
>> Thanks to =C3=86var for that.
>>
>> [...]
>>> git-bug use as identifier the hash of the first commit in the chain
>>> of commit of the bug.
>>
>> Clever!  I like this approach to the naming problem.
>>
>> [...]
>>> Git doesn't provide a low-level command to rebase a branch onto
>>> another without touching the index.
>>
>> Thanks for pointing this out.  There's been some recent work to make
>> Git's merge code (also used for cherry-pick) less reliant on the index
>> and worktree.  See https://crbug.com/git/12 for some references.
>> There's also been some heavy refactoring of "git rebase" code to be in
>> C and be able to make use of library functions instead of being a
>> shell script.
>>
>> That's all to say that we're in a pretty good place to consider
>> introducing commands like
>>
>>   git cherry-pick --onto=3D<branch> <revisions>
>>
>> In absence of that kind of thing, you can run commands that need to
>> touch the index (but not the working tree) by setting the GIT_INDEX
>> environment variable to point to a temporary index file.
>>
>>> I'd love to have some feedback from you. Contribution are also very
>>> much welcomed.
>>
>> Can you say more about the federation model it intends to support?
>> For example, do you imagine
>>
>> - having multiple copies of a git bugs repo that automatically fetch
>>   updates from each other
>>
>> - having explicit "pull request" synchronization moments when the
>>   owners of one copy of a bug tracker push or request a fetch of
>>   changes that have been happening on another
>>
>> - individual contributors using an offline copy of the bug tracker
>>   and pushing push/pull mostly to synchronize with a single
>>   centralized copy
>>
>> - something else?
>>
>> Thanks,
>> Jonathan
>
>
>
> --
> Michael



--=20
Michael
