From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add two grep config options
Date: Mon, 28 Mar 2011 13:21:22 -0400
Message-ID: <20110328172122.GA20817@sigill.intra.peff.net>
References: <1301088071-918-1-git-send-email-jratt0@gmail.com>
 <7vlj024wal.fsf@alter.siamese.dyndns.org>
 <4D9037AA.9090601@drmicha.warpmail.net>
 <20110328115421.GA9232@sigill.intra.peff.net>
 <7vvcz3yxs8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Joe Ratterman <jratt0@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 19:21:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4G89-0005oq-M3
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 19:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786Ab1C1RVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 13:21:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56233
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752832Ab1C1RVY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 13:21:24 -0400
Received: (qmail 13818 invoked by uid 107); 28 Mar 2011 17:22:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Mar 2011 13:22:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Mar 2011 13:21:22 -0400
Content-Disposition: inline
In-Reply-To: <7vvcz3yxs8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170163>

On Mon, Mar 28, 2011 at 10:12:23AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > One shortcoming of such a scheme, though, is that it is an
> > all-or-nothing proposal...
> 
> I fully agree with this assessment, and I think that was the primary
> reason that we rejected --plumbing / GIT_PLUMB (i.e. as too naive to be
> useful).
> 
> > So what we really want is to let the script "allow" certain options from
> > the user's preferences. This could be done easily with individual config
> > options, like:
> >
> >   git --allow=grep.extended grep ...
> 
> I think this is probably the right thing to do _if_ we wanted to add such
> a configuration variable and give a way to let script writers protect
> themselves.

Note that "git --allow=grep.extended" is not useful without
GIT_PLUMBING=1. Otherwise, users at the command line would have to
individually allow each config option, which makes them pointless.

Probably you already figured that out, but I wasn't sure from what you
wrote.

> But would any user go all that trouble, just not to say "-nE" from the
> command line (or use an alias that was designed not to crash with
> scripts)?

I dunno. I generally prefer to use extended regexps when I can, but I
don't remember ever having been annoyed that they are not the default
with git grep. Perhaps because 99% of my greps are for literal symbol
names (whereas in my editor, I am often doing substitutions, and I am
continually annoyed at having to use backslash to make my parentheses
magical).

-Peff
