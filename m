From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: [PATCH]Fix cg-export to not specify excess argument to compressor
Date: Mon, 26 Dec 2005 17:20:09 +0300
Message-ID: <200512261720.10136.snake@penza-gsm.ru>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_aw/rDvEipRR2Xg+"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 26 15:20:30 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqtD6-0007We-6j
	for gcvg-git@gmane.org; Mon, 26 Dec 2005 15:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVLZOUP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Dec 2005 09:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbVLZOUP
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Dec 2005 09:20:15 -0500
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:8328 "HELO
	penza-gsm.ru") by vger.kernel.org with SMTP id S1750758AbVLZOUO
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Dec 2005 09:20:14 -0500
Received: (qmail 18085 invoked from network); 26 Dec 2005 14:20:12 -0000
Received: from unknown (HELO snake) (192.168.0.20)
  by fileserver.penza-gsm.ru with SMTP; 26 Dec 2005 14:20:11 -0000
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.7.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on fileserver
X-Spam-Level: 
X-Spam-Status: No, score=-102.8 required=5.0 tests=ALL_TRUSTED,AWL,
	USER_IN_WHITELIST autolearn=unavailable version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14053>

--Boundary-00=_aw/rDvEipRR2Xg+
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

When gzip or bzip2 provided with empty string as argument
they failing to use stdin as the source of data.

-- 
Respectfully
Alexey Nezhdanov

--Boundary-00=_aw/rDvEipRR2Xg+
Content-Type: text/x-diff;
  charset="us-ascii";
  name="cg-export.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cg-export.patch"

--- /home/snake/scm/cogito/cg-export	2005-12-26 17:14:49.000000000 +0300
+++ cg-export	2005-12-26 17:16:17.000000000 +0300
@@ -44,10 +44,10 @@
 		base="${base##*/}"
 		case "$ext" in
 		.tar.gz|.tgz)
-			git-tar-tree "$id" "$base" | gzip -c9 "$tar" >"$dest"
+			git-tar-tree "$id" "$base" | gzip -c9 >"$dest"
 			;;
 		.tar.bz2)
-			git-tar-tree "$id" "$base" | bzip2 -c "$tar" >"$dest"
+			git-tar-tree "$id" "$base" | bzip2 -c >"$dest"
 			;;
 		.tar)
 			git-tar-tree "$id" "$base" >"$dest"

--Boundary-00=_aw/rDvEipRR2Xg+--
