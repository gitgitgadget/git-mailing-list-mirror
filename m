From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] contrib: remote-helpers: add move warnings (v2.0)
Date: Tue, 13 May 2014 16:29:56 -0500
Message-ID: <1400016596-13178-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 13 23:41:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkKRX-00026H-0d
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 23:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861AbaEMVkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 17:40:55 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:59434 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbaEMVky (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 17:40:54 -0400
Received: by mail-ob0-f177.google.com with SMTP id wp4so1090303obc.22
        for <git@vger.kernel.org>; Tue, 13 May 2014 14:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=C09yrUVV6D6Cr3uJIwdHRfM1hdB/763cvOEcuyAd508=;
        b=KyPA+AIIvlQ+/J4obQJwxCqneW4Z45tJA0xfGqXDNBnjff0h/HXO7TR8ndhnCqVZ6p
         4HbnHVAske7TS5mD8MoXLsEFMlntrjjUta2FvwNUJ14gE7wfp/E4qlahX1Jj9bCk+D34
         07u6KCBrSSdCoLCrAsmTczWTUItXbSZARblB0101a4+H3vEhfMWrhwsgH5OdCKNhtNc3
         nbCxPC+vZU8+YEF7Yb/iNLWvC5kws8mamB+OATs37pTSjbeaaF7XG5/p2TrDNx9OSR9m
         JLYCJBYR0kCk0wy1Vp0B7bH+qNt5GHJzCJ9x5nEy2Y2Q35neKa3Bj0lMROx4WnPsuYfQ
         Q4tA==
X-Received: by 10.60.141.9 with SMTP id rk9mr45273684oeb.12.1400017253495;
        Tue, 13 May 2014 14:40:53 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ld8sm3641257obb.9.2014.05.13.14.40.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 May 2014 14:40:52 -0700 (PDT)
X-Mailer: git-send-email 1.9.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248865>

The tools are now maintained out-of-tree, and they have a regression in
v2.0. It's better to start warning the users as soon as possible.

Can't possibly introduce regressions.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 3 +++
 contrib/remote-helpers/git-remote-hg  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 9abb58e..be4b9a3 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -43,6 +43,9 @@ import re
 import StringIO
 import atexit, shutil, hashlib, urlparse, subprocess
 
+sys.stderr.write('WARNING: git-remote-bzr is now maintained independently.\n')
+sys.stderr.write('WARNING: For more information visit https://github.com/felipec/git-remote-bzr\n')
+
 NAME_RE = re.compile('^([^<>]+)')
 AUTHOR_RE = re.compile('^([^<>]+?)? ?[<>]([^<>]*)(?:$|>)')
 EMAIL_RE = re.compile(r'([^ \t<>]+@[^ \t<>]+)')
diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 34cda02..989df66 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -25,6 +25,9 @@ import atexit
 import urlparse, hashlib
 import time as ptime
 
+sys.stderr.write('WARNING: git-remote-hg is now maintained independently.\n')
+sys.stderr.write('WARNING: For more information visit https://github.com/felipec/git-remote-hg\n')
+
 #
 # If you want to see Mercurial revisions as Git commit notes:
 # git config core.notesRef refs/notes/hg
-- 
1.9.2
