From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-remote: better handling of multiple remote
	HEADs
Date: Sun, 15 Feb 2009 01:08:15 -0500
Message-ID: <20090215060815.GA7473@coredump.intra.peff.net>
References: <20090214034345.GB24545@coredump.intra.peff.net> <1234607430-5403-1-git-send-email-jaysoffian@gmail.com> <20090214175420.GA3457@coredump.intra.peff.net> <alpine.LNX.1.00.0902141503230.19665@iabervon.org> <20090214211548.GA14898@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Feb 15 07:09:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYaCI-0004qy-LA
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 07:09:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbZBOGIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 01:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbZBOGIS
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 01:08:18 -0500
Received: from peff.net ([208.65.91.99]:39916 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718AbZBOGIR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 01:08:17 -0500
Received: (qmail 5324 invoked by uid 107); 15 Feb 2009 06:08:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 15 Feb 2009 01:08:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 01:08:15 -0500
Content-Disposition: inline
In-Reply-To: <20090214211548.GA14898@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109965>

On Sat, Feb 14, 2009 at 04:15:48PM -0500, Jeff King wrote:

> On Sat, Feb 14, 2009 at 03:21:30PM -0500, Daniel Barkalow wrote:
> 
> > I haven't checked lately, but I think that what's actually needed is to 
> > have the locate_head() function notice if the struct ref for HEAD actually 
> > has the symref field non-NULL, and report that as the unambiguous answer. 
> 
> Indeed. Something like the patch below works (on top of Jay's patches).
> [...]
> I will try to make something a little neater later today.

Here is a cleaner series. It depends on all of Jay's remote patches,
including the set-head one. I can resend once the dust is a little more
settled on those patches.

The first two are prep for adding a test in 5/5:

   1/5: test scripts: refactor start_httpd helper
   2/5: add basic http clone/fetch tests

These ones are code cleanup for 5/5:

   3/5: refactor find_refs_by_name to accept const list
   4/5: remote: refactor guess_remote_head

And this is the useful one.

   5/5: remote: use exact HEAD lookup if it is available

-Peff
