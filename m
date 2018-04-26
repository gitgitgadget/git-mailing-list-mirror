Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFE131F424
	for <e@80x24.org>; Thu, 26 Apr 2018 22:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757168AbeDZWTi (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 18:19:38 -0400
Received: from mail-yb0-f169.google.com ([209.85.213.169]:32906 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756583AbeDZWTh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 18:19:37 -0400
Received: by mail-yb0-f169.google.com with SMTP id y5-v6so9964781ybg.0
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 15:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DI8+sgaK19FXeCO6WkdTPEBcJxvMk1ks1u68kP8ovAg=;
        b=jfs9no25D1iKTI0rCmlNvz1A5qRMzO1CfrBUEajHcqYo2zVZzQxr8mVKSU8IEOhhq2
         AZE7bmGDo7XV1yAXMqH5EfT/B6m6IA9KvEgMY4yvbjsDUm/ge06ySKZ2g6Zg0wHQBcLu
         T61PN3u3zRpw+OH2OLteGASvz0wksLkc1h0KwLSTTFDaacAqodfp3txggsUdmUPOUVfJ
         xPQjupgbqvT9RdUJ8rRTc1TSST/q+wgqmczwVMN+SdXAJeJ4DU/1RHShId718W7EMT5Q
         xgir48ZlF0BkmLRDI41ROuc7koP+r8A5+1jnV7pYW/qlYvSquIDDij8qerq5DLRTW/yi
         wH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DI8+sgaK19FXeCO6WkdTPEBcJxvMk1ks1u68kP8ovAg=;
        b=IwpHTDXeLD0zgtxmdLgPAUvmOCdu3Bbd9vjqItMq3sIVwZdhgh6btC94a0Vt3zS3QC
         wZcR/joq4Hj27ESEofn/j85tML2RTgnqIETGxfmKiVkzTNAhN/AebzBBJGK/T+EJ7ZdA
         Tmu4E21iA9rzpJSR/fJDxBUlMZV0n0stG+1/pl8a+iBAkmGSNVJLuBRpkNHUogOMVayv
         PCkPBk9FAuqZG7vXpIv7zTk5j3hPdW3m4dlUjTw86QFDqRnHURiQM+P/DB47jd/tR6bh
         k+aX/fbeblmUWeVpPXr+n2G/BZQzGMGFQXku+QAEZARB6GJChwE4OilkLi4KVBZeVL0L
         rLZw==
X-Gm-Message-State: ALQs6tARcD9mBUk5eWn/p+dszHdDLiffQ3iKY5nC4xrEWX0w8ptcC57e
        PtOyvKdp9+sTs0PBHE0OzEMxLPfooeGJpX+hzZePrQ==
X-Google-Smtp-Source: AB8JxZppXeVScEf8FfX2Vexd9kppE3cuRunyHlAQwMeYtwA18KRv2bXFRXiAm3JG0JL4B0SiS8yVU3Am1VqCDj/gLUc=
X-Received: by 2002:a25:500e:: with SMTP id e14-v6mr19430791ybb.334.1524781176762;
 Thu, 26 Apr 2018 15:19:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Thu, 26 Apr 2018 15:19:36
 -0700 (PDT)
In-Reply-To: <CA+P7+xrUwq0G2YySC3SLKqyihhPnFPCiQnQpoVVa89+=W9O9+w@mail.gmail.com>
References: <1524739599.20251.17.camel@klsmartin.com> <CAGZ79kZA_R-5bA6mPdoHkVW-C21pNn_0x6FayhuuXqnOTrmjWw@mail.gmail.com>
 <CA+P7+xrUwq0G2YySC3SLKqyihhPnFPCiQnQpoVVa89+=W9O9+w@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 26 Apr 2018 15:19:36 -0700
Message-ID: <CAGZ79kaub2k-q-Mcj3H5o6ekyZ8ZZzG7+r5sHt5Ne25Nc3_nPQ@mail.gmail.com>
Subject: Re: git merge banch w/ different submodule revision
To:     Jacob Keller <jacob.keller@gmail.com>,
        Heiko Voigt <hvoigt@hvoigt.net>
Cc:     "Middelschulte, Leif" <Leif.Middelschulte@klsmartin.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan wrote:
> See https://github.com/git/git/commit/68d03e4a6e448aa557f52adef92595ac4d6cd4bd
> (68d03e4a6e (Implement automatic fast-forward merge for submodules, 2010-07-07)
> to explain the situation you encounter. (specifically merge_submodule
> at the end of the diff)

+cc Heiko, author of that commit.

On Thu, Apr 26, 2018 at 2:46 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Thu, Apr 26, 2018 at 10:56 AM, Stefan Beller <sbeller@google.com> wrote:
>> We often treating a submodule as a file from the superproject, but not always.
>> And in case of a merge, git seems to be a bit smarter than treating it
>> as a textfile with two different lines.
>
> Sure, but a submodule is checked out "at a commit", so if two branches
> of history are merged, and they conflict over which place the
> submodule is at.... shouldn't that produce a conflict??

Stepping back a little bit:

When two branches developed a file differently, they can be merged
iff they do not change the same lines (plus a little bit of margin of 1
extra line)

That is the builtin merge-driver for "plain text files" and seems to be accepted
widely as "good enough" or "that is how git merges".

What if this text file happens to be the .gitmodules file and the changed lines
happen to be 2 options in there (Say one option was the path, as one branch
renamed the submodule, and the other option is submodule.branch) ?

Then we could do better as we know the structure of the file. We would not
need the extra buffer line as a cautious step, but instead could parse both
sides of the merge and merge each config in-memory and then write out
a .gitmodules file. I think David Turner proposed a custom merge driver
for .gitmodules a couple month ago.

Another example is the merge code respecting renames on one side
(even for directories) and edits in the other side. Technically the rename
of a file is a "delete of all lines in this path", which could also argued to
just conflict with the edit on the other side.

With these examples given, I think it is legit to treat submodule changes
not as "two lines of text differ at the same place, mark it as conflict",
but we are allowed to be smarter about it.

> I mean, how is the merge algorithm supposed to know which is right?

Good question. As said above, the merge algorithm for text files is just
correct for "plain text files". In source code, I can give an example
which merges fine, but doesn't compile after merging: One side changes
a function signature and the other side adds a call to the function (still using
the old signature).

Here you can see that our merge algorithm is wrong. It sucks.
The solution is a custom merge driver for C code (or whatever
language you happen to use).

For submodules, the given commit made the assumption that
progressing in history of a submodule is never bad, i.e. there are
no reverts and no bugs introduced, only perfect features are added
by new submodule commits. (I don't know which assumptions were
actually made, I made this up).

Maybe we need to revisit that decision?

> The patch you linked appears to be able to resolve it to the one which
> contains both commits.. but that may not actually be true since you
> can rewind submodules since they're *pointers* to commits, not commits
> themselves.

Right, and that is the problem, as the pointer is a small thing, which
doesn't allow for the dumb text merging strategy that is used in files.

So we could always err out and have the user make a decision.
Or we could provide a basic merge driver for submodules (which
was implemented in that commit).

If you use a different workflow this doesn't work for you, so
obviously you want a different custom merge driver for
submodules?

> I'm not against that as a possible strategy to merge submodules, but
> it seems like not necessarily something you would always want...

I agree that it is reasonable to want different things, just like
wanting a merge driver that works better with C code.
(side note: I am rebasing a large series currently and one of the
frequent conflicts were different #includes at the top of a file.
You could totally automate merging that :/)

Thanks,
Stefan
