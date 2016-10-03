Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63C94207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 21:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbcJCVRv (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 17:17:51 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:33187 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751500AbcJCVRu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 17:17:50 -0400
Received: by mail-io0-f170.google.com with SMTP id r145so134370622ior.0
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 14:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jklpYyocoMh2y2CEMAKHGeGMzdjmRqYCc+DHQOElZgI=;
        b=ooxtDDJWnd7BDwYPIIXJLDSrRcwtcrs7YtXj+IqvQGMsrhmvsHvFCErtLDOd+DhckO
         nkdLDDkLYLJ/faWf4qpAPjvcE9DZEsbmWRqP6MTT/BnvcGHQqy1IdtJnanWLjcnfCjEJ
         RnUIGFzPpvx1uo0x3oMAB1vnCOTqewViZLRU6RHc8v+M1GPFrpXNKOQStEt3xpZzkB+N
         bOx6n53Y5cm37T3OBAe+WpEYDB5jVZdiWpq352JXa8pE3wOE+7c3ieb1I7I55e2Y48x1
         kCfHQ9S6SVnxVxRzze5wAGAGmhKElUTiV0mtwSBX4VbkRjxPnIF/V9nuyBzQzJmylZgX
         FIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jklpYyocoMh2y2CEMAKHGeGMzdjmRqYCc+DHQOElZgI=;
        b=fyW0zSbX4tzhSlu7+4AFR/HoEKz8W80xVbaNu3CUtPwpI7qK6hxvmhpkJUvOfLuG5q
         BRqXGdGvS3RbTKp9bCf0TfYjBSc4GZBg1gsI28HGSe1WNy/wrApVY0Ryc3hBIcbZQj99
         BAvlL8J9fesv+PmwJgtwiHhXvQ8cl1ewnZznr2/gP9DGyO1YdEO/sINytF23FhlTQUya
         nFeoZ6OVBM2sllsSm8gAGfZlX7zpI8x8oV23l721aXMgFFPKq+J7Pb03mNbCTWMgROJy
         JWF7BR/tLJEynatA8OfYO9S29mu/DnN5zftZ5ty10CwWOb8P6g4KvAlzWH2GIXJ3QanE
         NSgA==
X-Gm-Message-State: AA6/9RmLejq2B6n6pHdhNZ+Xwlqqhsm91JdfYj3k3q3hJm/REg79ODky+oErLwaH7/ZKEoJP0Xy8sSrzyP1vELwn
X-Received: by 10.107.144.86 with SMTP id s83mr770120iod.97.1475529469525;
 Mon, 03 Oct 2016 14:17:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Mon, 3 Oct 2016 14:17:49 -0700 (PDT)
In-Reply-To: <CA+55aFyos78qODyw57V=w13Ux5-8SvBqObJFAq22K+XKPWVbAA@mail.gmail.com>
References: <CA+55aFyos78qODyw57V=w13Ux5-8SvBqObJFAq22K+XKPWVbAA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 3 Oct 2016 14:17:49 -0700
Message-ID: <CAGZ79kYXx+a+U3o6FPBy2mHOy4BxxuF97t6iyedPLk0Qw1Jx1A@mail.gmail.com>
Subject: Re: Slow pushes on 'pu' - even when up-to-date..
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 3, 2016 at 2:11 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> This seems to be because I'm now on 'pu' as of a day or two ago in
> order to test the abbrev logic, but lookie here:
>
>     time git ls-remote ra.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux
>     .. shows all the branches and tags ..
>     real 0m0.655s
>     user 0m0.011s
>     sys 0m0.004s
>
> so the remote is fast to connect to, and with network connection
> overhead and everything, it's just over half a second. But then:
>
>     time git push ra.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux
>
> and it just sits there, and it's at 100% CPU the whole time, until it says:
>
>     Everything up-to-date
>
>     real 1m7.307s
>     user 1m2.761s
>     sys 0m0.475s
>
> Whaa? It took a *minute* of CPU time to decide that everything was up-to-date?
>
> That's just not right. The branch is entirely up-to-date:
>
>     git rev-parse HEAD
>     af79ad2b1f337a00aa150b993635b10bc68dc842
>
>     git ls-remote ra.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux master
>     af79ad2b1f337a00aa150b993635b10bc68dc842 refs/heads/master
>
> so there should be no need for any history walking. But it sure is
> doing *something*. A minute of CPU time on my machine is actually a
> pretty damn big deal.
>
> Looking at the trace, there's no IO - there's no back-and-forth about
> "I have this, do you have it?" or anything like that. The system call
> trace is just a lot of allocations, which I think means that "git
> push" is walking a lot of objects but not doing anything useful.
>
> I bisected it to commit 60cd66f "push: change submodule default to
> check", which makes little sense since I have no submodules, but there
> you go.. Apparently RECURSE_SUBMODULES_CHECK is just terminally
> broken.

Sorry for breaking you, too.

Junio complained about that when I was proposing the topic; but now
the strategy seems to just wait until Heiko fixed the
RECURSE_SUBMODULES_CHECK to be less broken.

* sb/push-make-submodule-check-the-default (2016-08-24) 1 commit
 - push: change submodule default to check

 Turn the default of "push.recurseSubmodules" to "check".

    Will hold to wait for hv/submodule-not-yet-pushed-fix

    This reveals that the "check" mode is too inefficient to use in
    real projects, even in ones as small as git itself.
    cf. <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>

Which itself is

* hv/submodule-not-yet-pushed-fix (2016-09-14) 2 commits
 - serialize collection of refs that contain submodule changes
 - serialize collection of changed submodules

 The code in "git push" to compute if any commit being pushed in the
 superproject binds a commit in a submodule that hasn't been pushed
 out was overly inefficient, making it unusable even for a small
 project that does not have any submodule but have a reasonable
 number of refs.

 The last two in the original series seem to break a few tests when
 queued to 'pu', and dropped for now.

 Waiting for a reroll.
