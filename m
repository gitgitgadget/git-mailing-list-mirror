From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: don't use too many threads with few
	objects
Date: Mon, 15 Dec 2008 22:20:17 -0500
Message-ID: <20081216032016.GA4247@coredump.intra.peff.net>
References: <alpine.LFD.2.00.0812111524370.14328@xanadu.home> <20081213133238.GA6718@sigill.intra.peff.net> <alpine.LFD.2.00.0812131456040.30035@xanadu.home> <e2b179460812151038y5a39b33cv1d7b41faf10563e@mail.gmail.com> <7vy6ygudhb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>,
	Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 04:21:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCQV8-00083h-4e
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 04:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbYLPDUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 22:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbYLPDUU
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 22:20:20 -0500
Received: from peff.net ([208.65.91.99]:2204 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736AbYLPDUT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 22:20:19 -0500
Received: (qmail 10006 invoked by uid 111); 16 Dec 2008 03:20:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 15 Dec 2008 22:20:18 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Dec 2008 22:20:17 -0500
Content-Disposition: inline
In-Reply-To: <7vy6ygudhb.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103238>

On Mon, Dec 15, 2008 at 05:15:44PM -0800, Junio C Hamano wrote:

> Perhaps the two runs are seeing different number of CPUs (hence threads)
> available?  That would then change the distribution of the work itself
> (i.e. what slice of obj-list goes as a single chunk to be processed) and
> would affect the outcome.

I am seeing the same failure as Mike on one of my boxen.  Each run sees
the same number of threads (4 in my case).

> Does the second test this patch adds fail?

With your patch, the added "both should match" test fails. So it seems
to be about doing a second run at all, not the difference in index
versions.

-Peff
