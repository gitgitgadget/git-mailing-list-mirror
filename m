From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Make sure the diff machinery outputs "\ No newline ..."
 in english
Date: Tue, 6 Sep 2005 16:05:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509061534560.23242@iabervon.org>
References: <20050904181724.GA23525@c165.ib.student.liu.se>
 <7vd5nohdp3.fsf@assigned-by-dhcp.cox.net> <20050905060149.GB1875@c165.ib.student.liu.se>
 <Pine.LNX.4.58.0509050849500.3568@evo.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 22:03:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECjdm-0004Fs-5e
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 22:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbVIFUBz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 16:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbVIFUBz
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 16:01:55 -0400
Received: from iabervon.org ([66.92.72.58]:48651 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750840AbVIFUBz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Sep 2005 16:01:55 -0400
Received: (qmail 32549 invoked by uid 1000); 6 Sep 2005 16:05:49 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Sep 2005 16:05:49 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509050849500.3568@evo.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8141>

On Mon, 5 Sep 2005, Linus Torvalds wrote:

> On Mon, 5 Sep 2005, Fredrik Kuivinen wrote:
> > 
> > After a quick look through the diff source I didn't find anything
> > else. It's quite possible that I haved missed something though. Most
> > of the translated messages are related to error reporting, which I
> > guess might be nice to have in the user specified language.
> 
> Is it possible that we could integrate the "diff" algorithm into git, and 
> get rid of the dependency on an external GNU diff? It would also make the 
> portability problems go away (ie old diff's being broken).
> 
> It would also potentially speed up the normal built-in diff a lot, since
> we wouldn't have to execute a whole other program to generate a diff, just
> call a helper function the way we do for xdiff..
> 
> Unreasonable?

The algorithm actually used by GNU diff is pretty complicated, and I don't 
really understand the actual implementation, which evidentally has a few 
important refinements over the original paper.

I've written my own diff, mainly to try a different algorithm, and it 
seems to work, but the code isn't yet appropriate to submit. This 
algorithm also has the advantage that it can identify moved sections and 
is less interested in interleaving a removed function with a new function 
to provide the shortest possible diff. I expect that I could get it to 
work if I put in a day on it; it's mostly writing a hashtable 
implementation for non-NULL-terminated string-keyed hash tables.

	-Daniel
*This .sig left intentionally blank*
