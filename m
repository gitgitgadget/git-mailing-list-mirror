From: Jeff King <peff@peff.net>
Subject: Re: git-gc doesn't clean up leftover objects after
	git-filter-branch unless you clone first
Date: Wed, 23 Apr 2008 18:13:16 -0400
Message-ID: <20080423221316.GE30057@sigill.intra.peff.net>
References: <32541b130804230841h32c07f3arc94cccfaf0b156a3@mail.gmail.com> <7vve28sdys.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 00:14:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JonE2-00024y-Jf
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 00:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbYDWWNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 18:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752587AbYDWWNP
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 18:13:15 -0400
Received: from peff.net ([208.65.91.99]:3394 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752358AbYDWWNO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 18:13:14 -0400
Received: (qmail 31819 invoked by uid 111); 23 Apr 2008 22:13:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 23 Apr 2008 18:13:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Apr 2008 18:13:16 -0400
Content-Disposition: inline
In-Reply-To: <7vve28sdys.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80267>

On Wed, Apr 23, 2008 at 10:00:59AM -0700, Junio C Hamano wrote:

> - Teach people that leftover cruft is nothing to worry about.

But it _is_ something to worry about in some particular situations. For
run-of-the-mill rebasing, sure, ignore it. But this question usually
comes up because the user did something like:

  1. import from foreign SCM or other source
  2. realize massive, history-wide mistake; git filter-branch
     to fix up the changes
  3. wonder why git is using twice as much space as it needs to; with
     a repository in the hundreds or thousands of megs, this can get
     really annoying (either because of wasted space, or because some
     operations, like "git repack -a" actually do per-object work).

-Peff
