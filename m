From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 41/41] wrapper.c: use warning_errno()
Date: Sun,  1 May 2016 18:14:57 +0700
Message-ID: <1462101297-8610-42-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:19:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpOv-0008RH-LN
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbcEALS6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:18:58 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33518 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbcEALS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:18:57 -0400
Received: by mail-pf0-f195.google.com with SMTP id e190so18858314pfe.0
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7zGjjoMd5v+yqCY0NwfAPvmNf/zgFDVyxhJglKTYk1Q=;
        b=XuTxGZcWunVpE68AJwKQuP8EwZnUDX1R6gPTkDbRTIdoRup3nyHoNSSZwur2sMy010
         vc3RrAFPmFmGza1n+wcOqYCCjo8C+S5KxENUDLtFJGHp+zlhmGTPJoZIaO3dMD7CkrOq
         VQAiEdURDu8rCQqOuwdmEquZ4meO/pt1A/4VSCHVhvXqVsA71mrnLu0ncTEJQD7B22QO
         6SnKMA9UAi3uWE3wWXGoBxbwq1Vn+zgbiroMFig5sBND8ZRdkHL9qDsmpNxAxDoU2GOJ
         dBgF7MZV8vaIos0yb3wB8r0CvdouSGJDyLE10ZVODaCdSPMPVJdY9y0pjQW4HsBZla0d
         uAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zGjjoMd5v+yqCY0NwfAPvmNf/zgFDVyxhJglKTYk1Q=;
        b=W6iZyqyCCJ2ewE54E9nEsLI24RFI4Hl6kmt8zQZw5C1m/P8Sl9L3x3huaPke7lDR+3
         TcEbtR5QmE5czt0ER8rUcg+sKyrO1VF4FphXAbu9yi+v0deuFRY4dtaVxuBtOEzkrgLh
         PcWfOJH2alwMiyU5B5mmzen+4RYsUS4T5gvtDckYAlEcxVeSbTZ+B5RfxkK2hayc67Ph
         rKmex0Ci9ToOV40bswYx7Dp+MxKdGyVVmPG3fJLqklO/ME9uUF8aHns6f0JkntCXVRKu
         Do4OOBiPuB+GbpL2KEn+SYnjxSCnY2TXF0B4po1Zxw4/xyMqcLOUUxdSok8gTDK6Q0Yh
         NqsQ==
X-Gm-Message-State: AOPr4FWCAvV5GBDOPc4FzWvXHy4Ni5w9un05By2YdAonWPAV6F1RTuir7b9PMpCtMvSLHQ==
X-Received: by 10.98.5.196 with SMTP id 187mr23853047pff.103.1462101536682;
        Sun, 01 May 2016 04:18:56 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id 1sm38929244pah.7.2016.05.01.04.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:18:55 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:18:52 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293191>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wrapper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index 9afc1a0..3df2fe0 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -572,7 +572,7 @@ static int warn_if_unremovable(const char *op, cons=
t char *file, int rc)
 	if (!rc || errno =3D=3D ENOENT)
 		return 0;
 	err =3D errno;
-	warning("unable to %s %s: %s", op, file, strerror(errno));
+	warning_errno("unable to %s %s", op, file);
 	errno =3D err;
 	return rc;
 }
@@ -608,7 +608,7 @@ int remove_or_warn(unsigned int mode, const char *f=
ile)
=20
 void warn_on_inaccessible(const char *path)
 {
-	warning(_("unable to access '%s': %s"), path, strerror(errno));
+	warning_errno(_("unable to access '%s'"), path);
 }
=20
 static int access_error_is_ok(int err, unsigned flag)
--=20
2.8.0.rc0.210.gd302cd2
