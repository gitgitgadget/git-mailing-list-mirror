From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] t5000: silence unzip availability check
Date: Sat, 09 Jun 2007 08:31:12 +0200
Message-ID: <466A4930.2020602@lsrfire.ath.cx>
References: <alpine.LFD.0.98.0706050908520.23741@woody.linux-foundation.org> <Pine.LNX.4.64.0706051819290.4046@racer.site> <Pine.LNX.4.64.0706061956540.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 08:31:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwuTw-0005fx-J8
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 08:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbXFIGbZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 02:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbXFIGbZ
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 02:31:25 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:34472
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750967AbXFIGbY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jun 2007 02:31:24 -0400
Received: from [10.0.1.201] (p508E537F.dip.t-dialin.net [80.142.83.127])
	by neapel230.server4you.de (Postfix) with ESMTP id B18773B001;
	Sat,  9 Jun 2007 08:31:22 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
In-Reply-To: <Pine.LNX.4.64.0706061956540.4046@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49558>

unzip -v on (at least) Ubuntu prints a screenful of version info
to stdout.  Get rid of it since we only want to know if unzip is
installed or not.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 5500505..a6c5bf6 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -108,7 +108,7 @@ test_expect_success \
     'git-archive --format=zip' \
     'git-archive --format=zip HEAD >d.zip'
 
-$UNZIP -v 2>/dev/null
+$UNZIP -v >/dev/null 2>&1
 if [ $? -eq 127 ]; then
 	echo "Skipping ZIP tests, because unzip was not found"
 	test_done
