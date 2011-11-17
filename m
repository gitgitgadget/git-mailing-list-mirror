From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/8] Enable GIT_DEBUG_MEMCHECK on git_pathname()
Date: Thu, 17 Nov 2011 08:42:01 -0500
Message-ID: <20111117134201.GA30718@sigill.intra.peff.net>
References: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
 <1321522335-24193-9-git-send-email-pclouds@gmail.com>
 <CALkWK0ndE1Q_jNSV7CBB5W2NyVhcy7kgNO5woWWOw6CXx3cxcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 14:42:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RR2EG-0005ve-DC
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 14:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757551Ab1KQNmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 08:42:06 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43447
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757357Ab1KQNmF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 08:42:05 -0500
Received: (qmail 22689 invoked by uid 107); 17 Nov 2011 13:42:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 17 Nov 2011 08:42:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Nov 2011 08:42:01 -0500
Content-Disposition: inline
In-Reply-To: <CALkWK0ndE1Q_jNSV7CBB5W2NyVhcy7kgNO5woWWOw6CXx3cxcA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185597>

On Thu, Nov 17, 2011 at 04:05:52PM +0530, Ramkumar Ramachandra wrote:

> The macros __FILE__, __LINE__ and __VA_ARGS__ are gcc-specific
> extensions, no?  I was curious to see if some other parts of Git are
> using this: a quick grep returns mailmap.c and notes-merge.c.  They
> both use __VA_ARGS__ it for debugging purposes.  So, nothing new.

All three are in C99. I'm pretty sure __FILE__ and __LINE__ were
available in C89, but I only have a copy of C99 handy these days.
Variable-argument macros were definitely introduced in C99 (and were a
gcc extension for a while before then).

> What happens if GIT_DEBUG_MEMCHECK is set, but I'm not using gcc?
> Also, it's probably worth mentioning in the commit message that this
> debugging trick is gcc-specific.

Older compilers will probably barf on the variable-argument macros.

-Peff
