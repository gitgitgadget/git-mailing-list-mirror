From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: Fix a warning about unused value.
Date: Fri, 25 Nov 2005 19:03:05 +0900 (JST)
Organization: USAGI/WIDE Project
Message-ID: <20051125.190305.106194770.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, yoshfuji@linux-ipv6.org
X-From: git-owner@vger.kernel.org Fri Nov 25 12:03:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfbLr-0003CC-5b
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 12:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbVKYLCo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 06:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbVKYLCo
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 06:02:44 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:528 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1751444AbVKYLCo
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2005 06:02:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by yue.st-paulia.net (Postfix) with ESMTP
	id 411EF33CC2; Fri, 25 Nov 2005 19:03:07 +0900 (JST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12734>

Hello.

Fix a warning:
  git.c:276: warning: value computed is not used

Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

diff --git a/git.c b/git.c
index bdd3f8d..0b10b6e 100644
--- a/git.c
+++ b/git.c
@@ -273,7 +273,7 @@ int main(int argc, char **argv, char **e
 		while (!strncmp(exec_path, "./", 2)) {
 			exec_path += 2;
 			while (*exec_path == '/')
-				*exec_path++;
+				exec_path++;
 		}
 		snprintf(git_command + len, sizeof(git_command) - len,
 			 "/%s", exec_path);

-- 
YOSHIFUJI Hideaki @ USAGI Project  <yoshfuji@linux-ipv6.org>
GPG-FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
