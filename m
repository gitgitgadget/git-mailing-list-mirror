From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] diff: resurrect the traditional empty "diff --git" behaviour
Date: Fri, 31 Aug 2007 23:32:37 +0200
Message-ID: <20070831213237.GA4753@steel.home>
References: <20070830072748.GF16312@mellanox.co.il> <7vmyw85uml.fsf@gitster.siamese.dyndns.org> <20070831080651.GA17637@mellanox.co.il> <7vabs82kcq.fsf@gitster.siamese.dyndns.org> <20070831081517.GB17637@mellanox.co.il> <7v4pig2j91.fsf@gitster.siamese.dyndns.org> <20070831152120.GC17637@mellanox.co.il> <7vr6lj1zg3.fsf@gitster.siamese.dyndns.org> <20070831160335.GA17761@coredump.intra.peff.net> <7vtzqfzcll.fsf_-_@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 23:33:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRE73-0005J5-Oq
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 23:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761124AbXHaVcr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 17:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966515AbXHaVcp
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 17:32:45 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:36962 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966477AbXHaVcl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 17:32:41 -0400
Received: from tigra.home (Fc93c.f.strato-dslnet.de [195.4.201.60])
	by post.webmailer.de (mrclete mo21) (RZmta 12.3)
	with ESMTP id 601f33j7VHIvuw ; Fri, 31 Aug 2007 23:32:38 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 2C51B277BD;
	Fri, 31 Aug 2007 23:32:38 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id B3768BE2A; Fri, 31 Aug 2007 23:32:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vtzqfzcll.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAPiog==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57220>

Junio C Hamano, Fri, Aug 31, 2007 22:13:42 +0200:
> The "Consier running git-status" warning message we experimented
> during the 1.5.3 cycle turns out to be a bad idea.  It robbed
> cache-dirty information from people who valued it, while still
> asking users to run "update-index --refresh".  It was hoped that
> the new behaviour would at least have some educational value,
> but not showing the cache-dirty paths like before means the user
> would not even know easily which paths are cache-dirty.
> 
> This commit reinstates the traditional behaviour as the default,
> but with a twist.
> 
> If you set diff.autorefreshindex configuration variable, it
> squelches the empty "diff --git" output, and at the end of the
> command, it automatically runs "update-index --refresh" without
> even bothering the user.  In other words, with the configuration
> variable set, people who do not care about the cache-dirtyness
> do not even have to see the warning.

I like this change.

So far my attempts to explain that warning to myself always left an
uneasy feeling of me having tricked myself into believing in its
usefullness.
