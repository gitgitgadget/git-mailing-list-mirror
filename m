From: Jeff King <peff@peff.net>
Subject: Re: Transfer notes when rebasing
Date: Wed, 4 Sep 2013 04:49:45 -0400
Message-ID: <20130904084945.GA22470@sigill.intra.peff.net>
References: <CAC9WiBiSLMO+JM3aEHZ8xdwKE=jh+mDuo4REQ7rnQ-rTDNb9qA@mail.gmail.com>
 <20130904075310.GB9637@sigill.intra.peff.net>
 <20130904075941.GA2582@serenity.lan>
 <20130904082803.GA17308@sigill.intra.peff.net>
 <CAC9WiBg+0PkEeBst6sw5uuCb4-21=zj+XCcjwKWSfAYi-ciqDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 10:49:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH8mi-0001HV-CD
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 10:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934448Ab3IDItu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 04:49:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:34759 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934296Ab3IDItt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 04:49:49 -0400
Received: (qmail 31272 invoked by uid 102); 4 Sep 2013 08:49:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Sep 2013 03:49:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Sep 2013 04:49:45 -0400
Content-Disposition: inline
In-Reply-To: <CAC9WiBg+0PkEeBst6sw5uuCb4-21=zj+XCcjwKWSfAYi-ciqDA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233823>

On Wed, Sep 04, 2013 at 10:47:22AM +0200, Francis Moreau wrote:

> > However, if the commit is dropped because we find while applying that it
> > becomes empty, there is not much we can do. It may have been obsoleted
> > by its counterpart patch that had a different patch-id, or it may even
> > have been obsoleted by unrelated patches. In the latter case, there is
> > nothing to copy to. In the former, you would have to trying to match up
> > the commit messages or similar to guess that the two commits correspond.
> 
> Can't git-rebase at least handle the case where a patch and its
> counterpart have the same patch-id ?

Certainly it could. My point was only that it doesn't currently (and it
does not even know what the counterpart is, only that there is one).

> Also maybe git-rebase should warn when dropping a commit having a note
> to tell the user that the note is dropped too.

That might end up annoying, depending on what you use notes for. But
I think if it were restricted to notes that would be rewritten via
notes.rewriteRef, it probably makes sense.

Patches welcome.

-Peff
