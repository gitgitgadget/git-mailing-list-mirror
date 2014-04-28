From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 12/12] MINGW: compat/mingw.h: drop fork() definition
Date: Mon, 28 Apr 2014 17:51:37 +0400
Message-ID: <1398693097-24651-13-git-send-email-marat@slonopotamus.org>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 15:58:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wem51-0003P7-7B
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 15:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137AbaD1N6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 09:58:33 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:39737 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbaD1N6a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 09:58:30 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WelyN-0004qo-E4; Mon, 28 Apr 2014 17:51:55 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247341>

fork() is not used in MinGW builds but causes a compiler warning
on x86_64 MinGW-W64: conflicting types for built-in function 'fork'

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 compat/mingw.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 8850109..2fbc8ea 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -89,8 +89,6 @@ static inline int symlink(const char *oldpath, const char *newpath)
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
