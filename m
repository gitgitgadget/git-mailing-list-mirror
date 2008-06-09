From: Jeff King <peff@peff.net>
Subject: Re: squashing patches
Date: Mon, 9 Jun 2008 16:53:21 -0400
Message-ID: <20080609205321.GA15912@sigill.intra.peff.net>
References: <20080607220101.GM31040@leksak.fem-net> <20080609114550.GA8079@leksak.fem-net> <7vprqqh06j.fsf@gitster.siamese.dyndns.org> <20080609204327.GD8079@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Joerg Sommer <joerg@alea.gnuu.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Mon Jun 09 22:54:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5oNg-000833-Po
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 22:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbYFIUxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 16:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbYFIUxZ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 16:53:25 -0400
Received: from peff.net ([208.65.91.99]:1892 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752252AbYFIUxY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 16:53:24 -0400
Received: (qmail 9445 invoked by uid 111); 9 Jun 2008 20:53:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 09 Jun 2008 16:53:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jun 2008 16:53:21 -0400
Content-Disposition: inline
In-Reply-To: <20080609204327.GD8079@leksak.fem-net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84426>

On Mon, Jun 09, 2008 at 10:43:27PM +0200, Stephan Beyer wrote:

> Something "like" this was my veeeery first approach: "edit" with commit
> was the backwards-compatible "edit" and without arguments was your
> "pause".
> Example:
> 	pick ea7beef
> 	edit		# or "pause" as you suggested
> After a little discussion this became:
> 	pick --edit ea7beef
> 
> And I can't objectively say what's better

I am just watching this from the sidelines, but it seems to me that you
are best off creating the directives as modular and orthogonal as
possible.  It is very simple to create "pick $1; edit" from "pick --edit
$1" later, but it is more difficult to go the other way around.

IOW, worry early about flexibility, and later you can build syntactic
sugar if you need to.

-Peff
