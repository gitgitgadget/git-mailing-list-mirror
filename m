From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: An idea: maybe Git should use a lock/unlock file mode for
 problematic files? [Was: Re: after first git clone of linux kernel repository
 there are changed files in working dir]
Date: Tue, 20 Jan 2009 19:03:10 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901201833400.19665@iabervon.org>
References: <d304880b0812101019ufe85095h46ff0fe00d32bbd0@mail.gmail.com>  <d304880b0812101022u2abe5d68ub3bda68ed39f830b@mail.gmail.com>  <83ocy3fmez.fsf@kalahari.s2.org>  <20090120105228.xbo3gyc0odwcgcsc@webmail.fussycoder.id.au>  <alpine.LNX.1.00.0901201441480.19665@iabervon.org>
  <1232486929.4179.7.camel@therock.nsw.bigpond.net.au>  <alpine.LNX.1.00.0901201651050.19665@iabervon.org> <81b0412b0901201525w22513418p57acc19457908a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Chapman <thestar@fussycoder.id.au>,
	Hannu Koivisto <azure@iki.fi>, rdkrsr <rdkrsr@googlemail.com>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 01:04:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPQaN-0003MO-3P
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 01:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756577AbZAUADN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 19:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755960AbZAUADM
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 19:03:12 -0500
Received: from iabervon.org ([66.92.72.58]:39533 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755521AbZAUADM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 19:03:12 -0500
Received: (qmail 18554 invoked by uid 1000); 21 Jan 2009 00:03:10 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Jan 2009 00:03:10 -0000
In-Reply-To: <81b0412b0901201525w22513418p57acc19457908a3@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106542>

On Wed, 21 Jan 2009, Alex Riesen wrote:

> 2009/1/20 Daniel Barkalow <barkalow@iabervon.org>:
> > My impression was that this didn't happen in practice, because teams
> > would tend to not have two people create the same file at the same time,
> > but with different cases, and people interacting with the same file at
> > different times would use whatever case it was introduced with.
> 
> It will and does happen in practice (annoingly too often even). Not with Git
> yet (with Perforce), where people do "branching" by simply copying things
> in another directory (perforce world does not know real branches),
> renaming files randomly, and putting the new directory back in the
> system (or maybe it is the strange tools here which do that - often
> it is the first character of a directory or file which gets down- or up-cased).

How does the resulting code work at all? With a case-sensitive filesystem, 
most of the files you're using don't have the expected names any more, and 
most systems will therefore not actually build or run.

I have to assume it's your strange tools, because we never have this 
problem at my work, where we also use Perforce. Perhaps it's that we 
always use "p4 integrate //some/project/version/... 
//some/other/project/version/..." which inherently preserves the case of 
all of the filenames within the project.

> As Perforce itself is case sensitive (like Git), using of such branches
> is a nightmare: the files get overwritten in checkout order which is
> not always sorted in predictable order. Combined with case-stupidity
> of the file system the working directories sometimes cause "interesting
> time" for unlucky users.
> Luckily (sadly) it is all-opening-in-a-wall shop, so the problem with "fanthom"
> files is rare (it is hard to notice) for most. Which actually makes it more
> frustrating when the real shit happens.
> 
> And it will happen to Git as well, especially if development go crossplatform.
> It is not that hard to accidentally rename a file on case-sensitive file system,
> "git add *" it and commit without thinking (that's how most of software
> development happens, come to think of it).

People can accidentally rename files? And still have things work when they 
do it on a case-sensitive filesystem?

	-Daniel
*This .sig left intentionally blank*
