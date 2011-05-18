From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add-interactive: shortcut to add hunk and quit
Date: Wed, 18 May 2011 02:45:15 -0400
Message-ID: <20110518064515.GA29612@sigill.intra.peff.net>
References: <20110517071232.GA19396@mrq1.org>
 <4DD369C3.4070806@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Hermann Gausterer <git-mailinglist@mrq1.org>,
	git list <git@vger.kernel.org>
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Wed May 18 08:45:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMaVY-0004mS-0Z
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 08:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952Ab1ERGpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 02:45:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49478
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752604Ab1ERGpR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 02:45:17 -0400
Received: (qmail 2399 invoked by uid 107); 18 May 2011 06:47:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 May 2011 02:47:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2011 02:45:15 -0400
Content-Disposition: inline
In-Reply-To: <4DD369C3.4070806@pcharlan.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173851>

On Tue, May 17, 2011 at 11:40:03PM -0700, Pete Harlan wrote:

> On 05/17/2011 12:12 AM, Hermann Gausterer wrote:
> > this combines the two "add -i" commands "y"+"q" to one.
> 
> ...
> 
> >         y - stage this hunk
> >         n - do not stage this hunk
> >         q - quit; do not stage this hunk nor any of the remaining ones
> > +       Q - stage this hunk but none of the remaining ones
> >         a - stage this hunk and all later hunks in the file
> >         d - do not stage this hunk nor any of the later hunks in the file
> >         g - select a hunk to go to
> 
> If "q" means "quit", I would expect "Q" to mean something like "quit
> immediately" (perhaps even undoing earlier adds), not "do something
> that 'q' wouldn't do, and then quit".

I agree. There was some discussion in another thread recently of the
atomicity of git-add (right now it applies the changes to each file
after all of its hunks are done). I would expect "q" to be "quit and
apply what I told you so far" and "Q" to be "quit and do not apply
anything".

> Perhaps "o" (for "stage exactly [o]ne commit"), or "t" for "stage
> [t]his commit" would be reasonable alternatives?

We could also allow multiple commands at once, like "yq" (even in
single-key mode, this would do the same thing).

-Peff
