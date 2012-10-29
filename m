From: Jeff King <peff@peff.net>
Subject: Re: merge --no-commit not able to report stats more verbosely?
Date: Mon, 29 Oct 2012 17:51:54 -0400
Message-ID: <20121029215154.GE20513@sigill.intra.peff.net>
References: <k63iai$kbp$1@ger.gmane.org>
 <20121028112150.GD11434@sigill.intra.peff.net>
 <CABURp0oX5aT=yEbYeDXoOPWj_aRscVBY327_E6uyrrp5TPvcxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Scott R. Godin" <scottg.wp-hackers@mhg2.com>, git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 22:52:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSxFz-0006hx-MN
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 22:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933041Ab2J2Vv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 17:51:59 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43085 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932945Ab2J2Vv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 17:51:57 -0400
Received: (qmail 23980 invoked by uid 107); 29 Oct 2012 21:52:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 17:52:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 17:51:54 -0400
Content-Disposition: inline
In-Reply-To: <CABURp0oX5aT=yEbYeDXoOPWj_aRscVBY327_E6uyrrp5TPvcxA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208642>

On Mon, Oct 29, 2012 at 02:12:32PM -0400, Phil Hord wrote:

> >> (develop)>$ git merge widget_twitter
> >> Merge made by the 'recursive' strategy.
> >>  .../code/community/Dnd/Magentweet/Model/User.php   |    3 ++-
> >>  1 files changed, 2 insertions(+), 1 deletions(-)
> >
> > Whereas here you do, and you get a diffstat.
> >
> > When you are in the middle of an uncompleted merge and want to know what
> > is happening, you should look at the index using "git status" (to get an
> > overview of what is ready to be committed and what is unmerged), "git
> > diff --cached" (to see what was automatically merged and is ready for
> > commit), and "git diff" (to see conflicted entries that still need to be
> > resolved).
> 
> I think he is looking for this bit
>     "Merge made by the 'recursive' strategy."
> 
> But he is seeing this instead:
>     "Automatic merge went well; stopped before committing as requested"
> 
> Should the "what happened" output be silenced on --no-commit?

Ah. Yeah, we should not print "Merge made by the..." because we did not
make a merge (and that message is part of the process to update the
ref). But in verbose mode, we could probably say more about the on-going
process (like which strategies we are trying). Patches welcome.

-Peff
