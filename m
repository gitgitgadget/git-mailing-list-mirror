From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Following renames
Date: Sun, 26 Mar 2006 15:09:13 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603261505230.15714@g5.osdl.org>
References: <20060326014946.GB18185@pasky.or.cz> <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org>
 <44264426.8010608@michonline.com> <20060326014946.GB18185@pasky.or.cz>
 <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org> <20060326100717.GD18185@pasky.or.cz>
 <Pine.LNX.4.64.0603260829550.15714@g5.osdl.org> <20060326191445.GQ18185@pasky.or.cz>
 <Pine.LNX.4.64.0603261415390.15714@g5.osdl.org> <20060326223154.GU18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 27 01:09:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNeMS-0001v7-4p
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 01:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWCZXJZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 18:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWCZXJZ
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 18:09:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39827 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932175AbWCZXJY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 18:09:24 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2QN9EDZ008510
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Mar 2006 15:09:14 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2QN9DF2021632;
	Sun, 26 Mar 2006 15:09:13 -0800
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060326223154.GU18185@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18065>



On Mon, 27 Mar 2006, Petr Baudis wrote:

> Dear diary, on Mon, Mar 27, 2006 at 12:22:04AM CEST, I got a letter
> where Linus Torvalds <torvalds@osdl.org> said that...
> > So commit "6" is uninteresting, and commit "5" will never even be
> > looked at, since we decided that the history of "d" comes from the
> > first parent with the same contents.
> 
> And this is the thing I have a problem with - this does not make much
> sense to me, why can't we just follow all parents instead of arbitrarily
> choosing one of them?

Sure, you can. It's _usually_ a huge waste of time, though. Why would you 
want to do more work than you need, since clearly the other parent was 
_not_ interesting from the standpoint of the question "where did this 
content come from"?

> > No, it's the expected output just because you expected merges to always 
> > show up. Merges get ignored if any of the parents have the same content 
> > already.
> 
> Eek. Can I avoid that? What was the reason for choosing this behavior?

Huge efficiency gains.

Lookie here. Do

	gitk -- rev-list.c

on the git archive with the current git-rev-list, and with your hacked-up 
version.

And tell me my version isn't a hell of a lot better. Because, I guarantee 
you, it is. We're just not _interested_ in all those merges that didn't 
actually make any difference.

Read up on what modern neuro-science thinks about the human brain, and 
what a lot of it is about. It's about ignoring irrelevant information.

The ability to throw stuff out that isn't interesting is the _real_ basis 
of true intelligence. I'd rather have git do the _intelligent_ history, 
than show history that isn't relevant and workign harder doing so.

		Linus
