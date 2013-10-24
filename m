From: Jeff King <peff@peff.net>
Subject: [PATCH 0/6] fix some parse_commit segfaults
Date: Thu, 24 Oct 2013 04:52:14 -0400
Message-ID: <20131024085213.GA1267@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 24 10:52:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZGeT-0004dN-5O
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 10:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754003Ab3JXIwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 04:52:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:54648 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753519Ab3JXIwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 04:52:16 -0400
Received: (qmail 7346 invoked by uid 102); 24 Oct 2013 08:52:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Oct 2013 03:52:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Oct 2013 04:52:14 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236575>

This is a repost of the series here:

  http://thread.gmane.org/gmane.comp.version-control.git/235735/focus=235826

(the original was a single patch, followed by a 5-patch series, which
I've combined here). It's mostly a cleanup, since parse_commit will only
fail in corrupted repos, but I did run into it in a real (corrupted)
repo.

  [1/6]: log_tree_diff: die when we fail to parse a commit
  [2/6]: assume parse_commit checks commit->object.parsed
  [3/6]: assume parse_commit checks for NULL commit
  [4/6]: use parse_commit_or_die instead of segfaulting
  [5/6]: use parse_commit_or_die instead of custom message
  [6/6]: checkout: do not die when leaving broken detached HEAD

-Peff
