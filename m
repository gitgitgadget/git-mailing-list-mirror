From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Removal of "--merge-order"?
Date: Fri, 24 Feb 2006 22:37:38 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602242230210.11479@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0602240824110.3771@g5.osdl.org>
 <Pine.LNX.4.58.0602240840520.7894@shark.he.net> <Pine.LNX.4.64.0602240918030.3771@g5.osdl.org>
 <Pine.LNX.4.58.0602240942520.7894@shark.he.net> <Pine.LNX.4.64.0602240957430.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 24 22:41:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCkgi-0006gX-3V
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 22:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbWBXVhp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 16:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbWBXVho
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 16:37:44 -0500
Received: from mail.gmx.de ([213.165.64.20]:41391 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932573AbWBXVho (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 16:37:44 -0500
Received: (qmail invoked by alias); 24 Feb 2006 21:37:42 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp030) with SMTP; 24 Feb 2006 22:37:42 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602240957430.22647@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16741>

Hi,

On Fri, 24 Feb 2006, Linus Torvalds wrote:

> Now, rev-list.c is not the biggest file (apply.c is about twice the size), 
> but in many ways it's the most complex one by far. It's also the most 
> performance-critical one, and the one that it would be really nice if we 
> were to be able to libify it.

This is what I wanted to try today, but unfortunately I had to do real 
work :-(

> For example, instead of the horrid scriping language, I _think_ I could 
> almost libify it by just hooking into "show_commit", and using a callback 
> function for that (and then the stand-alone program would just make the 
> callback function be one that prints out the commit). 

I don't find the scripting language you invented particularly horrid. 
Maybe some odd things (like "if" branching to the "else" block whenever 
*any* argument was passed), but not horrid.

But in the end I would prefer a libified git, if only to get rid of 
double parsing (if you pipe the output of git-rev-list to another git 
program, chances are that you parse the commit objects at least twice).

> That would possibly be a simpler way to get away from using nonportable 
> scripts. Plain C really does remain one of the most portable things out 
> there.

Yes.

Ciao,
Dscho
