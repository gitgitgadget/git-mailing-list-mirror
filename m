From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git-filter-branch.sh: Allow running in bare
	repositories
Date: Thu, 24 Jul 2008 00:06:57 +0200
Message-ID: <20080723220657.GA10151@machine.or.cz>
References: <7v8wvtjwa8.fsf@gitster.siamese.dyndns.org> <20080723215509.32438.49155.stgit@localhost> <alpine.DEB.1.00.0807232257500.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 00:08:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLmV7-0004lB-Do
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 00:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbYGWWG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 18:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753692AbYGWWG7
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 18:06:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50022 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752649AbYGWWG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 18:06:59 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id E27C7393A36E; Thu, 24 Jul 2008 00:06:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807232257500.8986@racer>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89790>

  Hi,

On Wed, Jul 23, 2008 at 10:59:03PM +0100, Johannes Schindelin wrote:
> On Wed, 23 Jul 2008, Petr Baudis wrote:
> 
> > Commit 46eb449c restricted git-filter-branch to non-bare repositories
> > unnecessarily; git-filter-branch can work on bare repositories just
> > fine.
> > 
> > Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> Funny, I did not get Cc:ed.

  sorry, I have to copy the Cc around manually with StGIT. :/

> > -git diff-files --quiet &&
> > -	git diff-index --cached --quiet HEAD -- ||
> > -	die "Cannot rewrite branch(es) with a dirty working directory."
> > +if [ "$(is_bare_repository)" = false ]; then
> > +	git diff-files --quiet &&
> > +		git diff-index --cached --quiet HEAD --) ||
> 
>                                                        ^
> 
> I doubt this has ever passed the test suite, let alone run.

  It did... provided that I didn't make after modifying the script.

> Besides, this extra-funny extra indent is quite brutal on my eyes.

  I kept the original indentation.

				Petr "Pasky" Baudis
