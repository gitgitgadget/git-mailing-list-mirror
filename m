From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 2/8] Fix typo in test
Date: Sat, 28 Jul 2012 02:47:46 -0700
Message-ID: <1343468872-72133-3-git-send-email-schwern@pobox.com>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 28 11:48:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv3dj-0005Ib-7X
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 11:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069Ab2G1JsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 05:48:19 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57120 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752Ab2G1JsG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 05:48:06 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so6503035pbb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 02:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=8z4wqdFMRHzdrAgkrGWCZRPklUVuneVH9wdrcjxeBjE=;
        b=FL+o6HRGpdUeAcOcP2bsStv56v8fgnBtFZRssZpICEdOCy096gqWmdQrrf4OaC3SpC
         aU3BwRq2LNHUMUrJMw3ZWCxIznjVnEhZ/uYBKK9MbVAxobmHzekSOh9nrx2lSLfdbOTi
         UEGr9G9ovhevGyp23TS78ZW1O3+4+wsb7VvBaXgiUMVrREvLTUlYWyhS7OwD44xWw5VE
         Ysi5ka4hiw9R6n2B+DlmVyrr/osB3ZUNOAiTz1FatzXBMNIHIoIxYnbID5lzmhGmEjlp
         oOsM4TVX6MGAZrkNjiLXJZqM35altJWJimqVtzqixWE0LDxB9pjS+0DlyiT9W+ea6NOB
         NuVQ==
Received: by 10.66.86.2 with SMTP id l2mr11123305paz.58.1343468885964;
        Sat, 28 Jul 2012 02:48:05 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id nv6sm3692274pbc.42.2012.07.28.02.48.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 02:48:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1343468872-72133-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202420>

From: "Michael G. Schwern" <schwern@pobox.com>

Test to check that the migration got rid of the old style git-svn directory.
It wasn't failing, just throwing a message to STDERR.
---
 t/t9107-git-svn-migrate.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index 289fc31..cfb4453 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -32,7 +32,7 @@ test_expect_success 'initialize old-style (v0) git svn layout' '
 	echo "$svnrepo" > "$GIT_DIR"/git-svn/info/url &&
 	echo "$svnrepo" > "$GIT_DIR"/svn/info/url &&
 	git svn migrate &&
-	! test -d "$GIT_DIR"/git svn &&
+	! test -d "$GIT_DIR"/git-svn &&
 	git rev-parse --verify refs/${remotes_git_svn}^0 &&
 	git rev-parse --verify refs/remotes/svn^0 &&
 	test "$(git config --get svn-remote.svn.url)" = "$svnrepo" &&
-- 
1.7.11.3
