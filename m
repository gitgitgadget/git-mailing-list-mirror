From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 0/2] test_terminal: check that TTY prerequisite is
 declared
Date: Fri, 15 Oct 2010 00:42:53 -0400
Message-ID: <20101015044252.GA22438@sigill.intra.peff.net>
References: <20101014030220.GB20685@sigill.intra.peff.net>
 <20101014030505.GC5626@sigill.intra.peff.net>
 <20101014031642.GB14664@burratino>
 <20101014033448.GB28197@sigill.intra.peff.net>
 <20101014203721.GA28958@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 06:42:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6c86-0000JU-1G
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 06:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003Ab0JOEme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 00:42:34 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:44907 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882Ab0JOEme (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 00:42:34 -0400
Received: (qmail 14488 invoked by uid 111); 15 Oct 2010 04:42:29 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 15 Oct 2010 04:42:29 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Oct 2010 00:42:53 -0400
Content-Disposition: inline
In-Reply-To: <20101014203721.GA28958@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159089>

On Thu, Oct 14, 2010 at 03:37:21PM -0500, Jonathan Nieder wrote:

> > Oops, good catch. I think we should already catch it, as test_terminal
> > will not be defined at all in the no-tty case. We could print a nicer
> > message, but
> 
> I rather meant something like this.
> 
> Patch 1 exposes the internal $prereq variable from
> test_expect_(success|failure).  Maybe it should be called
> GIT_TEST_something to avoid trampling other programs' namespaces?  Not
> sure.
> 
> Patch 2 introduces some magic autodetection so people that never run
> tests without -v can still notice the missing TTY prereqs.

Yeah, that is better, as it will catch the lack of prerequisite even on
systems where the prerequisite is met.

It seems like a lot of code to catch something small, but on the other
hand, it does seem to be a repeated mistake.

-Peff
