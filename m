Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8290D1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 18:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeJZChb (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 22:37:31 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41815 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbeJZChb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 22:37:31 -0400
Received: by mail-oi1-f195.google.com with SMTP id i10-v6so4654593oik.8
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 11:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=cdt/G7F00yvmo+Hu1AyfhqMFknRffzekGd5js65+avs=;
        b=14nWoutTipfKbiJUZnQ9RI/YQe3VW9JYpLPkJVV41kA9Uhyqufz6ZDR71E9o/AZRlP
         rDSuZ0xa3gu7TJoL0BQY3QG4u7dEGHHtasjcNIOOjadPxvY7aclgM5/g2tTnCC3jtYKf
         jyiCRFxqx5dPL3CvngRmmWASJ1nFJIOglio2nF8qtTfJ3rlFH9Uo5GAyzdPrqLmNfKz3
         jQ8l3j9g1VLbhLU3VSokO5CWKSSH0JoQn0+Ebn+91d2qCYncei0r+m0m8JLJYZJA/0gu
         vNuke5oRDcAqwvpNwXHux+hLoMZRglPG7KaUcWiEl9dkv5GzmGOFgbv3L7FXQu0hhlsW
         tZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=cdt/G7F00yvmo+Hu1AyfhqMFknRffzekGd5js65+avs=;
        b=kvSfyS7TwHkP9PKoTdqHBNnWW/nhaLZLWLzEAEtVPou8ULLl6TwFeLuL4uWN5pUj0W
         ZcOD+SBWGQg9vH8yS0zFZ3Fl/UKBhz+ElrBR2kcgkbCcqvU56poRZUxUJTroLYFRaJBc
         PtI8KXYSSHr0MiRmsaEpzmjBp3dezcwUQp287I3b5xd2ezKFUWTlpOewz0LjDKjxGE8V
         WdjxF3KIq6SDZZ1fY8A17kGr84UO/UQ3RcAfWUxfTNh1mkEZ18BoFTjy0y7ecl8vbEEa
         K7vSCowYeN5M61lI5UjkoGk8OyjWUA2d68jcAgKy2PcHlpHVEIZwCGA2CcdjJ5czq0Pg
         o93Q==
X-Gm-Message-State: AGRZ1gKZlvnd6XAfZNmk0uIGOoNXhZD/ihWb4Zrv0b831PvrrVGnb428
        042U1NXAphuI3TlhiG6RWU4YgkZSmFyDqfbMfEHHA5Y0Lz8=
X-Google-Smtp-Source: AJdET5cfGntSx1EZ/vwU9yjxCZhXsUUr+zeMcMgCpxOj0I7GslM9giRSiGFCQig4VRhvv8zKJ0WiawTQayGToq3w7Fc=
X-Received: by 2002:aca:6854:: with SMTP id d81-v6mr186899oic.18.1540490620029;
 Thu, 25 Oct 2018 11:03:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:370b:0:0:0:0:0 with HTTP; Thu, 25 Oct 2018 11:03:39
 -0700 (PDT)
X-Originating-IP: [73.70.188.119]
In-Reply-To: <CAGw6cBvLDNtYT6vfHcxmX0S_SS1vmYVCEkSD_ixah6cGKJ4H9w@mail.gmail.com>
References: <CAGw6cBvLDNtYT6vfHcxmX0S_SS1vmYVCEkSD_ixah6cGKJ4H9w@mail.gmail.com>
From:   Michael Forney <mforney@mforney.org>
Date:   Thu, 25 Oct 2018 11:03:39 -0700
Message-ID: <CAGw6cBvaC+TEOM9Tjdbs5zkz2hzW4649=4rsAo58cNOVHOQS=Q@mail.gmail.com>
Subject: Re: Confusing behavior with ignored submodules and `git commit -a`
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-03-16, Michael Forney <mforney@mforney.org> wrote:
> Hi,
>
> In the past few months have noticed some confusing behavior with
> ignored submodules. I finally got around to bisecting this to commit
> 5556808690ea245708fb80383be5c1afee2fb3eb (add, reset: ensure
> submodules can be added or reset).
>
> Here is a demonstration of the problem:
>
> First some repository initialization with a submodule marked as ignored.
>
> $ git init inner && git -C inner commit --allow-empty -m 'inner 1'
> Initialized empty Git repository in /tmp/inner/.git/
> [master (root-commit) ef55bed] inner 1
> $ git init outer && cd outer
> Initialized empty Git repository in /tmp/outer/.git/
> $ git submodule add ../inner
> Cloning into '/tmp/outer/inner'...
> done.
> $ echo 1 > foo.txt && git add foo.txt
> $ git commit -m 'outer 1'
> [master (root-commit) efeb85c] outer 1
>  3 files changed, 5 insertions(+)
>  create mode 100644 .gitmodules
>  create mode 100644 foo.txt
>  create mode 160000 inner
> $ git config submodule.inner.ignore all
> $ git -C inner commit --allow-empty -m 'inner 2'
> [master 7b7f0fa] inner 2
> $ git status
> On branch master
> nothing to commit, working tree clean
> $
>
> Up to here is all expected. However, if I go to update `foo.txt` and
> commit with `git commit -a`, changes to inner get recorded
> unexpectedly. What's worse is the shortstat output of `git commit -a`,
> and the diff output of `git show` give no indication that the
> submodule was changed.
>
> $ echo 2 > foo.txt
> $ git status
> On branch master
> Changes not staged for commit:
>   (use "git add <file>..." to update what will be committed)
>   (use "git checkout -- <file>..." to discard changes in working directory)
>
>         modified:   foo.txt
>
> no changes added to commit (use "git add" and/or "git commit -a")
> $ git commit -a -m 'update foo.txt'
> [master 6ec564c] update foo.txt
>  1 file changed, 1 insertion(+), 1 deletion(-)
> $ git show
> commit 6ec564c15ddae099c71f01750b4c434557525653 (HEAD -> master)
> Author: Michael Forney <mforney@mforney.org>
> Date:   Fri Mar 16 20:18:37 2018 -0700
>
>     update foo.txt
>
> diff --git a/foo.txt b/foo.txt
> index d00491f..0cfbf08 100644
> --- a/foo.txt
> +++ b/foo.txt
> @@ -1 +1 @@
> -1
> +2
> $
>
> There have been a couple occasions where I accidentally pushed local
> changes to ignored submodules because of this. Since they don't show
> up in the log output, it is difficult to figure out what actually has
> gone wrong.
>
> Anyway, since the bisected commit (555680869) only mentions add and
> reset, I'm assuming that this is a regression and not a deliberate
> behavior change. The documentation for submodule.<name>.ignore states
> that the setting should only affect `git status` and the diff family.
> In terms of my expectations, I would go further and say it should only
> affect `git status` and diffs against the working tree.
>
> I took a brief look through the relevant sources, and it wasn't clear
> to me how to fix this without accidentally changing the behavior of
> other subcommands.
>
> Any help with this issue is appreciated!

I accidentally pushed local changes to ignored submodules again due to this.

Can anyone confirm whether this is the intended behavior of ignore? If
it is, then at least the documentation needs an update saying that
`commit -a` will commit all submodule changes, even if they are
ignored.
