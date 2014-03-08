From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 10/28] commit: use SEQ_DIR instead of hardcoding "sequencer"
Date: Sat,  8 Mar 2014 09:48:02 +0700
Message-ID: <1394246900-31535-11-git-send-email-pclouds@gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
 <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 03:49:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM7Jx-0005Db-PR
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 03:49:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbaCHCs6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 21:48:58 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:61341 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbaCHCs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 21:48:57 -0500
Received: by mail-pd0-f172.google.com with SMTP id p10so4820349pdj.3
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 18:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4Q3zhNvWzoYS6OabzgA59XVKXnAZOOo0g7cfih+vx7M=;
        b=M/rP2FUNuslWq2SPL9oCS7qpjs5sh5/jWHFUgMbtNCR04couOaBwiuQarMVJ07q/Ov
         zqkB3rYdO2ijRCKOL6CSUDecwfrnTl/FRuzv0kP7nZnF6X5tn07O2UoSo/dNcssYOWnw
         I/JycON+ufKWoM6UqGWoNkB67aj0X2Iv3eUrvr6gH3A0WLa4bRtSE6VZr7e/VauJuioi
         /DkZewaQHxUMTrKdRKzX0U823jBTfrM1KqLOO+mDaoZtWyhLOLkmsIUDMCFuPTt988+6
         nU9mAzcwT7meyGtxTiQ6y8UeccjkEKYTvA23mCC7ZnFAAPS0a8Xg6P9D7iBw5yaT1DDJ
         gWIA==
X-Received: by 10.68.130.137 with SMTP id oe9mr25865880pbb.21.1394246936474;
        Fri, 07 Mar 2014 18:48:56 -0800 (PST)
Received: from lanh ([115.73.205.153])
        by mx.google.com with ESMTPSA id sh5sm7908427pbc.21.2014.03.07.18.48.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Mar 2014 18:48:55 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Mar 2014 09:49:29 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243651>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 3767478..ee3ac10 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -155,7 +155,7 @@ static void determine_whence(struct wt_status *s)
 		whence =3D FROM_MERGE;
 	else if (file_exists(git_path("CHERRY_PICK_HEAD"))) {
 		whence =3D FROM_CHERRY_PICK;
-		if (file_exists(git_path("sequencer")))
+		if (file_exists(git_path(SEQ_DIR)))
 			sequencer_in_use =3D 1;
 	}
 	else
--=20
1.9.0.40.gaa8c3ea
