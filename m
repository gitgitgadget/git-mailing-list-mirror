From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] git-count-objects.txt: describe each line in -v output
Date: Mon,  4 Feb 2013 19:49:04 +0700
Message-ID: <1359982145-10792-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 13:48:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2LTg-0003ne-GQ
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 13:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754552Ab3BDMsa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Feb 2013 07:48:30 -0500
Received: from mail-da0-f41.google.com ([209.85.210.41]:41712 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433Ab3BDMs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 07:48:29 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so2649442dak.14
        for <git@vger.kernel.org>; Mon, 04 Feb 2013 04:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Bf20TpSU0Hj2447q2x+qvHE3XWwE5y1PsvxXIHNd3ck=;
        b=ZjUmyg8/neefaAxFQQVLiHUM6kl2DPjUN8KghGq51VMMzIeD2kbNTjmmFuo5QoaoIb
         cQRzvFW2nQ0N842CIn5a/lS/UHPag0O+dE9EaALTaPNG+6AQ9N3U20pN5SBYo+v5cm7/
         qthhTCDy21ooGV/8VjmPL/yjPy9xSrjGrOLRp0Y4iPwVEIqlAv1GLtOELoZFHEwaoRSo
         BFaZYnBHyNJjNThOIWHp5hBaEsu+Qk4xm5DGhHtYoSIeDE5Z9mff3v0qOIJM0cHqJVgS
         oPOLzlj21Eq7q8l9Aku1OV52m4X4ch7vth9LyyPxsqNMoIwkAdM0lVo0hJkfX8OVwOmJ
         455w==
X-Received: by 10.66.84.3 with SMTP id u3mr52430959pay.51.1359982109039;
        Mon, 04 Feb 2013 04:48:29 -0800 (PST)
Received: from lanh ([115.74.36.51])
        by mx.google.com with ESMTPS id t7sm17595898pax.17.2013.02.04.04.48.25
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Feb 2013 04:48:27 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 04 Feb 2013 19:49:06 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215378>

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
