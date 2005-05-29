From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: [COGITO PATCH] fix "cg-Xnormid: command not found" error
Date: Sun, 29 May 2005 12:15:45 +0900 (JST)
Organization: USAGI Project
Message-ID: <20050529.121545.77345008.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun May 29 05:11:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcEC6-0001Z6-4X
	for gcvg-git@gmane.org; Sun, 29 May 2005 05:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVE2DMq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 May 2005 23:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVE2DMq
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 23:12:46 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:7945 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261225AbVE2DMn
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2005 23:12:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by yue.st-paulia.net (Postfix) with ESMTP id 45D7433CC2
	for <git@vger.kernel.org>; Sun, 29 May 2005 12:15:46 +0900 (JST)
To: git@vger.kernel.org
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Call cg-Xnormid with ${COGITO_LIB} to fix "cg-Xnormid: command not found"
error.

Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

Index: commit-id
===================================================================
--- c8e987e5e4608c1144293cd3f852210d70b572cb/commit-id  (mode:100755)
+++ uncommitted/commit-id  (mode:100755)
@@ -8,7 +8,7 @@
 . ${COGITO_LIB}cg-Xlib
 
 id="$1"
-normid=$(cg-Xnormid "$id") || exit 1
+normid=$(${COGITO_LIB}cg-Xnormid "$id") || exit 1
 
 if [ "$(git-cat-file -t "$normid")" != "commit" ]; then
 	echo "Invalid commit id: $id" >&2
Index: tree-id
===================================================================
--- c8e987e5e4608c1144293cd3f852210d70b572cb/tree-id  (mode:100755)
+++ uncommitted/tree-id  (mode:100755)
@@ -6,7 +6,7 @@
 # Takes ID of the appropriate commit, defaults to HEAD.
 
 id="$1"
-normid=$(cg-Xnormid "$id") || exit 1
+normid=$(${COGITO_LIB}cg-Xnormid "$id") || exit 1
 type=$(git-cat-file -t "$normid")
 
 if [ "$type" = "commit" ]; then


-- 
YOSHIFUJI Hideaki @ USAGI Project  <yoshfuji@linux-ipv6.org>
GPG-FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
