From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Which freedesktop.org "design flaws" in git are still relevant?
Date: Fri, 29 Feb 2008 13:11:15 -0800 (PST)
Message-ID: <m3hcfrjwnk.fsf@localhost.localdomain>
References: <51419b2c0802291232w166b3100yabd30ba30df6ef1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Elijah Newren" <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 29 22:12:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVCWM-0003Tv-K0
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 22:11:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbYB2VLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 16:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760994AbYB2VLU
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 16:11:20 -0500
Received: from fk-out-0910.google.com ([209.85.128.184]:36577 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760099AbYB2VLS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 16:11:18 -0500
Received: by fk-out-0910.google.com with SMTP id z23so5701874fkz.5
        for <git@vger.kernel.org>; Fri, 29 Feb 2008 13:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=+1QXlrDLDAQZbHBAi3jC63Wapb9bjwhx9HuIjhSTuFk=;
        b=hJ4tdrOUWm1hkL540Gv3AcWUxP0erBM6p2lyumi7ayuSi+5n8j2Tc6Ah/F8Ab5/haTiYuTTPZCGdqjfZlS4tFW6w0vzmv/u8U2PdaEwvT9fSRJqdxhmJ53iL0GFEq15n6IHrC58wDaNGC01vkSoc9uZWMIbBnunBf11XP3u8LnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=iX4oBiZI6UQWecLQcczJSz08Bh6Vbsr95LEHJuMLANUJOHAM9tFg+/W90AQg2g5RcpMVUBkfaE3MCInnYjJaxDqTFAc+EdxXW6RuYzO3p75LEiCGqX75yYPOztzqrKtVeIwEUTMPL5BV3x6BBgT0uQgwuITWGThbQg9ayuWItgE=
Received: by 10.82.188.15 with SMTP id l15mr9944526buf.26.1204319476559;
        Fri, 29 Feb 2008 13:11:16 -0800 (PST)
Received: from localhost.localdomain ( [83.8.217.18])
        by mx.google.com with ESMTPS id d25sm18829254nfh.33.2008.02.29.13.11.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Feb 2008 13:11:15 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1TLBEMW026418;
	Fri, 29 Feb 2008 22:11:14 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1TLBB4k026415;
	Fri, 29 Feb 2008 22:11:11 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <51419b2c0802291232w166b3100yabd30ba30df6ef1f@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75565>

"Elijah Newren" <newren@gmail.com> writes:

> The page http://www.freedesktop.org/wiki/Infrastructure/git/UIFlaws
> contains a number of claimed UI flaws of git.  I suspect that a number
> of them are out-of-date; it doesn't seem to jive with my recent
> reading of the documentation.  Could anyone point out which are still
> accurate with recent git, and which aren't?

I'll examine them point by point, and write replies when I know the
answer. Probably should correct wiki page, too...


> * git-revert will refuse to back out multi-parent commits, ie,
>   merges. The obvious behaviour is to do basically what git-show
>   [commit] | patch -p1 -R would do, ie, roll back the tree state to
>   the branch you came from.

If I remember correctly there was some work done on cherry-picking,
reverting (revert is cherry-picking reverse of a commit in the diff -R
or patch -R sense) and rebase with multiparent commits, telling which
of parent to treat. But I do not remember details.

The advice is of no use: git-show for merge (multi-parent) commits
either doesn't show diff at all, or show compact combined diff 
(diff --cc) which cannot be applied. Another issue of note is that
"git revert" does not roll back the tree state, but applies reversion
of given change, i.e. reverts / undoes given _changeset_.

> * 'git-rebase foo' is a noop, when foo is the name of local
>   branch. You would expect it to fetch the branch named foo from
>   upstream, and rebase your foo branch on top of it.

No, I would never expect git-rebase to fetch somthing. And "git rebase
<upstream>" is *not* no-op: it rebases (rebuilds) _current_ branch on
top of given branch.

To do fetch+rebase, i.e. update branch in rebase based workflow, use
"git pull --rebase".

> * git-fetch requires that the branch be named on both sides of
>   the :. It should treat 'foo' as an alias for 'foo:foo'.

>From git-fetch(1):

   - A parameter <ref> without a colon is equivalent to <ref>: when
     pulling/fetching, so it merges <ref> into the current branch
     without storing the remote branch anywhere locally

So 'foo' is treated as 'foo:' (which means fetch, and not store), and
not as 'foo:foo'. It is perhaps a bit strange, but backward
compatibility would I think prohibit us to change it, even if it would
make more sense to have it be shortcut for 'foo:foo' instead.

Besides now that we have git-remote it might be a moot point: setting
up remotes and remote branches info is very easy now.

> * git-rebase claims you should git-rebase --continue after you fix
>   up the merges; it really means you should git-update-index
>   followed by git-rebase --continue.

It is git-add now, not git-update-index.

I'm not sure what is exact wording of interrupted rebase in current
git, as it was some time since I used it, but IIRC it talks about
"resolving conflicts", and doing "git add"[*1*] is a part of this
step.

[*1*] There is/was a floating idea to add "git resolved" command,
which would be limited porcelain calling git-update-index, used _only_
to mark resolved conflicts, and having checks etc. for that.

> * The command to merge branch B onto branch A is not 
>   "git-merge A B". Instead it's "git-checkout A && git-pull . B".

Long fixed, although not in the matter mentioned. To merge branch B
into _current_ branch (you cannot merge to non-current branch because
of possibility of conflicts) you can use "git merge B".

> * There is no way to tell git-fetch (or therefore git-pull) to grab
>   all newly available branches. You have to ask for them by two
>   names (as above), and then there's no way to get those names
>   automatically into your remotes list (also as above).

It is possible with globbing refspec, like this example:
"refs/heads/*:refs/remotes/origin/*". You can use git-remote to do
this for you.

> * git pull's default behaviour on a branch is unhelpful: even when
>   there is an explicit Pull: branch1:branch1 line, a git pull with
>   branch1 checked out will still pull in master.

There is now branch.<name>.merge configuration variable to change the
"first pull line" default; note that globbing refspec requires this,
IIRC.

> * Fundamentally, the entire approach of making the UI painful to
>   deal with and forcing the user to deal with all the warts (instead
>   of just making the hairy low-level commands available), because
>   people will write nice wrappers around it, is the same reason
>   people laughed at tla, and still do.

This was I guess written in the "git is not an SCM' times. Those are
long past, gone with Cogito ;-)

