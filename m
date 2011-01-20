From: Jeff King <peff@peff.net>
Subject: Re: Parameter --color-words not documented for "git show"
Date: Thu, 20 Jan 2011 18:34:29 -0500
Message-ID: <20110120233429.GB9442@sigill.intra.peff.net>
References: <4D3893EA.5090907@hartwork.org>
 <201101202127.39962.trast@student.ethz.ch>
 <4D389E69.608@hartwork.org>
 <7vk4hzqnbx.fsf@alter.siamese.dyndns.org>
 <20110120231649.GC14184@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Git ML <git@vger.kernel.org>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Fri Jan 21 00:34:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg41V-0002fe-C9
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 00:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755935Ab1ATXee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 18:34:34 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38051 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755932Ab1ATXed (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 18:34:33 -0500
Received: (qmail 14903 invoked by uid 111); 20 Jan 2011 23:34:31 -0000
Received: from 99-189-169-83.lightspeed.snjsca.sbcglobal.net (HELO sigill.intra.peff.net) (99.189.169.83)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 20 Jan 2011 23:34:31 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jan 2011 18:34:29 -0500
Content-Disposition: inline
In-Reply-To: <20110120231649.GC14184@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165345>

On Fri, Jan 21, 2011 at 12:16:49AM +0100, Nicolas Sebrecht wrote:

> The 20/01/11, Junio C Hamano wrote:
> > Sebastian Pipping <webmaster@hartwork.org> writes:
> > 
> > > On 01/20/11 21:27, Thomas Rast wrote:
> > >> Quote from the latter:
> > >> 
> > >>        This manual page describes only the most frequently used options.
> > >
> > > Okay.  Is that a good a idea?
> > 
> > Yes; the alternative is to list everything.
> 
> Would it be bad? I tend to think that a manual page is the good place to
> list everything the program accepts as parameters and how to use them.
> FMHO, Manual page is not where newcomers look to learn but it should
> help everybody to find and understand all of the available options.

The problem is that we have a bazillion diff options that appear in many
manpages, so you are stuck with one of:

  1. repeat them all in each manpage (usually via some automagic
     include), which dwarfs the original content, and makes it hard for
     users to see subtle differences between commands

  2. Say "this describes only the most frequently used options", which
     leaves the user wondering which infrequently used options exist.

  3. Say "we also take diff options, and you can find out more about
     diff options in git-diff(1)." This at least points the user in the
     right direction, but you can't search for "--color-words" in the
     page.

  4. Do (3), but also list the all (or common) diff options in a succint
     list without descriptions, and refer the user to git-diff(1). Then
     they can grep if they like, and while they won't get the immediate
     answer, they will get referred to the right place.

As you can probably guess, I favor option (4), though we already do (3)
in some places.

-Peff
