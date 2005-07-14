From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH] stgit: export without --range does not export the last patch
Date: Thu, 14 Jul 2005 02:27:56 -0400
Message-ID: <20050714062744.21779.87923.sendpatchset@bryan-larsens-ibook-g4.local>
References: <20050714062733.21779.33599.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, git@vger.kernel.org,
	catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Thu Jul 14 08:28:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsxCW-0004BR-2C
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 08:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbVGNG15 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 02:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262924AbVGNG15
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 02:27:57 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:40055 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262492AbVGNG14 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 02:27:56 -0400
Received: (qmail 67850 invoked from network); 14 Jul 2005 06:27:47 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=XqImEshhvy7+oW8pVy/B2EHFrxAE1LyXf7OEII2T+kZOZURlDEqTCcbfs/yRb9xmNyg7MlEPvGA+zcbfIN2HH9Ia5ShlwnHmoJOdfn6O44he9pg95F7EbGjuSERm+4NaZa5MgGtSuBvom7HDLfACPMp72X/av2XoNuow3lmChtM=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@69.159.204.165 with plain)
  by smtp104.mail.sc5.yahoo.com with SMTP; 14 Jul 2005 06:27:47 -0000
To: bryan.larsen@gmail.com
In-Reply-To: <20050714062733.21779.33599.sendpatchset@bryan-larsens-ibook-g4.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The top patch is never exported.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 stgit/commands/export.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/export.py b/stgit/commands/export.py
--- a/stgit/commands/export.py
+++ b/stgit/commands/export.py
@@ -90,7 +90,7 @@ def func(parser, options, args):
             raise MainException, 'Incorrect patch range order'
     else:
         start_idx = 0
-        stop_idx = -1
+        stop_idx = len(applied)
 
     patches = applied[start_idx:stop_idx]
 
