From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC 2/2] Automatically transform .git/{branches,remotes} into .git/config
Date: Sun, 27 Nov 2005 13:59:45 +0100
Message-ID: <20051127125945.GD22159@pasky.or.cz>
References: <Pine.LNX.4.63.0511211455120.13775@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 14:00:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgM7z-00020K-QD
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 13:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbVK0M7b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 07:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbVK0M7b
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 07:59:31 -0500
Received: from w241.dkm.cz ([62.24.88.241]:16620 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751030AbVK0M7a (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 07:59:30 -0500
Received: (qmail 27923 invoked by uid 2001); 27 Nov 2005 13:59:45 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511211455120.13775@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12804>

Dear diary, on Mon, Nov 21, 2005 at 02:56:41PM CET, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> With this patch, git automatically extracts the information from 
> .git/branches and .git/remotes, puts it into .git/config, and renames the 
> directories to .git/branches.old and .git/remotes.old, respectively.
> 
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Please don't do so for .git/branches, that is primarily Cogito thing
and you will make it impossible to use GIT and Cogito on the same
repository - the moment the user uses git-pull on the repository, his
Cogito configuration is trashed and he has even no reliable undo
mechanism.

And in another thread (we have too many threads for this subject ;-)
I've tried to explain that branches and remotes are different concepts,
which live in different namespaces and have different semantics, so
rewriting branches to remotes is a bad idea anyway.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
