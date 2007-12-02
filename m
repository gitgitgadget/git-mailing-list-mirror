From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] builtin-commit: Add newline when showing which
	commit was created
Date: Sun, 2 Dec 2007 00:40:30 -0500
Message-ID: <20071202054030.GA393@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0711111730580.4362@racer.site> <Pine.LNX.4.64.0711111736440.4362@racer.site> <20071201222106.GA27102@coredump.intra.peff.net> <Pine.LNX.4.64.0712012238510.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 02 06:41:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyhZY-0001Di-DS
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 06:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbXLBFke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 00:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbXLBFke
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 00:40:34 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2129 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767AbXLBFke (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 00:40:34 -0500
Received: (qmail 18651 invoked by uid 111); 2 Dec 2007 05:40:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Dec 2007 00:40:31 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Dec 2007 00:40:30 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0712012238510.27959@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66759>

On Sat, Dec 01, 2007 at 10:41:47PM +0000, Johannes Schindelin wrote:

> Basically, I ran a test case in which the shell script was different from 
> the builtin version, and this was the patch that fixed it for me.
> 
> Maybe it should have been
> 
> 	if (log_tree_commit(&rev, commit))
> 		printf("\n");
> 
> at the end of print_summary() instead.  Can you try if that fixes it for 
> you?

No, it doesn't, unless you meant "if (!log_tree_commit(...". Of course,
I can't get log_tree_commit to return anything but true anyway (either
log_tree_diff shows something, or since we have set always_show_header,
we end up calling show_log).

It would be helpful if you could remember the test case, but perhaps
that is not an option at this point.

-Peff
