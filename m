From: Jeff King <peff@peff.net>
Subject: Re: trim_common_tail bug?
Date: Sat, 15 Dec 2007 15:02:02 -0500
Message-ID: <20071215200202.GA3334@sigill.intra.peff.net>
References: <20071215111621.GA8139@coredump.intra.peff.net> <20071215155150.GA24810@coredump.intra.peff.net> <7vprx7n90t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 21:02:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3dDS-00009n-8h
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 21:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757227AbXLOUCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 15:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754802AbXLOUCG
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 15:02:06 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1761 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757089AbXLOUCF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 15:02:05 -0500
Received: (qmail 18997 invoked by uid 111); 15 Dec 2007 20:02:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 15 Dec 2007 15:02:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Dec 2007 15:02:02 -0500
Content-Disposition: inline
In-Reply-To: <7vprx7n90t.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68411>

On Sat, Dec 15, 2007 at 09:49:06AM -0800, Junio C Hamano wrote:

> Shoot.  Thanks for spotting.
> 
> Wouldn't it be enough to do:
> 
>   	for (i = 0, recovered = 0; recovered < trimmed && i <= ctx; i++) {
> 		while (recovered < trimmed && ap[recovered++] != '\n')
> 	        	; /* nothing */
> 	}
> 
> then (warning: I haven't had my coffee yet)?

Yes, I think that is equivalent. My sleep-deprived brain keeps thinking
there must be a more clear way of writing this whole loop, but it
escapes me at the moment.

-Peff
