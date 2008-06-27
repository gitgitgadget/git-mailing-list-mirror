From: Jeff King <peff@peff.net>
Subject: Re: bug related to branches using / in name
Date: Thu, 26 Jun 2008 23:57:47 -0400
Message-ID: <20080627035747.GC7144@sigill.intra.peff.net>
References: <1214509350.28344.31.camel@odie.local> <20080627030245.GA7144@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>
To: Simon Holm =?utf-8?Q?Th=C3=B8gersen?= <odie@cs.aau.dk>
X-From: git-owner@vger.kernel.org Fri Jun 27 05:59:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC57F-0007VA-KU
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 05:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbYF0D5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 23:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146AbYF0D5v
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 23:57:51 -0400
Received: from peff.net ([208.65.91.99]:2100 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538AbYF0D5u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 23:57:50 -0400
Received: (qmail 31471 invoked by uid 111); 27 Jun 2008 03:57:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 26 Jun 2008 23:57:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jun 2008 23:57:47 -0400
Content-Disposition: inline
In-Reply-To: <20080627030245.GA7144@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86519>

On Thu, Jun 26, 2008 at 11:02:46PM -0400, Jeff King wrote:

> It might be nicer if this were handled automatically, but it would
> violate git-fetch's rule about never deleting branches. And presumably
> this comes up infrequently enough that it isn't a problem. Perhaps a
> better error message suggesting git-prune might make sense?

And here is a 2-patch series improving the error reporting for this
case (and it also helps with some other cases). I'm a little iffy on
2/2, since we don't actually _know_ that remote pruning will help. But
propagating specific errors up through the call chain would require
reasonably major surgery.

  1/2: fetch: give a hint to the user when local refs fail to update
  2/2: fetch: report local storage errors in status table

-Peff
