From: Jeff King <peff@peff.net>
Subject: Re: Cloning from kernel.org, then switching to another repo
Date: Mon, 12 Nov 2007 23:48:11 -0500
Message-ID: <20071113044810.GA11731@sigill.intra.peff.net>
References: <9e4733910711120557w62a9966bvb61a02a2bf9b99e9@mail.gmail.com> <Pine.LNX.4.64.0711121412410.4362@racer.site> <9e4733910711120736g31e3e84cx5a213afc4b889de7@mail.gmail.com> <Pine.LNX.4.64.0711121613570.4362@racer.site> <9e4733910711120822x18019fe6v40eb8ee0e48282dd@mail.gmail.com> <Pine.LNX.4.64.0711121635130.4362@racer.site> <9e4733910711120921q651208cby1276426ccd4b5fa4@mail.gmail.com> <20071113042017.GB9745@sigill.intra.peff.net> <9e4733910711122030q7bbf6057ubb6b5b27e1885500@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 05:48:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrnhQ-00019V-Aj
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 05:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756291AbXKMEsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 23:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756826AbXKMEsP
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 23:48:15 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1962 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755763AbXKMEsP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 23:48:15 -0500
Received: (qmail 17476 invoked by uid 111); 13 Nov 2007 04:48:12 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 12 Nov 2007 23:48:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2007 23:48:11 -0500
Content-Disposition: inline
In-Reply-To: <9e4733910711122030q7bbf6057ubb6b5b27e1885500@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64751>

On Mon, Nov 12, 2007 at 11:30:17PM -0500, Jon Smirl wrote:

> Execute bit was not set. I just set it for all the scripts. +x is not

I assume by "all the scripts" you mean "all of the post-update scripts
in my repositories" and not "all of the hook scripts in this
repository". Because I think some of the included hooks are not suitable
to run without some configuration, which is why they are disabled by
default.

> getting turned on with a default git init-db. I just made a new repo
> to check, no +x on the scripts.

Right. git-init just copies the files from the templates directory
(probably /usr/share/git-core/templates or similar), so if the hook is
not enabled there, it will not be in the new repo. And git ships with
all hooks disabled by default.

cogito used to enable the post-update hook by default for bare repos (if
you called cg-admin-setuprepo), but git never has.

It is mentioned in the "exporting a git repository via http" section of
the user manual.

-Peff
