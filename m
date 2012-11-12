From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Update cygwin.c for new mingw-64 win32 api headers
Date: Mon, 12 Nov 2012 16:43:52 -0500
Message-ID: <20121112214352.GB10531@sigill.intra.peff.net>
References: <1352679440-4098-1-git-send-email-mlevedahl@gmail.com>
 <20121112205832.GI4623@sigill.intra.peff.net>
 <CAK2bgnXLnKmnVwzE5U_1qZueUdj-QaT23f-iFmhJyRto3tWnhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 22:44:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY1ne-0005pP-4T
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 22:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003Ab2KLVn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 16:43:56 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45081 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523Ab2KLVn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 16:43:56 -0500
Received: (qmail 14528 invoked by uid 107); 12 Nov 2012 21:44:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Nov 2012 16:44:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2012 16:43:52 -0500
Content-Disposition: inline
In-Reply-To: <CAK2bgnXLnKmnVwzE5U_1qZueUdj-QaT23f-iFmhJyRto3tWnhA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209531>

On Mon, Nov 12, 2012 at 04:39:39PM -0500, Mark Levedahl wrote:

> >> diff --git a/Makefile b/Makefile
> >> index f69979e..1cc5d96 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -1082,6 +1082,7 @@ ifeq ($(uname_O),Cygwin)
> >>               NO_SYMLINK_HEAD = YesPlease
> >>               NO_IPV6 = YesPlease
> >>               OLD_ICONV = UnfortunatelyYes
> >> +             V15_MINGW_HEADERS = YesPlease
> >>       endif
> >
> > The "if" part of the conditional that did not make it into the context
> > above is an expr match for "1.6.*" From the name, I would think that we
> > would want to use these headers on cygwin 1.5.* , too. Is v1.5 too old
> > to care about now?
> 
> The opening if expression is:
>     ifeq ($(shell expr "$(uname_R)" : '1\.[1-6]\.'),4)
> which I believe matches any version below 1.7. 1.5 is what is released
> opensource, 1.6 is (or was) available as a supported product from
> redhat. So, I think the stanza is ok as is.

Oh, right, I'm an idiot. I read the patch, thought "gee, I wonder what
that conditional just outside the context is", looked it up, then
promptly misremembered exactly what it said when writing the rest of my
email.

Yes, what you have is absolutely right. Sorry for the noise.

-Peff
