From: Jeff King <peff@peff.net>
Subject: Re: "prune" prone to clock skew (Re: t3306 failure with v1.7.5-rc1)
Date: Fri, 8 Apr 2011 14:53:25 -0400
Message-ID: <20110408185325.GA6337@sigill.intra.peff.net>
References: <4D9ECF7C.6010709@drmicha.warpmail.net>
 <4D9EB406.5080302@viscovery.net>
 <4D9EB57D.1060402@drmicha.warpmail.net>
 <4D9EBC41.4080501@drmicha.warpmail.net>
 <20110408163021.GB32709@sigill.intra.peff.net>
 <7vei5c4lwh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 20:53:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8GoH-0000uU-Md
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 20:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756993Ab1DHSx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 14:53:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44530
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756243Ab1DHSx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 14:53:28 -0400
Received: (qmail 3522 invoked by uid 107); 8 Apr 2011 18:54:15 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Apr 2011 14:54:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Apr 2011 14:53:25 -0400
Content-Disposition: inline
In-Reply-To: <7vei5c4lwh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171143>

On Fri, Apr 08, 2011 at 11:51:10AM -0700, Junio C Hamano wrote:

> I don't personally think this is worth addressing, but as I was Cc'ed,
> I'll try.
> 
> If we at least know that the object store is contained within a single
> filesystem whose clock is at least guaranteed to monotonically increase,
> one possible workaround would be to touch a garbage file and read its
> timestamp, instead of grabbing the current time from the local clock, no?

Yeah, that is a much more accurate and simpler fix. Like you, I don't
really think it's worth worrying about, but if somebody wanted to, that
is much better than the fix I mentioned.

-Peff
