From: Petr Baudis <pasky@ucw.cz>
Subject: Re: cg-update with local uncommitted changes
Date: Tue, 31 May 2005 17:58:25 +0200
Message-ID: <20050531155825.GA7013@pasky.ji.cz>
References: <1117463114.7072.185.camel@pegasus> <20050530183932.GB10439@pasky.ji.cz> <1117480796.7072.204.camel@pegasus> <d7g430$1cq$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 17:57:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dd96E-00081a-1E
	for gcvg-git@gmane.org; Tue, 31 May 2005 17:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVEaP6p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 11:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVEaP6p
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 11:58:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11687 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261923AbVEaP63 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 11:58:29 -0400
Received: (qmail 9415 invoked by uid 2001); 31 May 2005 15:58:25 -0000
To: Dan Holmsand <holmsand@gmail.com>
Content-Disposition: inline
In-Reply-To: <d7g430$1cq$1@sea.gmane.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 31, 2005 at 12:31:28AM CEST, I got a letter
where Dan Holmsand <holmsand@gmail.com> told me that...
> Marcel Holtmann wrote:
> >I also think that it would be great if we cancel the merge if the local
> >changes conflict with the files in the merge. This is how Bitkeeper does
> >it and I think it is the only safe way, because if something fails or
> >rejects we may destroy the local changes.
> 
> I definitely agree (been bitten by patching gone wild a couple of times...).
> 
> This patch would make cg-merge and cg-admin-uncommit refuse to do 
> anything if there are conflicting uncommitted changes. Note: this only 
> applies to fast-forward merging, as cg-merge otherwise bails out if 
> there are *any* uncommitted changes (which is perhaps going to far).

Well, non-fast-forward cg-merge will do cg-commit and it would blend the
unrelated previously uncommitted changes into that, which is not what
you want.

> [PATCH] Make tree_timewarp safe, by refusing to handle conflicts.
> 
> Signed-off-by: Dan Holmsand <holmsand@gmail.com>

I don't really think this makes any sense. What do you then do when you
want to do some merging of the local uncommitted changes and upstream
update?

How have you been bitten, and how could we destroy the local changes?
You get rejects and patch will be pretty vocal about it, so then you
just go and resolve them. The correct direction is to make it do a
three-way merge, not make it do no merge at all.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
