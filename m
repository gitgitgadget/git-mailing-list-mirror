From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 098/104] mingw: use _commit to implement fsync
Date: Wed, 26 May 2010 18:01:08 +1200
Message-ID: <1274853674-18521-98-git-send-email-sam.vilain@catalyst.net.nz>
References: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 08:07:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH9lg-0004ff-Pq
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 08:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934037Ab0EZGGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 02:06:38 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:49306 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933930Ab0EZGG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 02:06:26 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 May 2010 02:06:22 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id A6AB3338A4;
	Wed, 26 May 2010 18:02:06 +1200 (NZST)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gp4uTVWJzDIM; Wed, 26 May 2010 18:02:05 +1200 (NZST)
Received: from wilber.wgtn.cat-it.co.nz (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 9E8FA33802;
	Wed, 26 May 2010 18:01:39 +1200 (NZST)
X-Mailer: git-send-email 1.7.1.rc2.333.gb2668
In-Reply-To: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147755>

From: Erik Faye-Lund <kusmabite@googlemail.com>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/mingw.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 0e3e743..f465566 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -80,7 +80,7 @@ static inline int fork(void)
 static inline unsigned int alarm(unsigned int seconds)
 { return 0; }
 static inline int fsync(int fd)
-{ return 0; }
+{ return _commit(fd); }
 static inline int getppid(void)
 { return 1; }
 static inline void sync(void)
-- 
1.7.1.rc2.333.gb2668
