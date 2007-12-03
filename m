From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] Use regex for :/ matching
Date: Mon, 3 Dec 2007 12:30:22 -0500
Message-ID: <20071203173022.GA19219@coredump.intra.peff.net>
References: <20071203043258.GA16658@coredump.intra.peff.net> <Pine.LNX.4.64.0712031052410.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 03 18:31:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzF81-0005m8-HL
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 18:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbXLCRaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 12:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbXLCRaZ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 12:30:25 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4980 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750969AbXLCRaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 12:30:25 -0500
Received: (qmail 30918 invoked by uid 111); 3 Dec 2007 17:30:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 03 Dec 2007 12:30:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Dec 2007 12:30:22 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0712031052410.27959@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66930>

On Mon, Dec 03, 2007 at 10:55:15AM +0000, Johannes Schindelin wrote:

> > The sha1 syntax :/ used to be a strict prefix match.
> > Instead, let's use a regular expression, which can save on
> Heh: 
> http://repo.or.cz/w/git/dscho.git?a=commitdiff;h=2546cd9732bb8d4bc1d2485ba7bbc1d5c8bac935

Hmm, the major difference seems to be that you grep the entire body,
whereas I grep just the oneline. My goal was to avoid matching the
search string in the message of a merge commit with merge summaries
turned on.

> Except that I did not support ".." (does yours?), _and_ that my patch is 
> not as nice as yours.

No, I didn't. I'm not sure it is sane, since :/ can contain free-form
text (and with a regex, .. is not that unlikely). And you can always do
git-log --not :/foo :/bar

> But then, my patch also works when save_commit_buffer == 0.  But I can 
> refactor this into its own patch, since it really is a separate issue.

Agreed.

-Peff
