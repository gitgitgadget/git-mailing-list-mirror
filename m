From: Jeff King <peff@peff.net>
Subject: Re: Strange effect merging empty file
Date: Thu, 22 Mar 2012 13:59:53 -0400
Message-ID: <20120322175952.GA13069@sigill.intra.peff.net>
References: <4F69AD3C.4070203@ericsson.com>
 <4F69B375.5050205@in.waw.pl>
 <86iphwomnq.fsf@red.stonehenge.com>
 <4F6B1F48.3040007@in.waw.pl>
 <20120322140140.GA8803@sigill.intra.peff.net>
 <7vty1gy3eh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Ralf Nyren <ralf.nyren@ericsson.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 19:00:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAmIq-0001uI-0p
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 19:00:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125Ab2CVR7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 13:59:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56775
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164Ab2CVR7y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 13:59:54 -0400
Received: (qmail 3032 invoked by uid 107); 22 Mar 2012 18:00:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Mar 2012 14:00:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2012 13:59:53 -0400
Content-Disposition: inline
In-Reply-To: <7vty1gy3eh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193673>

On Thu, Mar 22, 2012 at 10:03:02AM -0700, Junio C Hamano wrote:

> > I was thinking the same thing. And it seems this came up once before,
> > and the list seemed to favor special-casing merge-recursive (but not
> > diffcore):
> >
> >   http://thread.gmane.org/gmane.comp.version-control.git/116917/focus=117082
> 
> Yeah, thanks for digging up the old thread. I was looking at the patch to
> merge-recursive from Dscho on that thread and I think it identified the
> place that needs patching correctly. I was on a tablet, without the access
> to the surrounding code outside the patch context, so I do not know if the
> logic to detect the pure-rename of an empty file in the patch was correct,
> or the patch still applies to the current codebase, though.

It's easy to apply the patch manually, and I have written a test.
However, it seems to cause lots of other parts of t6022 to fail. I'll
try to dig up the cause.

-Peff
