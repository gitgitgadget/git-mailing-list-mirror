From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 1/3] t4034-diff-words: add a test for word diff without context
Date: Wed, 28 Oct 2009 13:24:30 +0100
Message-ID: <1256732672-11817-2-git-send-email-markus.heidelberg@web.de>
References: <1256732672-11817-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 13:26:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N37bi-00047W-MR
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 13:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbZJ1M0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 08:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbZJ1M0H
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 08:26:07 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:60165 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbZJ1M0G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 08:26:06 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id A17E3133B7A71;
	Wed, 28 Oct 2009 13:25:12 +0100 (CET)
Received: from [89.59.65.242] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1N37aQ-0002WH-01; Wed, 28 Oct 2009 13:25:10 +0100
X-Mailer: git-send-email 1.6.5.2.86.g61663
In-Reply-To: <1256732672-11817-1-git-send-email-markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/e2IBDcFJ/FExdlE2jRJa9QY2im/PJ95YO1ZSs
	SlqGYKBgixhugIP96Z/BPu28XSpbVF5sPzuEQWuS5gOhe+kg5n
	5X5XUW+yzadO5LzAeUTQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131460>


Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 t/t4034-diff-words.sh |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 4508eff..82240cf 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -68,6 +68,26 @@ cat > expect <<\EOF
 <WHITE>index 330b04f..5ed8eff 100644<RESET>
 <WHITE>--- a/pre<RESET>
 <WHITE>+++ b/post<RESET>
+<BROWN>@@ -1 +1 @@<RESET>
+<RED>h(4)<RESET><GREEN>h(4),hh[44]<RESET>
+<BROWN>@@ -3,0 +4,4 @@ a = b + c<RESET>
+
+<GREEN>aa = a<RESET>
+
+<GREEN>aeff = aeff * ( aaa )<RESET>
+EOF
+
+test_expect_failure 'word diff without context' '
+
+	word_diff --color-words --unified=0
+
+'
+
+cat > expect <<\EOF
+<WHITE>diff --git a/pre b/post<RESET>
+<WHITE>index 330b04f..5ed8eff 100644<RESET>
+<WHITE>--- a/pre<RESET>
+<WHITE>+++ b/post<RESET>
 <BROWN>@@ -1,3 +1,7 @@<RESET>
 h(4),<GREEN>hh<RESET>[44]
 <RESET>
-- 
1.6.5.2.86.g61663
