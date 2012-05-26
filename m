From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] clone --local fixes
Date: Fri, 25 May 2012 23:42:26 -0400
Message-ID: <20120526034226.GA14287@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Emeric Fermas <emeric.fermas@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 05:42:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY7ti-0007lq-Jm
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 05:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337Ab2EZDma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 23:42:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56339
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754459Ab2EZDm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 23:42:29 -0400
Received: (qmail 16039 invoked by uid 107); 26 May 2012 03:42:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 May 2012 23:42:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 May 2012 23:42:26 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198535>

Emeric mentioned that he was confused by the behavior of

  git clone --local file:///path/to/repo

in that the --local is silently ignored. Looking over the documentation,
it is quite unclear whether it is supposed to do anything or not. I
don't think it's an especially pressing use case, so one solution could
be to simply clarify the current behavior in the documentation.

However, I figured this should just be a two-line fix to give it more
sensible behavior, so why not just make it to do the sensible thing? And
while my initial version was two lines, it ended up growing to handle
all of the corner cases properly.  So I'm not super-excited about patch
2, but given that it is written, I think it's a reasonable thing to do
(and it is not _too_ complex).

And then while I was on the subject, I did patch 3, which is something
that has bugged me for a long time.

  [1/3]: t5701: modernize style
  [2/3]: clone: make --local handle URLs
  [3/3]: clone: allow --no-local to turn off local optimizations

-Peff
