From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: git daemon broken?
Date: Mon, 21 Nov 2005 15:47:33 +0900 (JST)
Organization: USAGI/WIDE Project
Message-ID: <20051121.154733.64482215.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: yoshfuji@linux-ipv6.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 07:48:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ee5SW-0001um-0n
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 07:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbVKUGqy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 01:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbVKUGqy
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 01:46:54 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:60429 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S932167AbVKUGqx
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 01:46:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by yue.st-paulia.net (Postfix) with ESMTP
	id 19EB333CC2; Mon, 21 Nov 2005 15:47:34 +0900 (JST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12425>

Hello.

It seems that git-daemon is broken.

(On server side)
% git daemon --verbose
(On client side)
% git pull git://git.skbuff.net/gitroot/yoshfuji/x.git

Then, we get on the server side,
:
[16660] Request for '/gitroot/yoshfuji/x.git'
fatal: '.': unable to chdir or not a git archive
[16660] Disconnected (with error)

It works if I remove "--strict" from daemon.c.

% git daemon --verbose
:
[16723] Request for '/gitroot/yoshfuji/x.git'
Packing 21 objects
[16723] Disconnected

-- 
YOSHIFUJI Hideaki @ USAGI Project  <yoshfuji@linux-ipv6.org>
GPG-FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
