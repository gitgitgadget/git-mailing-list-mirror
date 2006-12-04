X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: David Miller <davem@davemloft.net>
Subject: [PATCH]: Pass -M to diff in request-pull
Date: Sun, 03 Dec 2006 23:17:00 -0800 (PST)
Message-ID: <20061203.231700.55509531.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 4 Dec 2006 07:17:17 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33168>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr84e-0007GW-9B for gcvg-git@gmane.org; Mon, 04 Dec
 2006 08:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758916AbWLDHRJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 02:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758915AbWLDHRJ
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 02:17:09 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net
 ([74.93.104.97]:18614 "EHLO sunset.davemloft.net") by vger.kernel.org with
 ESMTP id S1758916AbWLDHRG (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec
 2006 02:17:06 -0500
Received: from localhost (localhost [127.0.0.1]) by sunset.davemloft.net
 (Postfix) with ESMTP id D758BAE46D0; Sun,  3 Dec 2006 23:17:00 -0800 (PST)
To: junkio@cox.net
Sender: git-owner@vger.kernel.org


Linus recommended this, otherwise any renames cause the
diffstate output to be rediculious in some circumstances :)

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 4319e35..4eacc3a 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -30,4 +30,4 @@ echo "  $url"
 echo
 
 git log  $baserev..$headrev | git-shortlog ;
-git diff --stat --summary $baserev..$headrev
