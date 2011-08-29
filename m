From: Jeff King <peff@peff.net>
Subject: Re: Idea: "git format-patch" should get more information out of git
Date: Mon, 29 Aug 2011 14:55:46 -0400
Message-ID: <20110829185546.GD756@sigill.intra.peff.net>
References: <4E587CC0.4090508@alum.mit.edu>
 <7vippiaduw.fsf@alter.siamese.dyndns.org>
 <7v1uw69h96.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 20:55:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy6zy-0007bg-RE
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 20:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797Ab1H2Szt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 14:55:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53486
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753945Ab1H2Szs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 14:55:48 -0400
Received: (qmail 19329 invoked by uid 107); 29 Aug 2011 18:56:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Aug 2011 14:56:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Aug 2011 14:55:46 -0400
Content-Disposition: inline
In-Reply-To: <7v1uw69h96.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180329>

On Sat, Aug 27, 2011 at 11:34:13PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Michael Haggerty <mhagger@alum.mit.edu> writes:
> >
> >> 4. There is no place to store the "additional information" (the part
> >> that comes in patch emails between the "---" and the diffstat) while
> >> working on the patch series;...
> >
> > I thought there was a RFC floating around to do this using notes and also
> > teach it to "commit -e" a few months ago? I vaguelly recall that Peff and
> > one of the J's were involved, so I am CC'ing them.
> 
> Also, when I prepare a commit to be sent with an additional piece of
> information, I often write "---" and the additional message after my
> S-o-b: line while preparing the commit log message. Unlike format-patch
> that strips that off, commit keeps it, which is handy.

After playing around a bit with my earlier series, I made the
realization (perhaps obvious to others :) ), that if you are in a
pure-patch workflow, keeping the "---" in your commit message locally is
much simpler. It follows the commit around through rebases
automatically, it gets put into format-patch output automatically, and
so forth.

The only real downside is that you can never tell git "don't show me the
cover letter cruft". Which is probably OK for your own local patches.
But the point of the "---" is that information should never make it into
a repo, which means in any workflow that involves pulling actual git
commits, it won't work (after reading Michael's response in another
thread, though, I think he would be interested in a hybrid
pull-or-apply-via-mail system).

-Peff
