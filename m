From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH] mingw: disable Python
Date: Thu,  7 Jan 2010 23:07:17 +0100
Message-ID: <1262902037-4420-1-git-send-email-kusmabite@gmail.com>
References: <40aa078e1001071400j21900ed1n415394491d469b8c@mail.gmail.com>
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Thu Jan 07 23:07:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT0W7-0006fC-0I
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 23:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232Ab0AGWHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 17:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787Ab0AGWHi
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 17:07:38 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:51455 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196Ab0AGWHh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 17:07:37 -0500
Received: by ey-out-2122.google.com with SMTP id 22so1065045eye.19
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 14:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=K5uLw7LVE+5I7I13/ASw+YgWkBVsvpiJH7cG96UQJkQ=;
        b=CAH3aecQxHoL9h5noxZQIXDqOgw1FX0qVCiMzybSqFk688V9QWQZHNk8SEmJp7ONIV
         MfyhFEDjNdX0NDdlCupMWXsZvKJOhrNZn+2ICewIXbEXIVgs8PseXDrXkwnH/b7vYyaQ
         iQAM97bBtbaD/BJfNHimiCi/e/a3IM8QG1In8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xi2uy8hpCx6qwe1A93bcRieNIX5FY5KfySfp96vvWKJ/mUnB20WnGhGPRBl/BzohXQ
         x5feKUBZGbkmLmGlnD0u2aBTT222Ck95x/MCx2cITLnCay+5wLxqHCmMlIF4gjw0XDYj
         lSBHdTiLLc3R8PAa+lyiSMtZ4colVo88CFJu4=
Received: by 10.213.43.130 with SMTP id w2mr2204155ebe.89.1262902056530;
        Thu, 07 Jan 2010 14:07:36 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 13sm15411647ewy.5.2010.01.07.14.07.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Jan 2010 14:07:36 -0800 (PST)
X-Mailer: git-send-email 1.6.5.1.1372.g025e4.dirty
In-Reply-To: <40aa078e1001071400j21900ed1n415394491d469b8c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136396>

Python is not commonly installed on Windows machines, so
we should disable it there by default.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

This patch is against Junio's current master, and enables
msysgit to compile upstream git again after Sverre's addition
of the python remote-helpers (2fe40b6).

 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 015bfab..0004c52 100644
--- a/Makefile
+++ b/Makefile
@@ -1027,6 +1027,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	NO_REGEX = YesPlease
 	BLK_SHA1 = YesPlease
+	NO_PYTHON = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o
-- 
1.6.6.90.g50bc9.dirty
