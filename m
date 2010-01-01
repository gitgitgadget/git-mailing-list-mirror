From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] run-command: optimize out useless shell calls
Date: Thu, 31 Dec 2009 23:50:18 -0500
Message-ID: <20100101045017.GA20769@coredump.intra.peff.net>
References: <20091230095634.GA16349@coredump.intra.peff.net>
 <4B3CD74D.7020605@kdbg.org>
 <20091231214134.GA31399@coredump.intra.peff.net>
 <200912312316.47925.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jan 01 06:02:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQZed-0006kZ-UI
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 06:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100Ab0AAEuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 23:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086Ab0AAEuW
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 23:50:22 -0500
Received: from peff.net ([208.65.91.99]:47450 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020Ab0AAEuV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 23:50:21 -0500
Received: (qmail 951 invoked by uid 107); 1 Jan 2010 04:55:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 31 Dec 2009 23:55:05 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Dec 2009 23:50:18 -0500
Content-Disposition: inline
In-Reply-To: <200912312316.47925.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135997>

On Thu, Dec 31, 2009 at 11:16:47PM +0100, Johannes Sixt wrote:

> > > It does assume that we are able to detect execvp failure due to
> > > ENOENT which is currently proposed elsewhere by Ilari Liusvaara (and
> > > which is already possible on Windows).
> >
> > We could also simply do the path lookup ourselves, decide whether to use
> > the shell, and then exec.
> 
> I tried to convince Ilari that this is the way to go, but...

How should we proceed, then? The "DWIM with spaces" magic seems like
something that can come later, so I am tempted to recommend taking my
series now, fixing up msysgit as mentioned earlier (or just dropping the
pager.c portion of my 2/6), and then implementing DWIM once Ilari's
topic matures.

We might want to hold my 5/6 and 6/6 back from master until the DWIM
(which would make both totally safe, I think).

-Peff
