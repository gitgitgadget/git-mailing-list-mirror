From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 10/31] commit: use SEQ_DIR instead of hardcoding "sequencer"
Date: Sun, 13 Jul 2014 11:50:47 +0700
Message-ID: <1405227068-25506-11-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 06:54:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6BnZ-0008HZ-LS
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 06:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbaGMEyB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2014 00:54:01 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:49415 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbaGMEyA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 00:54:00 -0400
Received: by mail-pa0-f44.google.com with SMTP id rd3so3619284pab.3
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 21:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XsSph0BqX7WgFnuZC5ySvPsBToquI/1nOmwdy0tqc74=;
        b=O/pR/db9mOP5/RzReVV356j/ZYyA7VWRSUyuO1eu04tL70rvsfnXIuUZhoAuglL6oL
         QkSjSMDFcNv1Yz/mFPAmUx933it06hWhugcShg9ocnl62YdSwqY/vCxMa+RbX+ybJSWO
         DxlUANdLAV2WYSv+SAyfSnY7d0owxcUe2nAo4a/mH72uBJwZyINTnVk5UR9x77f32SG2
         YrSqeNl31qxcGiR9Q5Lrp3Tqy2dluPZqEjYDY5nYxihWcvSNcMWDjFnuEYzXvdgPjvOh
         eyK04LyXod7dpZG1A7mVSbZuDTjWNtzRsP7+xXWQcAl6mur5QAHWs+wkuTUNmiANtHS0
         jPGg==
X-Received: by 10.70.35.207 with SMTP id k15mr9132980pdj.46.1405227239987;
        Sat, 12 Jul 2014 21:53:59 -0700 (PDT)
Received: from lanh ([115.73.227.1])
        by mx.google.com with ESMTPSA id fm8sm28978356pab.28.2014.07.12.21.53.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jul 2014 21:53:59 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jul 2014 11:54:00 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253413>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
1.9.1.346.ga2b5940
