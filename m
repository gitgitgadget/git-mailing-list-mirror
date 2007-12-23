From: Jeff King <peff@peff.net>
Subject: Re: cvsimport: trying to convert freebsd cvs to git
Date: Sun, 23 Dec 2007 12:29:13 -0500
Message-ID: <20071223172913.GA9297@sigill.intra.peff.net>
References: <20071222171801.GE15286@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stefan Sperling <stsp@stsp.name>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Dec 23 18:29:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6Udw-0006zQ-F0
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 18:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbXLWR3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2007 12:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbXLWR3R
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Dec 2007 12:29:17 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4956 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752839AbXLWR3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2007 12:29:16 -0500
Received: (qmail 17028 invoked by uid 111); 23 Dec 2007 17:29:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 23 Dec 2007 12:29:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Dec 2007 12:29:13 -0500
Content-Disposition: inline
In-Reply-To: <20071222171801.GE15286@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69189>

On Sat, Dec 22, 2007 at 06:18:01PM +0100, Miklos Vajna wrote:

> then i tried:
> 
> $ time git cvsimport -d `pwd`/cvs -C src.git src
> Initialized empty Git repository in /home/vmiklos/git/freebsd/src.git/.git/
> malformed revision

This is the actual error; everything else is git-cvsimport failing to
notice the problem and continuing anyway.

I will take a look and see if it is simple to stop the process here and
produce a better error message.

> 1) does cvsimport supports the case when the source if on the local
> filesystem, and not in not on a cvs server?

Yes, it should work fine (it will still call cvsps and CVS, so it should
look the same to git-cvsimport).

> 2) if it supports, then i think the real error message is 'malformed
> revision'. what is the proper way to see where is that revision?

Try git-cvsimport -v.

-Peff
