Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EEC41F404
	for <e@80x24.org>; Mon, 12 Mar 2018 21:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932354AbeCLV0F (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 17:26:05 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:40518 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932242AbeCLV0E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 17:26:04 -0400
Received: by mail-ua0-f171.google.com with SMTP id c14so7829993uak.7
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 14:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jT+6UU6n5zEqzusjMNBm8j92wpMJlIWhGuw5Zk2Bs7E=;
        b=B8raCgtuC0gVltQ1l86QWuCEqckeHPjQSedNKtWSLHPmyGfA+Vo6T9LA28BhgYuiRn
         ZC6LDH0zIc9r0LtENp1UNiPDXSrWkqZzO6wkzPUN9xDBNvAG1pVB4wezj9mZgf/A54na
         RWSqHp2xM9qom/F16Id6l9FTn4n6ZCCLHGw2m1vYWY8LN6eEKO9f6E+8F64aIHJ/Y7ko
         YGkWvFvwb1PDp3QwQxL3BrGrEOFJMD0NrHfnlCy+QvvKHT0CVVpML7X3PubhJvG9WVH1
         cUm/+eZfxYX4OxUBZEkeONE9EIxtY3DAQjdjlVuIOPHoBVIywiAXp9poUFLVyXVFuBeE
         2Alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jT+6UU6n5zEqzusjMNBm8j92wpMJlIWhGuw5Zk2Bs7E=;
        b=AvYoGqEeau7RRI0ArZeKa+3e9WOurjSqY3zHcZE4e06cKrdzqhtT4H34Y696scp5Q7
         Lyrp2vxleVM+JQ3FIgh4JVGbe2OhD8HCupuK4N+AiWjD8+vjzQierGbSWKQ+cxrZ+5YQ
         BI+OCyw4aG9KCG8ddF5ynK/g2SYgVd5/ktQ2+pGzzD/0q7mDx0e3jCbmipgJNlkJ+dnz
         Dpnz/m2lHOeLxwdYYCIj21Cs0EoVmP1ngdSlxWwIB8COn8l5QPo7+ZlTejmDHS4zDVUA
         QwKDOqwRtsrjEL3nFBLyo6thz387xfIu3kRmXZZE5huA77Uyh85HbGnSSEAqjYps3hnk
         X+LA==
X-Gm-Message-State: AElRT7HsRU2gFdjuzpZvymK7fX7DmgWlhsdw9bhYf0RJe+NrOsk7nF+z
        1iKFlFEfuT4RqeyGKteFIZhKKIupPt05XEsA47I=
X-Google-Smtp-Source: AG47ELsWe2YP3fpF/kq9reZlVj5idAagkPrT7liBrvw4JiJW6TsfqrUHbM+wcLkXVKhLzTnytp0qPIojGt5+PRhKddc=
X-Received: by 10.159.63.11 with SMTP id h11mr7011436uaj.94.1520889963235;
 Mon, 12 Mar 2018 14:26:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.1.49 with HTTP; Mon, 12 Mar 2018 14:26:02 -0700 (PDT)
In-Reply-To: <20180312184734.GA58506@aiede.svl.corp.google.com>
References: <CABPp-BEXcvgxcn4-OrDhjUpuOsGCJwE_XT+0eYOK4Ad_O5maOg@mail.gmail.com>
 <20180312184734.GA58506@aiede.svl.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 12 Mar 2018 14:26:02 -0700
Message-ID: <CABPp-BEdh+UOCpFn5Y1_RydR==dDHWTeNtBub+pPjH_06Ub28w@mail.gmail.com>
Subject: Re: Opinions on changing add/add conflict resolution?
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Cool, thanks for taking a look!

On Mon, Mar 12, 2018 at 11:47 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> My immediate reaction is that it seems inconsistent with the rest of
> merge behavior.  Why would add/add behave this way but edit/edit not
> behave this way?

Fair enough.  I have two separate reasons for believing that edit/edit
IS different than add/add; further, the current behavior for add/add
is inconsistent with the rest of merge behavior on a different axis.
I think it's helpful to get the motivation for my changes before
trying to explain why those are different and before delving into the
other inconsistency, so I'll add the explanation of this claim at the
end of this email.

> Would this behavior be configurable or unconditional?  I suspect I
> would want it turned off in my own use.
>
> On the other hand, in the case of wild difference between the two
> files, skipping the two-way merge and just writing one of the versions
> to the worktree (like we do for binary files) sounds like something I
> would like in my own use.

I think you just said the exact opposite thing in these last two
paragraphs; that you wouldn't want my proposed behavior and that you'd
want it.  I suspect that may mean that I misunderstood something you
said here.  Could you clarify?

> Can you add something more about the motivation to the commit message?
> E.g. is this about performance, interaction with some tools, to
> support some particular workflow, etc?

To be honest, I'm a little unsure how without even more excessive and
repetitive wording across commits.  Let me attempt here, and maybe you
can suggest how to change my commit messages?

  * When files are wildly dissimilar -- as you mentioned -- it'd be
easier for users to resolve conflicts if we wrote files out to
separate paths instead of two-way merging them.
  * There is a weird inconsistency between handling of add/add,
rename/add, and rename/rename(2to1).  I want this inconsistency fixed.
  * There is a significant performance optimization possible for
rename detection in git merge if we remove the above inconsistency and
treat these conflict types the same.  (Actually, we only need them to
be the same in the special case where a renamed file is unmodified on
the un-renamed side of history, but I don't want to special case that
situation because it sounds like a recipe for inconsistent results).
  * If we insist on these conflict types being handled differently
because there really is some important distinction between them, then
I'm almost certain that build_fake_ancestor() and it's usage in
am/rebase is broken/wrong.  This is because the usage of
build_fake_ancestor(), as currently implemented, will cause
mis-detection of one conflict type as another.

> Thanks and hope that helps,
> Jonathan

As promised above, here are my reasons for believing that edit/edit IS
fundamentally different than add/add for the behavior considered here,
as well as my explanation of the weird inconsistency add/add currently
has with the rest of merge behavior:

==Reason 1==
edit/edit means that ${path} existed in the merge base as well as both
sides.  It is more likely than not that ${path} on each side is
similar to the merge base and thus similar (though less so) to each
other.  On the other hand, add/add means ${path} did NOT exist in the
merge base.  Thus, we cannot use the same reason to believe they are
similar.  The only reason we have to assume similarity is the
filename, which, while a useful indicator, gives us a weird
inconsistency within git for handling pathname collisions -- see
"Weird inconsistency" below.

==Reason 2==
In merges, git does rename detection, but not copy or break detection.
In particular, break detection is what would allow us to find out that
the edited files are not similar to the original.  add/add conflicts
automatically come to us "pre-broken" (is there a better term for
knowing that two files are not paired?), though it is possible that
they just happen to be similar and should be paired/joined.

==Follow on to reason 2==
Not doing break detection means we get e.g. rename/add-source cases
wrong, so there are valid arguments for saying we should add break
detection.  However, it would be computationally expensive and would
require a fair amount of work re-thinking all the cases in
merge-recursive to make sure we get rename-breaks right (there are
FIXMEs and comments and testcases I added years ago to help someone
along the path if they want to try).  Since rename/add-source just
isn't a conflict type that occurs much (if it all) in real world
repositories, the motivation to implement it is somewhat low.

==Weird inconsistency git currently exhibits==
There are three types of conflicts representing two (possibly
unrelated) files colliding at the same path: add/add, rename/add, and
rename/rename(2to1).  add/add does the two-way merge of the colliding
files, and the other two conflict types write the two colliding files
out to separate paths.  I think the motivation behind the current
behavior was that add/add was written assuming filename-match implies
similarity, and the other two were written assuming filename-match
didn't imply anything and the files should be assumed dissimilar.
That seems weird to me.  I think all three should behave the same
(especially when the renamed file was unmodified on the un-renamed
side of history, and likely whenever there is no content conflicts for
the renamed file).
