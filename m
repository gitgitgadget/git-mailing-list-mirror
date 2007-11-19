From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH] config: correct and clarify core.*compression documentation
Date: Mon, 19 Nov 2007 09:28:54 -0600
Message-ID: <20071119152853.GH6212@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonas Juselius <jonas.juselius@chem.uit.no>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 16:29:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu8Yk-0004gt-7W
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 16:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847AbXKSP25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 10:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753835AbXKSP25
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 10:28:57 -0500
Received: from mxsf03.insightbb.com ([74.128.0.64]:23506 "EHLO
	mxsf03.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819AbXKSP24 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 10:28:56 -0500
X-IronPort-AV: E=Sophos;i="4.21,437,1188792000"; 
   d="scan'208";a="110594949"
Received: from unknown (HELO asav02.insightbb.com) ([172.31.249.124])
  by mxsf03.insightbb.com with ESMTP; 19 Nov 2007 10:28:55 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAFc6QUdKhvkY/2dsb2JhbACBWA
X-IronPort-AV: E=Sophos;i="4.21,437,1188792000"; 
   d="scan'208";a="162256418"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav02.insightbb.com with ESMTP; 19 Nov 2007 10:28:55 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 3C169309F21; Mon, 19 Nov 2007 09:28:54 -0600 (CST)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65454>

* core.loosecompression stated that the default was "0 (best speed)",
  when in fact 0 is "no compression", and the default is Z_BEST_SPEED,
  which is 1.

* Explain that the default of core.compression is -1, zlib default, and
  add a quote from zlib.h explaining what that actually means.
---
  applies to 'maint'; unfortunately I just noticed 1.5.3.6 went out.

 Documentation/config.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7ee97df..d62a72b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -226,13 +226,16 @@ core.compression::
 	An integer -1..9, indicating a default compression level.
 	-1 is the zlib default. 0 means no compression,
 	and 1..9 are various speed/size tradeoffs, 9 being slowest.
+	If not set, defaults to -1 (zlib default), which is "a default
+	compromise between speed and compression (currently equivalent
+	to level 6)."
 
 core.loosecompression::
 	An integer -1..9, indicating the compression level for objects that
 	are not in a pack file. -1 is the zlib default. 0 means no
 	compression, and 1..9 are various speed/size tradeoffs, 9 being
 	slowest.  If not set,  defaults to core.compression.  If that is
-	not set,  defaults to 0 (best speed).
+	not set,  defaults to 1 (best speed).
 
 core.packedGitWindowSize::
 	Number of bytes of a pack file to map into memory in a
-- 
1.5.3.5.1824.g5f389
