From: Jeff King <peff@peff.net>
Subject: Re: [PATCH RFC 0/2] Mixing English and a local language
Date: Thu, 13 Sep 2012 14:00:56 -0400
Message-ID: <20120913180056.GA1696@sigill.intra.peff.net>
References: <1345922816-20616-1-git-send-email-pclouds@gmail.com>
 <CACsJy8CG72PzvndV7C4a9hspxhprKn2tcb49HxeZ14pmEDycGQ@mail.gmail.com>
 <7vligfcdgh.fsf@alter.siamese.dyndns.org>
 <20120913132847.GD4287@sigill.intra.peff.net>
 <7v4nn1akz7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 20:01:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCDiw-0001xj-HM
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 20:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764Ab2IMSBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 14:01:00 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43650 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296Ab2IMSA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 14:00:59 -0400
Received: (qmail 5527 invoked by uid 107); 13 Sep 2012 18:01:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Sep 2012 14:01:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Sep 2012 14:00:56 -0400
Content-Disposition: inline
In-Reply-To: <7v4nn1akz7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205399>

On Thu, Sep 13, 2012 at 10:30:52AM -0700, Junio C Hamano wrote:

> >      But it should not be per-command, but per-message, and
> >      should include all output that is not diagnostic and is not
> >      machine-parseable (e.g., what I mentioned above, request-pull
> >      output, etc). If it is the project's language, then the team
> >      members will need to know it anyway, so it should not be too big a
> >      burden to have a potentially different language there than in the
> >      diagnostic messages.
> 
> No matter what the project languages is, machine parseable part will
> not be localized but fixed to "C" anyway, so I do not think it comes
> into the picture.

But there are parts that are neither machine-parseable nor diagnostics.
The diffstat is one, but I mentioned others. Are those going to be
forever fixed to LANG=C?

That does not bother me, but for a project whose team works entirely in
Japanese (both individually, and when sharing code), they will still be
stuck with these English-language snippets, and no way to localize them.
Even though they may not speak a word of it.

I have no idea if such a team is a strawman or not; that is why I
separated points 1 and 2. We can wait on point 2 until such a team shows
up and complains (of course, they would have to come here and complain
in English, so...).

> My take on this is, if there is the project language, it should
> apply to _everything_.  Please do not introduce any per-command,
> per-message, per-anything mess.  Just set LANG/LC_ALL up and be done
> with it.

But isn't that arguing for localizing diffstat? It is not
machine-parseable, so an all-Japanese team would want to localize it
along with their diagnostics.

-Peff
