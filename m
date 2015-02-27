From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] grep: correct help string for --exclude-standard
Date: Fri, 27 Feb 2015 21:01:58 +0700
Message-ID: <1425045718-30696-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 27 15:01:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRLUA-0006XM-1r
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 15:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbbB0OBh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2015 09:01:37 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35892 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbbB0OBg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2015 09:01:36 -0500
Received: by pdjp10 with SMTP id p10so21300825pdj.3
        for <git@vger.kernel.org>; Fri, 27 Feb 2015 06:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=/mDrD0lStA3b6/dFP9raW1gv3tKxlfeJmhbY1b+ibos=;
        b=iay6SZxwW1zY9cwzVaQDJqFeU7/lILujXf6B0PMsfKt3HkqrDWRdGiFJNYj+/6ChI1
         kfhsF2scx4getTDrusaalc4zAhIV/ImKmFbpiczkqpwR5fmP14OK8RfGNppdyFesqfwE
         fcyZM9lzqog25VR5PI+3D87+ity/VkwOSpI6/S5RRYDI/FrQL6Qx5TU1tFJIFWVZgrJV
         hj5MtB+Qc7yqlqSLae0kMBIRRRuGRKT1+UFUCjaI/UlSM9K+SbTV7FDxNh+QyuGCAK7I
         hPZuryv1ReiHJpinYFonI014n7YolUbqPH7b8daivNbZCJlfJz8Vfc35o9RjF6vVo1JR
         AOtQ==
X-Received: by 10.70.28.99 with SMTP id a3mr23903175pdh.81.1425045695691;
        Fri, 27 Feb 2015 06:01:35 -0800 (PST)
Received: from lanh ([115.73.203.245])
        by mx.google.com with ESMTPSA id s4sm4096783pdc.61.2015.02.27.06.01.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Feb 2015 06:01:34 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 27 Feb 2015 21:02:02 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264497>

The current help string is about --no-exclude-standard. But "git grep -=
h"
would show --exclude-standard instead. Flip the string. See 0a93fb8
(grep: teach --untracked and --exclude-standard options - 2011-09-27)
for more info about these options.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 4063882..e77f7cf 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -641,7 +641,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 		OPT_BOOL(0, "untracked", &untracked,
 			N_("search in both tracked and untracked files")),
 		OPT_SET_INT(0, "exclude-standard", &opt_exclude,
-			    N_("search also in ignored files"), 1),
+			    N_("ignore files specified via '.gitignore'"), 1),
 		OPT_GROUP(""),
 		OPT_BOOL('v', "invert-match", &opt.invert,
 			N_("show non-matching lines")),
--=20
2.3.0.rc1.137.g477eb31
