From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 12/18] list-files: add -1 short for --no-column
Date: Sun, 30 Mar 2014 20:56:03 +0700
Message-ID: <1396187769-30863-13-git-send-email-pclouds@gmail.com>
References: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
 <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 15:56:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUGEJ-0003Hd-0c
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 15:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbaC3N4v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2014 09:56:51 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:65240 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbaC3N4u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 09:56:50 -0400
Received: by mail-pd0-f172.google.com with SMTP id p10so6871334pdj.3
        for <git@vger.kernel.org>; Sun, 30 Mar 2014 06:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=H8ZB4U02RLzek/Kij1a0YOY7s1SAmXxmwArQpHW3d30=;
        b=UPCZqFeP9ahdp9W9f2u64Dcwe3l54EdLSKcDSw/z88P4oGaO5aDI+2Q5q/Z/6moUX8
         YiX/DcDWKHLX8B3U9hb/+RJTLPBFtTtoiWkg0FYGYtpVBdfGQql6o/evPikN0VW76wR4
         W/ac3qXu5uXa3aHF5zDLIfs5RaY30M8EcCnoYo1nIo6uZXP3QC4WudF6MImkVn26ZO4M
         UbXeNXsj7LwOPsKeMowHbrUef1cP0bPGkFj2WRKxcmCSzcoej8pB+JdwBa5tOH1CZKOk
         Ls3gV/4UsmFkh3yFo17xSxk5Vs7IwV4otDXe/iqdI43acUN76faAhurlGSUk+W12iuDF
         X19g==
X-Received: by 10.68.0.35 with SMTP id 3mr19455363pbb.52.1396187810224;
        Sun, 30 Mar 2014 06:56:50 -0700 (PDT)
Received: from lanh ([115.73.202.240])
        by mx.google.com with ESMTPSA id gu11sm37331129pbd.74.2014.03.30.06.56.47
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 30 Mar 2014 06:56:49 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Mar 2014 20:57:47 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245476>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-list-files.txt | 3 +++
 builtin/ls-files.c               | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/git-list-files.txt b/Documentation/git-list-=
files.txt
index 5dccbbc..725a236 100644
--- a/Documentation/git-list-files.txt
+++ b/Documentation/git-list-files.txt
@@ -49,6 +49,9 @@ OPTIONS
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
index 656b632..db0ee6b 100644
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
1.9.1.345.ga1a145c
