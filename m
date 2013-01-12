From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 5/8] svn-fe: allow svnrdump_sim.py to run with Python 3
Date: Sat, 12 Jan 2013 19:23:43 +0000
Message-ID: <fcc99192ded58bf017a56a3e2f3cfb2fce06bd5b.1358018078.git.john@keeping.me.uk>
References: <cover.1358018078.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 20:25:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu6iF-0001qa-U0
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 20:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207Ab3ALTZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 14:25:32 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:60533 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab3ALTZb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 14:25:31 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 7015322F81;
	Sat, 12 Jan 2013 19:25:31 +0000 (GMT)
X-Quarantine-ID: <dVgZN3LFjpd4>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dVgZN3LFjpd4; Sat, 12 Jan 2013 19:25:30 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id D482322F7C;
	Sat, 12 Jan 2013 19:25:30 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id C4510161E556;
	Sat, 12 Jan 2013 19:25:30 +0000 (GMT)
X-Quarantine-ID: <i-CIyG5f8c+k>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i-CIyG5f8c+k; Sat, 12 Jan 2013 19:25:30 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id B93F0161E1F3;
	Sat, 12 Jan 2013 19:25:15 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <cover.1358018078.git.john@keeping.me.uk>
In-Reply-To: <cover.1358018078.git.john@keeping.me.uk>
References: <cover.1358018078.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213306>

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
1.8.1
