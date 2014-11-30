From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/34] commit: use SEQ_DIR instead of hardcoding "sequencer"
Date: Sun, 30 Nov 2014 15:24:35 +0700
Message-ID: <1417335899-27307-11-git-send-email-pclouds@gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:27:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xuzqp-0007qO-N5
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbaK3I1Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:27:16 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:59582 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbaK3I1O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:27:14 -0500
Received: by mail-pd0-f177.google.com with SMTP id ft15so8886997pdb.22
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lc7Ao51Z1VALNpMAnmG8w2uiyikcsQMn3otp5M0zxIs=;
        b=ROvBXfRmJLoMRk5T015LAoJICkAVVOZwStCCJ4l7xkorcrgJdxUpbWWM0RBQpODefC
         KCTFoWyVEvZOSJtvJ0ri4DRByhPaS9nCSHciMBqy6Hy9WTss4pV4vSTLAWfgMbmf2Szw
         hQJJQZUKipycIhztT+EjBcgcd8V2zdZrTdsZ6D26B9G3pnOx14dBwNstgOuGk0BlGf+7
         jlS70WM1btILqTAH8zvoPGNX876gBlm0FbKm+jXryp95lmOaFB9zL3TkxljHwXepVXlb
         6qSHEg8iKsVs6AZZ5rqD3OkekN3dQFWp9UpYhvZOK1GFRg6CGtEyvjvEqKn4m5J3uz1w
         +Jag==
X-Received: by 10.70.92.45 with SMTP id cj13mr15876593pdb.65.1417336033995;
        Sun, 30 Nov 2014 00:27:13 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id v4sm14285066pbs.10.2014.11.30.00.27.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:27:13 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:27:09 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260396>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index e108c53..3f02686 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -170,7 +170,7 @@ static void determine_whence(struct wt_status *s)
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
