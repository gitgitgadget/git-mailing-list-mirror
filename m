From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 09/27] commit: use SEQ_DIR instead of hardcoding "sequencer"
Date: Sat,  1 Mar 2014 19:12:45 +0700
Message-ID: <1393675983-3232-10-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 13:21:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJivN-0001zf-PF
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 13:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763AbaCAMVp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 07:21:45 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:44857 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbaCAMVo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 07:21:44 -0500
Received: by mail-pa0-f54.google.com with SMTP id fa1so1904586pad.41
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 04:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4Q3zhNvWzoYS6OabzgA59XVKXnAZOOo0g7cfih+vx7M=;
        b=agHhQP2INw4vQTKVr9MzGKq2F4ZK0Vpj3ax8PrPoKIZ3WNMfdyi5qvlaVKUFemi0gk
         UWErmEfkK78AccTNH02UoQcgv0bTXPZZ43usjtaH+oDtLDBVAViuqHse0PQwpInmQPFV
         oXebLMeywiQY2vEny4a9hF+jeItqkVdYVhyBwcoYWuAIfToTs6PHO7mei6ozKx7yeKA3
         EYX8Z4IyIg6gXjdtgjVOf9UiDhmgrKWDe+jlq5CuXcM9Jwc0aEV/idilevA36FV73/0y
         7FYGWFp58wgWDvM/KW7U1ktx5Lond7QYPYVHx4sYipd7CVvJeRJVkeHBtOGRVbbInE8D
         aIQw==
X-Received: by 10.68.170.66 with SMTP id ak2mr9207580pbc.5.1393676504426;
        Sat, 01 Mar 2014 04:21:44 -0800 (PST)
Received: from lanh ([115.73.238.45])
        by mx.google.com with ESMTPSA id ce15sm37206572pac.0.2014.03.01.04.21.41
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 04:21:43 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 01 Mar 2014 19:22:09 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243074>

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
