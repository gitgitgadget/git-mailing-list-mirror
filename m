From: Jeff King <peff@peff.net>
Subject: Re: git-cvsimport bug
Date: Wed, 28 Nov 2007 13:55:04 -0500
Message-ID: <20071128185504.GA11236@coredump.intra.peff.net>
References: <20071127150136.GA50697@orion.lan> <20071128165746.GC20308@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Emanuele Giaquinta <e.giaquinta@glauco.it>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 19:56:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxS4z-0005N8-LN
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 19:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757841AbXK1SzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 13:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757875AbXK1SzI
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 13:55:08 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3683 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757940AbXK1SzG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 13:55:06 -0500
Received: (qmail 13162 invoked by uid 111); 28 Nov 2007 18:55:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 28 Nov 2007 13:55:05 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2007 13:55:04 -0500
Content-Disposition: inline
In-Reply-To: <20071128165746.GC20308@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66407>

On Wed, Nov 28, 2007 at 11:57:46AM -0500, Jeff King wrote:

> Some of git-cvsimport is quite old, and it accesses the ref files
> directly. It should be fairly easy to fix; I will post a patch in a few
> minutes.

The patch series is:

  1/3: Add basic cvsimport tests

       We had no tests before, so this at least gives a sanity check. I
       added a t9600 series, though perhaps the cvs-related tests
       (cvsserver and exportcommit) should collapse to a single t9[0-9]*
       series.

  2/3: cvsimport: use show-ref to support packed refs

       This fix is hopefully obvious, and the included test fails
       without it (and this should probably fix Emanuele's problem).

  3/3: cvsimport: miscellaneous packed-ref fixes

       This fixes all of the packed-ref problem spots I could find.
       However, I have no tests that show the problems or that verify
       that the fixes are sane. So apply with caution.

       Probably cvsimport would benefit greatly from a conversion to
       Git.pm, but that is likely to involve a lot of rewriting, and I
       have neither the time nor the inclination for that right now.

-Peff
