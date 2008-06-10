From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: freedesktop.org not really up to date?
Date: Tue, 10 Jun 2008 17:03:28 +0200
Message-ID: <200806101703.29571.jnareb@gmail.com>
References: <484E7CAE.4040403@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Jun 10 17:05:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K65Oi-00010M-Ea
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 17:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054AbYFJPDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 11:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753436AbYFJPDh
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 11:03:37 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:22970 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330AbYFJPDf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2008 11:03:35 -0400
Received: by an-out-0708.google.com with SMTP id d40so615585and.103
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=xDeH67phTEYUjNkwmeqWwUMQ/nVmtT/1SSAo8blzWpY=;
        b=JepRKB1kdgHnW/VHGulBxk8Sm3BrXRsvvVzJoGZvYdKRBGLmgaDXkWRDFkKz4kwu/D
         Z/IFEAVWJjSbw8DaTDa5q7sS6TIoURpBcK7/ePFUpGat2S/Afsi+yEjGIlYx9cYWNaYN
         pEa9M1Ao3TPvWZiS3ZzRzTsGY+DqgJEc3EU+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=MrHqY9CWQqlBbv1SdvH9Pg67KCNqNJ40yvUj3q6nI3/k0pkdNpC5hgL/QDvCRcYStk
         fZBsNqxE74QFCluJD0kQpY/VJFxraGcr0m8ffTLkKux/RtuLGs4JWSFQaIZE6EMGEGnC
         A9YvYJVE3Tdu94lalVugBikOmJ7ZIEIdnmoyE=
Received: by 10.100.242.20 with SMTP id p20mr5643162anh.14.1213110214745;
        Tue, 10 Jun 2008 08:03:34 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.192.165])
        by mx.google.com with ESMTPS id j13sm1827998rne.0.2008.06.10.08.03.31
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Jun 2008 08:03:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <484E7CAE.4040403@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84513>

On Tue, 10 Jun 2008, Andreas Ericsson wrote:

> I just stumbled across this freedesktop.org site from 2007-06-03:
> http://www.freedesktop.org/wiki/Infrastructure/git/UIFlaws
> 
> It seems to me that since then most of the issues have been worked
> out.  Are any of them still valid points? If so, which ones and how
> should we go about addressing them?

See below for detailed response.  It looks like all, or almost all 
issues got addressed...
 
> Jakub Cc'd as he was the last one to edit the (now immutable) wiki
> page. 

I wonder why it was made immutable (static page)... errr, it is not 
immutable, you just are required to login to edit.

Below detailed analysis of the contents of the page

-------------------------------------------------------------------
Infrastructure/git/UIFlaws:

> This page attempts to document the most egregious git UI offenses,
> in the hope that they'll get fixed someday. It would be pleasant if
> git had a bugzilla. In git's defence, 1.5 appears to be making great
> strides towards usability.   

I'm not sure if having bug tracker would help.  Git development works 
quite well with RelNotes, git mailing list and its searchable archives.

> * git-revert will refuse to back out multi-parent commits, ie, merges.
>   The obvious behaviour is to do basically what 
>      git-show [commit] | patch -p1 -R
>   would do, ie, roll back the tree state to the branch you came from.

Git has now "-m <parent-number>|--mainline <parent-number>" option to 
git-cherry-pick and git-revert, which would allow to revert merge 
commit.  You usually don't want to do this, by the way.

> * "git rebase foo" is a noop, when foo is the name of local branch.
>    You would expect it to fetch the branch named foo from upstream,
>    and rebase your foo branch on top of it.

Use "git pull --rebase" for this.

You wouldn't expect "git merge" to _fetch_ from upstream (would you?), 
so why "git rebase" would be expected to fetch?

> * git-fetch requires that the branch be named on both sides of the :.
>   It should treat foo as an alias for foo:foo. 

>From git-fetch(1) manpage:

   Some short-cut notations are also supported
   [...]

   *  A parameter <ref> without a colon is equivalent  to  <ref>:  when
      pulling/fetching,  so  it  merges  <ref>  into the current branch
      without storing the remote branch anywhere locally

There was discussion on git mailing list on changing this default, but 
among others backward compatibility prevents it.  That and the fact 
that current behavior makes most sense (usually with git-pull, not 
git-fetch) for one-shot fetches; if you want to contact given 
repository periodically, you would set up remote configuration (using 
git-remote for example) and wouldn't use refspecs anyway.

> * git-rebase claims you should git-rebase --continue after you fix up
>   the merges; it really means you should git-update-index followed by
>   git-rebase --continue.

(Actually now it is git-add, not git-update-index).

I don't know if it changed.  There was recurring idea about adding 
"git resolved" command, but it was never implemented, probably because 
it would add another comand to already large set, an that its name and 
a bit semantic were not sufficiently clear.  git-mergetool should 
reduce occurences where you have to manually git-add before continuing 
rebase.

> * The command to merge branch B onto branch A is not git-merge A B.
>   Instead it's git-checkout A && git-pull . B.

It _cannot_ be "git merge A B", as there can be conflicts, so one side 
_has_ to be checked out.  But nowadays "git checkout A && git merge B"
is enough, and you don't have to use bit cryptic "git pull . B" syntax.

> * There is no way to tell git-fetch (or therefore git-pull) to grab
>   all newly available branches. You have to ask for them by two names
>   (as above), and then there's no way to get those names automatically
>   into your remotes list (also as above).

With globbing refspecs it is now possible.

> * git pull's default behaviour on a branch is unhelpful: even when
>   there is an explicit Pull: branch1:branch1 line, a git pull with
>   branch1 checked out will still pull in master.

You can now use branch configuration to avoid this confusion, I think.

> * Fundamentally, the entire approach of making the UI painful to deal
>   with and forcing the user to deal with all the warts (instead of
>   just making the hairy low-level commands available), because people
>   will write nice wrappers around it, is the same reason people
>   laughed at tla, and still do.

Errr, what?!?  The idea never was to make UI horrible.  The idea was 
bottom-up approach, building low-level plumbing first, and evolving 
porcelain commands next (with a bit of help from Cogito...).

> * The index should be second-class, i.e. no -a flags to avoid the
>   index.

Well, Linux and Junio disagree.  

Beside, having index visible is useful, and sometimes necessary.

> * branch:branch-origin (or something) should be the default pull.

"git remote add <name> <url>" sets up globbing refspec in the form
'refs/heads/*:refs/remotes/<name>/*'.  

"origin" remote is default remote ("git pull"), but you can set 
different remotes, even per branch default remotes.

I don't know which of this thing author wanted to have.

> * branch:branch should be the default push for all branches, but only
>   push the current branch unless a flag is added.

Long discussion on git mailing list about "git push --current" vs 
"git push --matching" and which should be the default.  You can push 
current branch now with "git push <remote> HEAD" (or I think even with 
"git push HEAD"), changing the default for the backwards compatibility 
reasons would have to wait, even if we agree that it is a good change.

> * An update command should be created that:
>      o fetches the current branch's upstream to its -origin locally
>        (or all branches, perhaps); 
>      o merges the current branch origin to the branch locally;
>      o commits if it was a fast-forward, and leaves uncommitted
>        diffs otherwise. 

There is "git remote update", there are globbing refspecs, there is (or 
would be) --ff / --ff=only option and --no-commmit option... what I am 
not sure if the workflow described is actually useful... especially 
with easy rollback in "git reset --hard ORIG_HEAD" and "git commit 
--amend" at fingertips.

-- 
Jakub Narebski
Poland
