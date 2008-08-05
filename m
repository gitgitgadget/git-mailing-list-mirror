From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-cvsimport.perl: Print "UNKNOWN LINE..." on stderr,
	not stdout.
Date: Tue, 5 Aug 2008 11:35:59 -0400
Message-ID: <20080805153558.GA22111@sigill.intra.peff.net>
References: <87zlnro6kt.fsf@rho.meyering.net> <20080805152836.GB21901@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Tue Aug 05 17:37:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQOaz-0001bu-O0
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 17:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759638AbYHEPgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 11:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759305AbYHEPgD
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 11:36:03 -0400
Received: from peff.net ([208.65.91.99]:4784 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758181AbYHEPgB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 11:36:01 -0400
Received: (qmail 23929 invoked by uid 111); 5 Aug 2008 15:36:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 05 Aug 2008 11:36:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Aug 2008 11:35:59 -0400
Content-Disposition: inline
In-Reply-To: <20080805152836.GB21901@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91444>

On Tue, Aug 05, 2008 at 11:28:36AM -0400, Jeff King wrote:

>   $ perl -ne '/print (\S+)/ && print "$1\n" git-cvsimport.perl |
>     grep '^#' | wc -l

Urgh, somehow I managed to get a typo into my cut and paste. It should be

  grep '^"'

(i.e., we are getting rid of "print STDERR" and "print $fh"; this is
admittedly not very robust, but I just wanted an approximation of how
many there were).

-Peff
