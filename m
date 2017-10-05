Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC5171F600
	for <e@80x24.org>; Thu,  5 Oct 2017 19:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751766AbdJETdl (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 15:33:41 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:54089 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbdJETdk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 15:33:40 -0400
Received: by mail-qt0-f180.google.com with SMTP id 47so27456120qts.10
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 12:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OcI5JyOQCASzNy/CzoYhFX2Z99Vb5+oxgd4kLM0Rh90=;
        b=wNtE5VZg6yJpFfynrxlU8krpuGWE1GnNYWL0iK6UgFs3TFs34zlGqpH24hMwbS7jjg
         diuM8ZOIfUXLq5eWZLGQaS95DcUQP/vWvsMJGMB40lwutGvMW4KPbIH8ZyrsMiKIrwtv
         wyuVZ0RVtT2C3k85Yy/DT2p29XjhUGBqIjFDTYzU5DL2vLECuufgn9/O2nVo10F9Fk/T
         OLyLFzUhljFP37+9W2d3s6wAdaH7xKurW05ThB+NgvPHaA7uN5mybInM/OpzcQgCx3GJ
         0bEJ4h0kSfT2vuVbLM1I7rtgLV9RZrxcIkmqjbI4jHZxteOJW9huv8887b/4SLhy10IE
         A02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OcI5JyOQCASzNy/CzoYhFX2Z99Vb5+oxgd4kLM0Rh90=;
        b=RkcDq7mZVN3iarllLXKy5bT4wtzKSSUc6LSGmve79FERl+KY9Xo+FYScMIBIgiv/as
         qiPOpdu7pF6aFYB2QfItiiM50x4y2isESk/wLGM6QD/Ktv+SAv4zrQ8qr87cF2k9RPh1
         BgDxlJWzzZPtOZ8P8uOt/6s/0+oaeyI+8b1QJK/9MckT4tb60830NBD30XQVfVf4v63C
         epHpjTbP6OF6ZbOWm7c3MhOeSUaE5EgF/2iG1SbkXs+riUDYWzDPZIzXT8/VPOlk91ts
         d1y9VvysjF3OLjpVp4MEJltQ/vox1kwwUoOr4Psw2he+yC7aflWPvwPO1H3iq6rYDPRb
         nCwQ==
X-Gm-Message-State: AMCzsaWNn4UjS5wrduQ7p9Av4GDNg1PRuck5iYpwDfpr16Z4hcoRs8Wj
        D3Z3J+YV1S89gIaX47OYUqZJAbjPLVkSxjFvkJmZa4hXGoo=
X-Google-Smtp-Source: AOwi7QCsooCTMLeD7wSpJEtMQkiax8cn4rep/bgoqawCO8hrfmfO6dXFxz+kbOuDbvyXvknLZ+8GezCMdHdtgPaRxxA=
X-Received: by 10.200.41.89 with SMTP id z25mr25988606qtz.79.1507232019553;
 Thu, 05 Oct 2017 12:33:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Thu, 5 Oct 2017 12:33:38 -0700 (PDT)
In-Reply-To: <c6b52120-98bf-d685-6dc0-3c83e9e80d30@kdbg.org>
References: <c6b52120-98bf-d685-6dc0-3c83e9e80d30@kdbg.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 5 Oct 2017 12:33:38 -0700
Message-ID: <CAGZ79kbr=zBc5GEL7hYyCnBcbdE8ZRp65QwxKMUVsQ+qXvRAAw@mail.gmail.com>
Subject: Re: [PATCH/RFC] git-post: the opposite of git-cherry-pick
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 5, 2017 at 12:13 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Add a new command that can be used to copy an arbitrary commit
> to a branch that is not checked out.

Cool. :)

>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  I have been using this command since years, but got around to
>  write a man page and tests only now. I hope the man page makes
>  sense. I don't have the tool chain to build it, though, so
>  any hints for improvement are welcome.
>
>  .gitignore                        |  1 +
>  Documentation/git-cherry-pick.txt |  3 +-
>  Documentation/git-post.txt        | 57 +++++++++++++++++++++++++++++
>  Makefile                          |  1 +
>  command-list.txt                  |  1 +
>  git-post.sh                       | 60 ++++++++++++++++++++++++++++++
>  t/t3514-post.sh                   | 77 +++++++++++++++++++++++++++++++++++++++
>  7 files changed, 199 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/git-post.txt
>  create mode 100755 git-post.sh
>  create mode 100755 t/t3514-post.sh
>
> diff --git a/.gitignore b/.gitignore
> index 833ef3b0b7..a16263249a 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -106,6 +106,7 @@
>  /git-pack-refs
>  /git-parse-remote
>  /git-patch-id
> +/git-post
>  /git-prune
>  /git-prune-packed
>  /git-pull
> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> index d35d771fc8..6b34f4d994 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -226,7 +226,8 @@ context lines.
>
>  SEE ALSO
>  --------
> -linkgit:git-revert[1]
> +linkgit:git-revert[1],
> +linkgit:git-post[1]
>
>  GIT
>  ---
> diff --git a/Documentation/git-post.txt b/Documentation/git-post.txt
> new file mode 100644
> index 0000000000..e835e62be3
> --- /dev/null
> +++ b/Documentation/git-post.txt
> @@ -0,0 +1,57 @@
> +git-post(1)
> +===========
> +
> +NAME
> +----
> +git-post - Apply a commit on top of a branch that is not checked out

Contrasted to:
  git-cherry-pick - Apply the changes introduced by some existing commits
Some questions on top of my head:
* Do we want to emphasize the cherry-pick to say checked out?
* Is it a good design choice to have a different command, just because the
  target branch is [not] checked out?
* Naming: I just searched for synonyms "opposite of cherry-picking" and
  came up with cherry-put, cherry-post, target-commit
* What was the rationale for naming it "post" (it sounds very generic to me)?
* Does it play well with worktrees? (i.e. if a worktree has a branch checked
  out, we cannot post there, or can we?)

> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git post' dest-branch [source-rev]
> +
> +DESCRIPTION
> +-----------
> +
> +Applies the changes made by 'source-rev' (or, if not given, `HEAD`)
> +on top of the branch 'dest-branch' and records a new commit.
> +'dest-branch' is advanced to point to the new commit.
> +The operation that this command performs can be regarded as
> +the opposite of cherry-picking.
> +
> +EXAMPLES
> +--------
> +
> +Assume, while working on a topic, you find and fix an unrelated bug.
> +Now:
> +
> +------------
> +$ git commit                                   <1>
> +$ git post master                              <2>
> +$ git show | git apply -R && git reset HEAD^   <3>
> +------------
> +
> +<1> create a commit with the fix on the current branch
> +<2> copy the fix onto the branch where it ought to be
> +<3> revert current topic branch to the unfixed state;
> +can also be done with `git reset --keep HEAD^` if there are no
> +unstaged changes in files that are modified by the fix
> +
> +Oftentimes, switching branches triggers a rebuild of a code base.
> +With the sequence above the branch switch can be avoided.
> +That said, it is good practice to test the bug fix on the
> +destination branch eventually.

This is a cool and motivating example.


> +
> +BUGS
> +----
> +
> +The change can be applied on `dest-branch` only if there is
> +no textual conflict.

This is not a bug per se, it could be signaled via a return code that
the posting was unsuccessful.
