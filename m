From: Jeff King <peff@peff.net>
Subject: Re: Working with Git and CVS in a team.
Date: Sun, 15 Jun 2008 16:48:41 -0400
Message-ID: <20080615204841.GA10270@sigill.intra.peff.net>
References: <200806131633.34980.mirko.stocker@hsr.ch> <200806132247.03947.m1stocke@hsr.ch> <20080613205525.GA21165@sigill.intra.peff.net> <200806152222.50119.me@misto.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Stocker Mirko (m1stocke@hsr.ch)" <m1stocke@hsr.ch>,
	Git Mailing List <git@vger.kernel.org>
To: Mirko Stocker <me@misto.ch>
X-From: git-owner@vger.kernel.org Sun Jun 15 22:50:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7zAw-0002ZH-4N
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 22:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbYFOUso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 16:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbYFOUso
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 16:48:44 -0400
Received: from peff.net ([208.65.91.99]:2230 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070AbYFOUso (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 16:48:44 -0400
Received: (qmail 14686 invoked by uid 111); 15 Jun 2008 20:48:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 15 Jun 2008 16:48:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Jun 2008 16:48:41 -0400
Content-Disposition: inline
In-Reply-To: <200806152222.50119.me@misto.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85117>

On Sun, Jun 15, 2008 at 10:22:49PM +0200, Mirko Stocker wrote:

> >   mkdir bare.git && (cd bare.git && git init)
> >   mkdir cvsimport-hack && ln -s ../bare.git cvsimport-hack/.git
> >   git cvsimport -C cvsimport-hack
> 
> Uh, ok.. :) Thanks. 
> 
> I just wondered, do I even need the additional bare repository? If I use 
> git-cvsimport with -i, then it creates only the .git without doing a 
> checkout, then we could just clone this one from the clients and pull/push to 
> it?

Sure. From the client perspective, there's not really a difference
between a bare repo and one with a working directory. Using just one
repo with a working directory will mean you just have one extra checkout
on the server, which wastes a little space.

-Peff
