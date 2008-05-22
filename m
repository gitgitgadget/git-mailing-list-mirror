From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 22 May 2008 12:35:01 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805221212200.30431@racer>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7vwso85qkf.fsf@gitster.siamese.dyndns.org> <7vwso5r87q.fsf@gitster.siamese.dyndns.org> <7v8x0992hy.fsf@gitster.siamese.dyndns.org> <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org> <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org> <7vbq4j748l.fsf@gitster.siamese.dyndns.org> <7vr6d8apjx.fsf@gitster.siamese.dyndns.org> <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 22 13:36:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jz95Z-00008z-Dd
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 13:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756792AbYEVLex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 07:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756708AbYEVLex
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 07:34:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:46793 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756596AbYEVLew (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 07:34:52 -0400
Received: (qmail invoked by alias); 22 May 2008 11:34:50 -0000
Received: from R5e98.r.pppool.de (EHLO racer.local) [89.54.94.152]
  by mail.gmx.net (mp002) with SMTP; 22 May 2008 13:34:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18JMbw9gSEJAevydJXLA/Fcei5tU5OkOvZUY1sP8M
	QS0tKzbiDGqhig
X-X-Sender: gene099@racer
In-Reply-To: <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82613>

Hi,

On Wed, 21 May 2008, Junio C Hamano wrote:

> * js/config-cb (Wed May 14 18:46:53 2008 +0100) 1 commit
>  - Provide git_config with a callback-data parameter
> 
> This needs to wait until most of the other things graduate for 1.5.6; 
> luckily, unlike the other "path-list" changes, misconversions is much 
> easier to catch for this change and I am not worried about it.

Just let me know when to resubmit, and against what branch(es).

> * js/mailinfo (Fri May 16 14:03:30 2008 +0100) 1 commit
>  - <<PARK - BASE64 and QP still broken>> mailsplit and mailinfo:
>    gracefully handle NUL characters
> 
> When "am" processes a patch that modifies a line with NUL, we used to
> chomp the patch line there, resulting in rejects.  This patch fixes the
> issue partially, only when the message is not encoded in BASE64 nor
> Quoted-Printable.

Like I said, I would be happy if Tommy took care of that patch.

> * js/ignore-submodule (Wed May 14 18:03:59 2008 +0100) 3 commits
>  + Ignore dirty submodule states during rebase and stash
>  + Teach update-index about --ignore-submodules
>  + diff options: Introduce --ignore-submodules

I haven't heard back from you about renaming that option.  I think I 
suggested --non-gitlinks or something equally discouraging for 
porcelain users.

> * as/graph (Mon May 5 00:57:03 2008 -0700) 4 commits
>  + graph API: eliminate unnecessary indentation
>  + log and rev-list: add --graph option
>  + Add history graph API
>  + revision API: split parent rewriting and parent printing options
> 
> Draw "tig 'g'" graph without tig ;-)

I am a big fan of this feature.

> * db/clone-in-c (Tue May 20 14:15:14 2008 -0400) 11 commits
>  + clone: fall back to copying if hardlinking fails
>  + builtin-clone.c: Need to closedir() in copy_or_link_directory()
>  + builtin-clone: fix initial checkout
>  + Build in clone
>  + Provide API access to init_db()
>  + Add a function to set a non-default work tree
>  + Allow for having for_each_ref() list extra refs
>  + Have a constant extern refspec for "--tags"
>  + Add a library function to add an alternate to the alternates file
>  + Add a lockfile function to append to a file
>  + Mark the list of refs to fetch as const

Fingers crossed.

> * js/rebase-i-sequencer (Sun Apr 27 02:55:50 2008 -0400) 17 commits
>  + Use perl instead of tac
>  + Fix t3404 assumption that `wc -l` does not use whitespace.
>  + rebase -i: Use : in expr command instead of match.
>  + rebase -i: update the implementation of 'mark' command
>  + Add option --preserve-tags
>  + Teach rebase interactive the tag command
>  + Add option --first-parent
>  + Do rebase with preserve merges with advanced TODO list
>  + Select all lines with fake-editor
>  + Unify the length of $SHORT* and the commits in the TODO list
>  + Teach rebase interactive the merge command
>  + Move redo merge code in a function
>  + Teach rebase interactive the reset command
>  + Teach rebase interactive the mark command
>  + Move cleanup code into it's own function
>  + Don't append default merge message to -m message
>  + fake-editor: output TODO list if unchanged
> 
> This may complement the proposed "sequencer" GSoC project.  Dscho seems 
> to have quite a strong objection to the 'mark' syntax and mechanism 
> being unnecessarily complex.  Let's wait and see if a less complex but 
> equally expressive alternative materializes...

Yeah, I know.  My backlog is growing and growing.

Ciao,
Dscho
