From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 5/6] merge hook tests: fix missing '&&' in test
Date: Thu,  6 Mar 2014 15:50:23 +0100
Message-ID: <1394117424-29780-6-git-send-email-benoit.pierre@gmail.com>
References: <1394117424-29780-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 15:51:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLZdV-0005NE-La
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 15:51:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbaCFOuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 09:50:55 -0500
Received: from mail-wg0-f47.google.com ([74.125.82.47]:58789 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbaCFOux (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 09:50:53 -0500
Received: by mail-wg0-f47.google.com with SMTP id x12so3217582wgg.18
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 06:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=LYzpEMM5Cq3COAKTrHz2ILtKfrqE3OA39JdnDu7vTHY=;
        b=GtMgoOyq3l9dRsdGIgDLNAMtZVJIM80MXfZt/M/nkouHUcvylB49GtzgwYxsfMbymO
         V3rm2Z0dAnUx8+6gCvr9UeF8HaRatGQuSOSmjW1vQa/wJRfiFLDQw00U8oDAFwghIlFB
         YtFMZBQtvLKm1brc++0yBpbh77RykQzfM6rITyYCmj5Z1oSx6E7cfb4zkhMXEU6fR20q
         SnD6VRQFP/xLu7h+B7ZwJpXHm0ICm4tRzHj63MgLEudeHkqmVEqo83NqRHK/J/8jUd8i
         P+A6flZwg6Q05e2PaTzI9qOmEmORpz3hPSTp7tWe/L3DFYvqbys+xNehvE0UcbMH0RYl
         XxJw==
X-Received: by 10.194.78.16 with SMTP id x16mr10744004wjw.86.1394117443037;
        Thu, 06 Mar 2014 06:50:43 -0800 (PST)
Received: from localhost (109.12.70.86.rev.sfr.net. [86.70.12.109])
        by mx.google.com with ESMTPSA id h9sm18043451wjz.16.2014.03.06.06.50.41
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Mar 2014 06:50:42 -0800 (PST)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394117424-29780-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243518>

Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
---
 t/t7505-prepare-commit-msg-hook.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index ae7b2db..604c06e 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -189,7 +189,7 @@ test_expect_success 'with failing hook (merge)' '
 	git add file &&
 	rm -f "$HOOK" &&
 	git commit -m other &&
-	write_script "$HOOK" <<-EOF
+	write_script "$HOOK" <<-EOF &&
 	exit 1
 	EOF
 	git checkout - &&
-- 
1.9.0
