From: Jeff King <peff@peff.net>
Subject: Re: git-push: creating branch on remote, refspec format
Date: Thu, 26 Feb 2009 08:18:26 -0500
Message-ID: <20090226131826.GB7911@coredump.intra.peff.net>
References: <go609m$3dj$2@ger.gmane.org> <49A6863D.9000900@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lasse Kliemann <lasse-gmane-git-2009@mail.plastictree.net>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 26 14:20:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcg9e-000660-NZ
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 14:19:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199AbZBZNSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 08:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753295AbZBZNSb
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 08:18:31 -0500
Received: from peff.net ([208.65.91.99]:40574 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753012AbZBZNSa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 08:18:30 -0500
Received: (qmail 4793 invoked by uid 107); 26 Feb 2009 13:18:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 26 Feb 2009 08:18:54 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Feb 2009 08:18:26 -0500
Content-Disposition: inline
In-Reply-To: <49A6863D.9000900@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111559>

On Thu, Feb 26, 2009 at 01:08:29PM +0100, Michael J Gruber wrote:

> > $ git push /tmp/a master:foo
> [...]
> 
> You're using the very same form as the doc. "This form" in the doc
> refers to "repo refspec", i.e. something like "a b:c", which is what you
> use. The "refs/heads/" part is just there to disambiguate between
> possible different matches on the remote side (refs/heads/foo,
> refs/tags/foo, refs/remotes/bar/foo, ...).

Actually, it used to be that case that git would complain unless "foo"
was properly qualified; this was fixed in f8aae12 (push: allow
unqualified dest refspecs to DWIM, 2008-04-23), which is in v1.5.5.2.

The doc in question was added around v1.5.3. So I think it is simply
that it was never updated to match the new behavior. That paragraph
could probably even just be deleted, since there is no syntactic
difference between pushing to an existing branch and creating a new
branch (alternatively, it can say explicitly that creating a new branch
is the same as pushing to one).

-Peff
