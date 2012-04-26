From: Jeff King <peff@peff.net>
Subject: Re: git-push sent too many objects
Date: Thu, 26 Apr 2012 09:07:17 -0400
Message-ID: <20120426130717.GB27785@sigill.intra.peff.net>
References: <CAJo=hJuGHymJtZL14mAq0gBZE+za5URoon=rMzPA=tTQC14ftQ@mail.gmail.com>
 <15053.1334758946@plover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Mark Jason Dominus <mjd@plover.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 15:07:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNOPt-0000fL-4q
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 15:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756252Ab2DZNHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 09:07:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47148
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755527Ab2DZNHU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 09:07:20 -0400
Received: (qmail 15905 invoked by uid 107); 26 Apr 2012 13:07:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Apr 2012 09:07:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Apr 2012 09:07:17 -0400
Content-Disposition: inline
In-Reply-To: <15053.1334758946@plover.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196367>

On Wed, Apr 18, 2012 at 10:22:26AM -0400, Mark Jason Dominus wrote:

> Shawn Pearce:
> > On Tue, Apr 17, 2012 at 09:53, Mark Jason Dominus <mjd@plover.com> wrote:
> > > What happened here? =A0Why did git-push send 1,315 objects instead of 5?
> > 
> > Is it possible someone else modified the repository at the same time?
> 
> It is extremely unlikely. This repository is controlled by gitolite
> and I am the only person who has push access to it. Also, although my
> paste doesn't show it, the repository's master reference had not
> moved.

Is the repository public? I can't reproduce the issue on a trivial test
case, but it might be possible to create the original state of the
client and server repos with judicious use of "reset" and "prune".
If we can get a reliable case, then running with GIT_TRACE_PACKET will
show the commit negotiation that we go through.

-Peff
