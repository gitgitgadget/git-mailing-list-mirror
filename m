From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Mon, 8 Apr 2013 17:45:12 -0400
Message-ID: <20130408214512.GA11227@sigill.intra.peff.net>
References: <CAAvHm8PCQx18Gk2S7dicG+_GksjFqVLfPNCbism1sHnPUMDNzg@mail.gmail.com>
 <1365091293-23758-1-git-send-email-jkoleszar@google.com>
 <87wqscr9yk.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Koleszar <jkoleszar@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Josh Triplett <josh@joshtriplett.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 08 23:45:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPJsR-0002HS-4v
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 23:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965131Ab3DHVpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 17:45:18 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34351 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964857Ab3DHVpR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 17:45:17 -0400
Received: (qmail 16789 invoked by uid 107); 8 Apr 2013 21:47:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Apr 2013 17:47:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Apr 2013 17:45:12 -0400
Content-Disposition: inline
In-Reply-To: <87wqscr9yk.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220525>

On Mon, Apr 08, 2013 at 11:25:39PM +0200, Thomas Rast wrote:

> At the risk of repeating something that's been said already -- I only
> skimmed the thread -- this test breaks in today's pu on my machine.  I
> get:
> [...]
> --- expect	2013-04-08 21:24:36.571874540 +0000
> +++ actual	2013-04-08 21:24:36.579874619 +0000
> @@ -1,3 +1,2 @@
> -453190505bf07f7513bed9839da875eb3610f807	HEAD
>  453190505bf07f7513bed9839da875eb3610f807	refs/heads/master
>  453190505bf07f7513bed9839da875eb3610f807	refs/namespaces/ns/refs/heads/master
> not ok 14 - backend respects namespaces

I think what is in pu is not yet reflecting the latest discussion. HEAD
should not be included in the simulated info/refs, but should be
generated, respecting namespaces, whenever a client retrieves the HEAD
file directly.

It looks like the thread was left here;

  http://article.gmane.org/gmane.comp.version-control.git/220237

and we are just waiting for John's re-roll.

-Peff
