From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 16/16] add: avoid yoda conditions
Date: Thu, 31 Oct 2013 03:25:47 -0600
Message-ID: <1383211547-9145-17-git-send-email-felipe.contreras@gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:33:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbocy-0008Mw-Fa
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870Ab3JaJdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:33:11 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:39138 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714Ab3JaJdG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:33:06 -0400
Received: by mail-ob0-f178.google.com with SMTP id wm4so2740092obc.37
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MHJEKtgQcdKFJFqTXHJlvKuusWstf1JViHVqcNyhNwo=;
        b=MwAhI0pZeaVbKsXX4kFVqkWFQ5GAwIvZCH/Dp66tTu/wkVB1aSfWe2IXj50kYch5ss
         +SuJfugPcZ1ZD46UqX2VnuNcUgifJ7L4jf2zkLAhzm6qg8MTJpFk6wg+1U8c3/StUNDU
         L/mWsIORuVjRNQWSwF/ezHhyGqPF9PmIsjFLbQLLDDAJEElbzMjPTLVxYCCPOblnyMV6
         e6bWWBlj63B97JRmEc3oUhYZNH7lqBBm9327H4fKTfOW7J2QGNoVMHGGK9j0E4Dd9eqK
         EWX1GbkWZ3YZjlBjQYyuwhdrjHzogh/zLVQrIQHhXyEpWky9IDGBFXBPgKMXV+FPaRfZ
         DHQg==
X-Received: by 10.60.76.72 with SMTP id i8mr1822850oew.11.1383211986430;
        Thu, 31 Oct 2013 02:33:06 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s14sm5430016oeo.1.2013.10.31.02.33.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:33:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237098>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/add.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index 226f758..9b30356 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -429,7 +429,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	argc--;
 	argv++;
 
-	if (0 <= addremove_explicit)
+	if (addremove_explicit >= 0)
 		addremove = addremove_explicit;
 	else if (take_worktree_changes && ADDREMOVE_DEFAULT)
 		addremove = 0; /* "-u" was given but not "-A" */
-- 
1.8.4.2+fc1
