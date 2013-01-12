From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/8] git_remote_helpers: Allow building with Python 3
Date: Sat, 12 Jan 2013 19:23:39 +0000
Message-ID: <225a94d3d14770d46f48ac1a9309e660d24f4441.1358018078.git.john@keeping.me.uk>
References: <cover.1358018078.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 20:24:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu6hH-00015B-8T
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 20:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181Ab3ALTYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 14:24:25 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:43824 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082Ab3ALTYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 14:24:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 74C62606566;
	Sat, 12 Jan 2013 19:24:24 +0000 (GMT)
X-Quarantine-ID: <gECFU6jAVjG9>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gECFU6jAVjG9; Sat, 12 Jan 2013 19:24:24 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 0E3E6606565;
	Sat, 12 Jan 2013 19:24:24 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 01D43161E563;
	Sat, 12 Jan 2013 19:24:24 +0000 (GMT)
X-Quarantine-ID: <WzRIaiNkbYkG>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WzRIaiNkbYkG; Sat, 12 Jan 2013 19:24:23 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id A2E90161E55A;
	Sat, 12 Jan 2013 19:24:12 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <cover.1358018078.git.john@keeping.me.uk>
In-Reply-To: <cover.1358018078.git.john@keeping.me.uk>
References: <cover.1358018078.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213302>

Change inline Python to call "print" as a function not a statement.

This is harmless because Python 2 will see the parentheses as redundant
grouping but they are necessary to run this code with Python 3.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git_remote_helpers/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git_remote_helpers/Makefile b/git_remote_helpers/Makefile
index 74b05dc..f65f064 100644
--- a/git_remote_helpers/Makefile
+++ b/git_remote_helpers/Makefile
@@ -23,7 +23,7 @@ endif
 
 PYLIBDIR=$(shell $(PYTHON_PATH) -c \
 	 "import sys; \
-	 print 'lib/python%i.%i/site-packages' % sys.version_info[:2]")
+	 print('lib/python%i.%i/site-packages' % sys.version_info[:2])")
 
 all: $(pysetupfile)
 	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build
-- 
1.8.1
