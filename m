From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 1/5] hg-to-git: avoid raising a string exception
Date: Sun,  6 Jul 2008 05:15:17 +0200
Message-ID: <89a68bb21125c4ff706412cde5c04f5d96658789.1215313871.git.vmiklos@frugalware.org>
References: <cover.1215313871.git.vmiklos@frugalware.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stelian Pop <stelian@popies.net>
X-From: git-owner@vger.kernel.org Sun Jul 06 05:16:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFKjq-0000sb-Ff
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 05:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753347AbYGFDPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 23:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbYGFDPO
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 23:15:14 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:57909 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbYGFDPL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 23:15:11 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 7165F1DDC5C;
	Sun,  6 Jul 2008 05:15:08 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 4A9271A9CF0; Sun,  6 Jul 2008 05:15:21 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1.322.ge904b.dirty
In-Reply-To: <cover.1215313871.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1215313871.git.vmiklos@frugalware.org>
References: <cover.1215313871.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87492>

This fixes the following warning:
hg-to-git.py:92: DeprecationWarning: raising a string exception is deprecated

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 contrib/hg-to-git/hg-to-git.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index f68ef72..25d9941 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -89,7 +89,7 @@ try:
         if o in ('-v', '--verbose'):
             verbose = True
     if len(args) != 1:
-        raise('params')
+        raise Exception('params')
 except:
     usage()
     sys.exit(1)
-- 
1.5.6.1.322.ge904b.dirty
