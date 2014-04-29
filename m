From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 03/12] MINGW: compat/mingw.h: drop fork() definition
Date: Tue, 29 Apr 2014 13:11:57 +0400
Message-ID: <1398762726-22825-4-git-send-email-marat@slonopotamus.org>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 11:12:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf45i-0005Qe-EH
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756774AbaD2JMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:12:21 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:44968 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754661AbaD2JMR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 05:12:17 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1Wf45G-0006BN-56; Tue, 29 Apr 2014 13:12:14 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247538>

fork() is not used in MinGW builds but causes a compiler warning
on x86_64 MinGW-W64: conflicting types for built-in function 'fork'

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
Acked-by: Eric Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 262b300..87d58ba 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -90,8 +90,6 @@ static inline int symlink(const char *oldpath, const char *newpath)
 { errno = ENOSYS; return -1; }
 static inline int fchmod(int fildes, mode_t mode)
 { errno = ENOSYS; return -1; }
-static inline pid_t fork(void)
-{ errno = ENOSYS; return -1; }
 static inline unsigned int alarm(unsigned int seconds)
 { return 0; }
 static inline int fsync(int fd)
-- 
1.9.1
