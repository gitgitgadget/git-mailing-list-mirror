From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Quote arguments to tr in test-lib
Date: Sat, 23 Sep 2006 00:35:20 +0200
Message-ID: <20060922223520.3412.15062.stgit@lathund.dewire.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sat Sep 23 00:41:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQtiR-00056f-Fn
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 00:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965234AbWIVWlJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 18:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965247AbWIVWlJ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 18:41:09 -0400
Received: from [83.140.172.130] ([83.140.172.130]:18487 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S965234AbWIVWlF
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Sep 2006 18:41:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id 31464802889
	for <git@vger.kernel.org>; Sat, 23 Sep 2006 00:38:20 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06746-08 for <git@vger.kernel.org>; Sat, 23 Sep 2006 00:38:19 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.2])
	by torino.dewire.com (Postfix) with ESMTP id E105B800199
	for <git@vger.kernel.org>; Sat, 23 Sep 2006 00:38:17 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 8CB1828FBA
	for <git@vger.kernel.org>; Sat, 23 Sep 2006 00:41:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id 302N3pE7Lu8D for <git@vger.kernel.org>;
	Sat, 23 Sep 2006 00:41:08 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id A57CA28F52
	for <git@vger.kernel.org>; Sat, 23 Sep 2006 00:35:20 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: StGIT/0.10
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27535>

From: Robin Rosenberg <robin.rosenberg@dewire.com>

When there are single-character filenames in the test directory,
the shell tries to expand regexps meant for tr.
---

 t/test-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index e262933..e75ad5f 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -34,7 +34,7 @@ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR VISUAL
 
-case $(echo $GIT_TRACE |tr [A-Z] [a-z]) in
+case $(echo $GIT_TRACE |tr "[A-Z]" "[a-z]") in
 	1|2|true)
 		echo "* warning: Some tests will not work if GIT_TRACE" \
 			"is set as to trace on STDERR ! *"
