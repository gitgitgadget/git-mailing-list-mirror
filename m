From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-cvsimport.perl: Print "UNKNOWN LINE..." on stderr,
	not stdout.
Date: Tue, 5 Aug 2008 11:28:36 -0400
Message-ID: <20080805152836.GB21901@sigill.intra.peff.net>
References: <87zlnro6kt.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Tue Aug 05 17:29:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQOTm-0007B0-Ej
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 17:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759482AbYHEP2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 11:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759187AbYHEP2k
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 11:28:40 -0400
Received: from peff.net ([208.65.91.99]:4615 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758642AbYHEP2j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 11:28:39 -0400
Received: (qmail 23866 invoked by uid 111); 5 Aug 2008 15:28:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 05 Aug 2008 11:28:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Aug 2008 11:28:36 -0400
Content-Disposition: inline
In-Reply-To: <87zlnro6kt.fsf@rho.meyering.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91443>

On Tue, Aug 05, 2008 at 04:54:42PM +0200, Jim Meyering wrote:

> I'm used to filtering git-cvsimport's noisy stderr, but this
> diagnostic appears on stdout.  Looks like an oversight.
> Now that I'm using cvsps-2.2b1, I see tons of these.

There are a ton of things that go to stdout:

  $ perl -ne '/print (\S+)/ && print "$1\n" git-cvsimport.perl |
    grep '^#' | wc -l
  18

though many are only activated via "-v". Maybe it is worth putting all
of them to stderr? I really don't see why cvsimport should ever produce
any output on stdout.

-Peff
