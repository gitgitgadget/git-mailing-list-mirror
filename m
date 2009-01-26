From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 1/3] Introduce config variable "diff.primer"
Date: Mon, 26 Jan 2009 06:06:41 -0500
Message-ID: <20090126110641.GA19993@coredump.intra.peff.net>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <1232904657-31831-2-git-send-email-keith@cs.ucla.edu> <7v1vurf7lq.fsf@gitster.siamese.dyndns.org> <alpine.GSO.2.00.0901251345240.12651@kiwi.cs.ucla.edu> <20090126031206.GB14277@sigill.intra.peff.net> <alpine.DEB.1.00.0901261152320.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Keith Cascio <keith@CS.UCLA.EDU>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 26 12:08:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRPK5-00034A-MR
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 12:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbZAZLGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 06:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbZAZLGo
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 06:06:44 -0500
Received: from peff.net ([208.65.91.99]:40074 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706AbZAZLGo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 06:06:44 -0500
Received: (qmail 2330 invoked by uid 107); 26 Jan 2009 11:06:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 26 Jan 2009 06:06:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Jan 2009 06:06:41 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901261152320.14855@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107188>

On Mon, Jan 26, 2009 at 11:54:26AM +0100, Johannes Schindelin wrote:

> > So if you just want this from the command line, then I think it is safe 
> > to have "git diff" always respect "diff.primer", and scripts shouldn't 
> > be impacted.
> 
> But as Keith made clear, he wanted to use it from _git-gui_.  Which 
> -- naturally -- _has_ to use plumbing, to guarantee a stable interface.
>
> So "fixing" this in "git diff" is the wrong place; anything else than 
> teaching "git gui" to remember user-defined diff options and to use them 
> would be a complicator's glove.

I think what you are missing here is that he specifically mentioned the
command line, and I was responding to those comments. There are two
separate problems: default options for command line usage and the
mechanism by which one can set options for things like git-gui.

In this case he was asking specifically about "git diff" from the
command line, so fixing it in there _is_ the place to fix it (the only
other alternative being to make a wrapper or alias).

For the other problem, it _may_ benefit from tool support that would
help porcelains respect a "diff.primer" variable like Keith proposed.
But that has already been discussed elsewhere in the thread, so I'm not
going to repeat it here.

-Peff
