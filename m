From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cannot get git any more?
Date: Wed, 20 Jul 2005 01:38:39 +0200
Message-ID: <20050719233839.GC2255@pasky.ji.cz>
References: <20050717224904.D1ED735258B@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 20 01:39:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dv1fo-0005SP-W1
	for gcvg-git@gmane.org; Wed, 20 Jul 2005 01:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVGSXil (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jul 2005 19:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVGSXil
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jul 2005 19:38:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:5 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261421AbVGSXil (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jul 2005 19:38:41 -0400
Received: (qmail 6799 invoked by uid 2001); 19 Jul 2005 23:38:39 -0000
To: Wolfgang Denk <wd@denx.de>
Content-Disposition: inline
In-Reply-To: <20050717224904.D1ED735258B@atlas.denx.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Jul 18, 2005 at 12:49:04AM CEST, I got a letter
where Wolfgang Denk <wd@denx.de> told me that...
> -> cd ..
> -> mv git git.OLD
> -> cg-clone rsync://rsync.kernel.org/pub/scm/git/git.git
> /usr/local/src/git
> defaulting to local storage area
> @ERROR: Unknown module 'pub'
> rsync: connection unexpectedly closed (41 bytes read so far)
> rsync error: error in rsync protocol data stream (code 12) at io.c(342)
> cg-pull: unable to get the head pointer of branch master
> cg-init: pull failed

That's puzzling. Try just

	rsync -a rsync://rsync.kernel.org/pub/scm/git/git.git /usr/local/src/git

which should fail too and indicates that something must be weird on your
side since it apparently works for the rest of the world. ;-) Try
upgrading rsync, check if it really connects to the real
rsync.kernel.org and such...

> -> rm -fr git
> -> cg-clone http://www.kernel.org/pub/scm/git/git.git
> /usr/local/src/git
> defaulting to local storage area
> 00:44:43 URL:http://www.kernel.org/pub/scm/git/git.git/refs/heads/master [41/41] -> "refs/heads/origin" [1]
> progress: 2 objects, 4252 bytes
> error: File 6ff87c4664981e4397625791c8ea3bbb5f2279a3 (http://www.kernel.org/pub/scm/git/git.git/objects/6f/f87c4664981e4397625791c8ea3bbb5f2279a3) corrupt
> 
> Cannot obtain needed blob 6ff87c4664981e4397625791c8ea3bbb5f2279a3
> while processing commit 0000000000000000000000000000000000000000.
> cg-pull: objects pull failed
> cg-init: pull failed

This is unfortunately normal now.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
