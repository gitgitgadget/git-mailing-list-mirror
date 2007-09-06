From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/7] Rework strbuf API and semantics.
Date: Thu, 6 Sep 2007 10:52:44 -0400
Message-ID: <20070906145244.GB3546@coredump.intra.peff.net>
References: <20070902224213.GB431@artemis.corp> <11890776114037-git-send-email-madcoder@debian.org> <118907761140-git-send-email-madcoder@debian.org> <Pine.LNX.4.64.0709061506330.28586@racer.site> <85bqcfdfc7.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 16:53:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITIix-0004BL-7i
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 16:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598AbXIFOwq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 10:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753758AbXIFOwq
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 10:52:46 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3398 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752667AbXIFOwq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 10:52:46 -0400
Received: (qmail 22237 invoked by uid 111); 6 Sep 2007 14:52:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 06 Sep 2007 10:52:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Sep 2007 10:52:44 -0400
Content-Disposition: inline
In-Reply-To: <85bqcfdfc7.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57888>

On Thu, Sep 06, 2007 at 04:43:36PM +0200, David Kastrup wrote:

> > Would not "struct strbuf sb = { 0 };" have the same effect?  (I am not so 
> > standards-keen as other people, who I have no doubt will gladly answer 
> > this one.)
> 
> AFAIR, non-specified static memory areas are initialized to zero bits,
> and NULL resp (void *)0 is not guaranteed to be represented by zero
> bits.

You are right that the NULL pointer is not necessarily represented as
zero bits, but static pointers are explicitly initialized to the NULL
pointer (not all-bits-zero).

-Peff
