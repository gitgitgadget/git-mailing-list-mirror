From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 04/11] tests: at-combinations: increase coverage
Date: Tue,  7 May 2013 16:55:04 -0500
Message-ID: <1367963711-8722-5-git-send-email-felipe.contreras@gmail.com>
References: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 07 23:57:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZpsq-0008Tb-QM
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 23:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831Ab3EGV4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 17:56:52 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:34304 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab3EGV4v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 17:56:51 -0400
Received: by mail-yh0-f53.google.com with SMTP id z12so274320yhz.40
        for <git@vger.kernel.org>; Tue, 07 May 2013 14:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=TMUErBoITxda9OpN/GhmZ2OkjOsJ7BrwTssleckRUvE=;
        b=cBgg1khZqk3qSz/MudsXTp3c0jsqee+ZyW+2M+1sVkYbtfdaTL3+Fr0oMzWhhhsP3g
         7hBd/8yOr6+RHzkAlcYvFci4HOmIKbVPxulo8NzWGyseC9rfHhoq1f94WWQ8bxf1Qt4n
         0ppJloczto2KAD+UL3rBYKATiVvR4spSKHZhMTm6XDMWkAl4NvTsEjDBfu801x3BbeQi
         GSsINLiVGxa9MTJIxzdJq9vuh+maDfKmMZAadq9IAj/gTZpgBirv+2Eg0X9xBf9+1yvz
         To1yKjcj/P5V8gShzOHjYd+XeatlaftqnZreVok8ERz+SgISfJmy+MYPS2tWNPyqmxeD
         /srA==
X-Received: by 10.236.38.67 with SMTP id z43mr3865586yha.68.1367963810581;
        Tue, 07 May 2013 14:56:50 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c18sm33413821yho.13.2013.05.07.14.56.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 May 2013 14:56:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
In-Reply-To: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223609>

From: Ramkumar Ramachandra <artagnon@gmail.com>

Add more tests exercising documented functionality.

[fc: commit message and extra tests]

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t1508-at-combinations.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 2ea735e..58cd1fe 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -42,13 +42,21 @@ test_expect_success 'setup' '
 
 check HEAD ref refs/heads/new-branch
 check "@{1}" commit new-one
+check "HEAD@{1}" commit new-one
+check "@{now}" commit new-two
+check "HEAD@{now}" commit new-two
 check "@{-1}" ref refs/heads/old-branch
+check "@{-1}@{0}" commit old-two
 check "@{-1}@{1}" commit old-one
 check "@{u}" ref refs/heads/upstream-branch
+check "HEAD@{u}" ref refs/heads/upstream-branch
 check "@{u}@{1}" commit upstream-one
 check "@{-1}@{u}" ref refs/heads/master
 check "@{-1}@{u}@{1}" commit master-one
 nonsense "@{u}@{-1}"
+nonsense "@{0}@{0}"
 nonsense "@{1}@{u}"
+nonsense "HEAD@{-1}"
+nonsense "@{-1}@{-1}"
 
 test_done
-- 
1.8.3.rc0.401.g45bba44
