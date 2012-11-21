From: Jeff King <peff@peff.net>
Subject: Re: Topics currently in the Stalled category
Date: Wed, 21 Nov 2012 14:34:02 -0500
Message-ID: <20121121193401.GC16280@sigill.intra.peff.net>
References: <20121121024647.BBCC82E9301@grass.foxharp.boston.ma.us>
 <20121121092750.GA8262@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Fox <pgf@foxharp.boston.ma.us>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 20:34:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbG3y-00007C-LY
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 20:34:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755862Ab2KUTeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 14:34:06 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54439 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755768Ab2KUTeF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 14:34:05 -0500
Received: (qmail 9468 invoked by uid 107); 21 Nov 2012 19:34:57 -0000
Received: from ip68-100-44-35.dc.dc.cox.net (HELO sigill.intra.peff.net) (68.100.44.35)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 Nov 2012 14:34:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Nov 2012 14:34:02 -0500
Content-Disposition: inline
In-Reply-To: <20121121092750.GA8262@shrek.podlesie.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210167>

On Wed, Nov 21, 2012 at 10:27:50AM +0100, Krzysztof Mazur wrote:

> >  > * pf/editor-ignore-sigint (2012-11-11) 5 commits
> >  > 
> >  >  Avoid confusing cases where the user hits Ctrl-C while in the editor
> >  >  session, not realizing git will receive the signal. Since most editors
> >  >  will take over the terminal and will block SIGINT, this is not likely
> >  >  to confuse anyone.
> >  > 
> >  >  Some people raised issues with emacsclient, which are addressed by this
> >  >  re-roll. It should probably also handle SIGQUIT, and there were a
> >  >  handful of other review comments.
> >  > 
> >  >  Anybody interested in moving this forward?
> > 
> > i started this, but then jeff took it and ran with it and made it
> > right.  i think the remaining changes are small -- if jeff would
> > prefer, i can probably finish it.  (but i won't guarantee not to
> > mess up the "From:" lines.  :-)
> > 
> 
> I'm also interested. I sometimes use ":r !command" in vim, so far I never
> needed to use Ctrl-C, but maybe in future.
> 
> The SIGINT part seems to be finished, we need to decide what about SIGQUIT.

My plan was to just add in SIGQUIT[1] alongside SIGINT (and I think
there may have been one or two other minor comments in response to the
series). I am on vacation this week, but can revisit it next week. If
somebody wants to re-roll it in the meantime, that would be fine with
me.

-Peff

[1] Given the core-dumping behavior of SIGQUIT, I suspect it is not
    nearly as widely used as SIGINT, but it sounds more like the
    principle of least surprise to treat them the same.
