From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now
 incompatible with Cygwin (and probably Windows)
Date: Mon, 26 May 2008 15:25:58 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805261521130.30431@racer>
References: <483AC2CE.7090801@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 26 16:26:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0dev-0007dN-Rh
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 16:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755092AbYEZOZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 10:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755323AbYEZOZy
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 10:25:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:36803 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754987AbYEZOZx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 10:25:53 -0400
Received: (qmail invoked by alias); 26 May 2008 14:25:51 -0000
Received: from R4980.r.pppool.de (EHLO racer.local) [89.54.73.128]
  by mail.gmx.net (mp038) with SMTP; 26 May 2008 16:25:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/4JTNvWmL4QVrR1D7zISO22c5NzHRuIIRkIyplj2
	gM5g/4HHNDTqce
X-X-Sender: gene099@racer
In-Reply-To: <483AC2CE.7090801@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82936>

Hi,

On Mon, 26 May 2008, Mark Levedahl wrote:

> Beginning with the referenced commit, the git project cannot be checked 
> out on Cygwin (and I assume cannot be checked out on Windows using 
> msysgit, though I have not verified this) as this commit introduces the 
> file "t/5100/nul." On Windows, the file name "nul" is reserved, 
> regardless of path, and cannot be created or deleted. It serves 
> essentially the same function as /dev/null.

Even when referencing the full (or a relative) path?  That's bad!

> As a for instance of the troubles:
> 
> git>git checkout -f origin/master
> Previous HEAD position was a2f5be5... Merge branch
> 'jk/maint-send-email-compose' into maint
> error: git-checkout-index: unable to create file t/t5100/nul (File exists)
> 
> As this commit is part of the published master branch, I am not sure the 
> correct resolution: leaving this commit in place means that any commit 
> between it and a commit fixing this will always cause an error on Cygwin 
> / Windows. Of course, it *is* on the published master branch.

That's the case for all regressions: we do not rewrite history for them.

As for the resolution, could you quickly try the 'my-next' branch of 
git://repo.or.cz/git/dscho.git?

If that works, I'll send a proper patch to Junio.

Ciao,
Dscho
