From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] docs: note that receive-pack knows side-band-64k
 capability
Date: Wed, 24 Jul 2013 04:01:59 -0400
Message-ID: <20130724080159.GB4425@sigill.intra.peff.net>
References: <20130724080051.GA3890@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 10:02:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1u1v-00039p-9m
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 10:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894Ab3GXICd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 04:02:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:36961 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919Ab3GXICF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 04:02:05 -0400
Received: (qmail 23333 invoked by uid 102); 24 Jul 2013 08:02:04 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 24 Jul 2013 03:02:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jul 2013 04:01:59 -0400
Content-Disposition: inline
In-Reply-To: <20130724080051.GA3890@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231085>

The protocol-capabilities documentation notes that any
capabilities not explicitly mentioned for receive-pack work
only for upload-pack.

Receive-pack has advertised and understood side-band-64k
since 38a81b4 (receive-pack: Wrap status reports inside
side-band-64k, 2010-02-05), but we do not mention it
explicitly. Let's do so.

Note that receive-pack does not understand side-band, which
was obsolete by that point.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/protocol-capabilities.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 11467ff..9bc2a10 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -21,8 +21,8 @@ recognized by the receive-pack (push to server) process.
 The 'report-status' and 'delete-refs' capabilities are sent and
 recognized by the receive-pack (push to server) process.
 
-The 'ofs-delta' capability is sent and recognized by both upload-pack
-and receive-pack protocols.
+The 'ofs-delta' and 'side-band-64k' capabilities are sent and recognized
+by both upload-pack and receive-pack protocols.
 
 All other capabilities are only recognized by the upload-pack (fetch
 from server) process.
-- 
1.8.3.rc1.30.gff0fb75
