From: Marcel Koeppen <git-dev@marzelpan.de>
Subject: [PATCH] Fix sed syntax in t7502-commit for OSX
Date: Thu, 15 May 2008 04:19:08 +0200
Message-ID: <1210817948-72280-1-git-send-email-git-dev@marzelpan.de>
Cc: git@vger.kernel.org, sbejar@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 15 04:25:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwTA9-000465-Sc
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 04:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbYEOCYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 22:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbYEOCYy
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 22:24:54 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:45124 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbYEOCYx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 22:24:53 -0400
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 May 2008 22:24:53 EDT
Received: from [80.145.207.239] (helo=localhost.localdomain)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <git-dev@marzelpan.de>)
	id 1JwT3l-0004D5-CU; Thu, 15 May 2008 04:19:09 +0200
X-Mailer: git-send-email 1.5.5.1.215.g64c0d
X-Df-Sender: 893553
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82168>

The OSX version of sed interprets the command as argument to the -i option.

Signed-off-by: Marcel Koeppen <git-dev@marzelpan.de>
---
 t/t7502-commit.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 018060c..9a43104 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -166,7 +166,7 @@ test_expect_success 'author different from committer' '
 	test_cmp expect actual
 '
 
-sed -i '$d' expect
+sed -i -e '$d' expect
 echo "# Committer:
 #" >> expect
 unset GIT_COMMITTER_EMAIL
-- 
1.5.5.1.215.g64c0d
