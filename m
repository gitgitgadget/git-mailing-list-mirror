From: Jeff King <peff@peff.net>
Subject: [PATCHv2 0/9] echo characters in username prompt
Date: Sat, 10 Dec 2011 05:39:44 -0500
Message-ID: <20111210103943.GA16478@sigill.intra.peff.net>
References: <20111210102827.GA16460@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 11:39:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZKLO-0008Kn-Sj
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 11:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391Ab1LJKjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 05:39:46 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47042
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752588Ab1LJKjq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 05:39:46 -0500
Received: (qmail 14255 invoked by uid 107); 10 Dec 2011 10:46:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Dec 2011 05:46:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Dec 2011 05:39:44 -0500
Content-Disposition: inline
In-Reply-To: <20111210102827.GA16460@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186747>

On Sat, Dec 10, 2011 at 05:28:27AM -0500, Jeff King wrote:

> Here's the latest re-roll of the credential helpers series. I think this
> one is probably ready to go to 'next'.

And here's the prompt/terminal refactoring to go on top of it. This
isn't as well reviewed as the main credential series, but I think it's
reasonably solid.

Since the last round, I fixed the bone-head NO_DEV_TTY/HAVE_DEV_TTY
mixup that Jakub pointed out. And I split the "Linux has /dev/tty" patch
out so I could test to make sure it isn't accidentally turned on until
we actually enable it.

I also tested it on OS X, and it works fine there.

  [1/9]: imap-send: avoid buffer overflow
  [2/9]: imap-send: don't check return value of git_getpass
  [3/9]: move git_getpass to its own source file
  [4/9]: refactor git_getpass into generic prompt function
  [5/9]: add generic terminal prompt function
  [6/9]: prompt: use git_terminal_prompt
  [7/9]: credential: use git_prompt instead of git_getpass
  [8/9]: Makefile: linux has /dev/tty
  [9/9]: Makefile: OS X has /dev/tty

-Peff
