From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 1/6] Remove return undef from validate_patch
Date: Wed, 29 Apr 2009 09:12:18 -0400
Message-ID: <1241010743-7020-2-git-send-email-wfp5p@virginia.edu>
References: <1241010743-7020-1-git-send-email-wfp5p@virginia.edu>
Cc: gitster@pobox.com, Bill Pemberton <wfp5p@virginia.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 15:16:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz9eb-0003wt-3H
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 15:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758656AbZD2NMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 09:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754173AbZD2NM2
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 09:12:28 -0400
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:37681 "EHLO
	viridian.itc.Virginia.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760190AbZD2NMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 09:12:25 -0400
Received: by viridian.itc.Virginia.EDU (Postfix, from userid 1249)
	id C92695702F; Wed, 29 Apr 2009 09:12:23 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <1241010743-7020-1-git-send-email-wfp5p@virginia.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117884>

Returning undef is rarely the correct way to return a failure.
Replace it with return 0

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index cccbf45..4f62c59 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1182,7 +1182,7 @@ sub validate_patch {
 			return "$.: patch contains a line longer than 998 characters";
 		}
 	}
-	return undef;
+	return 0;
 }
 
 sub file_has_nonascii {
-- 
1.6.0.6
