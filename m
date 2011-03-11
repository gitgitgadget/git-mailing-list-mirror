From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] commit, status: #comment diff output in verbose mode
Date: Thu, 10 Mar 2011 20:23:18 -0500
Message-ID: <20110311012318.GB15377@sigill.intra.peff.net>
References: <1299787140-21472-1-git-send-email-icomfort@stanford.edu>
 <20110310225233.GH15828@sigill.intra.peff.net>
 <7vvczq1o4l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ian Ward Comfort <icomfort@stanford.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 02:23:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxr4c-0002jB-Uh
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 02:23:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754960Ab1CKBXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 20:23:19 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48988
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754207Ab1CKBXS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 20:23:18 -0500
Received: (qmail 1288 invoked by uid 107); 11 Mar 2011 01:23:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Mar 2011 20:23:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Mar 2011 20:23:18 -0500
Content-Disposition: inline
In-Reply-To: <7vvczq1o4l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168876>

On Thu, Mar 10, 2011 at 04:45:14PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > One reason to keep the existing behavior is that editors will tend to
> > syntax-highlight the diff portion without much extra effort (in vim, at
> > least, the syntax highlighting just includes the diff syntax
> > highlighting for that section).
> 
> Hmm, thanks for pointing it out; it indeed is a valid concern.
> 
> Although I usually strongly resist changes in order to keep the user
> experience stable, I didn't think about this one, as I don't let the
> editor syntax highlight anything.

I like the proposal for:

  # Lines below this one will be removed.
  diff --git ...

which seems to have the best of both worlds, robust and easy for editors
to recognize as a diff. For that matter, we could also do "# Lines below
this one..." for _all_ of the git-status template, but I don't think
it's necessary. Those lines are already clearly marked with a delimiter,
and I don't think anybody is complaining about them (and the "Lines
below this one..." line adds just one more line of cruft).

-Peff
