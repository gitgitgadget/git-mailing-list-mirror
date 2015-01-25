From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/21] list-files: add -1 short for --no-column
Date: Sun, 25 Jan 2015 19:37:48 +0700
Message-ID: <1422189476-7518-14-git-send-email-pclouds@gmail.com>
References: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 13:28:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFMIn-00035O-Lg
	for gcvg-git-2@plane.gmane.org; Sun, 25 Jan 2015 13:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630AbbAYM20 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jan 2015 07:28:26 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:59439 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546AbbAYM2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2015 07:28:25 -0500
Received: by mail-pa0-f47.google.com with SMTP id lj1so6474535pab.6
        for <git@vger.kernel.org>; Sun, 25 Jan 2015 04:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KMb6iBrIoBVXHvstOrqteQYTrhOt1wfUP16PHNhLSDc=;
        b=kF+XBqTYOrlJJ3R3FR4rBw0BemQ+vasJtP9Mwt/8jJQrtfWKNdcBbbw6nJe5cD0FOu
         ClMdzEiPMjpwZ3pu1pLsFqtbTTLitApK/SKrPNyyMhSs5x63saqmMszxzD5FTY3/a2MJ
         ZKCuKzeDHD02gr91b02W+23GrCudr0eg3WYlQvJGuJxsex7y2Wea4s9qwfogPDbYJdvL
         x0d0SvmPP47bQLOo/22D4hUWLcXf3zQRaUNR8tkThvYrELnXI+S6NFLiyWyvTVHgKHWD
         2ioUrc3AU8iPpwtcZpsd/l9xvgtpwc6yGUYexgrcBKdRxikZTobaA64/x6qG/WKkj5BM
         FVAA==
X-Received: by 10.70.55.168 with SMTP id t8mr25786671pdp.147.1422188904941;
        Sun, 25 Jan 2015 04:28:24 -0800 (PST)
Received: from lanh ([115.73.204.104])
        by mx.google.com with ESMTPSA id ju5sm7227422pab.42.2015.01.25.04.28.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Jan 2015 04:28:24 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 25 Jan 2015 19:39:43 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263010>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-list-files.txt | 3 +++
 builtin/ls-files.c               | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/git-list-files.txt b/Documentation/git-list-=
files.txt
index 8d285c1..1c0c877 100644
--- a/Documentation/git-list-files.txt
+++ b/Documentation/git-list-files.txt
@@ -50,6 +50,9 @@ OPTIONS
 --recursive::
 	Equivalent of `--max-depth=3D-1` (infinite recursion).
=20
+-1::
+	Equivalent of --no-column.
+
 --color[=3D<when>]::
 --no-color::
 	Color file names. The value must be `always`, `never`, or
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 010291c..a80ac6a 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -603,6 +603,8 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 			N_("show unmerged files")),
 		OPT__COLOR(&use_color, N_("show color")),
 		OPT_COLUMN(0, "column", &colopts, N_("show files in columns")),
+		OPT_SET_INT('1', NULL, &colopts,
+			    N_("shortcut for --no-column"), COL_PARSEOPT),
 		{ OPTION_INTEGER, 0, "max-depth", &max_depth, N_("depth"),
 			N_("descend at most <depth> levels"), PARSE_OPT_NONEG,
 			NULL, 1 },
--=20
2.2.0.84.ge9c7a8a
