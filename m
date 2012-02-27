From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fsck: do not print dangling objects by default
Date: Mon, 27 Feb 2012 14:18:46 -0500
Message-ID: <20120227191846.GB1600@sigill.intra.peff.net>
References: <20120226204357.GA26088@ecki>
 <7vty2ddzqj.fsf@alter.siamese.dyndns.org>
 <7vhayddxgp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 20:18:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2661-00038V-8q
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 20:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425Ab2B0TSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 14:18:48 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58933
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754224Ab2B0TSs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 14:18:48 -0500
Received: (qmail 29542 invoked by uid 107); 27 Feb 2012 19:18:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 Feb 2012 14:18:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Feb 2012 14:18:46 -0500
Content-Disposition: inline
In-Reply-To: <7vhayddxgp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191654>

On Sun, Feb 26, 2012 at 02:46:46PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I think that both the ultimate goal explained above, and the direction in
> > which the documentation updates tries to move us, are good.  I only gave a
> > cursory look at the code changes, but what they implement seems to match
> > the intention.
> >
> > Of course I may be missing something, so objections from others to argue
> > why we shouldn't do this is very much welcomed to stop me and Clemens ;-).
> 
> Let's start with the obvious.
> 
> It is much easier for a user to use a new option on the command line when
> he wants to use an improved behaviour when he runs the command manually.
> Having to update scripts that run the command to act on its output, on the
> other hand, is much more painful to the users.
> 
> And the intended audience for this change clearly is interactive users
> that follow the user-manual to try things out.
> 
> Given that, isn't it not just sufficient but actually better to instead
> add a new --no-dangling option and keep the default unchanged?

But if your intended audience is users who are confused by the dangling
warnings, explaining to them to use --no-dangling is not really
improving the situation. Of course, it is fsck, so I wonder how often
clueless people are really running it in the first place (i.e., it is
not and should not be part of most users' typical workflows). If it is
simply the case that they are being told to run "git fsck" by more
expert users without understanding what it does, then I could buy the
argument that those expert users could just as easily say "git fsck
--no-dangling".

-Peff
