From: Sean <seanlkml@sympatico.ca>
Subject: [PATCH] Fix interactive rebase to preserve author email address
Date: Wed, 19 Dec 2007 16:34:27 -0500
Message-ID: <BAYC1-PASMTP022BE21217030117EF2156AE5C0@CEZ.ICE>
References: <1197997575-13292-1-git-send-email-hskinnemoen@atmel.com>
	<1197997575-13292-2-git-send-email-hskinnemoen@atmel.com>
	<1197997575-13292-3-git-send-email-hskinnemoen@atmel.com>
	<1197997575-13292-4-git-send-email-hskinnemoen@atmel.com>
	<1197997575-13292-5-git-send-email-hskinnemoen@atmel.com>
	<20071218181019.2af46418@dhcp-252-066.norway.atmel.com>
	<alpine.LFD.0.9999.0712181318300.27475@localhost.localdomain>
	<20071219124008.4945e592@dhcp-252-066.norway.atmel.com>
	<20071219150734.50b1f847@dhcp-252-066.norway.atmel.com>
	<BAYC1-PASMTP13613FE244FF93DC2BF613AE5C0@CEZ.ICE>
	<20071219220223.7c5b3887@siona>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 22:35:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J56Z2-00080u-Rq
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 22:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbXLSVea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 16:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752393AbXLSVea
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 16:34:30 -0500
Received: from bay0-omc2-s15.bay0.hotmail.com ([65.54.246.151]:65015 "EHLO
	bay0-omc2-s15.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750936AbXLSVe3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 16:34:29 -0500
Received: from BAYC1-PASMTP02 ([65.54.191.162]) by bay0-omc2-s15.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 19 Dec 2007 13:34:29 -0800
X-Originating-IP: [74.15.76.104]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.15.76.104]) by BAYC1-PASMTP02.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Wed, 19 Dec 2007 13:34:28 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with smtp (Exim 4.43)
	id 1J56YX-0006q7-7Z; Wed, 19 Dec 2007 16:34:21 -0500
In-Reply-To: <20071219220223.7c5b3887@siona>
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.1; i686-pc-linux-gnu)
X-OriginalArrivalTime: 19 Dec 2007 21:34:29.0153 (UTC) FILETIME=[EF843910:01C84286]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68941>


Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
---
 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


This simple typo fix should hopefully make it work for you Haavard.

Cheers,
Sean


diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index cd7e43f..7153ac7 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -371,7 +371,7 @@ do
 		. "$DOTEST"/author-script && {
 			test ! -f "$DOTEST"/amend || git reset --soft HEAD^
 		} &&
-		export GIT_AUTHOR_NAME GIT_AUTHOR_NAME GIT_AUTHOR_DATE &&
+		export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
 		git commit -F "$DOTEST"/message -e
 
 		require_clean_work_tree
-- 
1.5.4.rc0.73.gce85b
