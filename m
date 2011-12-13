From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Revert "http: don't always prompt for password"
Date: Tue, 13 Dec 2011 18:20:53 -0500
Message-ID: <20111213232053.GE12432@sigill.intra.peff.net>
References: <20111213201704.GA12072@sigill.intra.peff.net>
 <20111213202508.GA12187@sigill.intra.peff.net>
 <7vaa6wuqjt.fsf@alter.siamese.dyndns.org>
 <20111213231909.GD12432@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Naewe <stefan.naewe@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Eric <eric.advincula@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 00:21:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rabee-0001G7-WD
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 00:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363Ab1LMXU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 18:20:56 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49844
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753639Ab1LMXUz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 18:20:55 -0500
Received: (qmail 25252 invoked by uid 107); 13 Dec 2011 23:27:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Dec 2011 18:27:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2011 18:20:53 -0500
Content-Disposition: inline
In-Reply-To: <20111213231909.GD12432@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187076>

On Tue, Dec 13, 2011 at 06:19:09PM -0500, Jeff King wrote:

> > Or just let the "dumb HTTP" die.
> > 
> > I thought push over DAV has long been dead; is anybody using it for real?
> 
> For the record, I have no problem whatsoever with letting it die. I just
> think we probably shouldn't do it accidentally during a release. ;)

BTW, one other solution, rather than reverting Stefan's patch, is to
just re-add the "unconditionally ask for a password" behavior back to
git-http-push, but not to the fetching side. Especially if we hope to
kill off git-http-push soon (after a deprecation period presumably),
then that lets it work in the meantime without hurting the other http
code. And it's really easy to do.

-Peff
