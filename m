From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add -i: ignore terminal escape sequences
Date: Wed, 18 May 2011 01:54:11 -0400
Message-ID: <20110518055411.GA27482@sigill.intra.peff.net>
References: <05ce7ccdb3f4e07724d430f6ea2a8c9730971c9d.1305645331.git.trast@student.ethz.ch>
 <7vipt8fyxj.fsf@alter.siamese.dyndns.org>
 <BANLkTinSKFVP=VYw4PoLP=-AUbLKeGX+gQ@mail.gmail.com>
 <7vei3weh2w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, trast@student.ethz.ch,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 18 07:54:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMZi7-0005KA-DK
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 07:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716Ab1ERFyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 01:54:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56535
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713Ab1ERFyO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 01:54:14 -0400
Received: (qmail 2086 invoked by uid 107); 18 May 2011 05:56:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 May 2011 01:56:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2011 01:54:11 -0400
Content-Disposition: inline
In-Reply-To: <7vei3weh2w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173848>

On Tue, May 17, 2011 at 10:03:03PM -0700, Junio C Hamano wrote:

> I think "add -p" used to have an internal mechanism to merge the adjacent
> split hunks back to a single hunk, so if we wanted to we could have given
> users a way to recover from a mistaken "s"plit, but I don't think we kept
> that code, so there is no way to properly "recover" from such a mistake.
> 
> Yes, it may be just the matter of two easy keystrokes, either yy or nn, to
> recover from such a mistake, and that is why I said "possibly". It is
> nevertheless destructive in the sense that you cannot recover without
> quitting the current session and restarting.
> 
> Of course Thomas could have simply done "reset" and started from scratch,
> so in that sense nothing is destructive, but we are not talking about the
> kind of destructive operations you cannot possibly recover without typing
> everything again.

I'm not that concerned about these type of destructive operations, which
might waste a few seconds or a minute of your time. But Thomas' original
email indicated he was using "git checkout -p", which _is_ destructive
in a much bigger way, because a "y" overwrites worktree files which do
not otherwise have a backup (even "reset -p" leaves unreferenced blobs
that used to be in the index).

-Peff
