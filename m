From: Jeff King <peff@peff.net>
Subject: Re: detecting rename->commit->modify->commit
Date: Thu, 1 May 2008 11:38:05 -0400
Message-ID: <20080501153804.GC11469@sigill.intra.peff.net>
References: <4819CF50.2020509@tikalk.com> <20080501144524.GA10876@sigill.intra.peff.net> <4819DCF1.7090504@tikalk.com> <20080501152035.GB11145@sigill.intra.peff.net> <4819E226.6000404@tikalk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ittay Dror <ittayd@tikalk.com>
X-From: git-owner@vger.kernel.org Thu May 01 17:39:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jras4-0000Vh-9f
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 17:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757172AbYEAPiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 11:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756952AbYEAPiH
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 11:38:07 -0400
Received: from peff.net ([208.65.91.99]:3887 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756724AbYEAPiG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 11:38:06 -0400
Received: (qmail 14797 invoked by uid 111); 1 May 2008 15:38:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 01 May 2008 11:38:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 May 2008 11:38:05 -0400
Content-Disposition: inline
In-Reply-To: <4819E226.6000404@tikalk.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80925>

On Thu, May 01, 2008 at 06:30:46PM +0300, Ittay Dror wrote:

> Well, I would have expected git to notice that the file was renamed in  
> one commit and keep tracking changes afterwards.

That's not how git works, and that's not what you asked it to do. You
gave it two states and asked it to diff between them. It never even
looked at the intermediate steps (and that's generally why git is so
fast). If you want to follow the history and look at every commit, then
that is something that _can_ be done, and does get done with things like
"git log --follow". But there is a diff mode currently implemented that
will crawl the history looking for interesting things.

-Peff
