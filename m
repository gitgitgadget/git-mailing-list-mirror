From: Thien-Thi Nguyen <ttn@gnuvola.org>
Subject: [patch] Insulate cvsimport test from CVSREAD=1
Date: Sat, 15 Mar 2008 09:57:33 +0100
Message-ID: <87lk4kl5z6.fsf@ambire.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 10:35:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaSnG-0000jU-03
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 10:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbYCOJeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 05:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbYCOJeU
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 05:34:20 -0400
Received: from [151.61.142.123] ([151.61.142.123]:58141 "EHLO
	ambire.localdomain" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751259AbYCOJeT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 05:34:19 -0400
X-Greylist: delayed 2063 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Mar 2008 05:34:19 EDT
Received: from ttn by ambire.localdomain with local (Exim 4.63)
	(envelope-from <ttn@gnuvola.org>)
	id 1JaSCr-00080k-8R
	for git@vger.kernel.org; Sat, 15 Mar 2008 09:57:33 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77316>

This small patch allows "make test" to finish successfully,
at least according to Git 1.5.4.4.

thi

________________________________________________________
commit 7b25916f06c80cd5fa889840195dcf8efd1bee66
Author: Thien-Thi Nguyen <ttn@gnuvola.org>
Date:   Sat Mar 15 09:52:12 2008 +0100

    Insulate cvsimport test from CVSREAD=1
    
    * t/t9600-cvsimport.sh: Unset env var CVSREAD.
    
    Signed-off-by: Thien-Thi Nguyen <ttn@gnuvola.org>

diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 7706430..fdbe474 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -28,6 +28,8 @@ esac
 
 CVSROOT=$(pwd)/cvsroot
 export CVSROOT
+# prevent cvs from making files read-only
+unset CVSREAD
 # for clean cvsps cache
 HOME=$(pwd)
 export HOME
