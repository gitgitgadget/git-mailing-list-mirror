From: Jeff King <peff@peff.net>
Subject: Re: git-revert is a memory hog
Date: Mon, 28 Jan 2008 01:01:49 -0500
Message-ID: <20080128060149.GB13521@coredump.intra.peff.net>
References: <20080127172748.GD2558@does.not.exist> <20080127173808.GX24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adrian Bunk <bunk@kernel.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 28 07:02:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJN4Z-0001nx-Om
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 07:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbYA1GBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 01:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbYA1GBx
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 01:01:53 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4146 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976AbYA1GBw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 01:01:52 -0500
Received: (qmail 24442 invoked by uid 111); 28 Jan 2008 06:01:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 28 Jan 2008 01:01:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jan 2008 01:01:49 -0500
Content-Disposition: inline
In-Reply-To: <20080127173808.GX24004@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71851>

On Sun, Jan 27, 2008 at 12:38:08PM -0500, Shawn O. Pearce wrote:

> >   git-show d19fbe8a7 | patch -p1 -R
> 
> Its more like:
> 
> 	git-diff-tree -M d19fbe8a7^ d19fbe8a7 | git-apply -R --index
> 
> In other words its doing rename detection.  Its possible that the
> rename detector fired for added/removed paths and it took some
> significant amount of memory to figure out what was renamed.

It's doubtful. There are only two files in that diff, and neither is a
candidate for rename detection.

-Peff
