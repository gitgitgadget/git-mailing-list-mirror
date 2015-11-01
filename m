From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 2/9] read-cache.c: fix constness of verify_hdr()
Date: Sun,  1 Nov 2015 14:42:42 +0100
Message-ID: <1446385369-8669-3-git-send-email-pclouds@gmail.com>
References: <1446385369-8669-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 14:43:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zssv3-0008FE-3u
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 14:43:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbbKANne convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Nov 2015 08:43:34 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33783 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbbKANnb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 08:43:31 -0500
Received: by wijp11 with SMTP id p11so36571411wij.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 05:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fp17tDwgBpyemA7+If/vSTv2FHQLaODhcEPEwrQYoVM=;
        b=nVP+qD0gxM+z/BSULl7fmyA8SqAUGkbjRvSBlQnDlo4nBfLMpEwTXzdmcNllA/K6/e
         P8kvX/MtYd8O1y7+p3aX0bNLwaZZEQqry5eJQf3WOQkFuoR7p0Oe+A/3sqOUWZaLd5qk
         4cKX1UKa9ElHJCGVbjnzePMWtOjgCUPywKQ0YaQv+5v9awUaQdLFqsRTJ/JXDZKiVMSF
         MHCwr5Ou2zpQzn1dHsYZY98ph66uRDocdq6FHwieatekoKfJD1WZnK62O6UTMI3gYct5
         T+7oFkMOeKkkRH3G27vlGZPl+ZDjJstfndISb7D5UvSCvNzGwbABhQnVtcmxbiDhRuUW
         GwqQ==
X-Received: by 10.194.209.175 with SMTP id mn15mr18548124wjc.22.1446385409969;
        Sun, 01 Nov 2015 05:43:29 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.homenet.telecomitalia.it (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id gd10sm17058028wjb.47.2015.11.01.05.43.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Nov 2015 05:43:28 -0800 (PST)
X-Mailer: git-send-email 2.2.0.513.g477eb31
In-Reply-To: <1446385369-8669-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280619>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 84616c8..a76c789 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1345,7 +1345,7 @@ struct ondisk_cache_entry_extended {
 			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
 			    ondisk_cache_entry_size(ce_namelen(ce)))
=20
-static int verify_hdr(struct cache_header *hdr, unsigned long size)
+static int verify_hdr(const struct cache_header *hdr, unsigned long si=
ze)
 {
 	git_SHA_CTX c;
 	unsigned char sha1[20];
--=20
2.2.0.513.g477eb31
