From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] t5510: do not leave changed cwd
Date: Fri, 4 Mar 2016 06:52:55 -0500
Message-ID: <20160304115255.GB8355@sigill.intra.peff.net>
References: <cover.1457088499.git.git@drmicha.warpmail.net>
 <f6499302a5dfb52bf6c9430581103da9569434a3.1457088499.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 04 12:53:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aboI5-0006vs-PB
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 12:53:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbcCDLw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 06:52:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:54678 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751112AbcCDLw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 06:52:58 -0500
Received: (qmail 30842 invoked by uid 102); 4 Mar 2016 11:52:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Mar 2016 06:52:57 -0500
Received: (qmail 14575 invoked by uid 107); 4 Mar 2016 11:53:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Mar 2016 06:53:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Mar 2016 06:52:55 -0500
Content-Disposition: inline
In-Reply-To: <f6499302a5dfb52bf6c9430581103da9569434a3.1457088499.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288249>

On Fri, Mar 04, 2016 at 11:53:50AM +0100, Michael J Gruber wrote:

> t5510 carefully keeps the cwd at the test root by using either subshells
> or explicit cd'ing back to the root. Use a subshell for the last
> subtest, too.

I doubt this caused the heisenbug you saw, as we should have an absolute
path for the trash-dir, and we "cd" to its containing directory before
deleting it. But this is definitely a good thing to be doing anyway, to
prevent surprises for new tests added to t5510.

-Peff
