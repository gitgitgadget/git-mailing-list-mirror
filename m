From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: JGIT: discuss: diff/patch implementation
Date: Tue, 11 Nov 2008 09:18:16 -0800
Message-ID: <20081111171816.GK2932@spearce.org>
References: <200811101522.13558.fg@one2team.net> <7v63mv5mro.fsf@gitster.siamese.dyndns.org> <1226398000.7541.11.camel@minastirith.xtradesoft.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Francis Galiegue <fg@one2team.net>,
	Git Mailing List <git@vger.kernel.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Raimund Bauer <ray007@gmx.net>
X-From: git-owner@vger.kernel.org Tue Nov 11 18:20:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzwtr-0007Qj-Pz
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 18:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbYKKRSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 12:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752469AbYKKRSS
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 12:18:18 -0500
Received: from george.spearce.org ([209.20.77.23]:39626 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbYKKRSR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 12:18:17 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id E70E8381FF; Tue, 11 Nov 2008 17:18:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1226398000.7541.11.camel@minastirith.xtradesoft.lan>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100656>

Raimund Bauer <ray007@gmx.net> wrote:
> On Mon, 2008-11-10 at 12:50 -0800, Junio C Hamano wrote:
> > Francis Galiegue <fg@one2team.net> writes:
> > 
> > > A very nice git feature, without even going as far as merges, is the cherry 
> > > pick feature.
> > 
> > I thought cherry-picking needs to be done in terms of 3-way merge, not
> > diff piped to patch, for correctness's sake.
> 
> What about http://sourceforge.net/projects/jlibdiff ?
> Maybe a bit old, but claims to have diff3 and is under LGPL.

I hadn't looked at that library before.

We've generally tried to avoid LGPL diff implementations, but partly
because any I found were ports from a GPL C based code tree to Java,
but then the guy who did the port went and changed the license
to LGPL.  Slightly dubious if you ask me.  ;-)

LGPL plays nicely with BSD, especially in Java where runtime
relinking is possible.  But it does screw with jgit.pgm's little
idea of "shove *everything* into a single shell script", as then
its not runtime re-linkable by the user.

I don't know how the Eclipse foundation feels about distributing
LGPL in the IDE.  One of our major reasons for going with a BSD
license on JGit was so the Eclipse Git team provider plugin could be
distributed alongside the CVS team provider, as part of the basic IDE
team provider package.  We're clearly not ready for that wide of a
distribution, but it was a goal Robin and I set out for the project.

-- 
Shawn.
