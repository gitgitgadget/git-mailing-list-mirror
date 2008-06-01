From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] git-add--interactive: manual hunk editing mode v2.1
Date: Sun, 1 Jun 2008 11:14:10 -0400
Message-ID: <20080601151409.GA31769@sigill.intra.peff.net>
References: <200805232221.45406.trast@student.ethz.ch> <20080529185808.GA2140@sigill.intra.peff.net> <200806010241.51464.trast@student.ethz.ch> <200806011650.02245.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jun 01 17:15:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2pH3-0003ly-Cp
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 17:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbYFAPOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 11:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752189AbYFAPOO
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 11:14:14 -0400
Received: from peff.net ([208.65.91.99]:1819 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752211AbYFAPON (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 11:14:13 -0400
Received: (qmail 20713 invoked by uid 111); 1 Jun 2008 15:14:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 01 Jun 2008 11:14:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 01 Jun 2008 11:14:10 -0400
Content-Disposition: inline
In-Reply-To: <200806011650.02245.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83449>

On Sun, Jun 01, 2008 at 04:50:00PM +0200, Thomas Rast wrote:

> Adds a new option 'e' to the 'add -p' command loop that lets you
> edit the current hunk in your favourite editor.

I haven't had time to review your patch yet, but I'll hopefully get to
it in the next day or so. In the meantime, a quick comment on this
change:

> -			   $ix < (scalar @$hunks)-2 ? @$hunks[$ix+1..@$hunks] : ()) {
> +			   $ix < (scalar @$hunks)-1 ? @$hunks[$ix+1..@$hunks-1] : ()) {

An easier and less error prone way to write "@$hunks-1" is "$#{$hunks}".

> As a side note, what's the "right" way to deal with this situation of
> patch improvements?  I made a normal commit chain on a side branch to
> keep the history, but format-patch wants to make that into two mails,
> so I had to rebuild the message format from diff -p --stat.

Usually you would squash your changes together into a single commit
locally using "commit --amend" or "rebase -i".

-Peff
