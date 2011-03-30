From: Jakob Pfender <jpfender@elegosoft.com>
Subject: [PATCH] Documentation/git-update-index.txt: Remove obsolete note
Date: Wed, 30 Mar 2011 15:01:57 +0200
Organization: elego Software Solutions GmbH
Message-ID: <4D9329C5.3060809@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, torvalds@osdl.org,
	spearce@spearce.org, johannes.schindelin@gmx.de, peff@peff.net,
	nico@fluxnic.net, pclouds@gmail.com, barkalow@iabervon.org,
	chriscool@tuxfamily.org, jrnieder@gmail.com, raa.lkml@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 15:02:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4v2M-00081N-3D
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 15:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754883Ab1C3NCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 09:02:08 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:58854 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681Ab1C3NCH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 09:02:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 643901B4DA3;
	Wed, 30 Mar 2011 15:02:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BZnbxqetlM-x; Wed, 30 Mar 2011 15:01:59 +0200 (CEST)
Received: from [10.10.10.30] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 7727E1B4DB1;
	Wed, 30 Mar 2011 15:01:58 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170382>

8dcf39 (Prevent bogus paths from being added to the index) introduced a
check for files beginning with '.', preventing path names such as
`./file`, `dir/./file` or `dir/../file` from being added. This was
reflected in the man page.

d089eba (setup: sanitize absolute and funny paths in get_pathspec())
removed this check without reflecting the change in the man page.

Signed-off-by: Jakob Pfender <jpfender@elegosoft.com>
---
  Documentation/git-update-index.txt |    6 ++----
  1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-update-index.txt 
b/Documentation/git-update-index.txt
index 1ca56c8..f0dcd1f 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -152,10 +152,8 @@ you will need to handle the situation manually.

  <file>::
  	Files to act on.
-	Note that files beginning with '.' are discarded. This includes
-	`./file` and `dir/./file`. If you don't want this, then use
-	cleaner names.
-	The same applies to directories ending '/' and paths with '//'
+	Note that directories ending in '/' and paths with '//' are
+	discarded.

  Using --refresh
  ---------------
-- 
1.7.0.4
