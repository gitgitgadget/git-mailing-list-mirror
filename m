From: Jeff King <peff@peff.net>
Subject: Re: git blame and cherry-picking
Date: Thu, 7 Aug 2008 14:22:56 -0400
Message-ID: <20080807182256.GF11314@sigill.intra.peff.net>
References: <91A979F0-1329-4CA6-AADC-6CF55872B57A@midwinter.com> <20080807060940.GA15405@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 20:24:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRAA0-0004zH-0Y
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 20:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757604AbYHGSXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 14:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757597AbYHGSW7
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 14:22:59 -0400
Received: from peff.net ([208.65.91.99]:1889 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756916AbYHGSW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 14:22:58 -0400
Received: (qmail 15344 invoked by uid 111); 7 Aug 2008 18:22:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 07 Aug 2008 14:22:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Aug 2008 14:22:56 -0400
Content-Disposition: inline
In-Reply-To: <20080807060940.GA15405@blimp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91594>

On Thu, Aug 07, 2008 at 08:09:40AM +0200, Alex Riesen wrote:

> Steven Grimm, Thu, Aug 07, 2008 00:18:33 +0200:
> > What, if any, is the approved way to get git blame to follow cherry- 
> > picked changes?
> 
> The can't be any: cherry-picks are just new commits. You just make the
> same changes at the new place in the history.

We used to say "cherry-picked from..." in the commit message, but I
don't think we do by default any longer. One could follow that link to
see the original change (if it still exists!).

You could potentially have git-blame incorporate that information
(again, if the referenced commit is even still available), but I'm not
sure exactly what difference it would make. I don't think you would want
to start blaming up the original commits line of parentage.

-Peff
