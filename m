From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cloning speed comparison, round II
Date: Sat, 12 Nov 2005 12:31:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511121229340.3263@g5.osdl.org>
References: <20051112155302.GD30496@pasky.or.cz> <Pine.LNX.4.64.0511121134170.3263@g5.osdl.org>
 <20051112194646.GE30496@pasky.or.cz> <Pine.LNX.4.64.0511121159470.3263@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 21:32:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb22e-0002KD-60
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 21:32:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbVKLUbw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 15:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbVKLUbw
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 15:31:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63152 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964783AbVKLUbu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 15:31:50 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jACKVdnO010840
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 12 Nov 2005 12:31:40 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jACKVXC2010568;
	Sat, 12 Nov 2005 12:31:36 -0800
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <Pine.LNX.4.64.0511121159470.3263@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11704>



On Sat, 12 Nov 2005, Linus Torvalds wrote:
> 
> So the fact is: rsync is often slower, and _always_ less capable. 

Side note: a lot of the rsync problems are non-issues for the initial 
clone. 

That initial clone is in fact the only time I think rsync can be a good 
idea, especially if the server end is repacking regularly.

Then the only downside of cloning using rsync is that it will obviously 
also set up the "origin" branch to be updated using rsync, which is sad if 
there are alternatives.

But it may be a good idea to first clone using rsync, and then edit the 
origin file to change the rsync into a git-native protocol if one is 
available.

		Linus
