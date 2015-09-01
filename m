From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] clarify sideband muxing in GIT_TRACE_PACKET
Date: Tue, 1 Sep 2015 16:22:16 -0400
Message-ID: <20150901202215.GA17370@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 22:22:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWs4V-0000i1-Ji
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 22:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbbIAUWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 16:22:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:53287 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751186AbbIAUWS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 16:22:18 -0400
Received: (qmail 21519 invoked by uid 102); 1 Sep 2015 20:22:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 15:22:18 -0500
Received: (qmail 5387 invoked by uid 107); 1 Sep 2015 20:22:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 16:22:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Sep 2015 16:22:16 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277036>

I happened to be debugging push with GIT_TRACE_PACKET today, and got
confused by the mixture of trace from the sideband demuxer and push
itself (details in patch 2/2). This series fixes it by showing a
distinct prefix for the sideband reads.

There's some trickery with start_async() involved, so I've tested it
both with and without NO_PTHREADS set.

  [1/2]: run-command: provide in_async query function
  [2/2]: pkt-line: show packets in async processes as "sideband"

-Peff
