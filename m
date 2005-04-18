From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Add help details to git help command.
Date: Mon, 18 Apr 2005 12:24:12 +0200
Message-ID: <20050418102412.GJ1461@pasky.ji.cz>
References: <200504172242.26326.elenstev@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 12:20:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNTMn-0000j7-PG
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 12:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVDRKYY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 06:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVDRKYY
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 06:24:24 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10403 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262020AbVDRKYS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 06:24:18 -0400
Received: (qmail 30115 invoked by uid 2001); 18 Apr 2005 10:24:12 -0000
To: Steven Cole <elenstev@mesatop.com>
Content-Disposition: inline
In-Reply-To: <200504172242.26326.elenstev@mesatop.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Apr 18, 2005 at 06:42:26AM CEST, I got a letter
where Steven Cole <elenstev@mesatop.com> told me that...
> There's a patch at the bottom of this, so please look at that first before
> my reading my whining immediately below.
> 
> I'm having some troubles with git pull, so this is just an ordinary diff.
> Otherwise, I would have used the in-house diff command.
> 
> <troubles>
> patch: **** Only garbage was found in the patch input.
> </troubles>
> <more troubles>
> Tracked branch, applying changes...
> error: bad signature
> error: verify header failed
> read_cache: Invalid argument
> error: bad signature
> error: verify header failed
> error: bad signature
> error: verify header failed
> </more troubles>

read-tree $(tree-id) && update-cache --refresh

The directory cache format changed, so it causes this. I'm hoping to
release 0.5 with good cache prepackaged Real Soon Now (tm). :-)

Note that then you will have to recover from the failed apply. If you
had no local commits, it is easy - put that two IDs git pull told
you to git diff and pipe it to git apply. If you had local commits, and
have already GIT version with merge-base, do just git merge pasky and
proceed with the merge. If you don't have merge-base, pass the first
ID from git track to git merge with the -b argument.

> This patch will provide the comment lines in the shell script associated
> with the command, cleaned up a bit for presentation.
> 
> BUGS: This will also print any comments in the entire file, which may
> not be desired.  If a command name and shell script filename
> do not follow the usual convention, this won't work, e.g. ci for commit.

Hey, those BUGS are the only slightly non-trivial thing on the whole
thing! I could do this patch myself... ;-) Also, you don't want to print
the first newline and the Copyright notices.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
