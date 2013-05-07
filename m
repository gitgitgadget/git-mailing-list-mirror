From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 07/11] sha1_name: remove unnecessary braces
Date: Tue,  7 May 2013 16:55:07 -0500
Message-ID: <1367963711-8722-8-git-send-email-felipe.contreras@gmail.com>
References: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 07 23:57:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZpss-0008Tb-KB
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 23:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973Ab3EGV5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 17:57:04 -0400
Received: from mail-gg0-f181.google.com ([209.85.161.181]:43507 "EHLO
	mail-gg0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab3EGV5B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 17:57:01 -0400
Received: by mail-gg0-f181.google.com with SMTP id q1so242196ggm.26
        for <git@vger.kernel.org>; Tue, 07 May 2013 14:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=riNQPux5DcCxtyfX1QxS+ePv0HtvqCmKi/bY5rgw5RA=;
        b=un2UJpmOQpqAHIWGN6XVpDfj7+mtCYbihtCCpVmAT29Zn+6/GfvktXR45d4Zsvhskz
         4ayd4D73a2M0uB9pf+tl9rsrKQ++wuz7SP2eh+1UP3djL3fhI/Gv/ymVYHy9sqOVLbbf
         BE51KB+af5gN/LRQAWnjaIbRq90fJ4NcPUx4Z/ifIpNU1YjhCZSJx1jHiPcupqfftK7f
         ygdOeO2D47FcD5NWugDqqgzQvd81audd+CKAF0yowUpgKuAv1aIOMTDtwu0WP0IUYW43
         QIc74L2XuGTs634IUKRpjYkyxfT/tza5PoWgAv2ypqkLJs9c0AOqxu6c0vQAIPCYACKe
         C6lw==
X-Received: by 10.236.222.130 with SMTP id t2mr3720196yhp.165.1367963821262;
        Tue, 07 May 2013 14:57:01 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id p31sm58386557yhm.10.2013.05.07.14.56.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 May 2013 14:57:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
In-Reply-To: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223613>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sha1_name.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 01e49a9..6530ddd 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -465,12 +465,11 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		int ret;
 		/* try the @{-N} syntax for n-th checkout */
 		ret = interpret_branch_name(str, &buf);
-		if (ret > 0) {
+		if (ret > 0)
 			/* substitute this branch name and restart */
 			return get_sha1_1(buf.buf, buf.len, sha1, 0);
-		} else if (ret == 0) {
+		else if (ret == 0)
 			return -1;
-		}
 		/* allow "@{...}" to mean the current branch reflog */
 		refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);
 	} else if (reflog_len)
-- 
1.8.3.rc0.401.g45bba44
