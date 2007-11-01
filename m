From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Do no colorify test output if stdout is not a terminal
Date: Thu, 1 Nov 2007 15:01:58 +0100
Message-ID: <20071101140158.GA14475@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 15:02:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inaci-0001kH-HS
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 15:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756701AbXKAOCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 10:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753529AbXKAOCD
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 10:02:03 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:46946 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756680AbXKAOCB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 10:02:01 -0400
Received: from tigra.home (Fc985.f.strato-dslnet.de [195.4.201.133])
	by post.webmailer.de (mrclete mo56) (RZmta 14.0)
	with ESMTP id 501c34jA1B42hP ; Thu, 1 Nov 2007 15:01:59 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E57C1277AE;
	Thu,  1 Nov 2007 15:01:58 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 4834256D22; Thu,  1 Nov 2007 15:01:58 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzATv+k0=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62961>

like when the output is redirected into a file in a cron job.
---
 t/test-lib.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 714de6e..603a8cd 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -60,6 +60,7 @@ esac
 # . ./test-lib.sh
 
 [ "x$TERM" != "xdumb" ] &&
+	[ -t 1 ] &&
 	tput bold >/dev/null 2>&1 &&
 	tput setaf 1 >/dev/null 2>&1 &&
 	tput sgr0 >/dev/null 2>&1 &&
-- 
1.5.3.4.549.g2789
