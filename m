From: Jeff King <peff@peff.net>
Subject: Re: Feature request: fetch --prune by default
Date: Tue, 21 Aug 2012 02:51:14 -0400
Message-ID: <20120821065113.GB3238@sigill.intra.peff.net>
References: <2C63E314-2EF5-4B8E-B96A-5306E317E045@gmail.com>
 <20120719115558.GC29774@sigill.intra.peff.net>
 <CAPBPrnsFk-Ww-52W-=qkTK7Yifjowx3tpsELznO4ncmqwfP_Qg@mail.gmail.com>
 <7vzk5uxvzl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexey Muranov <alexey.muranov@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 08:51:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3iJA-0000z8-DH
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 08:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297Ab2HUGvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 02:51:19 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43477 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775Ab2HUGvR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 02:51:17 -0400
Received: (qmail 28723 invoked by uid 107); 21 Aug 2012 06:51:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Aug 2012 02:51:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2012 02:51:14 -0400
Content-Disposition: inline
In-Reply-To: <7vzk5uxvzl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203945>

On Thu, Aug 16, 2012 at 04:22:54PM -0700, Junio C Hamano wrote:

> > In the meantime, would it make sense to introduce a configuration
> > variable to request this behavior?
> >
> > If so, should it be global?
> >
> > fetch.prune = always
> >
> > or per-remote?
> >
> > remote.<name>.prune = always
> >
> > The global option seems to be more in line with what Alexey is looking
> > for, but the per-remote one is similar to the tagopt option, which is
> > a similar idea.
> >
> > Of course, this might be just a waste of time to introduce a feature
> > no one would use, in which case we obviously should not introduce such
> > options.
> 
> I was reading through the backlog today and noticed that this topic
> veered into the "reflog graveyard" tangent.  I wasn't involved in
> the main topic, but I think having both configuration variables,
> remote.<remote>.prune taking precedence over fetch.prune, as long as
> we make sure "fetch --no-prune" will override any configured
> default, is not a bad thing per-se.
> 
> As long as the users who elect to use this feature are aware of the
> pruning of the refs and logs, that is, but "branch [-r] -d" has been
> the way to lose both the branch and its log for a long time, so I do
> not see a big issue there, either.
> 
> The log graveyard is an independently interesting idea, which I may
> ping separately, but I consider it pretty much orthogonal to this
> particular topic.

Yeah, I think that is sensible. As long as the _default_ is not to
prune, and people are making a conscious choice to prune, I don't see a
problem at all.

The log graveyard is orthogonal to the proposed option, but I think it
would be a necessary step before flipping the default for that option to
"true".

-Peff
