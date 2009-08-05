From: Mark A Rada <marada@uwaterloo.ca>
Subject: [PATCHv4 3/3] gitweb: update INSTALL w.r.t. snapshot format changes
Date: Wed, 5 Aug 2009 09:20:15 -0400
Message-ID: <5250C22D-E4D9-4A7C-ABF5-D01316FB1B56@uwaterloo.ca>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 15:20:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYgPr-0004YP-0m
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 15:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934318AbZHENUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 09:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934316AbZHENUR
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 09:20:17 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:34599 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934315AbZHENUQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 09:20:16 -0400
Received: from [192.168.1.102] (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id n75DJggb011477
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Wed, 5 Aug 2009 09:20:15 -0400 (EDT)
X-Mailer: Apple Mail (2.935.3)
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Wed, 05 Aug 2009 09:20:16 -0400 (EDT)
X-Miltered: at psyche with ID 4A7986EE.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on localhost
X-Virus-Status: Clean
X-UUID: 32715ccd-729b-4a37-9473-ef5e1aa9bef8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124905>

Documentation is now a little bit clearer.

--
Mark A Rada (ferrous26)
marada@uwaterloo.ca


-------->8-----------------
From: Mark Rada <marada@uwaterloo.ca>
Date: Sat, 1 Aug 2009 22:36:54 -0400
Subject: [PATCH 3/3] gitweb: update INSTALL w.r.t. snapshot format  
changes

Details about how to enable/disable a compression format and how to
set the compression level for any given format, except Zip which does
not have that ability to set a compression level.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---
  gitweb/INSTALL |   11 +++++++++++
  1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 18c9ce3..d53e1bb 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -123,6 +123,17 @@ GITWEB_CONFIG file:
  	$feature{'snapshot'}{'default'} = ['zip', 'tgz'];
  	$feature{'snapshot'}{'override'} = 1;

+Furthermore, if you enable overriding of the snapshot feature you can
+still disable specific compression formats from being used (XZ is
+disabled by default). You can also change the default compression level
+for non-Zip formats by specifying the level after the compressor name.
+For example, we can disable BZip2 compression, and enable XZ  
compression
+at level 6 by adding the following to your GITWEB_CONFIG file:
+
+	$known_snapshot_formats{'tbz2'}{'disabled'} = 1;
+	$known_snapshot_formats{'txz'}{'disabled'} = 0;
+	$known_snapshot_formats{'txz'}{'compressor'} = ['xz','-6'];
+

  Gitweb repositories
  -------------------
-- 
1.6.4
