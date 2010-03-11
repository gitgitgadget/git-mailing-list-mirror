From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] struct sockaddr_storage->ss_family is not portable
Date: Thu, 11 Mar 2010 17:27:22 -0500
Message-ID: <20100311222722.GB18292@sigill.intra.peff.net>
References: <20100311163715.GE7877@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Thu Mar 11 23:27:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npqqt-0002bv-Vn
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 23:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756905Ab0CKW10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 17:27:26 -0500
Received: from peff.net ([208.65.91.99]:39766 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751313Ab0CKW1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 17:27:25 -0500
Received: (qmail 4834 invoked by uid 107); 11 Mar 2010 22:27:48 -0000
Received: from c-71-206-173-191.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.191)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 11 Mar 2010 17:27:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Mar 2010 17:27:22 -0500
Content-Disposition: inline
In-Reply-To: <20100311163715.GE7877@thor.il.thewrittenword.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142004>

On Thu, Mar 11, 2010 at 04:37:15PM +0000, Gary V. Vaughan wrote:

> Actually, the test for setting NO_IPV6 at configure time is still
> too optimistic and I have to manually pass '-DNO_IPV6' in CPPFLAGS
> at build time on aix-5.2.0.0 and earlier, and irix-6.5 and older
> for them to pick up the right branch.

Are you running 'configure' or just 'make'? If the latter, then the
defaults for each platform are defined in the Makefile (e.g., see around
line 790 of the Makefile where we turn off IPv6 for Solaris 2.7, but not
2.8). Patches to tweak the defaults for obscure platforms are welcome.

Also, now that I look at that, we seem to already have a
NO_SOCKADDR_STORAGE flag that handles this case? Does setting that fix
your problem without this patch?

-Peff
