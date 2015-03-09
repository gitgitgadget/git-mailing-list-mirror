From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/16] list-files: make :(glob) pathspec default
Date: Mon,  9 Mar 2015 17:18:20 +0700
Message-ID: <1425896314-10941-3-git-send-email-pclouds@gmail.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 11:19:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUumE-0001VP-I3
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 11:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbbCIKTG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2015 06:19:06 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:41512 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbbCIKTD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 06:19:03 -0400
Received: by pdjy10 with SMTP id y10so24148279pdj.8
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 03:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=1TUNCEb9y0OPsjFiDaJSf3ycInIUOIaFTadYVykkodE=;
        b=QZGlmnW8HXal/m9CUcc70kWGp9pnxMFGwgowh/tMNKPkpcERreKucet/15hG4u/GCd
         l4rJK+UE6xQyXRe6IRiGrOcrGc8K0FV5HXAvgClTcHHhv3CEwGh+FBPT/mV/Dnpxuxq5
         NTEQ8b5++HaX65vU1WssrDg3A0Qt5Ar8oEEpbtUn0vEr8ECoeeb0ko5Y/bU58zKMVlub
         9O2h+yVROAgrVwLKYH5EIpfVrmJpZ1YuDPB9bw06YpljfLJTu4/q9OwuH0ZG2Vq5uyo8
         BSlqAGXkTE7I4TjLkqaMSg/fcXkoqh8lPNjFXTWoPho+1QRuEQkDA4k9TOxcCbq8Z2k+
         Y4DQ==
X-Received: by 10.66.181.144 with SMTP id dw16mr53170470pac.100.1425896342974;
        Mon, 09 Mar 2015 03:19:02 -0700 (PDT)
Received: from lanh ([115.73.245.123])
        by mx.google.com with ESMTPSA id fk15sm2521818pdb.19.2015.03.09.03.18.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 03:19:02 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Mar 2015 17:18:58 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265144>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index ac33f13..b99f2b7 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -65,6 +65,8 @@ int cmd_list_files(int argc, const char **argv, const=
 char *cmd_prefix)
 {
 	struct string_list result =3D STRING_LIST_INIT_NODUP;
=20
+	setenv(GIT_GLOB_PATHSPECS_ENVIRONMENT, "1", 0);
+
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(ls_usage, ls_options);
=20
--=20
2.3.0.rc1.137.g477eb31
