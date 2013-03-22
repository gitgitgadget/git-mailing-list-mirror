From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/3] t5521 (pull-options): use test_commit() where appropriate
Date: Fri, 22 Mar 2013 17:59:58 +0530
Message-ID: <1363955399-13153-3-git-send-email-artagnon@gmail.com>
References: <1363955399-13153-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 22 13:29:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ165-0005Jm-4O
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 13:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192Ab3CVM2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 08:28:55 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36142 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730Ab3CVM2w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 08:28:52 -0400
Received: by mail-pb0-f46.google.com with SMTP id uo15so3034817pbc.33
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 05:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=NBprCjrQym3tFohoPwSxiKDXtmaW/ZvtSPjefRACHnk=;
        b=cFBy5ZT4K0/v1qDKnW2rkFGC5TBQm3Y/p66z0kYwRpfimqY/hhKLnrtc2St4pUlo2A
         qB6xgfo0LDkRsOh4lLtq43552EmHPiBQoxRkg1zeaHwFmHEsMxZfCA+rXqoAqvIg9g/L
         3zNyWsGLZL/JiEkaBO9g8nQIUk6rqb4qD8TNdYhm1Im4gVZrtso9S1OZbwri4i7Arv0u
         re6FuVkYC6UhdAUV+dHMzs8/hULsE/MUMoa0XWvX9/GLettibM7lcgvjEpB2c6P9h3MR
         zx1ewRdRRMtbO4mZcZCpqtFAGH07HwmbIP8dWuMXxRQv4CN6dBXmVur7IMarUaSyqny5
         C6Vg==
X-Received: by 10.68.221.36 with SMTP id qb4mr2387805pbc.66.1363955332446;
        Fri, 22 Mar 2013 05:28:52 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id ve7sm2839591pab.11.2013.03.22.05.28.50
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 05:28:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.141.gad203c2.dirty
In-Reply-To: <1363955399-13153-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218797>

test_commit() is a well-defined function in test-lib-functions.sh that
allows you to create commits with a terse syntax.  Prefer using it
over creating commits by hand.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5521-pull-options.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 1b06691..4a804f0 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -7,8 +7,8 @@ test_description='pull options'
 test_expect_success 'setup' '
 	mkdir parent &&
 	(cd parent && git init &&
-	 echo one >file && git add file &&
-	 git commit -m one)
+	 test_commit "one" file "one"
+	)
 '
 
 test_expect_success 'git pull -q' '
-- 
1.8.2.141.gad203c2.dirty
