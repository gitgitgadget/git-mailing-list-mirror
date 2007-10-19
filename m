From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: Re: Qgit performance and maintain CVS environment with GIT repository
Date: Fri, 19 Oct 2007 12:34:47 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200710191234.47944.wielemak@science.uva.nl>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com> <200710190943.45201.wielemak@science.uva.nl> <471871BD.7030608@bluelane.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	piet.delaney@gmail.piet.net,
	Linus Torvalds <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org,
	piet.delaney@gmail.com, Piet Delaney <pdelaney@bluelane.com>
To: pete@bluelane.com
X-From: git-owner@vger.kernel.org Fri Oct 19 12:48:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IipPK-0002l8-6I
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 12:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757399AbXJSKs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 06:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757389AbXJSKs1
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 06:48:27 -0400
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:1692 "EHLO
	smtp-vbr10.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756726AbXJSKs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 06:48:26 -0400
Received: from gollem.science.uva.nl (gollem.science.uva.nl [146.50.26.20])
	(authenticated bits=0)
	by smtp-vbr10.xs4all.nl (8.13.8/8.13.8) with ESMTP id l9JAevY5058791;
	Fri, 19 Oct 2007 12:40:57 +0200 (CEST)
	(envelope-from wielemak@science.uva.nl)
User-Agent: KMail/1.9.5
In-Reply-To: <471871BD.7030608@bluelane.com>
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61686>

On Friday 19 October 2007 10:58, Pete/Piet Delaney wrote:
> Jan Wielemaker wrote:
> > On Friday 19 October 2007 02:22, Pete/Piet Delaney wrote:
> >> We are definitely not fine with CVS, the branch merging isn't
> >> comfortable. I'm just wondering about maintaining the existing
> >> CVS browsers and the build scripts if it's not a big deal. I'll
> >> try the git-cvsserver path. If anyone has any war stories to share
> >> on the path this would be an ideal time to share them.
> >
> > As for web browsing the history, our project was quickly convinced
> > gitweb is a lot better than cvsweb.  We are starting to get use to
> > basic git.  One developer works on CVS.  This is a bit handicapped,
> > but workable after a few patches to git-shell and git-cvsserver.
>
> Could you tell me a bit more about those patches and the need for using
> git-shell (haven't even messed with that yet).

One patch concerned handling "cvs update -p", which was accepted and I
guess will end up in the stable version someday.  One concerned handling
"cvs diff -c", which I never submitted.  I first tried a more general
approach to get diff option processing complete, but I had to backtrack
on that.  Now I have a quite simple hack, but more complete coverage of
diff option processing requires a bit more perl knowledge than I have.

I submitted a patch for shell.c to make it call "git cvsserver server"
if a commandline "cvs server" was passed to it, so you can do CVS+SSH
compatible to normal CVS.  I got so many comments I decided to keep it
for myself for now.

> I don't think we need to have any developers continuing to use CVS;
> but I may be wrong. I think I read that there's a limitation to being
> on the main branch and unfortunately most of out tags are on a release
> branch.

No, you can checkout any GIT branch as it it were a CVS module.

	--- Jan
