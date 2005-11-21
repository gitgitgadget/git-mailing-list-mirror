From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: [PATCH] GIT: fix compilation error in pack-redundant.c
Date: Mon, 21 Nov 2005 14:09:58 +0900 (JST)
Organization: USAGI/WIDE Project
Message-ID: <20051121.140958.91408363.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, yoshfuji@linux-ipv6.org
X-From: git-owner@vger.kernel.org Mon Nov 21 06:10:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ee3vy-0004yH-E2
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 06:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbVKUFJV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 00:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbVKUFJV
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 00:09:21 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:56845 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S932180AbVKUFJV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 00:09:21 -0500
Received: from localhost (localhost [127.0.0.1])
	by yue.st-paulia.net (Postfix) with ESMTP
	id 71B8533CC2; Mon, 21 Nov 2005 14:09:58 +0900 (JST)
To: junkio@cox.net
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12422>

Hello.

Fix compilation error in pack-redundant.c.

Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

diff --git a/pack-redundant.c b/pack-redundant.c
index fb6cb48..954dc55 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -376,11 +376,11 @@ size_t sizeof_union(struct packed_git *p
 size_t get_pack_redundancy(struct pack_list *pl)
 {
 	struct pack_list *subset;
+	size_t ret = 0;
 
 	if (pl == NULL)
 		return 0;
 
-	size_t ret = 0;
 	while ((subset = pl->next)) {
 		while(subset) {
 			ret += sizeof_union(pl->pack, subset->pack);

-- 
YOSHIFUJI Hideaki @ USAGI Project  <yoshfuji@linux-ipv6.org>
GPG-FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
