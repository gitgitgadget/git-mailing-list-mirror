From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 1/4] git-count-objects.txt: describe each line in -v output
Date: Tue, 12 Feb 2013 16:27:54 +0700
Message-ID: <1360661277-17273-2-git-send-email-pclouds@gmail.com>
References: <1360661277-17273-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 10:27:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5C9a-0001qA-If
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 10:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933020Ab3BLJ1X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Feb 2013 04:27:23 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35030 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933012Ab3BLJ1T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 04:27:19 -0500
Received: by mail-pa0-f42.google.com with SMTP id kq12so3581099pab.1
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 01:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Bf20TpSU0Hj2447q2x+qvHE3XWwE5y1PsvxXIHNd3ck=;
        b=RD/+cze7KsQwCWhqMyK4EaGuGKKsGgbCOuRQg1HfGK2W7tl1uGMiXU6N5DrVMbIplu
         Kb6y8qXXQYPgKYx1A6HoAyZi+9fqyKiR/qosHIKt9GatyKj8xLpA03Pv3AeV3LC7VNb0
         76EjsHqVsFW48Lww0O4bUYAZc3kYnIISiQldgrdf4miA16UZxGk2KGntTaZaXUf4iG7n
         uCoxhbEorf9V333Ji039/vGFxQSRRIiG1gTVnhhSp0+ppAFUT7Jxcunnqzy6a94+VQdc
         FJSLgldfgj6ghkL2WGGisxbH6YAZPrc7x40Av+QN6hVdQIcYJR/zMkkNAVgQikoxf9d0
         DPRQ==
X-Received: by 10.66.146.72 with SMTP id ta8mr7491245pab.24.1360661238858;
        Tue, 12 Feb 2013 01:27:18 -0800 (PST)
Received: from lanh ([115.74.60.127])
        by mx.google.com with ESMTPS id d1sm37053387paz.17.2013.02.12.01.27.15
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 01:27:18 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 12 Feb 2013 16:28:06 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1360661277-17273-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216123>

The current description requires a bit of guessing (what clause
corresponds to what printed line?) and lacks information, such as
the unit of size and size-pack.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-count-objects.txt | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-count-objects.txt b/Documentation/git-co=
unt-objects.txt
index 23c80ce..e816823 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -20,11 +20,21 @@ OPTIONS
 -------
 -v::
 --verbose::
-	In addition to the number of loose objects and disk
-	space consumed, it reports the number of in-pack
-	objects, number of packs, disk space consumed by those packs,
-	and number of objects that can be removed by running
-	`git prune-packed`.
+	Report in more detail:
++
+count: the number of loose objects
++
+size: disk space consumed by loose objects, in KiB
++
+in-pack: the number of in-pack objects
++
+size-pack: disk space consumed by the packs, in KiB
++
+prune-packable: the number of loose objects that are also present in
+the packs. These objects could be pruned using `git prune-packed`.
++
+garbage: the number of files in loose object database that are not
+valid loose objects
=20
 GIT
 ---
--=20
1.8.1.2.536.gf441e6d
