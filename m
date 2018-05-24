Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA4DB200B9
	for <e@80x24.org>; Thu, 24 May 2018 20:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969426AbeEXUu7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 16:50:59 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:44572 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966499AbeEXUu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 16:50:58 -0400
Received: by mail-yw0-f179.google.com with SMTP id p14-v6so1021897ywm.11
        for <git@vger.kernel.org>; Thu, 24 May 2018 13:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/fZ9fvbwoYM2UmZADr4kuA5dGgWludKQsiUy1hVLJfY=;
        b=JpV/mV0FYKz8XlZyNp9d20JaiF+BZcH0nDvDuL/zcyxVbYoX8gyw2Td/DcKadTBttA
         HzgOvSrRsaJQ+MVGEgpV+SxUlWWDKjHZRvs+aFl3By7GtpbFh7tGJ8ImDwfOfEb1oblg
         oj9E04IXgiEb81qA40H5uQN/DgF3z6tQbnleBEoCHY6hDFQoNn3XnN3HttvQ6hJ4lz8Q
         en3IFmx8U7gHgtiKUsyS94+Z3BgXM5dH1mLeOOIN8udYhqQZ3bWe7W6c9HgWs+dKo5zX
         nvEp9shq1Gm9SfUup0kVAFzEJcVRpJ2Oc1RTYLlFRwIxrEa23CCngPxp+bQ08MjM4tqY
         +j0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/fZ9fvbwoYM2UmZADr4kuA5dGgWludKQsiUy1hVLJfY=;
        b=pb3x0bLAtDYHfqe+2E3NE6Gth/H5x/F0xI8RautLE/IBm+CGBoFCO3MLrRvE65m3L5
         ElAL9YukqvCey18f5z9zmd9Tx//5BWTAgezX8LmpVFheLT5GC/vMXZVuoYWXPi3pwHAa
         WTko+UPDFzGSs9xnN8Y9oowKDhxuO/sSS9Vr+blzQi/d96Kx7nDsxQIRcrP1IpNxUVAq
         L1thLa6/EuyXZnuPV/PgjlQcS1M7t7WP6ycNuw3Cz/sEoN+ajFYHHVweuP7mr2PBPm7N
         QHd1jowEk93JswTX/qG/4pY4l7bLixvxq+7qL0Uh94U9itGzmHjL5eqM84tl6w15H7cf
         8pJA==
X-Gm-Message-State: ALKqPwdnMrlXDSHO8dXofn3t8hv//1PqUnmpriDg+cM/0sL6FCCgO1eV
        ERJSJiV5CCAhnAmhsC5C3iH+IwV0o9ALBdTe8NFHWHvOxlY=
X-Google-Smtp-Source: AB8JxZph9G21HJ0WEwnFW51AEtZwHhTXEEa47Of8T7VMpJ5p7BaQd6gjpPIpveGcgvcHnh4XI4YBDDCboJSycN8hDZo=
X-Received: by 2002:a81:8801:: with SMTP id y1-v6mr4939779ywf.238.1527195057291;
 Thu, 24 May 2018 13:50:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Thu, 24 May 2018 13:50:56 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.21.1805231434010.28811@localhost.localdomain>
References: <alpine.LFD.2.21.1805231434010.28811@localhost.localdomain>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 24 May 2018 13:50:56 -0700
Message-ID: <CAGZ79kavmH5KVS2Byc5+Hg3dOvVwGD11KZ3yzZTLwp8Ok9ZDTg@mail.gmail.com>
Subject: Re: "git grep" and "working tree" vs "working directory"
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 23, 2018 at 11:50 AM, Robert P. J. Day
<rpjday@crashcourse.ca> wrote:
>
>   more puzzling terminology, this time in the man page for "git grep".
> the SYNOPSIS shows, at the very end, the clearly optional
> "[<pathspec>...]",
>
>     git grep ...
>            ... snip ...
>            [--] [<pathspec>...]
>
> but nowhere in the man page is there an explanation as to the default
> value used if there is no pathspec, and here's why that's confusing.
>
>   first, what is the proper phrase for the *entire* checked out repo?

What is the *entirety* of a checked out repo?
(Is it just the main working tree, or do you mean all directories that are
found "git worktree --list" ?)

http://public-inbox.org/git/xmqqo9wy4hxa.fsf@gitster.mtv.corp.google.com
gives insights into "worktree vs working tree", the former being the command
and the latter being the directory you work in -- a working directory if you
will -- but the terminology is working tree. There was another recent discussion
on that, why it stuck with "tree".


> working tree? working directory? either? and is that the proper phrase
> to use *regardless* of where you happen to be located, perhaps in a
> subdirectory?
>
>   i did a quick test and, if i don't supply a pathspec, then "git
> grep" (quite reasonably) recursively searches only the *current*
> working directory (example from linux kernel source repo):
>
>   $ cd scripts
>   $ git grep -il torvalds --
>   checkstack.pl
>   get_maintainer.pl
>   package/mkdebian
>   $
>
> however, if you peruse the very first part of the OPTIONS section of
> that man page, you read:
>
>   --cached
>       Instead of searching tracked files in the working tree,
>       search blobs registered in the index file.
>
>   --no-index
>       Search files in the current directory that is not managed by Git.
>
>   --untracked
>       In addition to searching in the tracked files in the
>       working tree, search also in untracked files.
>
>   ... snip ...
>
> note how a couple of those options are described as searching "the
> working tree", when they clearly(?) do no such thing if you happen to
> be located in a subdirectory.

There are 2 dimensions to it:
* (where you are)
  if you run git-grep from a sub directory of the repository, then the
"sub-working-tree"
  will be searched. Extend the example from above by calling
  cd scripts
  git rm --cached checkstack.pl
  git grep -il torvalds --
  ls   checkstack.pl

* (what is searched)
  The options mentioned above specify what exactly is used as the base
for searching
  (the file system, the index, or a commit)


>   also, at the bottom of that section, one reads:
>
>   <pathspec>...
>       If given, limit the search to paths matching at least one
>       pattern. Both leading paths match and glob(7) patterns are supported.
>
>       For more details about the <pathspec> syntax, see the pathspec
>       entry in gitglossary(7).
>
> but, again, what if <pathspec> is *not* given? then what?

Assume "$pwd/."

>
>   finally, the first example has the same problem:
>
>   git grep 'time_t' -- '*.[ch]'
>       Looks for time_t in all tracked .c and .h files in the
>       working directory and its subdirectories.
>
> in "the working directory"?
>
>   what is the proper terminology to be used here?

the working directory sounds right, not sure which aspect you want to be
exposed more clearly.
