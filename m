From: Jeff King <peff@peff.net>
Subject: Re: git gc taking forever to reflog expire --all
Date: Tue, 11 May 2010 01:01:34 -0400
Message-ID: <20100511050134.GA9413@coredump.intra.peff.net>
References: <0C5B1A89-551A-4EC8-862A-C306A286FAF4@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git List <git@vger.kernel.org>
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Tue May 11 07:01:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBhbA-0001wE-Uw
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 07:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753607Ab0EKFBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 01:01:36 -0400
Received: from peff.net ([208.65.91.99]:34774 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752962Ab0EKFBf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 01:01:35 -0400
Received: (qmail 16752 invoked by uid 107); 11 May 2010 05:01:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 11 May 2010 01:01:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 11 May 2010 01:01:34 -0400
Content-Disposition: inline
In-Reply-To: <0C5B1A89-551A-4EC8-862A-C306A286FAF4@adacore.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146866>

On Mon, May 10, 2010 at 01:58:11PM -0400, Geert Bosch wrote:

> On my recent MacBook Pro, I gave up after reflog expire --all
> had chewed up 30 minutes of perfectly fine CPU time.

There are some corner cases that can cause the expire-unreachable
algorithm to behave badly. The fix is b4ca1db (reflog
--expire-unreachable: avoid merge-base computation, 2010-04-07), but
hasn't been included in a release yet.

In the meantime, you can work around it with:

  git config gc.reflogExpireUnreachable never

-Peff
