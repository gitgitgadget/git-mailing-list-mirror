From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] perl/Makefile: use 'installsitelib' even with
 NO_PERL_MAKEMAKER
Date: Mon, 6 Feb 2012 15:34:29 -0500
Message-ID: <20120206203429.GA31404@sigill.intra.peff.net>
References: <24482D02-B773-4FE3-8FC7-92B8B4D8C0FA@spotify.com>
 <7328033C-8A11-452D-A927-E81E2DC4ABD6@spotify.com>
 <20120206202610.GC30776@sigill.intra.peff.net>
 <9D199309-85A6-42EE-9417-8C4E61534670@spotify.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nicholas Harteau <nrh@ikami.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 21:34:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuVGn-0003vT-AO
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 21:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591Ab2BFUec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 15:34:32 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58943
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016Ab2BFUeb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 15:34:31 -0500
Received: (qmail 30907 invoked by uid 107); 6 Feb 2012 20:41:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Feb 2012 15:41:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2012 15:34:29 -0500
Content-Disposition: inline
In-Reply-To: <9D199309-85A6-42EE-9417-8C4E61534670@spotify.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190099>

On Mon, Feb 06, 2012 at 03:30:54PM -0500, Nicholas Harteau wrote:

> >>> ifdef NO_PERL_MAKEMAKER
> >>> -instdir_SQ = $(subst ','\'',$(prefix)/lib)
> >>> +instdir_SQ = $(subst ','\'',$(subst installsitelib=,'',$(shell $(PERL_PATH_SQ) -V:installsitelib)))
> > 
> > Isn't this a regression if I am a non-root user installing into
> > $HOME/local or similar? With MakeMaker, I end up with this in my
> > perl.mak:
> [...]
> 
> Totally correct - let me re-think the non-root case.  Thanks.

I just read the github PR you linked to. It sounds like it might work to
just add a knob that the homebrew recipe could tweak to enable this
behavior (with the knob off by default).

-Peff
