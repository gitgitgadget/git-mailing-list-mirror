From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 21:23:40 +0200
Message-ID: <1113679421.28612.16.camel@tglx.tec.linutronix.de>
References: <20050416131528.GB19908@elte.hu>
	 <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 20:20:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMrtp-000201-9b
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 20:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262717AbVDPSXt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 14:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbVDPSXt
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 14:23:49 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:60856
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262717AbVDPSXr
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 14:23:47 -0400
Received: from mail.tec.linutronix.de (213-239-205-147.clients.your-server.de [213.239.205.147])
	by mail.tglx.de (Postfix) with ESMTP id 9F25865C003;
	Sat, 16 Apr 2005 20:22:33 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 046B328222;
	Sat, 16 Apr 2005 20:23:41 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-04-16 at 10:04 -0700, Linus Torvalds wrote:

> So I'd _almost_ suggest just starting from a clean slate after all.  
> Keeping the old history around, of course, but not necessarily putting it
> into git now. It would just force everybody who is getting used to git in 
> the first place to work with a 3GB archive from day one, rather than 
> getting into it a bit more gradually.

Sure. We can export the 2.6.12-rc2 version of the git'ed history tree
and start from there. Then the first changeset has a parent, which just
lives in a different place. 
Thats the only difference to your repository, but it would change the
sha1 sums of all your changesets.

> What do people think? I'm not so much worried about the data itself: the
> git architecture is _so_ damn simple that now that the size estimate has
> been confirmed, that I don't think it would be a problem per se to put
> 3.2GB into the archive. But it will bog down "rsync" horribly, so it will
> actually hurt synchronization untill somebody writes the rev-tree-like
> stuff to communicate changes more efficiently..

We have all the tracking information in SQL and we will post the data
base dump soon, so people interested in revision tracking can use this
as an information base.

> But it's _great_ to have the history in this format, especially since 
> looking at CVS just reminded me how much I hated it.

:)

One remark on the tree blob storage format. 
The binary storage of the sha1sum of the refered object is a PITA for
scripting. 
Converting the ASCII -> binary for the sha1sum comparision should not
take much longer than the binary -> ASCII conversion for the file
reference. Can this be changed ?

tglx


