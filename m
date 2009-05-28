From: Jeff King <peff@peff.net>
Subject: Re: Bug in git-cvsexportcommit: can't commit files which have been
	removed from CVS
Date: Thu, 28 May 2009 16:06:35 -0400
Message-ID: <20090528200635.GJ13499@coredump.intra.peff.net>
References: <4A1EC184.50107@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nick Woolley <nickwoolley@yahoo.co.uk>
X-From: git-owner@vger.kernel.org Thu May 28 22:06:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9lsJ-0008OU-73
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 22:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756638AbZE1UGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 16:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755360AbZE1UGl
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 16:06:41 -0400
Received: from peff.net ([208.65.91.99]:53904 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753588AbZE1UGl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 16:06:41 -0400
Received: (qmail 22819 invoked by uid 107); 28 May 2009 20:06:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 28 May 2009 16:06:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 May 2009 16:06:35 -0400
Content-Disposition: inline
In-Reply-To: <4A1EC184.50107@yahoo.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120221>

On Thu, May 28, 2009 at 05:53:24PM +0100, Nick Woolley wrote:

> I have a patch against the current version of git's repository which
> seems to fix the problem.  This is actually three commits:
>  - the fix,
>  - an extension to t9200-git-cvsexportcommit.sh to test the fix
>  - EOL whitespace-removal
> 
> I'm hesitant to send all three as separate emails, even though the
> SubmittingPatches document seems to imply I should - should I squash
> them into one commit?

Don't worry about sending multiple messages to the list. It is the
normal behavior here. But you may want to collapse it somewhat:

  1. If your whitespace removal is a cleanup in nearby code, then that
     should probably come as the first patch.

  2. Your fix and the test extension should probably come in the same
     patch (we do sometimes do tests separately beforehand, marking them
     to expect failure, but that is usually only because nobody has a
     fix when the test is written :) ).

     If the whitespace removal is for the lines in your actual fix,
     then that should just be squashed in. There is no point showing us
     your broken-styled code to review, only to fix it in the very next
     commit.

So I would expect either a single patch (with cleaned-up fix and tests)
or a two-patch series (cleanups in the area, followed by your fix and
tests).

-Peff
