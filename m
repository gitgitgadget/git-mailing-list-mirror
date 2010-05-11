From: Jeff King <peff@peff.net>
Subject: Re: git gc taking forever to reflog expire --all
Date: Tue, 11 May 2010 06:08:00 -0400
Message-ID: <20100511100800.GA452@coredump.intra.peff.net>
References: <0C5B1A89-551A-4EC8-862A-C306A286FAF4@adacore.com>
 <20100511050134.GA9413@coredump.intra.peff.net>
 <3924516F-2626-41C0-8648-47A9481FA09F@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git List <git@vger.kernel.org>
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Tue May 11 12:08:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBmOT-0002aA-IB
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 12:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460Ab0EKKII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 06:08:08 -0400
Received: from peff.net ([208.65.91.99]:49091 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757724Ab0EKKIF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 06:08:05 -0400
Received: (qmail 19025 invoked by uid 107); 11 May 2010 10:08:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 11 May 2010 06:08:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 11 May 2010 06:08:00 -0400
Content-Disposition: inline
In-Reply-To: <3924516F-2626-41C0-8648-47A9481FA09F@adacore.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146884>

On Tue, May 11, 2010 at 06:05:14AM -0400, Geert Bosch wrote:

> > There are some corner cases that can cause the expire-unreachable
> > algorithm to behave badly. The fix is b4ca1db (reflog
> > --expire-unreachable: avoid merge-base computation, 2010-04-07), but
> > hasn't been included in a release yet.
> > 
> I tried with v1.7.1 + cherry-pick b4ca1db968eb57d9cd869337bffa254e0b2c83bd,
> but that didn't solve the issue.
> > In the meantime, you can work around it with:
> > 
> >  git config gc.reflogExpireUnreachable never
> 
> I had tried that too, but I guess I'll just have to be very patient:
> 22707 ttys001   11:14.27 git reflog expire --all

Hmm. If that didn't solve it, then presumably it is a different problem,
and I'd like to take a closer look. Is it possible for you to make a
tarball of the .git directory available?

> What would be the easiest way for me to repack my repository
> without running reflog expire at all?

Try "git repack -Ad".

-Peff
