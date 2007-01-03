From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Wed, 3 Jan 2007 06:59:24 -0500
Message-ID: <20070103115924.GA11136@coredump.intra.peff.net>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net> <87ps9xgkjo.wl%cworth@cworth.org> <7virfprquo.fsf@assigned-by-dhcp.cox.net> <20070103104620.GA27015@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 03 12:59:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H24mI-0007Su-KM
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 12:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbXACL71 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 06:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbXACL71
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 06:59:27 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1309 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750721AbXACL70 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 06:59:26 -0500
Received: (qmail 28729 invoked from network); 3 Jan 2007 06:59:34 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 3 Jan 2007 06:59:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jan 2007 06:59:24 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20070103104620.GA27015@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35860>

On Wed, Jan 03, 2007 at 05:46:20AM -0500, Jeff King wrote:

> Also, the implementation should be conceptually simple. Put
> refs/tags/v1.4.0 into HEAD on checkout. Disallow commit/merge unless
> HEAD points to refs/heads/*.

Let me take that back. It is actually still annoying to implement, since
many things (at least commit-tree, branch) are unhappy with a non-branch
in HEAD. Moreover, it's not as flexible as simply putting the commit
sha1 into the HEAD, as you suggested. My suggestion allows only
non-branch refs to be checked-out; however, it's likely somebody might
want to git-checkout HEAD~10 or some other unnamed thing.

-Peff
