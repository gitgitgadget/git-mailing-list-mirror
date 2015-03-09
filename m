From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/16] list-files: new indicator '&' for submodules when -F is used
Date: Mon,  9 Mar 2015 17:18:28 +0700
Message-ID: <1425896314-10941-11-git-send-email-pclouds@gmail.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 11:20:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUun3-0002K4-8k
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 11:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbbCIKT4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2015 06:19:56 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35614 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146AbbCIKTy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 06:19:54 -0400
Received: by pabli10 with SMTP id li10so71736552pab.2
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 03:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KQ8eJDncdtOgzP+omYN9uA2f8XLiuh4ZsBSLXY9ga0k=;
        b=vT6BavefpHlUsOJVktiMMGUXY8DWsj5dXgyTsqvkFiomGo5F7Uii7wRJmdk+fbgM6t
         9Qro//0z4B+itc5mo1tVmGWTVmHdWtVU1/5/MAKsP/Fgjn3w3Csi0OYOLFxe7gaKaw8k
         LvN0RJsm5AXOQ5u7jYIt0wz40ffmwoIThT+gfGSCnJ2M8IcZRzydj/LcrnSKrUbYKcVh
         IuAoPvKSrWIH7kg0R8TdwgjhOAYdFpS4zpClanDj8gA+v/hwXPIKiDTi2ShvCSuQiCOY
         kuoImQNv4lRpLDwNiFFE7n5U0E9RINt/HeliWbHVcBN2pgZ5mhUeLuFCmwjv6azB7HRc
         gPzQ==
X-Received: by 10.66.235.36 with SMTP id uj4mr52106452pac.123.1425896393533;
        Mon, 09 Mar 2015 03:19:53 -0700 (PDT)
Received: from lanh ([115.73.245.123])
        by mx.google.com with ESMTPSA id ff10sm18568439pad.1.2015.03.09.03.19.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 03:19:52 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Mar 2015 17:19:49 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265150>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index 97fa8bf..eb51e7a 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -51,6 +51,8 @@ static void append_indicator(struct strbuf *sb, mode_=
t mode)
 		c =3D '|';
 	else if (S_ISSOCK(mode))
 		c =3D '=3D';
+	else if (S_ISGITLINK(mode))
+		c =3D '&';
 #ifdef S_ISDOOR
 	else if (S_ISDOOR(mode))
 		c =3D '>';
--=20
2.3.0.rc1.137.g477eb31
