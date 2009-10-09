From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 1/4] Document the HTTP transport protocol
Date: Fri, 9 Oct 2009 15:50:36 -0400
Message-ID: <20091009195035.GA15153@coredump.intra.peff.net>
References: <1255065768-10428-1-git-send-email-spearce@spearce.org>
 <1255065768-10428-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 09 21:51:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwLVA-0001ud-40
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 21:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761299AbZJITvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 15:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761254AbZJITvO
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 15:51:14 -0400
Received: from peff.net ([208.65.91.99]:38726 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757638AbZJITvO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 15:51:14 -0400
Received: (qmail 18097 invoked by uid 107); 9 Oct 2009 19:54:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 09 Oct 2009 15:54:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Oct 2009 15:50:36 -0400
Content-Disposition: inline
In-Reply-To: <1255065768-10428-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129836>

On Thu, Oct 08, 2009 at 10:22:45PM -0700, Shawn O. Pearce wrote:

> +Servers MUST NOT require HTTP cookies for the purposes of
> +authentication or access control.
> [...]
> +Servers MUST NOT require HTTP cookies in order to function correctly.
> +Clients MAY store and forward HTTP cookies during request processing
> +as described by RFC 2616 (HTTP/1.1).  Servers SHOULD ignore any
> +cookies sent by a client.

Why not? I can grant that the current git implementation probably can't
handle it, but keep in mind this is talking about the protocol and not
the implementation. And I can see it being useful for sites like github
which already have a cookie-based login. Adapting the client to handle
this case would not be too difficult (it would just mean keeping cookie
state in a file between runs, or even just pulling it out of the normal
browser's cookie store). And people whose client didn't do this would
simply get an "access denied" response code.

Is there a technical reason not to allow it?

-Peff
