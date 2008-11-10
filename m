From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: JGIT: discuss: diff/patch implementation
Date: Mon, 10 Nov 2008 20:46:02 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811102030180.30769@pacific.mpi-cbg.de>
References: <200811101522.13558.fg@one2team.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Francis Galiegue <fg@one2team.net>
X-From: git-owner@vger.kernel.org Mon Nov 10 20:40:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzccB-0001D0-IY
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 20:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbYKJTim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 14:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbYKJTim
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 14:38:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:51449 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750773AbYKJTim (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 14:38:42 -0500
Received: (qmail invoked by alias); 10 Nov 2008 19:38:35 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp052) with SMTP; 10 Nov 2008 20:38:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/EGVpEFrHEETLN7iOnnSUrdevnwjBdq0/qQQfaI5
	8xfGQ1REI1fZiq
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200811101522.13558.fg@one2team.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100549>

Hi,

On Mon, 10 Nov 2008, Francis Galiegue wrote:

> A very nice git feature, without even going as far as merges, is the 
> cherry pick feature.
> 
> For this to be doable from within the Eclipse Git plugin, a diff/patch 
> implementation needs to be found, in a license compatible with the 
> current JGit license (3-clause BSD, as far as I can tell). Or a new 
> implementation can be rewritten from scratch, of course.

Do not forget creating efficient packs.  They also need an efficient diff 
engine.

> I found this:
> 
> http://code.google.com/p/google-diff-match-patch

Nice.

As was pointed out already, it is more meant to work on text than I'd like 
to, and it also seems to have cute DWIMery for HTML.

I did not find any implementation, so I started implementing my own 
version of Gene Myers' algorithm, with the plan to extend it with a 
patience diff option.

My code so far can generate a diff between two files, but does not use 
O(D) space (where D is the number of differences), but O(D^2), as I did 
not have enough time (a conference, and traveling around the world can do 
that to you).

Having looked at the source code of diff-patch-match, I admit that I do 
not understand enough of the algorithm with so little documentation, so I 
will continue my fun project.

Ciao,
Dscho
