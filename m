From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: [PATCH] Missing quotes
Date: Thu, 21 Apr 2005 22:45:45 +1000 (EST)
Message-ID: <20050421124545.AEED67F898@smurf.noris.de>
X-From: git-owner@vger.kernel.org Thu Apr 21 14:50:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOb7W-0002ER-Nd
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 14:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVDUMxr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 08:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVDUMxn
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 08:53:43 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:7647 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261342AbVDUMxi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 08:53:38 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1DObBS-0004w6-RO
	for git@vger.kernel.org; Thu, 21 Apr 2005 14:53:37 +0200
Received: (nullmailer pid 1141 invoked by uid 501);
	Thu, 21 Apr 2005 12:53:30 -0000
Received: from [150.203.247.5] (helo=smurf.noris.de)
	by server.smurf.noris.de with esmtp (Exim 4.50)
	id 1DOb6J-0004m1-1M
	for smurf@smurf.noris.de; Thu, 21 Apr 2005 14:48:20 +0200
Received: by smurf.noris.de (Postfix, from userid 501)
	id AEED67F898; Thu, 21 Apr 2005 22:45:45 +1000 (EST)
To: git@vger.kernel.org
X-Smurf-Spam-Score: -0.8 (/)
X-Smurf-Spam-Score: -1.7 (-)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

gitXnormid.sh should quote its cat-file calls so that nonexisting ssha1
IDs don't result in shell errors.

Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>

--- 42a073eb6b5bb397a3e8768a032463a7fa02e6b9/gitXnormid.sh  (mode:100755 sha1:c0d53afabe8662ebfc3c697faf08b0a2b43c93f7)
+++ 265515f9c4f089b1b61e9d2312c4b3babe189618/gitXnormid.sh  (mode:100644 sha1:94710a7a2ab945f1fbd5350cb0de15171ae3f582)
@@ -41,11 +41,11 @@
 	exit 1
 fi
 
-if [ "$type" = "tree" ] && [ $(cat-file -t "$id") = "commit" ]; then
+if [ "$type" = "tree" ] && [ "$(cat-file -t "$id")" = "commit" ]; then
 	id=$(cat-file commit $id | egrep "$TREE" | cut -d ' ' -f 2)
 fi
 
-if [ $(cat-file -t "$id") != "$type" ]; then
+if [ "$(cat-file -t "$id")" != "$type" ]; then
 	echo "Invalid id: $id" >&2
 	exit 1
 fi
