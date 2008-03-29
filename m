From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Use 'grep -a' to fix some errors with non-GNU grep(1).
Date: Fri, 28 Mar 2008 20:49:08 -0400
Message-ID: <20080329004908.GA9878@coredump.intra.peff.net>
References: <20080328224011.GB5486@dengar.tuneafish.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Bernd Ahlers <bernd@ba-net.org>
X-From: git-owner@vger.kernel.org Sat Mar 29 01:49:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfPGf-00055A-5n
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 01:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778AbYC2AtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 20:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754671AbYC2AtM
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 20:49:12 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4354 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754437AbYC2AtM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 20:49:12 -0400
Received: (qmail 21360 invoked by uid 111); 29 Mar 2008 00:49:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 28 Mar 2008 20:49:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Mar 2008 20:49:08 -0400
Content-Disposition: inline
In-Reply-To: <20080328224011.GB5486@dengar.tuneafish.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78445>

On Fri, Mar 28, 2008 at 11:40:11PM +0100, Bernd Ahlers wrote:

> This fixes test errors on OpenBSD.

Nak. "grep -a" isn't portable. If you have binary goo to check, I think
the safest thing is to either generate it using printf (if it's short
and easy) or include the expected output in a test file (this is what I
did for t4020; see 53a5b443).

You could also potentially use git-grep for this, but I haven't looked
into how it handles "-a" (and in general, I think we try to avoid using
git tools as test infrastructure to avoid false positives; e.g., we
prefer using a system tool to compare expected output rather than
git-diff).

-Peff
