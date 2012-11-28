From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 p1 07/13] remote-testgit: remove irrelevant test
Date: Wed, 28 Nov 2012 23:11:03 +0100
Message-ID: <1354140669-23533-8-git-send-email-felipe.contreras@gmail.com>
References: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 23:12:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdprr-0003JU-KE
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 23:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932804Ab2K1WLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 17:11:51 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43342 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932790Ab2K1WLs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 17:11:48 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5972393bkw.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 14:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2LODFmIFa+fiF/HUXK6loI5ouaUSScBTcVs+GPZOG6w=;
        b=qqtuKn2Tcfu/xRVQDSZmfLdnYPF15hIzRYMa20j5kCVtXKPjLS3sG7rcAS5wbH+AKQ
         XTxq2ltalMSLrzjQ+54lrMiHaLOAL5QUis4YWgF8LPJ5hA1h/RJYstPD+aRde9dGt22Q
         DRDdfz4Q3uzRNAGaWHcjf47apOOadGlDl/TRxp6SDhFZQfwLpCkWwcv1iuzpwJ7gvwkD
         x5CdWjOLtOvw0Ghf1QFkLQT8tNSFXe8JbcfS8gpBCt/OEyXvc2gdvqRsc0Rhk0OXs60f
         G2E59JTssDbq6ruAGVyPZq99V0I83KpTFPqgjFLD658M2K8BOFZiEupm8wYvHFOsX63U
         Irew==
Received: by 10.204.9.11 with SMTP id j11mr6116201bkj.53.1354140707582;
        Wed, 28 Nov 2012 14:11:47 -0800 (PST)
Received: from localhost (ip-109-43-0-26.web.vodafone.de. [109.43.0.26])
        by mx.google.com with ESMTPS id v8sm13782792bku.6.2012.11.28.14.11.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2012 14:11:46 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1
In-Reply-To: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210795>

This was only to cover a bug that was fixed in remote-testpy not to
resurface.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5801-remote-helpers.sh | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 2f7fc10..6801529 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -53,19 +53,6 @@ test_expect_success 'pushing to local repo' '
 	compare_refs localclone HEAD server HEAD
 '
 
-# Generally, skip this test.  It demonstrates a now-fixed race in
-# git-remote-testgit, but is too slow to leave in for general use.
-: test_expect_success 'racily pushing to local repo' '
-	test_when_finished "rm -rf server2 localclone2" &&
-	cp -R server server2 &&
-	git clone "testgit::${PWD}/server2" localclone2 &&
-	(cd localclone2 &&
-	echo content >>file &&
-	git commit -a -m three &&
-	GIT_REMOTE_TESTGIT_SLEEPY=2 git push) &&
-	compare_refs localclone2 HEAD server2 HEAD
-'
-
 test_expect_success 'fetch new branch' '
 	(cd public &&
 	 git checkout -b new &&
-- 
1.8.0.1
