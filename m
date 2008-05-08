From: Jeff King <peff@peff.net>
Subject: Re: git gc & deleted branches
Date: Thu, 8 May 2008 18:48:27 -0400
Message-ID: <20080508224827.GA2938@sigill.intra.peff.net>
References: <48235D99.2040407@nrlssc.navy.mil> <alpine.LSU.1.10.0805082232070.4260@bianca.dialin.t-online.de> <20080508210125.GC32762@sigill.intra.peff.net> <alpine.LFD.1.10.0805081712270.23581@xanadu.home> <20080508211734.GA819@sigill.intra.peff.net> <48236F69.2060900@nrlssc.navy.mil> <20080508213107.GA1016@sigill.intra.peff.net> <48237344.6070405@nrlssc.navy.mil> <20080508214454.GA1939@sigill.intra.peff.net> <48237650.5060008@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>,
	Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri May 09 00:49:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuEvL-0003Ql-RR
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 00:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759735AbYEHWs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 18:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760591AbYEHWs0
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 18:48:26 -0400
Received: from peff.net ([208.65.91.99]:4524 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759639AbYEHWsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 18:48:25 -0400
Received: (qmail 29997 invoked by uid 111); 8 May 2008 22:48:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 08 May 2008 18:48:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 May 2008 18:48:27 -0400
Content-Disposition: inline
In-Reply-To: <48237650.5060008@nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81575>

On Thu, May 08, 2008 at 04:53:20PM -0500, Brandon Casey wrote:

> > Yes. You would have to use the pack mtime. But of course you would have
> > to actually _leave_ them in a pack, or they would just keep getting
> > added to the new pack.
> 
> I had the impression that unreachable objects would not be packed. Maybe it
> was more of an assumption.

Look in builtin-pack-objects.c:1981-1982. We basically just say "if it's
in a pack now, then it should go into the new pack."

-Peff
