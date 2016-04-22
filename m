From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] wrapper.c: delete dead function git_mkstemps()
Date: Fri, 22 Apr 2016 19:25:16 +0700
Message-ID: <1461327916-3575-2-git-send-email-pclouds@gmail.com>
References: <1461327916-3575-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 14:25:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ata9K-0008SK-71
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 14:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbcDVMZS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 08:25:18 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34660 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbcDVMZP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 08:25:15 -0400
Received: by mail-pf0-f195.google.com with SMTP id 145so2442026pfz.1
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 05:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ljvP88MYhlN6YwWIB7LdJ1zX5/kxgMuaVY/vIK4cC2I=;
        b=gHwmtQweyiR+JjneymIHXMb+wgDHIas7oCrBdvljpFCJVBwbVYb5BL5So0ET2C4KCa
         /WfQwX1R9g4saEI+AlMCDFm1LUMwvjkjq4Sth8U/01+C7LozzZCFA5NQK9rFDpMenc6s
         RrdjotdmA7YyJMDcyQuXMBDESzMZn3b3taRObSNegR4P0lxWYmqSPWkZlty0fqPNfrLi
         JI6E8rVK8sSj5O6d5Tq8m3s/O15owrRBDiqOYumZwXH6egFS2Y43MtF3LgXuNv/OpTIa
         uJdnOayvtex6iCG+DAnXR/C06xcy6o63qvYcVJU8dRFShI2PTdashl/SpfA3sL7mjOFH
         quLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ljvP88MYhlN6YwWIB7LdJ1zX5/kxgMuaVY/vIK4cC2I=;
        b=f+3tW6neSIKJZ2y0ZrV9TMcfNgvVfTq8VzS2W7d2lmTMSx5en4kszyrCD93HN8t7rQ
         9wk4mHO9MP5MywsQkXbYYEKhf8mDfCCFnUBo2Io/Kr5kwGdkJ5SiEMjl2qoSeSpZVRJM
         bf7sMshqloXFmPvwN2L323C/y8mzlkEsIs0f8Hck/hKtUuzHb53E+DYsJzbSYnsEYOS7
         /IWlJfejcMQwppaGydFAq1T5PCZdDQXTc+Jp9Nh1U9qqFgXLMpbyyL1csVpHvcjqrxK9
         cOmNPgZma34Tu6uGwND7qvhURwNORckFn6pXR4FMj0SIfN40yxnzTvFbJ7i9IFMW4Bn/
         vMNA==
X-Gm-Message-State: AOPr4FV9nG2Eo4GrY6o9nCiOcjfgM/CbB7aeBzL53bNizejDS+m66WE2ZGvqcn3R3jJv4A==
X-Received: by 10.98.66.146 with SMTP id h18mr27829399pfd.27.1461327914722;
        Fri, 22 Apr 2016 05:25:14 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id w125sm8256563pfb.16.2016.04.22.05.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2016 05:25:13 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 22 Apr 2016 19:25:29 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1461327916-3575-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292188>

Its last call site was replaced by mks_tempfile_ts() in 284098f (diff:
use tempfile module - 2015-08-12) and there's a good chance
mks_tempfile_ts will continue to successfully handle this job. Delete
it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h   |  2 --
 wrapper.c | 17 -----------------
 2 files changed, 19 deletions(-)

diff --git a/cache.h b/cache.h
index 2711048..fd728f0 100644
--- a/cache.h
+++ b/cache.h
@@ -958,8 +958,6 @@ static inline int is_empty_blob_sha1(const unsigned=
 char *sha1)
=20
 int git_mkstemp(char *path, size_t n, const char *template);
=20
-int git_mkstemps(char *path, size_t n, const char *template, int suffi=
x_len);
-
 /* set default permissions by passing mode arguments to open(2) */
 int git_mkstemps_mode(char *pattern, int suffix_len, int mode);
 int git_mkstemp_mode(char *pattern, int mode);
diff --git a/wrapper.c b/wrapper.c
index 9afc1a0..9009f8b 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -446,23 +446,6 @@ int git_mkstemp(char *path, size_t len, const char=
 *template)
 	return mkstemp(path);
 }
=20
-/* git_mkstemps() - create tmp file with suffix honoring TMPDIR variab=
le. */
-int git_mkstemps(char *path, size_t len, const char *template, int suf=
fix_len)
-{
-	const char *tmp;
-	size_t n;
-
-	tmp =3D getenv("TMPDIR");
-	if (!tmp)
-		tmp =3D "/tmp";
-	n =3D snprintf(path, len, "%s/%s", tmp, template);
-	if (len <=3D n) {
-		errno =3D ENAMETOOLONG;
-		return -1;
-	}
-	return mkstemps(path, suffix_len);
-}
-
 /* Adapted from libiberty's mkstemp.c. */
=20
 #undef TMP_MAX
--=20
2.8.0.rc0.210.gd302cd2
