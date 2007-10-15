From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Color support added to git-add--interactive.
Date: Mon, 15 Oct 2007 00:12:02 -0400
Message-ID: <20071015041202.GA5939@coredump.intra.peff.net>
References: <471045DA.5050902@gmail.com> <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Zwell <dzwell@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 06:12:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhHJw-00081I-L9
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 06:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbXJOEMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 00:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbXJOEMJ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 00:12:09 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4058 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753246AbXJOEMH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 00:12:07 -0400
Received: (qmail 17221 invoked by uid 111); 15 Oct 2007 04:12:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 15 Oct 2007 00:12:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Oct 2007 00:12:02 -0400
Content-Disposition: inline
In-Reply-To: <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60940>

On Sat, Oct 13, 2007 at 04:45:41PM +0200, Wincent Colaiuta wrote:

> - changed the regex as suggested by Johannes, and a couple of others
> that are used when splitting hunks

BTW, this approach is totally bogus. The hunks that we store end up
getting fed back to git-apply when we stage them (which doesn't
understand the color codes).

Just try using your patch to actually stage a hunk; nothing happens (and
the error is almost impossible to see, since we show the bogus diff on
stderr).

So now I am doubly convinced that colorizing the diffs in
add--interactive is the right thing (and it looks like Tom Tobin has
already done a fair bit of the work).

-Peff
