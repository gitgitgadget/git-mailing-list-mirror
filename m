From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] Fix overridable written with an extra 'e'
Date: Fri, 28 Aug 2009 12:18:49 +0900
Message-ID: <20090828121849.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 05:23:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgs3c-0004Xu-GQ
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 05:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbZH1DXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 23:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbZH1DXK
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 23:23:10 -0400
Received: from karen.lavabit.com ([72.249.41.33]:60100 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831AbZH1DXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 23:23:09 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 61F3111B7D1;
	Thu, 27 Aug 2009 22:23:11 -0500 (CDT)
Received: from 5187.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 56HIIVWXS6WU; Thu, 27 Aug 2009 22:23:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=H5seV/3bHNGbDKxQYEBKyMom17XZgHYoJz39uxHFVb6fZBtaS7i49X0Vaj5w+hltlN6prOocOIFMhL7h4Zn2WEHhXIxCVj7dXZDOuIT8HfD/Tktz+Z9xhgn+Fb59HHMo7RnD4O3yc+hH1/hyY6iJ4tEyzRaOVzvcBBaYEPFIIm4=;
  h=From:To:Cc:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127249>

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
Found during the lunch break by one of my students...

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index b292e98..dcac8c8 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -61,7 +61,7 @@ automatic consolidation of packs.
 
 --prune=<date>::
 	Prune loose objects older than date (default is 2 weeks ago,
-	overrideable by the config variable `gc.pruneExpire`).  This
+	overridable by the config variable `gc.pruneExpire`).  This
 	option is on by default.
 
 --no-prune::
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 33ef190..43fa791 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -376,7 +376,7 @@ sub gitweb_get_feature {
 		@{$feature{$name}{'default'}});
 	if (!$override) { return @defaults; }
 	if (!defined $sub) {
-		warn "feature $name is not overrideable";
+		warn "feature $name is not overridable";
 		return @defaults;
 	}
 	return $sub->(@defaults);

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
