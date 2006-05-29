From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Improved pack format documentation.
Date: Mon, 29 May 2006 03:17:18 -0400
Message-ID: <20060529071718.GD6061@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 09:17:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkc0C-000357-Mb
	for gcvg-git@gmane.org; Mon, 29 May 2006 09:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWE2HRW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 03:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWE2HRW
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 03:17:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47762 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750720AbWE2HRV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 03:17:21 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fkc07-0005Xv-0n; Mon, 29 May 2006 03:17:19 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6FAF120E445; Mon, 29 May 2006 03:17:18 -0400 (EDT)
To: Junio Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20929>

While trying to implement a pack reader in Java I was mislead by
some facts listed in this documentation as well as found a few
details to be missing about the pack header.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/technical/pack-format.txt |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index ed2decc..0e1ffb2 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -5,8 +5,13 @@ GIT pack format
 
    - The header appears at the beginning and consists of the following:
 
-     4-byte signature
-     4-byte version number (network byte order)
+     4-byte signature:
+         The signature is: {'P', 'A', 'C', 'K'}
+
+     4-byte version number (network byte order):
+         GIT currently accepts version number 2 or 3 but
+         generates version 2 only.
+
      4-byte number of objects contained in the pack (network byte order)
 
      Observation: we cannot have more than 4G versions ;-) and
@@ -41,7 +46,7 @@ GIT pack format
     8-byte integers to go beyond 4G objects per pack, but it is
     not strictly necessary.
 
-  - The header is followed by sorted 28-byte entries, one entry
+  - The header is followed by sorted 24-byte entries, one entry
     per object in the pack.  Each entry is:
 
     4-byte network byte order integer, recording where the
-- 
1.3.3.g45d8
