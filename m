From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/3] git-count-objects.txt: describe each line in -v output
Date: Fri,  8 Feb 2013 10:48:25 +0700
Message-ID: <1360295307-5469-2-git-send-email-pclouds@gmail.com>
References: <1359982145-10792-1-git-send-email-pclouds@gmail.com>
 <1360295307-5469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 04:51:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3ezh-0001O6-08
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 04:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759691Ab3BHDu5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Feb 2013 22:50:57 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:54481 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759144Ab3BHDu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 22:50:56 -0500
Received: by mail-pa0-f42.google.com with SMTP id kq12so1828087pab.1
        for <git@vger.kernel.org>; Thu, 07 Feb 2013 19:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=DgTyiU8Ym8zksv9a8TwRENFN3rgjQWCrLIh1lSYDe7w=;
        b=ioyAx5IgNCnfQWT/WhXoZfC55xZ8q7uxm3hxZ37Lw9SnBC/oPCK0HAs8u6lVf4b53U
         88VLziE39xZOrW4pCZQLJUa2mU8e803TkUmQO3LU+WMzdYPRFo2bbrI+9cLjWiNk75xW
         Nypq+FRxp0TIaDx12rHZBusEYg4HYO1p5xnYSkMPbv0ukoLk72VN+Wc8LmE/4Y2HVkM3
         FmD87oIu9UySsVneJCKCqylKt2J5UMct/YefzK61hrOdrdd2bCpbTAyMGDbFS46+J9IH
         T/bpuKM5L8ACbJW4K+5zQer0CQzFWJs2FPdgQHvUKVvuAZR22upYfrNNhovUv7i8zdNu
         kSRw==
X-Received: by 10.66.72.233 with SMTP id g9mr12768563pav.29.1360295456066;
        Thu, 07 Feb 2013 19:50:56 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id d1sm50879278pav.6.2013.02.07.19.50.52
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 07 Feb 2013 19:50:55 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 08 Feb 2013 10:50:49 +0700
X-Mailer: git-send-email 1.8.1.2.495.g3fdf5d5.dirty
In-Reply-To: <1360295307-5469-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215745>

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
1.8.1.2.495.g3fdf5d5.dirty
