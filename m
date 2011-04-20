From: Jeff King <peff@peff.net>
Subject: Re: Cloning a remote tag without using git-fetch-pack directly?
Date: Wed, 20 Apr 2011 03:38:05 -0400
Message-ID: <20110420073805.GA2285@sigill.intra.peff.net>
References: <20110419222050.GA3304@feather>
 <20110420062653.GE28597@sigill.intra.peff.net>
 <20110420072720.GC1790@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jamey Sharp <jamey@minilop.net>
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 09:38:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCRzJ-0005xJ-NZ
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 09:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318Ab1DTHiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 03:38:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53491
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753170Ab1DTHiI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 03:38:08 -0400
Received: (qmail 17057 invoked by uid 107); 20 Apr 2011 07:39:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Apr 2011 03:39:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Apr 2011 03:38:05 -0400
Content-Disposition: inline
In-Reply-To: <20110420072720.GC1790@feather>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171849>

On Wed, Apr 20, 2011 at 12:27:20AM -0700, Josh Triplett wrote:

> Sadly, though, I still can't check out the result:
> 
> /tmp/linux-2.6$ git checkout FETCH_HEAD
> fatal: Cannot switch branch to a non-commit.
> (128) /tmp/linux-2.6$ git checkout -b master FETCH_HEAD
> fatal: Cannot switch branch to a non-commit.
> 
> I guess I'd hoped for something similar to "detached HEAD" mode.

No, it wouldn't make any sense to have a non-commit in HEAD, detached or
otherwise, since you couldn't build commits on top of it (what would the
new commit's parent pointer have in it?).

If you just want to check the files out into the working tree, you can
do:

  git read-tree --reset -u FETCH_HEAD

But I'm not really clear on what you're trying to accomplish with all of
this. If you can describe your ultimate goal, I might be able to help
more.

-Peff
