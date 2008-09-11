From: Jeff King <peff@peff.net>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 17:46:50 -0400
Message-ID: <20080911214650.GB3187@coredump.intra.peff.net>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl> <200809111020.55115.jnareb@gmail.com> <20080911123148.GA2056@cuci.nl> <20080911135146.GE5082@mit.edu> <20080911153202.GD2056@cuci.nl> <20080911180037.GH5082@mit.edu> <20080911190335.GB1451@cuci.nl> <20080911200452.GM5082@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Thu Sep 11 23:48:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdu1B-0002JK-8H
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 23:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbYIKVqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 17:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753439AbYIKVqx
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 17:46:53 -0400
Received: from peff.net ([208.65.91.99]:2322 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384AbYIKVqw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 17:46:52 -0400
Received: (qmail 5992 invoked by uid 111); 11 Sep 2008 21:46:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 11 Sep 2008 17:46:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Sep 2008 17:46:50 -0400
Content-Disposition: inline
In-Reply-To: <20080911200452.GM5082@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95652>

On Thu, Sep 11, 2008 at 04:04:53PM -0400, Theodore Tso wrote:

> > It will be q^..q, and specifically not p^..p, using ^p..p would be
> > lying.  We aim to document the evolvement of the patch in time.
> > Cherry-pick itself will always ignore the origin links present on the
> > old commit, it simply creates new ones as if the old ones didn't exist.
> 
> So if you never pull branch C (where commit q resides), there is no
> way for you to know that commits p and r are related.  How.... not
> useful.

That is a good point. Stephen has explained his workflow, and I can see
why he wants to reference the cherry-picked commits, and how he thinks
that the referenced commits will always be available in that workflow.
And obviously in Linus's workflow such references are basically useless,
and they should just not be generated.

But what about workflows in between? When I pull from some developer who
has added a weak reference to a particular commit SHA1, but I _don't_
have that commit, my next question "OK, so what was in that commit?".
What is the mechanism by which I find out more information on that SHA1?

Using a key that is meaningful to an external database (like a bug
tracker) means that you can go to that database to look up more
information.

-Peff
