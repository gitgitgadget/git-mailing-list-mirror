From: Jeff King <peff@peff.net>
Subject: Re: change in behaviour of git status and/or gitk bug
Date: Fri, 7 May 2010 01:00:54 -0400
Message-ID: <20100507050054.GA25987@coredump.intra.peff.net>
References: <n2na038bef51005061820o581b2f0aq940282264b7f083f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 07:01:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAFgP-0002h8-1n
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 07:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788Ab0EGFA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 01:00:58 -0400
Received: from peff.net ([208.65.91.99]:42297 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618Ab0EGFA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 01:00:57 -0400
Received: (qmail 19861 invoked by uid 107); 7 May 2010 05:01:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 07 May 2010 01:01:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 07 May 2010 01:00:54 -0400
Content-Disposition: inline
In-Reply-To: <n2na038bef51005061820o581b2f0aq940282264b7f083f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146524>

On Thu, May 06, 2010 at 06:20:34PM -0700, Chris Packham wrote:

> I noticed a while back that with gitk I kept on getting files shown as
> "Local uncommitted changes, not checked in to index" when I'd made
> modifications to them then backed them out so the working tree content
> was the same as the index. I used to (with git 1.6.x) fix / work
> around this by running git status.
> 
> Now, with git 1.7.1, that workaround has stopped working. No doubt

This was lost in v1.7.0, but should be back in v1.7.2. The actual fix is
4bb6644 (git status: refresh the index if possible, 2010-04-02).

You can run "git update-index --refresh" to get the same effect. Running
"git diff" also works.

There was some talk (and a patch) recently about gitk running
"update-index --refresh", but I don't know if it got picked up. See:

  http://article.gmane.org/gmane.comp.version-control.git/144182

-Peff
