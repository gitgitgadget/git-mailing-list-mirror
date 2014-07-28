From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 2/9] read-cache.c: fix constness of verify_hdr()
Date: Mon, 28 Jul 2014 19:03:08 +0700
Message-ID: <1406548995-28549-3-git-send-email-pclouds@gmail.com>
References: <1406548995-28549-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 14:04:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBjeu-0002tx-J5
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 14:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbaG1MD7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2014 08:03:59 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:55532 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbaG1MD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 08:03:59 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa1so10424817pad.13
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 05:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Tt9Yg21Y05ujJGdK/dmaWI28pdJ03Bwa5c4hEk+SGos=;
        b=HOMc43iGzl//GkHL6sk/pLD+ScPZbPevXhNV8y4Dln960owa6INKcxlAAF7dv04Bud
         7OEoo3MsZ/Ri2GrUutf7FsdSqYHGARadQkTC48pnkTn4/onx5ShE9oMTPNSEypaEoouJ
         46FkwnLUIbkcFOwoucU0tCek3REpP0T3FOPMGu3D0RC7fDIBKsmWEQ/RGxS6X4j/7lIM
         td5qAqmzaAMAnDRRILxn4CxJcXLOQuaqcVyPqq4VLpes8UeTi5ai3Zcgn3wpeNC6NO3c
         kWTU6KcKg8JfOD6FJ5/s21RMt1RBO/8jJkLQyueMM36UKmnQaLj2PwBtAirViVzYqQT8
         gmcw==
X-Received: by 10.68.179.66 with SMTP id de2mr3504533pbc.31.1406549038561;
        Mon, 28 Jul 2014 05:03:58 -0700 (PDT)
Received: from lanh ([115.73.211.176])
        by mx.google.com with ESMTPSA id gy2sm17468042pbb.50.2014.07.28.05.03.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jul 2014 05:03:57 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Jul 2014 19:04:00 +0700
X-Mailer: git-send-email 2.1.0.rc0.66.gb9187ad
In-Reply-To: <1406548995-28549-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254316>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 5d3c8bd..949270b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1324,7 +1324,7 @@ struct ondisk_cache_entry_extended {
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
2.1.0.rc0.66.gb9187ad
