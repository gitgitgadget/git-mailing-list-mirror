From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: diff/Checking out by date specification
Date: Mon, 30 Jun 2008 01:09:04 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806300042020.19665@iabervon.org>
References: <486843C3.30402@rea-group.com> <20080630032744.GA18930@sigill.intra.peff.net> <48686339.60205@rea-group.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Toby Corkindale <toby.corkindale@rea-group.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 07:10:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDBef-0003Fu-Db
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 07:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbYF3FJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 01:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbYF3FJH
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 01:09:07 -0400
Received: from iabervon.org ([66.92.72.58]:51461 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878AbYF3FJG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 01:09:06 -0400
Received: (qmail 19192 invoked by uid 1000); 30 Jun 2008 05:09:04 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Jun 2008 05:09:04 -0000
In-Reply-To: <48686339.60205@rea-group.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86871>

On Mon, 30 Jun 2008, Toby Corkindale wrote:

> Jeff King wrote:
> > On Mon, Jun 30, 2008 at 12:24:03PM +1000, Toby Corkindale wrote:
> > 
> > > `man git-rev-parse` seems to indicate that one can look at the state of
> > > the repository by date (absolute or relative), and use this for diff or
> > > checkout, etc.
> > > It includes examples such as "{yesterday}" and "{1979-02-26 18:30:00}".
> > 
> > It's a little bit more complex than that. The branch@{time} syntax means
> > "what was in _my_ branch at that time". And if you just cloned, your
> > branch doesn't go back very far.
> > 
> > If you want to say "find commits that happened before time T", you want
> > --until or --since (or their aliases --before and --after).
> > 
> > Would the documentation patch below have helped with the confusion?
> 
> Ah, I see.
> Thanks, yes, that would have made the issue clearer.
> 
> I think it would be good if you could give a couple of examples, such as:
> How would I go about checking out the code at the state it was in at, say,
> 2008-01-01?
> Or how one can get a diff between 2008-01-01 and 2008-01-08?

That's not well-defined, except in a particular location. It's pretty 
likely that there were some changes that were made by different people 
late in 2007, and languished in their local repositories, and were never 
merged with each other until after some further changes had been made and 
the holiday was over. So there isn't a single state of the code as of 
2008-01-01 to compare against.

The usual case for wanting the diff between 2008-01-01 and 2008-01-08 is 
that you encountered some version on each of those dates, and you want to 
know what the difference is between them, and reflogs work for that, but 
it's also possible that what you want is the states that were somewhere 
else at that point, and I don't think we have a good solution for that 
currently unless you can run git commands there to look at the reflog for 
that location.

But, in general, with a distributed system like git, you'll do better to 
look at the history graph around that time with gitk and find the states 
you're actually interested in by other features or a combination of 
features.

	-Daniel
*This .sig left intentionally blank*
