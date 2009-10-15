From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 1/4] Document the HTTP transport protocol
Date: Thu, 15 Oct 2009 13:39:02 -0400
Message-ID: <20091015173902.GA22262@sigill.intra.peff.net>
References: <1255065768-10428-1-git-send-email-spearce@spearce.org>
 <1255065768-10428-2-git-send-email-spearce@spearce.org>
 <20091009195035.GA15153@coredump.intra.peff.net>
 <20091015165228.GO10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 15 19:43:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyUMM-00035a-6i
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 19:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935205AbZJORjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 13:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935163AbZJORjk
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 13:39:40 -0400
Received: from peff.net ([208.65.91.99]:44138 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935153AbZJORjk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 13:39:40 -0400
Received: (qmail 8687 invoked by uid 107); 15 Oct 2009 17:42:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 15 Oct 2009 13:42:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Oct 2009 13:39:02 -0400
Content-Disposition: inline
In-Reply-To: <20091015165228.GO10505@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130406>

On Thu, Oct 15, 2009 at 09:52:28AM -0700, Shawn O. Pearce wrote:

> > And I can see it being useful for sites like github
> > which already have a cookie-based login.
> 
> What I'm concerned about is using the cookie jar.  My Mac OS X
> laptop has 5 browsers installed, each with their own #@!*! cookie
> jar: Safari, Opera, Firefox, Camino, Google Chrome.  How the hell
> is the git client going to be able to use those cookies in order
> to interact with a website that requires cookie authentication?

Sure, it is obviously something that an implementation will have to deal
with. Either through manual configuration by the user or some
auto-detection magic that tries to cover every case (and I suspect if we
really wanted to do this, a patch to libcurl to handle different cookie
jar formats would probably be the best way to go).

But my main point was that it is an implementation issue, not a protocol
issue. The lines are a little blurry for us because there really aren't
very many git implementations, but I think your document is an attempt
to document just the protocol to allow interoperability between clients.

But I think you got my point:

> Not technical, but I want to reduce the amount of complexity that
> a conforming client has to deal with to reduce support costs for
> everyone involved.
> 
> I weakend the sections on cookies:
> 
> + Authentication
> + --------------
> ....
> + Servers SHOULD NOT require HTTP cookies for the purposes of
> + authentication or access control.
> 
> and that's all we say on the matter.  I took out the Servers MUST
> NOT line under session state.

I think this is a good compromise. It's not recommended at this point,
but there is no reason to disallow it if both sides can handle the
non-protocol part (i.e., storing and managing cookies). Thanks.

-Peff
