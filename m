From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: receive.denyCurrentBranch
Date: Mon, 9 Feb 2009 12:06:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902091204100.10279@pacific.mpi-cbg.de>
References: <20090208042910.19079.qmail@science.horizon.com> <alpine.DEB.1.00.0902081128420.10279@pacific.mpi-cbg.de> <76718490902080950r798ca02es4e560da35e499046@mail.gmail.com> <alpine.DEB.1.00.0902082149380.10279@pacific.mpi-cbg.de>
 <76718490902081451xd953e84y33de64cc82c1da42@mail.gmail.com> <alpine.DEB.1.00.0902090038550.10279@pacific.mpi-cbg.de> <76718490902081747s7a1ebe12yaf08665429a594c6@mail.gmail.com> <20090209050659.GA12655@mini-me.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jay Soffian <jaysoffian@gmail.com>,
	George Spelvin <linux@horizon.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 09 12:07:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWTzA-0004yS-Pm
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 12:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbZBILGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 06:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752635AbZBILGF
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 06:06:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:51965 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752308AbZBILGE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 06:06:04 -0500
Received: (qmail invoked by alias); 09 Feb 2009 11:06:00 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 09 Feb 2009 12:06:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/vcR5T177vVdy35IkvCXHWCI7kWzZ9nDnNaiEPxq
	6f8pRgOW/UAf+0
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090209050659.GA12655@mini-me.lan>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109063>

Hi,

On Mon, 9 Feb 2009, Theodore Tso wrote:

> On Sun, Feb 08, 2009 at 08:47:26PM -0500, Jay Soffian wrote:
> > I agree that a detached HEAD is a bad idea. The closest parallel that
> > I can come up with for git would be for receive-pack to store incoming
> > changes into separate branch hierarchy, NOT for it to detach HEAD. A
> > toy-patch I played around with earlier allowed this on the non-bare
> > upstream repo:
> > 
> > [receive]
> >      prefix = refs/remotes/incoming
> > 
> > Then a push to refs/heads/master was automatically stored as
> > refs/remotes/incoming/master instead.
> 
> What happens when the next person pushes to the same remote repo, and
> their refs/heads/master push is not a fast-forward merge of the
> current refs/remotes/incoming/master?
> 
> Do you lose the first user's push at that point?  Or do you refuse the
> push?

This is meant for non-bare repositories, right?  Repositories that do have 
reflogs...

Ciao,
Dscho

P.S.: There _have_ been times when I would have liked an automatic 
PUSH_HEAD that is always temporary, such as FETCH_HEAD.  I _could_ imagine 
that this is something we could do (opt-in, of course): storing what was 
already pushed in a PUSH_HEAD, even if the refs could not be updated.
