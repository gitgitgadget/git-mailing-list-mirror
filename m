From: Jeff King <peff@peff.net>
Subject: Re: Feature: git stash pop --always-drop
Date: Mon, 10 Aug 2015 09:32:21 -0400
Message-ID: <20150810133220.GA3559@sigill.intra.peff.net>
References: <loom.20150810T124037-407@post.gmane.org>
 <20150810124125.GC32371@sigill.intra.peff.net>
 <loom.20150810T144849-152@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ed Avis <eda@waniasset.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 15:32:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOnBy-0000oy-Js
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 15:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332AbbHJNc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 09:32:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:42986 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752750AbbHJNc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 09:32:26 -0400
Received: (qmail 11954 invoked by uid 102); 10 Aug 2015 13:32:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 08:32:25 -0500
Received: (qmail 5254 invoked by uid 107); 10 Aug 2015 13:32:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 09:32:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 09:32:21 -0400
Content-Disposition: inline
In-Reply-To: <loom.20150810T144849-152@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275617>

On Mon, Aug 10, 2015 at 12:50:51PM +0000, Ed Avis wrote:

> An alternative would be for git stash to always print the name of the stash
> it is applying.  Then you can drop it afterwards by name and be sure you got
> the right one.  Printing the name of the stash sounds like a reasonable
> bit of chatter to add anyway, do you agree?

Yeah, I agree that makes sense. We already show something like:

  Dropped refs/stash@{0} (31cb86c3d700d241e315d989f460e3e83f84fa19)

when dropping. Perhaps model the message after that:

  Applying refs/stash@{0} (31cb86c3d700d241e315d989f460e3e83f84fa19)

Or maybe it would be useful to actually show the stash subject, though
the defaults are not very informative (just "WIP on master", and then
some totally irrelevant commit subject).

-Peff
