From: Jeff King <peff@peff.net>
Subject: Re: git-svn: Why not use git-fast-import?
Date: Tue, 22 Sep 2015 11:59:29 -0400
Message-ID: <20150922155928.GA16221@sigill.intra.peff.net>
References: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9D7@mail.accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Victor Leschuk <vleschuk@accesssoftek.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 17:59:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZePyk-0005b2-Mw
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 17:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933408AbbIVP7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 11:59:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:34487 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932940AbbIVP7b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 11:59:31 -0400
Received: (qmail 11180 invoked by uid 102); 22 Sep 2015 15:59:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Sep 2015 10:59:31 -0500
Received: (qmail 5083 invoked by uid 107); 22 Sep 2015 15:59:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Sep 2015 11:59:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Sep 2015 11:59:29 -0400
Content-Disposition: inline
In-Reply-To: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9D7@mail.accesssoftek.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278397>

On Tue, Sep 22, 2015 at 02:12:59AM -0700, Victor Leschuk wrote:

> I've been playing with git-svn for some time already and as it seems
> to me there are two most important problems which make it hard to use
> in production for large repositories. Very low speed and large memory
> footprint of synchronization with SVN repos (I am talking about clone
> and fetch operations mostly). I was wondering why the git-fast-import
> is not used for these purposes? Are there any serious limitations
> which make it impossible?

The main reason is that git-svn predates the invention of fast-import.
There was an attempt later to make a more "modern" svn interface:

  - it would provide a git-remote-helper interface (so you could use
    normal clone, fetch, and push with an "svn::" URL rather than a
    separate git-svn).

  - it would use fast-import for moving data into git

but it was never finished. I don't recall the specific problems offhand.
You can see the remnants in the vcs-svn directory of git, or you might
find discussions by searching the list archive.

-Peff
