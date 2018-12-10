Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF9A620A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 20:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbeLJUZl (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 15:25:41 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:32844 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbeLJUZl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 15:25:41 -0500
Received: by mail-vs1-f65.google.com with SMTP id p74so7497407vsc.0
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 12:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7FO0fCZlHhlHljdAzOAcZ71uyFDSwPbuViyjAx41x/E=;
        b=V1PF3siuXXuuWhAbYLfLNXy+CYayNDam1qYOci88HpX7t32u3UpgN1v6HRQoNpdBJT
         STQL+IOtIa1V8TZpSiUAgJMgmLG2qmM7Fkum/dOvaKtVoDt+klyXb7jajygLh88WKlSr
         9IFFcYGbXvD57QL4dzbdd05eSxa37ib6KiXR30+3624+UYXMByl2y3lJM4L+1Qv20FT+
         g2cqlCpUtwUYkO5A9NyL1GkKqsvozxddyztGPXRLOlEWkppb0yyqZbgr6aQ/QhJ3yaoP
         HPhQNqq9G06lz72Our5nHADZpzCEZ0iclQFBp5r8oRZGZkn4YkfrORCEcE7jOe0c0szJ
         TX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7FO0fCZlHhlHljdAzOAcZ71uyFDSwPbuViyjAx41x/E=;
        b=G01JsV6B3DuNB6yc57GV70xkjOnvqbb/ts2E/aL4IrOjOlLYctWxm6Xi958RaeANvV
         b6fAVNhqHD5SR4Di+nC0kMWXLVnI9HrllH29JgkCxrstNYd0AXtVROQraQsPlbg5eKIF
         jqW9kAhblBRDjJRdBSFAy8F7KMkz5oBn+zsFSK6aUJK4JfXYGVaxPzt3P8g3p+nVu26L
         aUHf9XvWDt4hhW8SFnSUnX2ID5LmZkPy/yBMdm0zwQmuXIsr34sBhCGXdqfOpyTxik0c
         RB1FXEz1eM/9+XYj8e9WS7OnVKT27FA3ILDEWD1sf8RtXK/FQqmwthhEvlIRqp2BXHjB
         KGKA==
X-Gm-Message-State: AA+aEWa7qXKCC2/Ul7Q9uQ+GGSFQd3nmbIrKmzfkIRdl8l2QvIcdb5vO
        egqwjoRkCQ5hWSKD0d92lqyU0IzehxLkna7F5Tw=
X-Google-Smtp-Source: AFSGD/WCCMXX1JKdYeeBbvBsFZyMbhi4XfwOoKEdcVm2obRD5hIj7vqhCmJ54HZnOYNkKgJo33RZrqSwkO2thKGH5XQ=
X-Received: by 2002:a67:e44f:: with SMTP id n15mr6297670vsm.116.1544473539602;
 Mon, 10 Dec 2018 12:25:39 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-8-t.gummerer@gmail.com>
In-Reply-To: <20181209200449.16342-8-t.gummerer@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 10 Dec 2018 12:25:28 -0800
Message-ID: <CABPp-BG9vjXF-entmun4+dMoOsZdjMgotSOtUUeNxO8c2VwgXA@mail.gmail.com>
Subject: Re: [PATCH 7/8] checkout: allow ignoring unmatched pathspec
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 9, 2018 at 12:05 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> Currently when 'git checkout -- <pathspec>...' is invoked with
> multiple pathspecs, where one or more of the pathspecs don't match
> anything, checkout errors out.
>
> This can be inconvenient in some cases, such as when using git
> checkout from a script.  Introduce a new --ignore-unmatched option,
> which which allows us to ignore a non-matching pathspec instead of
> erroring out.
>
> In a subsequent commit we're going to start using 'git checkout' in
> 'git stash' and are going to make use of this feature.

This makes sense, but seems incomplete.  But to explain it, I think
there's another bug I need to demonstrate first because it's related
on builds on it.  First, the setup:

  $ echo foo >subdir/newfile
  $ git add subdir/newfile
  $ echo bar >>subdir/newfile
  $ git status
  On branch A
  Changes to be committed:
    (use "git reset HEAD <file>..." to unstage)

      new file:   subdir/newfile

  Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
    (use "git checkout -- <file>..." to discard changes in working directory)

      modified:   subdir/newfile

Now, does it do what we expect?

  $ git checkout HEAD -- subdir/newfile
  error: pathspec 'subdir/newfile' did not match any file(s) known to git

This is the old overlay behavior; kinda lame, but you made no claims
about fixing the default behavior.  What about with your new option?

  $ git checkout --no-overlay HEAD -- subdir
  $ git status
  On branch A
  nothing to commit, working tree clean

Yes, the feature seems to work as advertised.  However, let's try
again with a different variant:

  $ echo foo >subdir/newfile
  $ git checkout --no-overlay HEAD -- subdir
  $ git status
  On branch A
  Untracked files:
    (use "git add <file>..." to include in what will be committed)

      subdir/newfile

Why is the file ignored and left there?  Also:

  $ git checkout --no-overlay HEAD -- subdir/newfile
  error: pathspec 'subdir/newfile' did not match any file(s) known to git

That seems wrong to me.  The point of no-overlay is to make it match
HEAD, and while subdir/newfile doesn't exist in HEAD or the index it
does match in the working tree so the intent is clear. But let's say
that the user did go ahead and specify your new flag:


  $ git checkout --no-overlay --ignore-unmatch HEAD -- subdir/newfile
  $ git status
  On branch A
  Untracked files:
    (use "git add <file>..." to include in what will be committed)

      subdir/newfile

  nothing added to commit but untracked files present (use "git add" to track)

So now it avoids erroring out when the user does more work than
necessary, but it still misses appropriately cleaning up the file.
