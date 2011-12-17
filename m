From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] attr: map builtin userdiff drivers to well-known
 extensions
Date: Fri, 16 Dec 2011 20:21:18 -0500
Message-ID: <20111217012118.GB20225@sigill.intra.peff.net>
References: <20111216110000.GA15676@sigill.intra.peff.net>
 <4EEB4F13.2010402@viscovery.net>
 <20111216192104.GA19924@sigill.intra.peff.net>
 <4EEBC0A7.3030303@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Dec 17 02:21:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbixp-0004qK-26
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 02:21:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760639Ab1LQBVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 20:21:21 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44483
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752732Ab1LQBVU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 20:21:20 -0500
Received: (qmail 9332 invoked by uid 107); 17 Dec 2011 01:28:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 Dec 2011 20:28:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Dec 2011 20:21:18 -0500
Content-Disposition: inline
In-Reply-To: <4EEBC0A7.3030303@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187344>

On Fri, Dec 16, 2011 at 11:05:27PM +0100, Johannes Sixt wrote:

> Am 16.12.2011 20:21, schrieb Jeff King:
> > I'm not clear from what you wrote on whether you were saying it is
> > simply sub-optimal, or whether on balance it is way worse than the
> > default funcname matching.
> 
> I'm saying the latter. Okay, we're talking "only" about hunk headers.
> But when you are reviewing patches, they are *extremely* useful and a
> time-saver; when they are wrong or not present, they are exactly the
> opposite.

Right. I don't think it is worth arguing "well, it's only funcname
headers". Because that same argument applies to both the advantages
(i.e., hopefully with the patch we are generating better funcname
headers) and disadvantage (i.e., it seems that we might be generating
worse funcname headers).

So it is really a question of "how good" or "how bad" for each style.

> Sure I have. What I didn't say (sorry for that!), but wanted to hint at
> is that this is to experiment with a pattern in order to ultimately
> improve the built-in pattern. The topic came up just the other day, and
> I took Thomas Rast's suggestion to experiment with a simplified pattern:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/186355/focus=186439
> 
> But as is, the built-in pattern misses way too many anchor points in C++
> code.

Yeah, I can certainly agree that the patterns could be better.

Maybe we should just table the extension mapping for now, then, and see
if the patterns improve? Or maybe just drop the C ones (and probably the
objc one based on other parts of the thread) and do the rest?

-Peff
