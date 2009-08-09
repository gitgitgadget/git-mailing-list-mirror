From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] moving test trash directories
Date: Sun, 9 Aug 2009 04:35:19 -0400
Message-ID: <20090809083518.GA8147@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 09 10:35:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma3sM-0005Xp-8E
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 10:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbZHIIfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 04:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752507AbZHIIfV
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 04:35:21 -0400
Received: from peff.net ([208.65.91.99]:32944 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674AbZHIIfU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 04:35:20 -0400
Received: (qmail 2705 invoked by uid 107); 9 Aug 2009 08:37:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 09 Aug 2009 04:37:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Aug 2009 04:35:19 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125329>

This series adds support for making trash directories for the test
scripts outside of the usual hierarchy. The main benefit is improved
performance. By putting the trash directories onto a tmpfs (rather than
SATA disks), my "make -j32 test" time went from around 1m51s to around
1m01s. I can only imagine what improvement it would have for people on
NFS.  :)

It also has the nice side effect that running the test suite doesn't
thrash your disk as much, in case you wanted to do something else while
it was running.

  [1/3] tests: use "$TEST_DIRECTORY" instead of ".."
  [2/3] tests: provide $TRASH_DIRECTORY variable
  [3/3] tests: allow user to specify trash directory location

-Peff
