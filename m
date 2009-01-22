From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: Short rant about git usability - make 'git clone' work on an 
	empty remote repository
Date: Thu, 22 Jan 2009 12:01:12 +0100
Message-ID: <237967ef0901220301p47dab7d7hdbf2dccd04a99f16@mail.gmail.com>
References: <20090122100230.GA9653@amd.home.annexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Richard W.M. Jones" <rjones@redhat.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 12:02:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPxKZ-000695-DC
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 12:02:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbZAVLBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 06:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753333AbZAVLBP
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 06:01:15 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:65119 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbZAVLBO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 06:01:14 -0500
Received: by ey-out-2122.google.com with SMTP id 22so787834eye.37
        for <git@vger.kernel.org>; Thu, 22 Jan 2009 03:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=38eLJvviJywjLe4/EVYqp3j8LpAN5Be/MNj0Fwi8fLw=;
        b=aB+9cWZwysJELLp90nHZ47lrOEtkwdqJF9vn9+Vn3OsAOwpv9MOEwdaHMQgiBLJ5Ls
         tNeaEhR3SYol9KfpiETAfMAANhnvOBm3q3QNJHRZ65CpZLYKtnaE43XtwE0qMD6glOLZ
         n5Yk1gpGTNAx5XGGfxMSjKv7E0DUB/rpfsgsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=O9nk2nf5qReyk+V29J0MTu2dDG+HUZSOE/dUwCf1otFGM22Xw6V/dhObJVnzXbwOMW
         0P+RfnwWgeXaZlzs1i8UAhXDgnBkt30ZAldrA9DuAyXuPPG6RRo+XBfKtIGAvsT+8TAs
         BFGo4UTcn6gS3ioU8z6oBnM1l4vIolgAef2AY=
Received: by 10.210.28.4 with SMTP id b4mr616048ebb.120.1232622072572; Thu, 22 
	Jan 2009 03:01:12 -0800 (PST)
In-Reply-To: <20090122100230.GA9653@amd.home.annexia.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106744>

2009/1/22 Richard W.M. Jones <rjones@redhat.com>:
> This is a rant, those offended by rants should stop reading now.
>
> When I want to check out a remote repository, I do:
>
>  git clone URL...
>
> Except when the repository is empty, when for no explicable reason
> this familiar command doesn't work.
>
>  $ git clone git+ssh://rwmj@git.ocamlcore.org/gitroot/ocaml-autoconf/ocaml-autoconf.git
>  Initialized empty Git repository in /home/rjones/d/ocaml-autoconf/.git/
>  fatal: no matching remote head
>
>  $ git init ocaml-autoconf
>  usage: git init [-q | --quiet] [--bare] [--template=<template-directory>] [--shared[=<permissions>]]
>  $ mkdir ocaml-autoconf
>  $ cd ocaml-autoconf
>  $ git init
>  Initialized empty Git repository in /home/rjones/d/ocaml-autoconf/.git/
>  $ ls
>  $ ls -a
>  .  ..  .git
>
> Following advice on a website ...
>
>  $ git-remote origin git+ssh://rwmj@git.ocamlcore.org/gitroot/ocaml-autoconf/ocaml-autoconf.git
>  error: Unknown subcommand: origin
>  usage: git remote
>     or: git remote add <name> <url>
>     or: git remote rm <name>
>     or: git remote show <name>
>     or: git remote prune <name>
>     or: git remote update [group]
>
>      -v, --verbose         be verbose
>
>  $ git remote add origin git+ssh://rwmj@git.ocamlcore.org/gitroot/ocaml-autoconf/ocaml-autoconf.git
>
>  $ git status
>  # On branch master
>  #
>  # Initial commit
>  #
>  nothing to commit (create/copy files and use "git add" to track)
>  $ git branch
>  $ git checkout
>  fatal: You are on a branch yet to be born
>  $ git status
>  # On branch master
>  #
>  # Initial commit
>  #
>  nothing to commit (create/copy files and use "git add" to track)
>  $ echo test > README
>  $ git commit -a
>  # On branch master
>  #
>  # Initial commit
>  #
>  # Untracked files:
>  #   (use "git add <file>..." to include in what will be committed)
>  #
>  #     README
>  nothing added to commit but untracked files present (use "git add" to track)
>  $ git add README
>  $ git commit -a
>  Created initial commit 2c9a63a: Create repository.
>   1 files changed, 1 insertions(+), 0 deletions(-)
>   create mode 100644 README
>
>  $ git push
>  No refs in common and none specified; doing nothing.
>  Perhaps you should specify a branch such as 'master'.
>  fatal: The remote end hung up unexpectedly
>  error: failed to push some refs to 'git+ssh://rwmj@git.ocamlcore.org/gitroot/ocaml-autoconf/ocaml-autoconf.git'
>  $ git push master
>  fatal: 'master': unable to chdir or not a git archive
>  fatal: The remote end hung up unexpectedly
>  $ git branch master
>  fatal: A branch named 'master' already exists.

$ man git-push
$ git push origin master
