From: Jeff King <peff@peff.net>
Subject: [PATCHv2 0/7] getpass refactoring
Date: Thu, 8 Dec 2011 03:21:19 -0500
Message-ID: <20111208082118.GA1507@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 09:21:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYZEM-00066n-Jo
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 09:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983Ab1LHIVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 03:21:22 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43088
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716Ab1LHIVV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 03:21:21 -0500
Received: (qmail 25528 invoked by uid 107); 8 Dec 2011 08:27:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Dec 2011 03:27:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Dec 2011 03:21:19 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186536>

This is a re-roll of the earlier "echo usernames as they are typed"
series here:

  http://article.gmane.org/gmane.comp.version-control.git/185970

It turns out that getpass() isn't even really good at getting passwords.
See patch 5/7 for details. This series replaces it entirely if you set
HAVE_DEV_TTY (otherwise, we continue to fallback to getpass()).

  [1/7]: imap-send: avoid buffer overflow
  [2/7]: imap-send: don't check return value of git_getpass
  [3/7]: move git_getpass to its own source file
  [4/7]: refactor git_getpass into generic prompt function
  [5/7]: add generic terminal prompt function
  [6/7]: prompt: use git_terminal_prompt
  [7/7]: credential: use git_prompt instead of git_getpass

It should be applied on top of the jk/credentials topic.

-Peff
