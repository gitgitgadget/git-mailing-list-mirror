From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH 2/2] config: clarify compression defaults
Date: Mon, 19 Nov 2007 10:58:51 -0600
Message-ID: <1195491531-2701-2-git-send-email-bdowning@lavos.net>
References: <alpine.LFD.0.99999.0711191139240.19105@xanadu.home>
 <1195491531-2701-1-git-send-email-bdowning@lavos.net>
Cc: Nicolas Pitre <nico@cam.org>,
	Jonas Juselius <jonas.juselius@chem.uit.no>,
	git@vger.kernel.org, Brian Downing <bdowning@lavos.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 18:07:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuA63-0000xe-C1
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 18:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690AbXKSRH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 12:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753229AbXKSRH0
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 12:07:26 -0500
Received: from mxsf04.insightbb.com ([74.128.0.74]:38046 "EHLO
	mxsf04.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690AbXKSRHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 12:07:25 -0500
X-IronPort-AV: E=Sophos;i="4.21,437,1188792000"; 
   d="scan'208";a="119310253"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO asav02.insightbb.com) ([74.134.249.24])
  by mxsf04.insightbb.com with ESMTP; 19 Nov 2007 12:07:24 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAIJRQUdKhvkY/2dsb2JhbACBWA
X-IronPort-AV: E=Sophos;i="4.21,437,1188792000"; 
   d="scan'208";a="162316094"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav02.insightbb.com with ESMTP; 19 Nov 2007 12:07:23 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 22BC7309F20; Mon, 19 Nov 2007 11:07:23 -0600 (CST)
X-Original-To: bdowning@lavos.net
Received: from silvara.lavos.net (silvara.lavos.net [10.4.0.20])
	by mail.lavos.net (Postfix) with SMTP id 78747309F21;
	Mon, 19 Nov 2007 10:58:48 -0600 (CST)
Received: (nullmailer pid 2761 invoked by uid 1000);
	Mon, 19 Nov 2007 16:58:51 -0000
X-Mailer: git-send-email 1.5.3.5.1824.g5f389
In-Reply-To: <1195491531-2701-1-git-send-email-bdowning@lavos.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65472>

* Clarify that core.compression provides a system-wide default to
  other compression parameters.

* Explain that the default for pack.compression, -1, is "a default
  compromise between speed and compression (currently equivalent
  to level 6)" according to zlib.h.

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
 Documentation/config.txt |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9565652..5d1eb5d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -226,6 +226,8 @@ core.compression::
 	An integer -1..9, indicating a default compression level.
 	-1 is the zlib default. 0 means no compression,
 	and 1..9 are various speed/size tradeoffs, 9 being slowest.
+	If set, this provides a default to other compression variables, 
+	such as 'core.loosecompression' and 'pack.compression'.
 
 core.loosecompression::
 	An integer -1..9, indicating the compression level for objects that
@@ -622,7 +624,9 @@ pack.compression::
 	in a pack file. -1 is the zlib default. 0 means no
 	compression, and 1..9 are various speed/size tradeoffs, 9 being
 	slowest.  If not set,  defaults to core.compression.  If that is
-	not set,  defaults to -1.
+	not set,  defaults to -1, the zlib default, which is "a default
+	compromise between speed and compression (currently equivalent 
+	to level 6)."
 
 pack.deltaCacheSize::
 	The maximum memory in bytes used for caching deltas in
-- 
1.5.3.5.1824.g5f389
