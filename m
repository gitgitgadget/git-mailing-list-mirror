From: Jeff King <peff@peff.net>
Subject: Re: Show containing branches in log?
Date: Wed, 2 Jul 2014 12:34:51 -0400
Message-ID: <20140702163451.GB14404@sigill.intra.peff.net>
References: <CAHd499A78BRVawWSHNnzJcD1Ca7RfFeEnJf0SB7py1MD5qwL0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 18:35:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2NUn-0003yM-S5
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 18:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756335AbaGBQey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 12:34:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:54948 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754104AbaGBQex (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 12:34:53 -0400
Received: (qmail 22831 invoked by uid 102); 2 Jul 2014 16:34:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Jul 2014 11:34:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Jul 2014 12:34:51 -0400
Content-Disposition: inline
In-Reply-To: <CAHd499A78BRVawWSHNnzJcD1Ca7RfFeEnJf0SB7py1MD5qwL0g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252793>

On Wed, Jul 02, 2014 at 09:50:57AM -0500, Robert Dailey wrote:

> I know that with the `git branch` command I can determine which
> branches contain a commit. Is there a way to represent this
> graphically with `git log`? Sometimes I just have a commit, and I need
> to find out what branch contains that commit. The reason why `git
> branch --contains` doesn't solve this problem for me is that it names
> almost all branches because of merge commits. Too much ancestry has
> been built since this commit, so there is no way to find the "closest"
> branch that contains that commit.
> 
> Is there a way to graphically see what is the "nearest" named ref to
> the specified commit in the logs?

Have you tried "git describe --contains --all <commit>"?

To some degree, I fear your question isn't something git can answer. If
the branch containing the commit has been merged into other branches,
then they all "contain" the commit. There is not really any reason to
prefer one over the other ("describe --contains" will try to find the
"closest" branch, but that is based on heuristics and is not necessarily
well-defined).

-Peff
