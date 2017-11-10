Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1F4A1F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 23:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754034AbdKJX01 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 18:26:27 -0500
Received: from mail-ua0-f176.google.com ([209.85.217.176]:53409 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751324AbdKJX00 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 18:26:26 -0500
Received: by mail-ua0-f176.google.com with SMTP id e10so5179454uah.10
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 15:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rxkc4WxzOjt+zZsegqtts8rC3swIph3prZOL5eGoZgU=;
        b=ve4czqnMAQlRbZ1lEEwkbjuktmD1aY8akX9W10AraaTafv0xv0y5iUjBbFLQx2ztcC
         QW8LRlvag2iT1Qhlya3OOizwfdXbgEbbAsjKUGOLDGPJ6XbYN6X27aIu9I0QTOd/GiZa
         IbsQ7RgQZeJKexzxZTHlgEZI2nN+ElZFd1dAEtLpZ6tWNT+lduHk5eYPpF6BY7DKLAGx
         GPm/hjNAAL7M1y/IzeSETeR+/jMlyD371vI6cYcf89qTPndVBSmE4dd1X47odSY85bHg
         D2m7GxUw2tVMfuobC3jJ+07tL0fEJdfiZsjcfRuZKFO3qJc/haz7pMKQFpPHwx6zMMnR
         3rkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rxkc4WxzOjt+zZsegqtts8rC3swIph3prZOL5eGoZgU=;
        b=JzGMFJnBHNfmn8wdrwvHiloR8h4JIiRfZRrYEmKbkhftNXXw+BFerft1CZdL/9Oo9o
         UCWJByhS6jwT0rgSGUflMTFfKYnc4JOSiunWy0chQuDMFBT1XjHvoC71KhmK8W3iy7++
         e+skvHnxOTVfsxbsf3GWg0uodnhIwEzgjMO57mWZCnDa7EULjlfNW8r+Xz6cXepe7lHu
         Tf4akquf0IP/Jq5a6kqp8grz2/u+duxUfTMzKBWZ5rMV1hXat3cn9fGVKZz1/MFkwpPj
         6oL3QHJFTF/Txxr0p+IFzT4keNJSyZcsaUf/wFUFAU0mu15/IgCpReCaidxOHLceY+gU
         3Fww==
X-Gm-Message-State: AJaThX6MIzM4HFPyG6ez3zOsm9RvBoqxzBJNsSaMz60IfWThU4/kRbgo
        soVQB6trVJI5asUklqlc4GRlyI6kx1J4uo3N3UI=
X-Google-Smtp-Source: AGs4zMYQSbnXpbWrizOxNYVZ5MkHf1okFT7eQP21tROXrh3rP3uXEI8+hE3fDbMMcubqjWBXe4kmN+Ykp49XY37OYy8=
X-Received: by 10.176.23.19 with SMTP id j19mr1747459uaf.87.1510356385358;
 Fri, 10 Nov 2017 15:26:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Fri, 10 Nov 2017 15:26:24 -0800 (PST)
In-Reply-To: <3076EE0E678D43B286F86E622CB9F06E@PhilipOakley>
References: <20171110190550.27059-1-newren@gmail.com> <3076EE0E678D43B286F86E622CB9F06E@PhilipOakley>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Nov 2017 15:26:24 -0800
Message-ID: <CABPp-BE1+32fQQdYuwP-7m+GXqyhoUpHKgMM6SCcW4e9geutvw@mail.gmail.com>
Subject: Re: [PATCH 00/30] Add directory rename detection to git
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 10, 2017 at 2:27 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Elijah Newren" <newren@gmail.com>
>>
>> In this patchset, I introduce directory rename detection to
>> merge-recursive,
>> predominantly so that when files are added to directories on one side of
>> history and those directories are renamed on the other side of history,
>> the
>> files will end up in the proper location after a merge or cherry-pick.
>>
>> However, this isn't limited to that simplistic case.  More interesting
>> possibilities exist, such as:
>>
>>  * a file being renamed into a directory which is renamed on the other
>>    side of history, causing the need for a transitive rename.
>>
>
> How does this cope with the case insensitive case preserving file systems on
> Mac and Windows, esp when core.ignorecase is true. If it's a bigger problem
> that the series already covers, would the likely changes be reasonably
> localised?
>
> This came up recently on GfW for `git checkout` of a branch where the case
> changed ("Test" <-> "test"), but git didn't notice that it needed to rename
> the directories on such an file system.
> https://github.com/git-for-windows/git/issues/1333

I wasn't aware there were problems with git on case insensitive case
preserving filesystems; fixing them wasn't something I had in mind
when writing this series.  However, the particular bug you mention is
actually completely orthogonal to this series; it talks about
git-checkout without the -m/--merge option, which doesn't touch any
code path I modified in my series, so my series can't really fix or
worsen that particular issue.

But, if there are further issues with such filesystems that also
affect merges/cherry-picks/rebases, then I don't think my series will
either help or hurt there either.  The recursive merge machinery
already has remove_file() and update_file() wrappers that it uses
whenever it needs to remove/add/update a file in the working directory
and/or index, and I have simply continued using those, so the number
of places you'd need to modify to fix issues would remain just as
localized as before.  Also, I continue to depend on the reading of the
index & trees that unpack_trees() does, which I haven't modified, so
again it'd be the same number of places that someone would need to
fix.  (However, the whole design to have unpack_trees() do the initial
work and then have recursive merge try to "fix it up" is really
starting to strain.  I'm starting to think, again, that merge
recursive needs a redesign, and have some arguments I wanted to float
out there...but I've dumped enough on the list for a day.)

It's possible that this series fixes one particular issue -- namely
when merging, if the merge-base contained a "Test" directory, one side
added a file to that directory, and the other side renamed "Test" to
"test", and if the presence of both "Test" and "test" directories in
the merge result is problematic, then at least with my fixes you
wouldn't end up with both directories and could thus avoid that
problem in a narrow set of cases.

Sorry that I don't have any better news than that for you.

Elijah
