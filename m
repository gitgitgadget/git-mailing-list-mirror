From: Jeff King <peff@peff.net>
Subject: Re: RFC: "git config -l" should not expose sensitive information
Date: Thu, 20 Dec 2012 10:54:44 -0500
Message-ID: <20121220155444.GB6008@sigill.intra.peff.net>
References: <50CF039A.7010800@gmx.de>
 <20121220150408.GD27211@sigill.intra.peff.net>
 <50D33409.1050309@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Dec 20 16:55:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TliSe-0008Pf-Om
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 16:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114Ab2LTPyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 10:54:47 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59760 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119Ab2LTPyq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 10:54:46 -0500
Received: (qmail 10415 invoked by uid 107); 20 Dec 2012 15:55:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Dec 2012 10:55:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Dec 2012 10:54:44 -0500
Content-Disposition: inline
In-Reply-To: <50D33409.1050309@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211902>

On Thu, Dec 20, 2012 at 04:51:37PM +0100, Michael Haggerty wrote:

> > The problem seems to be that people are giving bad advice to tell people
> > to post "git config -l" output without looking at. Maybe we could help
> > them with a "git config --share-config" option that dumps all config,
> > but sanitizes the output. It would need to have a list of sensitive keys
> > (which does not exist yet), and would need to not just mark up things
> > like smtppass, but would also need to pull credential information out of
> > remote.*.url strings. And maybe more (I haven't thought too long on it).
> 
> I think the problem is yet another step earlier: why do we build tools
> that encourage people to store passwords in plaintext in a configuration
> file that is by default world-readable?

Agreed. Most of it is hysterical raisins. We did not have any portable
secure storage for a long time. These days we have the credential helper
subsystem, which send-email can and should be using.

-Peff
