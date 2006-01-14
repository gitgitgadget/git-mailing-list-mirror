From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC: Subprojects
Date: Sat, 14 Jan 2006 12:02:37 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601141154590.13339@g5.osdl.org>
References: <43C52B1F.8020706@hogyros.de>
 <Pine.LNX.4.63.0601111740220.17966@wbgn013.biozentrum.uni-wuerzburg.de>
 <43C537C9.4090206@hogyros.de> <Pine.LNX.4.64.0601110928350.5073@g5.osdl.org>
 <7vacdzkww3.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0601141055210.13339@g5.osdl.org>
 <43C951B6.5030607@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Simon Richter <Simon.Richter@hogyros.de>
X-From: git-owner@vger.kernel.org Sat Jan 14 21:03:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExrcJ-0006s8-U6
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 21:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWANUDM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 15:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbWANUDM
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 15:03:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16864 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750863AbWANUDM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jan 2006 15:03:12 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0EK2cDZ014352
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 14 Jan 2006 12:02:39 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0EK2bS8013335;
	Sat, 14 Jan 2006 12:02:38 -0800
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <43C951B6.5030607@gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.65__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14676>



On Sat, 14 Jan 2006, A Large Angry SCM wrote:
>
> So far I've not seen any convincing arguments why the sub-projects can not be
> managed by the Makefile, or equivalent, of the super-project. Particularly
> when the sub-projects have a life of their own.

Now, from a developer standpoint I actually agree with you. I find 
sub-projects totally useless - I'm much happier just having separate 
trees.

The advantage (as far as I can tell) of sub-projects is not that they are 
easier to develop in, but that it's a total nightmare for the technical 
_user_ to download ten different projects from ten different sites, and 
configure them properly and install them in the right order, and keep them 
up-to-date.

There are projects that I simply gave up even trying to track: I wasn't 
interested in being a developer per se, but I _was_ interested in trying 
to test and give feedback to the current development tree - but it was 
just too damn confusing to get it working.

If I could have just done a "git clone <top-level>" to get it all, I'd 
have been a much more productive user.

This is why I think sub-projects are more about "git checkout" and an 
automated "git fetch" than anything else. Doing actual development etc you 
can easily do one project at a time. "git diff" and "git commit" wouldn't 
need any real ability to recurse into subprojects and try to make it 
seamless. And if you do a "git pull" that needs to do anything but 
fast-forward, you might as well resolve the sub-projects one by one.

		Linus
