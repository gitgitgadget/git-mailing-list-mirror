From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: command prompt script for current branch
Date: Wed, 06 Feb 2008 13:09:50 -0800 (PST)
Message-ID: <m3r6fp4wrt.fsf@localhost.localdomain>
References: <9b3e2dc20802061152q63bc61acuaecf3f33d4df8b19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen Sinclair" <radarsat1@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 22:10:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMrXL-0002aT-Jk
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 22:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756683AbYBFVJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 16:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756634AbYBFVJz
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 16:09:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:3417 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756683AbYBFVJx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 16:09:53 -0500
Received: by ug-out-1314.google.com with SMTP id z38so527337ugc.16
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 13:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=5tknWEQNQ1+ezDHk2Y69oEW1S+3VhSfNAoFxIFZeQbw=;
        b=fOkBBYyEUtaNHYG9MHNKVrD2e4RwhVkvhhbr2EOYL2dNe0ouWuEDj07HY+uUt1k0K39+G3vBwBVX4wfAEqQVzNKf8vOwJsiyQss84o9fiYx+VOZwFIe0HnaSdCEs7Lj2eew/kIH40O33Ifq1zH5rVA6rYAko5t+X7mEeEhMbjeE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=COtOCugJtize110Xq8YT/PrtHT4/c4vsNOD7aKFarW8UgS9um1AfVh4FSC07g+UyoEBzomlxHrBMMvsVOAh17GClr5ZILThV7bwSIwAv9kFJNJrf7sgB7tbJdjzbbHqPcAi3M5WCs2+M+0Qquk2fMwah77SEOMGUKyQX77N78ds=
Received: by 10.78.204.7 with SMTP id b7mr18644553hug.74.1202332191449;
        Wed, 06 Feb 2008 13:09:51 -0800 (PST)
Received: from localhost.localdomain ( [83.8.239.145])
        by mx.google.com with ESMTPS id z33sm8055117ikz.0.2008.02.06.13.09.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Feb 2008 13:09:50 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m16L9ijt015631;
	Wed, 6 Feb 2008 22:09:44 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m16L9gDu015628;
	Wed, 6 Feb 2008 22:09:42 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <9b3e2dc20802061152q63bc61acuaecf3f33d4df8b19@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72855>

"Stephen Sinclair" <radarsat1@gmail.com> writes:

> Attached is a script I quickly wrote up yesterday.  Sometimes I've
> found I started working only to realize I was on the wrong branch.
> (Now that I'm accustomed to working with git, I make many small
> branches, so it happens.)

First, it is much better to put such script inline, in the body of
your email.  This makes commenting about script body much easier.
And if you have to attach it, for example because your mailer mangles
whitespace (which is not the case here), make sure that attachement
uses "text/plain", and if possible "inline" disposition, to better
_view_ the code without need to save it to temporary file.

I would take an exeption and comment on your code, even though you
make it hard to do so.


Second, there are numerous examples on how to create git-aware
prompt.  Those include code in contrib/completion/git-completion.bash
in git sources:

#    4) Consider changing your PS1 to also show the current branch:
#        PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
#
#       The argument to __git_ps1 will be displayed only if you
#       are currently in a git repository.  The %s token will be
#       the name of the current branch.

