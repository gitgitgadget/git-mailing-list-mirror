From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Subject: [PATCH] Warning fix in diff.c
Date: Tue, 14 Jun 2005 23:57:50 +0900
Message-ID: <20050614235750.3156fd24.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: yuasa@hh.iij4u.or.jp
X-From: git-owner@vger.kernel.org Tue Jun 14 16:53:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiCnY-00069K-Gx
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 16:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVFNO6T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Jun 2005 10:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVFNO6T
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jun 2005 10:58:19 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:20477 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261160AbVFNO6B (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2005 10:58:01 -0400
Received: MO(mo01)id j5EEvu7r024568; Tue, 14 Jun 2005 23:57:56 +0900 (JST)
Received: MDO(mdo00) id j5EEvt7S000564; Tue, 14 Jun 2005 23:57:55 +0900 (JST)
Received: from stratos (h042.p502.iij4u.or.jp [210.149.246.42])
	by mbox.iij4u.or.jp (4U-MR/mbox01) id j5EEvsnE026404
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Tue, 14 Jun 2005 23:57:54 +0900 (JST)
To: git@vger.kernel.org
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch had fixed the following warning.
Please apply.

cc -g -O2 -Wall  '-DSHA1_HEADER="mozilla-sha1/sha1.h"'   -c -o diff.o diff.c
diff.c: In function `parse_num':
diff.c:606: warning: value computed is not used

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -603,7 +603,7 @@ static int parse_num(const char **cp_p)
 			scale *= 10;
 			num = num * 10 + ch - '0';
 		}
-		*cp++;
+		cp++;
 	}
 	*cp_p = cp;
 
