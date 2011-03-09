From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git cat-file does not terminate
Date: Wed, 9 Mar 2011 16:43:23 -0500
Message-ID: <20110309214323.GB4400@sigill.intra.peff.net>
References: <4D70E340.3050309@tweerlei.de>
 <20110304154014.GE24660@m62s10.vlinux.de>
 <20110304160047.GA9662@sigill.intra.peff.net>
 <7vzkpa7qmp.fsf@alter.siamese.dyndns.org>
 <20110308211423.GB4594@sigill.intra.peff.net>
 <7vwrk9cjib.fsf@alter.siamese.dyndns.org>
 <4D779385.3070602@tweerlei.de>
 <7vzkp49jk3.fsf@alter.siamese.dyndns.org>
 <4D77DA52.7050701@tweerlei.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org
To: Robert Wruck <wruck@tweerlei.de>
X-From: git-owner@vger.kernel.org Wed Mar 09 22:43:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxRAO-0005R8-Tm
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 22:43:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525Ab1CIVnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 16:43:19 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53755
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753517Ab1CIVnR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 16:43:17 -0500
Received: (qmail 2617 invoked by uid 107); 9 Mar 2011 21:43:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Mar 2011 16:43:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Mar 2011 16:43:23 -0500
Content-Disposition: inline
In-Reply-To: <4D77DA52.7050701@tweerlei.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168766>

On Wed, Mar 09, 2011 at 08:51:46PM +0100, Robert Wruck wrote:

> >Thanks; it is not very critical so don't spend too much effort trying to
> >find a way to do so at runtime.  We can always use the approach Jeff's
> >Makefile patch took to make it safe (and potentially slow) by default on
> >all Cygwin while still allowing people on an unaffected version to turn
> >the workaround off while building.
> 
> The write() issue will presumably be fixed in the next cygwin
> release. I already have a version that works on WinXP where it used
> to fail.

Cool. Does our Makefile know the cygwin version number via "uname -r"?
We could at least tweak the build-time patch to turn it on for the right
versions (though we should perhaps wait for the fixed version to be
released so we know what it is. :) ).

Personally I wouldn't bother much with run-time detection. But maybe
cygwin people tend to download binary packages and run them on top of
arbitrary versions cygwin? I don't know what's normal.

-Peff
