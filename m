From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git-init: set receive.guardCurrentBranch = true for
 non-bare repositories
Date: Mon, 24 Mar 2008 12:00:25 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803241158301.4353@racer.site>
References: <alpine.LSU.1.00.0803232142460.4353@racer.site> <alpine.LSU.1.00.0803232144070.4353@racer.site> <7v4pax3r6l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 12:01:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdkQO-0004u1-2K
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 12:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757492AbYCXLA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 07:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757500AbYCXLA0
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 07:00:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:53285 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756679AbYCXLAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 07:00:25 -0400
Received: (qmail invoked by alias); 24 Mar 2008 11:00:23 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp014) with SMTP; 24 Mar 2008 12:00:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18RjaIHkrURTd2Dkl1QbxSe7LWSiY7bEmyBjnwgDY
	kSweXtygGcDL8d
X-X-Sender: gene099@racer.site
In-Reply-To: <7v4pax3r6l.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78020>

Hi,

On Sun, 23 Mar 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > When initializing a non-bare repositories, you most likely want to 
> > avoid pushing into the current branch (because a push does not touch 
> > the working tree at all).
> 
> As I described in my other message, I suspect that treating the current 
> branch specially like this is a wrong approach.  The configuration might 
> be a good idea, but shouldn't it prevent any local branch from getting 
> updated?  Push into non-bare repository is simply a fetch run in reverse 
> direction.

That would break this work flow:

	# machine A
	$ git push B master:refs/heads/tmp

	# machine B
	$ git merge tmp
	$ git branch -d tmp

Besides, there is a _vital_ difference between the current branch, and any 
other local branch: pushing into other local branches cannot make your 
working tree stale.

Ciao,
Dscho
