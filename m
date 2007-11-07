From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in
 git, help users out.
Date: Wed, 7 Nov 2007 11:08:04 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711071103450.4362@racer.site>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org>
 <200711062106.57083.robin.rosenberg.lists@dewire.com> <20071106201324.GA30262@glandium.org>
 <200711062221.58475.robin.rosenberg.lists@dewire.com>
 <Pine.LNX.4.64.0711062225090.4362@racer.site> <20071107081608.GA19066@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 12:08:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipiln-00065f-08
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 12:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbXKGLIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 06:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbXKGLIK
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 06:08:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:45332 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750695AbXKGLIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 06:08:09 -0500
Received: (qmail invoked by alias); 07 Nov 2007 11:08:07 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp021) with SMTP; 07 Nov 2007 12:08:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/R2fMZosLRYT8v8t22ZwSX0Dv8LLlkjeTbjIsFjB
	u8XP/gNK7nU/m/
X-X-Sender: gene099@racer.site
In-Reply-To: <20071107081608.GA19066@glandium.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63804>

Hi,

On Wed, 7 Nov 2007, Mike Hommey wrote:

> On Tue, Nov 06, 2007 at 10:25:48PM +0000, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > On Tue, 6 Nov 2007, Robin Rosenberg wrote:
> > 
> > > tisdag 06 november 2007 skrev Mike Hommey:
> > > > Maybe the documentation could emphasise on how to undo things when 
> > > > the user makes mistakes. Sometimes, saving your repo can be as 
> > > > simple as git reset --hard HEAD@{1}. This is not, unfortunately, a 
> > > > works-for-all-cases command.
> > > 
> > > Yea, git-undo(7). 
> > 
> > In related news, I know a few users who need an un-rm-rf.  Anyone?
> 
> The fact is you can do harm to your repo with things you wouldn't expect 
> to break things, except maybe you gave bad arguments or so. It's quite 
> easy to fuck up with git-rebase, or to merge the wrong commits, etc.

I don't see how these commands are dangerous.  Usually you just look into 
the reflog, pick the one commit you started with, and reset --hard.

The _only_ commands I find dangerous are "git stash clear" and "git reflog 
--expire=0".  Funnily, people want to do that all the time.

Like recently, on the IRC channel, where somebody lost patches "during a 
rebase", by "rm -rf .dotest".

There will be a point where nobody can help.  But before that, reflogs are 
your friend.  But you must not do "reset --hard HEAD@{1}" blindly.  You 
have to look first what the reflogs are.

Ciao,
Dscho
