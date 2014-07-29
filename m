From: Jeff King <peff@peff.net>
Subject: [PATCH v2 0/6] improving "git stash list -p"
Date: Tue, 29 Jul 2014 13:53:00 -0400
Message-ID: <20140729175300.GA21536@peff.net>
References: <20140729115334.GA8976@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 19:53:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCBaI-0007gB-Sv
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 19:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbaG2RxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 13:53:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:42604 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750708AbaG2RxF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 13:53:05 -0400
Received: (qmail 2136 invoked by uid 102); 29 Jul 2014 17:53:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jul 2014 12:53:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jul 2014 13:53:00 -0400
Content-Disposition: inline
In-Reply-To: <20140729115334.GA8976@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254451>

I spent a few more minutes cleaning up the rough edges here, and this is
what I ended up with. This version uses run_diff to implement the actual
single-parent diff, so that it matches a "real" diff exactly. It also
introduces a few new patches to let you really specify an empty --pretty
user-format.

I do think this is an improvement over the current state. I'd also be OK
with just specifying "--first-parent" to "git stash list" by default, so
that "git stash list -p" does something sensible. I don't like that it
doesn't let you peek at the index, but nobody has complained about that
in "git stash show", so perhaps nobody cares.  All things being equal, I
prefer this solution, though.

  [1/6]: revision: drop useless string offset when parsing "--pretty"
  [2/6]: pretty: treat "--format=" as an empty userformat
  [3/6]: pretty: make empty userformats truly empty
  [4/6]: add --simplify-combined-diff option
  [5/6]: stash: default listing to "--cc --simplify-combined-diff"
  [6/6]: stash: show combined diff with "stash show"

-Peff
