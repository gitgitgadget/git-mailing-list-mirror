From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] branch --edit-description: protect against mistyped
 branch name
Date: Sun, 5 Feb 2012 23:20:43 -0500
Message-ID: <20120206042043.GC29365@sigill.intra.peff.net>
References: <4F24E287.3040302@alum.mit.edu>
 <7vwr8bvvxj.fsf@alter.siamese.dyndns.org>
 <4F263AEE.4080409@alum.mit.edu>
 <7v39axc9gp.fsf@alter.siamese.dyndns.org>
 <20120130214842.GA16149@sigill.intra.peff.net>
 <7vaa4wda60.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 05:20:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuG4R-0007Gw-2S
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 05:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621Ab2BFEUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 23:20:46 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58542
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753454Ab2BFEUp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 23:20:45 -0500
Received: (qmail 22612 invoked by uid 107); 6 Feb 2012 04:27:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 05 Feb 2012 23:27:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Feb 2012 23:20:43 -0500
Content-Disposition: inline
In-Reply-To: <7vaa4wda60.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190007>

On Sun, Feb 05, 2012 at 05:26:31PM -0800, Junio C Hamano wrote:

> This incidentally also errors out --edit-description when the HEAD points
> at an unborn branch (immediately after "init", or "checkout --orphan"),
> because at that point, you do not even have any commit that is part of
> your history and there is no point in describing how this particular
> branch is different from the branch it forked off of, which is the useful
> bit of information the branch description is designed to capture.
> 
> We may want to special case the unborn case later, but that is outside the
> scope of this patch to prevent more common mistakes before 1.7.9 series
> gains too much widespread use.

That sounds OK to me. I'm not even sure people will want to use
"--edit-description" on an unborn pointed-to branch or not (I mentioned
it only as "this is a plausible use case to me that we might be
breaking"). I think people will still be figuring out workflows around
it. So it's not a big deal to wait and see.

-Peff
