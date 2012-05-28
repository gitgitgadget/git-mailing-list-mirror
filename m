From: Jeff King <peff@peff.net>
Subject: Re: Git hangs at =?utf-8?B?4oCcV3JpdGlu?=
 =?utf-8?B?ZyBvYmplY3RzOiAxMSXigJ0=?=
Date: Mon, 28 May 2012 15:23:16 -0400
Message-ID: <20120528192316.GA2861@sigill.intra.peff.net>
References: <EF4D4C5F-2D6B-46F2-B5A4-9DB1BA55BB6B@att.net>
 <20120525005156.GC11300@sigill.intra.peff.net>
 <033AF49C-4CB3-4412-8845-0246D356358C@att.net>
 <2DE05B0B-1D7E-451F-9151-B01CDDF4593E@att.net>
 <201205270312.q4R3Chef014187@no.baka.org>
 <3BBC77C3-B747-4F68-A135-954C3C00ECBA@att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Seth Robertson <in-gitvger@baka.org>, git@vger.kernel.org
To: Timothy Normand Miller <theosib@att.net>
X-From: git-owner@vger.kernel.org Mon May 28 21:23:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZ5XG-00056E-TC
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 21:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843Ab2E1TXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 15:23:18 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:34416
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754389Ab2E1TXS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 15:23:18 -0400
Received: (qmail 15256 invoked by uid 107); 28 May 2012 19:23:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 May 2012 15:23:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 May 2012 15:23:16 -0400
Content-Disposition: inline
In-Reply-To: <3BBC77C3-B747-4F68-A135-954C3C00ECBA@att.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198716>

On Mon, May 28, 2012 at 08:48:32AM -0400, Timothy Normand Miller wrote:

> I tried uploading a file via sftp, and it stalls out at 160K.  So this
> is the cause of the problem.  SSH is broken.  Unfortunately, googling
> for ssh and stall isn't getting me anywhere.

Thanks for following up. I hadn't had a chance to look at your strace
output until today, and now you have saved me the trouble. :)

So I think we can rule out a git bug at this point. I would say it is an
issue with network settings, but it sounds like you reproduced it while
sshing to the local host (though depending on your setup, you might
still be able to trigger firewall rules in that case, which could have
an impact).

At this point, I'd try upgrading ssh if possible, and otherwise submit a
bug report to the ssh vendor (either your distro, or openssh directly if
you can reproduce it on pristine source).

-Peff
