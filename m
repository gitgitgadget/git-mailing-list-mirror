From: Jeff King <peff@peff.net>
Subject: Re: How can I figure out what commits relate to a given diff?
Date: Thu, 22 May 2008 12:04:14 -0400
Message-ID: <20080522160414.GA11158@sigill.intra.peff.net>
References: <48358F7E.6030401@harris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Steven A. Falco" <sfalco@harris.com>
X-From: git-owner@vger.kernel.org Thu May 22 18:06:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzDIg-0005IE-5g
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 18:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573AbYEVQEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 12:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755211AbYEVQE1
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 12:04:27 -0400
Received: from peff.net ([208.65.91.99]:4440 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754743AbYEVQER (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 12:04:17 -0400
Received: (qmail 3629 invoked by uid 111); 22 May 2008 16:04:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 22 May 2008 12:04:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2008 12:04:14 -0400
Content-Disposition: inline
In-Reply-To: <48358F7E.6030401@harris.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82636>

On Thu, May 22, 2008 at 11:21:34AM -0400, Steven A. Falco wrote:

> For example, one of the diffs in the patch file begins with:
> 
> diff --git a/Makefile b/Makefile
> index 9ceadaa..ad31bc6 100644
> 
> Is there a way to map a blob SHA1 to a commit?  In this example, I'd
> like to map 9ceadaa and ad31bc6 to their commits.  It seems easy to go
> the other way, seeing what is in a commit, but I've not been able to
> find a method for going "backwards" from a blob to a commit.

Miklos suggested a way of looking up trees and commits which contain
blobs, but you can also look for that specific change of blobs:

  git log --pretty=format:'%h %s' --raw |
    perl -00 -ne 'print if /9ceadaa.*ad31bc6/'

-Peff
