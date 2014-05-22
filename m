From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/9] strbuf: add strbuf_tolower function
Date: Thu, 22 May 2014 14:41:14 -0400
Message-ID: <20140522184113.GC1167@sigill.intra.peff.net>
References: <20140521102524.GA30301@sigill.intra.peff.net>
 <20140521102742.GB30464@sigill.intra.peff.net>
 <AD42BA87-3C73-4EB2-AF88-96C4F7E6FA0C@gmail.com>
 <20140522055852.GA16587@sigill.intra.peff.net>
 <xmqq38g1oe2y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 22 20:41:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnXvc-0004bR-Ia
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 20:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbaEVSlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 14:41:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:57568 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751249AbaEVSlP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 14:41:15 -0400
Received: (qmail 15200 invoked by uid 102); 22 May 2014 18:41:15 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 May 2014 13:41:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2014 14:41:14 -0400
Content-Disposition: inline
In-Reply-To: <xmqq38g1oe2y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249932>

On Thu, May 22, 2014 at 11:36:37AM -0700, Junio C Hamano wrote:

> > Yes, and that would be fine with me (I actually wrote strbuf_tolower for
> > my own use, and _then_ realized that we already had such a thing that
> > could be replaced).
> 
> Do we forbid that sb->buf[x] for some x < sb->len to be NUL, and if
> there is such a byte we stop running tolower() on the remainder?

Christian brought this up elsewhere, and I agree it's probably better to
work over the whole buffer, NULs included. I'm happy to re-roll (or you
can just pick up the version of the patch in this thread), but I think
the bigger question is: is this refactor worth doing, since there is
only one caller?

-Peff
