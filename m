From: Jeff King <peff@peff.net>
Subject: Re: Building git 2.4.5 on AIX 6.1 problems
Date: Fri, 10 Jul 2015 01:06:43 -0400
Message-ID: <20150710050642.GA4627@peff.net>
References: <516b832bd9db48e4bdb486d63b2a3977@imap.force9.net>
 <xmqqwpy9uqth.fsf@gitster.dls.corp.google.com>
 <a4eee6a136cafece6be5dbd5ee934f7a@imap.force9.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Norris <john@norricorp.f9.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 10 07:06:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDQWR-0002fr-3h
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 07:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587AbbGJFGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 01:06:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:58467 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751522AbbGJFGq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 01:06:46 -0400
Received: (qmail 19268 invoked by uid 102); 10 Jul 2015 05:06:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Jul 2015 00:06:46 -0500
Received: (qmail 6116 invoked by uid 107); 10 Jul 2015 05:06:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Jul 2015 01:06:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Jul 2015 01:06:43 -0400
Content-Disposition: inline
In-Reply-To: <a4eee6a136cafece6be5dbd5ee934f7a@imap.force9.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273802>

On Fri, Jul 10, 2015 at 04:32:37AM +0000, John Norris wrote:

> But there are a few archive commands before I get to linking
> credentials-store. Is there something special about credentials store?

Not really. It is just the first program alphabetically, so it comes
first in the Makefile. You can try "make git" and you'll probably see
similar problems linking git (or if you don't, then it is a sign our
Makefile is broken for external programs versus the main git binary).

> And is the collect2 an AIX library or general library used by git?

It's a gcc thing:

  https://gcc.gnu.org/onlinedocs/gccint/Collect2.html

-Peff
