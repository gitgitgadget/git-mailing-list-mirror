From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: Re: [ANNOUNCE] GIT 1.0.7
Date: Sat, 07 Jan 2006 02:16:14 -0600 (CST)
Organization: USAGI/WIDE Project
Message-ID: <20060107.021614.94523887.yoshfuji@linux-ipv6.org>
References: <7vhd8go71t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, yoshfuji@linux-ipv6.org
X-From: git-owner@vger.kernel.org Sat Jan 07 09:15:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev9Ei-0003zk-Od
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 09:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbWAGIPi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 03:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWAGIPi
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 03:15:38 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:23052 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1030353AbWAGIPh
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 03:15:37 -0500
Received: from localhost (localhost [127.0.0.1])
	by yue.st-paulia.net (Postfix) with ESMTP
	id C52F333CC2; Sat,  7 Jan 2006 17:16:19 +0900 (JST)
To: junkio@cox.net
In-Reply-To: <7vhd8go71t.fsf@assigned-by-dhcp.cox.net>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14240>

In article <7vhd8go71t.fsf@assigned-by-dhcp.cox.net> (at Fri, 06 Jan 2006 23:01:34 -0800), Junio C Hamano <junkio@cox.net> says:

> GIT 1.0.7 is available at http://www.kernel.org/pub/software/scm/git/

Allow compilation w/ gcc 2.95.4.
(Or, it is okay to replace path[] with path[0].)

Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

diff --git a/describe.c b/describe.c
index 84d96b5..3688c4a 100644
--- a/describe.c
+++ b/describe.c
@@ -17,8 +17,8 @@ static int abbrev = DEFAULT_ABBREV;
 static int names = 0, allocs = 0;
 static struct commit_name {
 	const struct commit *commit;
+	char *path;
 	int prio; /* annotated tag = 2, tag = 1, head = 0 */
-	char path[];
 } **name_array = NULL;
 
 static struct commit_name *match(struct commit *cmit)
@@ -43,6 +43,7 @@ static void add_to_known_names(const cha
 	struct commit_name *name = xmalloc(sizeof(struct commit_name) + len);
 
 	name->commit = commit;
+	name->path = sizeof(*name);
 	name->prio = prio; 
 	memcpy(name->path, path, len);
 	idx = names;

-- 
YOSHIFUJI Hideaki @ USAGI Project  <yoshfuji@linux-ipv6.org>
GPG-FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
