From: Jeff King <peff@peff.net>
Subject: [PATCH 0/4] git replace --edit --raw
Date: Tue, 24 Jun 2014 05:42:25 -0400
Message-ID: <20140624094217.GA14216@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 11:42:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzNFS-0006XM-6S
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 11:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbaFXJmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 05:42:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:50129 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751206AbaFXJmh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 05:42:37 -0400
Received: (qmail 16199 invoked by uid 102); 24 Jun 2014 09:42:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Jun 2014 04:42:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jun 2014 05:42:25 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252390>

I tried to use "git replace --edit" today to repair a corrupted tree
that had an empty filename:

  $ git replace --edit HEAD^{tree}
  fatal: empty filename in tree entry
  fatal: cat-file reported failure

Oops. One of the major purposes of the command is to repair broken
objects. This series introduces a "--raw" option to let you easily edit
the binary if need be.

The first two patches are unrelated cleanups I noticed in the area. The
third is refactoring, and the final one is the interesting bit.

There's a minor textual conflict in the documentation with
cc/replace-graft, but it's pretty straightforward to resolve.

  [1/4]: replace: replace spaces with tabs in indentation
  [2/4]: avoid double close of descriptors handed to run_command
  [3/4]: replace: use argv_array in export_object
  [4/4]: replace: add a --raw mode for --edit

-Peff
