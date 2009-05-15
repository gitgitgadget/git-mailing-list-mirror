From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Showing stash state in bash prompt
Date: Thu, 14 May 2009 22:11:05 -0400
Message-ID: <20090515021105.GA19241@coredump.intra.peff.net>
References: <20090513094448.GC2106@bug.science-computing.de> <20090513112535.GD2106@bug.science-computing.de> <7v4ovo4xyt.fsf@alter.siamese.dyndns.org> <200905142025.02592.trast@student.ethz.ch> <buo1vqrqj2n.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Daniel Trstenjak <Daniel.Trstenjak@science-computing.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	spearce@spearce.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri May 15 04:13:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4mvN-00059H-Uk
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 04:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736AbZEOCLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 22:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752945AbZEOCLI
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 22:11:08 -0400
Received: from peff.net ([208.65.91.99]:51584 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180AbZEOCLH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 22:11:07 -0400
Received: (qmail 30789 invoked by uid 107); 15 May 2009 02:11:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 14 May 2009 22:11:07 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 14 May 2009 22:11:05 -0400
Content-Disposition: inline
In-Reply-To: <buo1vqrqj2n.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119246>

On Fri, May 15, 2009 at 09:57:20AM +0900, Miles Bader wrote:

> Thomas Rast <trast@student.ethz.ch> writes:
> > But IMHO it would not be a good idea to teach people stash/pop anyway:
> > 'stash drop' is irreversible, because the stash is itself implemented
> > through the reflog and thus not guarded by one.
> 
> I don't understand why you say this -- sure "drop" is dangerous, but
> that's exactly why you should use "pop" instead, because it makes sure
> the changes are _somewhere_.  I found with the old (pre-"pop") stash,
> I'd often end up in a situation where I'd lose track of whether I had
> done a stash apply or not, and the risk of inadvertently doing a drop
> _without_ a corresponding apply was very real.

"pop" doesn't always succeed. If you have conflicts in applying, then
you end up with conflict markers, and the stash remains. You then fix up
and commit as you see fit, but your stash is still there. So this bash
prompt will nag you, which I think is what Thomas was complaining about
(but perhaps the nagging would then convince you to keep a cleaner stash
area by dropping the resolved stash).

-Peff
