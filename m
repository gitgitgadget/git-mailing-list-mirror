From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH 3/3] Compile fix for MSVC: Use NO_INET_PTON and NO_INET_NTOP
Date: Fri, 18 Nov 2011 17:44:30 +0100
Message-ID: <1321634670-4968-3-git-send-email-vfr@lyx.org>
References: <1321634670-4968-1-git-send-email-vfr@lyx.org>
Cc: gitster@pobox.com, kusmabite@gmail.com, msysgit@googlegroups.com,
	j.sixt@viscovery.net, Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 17:46:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRRa7-0006sN-4k
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 17:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758119Ab1KRQpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 11:45:52 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61269 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756409Ab1KRQpv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 11:45:51 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so3544688eye.19
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 08:45:50 -0800 (PST)
Received: by 10.14.9.198 with SMTP id 46mr333260eet.176.1321634750460;
        Fri, 18 Nov 2011 08:45:50 -0800 (PST)
Received: from localhost.localdomain (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id z58sm4088253eea.3.2011.11.18.08.45.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Nov 2011 08:45:49 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1321634670-4968-1-git-send-email-vfr@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185668>

This is needed to compile daemon.c.

In v1.7.3.2-162-ga666b47 (Nov 4 2010; Erik Faye-Lund <kusmabite@gmail.com>;
daemon: opt-out on features that require posix) this was introduced for
MingW, but this is also necessary for MSVC.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index ee34eab..b9d53aa 100644
--- a/Makefile
+++ b/Makefile
@@ -1120,6 +1120,8 @@ ifeq ($(uname_S),Windows)
 	BLK_SHA1 = YesPlease
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	NATIVE_CRLF = YesPlease
+	NO_INET_PTON = YesPlease
+	NO_INET_NTOP = YesPlease
 
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
-- 
1.7.4.1
