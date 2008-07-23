From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-filter-branch.sh: Allow running in bare
 repositories
Date: Wed, 23 Jul 2008 22:59:03 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807232257500.8986@racer>
References: <7v8wvtjwa8.fsf@gitster.siamese.dyndns.org> <20080723215509.32438.49155.stgit@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 24 00:00:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLmNR-00029d-Bw
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 00:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353AbYGWV7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 17:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbYGWV7E
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 17:59:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:34414 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752581AbYGWV7D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 17:59:03 -0400
Received: (qmail invoked by alias); 23 Jul 2008 21:58:59 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp005) with SMTP; 23 Jul 2008 23:58:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ZyFpoHswZ5ADUAWLqBZPptXOg3yI9uRIbfW448I
	vtqntjnremorFP
X-X-Sender: gene099@racer
In-Reply-To: <20080723215509.32438.49155.stgit@localhost>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89787>

Hi,

On Wed, 23 Jul 2008, Petr Baudis wrote:

> Commit 46eb449c restricted git-filter-branch to non-bare repositories
> unnecessarily; git-filter-branch can work on bare repositories just
> fine.
> 
> Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Funny, I did not get Cc:ed.

> -git diff-files --quiet &&
> -	git diff-index --cached --quiet HEAD -- ||
> -	die "Cannot rewrite branch(es) with a dirty working directory."
> +if [ "$(is_bare_repository)" = false ]; then
> +	git diff-files --quiet &&
> +		git diff-index --cached --quiet HEAD --) ||

                                                       ^

I doubt this has ever passed the test suite, let alone run.

Besides, this extra-funny extra indent is quite brutal on my eyes.

Ciao,
Dscho
