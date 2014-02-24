From: Jeff King <peff@peff.net>
Subject: [PATCH 0/5] handle bogus commit dates
Date: Mon, 24 Feb 2014 02:33:48 -0500
Message-ID: <20140224073348.GA20221@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 24 08:33:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHq30-0003Oq-Vw
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 08:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbaBXHdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 02:33:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:55852 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751200AbaBXHdu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 02:33:50 -0500
Received: (qmail 14014 invoked by uid 102); 24 Feb 2014 07:33:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Feb 2014 01:33:51 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Feb 2014 02:33:48 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242565>

This series improves our handling of commit dates that are numbers, but
are ridiculously large. The most critical one is the final commit, which
fixes a segfault, but the others clean up various corner cases.

  [1/5]: t4212: test bogus timestamps with git-log
  [2/5]: fsck: report integer overflow in author timestamps
  [3/5]: date: check date overflow against time_t
  [4/5]: pretty: handle integer overflow in timestamps
  [5/5]: log: do not segfault on gmtime errors

-Peff
