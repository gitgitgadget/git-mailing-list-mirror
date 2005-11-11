From: Petr Baudis <pasky@suse.cz>
Subject: Re: proper way to make cg-fetch work from originally git-clone'd tree
Date: Fri, 11 Nov 2005 01:11:48 +0100
Message-ID: <20051111001148.GG30496@pasky.or.cz>
References: <86mzkc4nlu.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 01:13:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaMWJ-0004jb-KS
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 01:11:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbVKKALw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 19:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbVKKALw
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 19:11:52 -0500
Received: from w241.dkm.cz ([62.24.88.241]:18860 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932269AbVKKALv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 19:11:51 -0500
Received: (qmail 27198 invoked by uid 2001); 11 Nov 2005 01:11:48 +0100
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <86mzkc4nlu.fsf@blue.stonehenge.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11540>

Dear diary, on Thu, Nov 10, 2005 at 02:51:57PM CET, I got a letter
where "Randal L. Schwartz" <merlyn@stonehenge.com> said that...
> I tried git-fetch this morning, and it said I didn't have an origin,
> which makes sense because I made the tree with git-clone, not cg-clone.
> 
> However, when I tried
> 
>         cg-branch-add origin rsync://rsync.kernel.org/pub/scm/git/git.git
> 
> it complained that I already had an origin!  It seems to work after
> that, but what should I have done instead?  Is there a way to make
> both cg-fetch and git-fetch to default to the same things?

You should do what you did - it was just a warning. git-clone seems to
have created only a 'remotes' entry, which Cogito doesn't understand
(yet).

> By the way, my "make only if something changed" works now, because
> I've separated cg-fetch and cg-merge.  My merge step looks like:
> 
>   cg-merge 2>&1 | grep -v 'already fully merged' && make prefix=/opt/git all install && (cd Documentation && make prefix=/opt/git all install)

Any reason why you were unable to tell the main make 'doc install-doc'?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
