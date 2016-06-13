From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 3/8] t0400: use --batch-all-objects to get all objects
Date: Mon, 13 Jun 2016 10:55:41 +0200
Message-ID: <20160613085546.11784-4-chriscool@tuxfamily.org>
References: <20160613085546.11784-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Mike Hommey <mh@glandium.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 10:56:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCNft-0007VH-0V
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 10:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161244AbcFMI4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 04:56:11 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33044 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161007AbcFMI4I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 04:56:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id r5so13086918wmr.0
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 01:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vemTOuykGqa/qQmz59JRxr4bfneotvPsstcWoIdl0JE=;
        b=zYOkG9K8OYw26Sx5aO6rEn4gJBjSgdzqwMAGISQFdhGe7fXocCvivzEdc/SHGEYnQZ
         dAZfXN6ZK2Zz9vWBT5pH9i4Atl9gWvBSNhWixuJWKsM5OMVvji/SBYGjnIMfZ+a2kqMy
         bQy2ubsZ1FFetxf79JBmkJLE711mAST/1nEMq9vRmaGfUhcy3IzHvJexO2v0zmZGUDCf
         VuTiOHHDfKGJNfLYGBnMcZZyYvk7NmwwyjjakB54Y8Ml00MXmSmtjhhWzO582C0gIjeA
         5Bw7reozGKzizk3DwMzBiHGgfjENZ8CPdoQQqzDkUSbi52MoSsVRgLbxdlRmaYk03oPx
         Uf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vemTOuykGqa/qQmz59JRxr4bfneotvPsstcWoIdl0JE=;
        b=bBhWTX1Drg3qYcI5KKHApnjankH4ja+Fd7LlTnnIcQznMnyd7+bR+5brVM/1UdvBQ/
         Fn9Wpda2T4nKjE2+04vOvrfuqPmXg/NPiJz5Yl5HyJSe7/1aoGXdpkpTs1Hl92WklcPR
         wOAHrYioBijVTkMSalOvBXdqAJcCKSFC6wRZE6yPbxPZL+tu8NovYWjG8rG7oZbaS2jT
         2hPGaYwsQ4mzSNyMKH/A86NKY8mBN3aJ0Z0eTX3sDTtZAlyPcXI2ZLpGTT/ULXnDeiBg
         4KwC3xGG07Y3P7GxEByjizzrZAhBASpxDtGkRO4+OmmiR5KlN2TU94zjFthQSNtlXOxX
         us3w==
X-Gm-Message-State: ALyK8tK5WM3zMQ8BtrDybj/S/8deZIP6NdaaXBgSdCDMYombbA45YYBaRBW1/mIT6njIGA==
X-Received: by 10.194.94.165 with SMTP id dd5mr13205311wjb.31.1465808167217;
        Mon, 13 Jun 2016 01:56:07 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id z6sm26342384wjv.41.2016.06.13.01.56.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 01:56:06 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.8.ga2c5126
In-Reply-To: <20160613085546.11784-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297170>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0400-external-odb.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index 2b01617..fe85413 100755
--- a/t/t0400-external-odb.sh
+++ b/t/t0400-external-odb.sh
@@ -10,9 +10,7 @@ write_script odb-helper <<\EOF
 GIT_DIR=$ALT_SOURCE; export GIT_DIR
 case "$1" in
 have)
-	git rev-list --all --objects |
-	cut -d' ' -f1 |
-	git cat-file --batch-check |
+	git cat-file --batch-check --batch-all-objects |
 	awk '{print $1 " " $3 " " $2}'
 	;;
 get)
-- 
2.9.0.rc2.362.g3cd93d0
