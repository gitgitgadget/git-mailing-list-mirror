From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] cosmetic improvements for "git show tag"
Date: Fri, 17 Jul 2009 19:16:22 -0400
Message-ID: <20090717231622.GA13511@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 18 01:16:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRwfM-0003l8-Kt
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 01:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201AbZGQXQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 19:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753993AbZGQXQ2
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 19:16:28 -0400
Received: from peff.net ([208.65.91.99]:39280 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753014AbZGQXQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 19:16:27 -0400
Received: (qmail 29647 invoked by uid 107); 17 Jul 2009 23:18:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 17 Jul 2009 19:18:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jul 2009 19:16:22 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123495>

Right now, if you do:

  $ git tag -m 'annotated tag message' foo
  $ git show foo

you get:

    tag foo
    Tagger: Jeff King <peff@peff.net>
    Date:   Fri Jul 17 19:10:54 2009 -0400


    annotated tag message
    commit 88c17f18d7f3091508218b36a17cdf0dfd56ae65
    Author: Jeff King <peff@peff.net>
    Date:   Fri Jul 17 19:10:50 2009 -0400

        commit message

    diff ...

which is IMHO quite hard to read. These two one-liner patches improve
the output to:

    tag foo
    Tagger: Jeff King <peff@peff.net>
    Date:   Fri Jul 17 19:10:54 2009 -0400

    annotated tag message

    commit 88c17f18d7f3091508218b36a17cdf0dfd56ae65
    Author: Jeff King <peff@peff.net>
    Date:   Fri Jul 17 19:10:50 2009 -0400

        commit message

    diff ...

which I find much more readable. The changes are localized to "git
show", and since it is porcelain, I don't think there should be any
negative fallout by changing the output.

---
Jeff King (2):
  show: suppress extra newline when showing annotated tag
  show: add space between tag body and tagged object

 builtin-log.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)
