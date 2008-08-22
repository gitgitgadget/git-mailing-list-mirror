From: Jeff King <peff@peff.net>
Subject: Re: Linux 2.6.27-rc3: kernel BUG at mm/vmalloc.c - bisected
Date: Fri, 22 Aug 2008 17:21:21 -0400
Message-ID: <20080822212121.GA31546@coredump.intra.peff.net>
References: <48A36838.3050309@hp.com> <20080819124602.9e8e69f7.akpm@linux-foundation.org> <48AEDD3D.4060507@hp.com> <20080822092549.ddcb7e79.akpm@linux-foundation.org> <20080822171651.GP10544@machine.or.cz> <20080822105136.a8432875.akpm@linux-foundation.org> <7v7ia8ahgu.fsf@gitster.siamese.dyndns.org> <20080822141651.fe16ed99.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, pasky@suse.cz,
	Alan.Brunelle@hp.com, linux-kernel@vger.kernel.org,
	git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 23:22:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWe5V-0001Fk-1O
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 23:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957AbYHVVVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 17:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753203AbYHVVVY
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 17:21:24 -0400
Received: from peff.net ([208.65.91.99]:1293 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618AbYHVVVX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 17:21:23 -0400
Received: (qmail 25432 invoked by uid 111); 22 Aug 2008 21:21:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 22 Aug 2008 17:21:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Aug 2008 17:21:21 -0400
Content-Disposition: inline
In-Reply-To: <20080822141651.fe16ed99.akpm@linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93373>

On Fri, Aug 22, 2008 at 02:16:51PM -0700, Andrew Morton wrote:

> Sure, but
> 
> a) whoever added a change like that without also causing the build to
>    break is slappable and

Well, the point is to find out _who_ to slap. ;)

> b) there are now two commits (one in each branch) either one of
>    which, when applied on top of the other branch will introduce the
>    regression.
> 
>    That's useful infomation, but we don't know how to get
>    git-bisect to give it to us.
>
> It's pretty simple.  If git-bisect tells us that the regression was
> introduced by a merge commit, we want to perform a bisection within
> that merge's individual commits.

I mentioned linearizing the two lines of development in another
message in this thread. But there are, of course, two linearizations,
neither of which might be possible to generate automatically, and one
might give you a better answer than the other.

-Peff
