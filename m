From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH JGIT 4/5] Repository: Make listener collections members final
Date: Wed, 12 Aug 2009 11:06:47 -0400
Message-ID: <1250089607-22476-1-git-send-email-fonseca@diku.dk>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 17:07:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbFPv-0002zZ-RQ
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 17:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496AbZHLPGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 11:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753469AbZHLPGu
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 11:06:50 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:52845 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450AbZHLPGt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 11:06:49 -0400
Received: by gxk9 with SMTP id 9so106130gxk.13
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 08:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=b4zxcgC0mRzvhH1wk+VsgibaRDL2cIxR+KJ8Gx2MhDI=;
        b=UT7D4lI4f8WWhLsrHMH5bcfTcklbqrODknYUCgyq+43kGpaV75jwZe8wctOde/nuwJ
         1mt+WvnVp6zdSbWbPJ/cY5n2tSgWG5+8SAmlOL/4AO4uMd3N8QP+AvFVq6VVw9eFX1Oc
         jw22i36ZQplYcj65i6+NWLjyJ2vn4rz1f6UVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=sofCb/OgeL3Od08o70OzNL5TEI+0acAih3imk5sVsoS16FPZvAlFtZ2btxbzzKieqB
         Xo/lngdvYPDiBNy6W1u1KHDGgYSuW18lxYLLn6ry4gBDYL88LR+TdsyZypPGQsKKT5bC
         iWvoZCGQneQdaWMkK/h3gK9WWNA3+yACij1uw=
Received: by 10.91.156.15 with SMTP id i15mr142222ago.0.1250089610318;
        Wed, 12 Aug 2009 08:06:50 -0700 (PDT)
Received: from localhost.localdomain (bas1-montreal42-1178045554.dsl.bell.ca [70.55.140.114])
        by mx.google.com with ESMTPS id 38sm11243aga.39.2009.08.12.08.06.49
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 12 Aug 2009 08:06:49 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.rc3.195.g2b05f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125705>

Silences warnings related with using synchronized() on these members.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 .../src/org/spearce/jgit/lib/Repository.java       |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 468cf4c..d6be9bf 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -100,8 +100,8 @@
 
 	private GitIndex index;
 
-	private List<RepositoryListener> listeners = new Vector<RepositoryListener>(); // thread safe
-	static private List<RepositoryListener> allListeners = new Vector<RepositoryListener>(); // thread safe
+	private final List<RepositoryListener> listeners = new Vector<RepositoryListener>(); // thread safe
+	static private final List<RepositoryListener> allListeners = new Vector<RepositoryListener>(); // thread safe
 
 	/**
 	 * Construct a representation of a Git repository.
-- 
1.6.4.rc3.195.g2b05f
