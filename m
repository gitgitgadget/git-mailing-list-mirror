From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] dir.c: remove dead function fnmatch_icase()
Date: Fri, 22 Apr 2016 19:25:15 +0700
Message-ID: <1461327916-3575-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 14:25:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ata97-0008N4-Be
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 14:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324AbcDVMZL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 08:25:11 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33787 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbcDVMZK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 08:25:10 -0400
Received: by mail-pf0-f195.google.com with SMTP id e190so9851221pfe.0
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 05:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NVylIvLpwzxHVnSfCLQct3zNXq/OJBS9r9P2dGgHlVQ=;
        b=dbW6PGvfUHA7Uqga1Mb8IG98aQnWmKpyP97IvH7vr24vyqKLApKz0CCC2vSxH7kBGY
         /xAI/bq63WMKFTyOl2Yx5ppg4UUjHs1oMxBkKS00yF9q0/Qz3idOSpZF+7FNFbtjuUvC
         ZfLQ3j6SW8AT8x8kVilcpD8+CNDQgXZZoP0Z+yqHMo47H0SIPiJQab+MKUbBybf1XilS
         42nF63Www3AVtxiGocn7fhyx4/fsUP65GF6ILZ5HZK3f35MsOP4+U9vIkIKxDFk4wSMk
         /HqLI/xFdUcdqFFkEbFP4u/cz4n8UeSS0frdn5CjzVo2sBZXdqAjc6P4lOa7dqHVR13i
         Tamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NVylIvLpwzxHVnSfCLQct3zNXq/OJBS9r9P2dGgHlVQ=;
        b=YrVuCn0TpBnudGUFoAfRBhGe+qasQc3SMes3Oom/x7zXU9dMB22trQJJzwVLX5xHty
         Pcf2qiNnYkKv3yTApyocU7TAiR02KyWxrVyib+1X0SSZKHG1SFTlCYCRp+f6Dx8xn1CZ
         UQnAnQh8tJiORQ5bkk1TI4dG2MiTXQR/2dKLd2vCEI/9t0UpaN9F9QDxJ6n6M4Q/WNPp
         bHmUE7tl89fJ1Wx5Ypi92V3kkpahT22jjRdtWUt3gDH4RYQg2staWdc67mSVI8ofOhlK
         lj/UT5N5mwZgYBWIHcKBBZsNPU7L+iVRBynumm6+1J92+BXmrv6R3YxhIlDCqNY7Se8R
         aQVA==
X-Gm-Message-State: AOPr4FV/m4gzX+K5UestxavFiMkWQN+hwlaovWhGksvoEXqto0jeSwTMSia0psbuOl8XXw==
X-Received: by 10.98.67.143 with SMTP id l15mr19574025pfi.114.1461327909050;
        Fri, 22 Apr 2016 05:25:09 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id t8sm9415667paw.16.2016.04.22.05.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2016 05:25:07 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 22 Apr 2016 19:25:23 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292187>

It was largely replaced by fnmatch_icase_mem() and its last use was in
84b8b5d (remove match_pathspec() in favor of match_pathspec_depth() -
2013-07-14).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 7 -------
 dir.h | 1 -
 2 files changed, 8 deletions(-)

diff --git a/dir.c b/dir.c
index 996653b..656f272 100644
--- a/dir.c
+++ b/dir.c
@@ -64,13 +64,6 @@ int strncmp_icase(const char *a, const char *b, size=
_t count)
 	return ignore_case ? strncasecmp(a, b, count) : strncmp(a, b, count);
 }
=20
-int fnmatch_icase(const char *pattern, const char *string, int flags)
-{
-	return wildmatch(pattern, string,
-			 flags | (ignore_case ? WM_CASEFOLD : 0),
-			 NULL);
-}
-
 int git_fnmatch(const struct pathspec_item *item,
 		const char *pattern, const char *string,
 		int prefix)
diff --git a/dir.h b/dir.h
index 301b737..d56d2fb 100644
--- a/dir.h
+++ b/dir.h
@@ -272,7 +272,6 @@ extern int remove_path(const char *path);
=20
 extern int strcmp_icase(const char *a, const char *b);
 extern int strncmp_icase(const char *a, const char *b, size_t count);
-extern int fnmatch_icase(const char *pattern, const char *string, int =
flags);
=20
 /*
  * The prefix part of pattern must not contains wildcards.
--=20
2.8.0.rc0.210.gd302cd2
