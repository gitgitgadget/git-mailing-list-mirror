From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v3 5/8] svn-fe: allow svnrdump_sim.py to run with Python 3
Date: Sun, 20 Jan 2013 13:15:35 +0000
Message-ID: <939a445ab113e0beb41e6882b1ec6089de86fac9.1358686905.git.john@keeping.me.uk>
References: <cover.1358686905.git.john@keeping.me.uk>
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 14:16:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Twulc-00039M-Ua
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 14:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051Ab3ATNQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 08:16:36 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:51846 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab3ATNQf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 08:16:35 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 3668C6064D3;
	Sun, 20 Jan 2013 13:16:35 +0000 (GMT)
X-Quarantine-ID: <SeoX1oie6vGb>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SeoX1oie6vGb; Sun, 20 Jan 2013 13:16:34 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id C6BD36064D2;
	Sun, 20 Jan 2013 13:16:34 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id C13B9161E480;
	Sun, 20 Jan 2013 13:16:34 +0000 (GMT)
X-Quarantine-ID: <92-onL2lmS4Y>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 92-onL2lmS4Y; Sun, 20 Jan 2013 13:16:34 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 39AEC161E509;
	Sun, 20 Jan 2013 13:16:27 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <cover.1358686905.git.john@keeping.me.uk>
In-Reply-To: <cover.1358686905.git.john@keeping.me.uk>
References: <cover.1358686905.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214015>

The changes to allow this script to run with Python 3 are minimal and do
not affect its functionality on the versions of Python 2 that are
already supported (2.4 onwards).

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 contrib/svn-fe/svnrdump_sim.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/svn-fe/svnrdump_sim.py b/contrib/svn-fe/svnrdump_sim.py
index 17cf6f9..4e78a1c 100755
--- a/contrib/svn-fe/svnrdump_sim.py
+++ b/contrib/svn-fe/svnrdump_sim.py
@@ -14,7 +14,7 @@ if sys.hexversion < 0x02040000:
 
 def getrevlimit():
         var = 'SVNRMAX'
-        if os.environ.has_key(var):
+        if var in os.environ:
                 return os.environ[var]
         return None
 
@@ -44,7 +44,7 @@ def writedump(url, lower, upper):
 
 if __name__ == "__main__":
         if not (len(sys.argv) in (3, 4, 5)):
-                print "usage: %s dump URL -rLOWER:UPPER"
+                print("usage: %s dump URL -rLOWER:UPPER")
                 sys.exit(1)
         if not sys.argv[1] == 'dump': raise NotImplementedError('only "dump" is suppported.')
         url = sys.argv[2]
-- 
1.8.1.353.gc992d5a.dirty
