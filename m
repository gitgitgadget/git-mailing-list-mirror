From: Jeff King <peff@peff.net>
Subject: Re: git-cvsexportcommit fails for huge commits
Date: Wed, 12 Dec 2007 23:17:37 -0500
Message-ID: <20071213041737.GA23624@coredump.intra.peff.net>
References: <20071211200418.GA13815@mkl-desktop> <20071212083154.GB7676@coredump.intra.peff.net> <46a038f90712121158n674a9044t75ef99473314457c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Klinik <markus.klinik@gmx.de>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 05:18:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2fWN-0005E4-Oe
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 05:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbXLMERl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 23:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752442AbXLMERl
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 23:17:41 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2704 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692AbXLMERk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 23:17:40 -0500
Received: (qmail 7099 invoked by uid 111); 13 Dec 2007 04:17:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Dec 2007 23:17:38 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2007 23:17:37 -0500
Content-Disposition: inline
In-Reply-To: <46a038f90712121158n674a9044t75ef99473314457c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68117>

On Thu, Dec 13, 2007 at 08:58:33AM +1300, Martin Langhoff wrote:

> IOWs, the protocol *is* atomic, and this patch does make things
> slightly more brittle. Perhaps require an option to be set before we
> do this?

I started writing a patch to let the user specify the limit, but it was
just too ugly. What user knows the right limit? We are probably better
off just setting the limit at something high and reasonable (like 64K --
it would be nice to get feedback from Markus on what platform he is
using and what is a reasonable value), or just using a tempfile with
xargs, which should figure out the correct value.

-Peff
