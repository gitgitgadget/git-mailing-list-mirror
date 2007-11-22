From: Jeff King <peff@peff.net>
Subject: Re: Temporary directories getting errantly added into trees
Date: Thu, 22 Nov 2007 05:43:52 -0500
Message-ID: <20071122104352.GB10389@sigill.intra.peff.net>
References: <4744FCD9.7020102@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 11:44:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv9Xb-0004G2-53
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 11:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbXKVKn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 05:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbXKVKnz
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 05:43:55 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3303 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751870AbXKVKnz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 05:43:55 -0500
Received: (qmail 21958 invoked by uid 111); 22 Nov 2007 10:43:53 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 22 Nov 2007 05:43:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2007 05:43:52 -0500
Content-Disposition: inline
In-Reply-To: <4744FCD9.7020102@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65778>

On Thu, Nov 22, 2007 at 04:51:53PM +1300, Sam Vilain wrote:

> I think it would be a good thing for all if you had to work very hard to
> put files like this in the tree, or perhaps it would be better to go
> through and make all the tools that create these temporary directories
> create them under .git instead.


Personally, I think they should all go under .git with very descriptive,
public names (the name ".dotest" is not really hidden from the user, and
I have never really been able to make sense of it. Surely there is some
more useful name?).

But I think there is the real possibility of damaging user scripts which
make assumptions based on the presence of .dotest (to see if we're in a
git-am or rebase session, etc). I have no idea how common such scripts
are.

-Peff
