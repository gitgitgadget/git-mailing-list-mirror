From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 21 Feb 2008 10:40:59 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802211024200.17164@racer.site>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org> <7vodavd9qw.fsf@gitster.siamese.dyndns.org> <7vbq6tset4.fsf@gitster.siamese.dyndns.org> <7vmyq9gk94.fsf@gitster.siamese.dyndns.org> <7vk5la4oxq.fsf@gitster.siamese.dyndns.org> <7vejbc44hu.fsf@gitster.siamese.dyndns.org>
 <7v8x1fymei.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 11:42:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS8sK-0001Ut-VM
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 11:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450AbYBUKlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 05:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755449AbYBUKlZ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 05:41:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:50931 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755373AbYBUKlY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 05:41:24 -0500
Received: (qmail invoked by alias); 21 Feb 2008 10:41:16 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp024) with SMTP; 21 Feb 2008 11:41:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+hrC8Gm0ahECfb7kGo18HjWe6a0ESE4oSpDWZ7mw
	vj0K74Z25PROPK
X-X-Sender: gene099@racer.site
In-Reply-To: <7v8x1fymei.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74611>

Hi,

On Wed, 20 Feb 2008, Junio C Hamano wrote:

> ----------------------------------------------------------------
> [New Topics]
> 
> * js/branch-track (Tue Feb 19 11:24:38 2008 -0500) 2 commits

Heh, now it gets confusing ;-) Three regular contributors with the same 
initials? ;-)

> * js/merge (Sun Feb 17 19:07:40 2008 +0000) 2 commits
>  + xdl_merge(): introduce XDL_MERGE_ZEALOUS_ALNUM
>  + xdl_merge(): make XDL_MERGE_ZEALOUS output simpler
> 
> This makes conflicting merges that have hunks separated by only
> a few common lines much easier to read.

The question is: what to do about ALNUM.  Use it in merge-recursive?  Make 
it a config variable?

> * db/push-single-with-HEAD (Wed Feb 20 12:54:05 2008 -0500) 1 commit
>  + Resolve value supplied for no-colon push refspecs
> 
> Kills two birds with a commit by (1) fixing "git push $there +HEAD"
> to force the single push, and (2) allowing you to set
> "remote.$there.push = HEAD" so that "git push $there" will push
> only the current branch.

The question is now: should we initialise remote.origin.push to HEAD like 
you said?  And if so, shouldn't we have git-remote's "add" do the same?

Speaking of which, I think it would make sense to teach git-remote's "add" 
to detect if you are installing a remote "origin" and set up 
branch.$(git symbolic-ref HEAD).{remote,merge} like clone would.  After 
all, if you are setting up "origin", chances are that you just initialised 
a remote repository with your current one.

Thoughts?

> * js/reflog-delete (Fri Jan 4 19:11:37 2008 -0600) 2 commits
>  + builtin-reflog.c: fix typo that accesses an unset variable
>  + Teach "git reflog" a subcommand to delete single entries
> 
> There was a patch that uses this to implement "git-stash drop",
> which I didn't queue, as the command name and the UI was
> undecided yet.  Dscho was in favor of "pop" without "drop".

Maybe it is time to "drop" this topic?

> * nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
>  - Move all dashed-form commands to libexecdir
> 
> Scheduled for 1.6.0.  I am not sure if we should merge this to
> 'next' before 1.5.5.  Most active people will be on 'next' and
> if we have this there, the resulting 1.5.5 release might end up
> having issues that come from differences this one introduces.

I think this is a good plan.  Better safe 'n sorry.

Ciao,
Dscho
