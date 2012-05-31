From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/6] reflog: remove i18n legos in pruning message
Date: Thu, 31 May 2012 20:04:38 +0700
Message-ID: <1338469482-30936-3-git-send-email-pclouds@gmail.com>
References: <1338463242-10618-1-git-send-email-worldhello.net@gmail.com>
 <1338469482-30936-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 31 15:09:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa57x-0006qi-AP
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 15:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757999Ab2EaNJR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 09:09:17 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54297 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757948Ab2EaNJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 09:09:16 -0400
Received: by dady13 with SMTP id y13so1271684dad.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 06:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uGmZOj2jao8phxhDiZ/9G91lPUxiJJIBSiSBrB67dDY=;
        b=cJ+tO1ftrCDv/c2S5/kMToAStS5awQzGK1dnwbpV7Gc9z8tncuO5NiBEaUBInYHAbL
         NgLBowU/IYQn9D8tlWdQLMS8zU5LeJz5T9muYVtT7ymsMMz8AknhZkfMi+rwne9jpJsC
         /Whi8Phy7XbWnQPfiQtTv/yWsv56++qooxkXREFwyx1y7RN1LWPjd2ou4mtcJOt+3cC2
         ROrsy8Dj9QSXoh0HFBNVN6Yq0zDek6U9UUg5Fi0eX12ZGUmM7w2T4uGbnOW/erFgJNX0
         2V6D1Fg2vx1DSA8NzUs/4uDIbMeH2rkeqf+ML6CWmuYqWp/mk3mNTXQ+WoxYcl3a9ALC
         SYPw==
Received: by 10.68.230.105 with SMTP id sx9mr6545989pbc.114.1338469756043;
        Thu, 31 May 2012 06:09:16 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.14])
        by mx.google.com with ESMTPS id ql3sm4128873pbc.72.2012.05.31.06.09.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 May 2012 06:09:15 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 31 May 2012 20:05:04 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338469482-30936-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198890>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/reflog.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 062d7da..6cedcec 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -330,8 +330,12 @@ static int expire_reflog_ent(unsigned char *osha1,=
 unsigned char *nsha1,
 		printf("keep %s", message);
 	return 0;
  prune:
-	if (!cb->newlog || cb->cmd->verbose)
-		printf("%sprune %s", cb->newlog ? "" : "would ", message);
+	if (!cb->newlog || cb->cmd->verbose) {
+		if (cb->newlog)
+			printf("prune %s", message);
+		else
+			printf("would prune %s", message);
+	}
 	return 0;
 }
=20
--=20
1.7.10.2.549.g9354186
