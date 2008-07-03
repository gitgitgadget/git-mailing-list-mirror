From: Petr Baudis <pasky@suse.cz>
Subject: Re: RFC: grafts generalised
Date: Thu, 3 Jul 2008 02:21:17 +0200
Message-ID: <20080703002117.GH12567@machine.or.cz>
References: <20080702143519.GA8391@cuci.nl> <m3lk0kfdo1.fsf@localhost.localdomain> <20080702173203.GA16235@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Jul 03 02:22:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KECaV-0002qY-L3
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 02:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbYGCAVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 20:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbYGCAVT
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 20:21:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52652 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623AbYGCAVS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 20:21:18 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 4CC0B2C4C04C; Thu,  3 Jul 2008 02:21:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080702173203.GA16235@cuci.nl>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87211>

On Wed, Jul 02, 2008 at 07:32:03PM +0200, Stephen R. van den Berg wrote:
> Also, the graft mechanism specifically is intended as a temporary
> solution until one uses filter-branch to "finalise" the result into a
> proper repository which becomes cloneable.

Grafts are _much_ older than filter-branch and I'm not sure where did
you get this idea; do we claim that in any documentation?

> >The fact that git-filter-branch (and earlier cg-admin-rewrite-hist)
> >respects grafts, and rewrites history so that grafts are no-op and are
> >not needed further is a bit of side-effect.
> 
> I beg to differ.  It's not a side effect, it's the proper way to get
> rid of the grafts file.  Grafts are temporary and ugly.  In proper
> repositories they are a sign of transition to a proper state.
> The proper state is attained by using git filter-branch.

There's nothing ugly or necessarily temporary about grafts. One example
of completely valid usage is adding previous history of a project to it
later.

First, you don't need to carry around all the archived baggage you are
probably rarely going to access anyway if you don't need to; changing a
VCS is ideal cutoff point.

Second, you don't need to worry about doing perfect conversion at the
moment of the switch.

Third, even if you think you have done it perfectly, it will turn out
later that something is wrong anyway.

Fourth, it may not be actually _clear_ what the canonical history should
be. Consider linux-kernel, you can graft the BitKeeper history (or one
of possible candidates for the ideal conversion, though one is AFAIK
clearly favoured), or you could also graft commit-per-tarball history
even from the times before BitKeeper; you certainly don't want either in
the current main history DAG.

-- 
				Petr "Pasky" Baudis
The last good thing written in C++ was the Pachelbel Canon. -- J. Olson
