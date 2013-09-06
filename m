From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 0/5] Disable "git status" comment prefix
Date: Fri, 6 Sep 2013 17:55:10 -0400
Message-ID: <20130906215509.GA13319@sigill.intra.peff.net>
References: <1378374618-31439-1-git-send-email-Matthieu.Moy@imag.fr>
 <xmqqhadzhyjb.fsf@gitster.dls.corp.google.com>
 <vpqioyfukkw.fsf@anie.imag.fr>
 <20130905232322.GB29351@sigill.intra.peff.net>
 <20130906165330.GA6462@google.com>
 <vpq38phsvuc.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Sep 06 23:55:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI3zu-0007vp-Pu
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 23:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089Ab3IFVzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 17:55:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:58591 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946Ab3IFVzP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 17:55:15 -0400
Received: (qmail 9402 invoked by uid 102); 6 Sep 2013 21:55:15 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Sep 2013 16:55:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Sep 2013 17:55:10 -0400
Content-Disposition: inline
In-Reply-To: <vpq38phsvuc.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234103>

On Fri, Sep 06, 2013 at 07:28:43PM +0200, Matthieu Moy wrote:

> >> FWIW, I had the same thought as Junio. I much prefer something like
> >> status.displayCommentPrefix for clarity and future-proofing.
> >
> > Sounds fine, but I don't understand why we'd want this to be an option
> > with a future in the first place.  Why not just fix the remaining bugs
> > before merging to master and make it unconditional?
> 
> I think some old-time users may appreciate to have a
> backward-compatibility option. It doesn't cost much for us, as we need
> the variable internally (to use the prefix in COMMIT_EDITMSG, and not on
> stdout), and it actually makes it easier to test.

Exactly. I kind of prefer the old output, though it is probably just
having my brain rotted from seeing it so much. I'm going to give the new
behavior a try for a while to see if I adjust, but ultimately I'd like
to have the escape hatch. And as you say, it doesn't cost much, since we
have to keep both code paths anyway.

> I won't change the header part in this topic (no time, sorry), but the
> missing newline before "nothing added" actually sounds like a bug, as
> there is normally a newline after each list of file in `git status`,
> except untracked and ignored.
> 
> I'll fix it as a separate patch in the next round.

Thanks for looking into it.

-Peff
