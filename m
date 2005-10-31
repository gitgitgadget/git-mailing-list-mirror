From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: GIT 0.99.9
Date: Sun, 30 Oct 2005 18:52:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0510301838110.27915@g5.osdl.org>
References: <7vd5lnztav.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 31 03:55:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWPmW-0002Wg-8X
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 03:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbVJaCwR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 21:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbVJaCwR
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 21:52:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5000 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751290AbVJaCwQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Oct 2005 21:52:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9V2rxFR018111
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 30 Oct 2005 18:54:00 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9V2qBLR017692;
	Sun, 30 Oct 2005 18:52:11 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5lnztav.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10848>


Btw, 
 one thing I'd like to see (maybe it already exists and I just have 
overlooked it) is some kind of simple readme or something about the 
different ways to limit the output of the various git commands.

I've several times been surprised to see people not realize that
"git-whatchanged" takes a file list to limit the files it is interested 
in. I also suspect people don't realize that you can limit it by time and 
version and file list, all at the same time.

IOW, 

	git-whatchanged -p --pretty=short --since="2 weeks ago" v0.99.8..v0.99.9 Makefile

is a valid query: it basically asks for any change to the Makefile in 
between versions v0.99.8..v0.99.9, _and_ within the last two weeks, and 
asks to show it as a patch, with the shortened commit message.

Is it useful? The above exact line almost certainly isn't, but variations 
on the above definitely are. And I suspect a lot of people never even 
realized you could do something like that.

(The danger with date-based things is that something may be 4 months old, 
but it only got _merged_ yesterday, so it may be new to _you_. And the 
--since="2 weeks ago" will not show it, which can be surprising to people 
who expect things that are new to _them_ to be shown).

The above limiters now work with "git log" and "gitk" too (they've worked 
for a long time with "git-whatchanged", but only with the new git-rev-list 
functionality does the name-limiting work for the other commands).

It would be good to make this more well-known, because a lot of people 
probably end up using git not as developers, but just to follow what is 
going on. And then the different limiters are some of the most important 
parts (the date-one is likely the least important one, but limiting by 
version and name is _very_ important).

		Linus
