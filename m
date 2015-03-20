From: Jeff King <peff@peff.net>
Subject: [PATCH v2 0/5] not making corruption worse
Date: Fri, 20 Mar 2015 14:42:16 -0400
Message-ID: <20150320184215.GA26368@peff.net>
References: <20150317072750.GA22155@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 19:50:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ1zc-0007zk-NF
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 19:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbbCTSnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 14:43:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:36027 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751154AbbCTSmU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 14:42:20 -0400
Received: (qmail 28971 invoked by uid 102); 20 Mar 2015 18:42:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 13:42:19 -0500
Received: (qmail 26912 invoked by uid 107); 20 Mar 2015 18:42:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 14:42:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 14:42:16 -0400
Content-Disposition: inline
In-Reply-To: <20150317072750.GA22155@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265937>

This is a re-roll of the series to make "git prune" in a corrupted
repository safer.

There are only minor tweaks from v1, but I think all of the raised
issues were addressed (there was discussion on some other points, but I
think they are OK as-is; more discussion is of course welcome).

The changes from v1 are:

  - use "bogus..name" as a bad refname instead of "bogus:name", as the
    latter has problems on Windows

  - fix broken &&-chains in tests

  - better commenting of missing-commit setup in t5312

  - typo-fixes in commit messages

Patches:

  [1/5]: t5312: test object deletion code paths in a corrupted repository
  [2/5]: refs: introduce a "ref paranoia" flag
  [3/5]: prune: turn on ref_paranoia flag
  [4/5]: repack: turn on "ref paranoia" when doing a destructive repack
  [5/5]: refs.c: drop curate_packed_refs

-Peff
