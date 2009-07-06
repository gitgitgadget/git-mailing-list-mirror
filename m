From: Nick Woolley <nick@noodlefactory.co.uk>
Subject: [PATCH 2/2] Avoid generating a warning if $fullname{$file} is undefined
Date: Mon, 06 Jul 2009 14:33:45 +0100
Organization: Noodle Factory Ltd
Message-ID: <4A51FD39.4080402@noodlefactory.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 16:12:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNova-0001UO-Hp
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 16:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbZGFOMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 10:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754275AbZGFOMG
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 10:12:06 -0400
Received: from udon.noodlefactory.co.uk ([80.68.88.167]:57360 "EHLO
	udon.noodlefactory.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639AbZGFOME (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 10:12:04 -0400
Received: from 87-194-154-6.bethere.co.uk ([87.194.154.6] helo=[192.168.0.102])
	by udon.noodlefactory.co.uk with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nick@noodlefactory.co.uk>)
	id 1MNoKD-0006d5-58
	for git@vger.kernel.org; Mon, 06 Jul 2009 14:33:41 +0100
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122789>

Signed-off-by: Nick Woolley <git.wu-lee@noodlefactory.co.uk>
---
 git-cvsexportcommit.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index d509468..59b6722 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -259,7 +259,8 @@ if (@canstatusfiles) {
 	    if $file =~ /^no file /
 		&& $status eq 'Up-to-date';

-	$cvsstat{$fullname{$file}} = $status;
+	$cvsstat{$fullname{$file}} = $status
+	    if defined $fullname{$file};
       }
     }
 }
-- 
1.6.3.3
