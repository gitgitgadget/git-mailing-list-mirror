From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 26/41] gpg-interface.c: use error_errno()
Date: Sun,  1 May 2016 18:14:42 +0700
Message-ID: <1462101297-8610-27-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:17:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpNd-0007ji-6c
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbcEALRh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:17:37 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33236 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbcEALRg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:17:36 -0400
Received: by mail-pf0-f195.google.com with SMTP id e190so18856804pfe.0
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z0LxuSCppRXjmPrqdmtGSKkSmFbTboXw2fK+aByx6rE=;
        b=sBQOqnP+P5TWR6Cxse243nhUQjvxXv4VyCoqBwrNjP+gYztFrtzxxu7SpwPQF56LJw
         +MU7Rfy0+0hHQILCscgihac6jMAbMTEmpf/HvTrFA3coNbx8LFmOLscENtJeVQe05N9G
         oI0Ql++5UoLuuqZxh1V+KZf94gkapIOwarNZzXuoFfxKUFUKVLf48HQXYJDChX9OA7eW
         7RXnqcFF/AxMXcXN2HHz6nOObZBqffsmDCwWy0x+DfRkhjSfGXvzuXJmBA57Iw9pcM7R
         FgniM7BACGCdhKAVPGA3HBMPlFPEq/13KBmF2f7b2Jdv6qUVsBAUYanV3Dv+czq+T3Is
         N74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z0LxuSCppRXjmPrqdmtGSKkSmFbTboXw2fK+aByx6rE=;
        b=emVl4s5m1COvfu6UV1tgHg0JT0Zeo//3otwHeHl6Uh1cOYtHGX9IoEkb4jZYZC60Cp
         Z0ctXXUkiBIHd02HAkPIwi/mXIK6COJYGE1kl5WIiG8ZeQ9Y+bnoRi1N0bhmZwZaJFBZ
         rj33v95X1h7s8vHAFjBLx+5rcoCby55Slslv9u1mVaSKrzDJFiCCprc0TS8uCXmaeL7c
         GOyXMHBVhrGx7Sg/gqCdrLu5R0kr+TPoryfQKFLGkV0eTSagmiAiXkqBY4EHX2ISRBcx
         rp8zStpMi39zct2t9tgYXAQh9MHS8N9Sy1k8Dx7iUI9AEQi0MMV0BYquPa6meNxkOoLF
         6QHg==
X-Gm-Message-State: AOPr4FUMDcwHXrdruiY0SvB+V/GEXUsHz/t3pESUeb6fjYyf02CTasgoavFQK6q0zWIbyg==
X-Received: by 10.98.39.2 with SMTP id n2mr43411353pfn.145.1462101456242;
        Sun, 01 May 2016 04:17:36 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id v126sm35767765pfv.92.2016.05.01.04.17.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:17:35 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:17:31 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293176>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 gpg-interface.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 2259938..c4b1e8c 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -219,11 +219,9 @@ int verify_signed_buffer(const char *payload, size=
_t payload_size,
 	args_gpg[0] =3D gpg_program;
 	fd =3D git_mkstemp(path, PATH_MAX, ".git_vtag_tmpXXXXXX");
 	if (fd < 0)
-		return error(_("could not create temporary file '%s': %s"),
-			     path, strerror(errno));
+		return error_errno(_("could not create temporary file '%s'"), path);
 	if (write_in_full(fd, signature, signature_size) < 0)
-		return error(_("failed writing detached signature to '%s': %s"),
-			     path, strerror(errno));
+		return error_errno(_("failed writing detached signature to '%s'"), p=
ath);
 	close(fd);
=20
 	gpg.argv =3D args_gpg;
--=20
2.8.0.rc0.210.gd302cd2
