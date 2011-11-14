From: Jeff King <peff@peff.net>
Subject: Re: Git shouldn't allow to push a new branch called HEAD
Date: Mon, 14 Nov 2011 15:26:42 -0500
Message-ID: <20111114202642.GB26269@sigill.intra.peff.net>
References: <1318591877.2938.20.camel@mastroc3.mobc3.local>
 <1318592153.2938.21.camel@mastroc3.mobc3.local>
 <1321261662.2941.13.camel@mastroc3.mobc3.local>
 <4EC0F15A.9010502@alum.mit.edu>
 <20111114111659.GC10847@sigill.intra.peff.net>
 <7vbosejvx8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Daniele Segato <daniele.bilug@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 21:26:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ37B-00067M-4Z
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 21:26:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756206Ab1KNU0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 15:26:44 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41275
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754537Ab1KNU0o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 15:26:44 -0500
Received: (qmail 31704 invoked by uid 107); 14 Nov 2011 20:26:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Nov 2011 15:26:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2011 15:26:42 -0500
Content-Disposition: inline
In-Reply-To: <7vbosejvx8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185400>

On Mon, Nov 14, 2011 at 12:22:59PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So one solution is to block fetching of remote branches called HEAD
> > (which I would be OK with). But another is...
> > ... Obviously there's a lot more to it than just tweaking the default fetch
> > refspecs. The ref lookup rules need to be changed to take this into
> > account. There was some discussion about this over the summer (under the
> > subject of possible "1.8.0" changes), but I don't think any work has
> > been done.
> 
> I would say discussing and ironing out the kinks of the design counts as
> work, but I agree nobody was seriously interested in laying out a sensible
> transition plan and discussion died out before anything concrete happened.

Yeah, I should have said "...has been done since then".

> Regardless of the layout chanage, which probably is a 2.X topic, I think a
> good first step would be to start forbidding anything that ends with _?HEAD
> as a branch or tag name, on top of Michael's "enforce the refname rules more
> vigorously when a ref is created" series.

Agreed. Changing the layout is a long-term fix, and I think disallowing
HEAD is a reasonable stop-gap measure.

-Peff
