From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gc: call "prune --expire 2.weeks.ago"
Date: Thu, 13 Mar 2008 00:30:53 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803130028550.1656@racer.site>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site> <7vskywadum.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803112234470.2947@xanadu.home> <7vbq5k77z0.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803121153160.1656@racer.site>
 <alpine.LFD.1.00.0803121143170.2947@xanadu.home> <FE263BF7-9948-463C-B9B2-833B068EB10B@ai.rug.nl> <alpine.LSU.1.00.0803121705330.1656@racer.site> <20080312170155.GB11236@coredump.intra.peff.net> <B27EC8CF-482D-499B-B4E0-019049926C93@ai.rug.nl>
 <7vtzjb34y0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pieter de Bie <pdebie@ai.rug.nl>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 00:31:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZaPv-0000dW-PR
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 00:31:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296AbYCLXat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 19:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752269AbYCLXat
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 19:30:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:54506 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752094AbYCLXas (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 19:30:48 -0400
Received: (qmail invoked by alias); 12 Mar 2008 23:30:46 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp054) with SMTP; 13 Mar 2008 00:30:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18xE8RxPVgx+6YM/oBa9PhU+dOoQI5kV1pQrDmQEk
	k5vsbThU9w+bTh
X-X-Sender: gene099@racer.site
In-Reply-To: <7vtzjb34y0.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77025>

Hi,

On Wed, 12 Mar 2008, Junio C Hamano wrote:

> In any case, after 90 days, my reading of the code is that these loose 
> ones become unreachable, and when we look at their timestamps, we notice 
> that they are already more than 2 weeks old, and they will immediately 
> be removed.

Yes.

In any case, most likely these objects would have been packed anyway 
during that period, so they would have been pruned by the repack called by 
git-gc.

My patch really, really is about _unreferenced_ loose objects, i.e. 
something you get by multiple "git add"s without commits.  And by merge 
conflicts.

IOW by objects that were never referenced by commit objects.

Ciao,
Dscho
