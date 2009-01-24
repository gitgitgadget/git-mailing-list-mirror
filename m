From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] handle color.ui at a central place
Date: Sat, 24 Jan 2009 14:17:01 -0500
Message-ID: <20090124191700.GA17935@coredump.intra.peff.net>
References: <20090117153846.GB27071@coredump.intra.peff.net> <200901220113.32711.markus.heidelberg@web.de> <7vmydi4kiz.fsf@gitster.siamese.dyndns.org> <200901241228.33690.markus.heidelberg@web.de> <7vk58ko8k7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: markus.heidelberg@web.de,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 20:19:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQo24-00060k-KA
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 20:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678AbZAXTRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 14:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753363AbZAXTRE
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 14:17:04 -0500
Received: from peff.net ([208.65.91.99]:60747 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752942AbZAXTRE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 14:17:04 -0500
Received: (qmail 19110 invoked by uid 107); 24 Jan 2009 19:17:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 24 Jan 2009 14:17:09 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Jan 2009 14:17:01 -0500
Content-Disposition: inline
In-Reply-To: <7vk58ko8k7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106992>

On Sat, Jan 24, 2009 at 10:36:24AM -0800, Junio C Hamano wrote:

> Why should format-patch need to even worry about protecting itself from
> "color.ui" to begin with?

Agreed. In the "should I use color" function I proposed, there should be
a big fat "are_we_a_porcelain_that_will_allow_any_color_at_all" flag
at the top, which will make it totally clear how to make sure color is
off.

> You did not find the breakage in format-patch either to begin with; so
> your not finding does not give us much confidence that there is no other
> breakage, does it?
> 
> Grumble...

Sadly, this is an area that is not covered very well in the tests
(partially, I think, because it is "just" output which we tend to
neglect, and partially because the isatty() stuff is hard to test with
our harness). So I don't think it's _entirely_ Markus' fault.

-Peff
