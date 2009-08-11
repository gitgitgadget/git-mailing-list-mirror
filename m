From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/8] Add a config option for remotes to specify a
 foreign vcs
Date: Tue, 11 Aug 2009 17:48:49 -0400
Message-ID: <20090811214849.GA3868@sigill.intra.peff.net>
References: <alpine.LNX.2.00.0908091526060.27553@iabervon.org>
 <7v1vnk79lt.fsf@alter.siamese.dyndns.org>
 <36ca99e90908110831g2ad52a5ar4a755723a6682f77@mail.gmail.com>
 <alpine.DEB.1.00.0908111817490.4638@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Brian Gernhardt <benji@silverinsanity.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 11 23:49:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MazDJ-0003Cb-Bb
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 23:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807AbZHKVsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 17:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753869AbZHKVsv
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 17:48:51 -0400
Received: from peff.net ([208.65.91.99]:58316 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753491AbZHKVsu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 17:48:50 -0400
Received: (qmail 6756 invoked by uid 107); 11 Aug 2009 21:48:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 11 Aug 2009 17:48:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Aug 2009 17:48:49 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0908111817490.4638@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125606>

On Tue, Aug 11, 2009 at 06:20:54PM +0200, Johannes Schindelin wrote:

> >        o   [user@]host.xz:/path/to/repo.git/
> 
> That is a valid concern.  I'd suggest to disallow @ and . in the protocol 
> name (maybe even everything non-alnum).  For shortcuts that really read 
> like "svn", I think it is not too much asked for to require adjusting the 
> URL (by prefixing ssh:// and adjusting the path).
> 
> If there is really anybody who uses Git via ssh to access a server called 
> "svn", we could just as well have a little fun with them, don't you agree?

It is not actually that unreasonable. I have remotes which point to:

  vcs:git/foo.git

where "vcs" is a shorthand for vcs.gtisc.gatech.edu, defined in my
.ssh/config (it's a machine which hosts several different version
control systems). So I could see somebody having something like "svn" if
they were, e.g., hosting a git-to-svn conversion on their company's svn
server.

And as far as asking people in such a situation to change, consider:

  1. No matter how small a change, asking for a change means you are
     breaking people's current config.

  2. ssh:// really is inferior, especially if you are typing it on the
     command-line as part of a one-off pull. It is really convenient to
     assume you start in your home directory (as above), and to be able
     to use tilde-notation to point to the home directories of others
     (e.g., "git pull vcs:~mike/foo.git").

-Peff
