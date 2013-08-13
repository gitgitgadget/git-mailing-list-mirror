From: Jeff King <peff@peff.net>
Subject: Re: git should not use a default user.email config value
Date: Tue, 13 Aug 2013 07:46:35 -0400
Message-ID: <20130813114635.GA16506@sigill.intra.peff.net>
References: <20130809223758.GB7160@sigill.intra.peff.net>
 <20130809231928.GY14690@google.com>
 <20130810064717.GB30185@sigill.intra.peff.net>
 <52060EF9.2040504@alum.mit.edu>
 <7vvc3d1o01.fsf@alter.siamese.dyndns.org>
 <CAH5451nHfOaBzFzkrGvw+TyRj==cVpKF_QdXsTxnn5tTr1c0dw@mail.gmail.com>
 <20130812123921.GA16088@sigill.intra.peff.net>
 <CAH5451=PK15n4U-3Mb_TLevF3-r+vrpk1PXD15Oo1A2KFc5i_w@mail.gmail.com>
 <20130812154520.GA18215@sigill.intra.peff.net>
 <CAH5451=WKXUNzovXquFii=EdkeQXJEQ96_CRRebgQW6ow_19VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 13 13:46:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9D3u-0000Yu-78
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 13:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757424Ab3HMLqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 07:46:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:55890 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757403Ab3HMLql (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 07:46:41 -0400
Received: (qmail 13158 invoked by uid 102); 13 Aug 2013 11:46:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Aug 2013 06:46:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Aug 2013 07:46:35 -0400
Content-Disposition: inline
In-Reply-To: <CAH5451=WKXUNzovXquFii=EdkeQXJEQ96_CRRebgQW6ow_19VA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232221>

On Tue, Aug 13, 2013 at 09:05:40PM +1000, Andrew Ardill wrote:

> I applied this on top of latest next (1da3ebde8999d07), and it worked
> perfectly for my use case.
> 
> For what it's worth, it also passed the test suite!
> 
> Would be great to see this, or something on the same theme, get into
> master. I'd be happy to review patches/write tests/write documentation
> if needed.

Like I said, I do not have a particular use for it, but I don't think it
would hurt anybody who does not use it. If you want to polish it up into
a real patch with docs and tests, I don't mind.

The only downside I can think of is that we might want to use the
subsection in "include.SUBSECTION.*" for some other limiting conditions
(e.g., "only include this config when running version >= X.Y", or even
"include only when environment variable FOO is true").

I guess we could do something like:

  [include "repo:...your regex here..."]
    path = .gitconfig-only-for-some-repos
  [include "env:USE_MY_MAGIC_CONFIG"]
    path = .gitconfig-only-when-magic-env-set

Adding the "repo:" prefix for this repo-dir matching is pretty trivial.
Adding a similar env-matching is only slightly less trivial; but does
anybody actually want it?

-Peff
