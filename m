From: Jeff King <peff@peff.net>
Subject: Re: [RFC] cherry-pick using multiple parents to implement -x
Date: Sun, 7 Sep 2008 21:49:59 -0400
Message-ID: <20080908014959.GA29129@coredump.intra.peff.net>
References: <20080907103415.GA3139@cuci.nl> <20080907172807.GA25233@coredump.intra.peff.net> <20080907195626.GA8765@cuci.nl> <20080907200441.GA26705@coredump.intra.peff.net> <20080907202202.GC8765@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Mon Sep 08 03:51:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcVue-0005t0-H0
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 03:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbYIHBuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 21:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752376AbYIHBuE
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 21:50:04 -0400
Received: from peff.net ([208.65.91.99]:4889 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792AbYIHBuB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 21:50:01 -0400
Received: (qmail 15885 invoked by uid 111); 8 Sep 2008 01:50:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 07 Sep 2008 21:50:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Sep 2008 21:49:59 -0400
Content-Disposition: inline
In-Reply-To: <20080907202202.GC8765@cuci.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95204>

On Sun, Sep 07, 2008 at 10:22:02PM +0200, Stephen R. van den Berg wrote:

> >But then it will fail to find legitimate merge bases. So yes, you _can_
> 
> Will it?  Can you give me one example where it would find the wrong one?

How about the example I gave already? The first merge-base is E, but
that is not correct for the merge I gave. So you propose an algorithm
which will find A. But now imagine the exact some topology, but there
was no cherry-pick; instead, E' is actually a merge. Wouldn't E be the
right merge-base then?

And yes, of course the _content_ of the trees in E' will be different in
those two cases. But the shape of the history graph will be the same,
and that is the only thing that goes into finding a merge base.

-Peff
