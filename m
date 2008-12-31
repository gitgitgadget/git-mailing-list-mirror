From: Daniel Barkalow <barkalow@iabervon.org>
Subject: RE: for newbs = little exercise / tutorial / warmup for windows and
 other non-sophisticated new Git users :-) [Scanned]
Date: Tue, 30 Dec 2008 22:49:19 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0812302236190.19665@iabervon.org>
References: <BB5F02FD3789B54E8964D38D6775E718242D35@ALTMORE-SVR.altmore.local> <alpine.LNX.1.00.0812302143210.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Whiteside <jeff.m.whiteside@gmail.com>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Conor Rafferty <conor.rafferty@altmore.co.uk>
X-From: git-owner@vger.kernel.org Wed Dec 31 04:53:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHs9M-0003Y4-Bh
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 04:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728AbYLaDtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 22:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752230AbYLaDtV
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 22:49:21 -0500
Received: from iabervon.org ([66.92.72.58]:55907 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751813AbYLaDtU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 22:49:20 -0500
Received: (qmail 27095 invoked by uid 1000); 31 Dec 2008 03:49:19 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Dec 2008 03:49:19 -0000
In-Reply-To: <alpine.LNX.1.00.0812302143210.19665@iabervon.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104248>

On Tue, 30 Dec 2008, Daniel Barkalow wrote:

> On Wed, 31 Dec 2008, Conor Rafferty wrote:
> 
> > -----Original Message-----
> > wtf is wrong with
> > 
> > git checkout <something>
> > 
> > ??
> > 
> > ** It doesn't reliably put the files that were in that revision into the
> > working directory - a fairly major flaw, for what I'm using SCM for (and
> > 80% of the market IMHO)
> 
> It certainly does for me; I rely on it pretty much constantly. Can you 
> give a sequence of commands (ideally the whole sequence from the "git 
> init") that leads to a difference?

Actually, I know what you must be doing:

$ git tag versionD
$ git checkout versionA
(versionA in the working directory)
$ rm *.*
(versionA with ABC.txt and AC.txt deleted)
$ git checkout versionB
(versionB with ABC.txt and AC.txt deleted)

If you've made any changes (including deleting files), "git checkout" (no 
pathes) will preserve them. On the other hand, it will remove files that 
are in the commit you're leaving and not in the commit you're going to. So 
just don't remove the working directory files and you should be all set.

In order to get them back if you have removed them, you can do:

$ git checkout .

This will discard all of the changes you've made only to the working 
directory; i.e., it'll recover the deleted files. You should also try "git 
status" whenever anything's mysterious, because it will tell you what's 
going on.

	-Daniel
*This .sig left intentionally blank*
