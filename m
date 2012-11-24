From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 p1.1 07/14] remote-testgit: remove irrelevant test
Date: Sat, 24 Nov 2012 04:17:07 +0100
Message-ID: <1353727034-24698-8-git-send-email-felipe.contreras@gmail.com>
References: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 04:18:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6Fx-0001zJ-8c
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614Ab2KXDRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:17:53 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61989 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932594Ab2KXDRw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:17:52 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4063027bkw.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uzxRx6go4E364q48BLZxvvU6PnJDcGWDf/Uyr2cOrX8=;
        b=pb465wAR00M0v8Wo19szQ7pcxHn0vrCMYI9scJZ3x39uuIpkennN0pcme7n6JY5MwT
         cW61dhyjNTtOY+XdYY7A9EDfYJi3r+6Bz2rjAlmRuA8VWtNaHqvMKONQ/47vfLJhyXuU
         P4az4ed2DOA3+0gdK4IQj2M0OotLUnq4t8JgalshUZTQf3rRCaHpUJQmF0jcvNaGqAW2
         qgn6hicFl/+/VyehAe3ZWLZ4+HABa1jqxe2AttlLruMc0W12xtF6AaYCv1VxeV2rbh7F
         OctE/93Ym8urjWKRPNKCNLEPsp+aiutoaQSVwZKDafzTubBLlZ/9GkSeM5c3JrvqiaOj
         uFAQ==
Received: by 10.204.6.21 with SMTP id 21mr1752323bkx.77.1353727071883;
        Fri, 23 Nov 2012 19:17:51 -0800 (PST)
Received: from localhost (ip-109-43-0-90.web.vodafone.de. [109.43.0.90])
        by mx.google.com with ESMTPS id k3sm5468314bku.13.2012.11.23.19.17.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 19:17:51 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210288>

This was only to cover a bug that was fixed in remote-testpy not to
resurface.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
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
1.8.0
