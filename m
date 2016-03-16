From: Jeff King <peff@peff.net>
Subject: Re: Forgotten declaration of function path_name() in revision.h?
Date: Wed, 16 Mar 2016 14:48:53 -0400
Message-ID: <20160316184853.GA32615@sigill.intra.peff.net>
References: <56E9A07D.3080508@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Petr Stodulka <pstodulk@redhat.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 19:49:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agGVB-0004Yp-GM
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 19:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935201AbcCPSs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 14:48:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:60815 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932139AbcCPSs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 14:48:56 -0400
Received: (qmail 11913 invoked by uid 102); 16 Mar 2016 18:48:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 14:48:56 -0400
Received: (qmail 17276 invoked by uid 107); 16 Mar 2016 18:49:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 14:49:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Mar 2016 14:48:53 -0400
Content-Disposition: inline
In-Reply-To: <56E9A07D.3080508@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289016>

On Wed, Mar 16, 2016 at 07:05:49PM +0100, Petr Stodulka wrote:

> according to commit 9831e92 (merge) there is maybe by mistake kept declaration
> of function path_name() in revision.h, whose definition was removed
> and isn't used in git anymore.

Yes, this should have been part of de1e67d (list-objects: pass full
pathname to callbacks, 2016-02-11), but I missed it.

The patch itself looks fine to me (though it probably makes more sense
to point to de1e67d than the merge).

Note also that:

> ======================================================================
> From ae72c8f9085b3b7bd84f94f90ff5b0416db59d67 Mon Sep 17 00:00:00 2001
> From: Petr Stodulka <pstodulk@redhat.com>
> Date: Wed, 16 Mar 2016 18:51:53 +0100
> Subject: [PATCH] remove obsoleted function path_name() from header file
>  revision.h

It makes things easier on the maintainer if you format your patch such
that "git am" can apply it directly. Use scissors like:

-- >8 --

to separate the patch from anything that should not go into the commit
message (rather than "=====..." as you have here).

Drop the "From " line which says nothing (it is an mbox separator, but
we are already inside a message).

The rest of the headers do not hurt, but are generally redundant with
what is in your email header (though in this case, the Subject is
different, so you would want to retain that).

-Peff
