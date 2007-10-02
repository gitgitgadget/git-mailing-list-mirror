From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 2 Oct 2007 00:16:52 -0400
Message-ID: <20071002041652.GA32133@coredump.intra.peff.net>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org> <7v1wd1d0le.fsf@gitster.siamese.dyndns.org> <7vfy11yyxk.fsf@gitster.siamese.dyndns.org> <20070927023633.GA28902@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 06:17:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcZBw-0003lN-H1
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 06:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbXJBEQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 00:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbXJBEQ4
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 00:16:56 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4040 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798AbXJBEQz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 00:16:55 -0400
Received: (qmail 21749 invoked by uid 111); 2 Oct 2007 04:16:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 02 Oct 2007 00:16:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2007 00:16:52 -0400
Content-Disposition: inline
In-Reply-To: <20070927023633.GA28902@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59655>

On Wed, Sep 26, 2007 at 10:36:33PM -0400, Jeff King wrote:

> > * jk/diff-rename (Tue Sep 25 15:29:42 2007 -0400) 1 commit
> >  + diffcore-rename: cache file deltas
> > 
> > Parked in 'next' for now but is 'master' material.
> 
> My tests after this patch show that spanhash_find is responsible for
> a large portion of the processing time in large renames, so I am going
> to look into speeding that up.

Just to update, I tried using a non-colliding hash for this (at the
expense of much memory), and I wasn't able to get things much faster
(and certainly not worth the explosion in memory), short of reducing the
size of the hash (which is going to reduce the quality of the output).
So I am giving up for the time being, but if others are interested in
trying to speed things up, I would be happy to discuss ideas.

-Peff
