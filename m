From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 p1 13/13] fast-export: fix comparison in tests
Date: Wed, 28 Nov 2012 23:11:09 +0100
Message-ID: <1354140669-23533-14-git-send-email-felipe.contreras@gmail.com>
References: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 23:12:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdpru-0003JU-QD
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 23:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756004Ab2K1WMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 17:12:09 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43342 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932823Ab2K1WMI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 17:12:08 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5972393bkw.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 14:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mlvnku7Em1zUFamqmxWM+jrj9z7gNajQMWs4NnXCsfM=;
        b=cb/qmPlnP1JZbn824AI3yGEOXv0xXJYAY5sT5qaxWLkKYd9NPs29LWx8/mXDZ/wtvV
         MAZoYmBKOToBbdLhih0tUfDuWQbHK3O1PQKMgb2KS3YPt/xo2ocRzxBDtedwR5tkdA3Z
         fSwAttRNu7e0OZsO1xvpJFJak3Pkg7qh5ii+XaHcpJnaYjAjfF+FACOmh/n79c79F+EX
         U+B1RqVXcB0+tCGHiclUQfaviI88PZgn8T7ViJSFqgGQZ0ni1Evkjnt7qN6vy7vb0B0g
         bgKJXGmelIP0pVhHY6F0hbBD5vGhkCtV4DBZjFWAQmCL4pbAdkyBrW3QKRNTq9ppx9Ls
         TQug==
Received: by 10.204.5.202 with SMTP id 10mr5977334bkw.135.1354140727531;
        Wed, 28 Nov 2012 14:12:07 -0800 (PST)
Received: from localhost (ip-109-43-0-26.web.vodafone.de. [109.43.0.26])
        by mx.google.com with ESMTPS id go4sm13830018bkc.15.2012.11.28.14.12.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2012 14:12:06 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1
In-Reply-To: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210792>

First the expected, then the actual, otherwise the diff would be the
opposite of what we want.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9350-fast-export.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 5948b65..1f59862 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -303,7 +303,7 @@ test_expect_success 'dropping tag of filtered out object' '
 (
 	cd limit-by-paths &&
 	git fast-export --tag-of-filtered-object=drop mytag -- there > output &&
-	test_cmp output expected
+	test_cmp expected output
 )
 '
 
@@ -320,7 +320,7 @@ test_expect_success 'rewriting tag of filtered out object' '
 (
 	cd limit-by-paths &&
 	git fast-export --tag-of-filtered-object=rewrite mytag -- there > output &&
-	test_cmp output expected
+	test_cmp expected output
 )
 '
 
@@ -351,7 +351,7 @@ test_expect_failure 'no exact-ref revisions included' '
 	(
 		cd limit-by-paths &&
 		git fast-export master~2..master~1 > output &&
-		test_cmp output expected
+		test_cmp expected output
 	)
 '
 
-- 
1.8.0.1
