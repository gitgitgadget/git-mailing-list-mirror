From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 15:48:14 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712111544390.25032@woody.linux-foundation.org>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com> <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org> <vpq4pepcaz5.fsf@bauges.imag.fr> <alpine.LFD.0.9999.0712111119310.25032@woody.linux-foundation.org>
 <vpq63z49511.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Berlin <dberlin@dberlin.org>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Dec 12 00:49:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Eqi-0005rY-Sd
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 00:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758064AbXLKXsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 18:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758043AbXLKXsw
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 18:48:52 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60638 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753005AbXLKXsv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 18:48:51 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBBNmF8X003313
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Dec 2007 15:48:16 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBBNmE3v015316;
	Tue, 11 Dec 2007 15:48:15 -0800
In-Reply-To: <vpq63z49511.fsf@bauges.imag.fr>
X-Spam-Status: No, hits=-2.716 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67971>



On Wed, 12 Dec 2007, Matthieu Moy wrote:
>
> > I seriously doubt it, though. Do you get *history* right, or do you just 
> > get a random list of commits?
> 
> Well, you don't get merge commit right with SVN, but that's a
> different issue (svn 1.5 is supposed to have something about merge
> history, I don't know how it's done ...). So, if by "history", you
> mean how branches interferred together, obviously, SVN is bad at this.
> But it's equally bad at "svn log dir/" and plain "svn log".

Yeah, git just has higher goals.

The time history really matters (or rather, what I call the "shape" of 
history) is when you are trying to merge, and you get a merge conflict. 
That's when you want to do

	gitk master merge ^merge-base -- files-that-are-unmerged

and in fact this is such an important thing for me that there is a 
shorthand argument to do exactly that, ie:

	gitk --merge

which shows the commits that touched the unmerged files graphically *with* 
the history being correct (ie you don't just get a random log of "these 
changes happened", you get the real history of the two branches as it 
pertains to the files you care about!)

> But to simplify, if you take a linear history (no merge commits),
> "svn log dir/" give you the list of commits which changed something
> inside "dir/"

Sure, linear history is trivial. But it's also almost totally 
uninteresting.

			Linus
