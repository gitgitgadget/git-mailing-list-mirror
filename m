From: Jeff King <peff@peff.net>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a
	custom merge strategy
Date: Mon, 28 Jul 2008 15:26:51 -0400
Message-ID: <20080728192651.GA26677@sigill.intra.peff.net>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com> <20080728185604.GA26322@sigill.intra.peff.net> <alpine.DEB.1.00.0807282008470.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: sverre@rabbelier.nl, Git Mailinglist <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 21:28:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNYNu-0007ae-8h
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 21:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbYG1T0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 15:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752611AbYG1T0x
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 15:26:53 -0400
Received: from peff.net ([208.65.91.99]:1436 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752032AbYG1T0x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 15:26:53 -0400
Received: (qmail 2560 invoked by uid 111); 28 Jul 2008 19:26:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 28 Jul 2008 15:26:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jul 2008 15:26:51 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807282008470.8986@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90492>

On Mon, Jul 28, 2008 at 08:09:55PM +0100, Johannes Schindelin wrote:

> Well, I have to say that the workflow is a bit backwards if the person who 
> _publishes_ the thing is the one saying "Ooops, my version no goodie, 
> other version please, but so that pull still works".
> 
> I would have expected the one who has the good version to make the choice.

My situation was two long-running branches, "stable" and "devel",
both of which were worked on by many developers. One person was in
charge of integration and branch management. They wanted "stable" to
get the contents of "devel" (which were now ready for release), ignoring
any small fixes that had been done on "stable" (since they had all been
moved over to "devel" previously, but in subtly different ways that
would create conflicts). And "git reset" was not an option, because they
wanted to keep the history of "stable" in case those fixes needed to be
looked at later.

So the logical sequence was:

  git checkout production
  git merge -s theirs master

-Peff
