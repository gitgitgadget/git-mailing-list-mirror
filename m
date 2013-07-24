From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] document 'quiet' receive-pack capability
Date: Wed, 24 Jul 2013 04:03:43 -0400
Message-ID: <20130724080342.GD4425@sigill.intra.peff.net>
References: <20130724080051.GA3890@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 10:03:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1u37-0004nJ-Uw
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 10:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173Ab3GXIDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 04:03:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:36981 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919Ab3GXIDq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 04:03:46 -0400
Received: (qmail 23454 invoked by uid 102); 24 Jul 2013 08:03:46 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 24 Jul 2013 03:03:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jul 2013 04:03:43 -0400
Content-Disposition: inline
In-Reply-To: <20130724080051.GA3890@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231087>

This was added in c207e34 (fix push --quiet: add 'quiet'
capability to receive-pack, 2012-01-08) but never
documented.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/protocol-capabilities.txt | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index d35159e..ec131b6 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -18,7 +18,7 @@ NOT advertise capabilities it does not understand.
 and server advertised.  As a consequence of these rules, server MUST
 NOT advertise capabilities it does not understand.
 
-The 'report-status' and 'delete-refs' capabilities are sent and
+The 'report-status', 'delete-refs', and 'quiet' capabilities are sent and
 recognized by the receive-pack (push to server) process.
 
 The 'ofs-delta' and 'side-band-64k' capabilities are sent and recognized
@@ -200,3 +200,13 @@ to delete references.
 value of a reference update.  It is not sent back by the client, it
 simply informs the client that it can be sent zero-id values
 to delete references.
+
+quiet
+-----
+
+If the receive-pack server advertises the 'quiet' capability, it is
+capable of silencing human-readable progress output which otherwise may
+be shown when processing the received pack. A send-pack client should
+respond with the 'quiet' capability to suppress server-side progress
+reporting if the local progress reporting is also being suppressed
+(e.g., via `push -q`, or if stderr does not go to a tty).
-- 
1.8.3.rc1.30.gff0fb75
