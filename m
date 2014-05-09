From: Jeff King <peff@peff.net>
Subject: Re: t5539 fails on ubuntu for v2.0.0-rc2 - the SAME on 12.04 server
 - this test was disabled up to 1.9.2
Date: Fri, 9 May 2014 11:50:41 -0400
Message-ID: <20140509155041.GF18197@sigill.intra.peff.net>
References: <536A8FF8.7080909@fabiodalfonso.com>
 <536BF8C7.6010208@fabiodalfonso.com>
 <536C9444.8060408@fabiodalfonso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Fabio D'Alfonso <fabio.dalfonso@fabiodalfonso.com>
X-From: git-owner@vger.kernel.org Fri May 09 17:50:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Win4R-0005AH-IK
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 17:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156AbaEIPun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 11:50:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:48325 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754033AbaEIPun (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 11:50:43 -0400
Received: (qmail 27954 invoked by uid 102); 9 May 2014 15:50:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 May 2014 10:50:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 May 2014 11:50:41 -0400
Content-Disposition: inline
In-Reply-To: <536C9444.8060408@fabiodalfonso.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248576>

On Fri, May 09, 2014 at 10:39:32AM +0200, Fabio D'Alfonso wrote:

> this test was disabled up to 1.9.2 so it did not fail as it did not run by
> default.

Yes, in v1.9.2 we turned on http tests to run by default, but only if we
could succeed in setting up the http server automatically (and if we
can't, we skip the tests). Unfortunately your case seems to set up the
http server fine, but then it dies. It's odd that it's only on this one
test, though.

You can manually disable them by setting GIT_TEST_HTTPD=false in your
config.mak file. If this sort of spurious failure is common, we may have
to consider switching the default back to "false" from "auto".

> It seems that no one is interested to this issue. Probably I misunderstood
> the purpose of the list.

This is the right place. But your problem is confusing and hard, so it
may take time for people to look into it and respond. :)

-Peff
