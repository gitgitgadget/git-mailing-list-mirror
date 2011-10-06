From: Jeff King <peff@peff.net>
Subject: Re: git-cherry-pick and author field in version 1.7.6.4
Date: Thu, 6 Oct 2011 09:26:46 -0400
Message-ID: <20111006132646.GB1792@sigill.intra.peff.net>
References: <4E8C6F0E.7000508@6wind.com>
 <20111005174138.GA22962@sigill.intra.peff.net>
 <4E8D5DEA.9010500@6wind.com>
 <20111006112742.GA4445@sigill.intra.peff.net>
 <4E8DA0EE.50208@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 15:26:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBnyQ-00022s-2N
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 15:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865Ab1JFN0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 09:26:50 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54356
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935645Ab1JFN0t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 09:26:49 -0400
Received: (qmail 7496 invoked by uid 107); 6 Oct 2011 13:26:49 -0000
Received: from 208.177.47.101.ptr.us.xo.net (HELO sigill.intra.peff.net) (208.177.47.101)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Oct 2011 09:26:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Oct 2011 09:26:46 -0400
Content-Disposition: inline
In-Reply-To: <4E8DA0EE.50208@6wind.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182947>

On Thu, Oct 06, 2011 at 02:37:02PM +0200, Nicolas Dichtel wrote:

> >>Maybe it is related to the problem I've reported in another thread:
> >>http://comments.gmane.org/gmane.comp.version-control.git/182853
> >
> >Possibly. That issue is about the commit that comes _after_ the
> >cherry-pick, and in this instance, things are already wrong for you by
> >the time the cherry-pick has completed.
> >
> >However, the problem has to do with leaving a stale state file in .git,
> >so perhaps a previous partially-completed cherry-pick has left cruft in
> >.git that is confusing this cherry-pick (i.e., I can't reproduce because
> >it is being affected by something that happened before the commands
> >above). So let's see what Jay comes up with for solving the other
> >problem, and I suspect it may just fix this issue, too.
> I think so too. Will wait.

Since you can reproduce this so readily, and since you said it seems to
work with older versions of git, you might try bisecting. There's a
reasonable chance it will just end up at Jay's CHERRY_PICK_HEAD commit,
but it might be worth doing.

-Peff
