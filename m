From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] pack-objects: fix threaded load balancing
Date: Sat, 8 Dec 2007 04:18:44 -0500
Message-ID: <20071208091842.GA23489@sigill.intra.peff.net>
References: <alpine.LFD.0.99999.0712080000120.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jon Smirl <jonsmirl@gmail.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 10:19:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0vqJ-0003Ww-2R
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 10:19:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756461AbXLHJSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 04:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756399AbXLHJSs
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 04:18:48 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1202 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756396AbXLHJSr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 04:18:47 -0500
Received: (qmail 17829 invoked by uid 111); 8 Dec 2007 09:18:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 08 Dec 2007 04:18:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Dec 2007 04:18:44 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.99999.0712080000120.555@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67534>

On Sat, Dec 08, 2007 at 12:03:17AM -0500, Nicolas Pitre wrote:

> This patch implements a completely different approach by initially
> splitting the work in large chunks uniformly amongst all threads, and
> whenever a thread is done then it steals half of the remaining work from
> another thread with the largest amount of unprocessed objects.

Yay! This works great on my "pack a few hundred very large objects" repo.

-Peff
