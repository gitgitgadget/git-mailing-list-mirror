From: Jeff King <peff@peff.net>
Subject: Re: Issue updating files during a checkout from a remote push
Date: Fri, 7 Nov 2008 16:59:13 -0500
Message-ID: <20081107215913.GB20126@coredump.intra.peff.net>
References: <334B3AB1-125A-4163-BEBC-9A73C4F569B5@idibu.com> <09C2A669-2B99-4490-9C95-FCCD76C03D61@idibu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Steve Walker <steve@idibu.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 23:00:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyZNW-0005Ls-EE
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 23:00:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbYKGV7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 16:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbYKGV7Q
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 16:59:16 -0500
Received: from peff.net ([208.65.91.99]:4398 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279AbYKGV7P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 16:59:15 -0500
Received: (qmail 2590 invoked by uid 111); 7 Nov 2008 21:59:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 07 Nov 2008 16:59:14 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Nov 2008 16:59:13 -0500
Content-Disposition: inline
In-Reply-To: <09C2A669-2B99-4490-9C95-FCCD76C03D61@idibu.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100337>

On Thu, Nov 06, 2008 at 06:17:54PM +0100, Steve Walker wrote:

> Sorry to keep answering my own questions directly after posting...
>
> I just tried with a 'git commit -f' and the files updated.

There is no "-f" option to commit. Did you mean "checkout -f"?

If that is the case, then yes, that will "fix" your problem in that it
brings the HEAD, index, and working tree into sync. But it is dangerous
in that it throws away any local changes you might have had.

If you did really mean "commit" then that is also a bad solution. It
creates a new commit on top of the recently pushed work that reverts all
of the changes made by the recently pushed work.

-Peff