> * The index should be second-class, i.e. no -a flags to avoid the
>   index.

To much opposition for that. Adding '-a' option is not such a burden
(you most probably ass '-s' option anyway), and you can always use
alias for this.

> * branch:branch-origin (or something) should be the default pull.

You can configure from which remote to fetch (to pull) with
branch.<name>.remote, and which branch to merge with
branch.<name>.merge.  And branch.autosetupmerge if you want git to set
this up for you...

> * branch:branch should be the default push for all branches, but
>   only push the current branch unless a flag is added.

You can now push only current branch with "git push <remote> HEAD",
and IIRC also with magic "git push HEAD".

There was talk about whether make current --matching, or proposed
--current, behaviour the default for git-push. Any changes in behavior
must be done with long obsolescence period (half a year for git).

> * An update command should be created that:
>     * fetches the current branch's upstream to its -origin locally
>       (or all branches, perhaps);
>     * merges the current branch origin to the branch locally;
>     * commits if it was a fast-forward, and leaves uncommitted diffs
>       otherwise.

Not done, and probably has no much sense otherwise (merging is done
using 3-way merge, not by taking diff and applying it as a patch).

> Infrastructure/git/UIFlaws (last edited 2007-06-03)

-- 
Jakub Narebski
Poland
ShadeHawk on #git
