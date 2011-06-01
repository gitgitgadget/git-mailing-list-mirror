From: Jeff King <peff@peff.net>
Subject: Re: Unable to fork off sideband demultiplexer
Date: Wed, 1 Jun 2011 13:35:25 -0400
Message-ID: <20110601173524.GF7132@sigill.intra.peff.net>
References: <loom.20110601T161508-689@post.gmane.org>
 <7vk4d5h3qt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Randy Brandenburg <randy.brandenburg@woh.rr.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 19:35:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRpKP-0002PG-KQ
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 19:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759136Ab1FARf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 13:35:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40082
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759036Ab1FARf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 13:35:28 -0400
Received: (qmail 15148 invoked by uid 107); 1 Jun 2011 17:35:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Jun 2011 13:35:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2011 13:35:25 -0400
Content-Disposition: inline
In-Reply-To: <7vk4d5h3qt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174885>

On Wed, Jun 01, 2011 at 10:15:54AM -0700, Junio C Hamano wrote:

> Randy Brandenburg <randy.brandenburg@woh.rr.com> writes:
> 
> > # git push
> > error: cannot create thread: Unknown error 
> 
> Perhaps threading library does not really work on your platform? Does
> rebuilding git with "make NO_PTHREADS=YesPlease" help?

I suspect it is more subtle than that. We've had several people recently
reporting the same issue, and all are using pre-built binaries on
Solaris 9. Given the weird errno value ("unknown error"), my guess is
that the packages are built on Solaris 10, and there is some ABI
incompatibility between the two platforms.

I'd be curious if building on Solaris 9, even without NO_PTHREADS set,
fixes the issue.

-Peff
