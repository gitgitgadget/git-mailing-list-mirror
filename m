From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH v7 5/9] t/test-lib.sh: Export also GIT_BUILD_DIR in
	test_external
Date: Thu, 23 Dec 2010 00:56:39 +0100
Message-ID: <20101222235639.7998.10673.stgit@localhost.localdomain>
References: <20101222234843.7998.87068.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog9@eaglescrag.net>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 23 00:57:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVYYc-0007iE-Ez
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 00:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910Ab0LVX5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 18:57:17 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59129 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab0LVX5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 18:57:16 -0500
Received: by mail-bw0-f46.google.com with SMTP id 15so7007506bwz.19
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 15:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=DNiZh6B/T75w/5dlGZm18BCIoPwySE3+ML/s5yjQH3Y=;
        b=bzoI0zhborCMqfRj0WIOA/E5m1YVprD1BuEyZDhFEYPGiWmyoMq7B4XvKEvY5Qpx82
         W5FJ9mjQ3qsNAx+zHiTZCflUCjdSgB2B7YU1fqtqnIjKfa05RrYHkR3l/CeMWIaYlGhe
         l1VVOFfqJC94HkfOtVdrjtf4PHMJf5ApYgD8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=bLSPtfIlkqaVralOzjlrnaHYjFSGKo3MZsbto5aMvaRJEz0YFy4XpF/7k02b6lXaWM
         l7XYk+55kwB6+Yo08O1gfAjM1O3RX3liaG8RZIEIe3jZ8Y1MQiY9tkNlN77bQFZ+U+EE
         4SuLB4BmeLBkj5zjheHnv52dinyD9FSN80dUs=
Received: by 10.204.23.14 with SMTP id p14mr6519925bkb.175.1293062236177;
        Wed, 22 Dec 2010 15:57:16 -0800 (PST)
Received: from localhost.localdomain (abvw91.neoplus.adsl.tpnet.pl [83.8.220.91])
        by mx.google.com with ESMTPS id v1sm5321584bkt.17.2010.12.22.15.57.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Dec 2010 15:57:15 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBMNudjZ008152;
	Thu, 23 Dec 2010 00:56:49 +0100
In-Reply-To: <20101222234843.7998.87068.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164106>



This way we can use it in test scripts written in other languages
(e.g. in Perl), and not rely on "$TEST_DIRECTORY/.."

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

 t/test-lib.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/t/test-lib.sh b/t/test-lib.sh
index 48fa516..c077fa4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -552,9 +552,9 @@ test_external () {
 		# Announce the script to reduce confusion about the
 		# test output that follows.
 		say_color "" "# run $test_count: $descr ($*)"
-		# Export TEST_DIRECTORY, TRASH_DIRECTORY and GIT_TEST_LONG
+		# Export TEST_DIRECTORY, GIT_BUILD_DIR, TRASH_DIRECTORY and GIT_TEST_LONG
 		# to be able to use them in script
-		export TEST_DIRECTORY TRASH_DIRECTORY GIT_TEST_LONG
+		export TEST_DIRECTORY GIT_BUILD_DIR TRASH_DIRECTORY GIT_TEST_LONG
 		# Run command; redirect its stderr to &4 as in
 		# test_run_, but keep its stdout on our stdout even in
 		# non-verbose mode.
