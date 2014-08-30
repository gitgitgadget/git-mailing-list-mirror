From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/32] commit: use SEQ_DIR instead of hardcoding "sequencer"
Date: Sat, 30 Aug 2014 15:33:40 +0700
Message-ID: <1409387642-24492-11-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 10:34:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNe7c-0001p5-MF
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 10:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbaH3Iev convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 04:34:51 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:32956 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbaH3Ieu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 04:34:50 -0400
Received: by mail-pa0-f44.google.com with SMTP id rd3so8183554pab.31
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 01:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=x2c4irClMlzAgUwTpMsg9Jk/+g2grjJsOdtYv17M8U4=;
        b=sfzesANfu52VEM2Eq1hsaVJiVb/GUCH/EqhjwXQ2P2fJkuyC8eHMKOX07CoAk9kZ0l
         fcgCUzi5FXdl5dA8dAN7918Ls2w4ZcMn0a8n0SQHTbLo9eut3QJ48i/00cS+uiE25Qig
         638C1PayubQdYqAuS/64oYZanhLa0u4QrYE7zlKnEg1jpVopmjY5nSn+HZdj/MAWk+3h
         uszsIoHUFIkwgUZ21OnjSE/UGV5Utl547O/PTig3sN8cl+Y7hAbfMLCfJYKZA7puP25a
         nO1kGCM/I93AKPiTIaj+M3rwt8o478IEFURx6myNiqyF91NaVMe2WT89Hla2K3L/xPEe
         tqlg==
X-Received: by 10.70.0.201 with SMTP id 9mr22512751pdg.43.1409387689142;
        Sat, 30 Aug 2014 01:34:49 -0700 (PDT)
Received: from lanh ([115.73.195.142])
        by mx.google.com with ESMTPSA id ou6sm2045994pbb.88.2014.08.30.01.34.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 01:34:48 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Aug 2014 15:34:58 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256220>

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
