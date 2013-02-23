From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/2] update-index: list supported idx versions and their features
Date: Sat, 23 Feb 2013 08:54:28 +0700
Message-ID: <1361584468-11820-1-git-send-email-pclouds@gmail.com>
References: <1361534964-4232-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 02:54:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U94JO-0000Yl-DU
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 02:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757541Ab3BWBxh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2013 20:53:37 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:54231 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254Ab3BWBxg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 20:53:36 -0500
Received: by mail-pb0-f50.google.com with SMTP id up1so705109pbc.9
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 17:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=fbwbIjURXnN3Sva9s2L+UhgDzDOkSd6hKrrBsmRCpbg=;
        b=HtLssq/ze5wlhrpggduyhtcW5yc+lV7YZqLeAfSViKMknQ/VdITqNDwp3azxcqEIAp
         F+jj1Zf48q32+8257L+ePM5UnI1sHmMXUz5l1pA2UgysAY0qQoWWo77VNwV56UPQ1+5G
         rAA/kFRsI5Wp/VAaI7oTnlSeRczspr5aeCJyr0jkHJGAFdFtnGRNCAR2qnaplx6mpAQk
         CygVB5Caix9c7iz7BiK87JqFOKi27y2DNMqKf24fGjDrbjBHPqDlUN9HA9O8eMCR3P5p
         FwJFESAeljRRwU+Or+BsfzaWrllzthrHN9eu5avXlUqQG+mCrGsTPSb8NMyujzRKz0kY
         C9Dg==
X-Received: by 10.66.227.137 with SMTP id sa9mr7264712pac.17.1361584416347;
        Fri, 22 Feb 2013 17:53:36 -0800 (PST)
Received: from lanh ([115.74.55.130])
        by mx.google.com with ESMTPS id hu2sm4264745pbc.38.2013.02.22.17.53.32
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Feb 2013 17:53:35 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 23 Feb 2013 08:54:31 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1361534964-4232-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216887>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .. and the user should know (briefly) the differences between index
 versions too.

 Documentation/git-update-index.txt | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-upd=
ate-index.txt
index 77a912d..e5aaba5 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -145,7 +145,15 @@ you will need to handle the situation manually.
=20
 --index-version <n>::
 	Write the resulting index out in the named on-disk format version.
-	The current default version is 2.
+	Supported versions are 2, 3 and 4. The current default version is 2
+	or 3, depending on whether extra features are used, such as
+	`git add -N`.
++
+	Version 4 performs a simple pathname compression that could
+	reduce index size by 30%-50% on large repositories, which
+	results in faster load time. Version 4 is relatively young
+	(first released in 1.8.0 in October 2012). Other Git
+	implementations may not support it yet.
=20
 -z::
 	Only meaningful with `--stdin` or `--index-info`; paths are
--=20
1.8.1.2.536.gf441e6d
