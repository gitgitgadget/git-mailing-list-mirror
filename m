From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix signal handler
Date: Sun, 14 Feb 2010 01:47:45 -0500
Message-ID: <20100214064745.GC20630@coredump.intra.peff.net>
References: <4B684F5F.7020409@web.de>
 <20100202205849.GA14385@sigill.intra.peff.net>
 <4B71A2EE.8070708@web.de>
 <4B72E81B.3020900@web.de>
 <20100210173348.GA5091@coredump.intra.peff.net>
 <4B76A985.9070809@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Sun Feb 14 07:47:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgYGi-0006Q2-Pw
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 07:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703Ab0BNGro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 01:47:44 -0500
Received: from peff.net ([208.65.91.99]:52930 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753394Ab0BNGrn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 01:47:43 -0500
Received: (qmail 31200 invoked by uid 107); 14 Feb 2010 06:47:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 14 Feb 2010 01:47:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Feb 2010 01:47:45 -0500
Content-Disposition: inline
In-Reply-To: <4B76A985.9070809@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139889>

On Sat, Feb 13, 2010 at 02:30:45PM +0100, Markus Elfring wrote:

> > Why does this need to become extern?
> 
> How do you think about to stress the detail that the function
> "log_show_early" is called by the function "limit_list" from an other
> translation unit.

Stress to whom? The keyword "extern" tells something to the linker, but
the linker doesn't care (and in fact making it extern introduces cruft
into the global namespace). If you want to tell the user, a comment
would be appropriate, but I don't think it is necessary. It is not hard
to see that the only use is assigning to an extern function pointer.

> > Overall, this change looks sane to me.
> 
> How are the chances to get the update suggestion into the public Git
> repository?

You would have a better chance if you followed the directions in
SubmittingPatches, including sending it to the maintainer, including
your patch inline, and wrapping your commit message.

-Peff
