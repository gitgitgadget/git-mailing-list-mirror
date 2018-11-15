Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E77641F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 05:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeKOPSj (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 10:18:39 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35660 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeKOPSj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 10:18:39 -0500
Received: by mail-oi1-f195.google.com with SMTP id v6so3426919oif.2
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 21:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Qb3YSTnBzUjczYYMcQLBLUw5NnkdH/3CfN/IXi5AEUk=;
        b=Ih6Mvn+GsBid77HVU1J8iM3FleN3W5cZn+iolRKhiiIAqHyVQbK74JeF3a30TsmhYJ
         54iMygW73cEkrTIOHtNYQmod/Wmj/GyO7KrZN1Isll9RmZxSr9ByGC0TG3g0F/XjjheB
         CJNWDxjbt7q3lxMLDTdFUi64OrI6GkGDPJU3VQGSqp9CfvL3rkHEtVnDGpZ6Crdw9E3x
         v1QxkBSuTDdemrmSMZbv10hSapvTzBkhhqvwabRXHm0O2LHimXcOERGdpOj1slmGHiFX
         dF6ebdEBdHP1tJMIXQkiAmxuJSGQgoR8jUepb1lj9gQrsn81aUJ83yK1Lw4STEAXJeNQ
         64TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Qb3YSTnBzUjczYYMcQLBLUw5NnkdH/3CfN/IXi5AEUk=;
        b=rTlq/W4ih4BP1/CgtKjxix0lacWkaVIWNnjMuaDLCstBtite2XtSxyLYu6UK/a0Oy5
         +d1/F9DO76UIUzLm2TbiOgzferjmoDWMHHxGp0I07VK0lKxsXSPYY8tjACwJw1vSwg7/
         YxZMaKxTRHV611pgsGyY9C72gpI1QZngj1AVY85CjiUA0MJUAMA+n7lKXoMjXN+jUXUH
         j5NdG57DtFwRsmsU7Zr1o8FzjaFLZbx1ocfDcW1gy8tbAcu550kJiTJASV7UGNtTaEso
         COqHGHOIAshv1H9BRQ8o3wNpm0dP1f9zkENyhRP4zGys47cStBpC54SZO7BIE4DO+VG8
         U8YA==
X-Gm-Message-State: AGRZ1gK0iT8jtqmI2hVRl7F7t3PeFQa07OCXvbkMc4f1wgdWhsJR3jhV
        rVYUqXyq384xJHuKVhKHpMy32P+NcFPW2A1MI5ERPFDYfRU=
X-Google-Smtp-Source: AJdET5cfgNiXSXR3/p37vjM2Fa/TU3VmJTEvReGsZnZEaCuDiQsHGzgu/0ma0RPYtu1JfsOMK0GHg9V9c5KOl40A2zE=
X-Received: by 2002:aca:af48:: with SMTP id y69mr2619016oie.274.1542258739188;
 Wed, 14 Nov 2018 21:12:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:d182:0:0:0:0:0 with HTTP; Wed, 14 Nov 2018 21:12:18
 -0800 (PST)
X-Originating-IP: [2601:647:5180:35d7::860e]
In-Reply-To: <CAGZ79ka=tkKYNkPmSjhomcfAPbEg6PQPSRtpe3uq2B45fNoyjg@mail.gmail.com>
References: <CAGw6cBvLDNtYT6vfHcxmX0S_SS1vmYVCEkSD_ixah6cGKJ4H9w@mail.gmail.com>
 <CAGw6cBvaC+TEOM9Tjdbs5zkz2hzW4649=4rsAo58cNOVHOQS=Q@mail.gmail.com> <CAGZ79ka=tkKYNkPmSjhomcfAPbEg6PQPSRtpe3uq2B45fNoyjg@mail.gmail.com>
From:   Michael Forney <mforney@mforney.org>
Date:   Wed, 14 Nov 2018 21:12:18 -0800
Message-ID: <CAGw6cBvJSswpvrMwKU9b+ANEHO4tWjWVhLL54nUyod2NoHJe1w@mail.gmail.com>
Subject: Re: Confusing behavior with ignored submodules and `git commit -a`
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-10-25, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Oct 25, 2018 at 11:03 AM Michael Forney <mforney@mforney.org>
> wrote:
>>
>> On 2018-03-16, Michael Forney <mforney@mforney.org> wrote:
>> > Hi,
>> >
>> > In the past few months have noticed some confusing behavior with
>> > ignored submodules. I finally got around to bisecting this to commit
>> > 5556808690ea245708fb80383be5c1afee2fb3eb (add, reset: ensure
>> > submodules can be added or reset).
>
> Uh. :(
>
> See the discussion starting at
> https://public-inbox.org/git/20170725213928.125998-4-bmwill@google.com/
> specifically
> https://public-inbox.org/git/xmqqinieq49v.fsf@gitster.mtv.corp.google.com/

Thanks for the links. Let me explain how I'm using
submodule.<name>.ignore. Maybe there's a better mechanism in git to
deal with this (if .ignore is a misfeature).

I have a git repository which contains a number of submodules that
refer to external repositories. Some of these repositories need to
patched in some way, so patches are stored alongside the submodules,
and are applied when building. This mostly works fine, but causes
submodules to show up as modified in `git status` and get updated with
`git commit -a`. To resolve this, I've added `ignore = all` to
.gitmodules for all the submodules that need patches applied. This
way, I can explicitly `git add` the submodule when I want to update
the base commit, but otherwise pretend that they are clean. This has
worked pretty well for me, but less so since git 2.15 when this issue
was introduced.

Of course, I could maintain and publish forks of those repositories
and use those as the remote for the submodules. However in many cases
these patches are just temporary until they get applied upstream and a
new release is made, and I don't really want to keep mirrors
unnecessarily, or keep switching the submodule URL between upstream
and my fork.

>> > However, if I go to update `foo.txt` and
>> > commit with `git commit -a`, changes to inner get recorded
>> > unexpectedly. What's worse is the shortstat output of `git commit -a`,
>> > and the diff output of `git show` give no indication that the
>> > submodule was changed.
>
> This is really bad. git-status and git-commit share some code,
> and we'll populate the commit message with a status output.
> So it seems reasonable to expect the status and the commit to match,
> i.e. if status tells me there is no change, then commit should not record
> the submodule update.

I just checked and if I don't specify a message on the command-line,
the status output in the message template *does* mention that `inner`
is getting updated.

>> > There have been a couple occasions where I accidentally pushed local
>> > changes to ignored submodules because of this. Since they don't show
>> > up in the log output, it is difficult to figure out what actually has
>> > gone wrong.
>
> How was it prevented before? Just by git commit -a not picking up the
> submodule change?

Yes. Previously, `git commit -a` would not pick up the change (unless
I added it explicitly with `git add`), and `git log` would still show
changes to ignored submodules (which is the behavior I want).

> I guess reverting that commit is not a good idea now, as
> I would expect something to break.
>
> Maybe looking through the series 614ea03a71
> (Merge branch 'bw/submodule-config-cleanup', 2017-08-26)
> to understand why it happened in the context would be a good start.

Thanks, that's a good idea. I'll take a look through that series.

>> I accidentally pushed local changes to ignored submodules again due to
>> this.
>>
>> Can anyone confirm whether this is the intended behavior of ignore? If
>> it is, then at least the documentation needs an update saying that
>> `commit -a` will commit all submodule changes, even if they are
>> ignored.
>
> The docs say "(but it will nonetheless show up in the output of
> status and commit when it has been staged)" as well, so that commit
> sounds like a regression?

I just came across someone else affected by this issue:
https://github.com/git/git/commit/55568086#commitcomment-27137460
