From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Hiding some refs in ls-remote
Date: Mon, 21 Jan 2013 18:45:49 -0500
Message-ID: <20130121234549.GF17156@sigill.intra.peff.net>
References: <1358555826-11883-1-git-send-email-gitster@pobox.com>
 <20130119165042.GB12307@sigill.intra.peff.net>
 <7vpq0zn2za.fsf@alter.siamese.dyndns.org>
 <7vip6rjyn3.fsf@alter.siamese.dyndns.org>
 <20130121230108.GB17156@sigill.intra.peff.net>
 <7v38xuf6w5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, spearce@spearce.org, mfick@codeaurora.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 00:46:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxR4H-0002Wu-JH
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 00:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756224Ab3AUXpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 18:45:53 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41845 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752532Ab3AUXpv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 18:45:51 -0500
Received: (qmail 20843 invoked by uid 107); 21 Jan 2013 23:47:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 Jan 2013 18:47:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Jan 2013 18:45:49 -0500
Content-Disposition: inline
In-Reply-To: <7v38xuf6w5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214178>

On Mon, Jan 21, 2013 at 03:33:46PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> It may even make sense to have "git push" honor it, excluding them
> >> from "git push --mirror" (or "git push --all" if some of the
> >> branches are hidden); I haven't thought things through, though.
> >
> > That is harder, as that is something that happens on the client. How
> > does the client learn about the transfer.hiderefs setting on the remote?
> 
> No, I was talking about running "git push" from a repository that
> has the transfer.hiderefs set, emulating a fetch from a client by
> pushing out in the reverse direction.

Ah. That seems a bit more questionable to me, as you are assuming that
the face that the repository shows to network clients is the same as it
would show when it is the client itself. That wouldn't be true, for
example, when pushing to a backup repository which would expect to get
everything.

Of course the same problem comes from a backup repository which wants to
fetch from you. Which again comes down to the fact that I think this
ref-hiding is really in the eye of the receiver, not the sender.

-Peff