and the _git_ps1 file in sources of "Git In Nutshell", with git
repository at http://git.jonas.iki.fi/git_guides.git; this code
by yours truly is heavily commented to make it easier to understand.
I'm not sure if it is included in "Git In Nutshell" 
(http://jonas.iki.fi/git_guides).

I have put the _git_ps1 code at the end of this post.

> So I made this small script to simply write the name of the currently
> checked out branch, as well as information on how many commits it
> differs from the remote tracking branch, if any.
> It also appends an exclamation mark if I have uncommitted changes.  I
> stuck it in my PS1 environment variable, so that it would be part of
> my command prompt.

Third, the information on how many commits it differes from coupled
remote tracking branch is not that fast to get; additionally you don't
always _have_ coupled remote tracking branch.  For me the number of
commits current branch differs from origin repo, and "dirtiness" of
branch are not important, while working with detached HEAD and marking
branches which are StGit controlled is.

> -- >8 --
> #!/bin/bash
>
> # exit if not a git repo
> if ! (git branch >/dev/null 2>&1); then
>     exit
> fi

There are much better ways to do this; it is usually much better to
use plumbing (engine) commands in scripts, not porcelain, which is
meant for user interaction. See code in _git_ps1

Besides, why do you run git-branch _twice_?
 
> BRANCH=$(git branch | grep \* | sed s,\*\ ,, )

There is much better way to do this with plumbing.

> REMOTE=$(git config --list | grep branch.$BRANCH.remote 2>/dev/null | cut -f2 -d=)
> MERGE=$(git config --list | grep branch.$BRANCH.merge 2>/dev/null | sed s,^.*=refs/heads/,,)

Why do you use "git config --list" then grep for key, instead of
asking git-config to return results for given key with 
"git config --get" or "git config --get-all"?

By the way, when you use grep you should quote '.', as '.' means any
character in regular expression. You do not need put regular
expression (parameter to grep) in double quotes _only_ because
refnames (and branchnames) cannot contain spaces.

Your code wouldn't be able to deal with being on detached HEAD.

> # exit if no branch found
> if [ "${BRANCH}"x == x ]; then
>     exit
> fi

This is mixture of coding for portability with bash-isms; either use
'test' instead of '[', or use '-z' operator.

> echo -n ' '[$BRANCH
>
> # dirty state
> if [ "$(git-diff-index --name-only HEAD)"x != x ]; then
>     echo -n \!
> fi

Err... if you want to check if there are differences, it would be
better to use '--quiet' (which implies '--exit-code') and check for
exit code instead of checking if there was any output.

BTW. there is slight inconsistency in using dashed (git-diff-index)
and dashless (git branch) of diff commands.  In "external" script
which does not source git shell script "library", it is better to use
dashless form.
 
> # exit if no remote tracking branch found
> if [ ${REMOTE}x == x -a ${MERGE}x == x ]; then
>     echo ]
>     exit
> fi
> 
> # Uncomment this line to ignore remote tracking branches
> # echo ]; exit
> 
> # calc number of revs between remote and local
> FWDREVS=$(git rev-list $REMOTE/$MERGE..$BRANCH 2>/dev/null 2>&1 | wc -l)
> 
> # and the other way, in case it is not up to date
> BACKREVS=$(git rev-list $BRANCH..$REMOTE/$MERGE 2>/dev/null 2>&1 | wc -l)
> 
> echo -n ' '-\> $REMOTE/$MERGE
> 
> if [ $FWDREVS -gt 0 ]; then
>     echo -n +$FWDREVS
> fi
> 
> if [ $BACKREVS -gt 0 ]; then
>     echo -n -$BACKREVS
> fi
> 
> echo ]

Why do you use sequence of "echo -n", instead of setting variables,
perhaps with the help of some more advanced constructs like in example
below, then using one "echo" to output it all?

-- >8 --
function _git_ps1()
{
	# 'git_dir' is absolute path to git repository
	# 'rel' is path relative to top dir in repository
	# 'br' is current branch name, or 'HEAD' if we are on detached HEAD
	local git_dir rel br

	# first call to git-rev-parse also checks if we are inside git
	# repository; if we are not in git repository, use default prompt,
	# provided as an argument
	rel=$(git rev-parse --show-prefix 2>/dev/null) || \
		{ echo "$@" ; return; }
	rel=${rel%\/}

	# get branch name, strip 'refs/heads/' prefix,
	# and use 'HEAD' for detached HEAD (no branch name)
	br=$(git symbolic-ref HEAD 2>/dev/null)
	br=${br#refs/heads/}
	br=${br:-HEAD}

	# path to top dir of git repository
	loc=${PWD%/$rel}

	# the following code is important only if you use StGit,
	# to note if you are on StGit controlled branch;
	# use second part of conditional if you don't use StGit
	git_dir=$(git rev-parse --git-dir)
	if [ "$br" -a -e "$git_dir/patches/$br" ]; then
		echo "$br:${loc/*\/}${rel:+/$rel}# "
	else 
		echo "$br:${loc/*\/}${rel:+/$rel}> "
	fi
}

## bash:
## set PS1 only if we are in interactive shell (PS1 is set)
#    [ "$PS1" ] && PS1='$(_git_ps1 "\u@\h:\w> ")'

## zsh:
#	function precmd() {
#		PS1=`_git_ps1 '%m:%~%# '`
#	}
# vim:filetype=sh

 
-- 
Jakub Narebski
Poland
ShadeHawk on #git
