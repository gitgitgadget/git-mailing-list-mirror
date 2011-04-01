From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/4] run-command: implement abort_async for pthreads
Date: Fri, 1 Apr 2011 10:00:11 -0400
Message-ID: <20110401140011.GB1650@sigill.intra.peff.net>
References: <20110331184243.GA12027@sigill.intra.peff.net>
 <20110331184546.GA16981@sigill.intra.peff.net>
 <AANLkTikF_xLTdY0BgaXmUXvBJTG3HD3by9zN59KwPii5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 16:00:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5etn-0000ZA-Iz
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 16:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756682Ab1DAOAO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2011 10:00:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40110
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754340Ab1DAOAN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 10:00:13 -0400
Received: (qmail 9113 invoked by uid 107); 1 Apr 2011 14:00:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Apr 2011 10:00:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Apr 2011 10:00:11 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikF_xLTdY0BgaXmUXvBJTG3HD3by9zN59KwPii5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170587>

On Fri, Apr 01, 2011 at 11:41:12AM +0200, Erik Faye-Lund wrote:

> On Thu, Mar 31, 2011 at 8:45 PM, Jeff King <peff@peff.net> wrote:
> > We just need to cancel the thread, instead of sending it a
> > signal as we do for fork()'d async sections.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > This could also just be part of the merge resolution, but I thought=
 it
> > would be easier to see what is going on if I put it here.
> >
> > =C2=A0run-command.c | =C2=A0 =C2=A02 +-
> > =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/run-command.c b/run-command.c
> > index e31c073..46ea07d 100644
> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -607,7 +607,7 @@ void abort_async(struct async *async)
> > =C2=A0#ifdef NO_PTHREADS
>=20
> This context-line doesn't match 3/4... Did you send out the wrong
> version of that patch?

No, read the cover letter. After 4/4, you have to merge the fix up to a
more modern version with pthreads, then this goes on top of the
resolution.

-Peff
