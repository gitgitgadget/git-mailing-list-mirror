Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9EC21FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 22:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757415AbeAHWPG (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 17:15:06 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:42664 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756391AbeAHWPF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 17:15:05 -0500
Received: by mail-qt0-f176.google.com with SMTP id g9so15558333qth.9
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 14:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opera.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CixdUMYFKEhCZqCJ3XjD2Wijhtehfo3b+YvF8RbDYKo=;
        b=FZpyCrZSnXEdVAoLrBQ6QPH7DVYQXOSCa1b7gifty/Vs5NZJPsFLvzUJYSi4GWKGJ3
         OFiz4IV1J5HAZL/5Mh1StSVKRlaRV1p61xDGP739aoLnp7tHniYTgFUgSR9OayGCV6cq
         CWhNGEdRjaK4sGvTe5Be1ynkDplYrGYgMHHNGrsJgirXDXEUXWlGqnndiEE8Ct+Knb3J
         G/k+2Tm212gRJbZD0uL+bZ96ncXiI5RSX/xqDPDdxm/QfuQIqqALkAMxMCrC7Iye+Uba
         xB5yK2H/qphVwmFykPNWsdIEIWLLq8iIQ6O3WRWzQtdwqh66qDdnNe5Nhxb5cUhyk7w0
         l/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CixdUMYFKEhCZqCJ3XjD2Wijhtehfo3b+YvF8RbDYKo=;
        b=IPnVo3tyESiGsw9Hs7Epgik1tsQevXDJLKKO9Hh0sgceKOjbrYooNVUm0GJo+KR3xK
         1sNjvZN6U+QyfDLJ6PF0J4z0GxxGcRoJx3dsanWRgNC3HUpEZRw1VJ0wdRuMU/lECkMH
         ecR2wk6k0lCoe4Cc+6kSJhMAyV6A4sd0PyzAqcueWrbFBa7t9lhTNcZuipp8wa7vgiD8
         WPqXrzr8fhWMLk7wub+4ATyU2UWJT5X/ox/iVz5oVXIZXcyYwc/0WurnFKGQpKzcepO3
         R7OtzMNmXuhN7WSp8WCwK1SXpzl3TvEXJtXoPxvFFXnqZ3aUbijdbsTelQUYbYW86x54
         8ZQw==
X-Gm-Message-State: AKwxyteB9Ms+IQOFD2YTfdiR47RyCHg5Vsn/AAY/+qm6pHX+FIg9Idgn
        mmfoGwx0UNc8+/68HDWRDt2FxE2GZ1IaG+a64JG0SQ==
X-Google-Smtp-Source: ACJfBosr3/cF7E/cuHpZG0GSzooZyRIj+P4DHnwyqkgBtdTKJzeTurnvLASI90bLXutRM7oxQdGFh/17Ymn7uI4+D8I=
X-Received: by 10.200.45.215 with SMTP id q23mr18799014qta.85.1515449704468;
 Mon, 08 Jan 2018 14:15:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.55.53.65 with HTTP; Mon, 8 Jan 2018 14:15:04 -0800 (PST)
In-Reply-To: <CAGZ79katKiRwXLJscxbO-+JWLedgKmZ7Un-65i4CqefX9Fedqg@mail.gmail.com>
References: <CAP=KgsSQOG=mmUDfSFDw0HJYvJWVPFU7M5T+k4VhfuRC_v9dww@mail.gmail.com>
 <CAGZ79katKiRwXLJscxbO-+JWLedgKmZ7Un-65i4CqefX9Fedqg@mail.gmail.com>
From:   Per Cederqvist <cederp@opera.com>
Date:   Mon, 8 Jan 2018 23:15:04 +0100
Message-ID: <CAP=KgsRR1b8t=qBASf+8EnJyCmpLYPaJQMVHy6VfNxHruJ3--A@mail.gmail.com>
Subject: Re: cherry-picking fails after making a directory a submodule
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 8, 2018 at 10:46 PM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Jan 8, 2018 at 1:08 PM, Per Cederqvist <cederp@opera.com> wrote:
>> I have a situation where I have switched a directory from being a
>> subdirectory to being a submodule.  I then try to cherry-pick a commit
>> from a taskbranch that was made before the switch to the master
>> branch.  The commit touches a file outside the subdirectory/submodule.
>> Yet "git cherry-pick" fails with this error message:
>>
>>> error: could not apply 78c403e... Add a project feature
>>> hint: after resolving the conflicts, mark the corrected paths
>>> hint: with 'git add <paths>' or 'git rm <paths>'
>>> hint: and commit the result with 'git commit'
>>
>> I can resolve the situation by running "git add libfoo && git
>> cherry-pick --continue".  The generated commit contains no changes to
>> "libfoo".
>>
>> I don't understand why I need to manually add libfoo, as the commit
>> I'm cherry-picking doesn't touch anything in libfoo.
>>
>> The script below can reproduce the issue.  Tested with git 2.15.1,
>> 2.14.0 and 2.8.0, all with the same result.
>>
>> Is this a bug in "git cherry-pick"?
>
> Could you please test with
> github.com/git/git/commit/c641ca67072946f95f87e7b21f13f3d4e73701e3
> included? (See its parent commit, for the test)
>
> From my cursory read that commit is the issue addressed in that commit.

Thanks!  I can confirm that applying the changes to merge-recursive.c from
that commit fixes the issue in 2.15.1.

    /ceder
