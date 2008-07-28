From: Jeff King <peff@peff.net>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a
	custom merge strategy
Date: Mon, 28 Jul 2008 14:56:04 -0400
Message-ID: <20080728185604.GA26322@sigill.intra.peff.net>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailinglist <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Mon Jul 28 20:57:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNXuB-0004Wp-Pu
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 20:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755842AbYG1S4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 14:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755674AbYG1S4J
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 14:56:09 -0400
Received: from peff.net ([208.65.91.99]:2047 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753311AbYG1S4I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 14:56:08 -0400
Received: (qmail 2291 invoked by uid 111); 28 Jul 2008 18:56:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 28 Jul 2008 14:56:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jul 2008 14:56:04 -0400
Content-Disposition: inline
In-Reply-To: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90485>

On Mon, Jul 28, 2008 at 04:54:17PM +0200, Sverre Rabbelier wrote:

> Thus resulting in a 'wrong way around' merge as part of master? It
> would say "Merge branch 'master' into otherbranch", while what
> happened was "Merge branch 'otherbranch' into master".
> 
> So, in short: what does the list think about adding
> "git-merge-theirs", that does (although possibly less 'hackish'):
> 
> cat > git-merge-theirs << EOF
> #!/bin/sh
> eval git read-tree --reset -u \\\$\$#
> EOF

I ran into this exact situation while showing somebody how awesome git
was, and it was a little embarrasing to say "oops, now we have to do
this backwards."

So I think it would be nice for completeness, although I admit that my
situation was rare (but no rarer, perhaps, than "-s ours").

-Peff

PS You may find your shell snippet a bit more readable by quoting 'EOF'.
