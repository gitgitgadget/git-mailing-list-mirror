From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] version: add git_user_agent function
Date: Tue, 19 Jun 2012 15:52:29 -0400
Message-ID: <20120619195229.GA14692@sigill.intra.peff.net>
References: <20120602184948.GA14269@sigill.intra.peff.net>
 <20120602190112.GB14369@sigill.intra.peff.net>
 <87pq8vrvqz.fsf@thomas.inf.ethz.ch>
 <20120619185916.GA16429@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 19 21:52:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh4Tb-0005sw-UX
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 21:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855Ab2FSTwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 15:52:32 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:32941
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753482Ab2FSTwb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 15:52:31 -0400
Received: (qmail 12672 invoked by uid 107); 19 Jun 2012 19:52:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Jun 2012 15:52:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jun 2012 15:52:29 -0400
Content-Disposition: inline
In-Reply-To: <20120619185916.GA16429@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200232>

On Tue, Jun 19, 2012 at 02:59:16PM -0400, Jeff King wrote:

> > Unless the user manually sets GIT_USER_AGENT, This forces a full rebuild
> > due to changed CFLAGS whenever the version changes.  Can you make it so
> > that only version.o needs to be rebuilt, as with the normal git version
> > string?
> 
> Ick, yeah. I had though this was already the case, but it turns out that
> it was a peculiarity of my personal config.mak (I set a custom $prefix
> based on the branch, and it has a similar problem). I'll see if I can
> fix both.

Here it is.

  [1/3]: Makefile: apply dependencies consistently to sparse/asm targets
  [2/3]: Makefile: split GIT_USER_AGENT from GIT-CFLAGS
  [3/3]: Makefile: split prefix flags from GIT-CFLAGS

Patches go on top of jk/version-string.

-Peff
