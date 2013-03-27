From: Jeff King <peff@peff.net>
Subject: Re: git status takes 30 seconds on Windows 7. Why?
Date: Wed, 27 Mar 2013 15:04:25 -0400
Message-ID: <20130327190425.GA26380@sigill.intra.peff.net>
References: <CAFT1WNyyXbCOQWMt8nYife7Tix_mJzDQrj5e+N=GKbDR8OyYzQ@mail.gmail.com>
 <vpqr4j0rccf.fsf@grenoble-inp.fr>
 <CAFT1WNxm0Kx9vHx+NB92_tZV6KsVhefiVXa-K69YbWOkpCXSgA@mail.gmail.com>
 <20130327184657.GP2286@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jim Kinsman <jakinsman@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Mar 27 20:05:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKved-0004hq-O9
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 20:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814Ab3C0TEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 15:04:31 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41788 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628Ab3C0TEb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 15:04:31 -0400
Received: (qmail 17073 invoked by uid 107); 27 Mar 2013 19:06:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Mar 2013 15:06:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Mar 2013 15:04:25 -0400
Content-Disposition: inline
In-Reply-To: <20130327184657.GP2286@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219306>

On Wed, Mar 27, 2013 at 06:46:57PM +0000, John Keeping wrote:

> I think the simple reality is that Git was written with the assumption
> that stat is cheap and that isn't really the case on Windows, where the
> filesystem cache doesn't seem to do that well with this.

Yes, I think that's pretty much the case (though most of my
Git-on-Windows experience is from cygwin long ago, where the stat
performance was truly horrendous). Have you tried setting
core.preloadindex, which should run the stats in parallel?

-Peff
