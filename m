From: Jeff King <peff@peff.net>
Subject: Re: Which file is older in history?
Date: Thu, 21 Mar 2013 09:26:20 -0400
Message-ID: <20130321132620.GB23162@sigill.intra.peff.net>
References: <CALkWK0nTjoR9qBY-hnkrDKnyf8088ZDJ1LK_zNqAoAB7ndvaww@mail.gmail.com>
 <7vobeddcjq.fsf@alter.siamese.dyndns.org>
 <CALkWK0nRgzNYViKSx97OyHVOQmFN61Ex9EUvr1JK-0=GX=uX0w@mail.gmail.com>
 <20130321122130.GA22607@sigill.intra.peff.net>
 <20130321122428.GB22607@sigill.intra.peff.net>
 <CALkWK0nOzUXk0cFh8GCHc=YqLkRJ2XNFgU_tOsua81ROK99mXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 14:26:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIfWC-0002AO-A4
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 14:26:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758149Ab3CUN03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 09:26:29 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33819 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753140Ab3CUN02 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 09:26:28 -0400
Received: (qmail 22656 invoked by uid 107); 21 Mar 2013 13:28:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Mar 2013 09:28:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Mar 2013 09:26:20 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0nOzUXk0cFh8GCHc=YqLkRJ2XNFgU_tOsua81ROK99mXw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218726>

On Thu, Mar 21, 2013 at 06:02:32PM +0530, Ramkumar Ramachandra wrote:

> >   git log --format=%H --name-status --diff-filter=A -- path1 path2 |
> >   grep ^A |
> >   tail -1
> 
> Great!  I just learnt about --name-status now.

You can also use "--name-only", but the parsing is a little less robust.

> Nit: tail -<n> is deprecated in favor of tail -n <n>, I think.  It's
> nicer to have definite fixed command line options, as opposed to
> parsing an arbitrary -(*) and deciding if \1 is a \d+.

Yeah, POSIX has always specified "-n" for tail, as well as for head.  I
remember in the late 90's and early 00's running into systems where
POSIX "head -n" did not work, and you _had_ to use "head -1". I don't
recall now if that was the case for tail, too, nor what system that was
on (but if I had to guess, I'd say pre-Solaris SunOS).

So yeah. Using "tail -n 1" is probably a better idea in the long run.

-Peff
