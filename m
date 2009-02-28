From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-svn, and which branch am I on?
Date: Sat, 28 Feb 2009 09:14:29 -0800 (PST)
Message-ID: <m38wnqv5zh.fsf@localhost.localdomain>
References: <87ljrr7xof.fsf@rimspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Pittman <daniel@rimspace.net>
X-From: git-owner@vger.kernel.org Sat Feb 28 18:16:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdSnE-0007tv-7E
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 18:16:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbZB1ROe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 12:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbZB1ROe
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 12:14:34 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:23887 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbZB1ROd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 12:14:33 -0500
Received: by fg-out-1718.google.com with SMTP id 16so772241fgg.17
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 09:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=pTaxHIqIfTfQ8UxDSkXub1LTNENS9E2nbAQJUTjQZHs=;
        b=jeOhDvzp8SzH2q6WtWV47CUBIu/I78Il7VmGQhyou66tleWpwBXP+vnpyU84fyD9W1
         RHlliuzmzJDtAieYAew0Pi+H6lmLGK89Pn/TJ5jmLSnXg/oneOixcDERfbi17CmKyGTx
         x+Q94hM/TcAWU/S/StVJVZj0xw9MxTYvX9rlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=eTCpkM6JY0dUuPxBBLX69JF7Yb8g+UQr4muR+z9IpyzB7kymwmWEl2kWI7ZbsjgAbU
         d/2SSgavIJS63C2+ykjW1VTR+aiyK9CYOod4kkIZzlBS4HjK1u5iJzsyfnBx5OI1V015
         dmHnxn4JajQxBCnOpg+IxDx4375+R4062sRks=
Received: by 10.86.28.2 with SMTP id b2mr7455fgb.75.1235841270070;
        Sat, 28 Feb 2009 09:14:30 -0800 (PST)
Received: from localhost.localdomain (abwe96.neoplus.adsl.tpnet.pl [83.8.228.96])
        by mx.google.com with ESMTPS id l12sm8565444fgb.51.2009.02.28.09.14.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Feb 2009 09:14:29 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n1SHESo0028676;
	Sat, 28 Feb 2009 18:14:29 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n1SHERKu028673;
	Sat, 28 Feb 2009 18:14:27 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <87ljrr7xof.fsf@rimspace.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111776>

Daniel Pittman <daniel@rimspace.net> writes:

> The general question was: in git, how do I identify where this branch
> came from?

In general, you cannot. In specific cases, you can.
See below for details.
 
> Specifically, this was about 'git svn', but also generally how to
> identify this information in git.
> 
> So, with a repository branch layout like this:
> 
>   master        (local)
>   testing       (local)
>   trunk         (remote)
>   v100          (remote)
> 
> How would I find out which remote branch master and trunk came from?
> 
> 
> To restate that, because I am not sure if that is clear, given this
> layout of branches:
> 
>      trunk (remote)
>      |
>  o---o---o---o---o  branch master
>   \
>    \
>     o---o---o---o branch testing
>     |
>     v100 (remote)
> 
> How can I identify that 'testing' came from the 'v100' branch, and that
> master came from the 'trunk' branch?
> 
> 
> Ideally, I would like to work this out on the command line, without
> needing to reference gitk or another graphical tool, but even a solution
> that used them would be fine.

[...]
> ...and, finally, is the reason that I am finding it hard to explain this
> because I have an expectation of how things work that doesn't match up
> with git?  In other words, is the question actually meaningless?

On the plumbing level, or on the level of graph of commits, git does
not store information "where this branch came from".  For git, from
the point of view of commit objects, the following two pictures are
totally equivalent (by design):

        /-o---o      branch a
       /
  o---*---o---o---o  branch b

and
  
  o---*---o---o      branch a
       \
        \-o---o---o  branch b

What you _can_ get on this level is to find common ancestor (or common
ancestors) of branches 'a' and 'b', using "git merge-base a b"; this
would return commit marked '*'.


However, when creating a branch, you can tell git that you want for
newly created branch to track branch you are based on (with --track)
option.  By default saving tracking information is done when branching
off remote-tracking branches.

>From git-branch(1):

  When a local branch is started off a remote branch, git sets up the
  branch so that 'git-pull' will appropriately merge from
  the remote branch. This behavior may be changed via the global
  `branch.autosetupmerge` configuration flag. That setting can be
  overridden by using the `--track` and `--no-track` options.

  [...]

  --track::
      When creating a new branch, set up configuration so that 'git-pull'
      will automatically retrieve data from the start point, which must be
      a branch. Use this if you always pull from the same upstream branch
      into the new branch, and if you don't want to use "git pull
      <repository> <refspec>" explicitly. This behavior is the default
      when the start point is a remote branch. Set the
      branch.autosetupmerge configuration variable to `false` if you want
      'git-checkout' and 'git-branch' to always behave as if '--no-track' were
      given. Set it to `always` if you want this behavior when the
      start-point is either a local or remote branch.

And git-config(1)

  branch.<name>.remote::
      When in branch <name>, it tells 'git-fetch' which remote to fetch.
      If this option is not given, 'git-fetch' defaults to remote "origin".

  branch.<name>.merge::
      When in branch <name>, it tells 'git-fetch' the default
      refspec to be marked for merging in FETCH_HEAD. The value is
      handled like the remote part of a refspec, and must match a
      ref which is fetched from the remote given by
      "branch.<name>.remote".
      The merge information is used by 'git-pull' (which at first calls
      'git-fetch') to lookup the default branch for merging. Without
      this option, 'git-pull' defaults to merge the first refspec fetched.
      Specify multiple values to get an octopus merge.
      If you wish to setup 'git-pull' so that it merges into <name> from
      another branch in the local repository, you can point
      branch.<name>.merge to the desired branch, and use the special setting
      `.` (a period) for branch.<name>.remote

In this case you can get _name_ of the branch this branch "came from"
with "git config branch.<branchname>.merge".

HTH.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
