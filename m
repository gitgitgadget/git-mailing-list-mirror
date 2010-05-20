From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 4/5] mingw: use _commit to implement fsync
Date: Thu, 20 May 2010 20:57:54 +0200
Message-ID: <d9c55801e8ea50fafbc3ea5de0f7f084984418de.1274380838.git.j6t@kdbg.org>
References: <cover.1274380838.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 20 21:01:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFAze-0008SX-Lu
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 21:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673Ab0ETTBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 15:01:11 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:15453 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752601Ab0ETTBK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 15:01:10 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C9C32A7EC2;
	Thu, 20 May 2010 21:01:07 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id AAFB919F5F0;
	Thu, 20 May 2010 20:58:26 +0200 (CEST)
X-Mailer: git-send-email 1.7.1.64.ga1799.dirty
In-Reply-To: <cover.1274380838.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147410>

From: Erik Faye-Lund <kusmabite@googlemail.com>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/mingw.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 7c2ab64..a6b8778 100644
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
1.7.1.64.ga1799.dirty
