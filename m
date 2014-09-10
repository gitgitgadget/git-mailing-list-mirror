From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 10/32] commit: use SEQ_DIR instead of hardcoding "sequencer"
Date: Thu, 11 Sep 2014 05:41:46 +0700
Message-ID: <1410388928-32265-11-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 00:43:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRqbN-0001Wq-IP
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 00:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150AbaIJWm5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2014 18:42:57 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33806 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbaIJWm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 18:42:57 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so4263146pdj.22
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 15:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=x2c4irClMlzAgUwTpMsg9Jk/+g2grjJsOdtYv17M8U4=;
        b=z2U0H6G0ItOH8evPgZv9EXGxrTQsOIli9yVtEMjoXvIkqrVg8fTgqtNnLKXi34zDX9
         9CnHz3KR+oOfPpQM2oLqbqpYQHdYrNahXo2ncFJOOLVbPH5D332fAnMKBjJMN0cjO8wh
         bHAgopDH313AotPMQqZJonzAMz81WL3IbuRBNfUofXDQ8iJ81qRckr4HgFpoZykB1wUA
         Dlsg1xBA9/J2sEI+IS63LiWdehGSPxXE1NSeTT19k3m9Lo/AmUVxbdjNlOr37C6xiRXO
         7jVJeH9moutMPu86h8dlExdPmrUUb1UC0TXrIArE0weihjMib4d4rALMmjqDnW6JO9JH
         l4qg==
X-Received: by 10.70.96.200 with SMTP id du8mr52373655pdb.117.1410388976666;
        Wed, 10 Sep 2014 15:42:56 -0700 (PDT)
Received: from lanh ([115.73.197.210])
        by mx.google.com with ESMTPSA id fn1sm15577358pdb.88.2014.09.10.15.42.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Sep 2014 15:42:56 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 11 Sep 2014 05:43:16 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256787>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 461c3b1..4b9f012 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -156,7 +156,7 @@ static void determine_whence(struct wt_status *s)
 		whence =3D FROM_MERGE;
 	else if (file_exists(git_path("CHERRY_PICK_HEAD"))) {
 		whence =3D FROM_CHERRY_PICK;
-		if (file_exists(git_path("sequencer")))
+		if (file_exists(git_path(SEQ_DIR)))
 			sequencer_in_use =3D 1;
 	}
 	else
--=20
2.1.0.rc0.78.gc0d8480
