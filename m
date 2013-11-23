From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] drop support for "experimental" loose objects
Date: Fri, 22 Nov 2013 19:30:14 -0500
Message-ID: <20131123003014.GA11012@sigill.intra.peff.net>
References: <20131120203350.GA31139@kitenet.net>
 <20131120213348.GA29004@sigill.intra.peff.net>
 <20131120222805.GC26468@kitenet.net>
 <20131121114157.GA7171@sigill.intra.peff.net>
 <20131121114837.GB7171@sigill.intra.peff.net>
 <20131123002405.GK4212@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 23 01:30:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vk17C-0002Ns-5T
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 01:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755588Ab3KWAaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 19:30:17 -0500
Received: from cloud.peff.net ([50.56.180.127]:44087 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755486Ab3KWAaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 19:30:16 -0500
Received: (qmail 24831 invoked by uid 102); 23 Nov 2013 00:30:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Nov 2013 18:30:16 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Nov 2013 19:30:14 -0500
Content-Disposition: inline
In-Reply-To: <20131123002405.GK4212@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238224>

On Fri, Nov 22, 2013 at 04:24:05PM -0800, Jonathan Nieder wrote:

> >  t/t1013-loose-object-format.sh                     |  66 ------------------
> 
> Hmm, not all of these tests are about the "experimental" format.  Do
> we really want to remove them all?

I think so. They were not all testing the experimental format, but they
were about making sure the is-it-experimental heuristic triggered
properly with various zlib settings.

Now that we do not apply that heuristic, there is nothing (in git) to
test. We feed the contents straight to zlib. We could keep the objects
with small window size as a test, but we are not really testing git; we
are testing zlib at that point.

-Peff
