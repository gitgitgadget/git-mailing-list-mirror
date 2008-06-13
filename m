From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add test-tr: poor-man tr
Date: Fri, 13 Jun 2008 02:02:15 -0400
Message-ID: <20080613060215.GB26768@sigill.intra.peff.net>
References: <20080611182501.GA3344@steel.home> <20080611225448.GC19474@sigill.intra.peff.net> <20080612060152.GA3798@steel.home> <20080612062309.GA31816@sigill.intra.peff.net> <20080612203245.GB8057@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 08:03:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K72NT-0001KH-LP
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 08:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbYFMGCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 02:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752945AbYFMGCS
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 02:02:18 -0400
Received: from peff.net ([208.65.91.99]:2991 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752096AbYFMGCR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 02:02:17 -0400
Received: (qmail 28444 invoked by uid 111); 13 Jun 2008 06:02:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 13 Jun 2008 02:02:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2008 02:02:15 -0400
Content-Disposition: inline
In-Reply-To: <20080612203245.GB8057@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84838>

On Thu, Jun 12, 2008 at 10:32:45PM +0200, Alex Riesen wrote:

> That was the problem. ActiveState Perl always replaces LF in the
> output with CRLF, which caused mismatches with template files in some
> tests (even the generated templates had LF line endings, cygwins tools
> follow that convention). At first, I tried to get by putting
> "binmode(STDOUT)" into every test, but this became boring with a time.
> Besides, the lines get very long and ugly (and make conflict resolving
> harder).

Does ActiveState respect the PERLIO environment variable? I haven't
played with it much, but my understanding is that setting
PERLIO=:unix:perlio should give you sane behavior (the default on
Windows should be PERLIO=:unix:crlf).

> > So I am not opposed to test-tr, I just wanted you to explain it better
> > in the commit log. ;)
> 
> I already tried.

I think this thread and the improved commit message have helped.

-Peff
