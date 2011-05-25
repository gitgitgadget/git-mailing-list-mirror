From: Jeff King <peff@peff.net>
Subject: Re: Cross-compiling git (was: [PATCHv2] add Android support)
Date: Wed, 25 May 2011 11:06:55 -0400
Message-ID: <20110525150655.GA8795@sigill.intra.peff.net>
References: <B22B44EF-0AFB-44E3-93E3-61FA730431B9@gieschke.de>
 <m3k4dhzynr.fsf_-_@localhost.localdomain>
 <20110523143040.GB17743@sigill.intra.peff.net>
 <201105251620.01116.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Rafael Gieschke <rafael@gieschke.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 17:07:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPFfr-0001NL-6o
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 17:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933106Ab1EYPG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 11:06:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40629
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932176Ab1EYPG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 11:06:57 -0400
Received: (qmail 820 invoked by uid 107); 25 May 2011 15:06:57 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 May 2011 11:06:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 May 2011 11:06:55 -0400
Content-Disposition: inline
In-Reply-To: <201105251620.01116.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174410>

On Wed, May 25, 2011 at 04:20:00PM +0200, Jakub Narebski wrote:

> Well, the vague sketch of an idea is for Makefile to set uname_*
> variables depending on the contents of `host` / `HOST` build variable,
> so that detection is based on the target OS.

Right. But my point is that there is no uname_* variable that
corresponds to Android (at least from me running "uname" on the one
Android device I have access to).  You need a new variable.

> > Whether you call it "ANDROID=YesPlease" or some other form.
> 
> I think it is better to solve more generic issue of cross-compiling
> Git rather than solving narrow issue of cross-compiling Git on Android.

Sure. But I think there are two orthogonal problems:

  1. How to specify alternate platform defaults when cross-compiling.

  2. When we are compiling for an Android platform, which knobs should
     be tweaked by default, and whether there should be a convenience
     "tweak these Android knobs" switch.

The name of the switch in (2) might be related to how (1) is
implemented, but it doesn't have to be.

Anyway, this is all getting a bit too theoretical to be productive.  I'm
not actually cross-compiling, so I don't really know how well or poorly
our current Makefile handles it, let alone the autoconf support on top
of our Makefile. So without patches to discuss, I think we're just going
in circles.

The original poster just wanted knobs for (2). Having (1) would be neat,
but I don't see any reason to hold up (2) if nobody is actually working
on (1).

-Peff
