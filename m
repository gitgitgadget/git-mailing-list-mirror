From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] peel_ref cleanups changes
Date: Mon, 6 May 2013 22:54:58 -0400
Message-ID: <20130507025458.GA22912@sigill.intra.peff.net>
References: <20130507023610.GA22053@sigill.intra.peff.net>
 <20130507024313.GC22940@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 07 04:55:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZY3Y-0008Dp-Ev
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 04:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758703Ab3EGCzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 22:55:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:43769 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758548Ab3EGCzA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 22:55:00 -0400
Received: (qmail 15101 invoked by uid 102); 7 May 2013 02:55:21 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 May 2013 21:55:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 May 2013 22:54:58 -0400
Content-Disposition: inline
In-Reply-To: <20130507024313.GC22940@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223529>

On Mon, May 06, 2013 at 10:43:13PM -0400, Jeff King wrote:

> I hooked the refreshing into get_packed_refs, since then all callers get
> it for free. It makes me a little nervous, though, just in case some
> caller really cares about calling get_packed_refs but not having the
> list of packed-refs change during the call. peel_ref looks like such a
> function, but isn't, for reasons I'll explain in a followup patch.

I thought I would need the cleanups below for peel_ref, but it turns out
that the middle chunk of the function is never exercised. They conflict
textually with Michael's mh/packed-refs-various topic, so I think it may
make sense to just rebase them on top of that.

  [1/2]: peel_ref: rename "sha1" argument to "peeled"
  [2/2]: peel_ref: refactor for safety with simultaneous update

-Peff
