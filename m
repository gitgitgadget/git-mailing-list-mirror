From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/3] ls-tree: disable negative pathspec because it's not supported
Date: Sun,  9 Nov 2014 15:58:38 +0700
Message-ID: <1415523519-28789-2-git-send-email-pclouds@gmail.com>
References: <1415444432-18596-1-git-send-email-pclouds@gmail.com>
 <1415523519-28789-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 09 09:58:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnOKU-00049D-Q1
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 09:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbaKII6d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Nov 2014 03:58:33 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:55186 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbaKII6c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 03:58:32 -0500
Received: by mail-pd0-f175.google.com with SMTP id y13so5957066pdi.20
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 00:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Kfvai8pTKtfIOQ2h8AXdpD86+UB488fb8/vITZpofhM=;
        b=qBmYg60SzFSoT1Qqgt2GQJinevW1+tNIulXFa3Iq8ay1cK3LsQBO65Dy2e9T4IdO1a
         WnOG5uB24y2ezBy5BteWA2RZp6oOxHsKHD0AoJXgrzAJgyEG8NnApYajiWcU16FxvXkt
         +C5WhIX6gO+aEiVADvo0GhrN4mBZRsiWE/boDTdf2rgzQUwvP2b6aR88cG5iKX/oGMdr
         EYoG18dAYJhv2Cq102jnD+jhtR1VLMHPUAIPB15r/o6MCYbSg0bf9l2JswnMURnRD35h
         baOTer7eyKzkpjntNCL1+O1CkFk33NPq4GjDCozEaJFsM9esrpmowhdBEg9tIT0cLRWr
         wE4w==
X-Received: by 10.66.65.130 with SMTP id x2mr24363035pas.85.1415523511857;
        Sun, 09 Nov 2014 00:58:31 -0800 (PST)
Received: from lanh ([115.73.197.54])
        by mx.google.com with ESMTPSA id n2sm13391863pdg.2.2014.11.09.00.58.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Nov 2014 00:58:31 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Nov 2014 15:58:45 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1415523519-28789-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 1ab0381..d226344 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -174,7 +174,8 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
 	 * cannot be lifted until it is converted to use
 	 * match_pathspec() or tree_entry_interesting()
 	 */
-	parse_pathspec(&pathspec, PATHSPEC_GLOB | PATHSPEC_ICASE,
+	parse_pathspec(&pathspec, PATHSPEC_GLOB | PATHSPEC_ICASE |
+				  PATHSPEC_EXCLUDE,
 		       PATHSPEC_PREFER_CWD,
 		       prefix, argv + 1);
 	for (i =3D 0; i < pathspec.nr; i++)
--=20
2.1.0.rc0.78.gc0d8480
