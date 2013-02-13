From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 1/4] git-count-objects.txt: describe each line in -v output
Date: Wed, 13 Feb 2013 16:13:16 +0700
Message-ID: <1360746799-3668-2-git-send-email-pclouds@gmail.com>
References: <7va9r9igze.fsf@alter.siamese.dyndns.org>
 <1360746799-3668-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 10:13:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5YOs-0004bd-5Z
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 10:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973Ab3BMJMp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2013 04:12:45 -0500
Received: from mail-da0-f50.google.com ([209.85.210.50]:59479 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635Ab3BMJMm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 04:12:42 -0500
Received: by mail-da0-f50.google.com with SMTP id h15so465790dan.23
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 01:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Bf20TpSU0Hj2447q2x+qvHE3XWwE5y1PsvxXIHNd3ck=;
        b=BdWXA+aVeTpdwtqfXJcVmTeKZ5u3SNsrRlkJkPobIR0pSJzvjDVqY4Fv1DiVTIde5M
         zw9KhTJHoQ10ciaKQ4CcpbzZAUG2VIYgiUcA/vdwPPkjldsxdZj0jtWCxL0YbOEG/Fde
         hOtOw3fCQV/KqCsf3sU03aGv2Iw+5xsMHZSVrlyYMKq0aHKU4ymauf2T8ZMH79d+PH+p
         gIdk7EXpHKxL4qrgX8N7Jjpr51rhBbySfoNt4m8IfnQTB2QlnrUnkbAOjUvU/htXgKal
         8edU2juf2v3M/Wv1l/U8t0UkJ5KPCvHERpzBuSlOk6ZMC/FAT99qNjLwYc34dt+c1ClA
         MbvQ==
X-Received: by 10.66.73.165 with SMTP id m5mr61838267pav.78.1360746761941;
        Wed, 13 Feb 2013 01:12:41 -0800 (PST)
Received: from lanh ([115.74.60.127])
        by mx.google.com with ESMTPS id k7sm68616696paz.13.2013.02.13.01.12.38
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 01:12:40 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Feb 2013 16:13:27 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1360746799-3668-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216240>

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
