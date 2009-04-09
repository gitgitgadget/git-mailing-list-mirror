From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] branch: show upstream branch when double verbose
Date: Thu, 9 Apr 2009 04:23:50 -0400
Message-ID: <20090409082350.GD17221@coredump.intra.peff.net>
References: <20090407070254.GA2870@coredump.intra.peff.net> <20090407071656.GE2924@coredump.intra.peff.net> <49DB089A.7080207@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 09 10:25:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrpZx-0004kM-DG
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 10:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759804AbZDIIX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 04:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758922AbZDIIXy
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 04:23:54 -0400
Received: from peff.net ([208.65.91.99]:42793 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758445AbZDIIXx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 04:23:53 -0400
Received: (qmail 14505 invoked by uid 107); 9 Apr 2009 08:23:53 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.0.130)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 09 Apr 2009 04:23:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Apr 2009 04:23:50 -0400
Content-Disposition: inline
In-Reply-To: <49DB089A.7080207@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116149>

On Tue, Apr 07, 2009 at 10:02:34AM +0200, Michael J Gruber wrote:

> > will be interpreted as "origin/master is ahead 5, behind 6" when it is
> > really the reverse. Maybe "[ahead 5, behind 6 from origin/master]" would
> > be better?
> 
> Maybe [origin/master +5 -6]? That should be short enough for sticking it
> into -v. We could even use [origin/master +0 -0] for an up-to-date
> branch then.

I am not opposed to that format, but I don't feel strongly. And not many
people are voicing an opinion in this thread (strange, given that it is
an opportunity for bikeshedding :) ). My patches are in next, so I think
I am done on the topic for now. But feel free to submit a followup
patch.

> In any case, I think often one is interested in one branch only. I would
> expect "git branch -v foo" to give me the -v info just for branch foo.
> Currently it does not. But that would be an independent patch on top.

Hmm. I think that is a little counterintuitive because we think of "-v"
as simply "increase verbosity" (because that is what it means in just
about every program). But here you are fundamentally changing the action
that is occurring (from "create branch" to "show branch").  I think it
would make more sense to have a "show branch" mode like:

  git branch -s foo

which would probably have the more detailed output by default.

-Peff
