From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] SunOS grep does not understand -C<n>
Date: Fri, 24 Jul 2009 01:41:45 -0400
Message-ID: <20090724054144.GC6563@sigill.intra.peff.net>
References: <7vr5w6tzq8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 07:41:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUDXW-0003Tw-Ef
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 07:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbZGXFlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 01:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbZGXFlr
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 01:41:47 -0400
Received: from peff.net ([208.65.91.99]:39502 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbZGXFlq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 01:41:46 -0400
Received: (qmail 14099 invoked by uid 107); 24 Jul 2009 05:43:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 24 Jul 2009 01:43:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jul 2009 01:41:45 -0400
Content-Disposition: inline
In-Reply-To: <7vr5w6tzq8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123904>

On Thu, Jul 23, 2009 at 10:30:07PM -0700, Junio C Hamano wrote:

> I noticed that the first "grep -C1" test in t7002 does not pass on my 
> SunOS-5.11-i86pc, and that is not because our way to spawn external
> grep is broken, but because the native grep does not understand -C<n>.
> 
> Is it just me and my installation (i.e. I might have failed to install
> saner grep from the distribution that everybody uses), or everybody on
> SunOS is using this option himself because our Makefile doesn't do that
> automatically for them?
> 
> Just in case it is the latter, here is a proposed patch.

Yes, I've been building with NO_EXTERNAL_GREP for my test box. The grep
from Solaris 8, at least, doesn't understand '-e' either, which causes
it to fail many other tests.

-Peff
