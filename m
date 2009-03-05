From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Mar 2009, #02; Thu, 05)
Date: Thu, 5 Mar 2009 06:00:51 -0500
Message-ID: <20090305110051.GA17921@coredump.intra.peff.net>
References: <7vbpsg2sgx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 12:02:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfBLf-0000GB-Dx
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 12:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbZCELBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 06:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752774AbZCELBA
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 06:01:00 -0500
Received: from peff.net ([208.65.91.99]:36986 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191AbZCELBA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 06:01:00 -0500
Received: (qmail 30059 invoked by uid 107); 5 Mar 2009 11:01:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 05 Mar 2009 06:01:00 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Mar 2009 06:00:51 -0500
Content-Disposition: inline
In-Reply-To: <7vbpsg2sgx.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112296>

On Thu, Mar 05, 2009 at 02:07:26AM -0800, Junio C Hamano wrote:

> * mh/cvsimport-tests (Mon Feb 23 06:08:14 2009 +0100) 5 commits
>  - Add a test of "git cvsimport"'s handling of tags and branches
>  - Add some tests of git-cvsimport's handling of vendor branches
>  - Test contents of entire cvsimported "master" tree contents
>  - Use CVS's -f option if available (ignore user's ~/.cvsrc file)
>  - Start a library for cvsimport-related tests
> 
> Tests without fixes are of dubious value.  Any takers?

At the very least, I think the first 3 are nice infrastructure cleanups
that will help future tests for cvsimport. So it makes sense to me to
apply them to help future testers (otherwise, they would have to know
that these patches existed and dig them out of the list).

The final two introduce the new tests. They look fine as far as fitting
into the test infrastructure, but I have to admit that I haven't
actually looked closely at _what_ they are testing. I assumed since they
are adapted from Michael's cvs2svn tests that they are showing real
problems that he had faced there. If they are meant to show failings of
cvsps-based conversion (which is my understanding from Michael's other
messages), then I'm not even sure they _are_ fixable without a total
rewrite.

So I don't know whether it makes sense to apply them if we never plan on
fixing them. Michael said his goal was to document problems with
cvsps-based importing, and I think he has done that in a way that will
help anyone who wants to try fixing. We can help people out a little
more by carrying the tests in the tree (versus making them pull them
from the list); the downside is that it may take the test suite a little
longer to run. I don't know how much we care; it might not matter for 2
tests, but I certainly wouldn't want to 30 minutes of testing for
something that isn't fixable (and CVS tests tend to be terribly slow).

-Peff
