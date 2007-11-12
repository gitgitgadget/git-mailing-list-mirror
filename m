From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] git-quiltimport.sh fix --patches handling
Date: Mon, 12 Nov 2007 12:07:40 +0000
Message-ID: <20071112120739.GH301@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 13:09:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrY5m-0005ln-GG
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 13:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758278AbXKLMIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 07:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758257AbXKLMIW
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 07:08:22 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:1717 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758242AbXKLMIV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 07:08:21 -0500
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1IrY4z-0006JU-HM; Mon, 12 Nov 2007 12:07:49 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64607>

When converting git-quiltimport.sh to the new git-rev-part --parseopt
system, the handling of --patches was broken.  We inadvertantly always
attempt to use '--patches' as the value.

This was introduced in the following commit:

    commit e01fbf1a8f185bf6722e828286862a4122269ef7
    Author: Pierre Habouzit <madcoder@debian.org>
    Date:   Sun Nov 4 11:31:01 2007 +0100

        Migrate git-quiltimport.sh to use git-rev-parse --parseopt

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 git-quiltimport.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 56c9569..6b0c4d2 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -23,8 +23,8 @@ do
 		dry_run=1
 		;;
 	--patches)
-		QUILT_PATCHES="$1"
 		shift
+		QUILT_PATCHES="$1"
 		;;
 	--)
 		shift
