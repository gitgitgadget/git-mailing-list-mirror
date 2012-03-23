From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] merging renames of empty files
Date: Thu, 22 Mar 2012 20:23:00 -0400
Message-ID: <20120323002300.GA15940@sigill.intra.peff.net>
References: <4F6B1F48.3040007@in.waw.pl>
 <20120322140140.GA8803@sigill.intra.peff.net>
 <7vty1gy3eh.fsf@alter.siamese.dyndns.org>
 <20120322175952.GA13069@sigill.intra.peff.net>
 <20120322182533.GA20360@sigill.intra.peff.net>
 <7v62dwxybd.fsf@alter.siamese.dyndns.org>
 <20120322190303.GA32756@sigill.intra.peff.net>
 <7vwr6cwiux.fsf@alter.siamese.dyndns.org>
 <20120322224651.GA14874@sigill.intra.peff.net>
 <7vpqc4us0u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Ralf Nyren <ralf.nyren@ericsson.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 01:23:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAsHd-0008B6-Qx
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 01:23:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754341Ab2CWAXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 20:23:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57078
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753474Ab2CWAXD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 20:23:03 -0400
Received: (qmail 8076 invoked by uid 107); 23 Mar 2012 00:23:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Mar 2012 20:23:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2012 20:23:00 -0400
Content-Disposition: inline
In-Reply-To: <7vpqc4us0u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193739>

On Thu, Mar 22, 2012 at 04:37:05PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Here's a 2-patch series to replace the old 3/3 (they go on top of the
> > first two cleanups from the previous iteration).
> 
> Hrm. As this is probably useful for older maintenance track, I would have
> preferred not to see the first one that touches sequencer.c that did not
> exist in the 1.7.7.x maintenance track, as the change is purely "cosmetic"
> and does not have anything to do with fixing the over-agressive merge.

I considered that, but assumed this was not a maint fix, but rather a
new "feature" to improve the heuristics. That being said, the first
patch is entirely unrelated.  The others don't depend on it textually or
semantically, and it does not need to be part of the series (I just
happened to notice it while in the area).

> I thought that our recommendation for keeping an otherwise empty
> directories around was to have .gitignore file with two entries in it,
> namely:
> 
> 	.*
>         *
> 
> So these files will be everywhere and without being empty, no?

I dunno. I have never recommended that, but maybe it is something people
do.

> But I tend to prefer the simplicity of limiting this to empty files
> anyway.

Yeah. We might want to do a gitattributes thing on top, but I'd much
rather have this in the meantime, as it seems like it handles the bulk
of the complaints we have actually seen on the list.

-Peff
