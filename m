From: Petr Baudis <pasky@suse.cz>
Subject: Re: Garbage in .git directories???
Date: Mon, 19 Sep 2005 21:44:45 +0200
Message-ID: <20050919194445.GD18320@pasky.or.cz>
References: <200509172141.31591.dtor_core@ameritech.net> <432F0D1B.60303@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 21:45:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHRZK-0004gF-FA
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 21:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbVISTor (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 15:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbVISTor
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 15:44:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57534 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932618AbVISTor (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 15:44:47 -0400
Received: (qmail 14074 invoked by uid 2001); 19 Sep 2005 21:44:45 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <432F0D1B.60303@zytor.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8902>

Dear diary, on Mon, Sep 19, 2005 at 09:10:19PM CEST, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> told me that...
> Dmitry Torokhov wrote:
> >
> >git clone 
> >rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 
> >work
> >
> >and it seems there is some garbage in .git directory:
> >
> >[dtor@anvil work]$ ls -la .git/
> >total 40
> >drwxrwxr-x    9 dtor dtor 4096 Sep 17 21:17 .
> >drwxrwxr-x    3 dtor dtor 4096 Sep 17 21:17 ..
> >drwxrwxr-x    2 dtor dtor 4096 Sep 17 21:17 branches
> >-rw-rw-r--    1 dtor dtor   58 Sep 17 21:17 description
> >lrwxrwxrwx    1 dtor dtor   17 Sep 17 21:17 HEAD -> refs/heads/master
> >drwxrwxr-x    2 dtor dtor 4096 Sep 17 21:17 hooks
> >drwxrwxr-x    2 dtor dtor 4096 Sep 17 21:17 info
> >drwxr-xr-x  260 dtor dtor 4096 Sep 17 17:41 objects
> >drwxrwxr-x    4 dtor dtor 4096 May  1 19:15 refs
> >drwxrwxr-x    2 dtor dtor 4096 Sep 17 21:28 remotes
> >drwxrwxr-x    2 dtor dtor 4096 Sep 17 21:17 V?Cl?????E 
> >???#V?C????l??E#V?C??;H
> >                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> >The similar garbage(?) shows when I clone git's repository.
> >
> 
> FWIW, using cg-clone (using git-core 0.99.6 and cogito 0.14.1) I keep 
> finding a directory in .git which consists of a single DEL character (\177).

Does cg-init produce it too? It really seems that this has to be a bug
in git-init-db. If that is the case, could you try temporarily renaming
the templates directory?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
