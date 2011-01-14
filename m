From: Jeff King <peff@peff.net>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Fri, 14 Jan 2011 15:07:06 -0500
Message-ID: <20110114200705.GA3316@sigill.intra.peff.net>
References: <AANLkTimf2rwKqyWwQbdj7cjS8YcQwCXYGRCvQbZ5HZ19@mail.gmail.com>
 <AANLkTik15iV9SOv6rRL5+DQkAZ4JwBGTS+gqS3nXy2hN@mail.gmail.com>
 <AANLkTikk7Xdiey76Dmy848_B4qNX2-Vbis7p=E8vtNL9@mail.gmail.com>
 <AANLkTimONqL4=E4Unrsj9PU5u57KGXrmO6xWUOCLorgs@mail.gmail.com>
 <AANLkTi=PTgmOSC7pRLjujO5fi9Wdp69Jmj4zCkhGSYSz@mail.gmail.com>
 <AANLkTiksAZSi-Yo8yJv5ca9XWWvB3iVQhZOJtTs-F8gk@mail.gmail.com>
 <AANLkTi=Z6Dx6m68zi7Q1eRVxX3DXOyKj+Ff177UCQrAj@mail.gmail.com>
 <AANLkTimZF+r2aNzrXsUuHVZR65N5wpOYLutFgGAGoci_@mail.gmail.com>
 <20110114162144.GA867@sigill.intra.peff.net>
 <7vhbdbnxud.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Tor Arntsen <tor@spacetec.no>, JT Olds <jtolds@xnet5.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 14 21:07:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pdpvd-0001d4-TH
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 21:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab1ANUHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 15:07:10 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:55586 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751922Ab1ANUHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 15:07:09 -0500
Received: (qmail 6898 invoked by uid 111); 14 Jan 2011 20:07:07 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 14 Jan 2011 20:07:07 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jan 2011 15:07:06 -0500
Content-Disposition: inline
In-Reply-To: <7vhbdbnxud.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165120>

On Fri, Jan 14, 2011 at 10:28:58AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So we should probably do one or both of:
> >
> >   1. Make an --allow-any-name option to mailinfo, and use it when we
> >      invoke mailinfo internally for rebasing. That still doesn't solve
> >      the emailed patch problem, but at least keeps purely internal
> >      operations sane.
> >
> >   2. Bump the check up to git-commit time, which is the best place to
> >      catch and tell somebody that their name is too short, because they
> >      can actually fix it.
> >
> > Even if we dropped the check now, option (2) is still useful, because
> > you have no idea which version of git the other end will use to apply
> > your patch.
> 
> I am perfectly Ok with making the check looser in "am" when $rebasing is
> in effect.  Wouldn't that solve the issue?

More or less. You would still have some lossiness when emailing your
patch. Do we want to warn about that?

-Peff
