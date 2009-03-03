From: Jeff King <peff@peff.net>
Subject: Re: remote branches, and branch names in general
Date: Tue, 3 Mar 2009 04:05:50 -0500
Message-ID: <20090303090550.GF3627@coredump.intra.peff.net>
References: <450196A1AAAE4B42A00A8B27A59278E709F07398@EXCHANGE.trad.tradestation.com> <m3vdqrtp84.fsf@localhost.localdomain> <20090303041631.GB18136@coredump.intra.peff.net> <200903030958.56150.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	John Dlugosz <JDlugosz@tradestation.com>, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 03 10:08:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeQbA-0001bi-VF
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 10:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246AbZCCJF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 04:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753525AbZCCJFz
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 04:05:55 -0500
Received: from peff.net ([208.65.91.99]:55824 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753409AbZCCJFy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 04:05:54 -0500
Received: (qmail 14256 invoked by uid 107); 3 Mar 2009 09:05:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 03 Mar 2009 04:05:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Mar 2009 04:05:50 -0500
Content-Disposition: inline
In-Reply-To: <200903030958.56150.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112036>

On Tue, Mar 03, 2009 at 09:58:55AM +0100, Markus Heidelberg wrote:

> > Yes. I don't know if they are documented anywhere, but the complete
> > lookup order is:
> > 
> >   $ git grep -h -A8 ref_rev_parse_rules refs.c
> >   const char *ref_rev_parse_rules[] = {
> >           "%.*s",
> >           "refs/%.*s",
> >           "refs/tags/%.*s",
> >           "refs/heads/%.*s",
> >           "refs/remotes/%.*s",
> >           "refs/remotes/%.*s/HEAD",
> >           NULL
> >   };
> 
> Documented in git-rev-parse -> specifying revisions.

Oh, indeed. Thanks for pointing it out.

Though I think this may be part of what people mean when they say git
documentation sucks. I had no idea where to look for such a thing, and
it turns out it is in the manpage for a plumbing command that in theory
I should never have to use.

-Peff
