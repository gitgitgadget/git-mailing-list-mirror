From: Jeff King <peff@peff.net>
Subject: Re: git version numbers
Date: Sun, 29 May 2011 23:34:28 -0400
Message-ID: <20110530033428.GB27691@sigill.intra.peff.net>
References: <20110528201321.GA26017@Imperial-SD-Longsword>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Mazid <timmazid@hotmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 05:34:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQtFS-00009k-Tj
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 05:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238Ab1E3Deb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2011 23:34:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52076
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753979Ab1E3Deb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2011 23:34:31 -0400
Received: (qmail 11764 invoked by uid 107); 30 May 2011 03:34:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 29 May 2011 23:34:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 29 May 2011 23:34:28 -0400
Content-Disposition: inline
In-Reply-To: <20110528201321.GA26017@Imperial-SD-Longsword>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174716>

On Sun, May 29, 2011 at 06:13:22AM +1000, Tim Mazid wrote:

> I was just looking at various versioning schemes, and I came to wonder
> about git's one.  Most of the ones out there are of the form
> <major>.<minor>.<optional revision> (j.n.r), but git seems to have four,
> as in 1.7.5.1.
> 
> So, I was wondering what you call each number in the git version; does
> the usual j.n.r apply to the last three and the first one is a
> "mystery"?  What is the official versioning scheme?  Does each number
> have any particular name?

In "git w.x.y.z", the decoding is:

  w: not likely to change short of a complete rewrite or something that
     is quite incompatible (i.e., will probably remain "1" for quite a
     while)

  x: when this jumps, it is a "big" version change, meaning there may be
     some minor incompatibilities or new ways of doing things. For
     example, 1.5.0 introduced a lot of usability changes and the
     separate-remotes layout became the default. In 1.6.0, we stopped
     shipping "git-*" in the PATH, and started using some new packfile
     features by default. And so on. If you want to know more, see
     Documentation/RelNotes/1.?.0.txt.

  y: when this jumps, it is a new release cut from master that does not
     have any "big" changes as above. There will be new features and
     some bugfixes. See RelNotes/1.7.?.txt for examples of what gets
     included.

  z: when this jumps, it is a bugfix release based on the feature
     release w.x.y. See RelNotes/1.7.5.?.txt for examples.

Getting more to your actual question, I don't know that we ever use any
particular name like "major" or "minor" for any of them. We do tend to
use the terms "feature release" for w.x.y releases and "bugfix release"
for w.x.y.z.

-Peff
