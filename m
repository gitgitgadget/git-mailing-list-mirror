Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3600B215F4
	for <e@80x24.org>; Tue,  1 May 2018 15:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754749AbeEAPwe (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 11:52:34 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34807 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbeEAPwd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 11:52:33 -0400
Received: by mail-vk0-f48.google.com with SMTP id t63-v6so7207733vkb.1
        for <git@vger.kernel.org>; Tue, 01 May 2018 08:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fbk2IxIwX/rihM5h8nkW6kUlDoxaiJhO5zO48llUdOE=;
        b=X/09IyS3aa0zZyeUyqik5asRRv6cDdOJ52XkTP5gq1FM8biFA4zSi6V/HpSVZRBGYN
         JHepzsTb9rgeXb3k68JasyLcdwmU3hSn7R+sKfXLyZO6F8kABj0c8teyb847l7nVWN1r
         eSry0xl3Ov7qvwFHovl0E+HcFXhdGUrp7Y0zFsKJ1OJw0E7fpnvjDGP58wdj1/RURSi2
         nbzJaVO4MXCXBSYNtLiupqjWoCibtd6sR4/WZ/B/yBum6QwXMapEw1PBvypvCWkyBCu/
         xMg7EfpovUJXQSfsSAEENoWI4MHgQAauV/YV0aWSYInl848aBr4Yxbq5NFXNbOoSj5Ay
         80jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fbk2IxIwX/rihM5h8nkW6kUlDoxaiJhO5zO48llUdOE=;
        b=MAXO6G1gRFiTDpeyM8ue6uAk73gonE+SzXCUFT0Ikpn83afiEqsOCIBNhxIDU4wnte
         YVOG7qy03Z/GyOPZ1aGjJmE4a64Oyx2rs+egkgn+xE+7xAKwDqgKibAhX3O/soLQ8EsG
         emY5OsbfejQQbYNxqytPybd96QZzp6Icf6HlYbikZwGr4OwtZ7Vay9xnO8E0kffI5er3
         qYNeoZQ6PGNT2SPFc74s8mKMGM2Bdu8CNbBxf8EWHYTEJqPw2GMB9ymRvHg5Rzd8KXqN
         +jYRUbJzn5pfrrJaFvMRtGZ+8p/zVH2NwUKRzPHEM5tCIEU/RmIJpmUKMR6jpxxxAv23
         PfcA==
X-Gm-Message-State: ALQs6tCLxNt/utAEEbSwpzkPiWAmENmVqXMD4PUv+sDCGUt2zgGjNTAX
        DgrxNy9N3VApzgcWp8lSdxtAM6hjrAHzOQphrF0=
X-Google-Smtp-Source: AB8JxZpe2WDvVcrdjWGnVRqgehjJDWSxIoigWiL6GyBQ53FxkhJcWjKh0dPnMLC9rJWyeIBGcsmqaCR0NAv69X41tV8=
X-Received: by 2002:a1f:370a:: with SMTP id e10-v6mr13763727vka.106.1525189951554;
 Tue, 01 May 2018 08:52:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Tue, 1 May 2018 08:52:30 -0700 (PDT)
In-Reply-To: <1652522802.213664.1525177431907.JavaMail.zimbra@matthieu-moy.fr>
References: <c466854f-6087-e7f1-264a-1d2df9fd9b5a@gmail.com>
 <50c60ddfeb9a44a99f556be2c2ca9a34@BPMBX2013-01.univ-lyon1.fr>
 <907020160.11403426.1525172946040.JavaMail.zimbra@inria.fr>
 <20180501114316.GB13919@esm> <1652522802.213664.1525177431907.JavaMail.zimbra@matthieu-moy.fr>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 1 May 2018 08:52:30 -0700
Message-ID: <CABPp-BFbVP3iwAbaa2cEPw9Sr+ANJoHHYHOCQ4oAZoVdyX164A@mail.gmail.com>
Subject: Re: [PATCH v2] wt-status: use rename settings from init_diff_ui_defaults
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <peartben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 1, 2018 at 5:23 AM, Matthieu Moy <git@matthieu-moy.fr> wrote:
> "Eckhard Maa=C3=9F" <eckhard.s.maass@googlemail.com>:
>
>> On Tue, May 01, 2018 at 01:09:06PM +0200, Matthieu Moy wrote:
>> > That init_diff_ui_defaults() should indeed have been before
>> > git_config() from the beginning. My bad, I'm the one who
>> > misplaced it apparently :-(.
>
>> Should I have done this "bug fix" in a separate commit or mention it in
>> the commit message?
>
> I'm fine with it as-is. Before your "fix", the config was ignored
> because overwritten by init_diff_ui_defaults() after reading the
> config, so effect of your change is indeed what the commit message
> describes.
>
> I'm often thinking aloud while reviewing, don't take my comments as
> objections.
>
>> > This "break_opt =3D 0" deserves a mention in the commit message IMHO.
>> > I'm not 100% sure it's a good change actually.
>
>> Hm, what problems do you see here?
>
> I don't see any "problem", I *think* your change is good, but I can't
> fully convince myself that it is without further explanation.
>
> Unlike the other two, this option has no corresponding configuration
> variable, so the "let the config" argument doesn't apply. For "git
> status", there's actually not even a command-line option. So, this
> assignment removed, there's no way in the user-interface to re-enable
> the previous behavior. *If* there was a good reason to get "break_opt
> =3D 0", then your patch is breaking it.
>
> Unfortunately, the commit introducing it doesn't help much: f714fb8
> (Enable rewrite as well as rename detection in git-status,
> 2007-12-02) is just a one-liner message with a one-liner patch.
>
> But actually, I never used -B/--break-rewrites, and writting this
> message I tried to get a case where -B would make a difference and I'm
> not even able to find one. So, as someone who never understood the
> real point of -B, I'm not sure I'm qualified to juge on what's the
> best default ;-).

In git.git, just make non-sensical changes like the following (a
normal rename, and a break-rename, for comparison):

    git mv oidset.c another-file.c
    echo "// Modifying normally renamed file for fun" >>another-file.c
    git rm merge.c
    git mv object.c merge.c
    echo "// Random change to break-rename file" >>merge.c
    git add merge.c another-file.c

Now compare, git before Eckhard's change:

$ /usr/bin/git status
HEAD detached at v2.17.0
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

    renamed:    oidset.c -> another-file.c
    renamed:    object.c -> merge.c

and git after Eckhard's change:

$ git status
HEAD detached at v2.17.0
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

    renamed:    oidset.c -> another-file.c
    modified:   merge.c
    deleted:    object.c

Which is better?  Well, gut reaction only looking at the above output
folks would probably say the former is. However, compare the output to
this:

$ git diff --name-status HEAD
R094    oidset.c        another-file.c
M       merge.c
D       object.c

git status and git diff are inconsistent for no good reason.  We can
instruct diff to behave the same as old status, of course:

$ git diff --name-status -B HEAD
R094    oidset.c        another-file.c
R099    object.c        merge.c

...but why does the user have to instruct diff to get the same default
behavior they get from status?  I'll note here that log and show have
the same default as diff.


I'm not certain what the default should be, but I do believe that it
should be consistent between these commands.  I lean towards
considering break detection being on by default a good thing, but
there are some interesting issues to address:
  - there is no knob to adjust break detection for status, only for
diff/log/show/etc.
  - folks have a knob to turn break detection on (for diff/log/show),
but not one to turn it off
  - for status, break detection makes no sense if rename detection is off.
  - for diff/log/show, break detection provides almost no value if
rename detection is off (only a dissimilarity index), suggesting that
if user turns rename detection off and doesn't explicitly ask for
break detection, then it's a waste of time to have it be on
  - merge-recursive would break horribly right now if someone turned
break detection on for it.  Turning it on might be a good long term
goal, but it's not an easy change.


So, where does that leave us?  My opinion is
  - these commands should be consistent.  Eckhard's patch makes them so.
  - we might want to move towards break detection being on as the
default.  That's a couple patch series (one for everything but
merge-recursive, and a separate much bigger series for
merge-recursive).

But I can see others saying we should leave things inconsistent until
we can fix the other commands to use break detection as the default.
So...thoughts?

Elijah
