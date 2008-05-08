From: Jeff King <peff@peff.net>
Subject: Re: git gc & deleted branches
Date: Thu, 8 May 2008 17:44:54 -0400
Message-ID: <20080508214454.GA1939@sigill.intra.peff.net>
References: <20080508183926.GA30613@sigill.intra.peff.net> <alpine.LSU.1.10.0805082051210.10981@bianca.dialin.t-online.de> <48235D99.2040407@nrlssc.navy.mil> <alpine.LSU.1.10.0805082232070.4260@bianca.dialin.t-online.de> <20080508210125.GC32762@sigill.intra.peff.net> <alpine.LFD.1.10.0805081712270.23581@xanadu.home> <20080508211734.GA819@sigill.intra.peff.net> <48236F69.2060900@nrlssc.navy.mil> <20080508213107.GA1016@sigill.intra.peff.net> <48237344.6070405@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>,
	Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu May 08 23:45:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuDvz-0005ki-Ot
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 23:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761635AbYEHVox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 17:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760991AbYEHVox
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 17:44:53 -0400
Received: from peff.net ([208.65.91.99]:2750 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759308AbYEHVow (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 17:44:52 -0400
Received: (qmail 26043 invoked by uid 111); 8 May 2008 21:44:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 08 May 2008 17:44:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 May 2008 17:44:54 -0400
Content-Disposition: inline
In-Reply-To: <48237344.6070405@nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81573>

On Thu, May 08, 2008 at 04:40:20PM -0500, Brandon Casey wrote:

> The 'prune --expire' behavior is based on object mtime (i.e. file
> modification time).  That is lost once something is packed right?

Yes. You would have to use the pack mtime. But of course you would have
to actually _leave_ them in a pack, or they would just keep getting
added to the new pack.

> I was thinking that either repack or pack-objects could be modified to
> unpack those unreachable objects and leave them loose, and also give
> them the timestamp of the pack file they came from. Then the --expire
> behavior of git-prune could work normally and remove them. This seems
> like it would work nicely since prune follows repack in git-gc.

That is sensible, I think.

-Peff
