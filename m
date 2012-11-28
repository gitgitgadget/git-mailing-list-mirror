From: Jeff King <peff@peff.net>
Subject: [PATCH 0/5] jk/send-email-sender-prompt loose ends
Date: Wed, 28 Nov 2012 13:25:35 -0500
Message-ID: <20121128182534.GA21020@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 19:26:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdmKX-0001sK-Fl
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 19:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476Ab2K1SZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 13:25:37 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33878 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754957Ab2K1SZh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 13:25:37 -0500
Received: (qmail 9724 invoked by uid 107); 28 Nov 2012 18:26:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Nov 2012 13:26:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2012 13:25:35 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210749>

Here are the cleanups and refactorings split out from my
jk/send-email-sender-prompt series. They can go right on master and are
independent of Felipe's fc/send-email-no-sender-prompt topic.

  [1/5]: test-lib: allow negation of prerequisites

Same as before. I think this is a useful feature for the test suite (and
2/5 depends on it).

  [2/5]: t7502: factor out autoident prerequisite

Same as before. Patch 5/5 depends on it.

  [3/5]: ident: make user_ident_explicitly_given static

Same as before. Cleanup.

  [4/5]: ident: keep separate "explicit" flags for author and committer

Same as before. Cleanup. I do not know if anybody will ever care about
the corner cases it fixes, so it is really just being defensive for
future code.

  [5/5]: t: add tests for "git var"

Tests split out from he "git var can take multiple values" patch.

Dropped were:

  - "git var" can take multiple values. Nobody really cares about doing
    so, and it's an external interface, so we'd have to support it
    forever.

  - exporting "explicit ident" flag via "git var"; same reasoning as
    above

  - Git.pm supporting explicit ident; ditto

  - send-email prompting change; obsoleted by Felipe's patch

-Peff
